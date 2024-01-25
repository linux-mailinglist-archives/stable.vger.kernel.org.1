Return-Path: <stable+bounces-15741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F0583B5F1
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F974B23B12
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB885387;
	Thu, 25 Jan 2024 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsLEkPQ0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5672193
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141781; cv=none; b=GeSeczqJIIzWgsYZTK08pLFgNZlFxafDErUnn0nyRxosRC2bljXo6BY+hhpDdckMjiMY9H+gG/2QAr6zN3XW24Uz2v+2StQ036CPTgFhe/5Chq2YteXhTUNtuTBFY0P83Xahyy56l+0A+fBbu+OXBWdiwklMcSr4kRegG/GQVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141781; c=relaxed/simple;
	bh=/WO5dDIcSw2WYExRHKwhBp4d7kcl0j6p04cFS/iaPJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tn130bb1zZrZwz+doyaDVt5d4Wly2ct+sO1nz8Hn8Dl6q/OutQBifAR2U7CATLoQo9VKC1XmVSo676GxKS3IN8fbb9ef+p31IIiIjsxsxRkuKmORqIYUgtlSq1fMMYNBVGGBbbrYkho+U/nbck08Wc+h7o5m2HAnQwuwOfY3z0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsLEkPQ0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a310f4b3597so134201466b.3
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141778; x=1706746578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHZ3pdoRkIbUdtPnK3jdLYtVM30hkWQ83vcqUNwSDWk=;
        b=gsLEkPQ09H8+2yAd+LNspRjUEWSFDy/hXcDyk/qjqFuMBEk6mSOItKI5O4IvEC0P+3
         B9UyIuS3K0yJr+E/tD7BJ62q7/nDyYgBaaGv6Z78Vs+OLiLGFOjebHEEiK9YqILOU1pl
         DELrOsbvh//6Ds+SO/P5k0ooOQ9UgmwDx1ZPAHkkJq1uYTBl7gfu+AuFMEVZxL6Nm7mU
         7SyUrbNhb4Ix9QQM2lT6YWYCtNy3ma4Gk213tmzt6eOxq5O8/jvDE7s2nqGxNdHwoz5d
         M+i3+Zva3yXORu8IGzJjZEBSwRUUDKBTWYCTQZpFzPoCI7QI341Yi1osvxY9luqD6hDM
         Cw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141778; x=1706746578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHZ3pdoRkIbUdtPnK3jdLYtVM30hkWQ83vcqUNwSDWk=;
        b=p34ZrRsBwj1cIJuGs8HO6mRkl7bAHx5JvsKr8H0GGFKoyEI3ut79ZX7j+u75ihgqTy
         Anfd+dnP4l67kj32PAZgjmmT9kBQHW16MIVvuU/ZUYQc3ie8bZ5A+lt0C7L+dXRftzPT
         2eJT/bTFnNIiZo6oJ//cNwPVvJvwWekyllonQ7fm3Inigq9xlwohd247yn8+X0oTNuMj
         6Wkx4FyEosu/y8Sw1OkdbSnfvVvXwx4gTeZfzF0tKxUCsY7eVFG3FRez9kltz+/lQLAb
         GuVsoXPm3fTdxkFEY9m8F3S7IcCRB7/bOhvueUbZDaSd2SLdgxbfD2gonLZgkdmZwm/Q
         C+oQ==
X-Gm-Message-State: AOJu0Yy4vsbbTtc8wOyhmBz4lnvkecKLUUdu4P5JO2Bce2dXClK6O9uQ
	cQjXoYd+9OQMd1mEppMoSG8C9QggX6DB8ed8Bus39iQFial4svg7oPwW7XSy
X-Google-Smtp-Source: AGHT+IF4hgBlgAxF2NFL0g5P4DfiKvmMlYUElH3oJSGJRwOkE4G2SSHhLQ1FU31j18b60jaNHifBRw==
X-Received: by 2002:a17:906:1284:b0:a2f:d73d:e99d with SMTP id k4-20020a170906128400b00a2fd73de99dmr85104ejb.18.1706141777804;
        Wed, 24 Jan 2024 16:16:17 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:17 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: stable@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	mykolal@fb.com,
	gregkh@linuxfoundation.org,
	mat.gienieczko@tum.de,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.6.y 01/17] bpf: move explored_state() closer to the beginning of verifier.c
Date: Thu, 25 Jan 2024 02:15:38 +0200
Message-ID: <20240125001554.25287-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125001554.25287-1-eddyz87@gmail.com>
References: <20240125001554.25287-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 3c4e420cb653 ]

Subsequent patches would make use of explored_state() function.
Move it up to avoid adding unnecessary prototype.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231024000917.12153-2-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 824531d4c262..ff4fc5cccd00 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1778,6 +1778,19 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	return 0;
 }
 
+static u32 state_htab_size(struct bpf_verifier_env *env)
+{
+	return env->prog->len;
+}
+
+static struct bpf_verifier_state_list **explored_state(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_verifier_state *cur = env->cur_state;
+	struct bpf_func_state *state = cur->frame[cur->curframe];
+
+	return &env->explored_states[(idx ^ state->callsite) % state_htab_size(env)];
+}
+
 static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
 	while (st) {
@@ -14710,21 +14723,6 @@ enum {
 	BRANCH = 2,
 };
 
-static u32 state_htab_size(struct bpf_verifier_env *env)
-{
-	return env->prog->len;
-}
-
-static struct bpf_verifier_state_list **explored_state(
-					struct bpf_verifier_env *env,
-					int idx)
-{
-	struct bpf_verifier_state *cur = env->cur_state;
-	struct bpf_func_state *state = cur->frame[cur->curframe];
-
-	return &env->explored_states[(idx ^ state->callsite) % state_htab_size(env)];
-}
-
 static void mark_prune_point(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].prune_point = true;
-- 
2.43.0



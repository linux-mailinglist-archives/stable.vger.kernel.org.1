Return-Path: <stable+bounces-15742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C264F83B5F0
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A418289189
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7050629;
	Thu, 25 Jan 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF/u+Jo9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E838C
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141783; cv=none; b=K8qo569PdfrZdLLk/wNq+kO+iiFXo6+2OF+GasJpfKG5huTuj/1NUL62IPYG83VHNBjFBlsUXA517sPIGhK3UIFtoHGzg2V3YJCzivN1RV57ocPDsA/3jOMPP/LQRTXnq3/MjJKDVJesEgTGjY+taNzNGSLDFIc8eYVdWOxCqD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141783; c=relaxed/simple;
	bh=Iuqm2kD4QMX6DHCZUOE6v4elQg1s2jjIKQ7RG/loiZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG7iceUeHsbXGV+1GuN1CaItM+2GgDxNfhZvC7wPCpIl1uhGgZf8GIHVb5elEGHCUnK/7byHnEweQNXl6Qir1EBvjd3CRI0WzS3ItawuHN1kGIeNECQuj2uvqtLZlcIVFY5jq92UEAmfv66W5KwVGbft1WFFg8UUnfLVW4QkplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF/u+Jo9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so7671989e87.0
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141780; x=1706746580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/2XG8xO7sOWi86QX1pBw1Mh53fPo+cvCC1okPp/OKw=;
        b=LF/u+Jo9JiEfkv4WYu4+MrwqgbK0+KRVI1iSsYrWk4huUcjuE8Bw+WpbM+sASM2YF9
         rKj+AD3zx6gdJqY/aKEbU1n52k8PXcDU96sC/xXpwB/3+W1Tt/YJppm2kp+8Iij24rwP
         uOSiMwZNv7ljDQN4FcgxhDDlalaiUq1Z5paC73H26M16vLQyp+/E/9UP3Da19zKzXT9n
         CdMmiByAxhHAPRBaq3hCn1LEUGvNOQz8GOUIIVMfnqlGZJ3h7KFIEp+xRtzj0mai4w25
         26I3RIT5d92dmqagGvzOLTmCKGJeWqgC25LhOTROGiOUB73o/3zEM0jpkkGh+5YL8FLS
         8jEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141780; x=1706746580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/2XG8xO7sOWi86QX1pBw1Mh53fPo+cvCC1okPp/OKw=;
        b=VxMgt7em3mFjvQlR3fOYUPvZsQyHBnkMQZ0LgTzmt79B8ry/di4E+REMmmwUcCQxQD
         Vsx35Neiw52zE0L+XrFn3onTBbGcDvVvh2nQZYWT3zKAP4mQ/PQxG0vwu2Sox0nTrJuE
         mw8T6AJK4ThOc0Y0ql416fImcxEh/M6SGo19+HKbaWh7/r519yrZi1HpRIc3IzYQo7ju
         8mwlftqZ+YbfAZZZZZT+OQMkqVYi37CAfgEb0T+uiARwqu8XnzkJIHkVXlB6mo4DQxsd
         oqG7qL/EDIF9Eb/nvUv2+4lV1bbzvvIc+Ig2hP2Mq1RG6j6sNTOappMvvvucGgyLJI6s
         2ikQ==
X-Gm-Message-State: AOJu0Yxd6vua592trCb40nzM48q+dnfbLx7tAIjo3w86vXUi0X+DwysL
	b3YHr1LKEmkDBlBtZfTMlZRS7HKEhbFnSzPQlJYlYblvU8SFcmf1RZ4olB6K
X-Google-Smtp-Source: AGHT+IHV9fiki3GJOfQjKDNvjkO5Rel/2Pke3xAZJVUlHD/FQSrirESpFb/bgeMvVtltz4bc+m73UA==
X-Received: by 2002:a19:674b:0:b0:50e:b2f0:3dbb with SMTP id e11-20020a19674b000000b0050eb2f03dbbmr24040lfj.79.1706141779369;
        Wed, 24 Jan 2024 16:16:19 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:18 -0800 (PST)
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
Subject: [PATCH 6.6.y 02/17] bpf: extract same_callsites() as utility function
Date: Thu, 25 Jan 2024 02:15:39 +0200
Message-ID: <20240125001554.25287-3-eddyz87@gmail.com>
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

[ Upstream commit 4c97259abc9b ]

Extract same_callsites() from clean_live_states() as a utility function.
This function would be used by the next patch in the set.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231024000917.12153-3-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff4fc5cccd00..499a6ae515b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1791,6 +1791,20 @@ static struct bpf_verifier_state_list **explored_state(struct bpf_verifier_env *
 	return &env->explored_states[(idx ^ state->callsite) % state_htab_size(env)];
 }
 
+static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_state *b)
+{
+	int fr;
+
+	if (a->curframe != b->curframe)
+		return false;
+
+	for (fr = a->curframe; fr >= 0; fr--)
+		if (a->frame[fr]->callsite != b->frame[fr]->callsite)
+			return false;
+
+	return true;
+}
+
 static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
 	while (st) {
@@ -15529,18 +15543,14 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 			      struct bpf_verifier_state *cur)
 {
 	struct bpf_verifier_state_list *sl;
-	int i;
 
 	sl = *explored_state(env, insn);
 	while (sl) {
 		if (sl->state.branches)
 			goto next;
 		if (sl->state.insn_idx != insn ||
-		    sl->state.curframe != cur->curframe)
+		    !same_callsites(&sl->state, cur))
 			goto next;
-		for (i = 0; i <= cur->curframe; i++)
-			if (sl->state.frame[i]->callsite != cur->frame[i]->callsite)
-				goto next;
 		clean_verifier_state(env, &sl->state);
 next:
 		sl = sl->next;
-- 
2.43.0



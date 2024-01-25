Return-Path: <stable+bounces-15750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E3483B5F9
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DAC289315
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261057FB;
	Thu, 25 Jan 2024 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDqhOjv8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A8A387
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141794; cv=none; b=sqSwlK+NPKxVvIZCwklD7lQoakas1jqOirLR04TRvCDs6d5mcrdzpzaAooOSuHvT05AOieTbcq7fm9uuRUhctYiin3izQ6rGBqM9ILkAtcEg5LJbmjZP7drj5oKBOIg3OkrCtZhuvj1BOGF7MCyf2wbd70AT0f1+iC8Tr/ZDMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141794; c=relaxed/simple;
	bh=pWfeHpKIA4QYvTCVxWk+ZXqa1cFPiIk3U12jNKwH1PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETnh6EnI2o6ck7t8dmkkkiio6s3ApeDopuMQETlIMP3VHhZSBOoFK5CJJYqwYunhzYnLHKMRfmpR6iSncpAHiXeE547z8oVlBGnbamtZAu8nTbmUzZ9lvlznagqNJN+YrpF6+puAoBAelW6x8mhYb7XGmpTcvpZbhlioNZZhk4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDqhOjv8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a87dfc3b5so5289751a12.3
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141791; x=1706746591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G4UPOG9YJf+SHfFrGuQZVk4WMQaBTGQJTi7ks5s1S0=;
        b=dDqhOjv8yckPt1Hi7ch7Cvlmv0XHH5Q+9I6Ag423+sOi1VT44B/ccAV4rUrDf2d42Z
         CsH8JKZKlUxDH/CZaZmZ4H0QGWa/8tTPOlJzQEqmAUXoPCyle/6Hn5Ygt/ZUarB3ttQQ
         DmSRFk9yeZ20TDAhnaUf9cLLJq8yhVIjcuik86nVM27MN5uFlmxZzC9uTHentJKWEHD+
         b/8+KnK19lapyaIjHrAIoVPtddVqiBaq4fvUqG82BjHgYq0GfgjsEv2kpBbeMTyVP3YI
         At4+//WXncVvbhQCAVy6le+RKJxyNMVZ1hGWvlaw4yq8lEH0U6tTAoqyR9/WplPj+I+p
         3MTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141791; x=1706746591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7G4UPOG9YJf+SHfFrGuQZVk4WMQaBTGQJTi7ks5s1S0=;
        b=YPrv5wodaAt/18DXcKcnbK6GlOVu+Y7ey92KfV0ATmFmDBTyIpG2S1m3nk1o9y9MO/
         IeJ7oEoJiQApcPRJ1BGnuhQn2QvsWt8bM+l9N2u+ZRtS/A46CQpCFypi7yLD53agzcEb
         ZuOzbiEX37iyi7wE0rLpeGn7qFDbxGNRf/Zxgh7quAl5BK5yV90xEDHqTKqfaptGh9zz
         ThB10/S5DMc/fF08cFWhDgywZGbyZtkDo715EAtGeHnSOiAG9ZPx1ctuDnjdC0zFd7mD
         x5b7/GiVB/o9+fbCJQfBH9lv5XTBYle0aTHUu++kobv6HbGcmnpDGMZdRxLtm7c54D6p
         BZ1Q==
X-Gm-Message-State: AOJu0YwSWCbjR14xSRrR1g1g2+EyZSqHtP0Th343nUsDJcRa3RGlW3vG
	pgALX7u95EgII8W5eiU6zvboU01t8fR3bMtsjSzIb445v3hSjDr2m+i52iHP
X-Google-Smtp-Source: AGHT+IHKvyNjmqqVSf14MDLqCEsbbVbHFznXZ71gNNR4XFAdORfOrjV++W5BByQCDCSLkUFO3jtjog==
X-Received: by 2002:a17:906:a445:b0:a31:6398:ade7 with SMTP id cb5-20020a170906a44500b00a316398ade7mr49807ejb.138.1706141791031;
        Wed, 24 Jan 2024 16:16:31 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:30 -0800 (PST)
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
Subject: [PATCH 6.6.y 10/17] bpf: extract __check_reg_arg() utility function
Date: Thu, 25 Jan 2024 02:15:47 +0200
Message-ID: <20240125001554.25287-11-eddyz87@gmail.com>
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

[ Upstream commit 683b96f9606a ]

Split check_reg_arg() into two utility functions:
- check_reg_arg() operating on registers from current verifier state;
- __check_reg_arg() operating on a specific set of registers passed as
  a parameter;

The __check_reg_arg() function would be used by a follow-up change for
callbacks handling.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231121020701.26440-5-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e306a6fd8fbd..dc03927a8540 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3313,13 +3313,11 @@ static void mark_insn_zext(struct bpf_verifier_env *env,
 	reg->subreg_def = DEF_NOT_SUBREG;
 }
 
-static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
-			 enum reg_arg_type t)
+static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *regs, u32 regno,
+			   enum reg_arg_type t)
 {
-	struct bpf_verifier_state *vstate = env->cur_state;
-	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_insn *insn = env->prog->insnsi + env->insn_idx;
-	struct bpf_reg_state *reg, *regs = state->regs;
+	struct bpf_reg_state *reg;
 	bool rw64;
 
 	if (regno >= MAX_BPF_REG) {
@@ -3360,6 +3358,15 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 	return 0;
 }
 
+static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
+			 enum reg_arg_type t)
+{
+	struct bpf_verifier_state *vstate = env->cur_state;
+	struct bpf_func_state *state = vstate->frame[vstate->curframe];
+
+	return __check_reg_arg(env, state->regs, regno, t);
+}
+
 static void mark_jmp_point(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].jmp_point = true;
@@ -9166,7 +9173,7 @@ static void clear_caller_saved_regs(struct bpf_verifier_env *env,
 	/* after the call registers r0 - r5 were scratched */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
-		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+		__check_reg_arg(env, regs, caller_saved[i], DST_OP_NO_MARK);
 	}
 }
 
-- 
2.43.0



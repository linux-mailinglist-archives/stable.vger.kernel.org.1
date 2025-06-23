Return-Path: <stable+bounces-155355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2EDAE3EA4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093C63B7904
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D602231A23;
	Mon, 23 Jun 2025 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K3Ymc0FL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492624169D
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679675; cv=none; b=juCw/a67zW8nimGWYdz3Xu9lkuX5ABhRQ6YSwEpCAoBCQRpE+ZCRkZ4GKiO58HJOB9WsxJ/riGlgKghlkf/J5rJzdHKhS79eVfR4AZ1glkdHHBnNfePihhrkvXriAE9dJQTCGHjODsSJGrfjolVc5ej/pWgKFuGirBI8D7k+gxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679675; c=relaxed/simple;
	bh=dv4DOQ2sNt9iYHoPDUBue4NBZh86sHYAh+V/btyNKto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eKI/T/9Ov8LxZGjuveUizWWjXwyHJ7yB3VxpJwrteruvULeOI7qvvcY9xUxIgc7uNTUUvghUbUYIk5C+DyWYgIwZJBGu6nkQMwujWFbCR7OM8jaYoRDDIcQQn4UHHzsyrNztQUI3z8HolLwI8xNT7Mu1zXnR1gGCz+pLM+w9gic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K3Ymc0FL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748d982e92cso2528074b3a.1
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 04:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750679673; x=1751284473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDmGZtoIStHZ1GgW29TqUM63gTie9QnFp3IcquWGayI=;
        b=K3Ymc0FLJZystBzzM2HQgPGtqB4Ggr+v5B2DzXKva+rjHWQBDEAP16yQeSDx/xa0Ko
         M4OezD23HIBKjTNS+zLrTsom1bOmRyyxDSY1JBoGvfz1pEz2O2NdLnszbJ7UqCNxgI1z
         hLS8j10495aWEg/xrFch56DgUasQRMS1cucs0Z02fQVD2ArAMAPFFJs7kJGm+1RBltFd
         yYXteGfAInDGFgpH3mSIyvqkR4fryeKGSWm8QnWHMCZtycr1tCwL1MWZhDTaDnImjz61
         E8JnFxeaYvvhel9+Y88YcKGVKm4EBBAEflGrkGsR/7BuexHF3+1FBV7AO/0DCrQeN/iU
         sLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679673; x=1751284473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDmGZtoIStHZ1GgW29TqUM63gTie9QnFp3IcquWGayI=;
        b=TKZ3G1dUBff8NDFNYWAseFQKj+fOEnboTtclbEC0SvOQY4jPVteYuNoFokqxAYH0mN
         d9yF4ox1De7TRm6g3LqG+yDCrUn8FQwSWe4ZQho2+R4wYtAZ0DgizgWxzFRM67cGLwTv
         oHb55IG89bkqWbISvBtT6VanwAMsmZiu5Z99fKAJUTuO8vOOaJJ/fDWEN3bPvb4A2f6p
         lXhww/1l5L7bEGapc83RWYh/KIZxibq+suVGvrSf0TuFPseUbZrSPDcK2uNsc84TJbJB
         OvvNk/xY4v7gLBzI+44DrkiWqdRFC6xjzdqeppakUcWjlv4TEp9hL7LqEvZVR24kcmRj
         pBlg==
X-Gm-Message-State: AOJu0Yxhb2QgbNZ6fgc8kRD6FYgMXvk47oH3QFEqrNISfMz9xKZi5ChC
	BSEX9VtkcxsHDgjh1Hn0NSTc9rR7RqMMlcBXaS9dr3dz6yFtkkxXek0XJXWkUl9JfA==
X-Gm-Gg: ASbGncsK10PHDnBBKo5X6ej05BylzIp0/7pIZRtil/So6tEDaSWG+OylZmcCevRo6RF
	twG7tcfnSHDUt8/Vpy96Rm7rVIvMpiVP/5oezS0AV+NiONk4DDnxw38jTHAFhk+zemusETmRqcO
	TpB9xjS0hWEXX/dmyUypKes1lElSKJ2IVOssrnxs9Wlt4lTKq7kLM1KYTrXuPnXO8M33j7cf/0H
	WtlMTTE8YSn3Qqr4aFiXWdIAGbAhhIWkIwTfnGI6PWbdj7fAUbn5XQ8t5aHzsXXvQBBH2hXBeBH
	HZnpcbJy55nDn6N89zjQhRWKSlw5jMk1RawnZ+hteFClHVDBDrbvmyAbiQrwelhahsT4HY+b6SB
	MFgz06VmbZj6ZbGteCK4KIk8FVFTggcM7
X-Google-Smtp-Source: AGHT+IF50lsgFXkiV1thDqK82G28r8NTToJ8xXhsTa8r0KL14+/J+Tp7lIQBbYcflW+T+dBP41MKXg==
X-Received: by 2002:a05:6a21:1f8d:b0:21a:eb6a:b84b with SMTP id adf61e73a8af0-22026de777fmr18877106637.30.1750679672871;
        Mon, 23 Jun 2025 04:54:32 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12427b7sm6597716a12.40.2025.06.23.04.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 04:54:32 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Luiz Capitulino <luizcap@amazon.com>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: [PATCH 4/4] Revert "bpf: allow precision tracking for programs with subprogs"
Date: Mon, 23 Jun 2025 19:54:03 +0800
Message-Id: <20250623115403.299-5-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623115403.299-1-ziqianlu@bytedance.com>
References: <20250623115403.299-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 2474ec58b96d8a028b046beabdf49f5475eefcf8.

The backport of bpf precision tracking related changes has caused bpf
verifier to panic while loading some certain bpf prog so revert them.

Link: https://lkml.kernel.org/r/20250605070921.GA3795@bytedance/
Reported-by: Wei Wei <weiwei.danny@bytedance.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/bpf/verifier.c | 35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ecd0d04ff8e61..7a8599355c5ed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1359,7 +1359,7 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 	reg->type = SCALAR_VALUE;
 	reg->var_off = tnum_unknown;
 	reg->frameno = 0;
-	reg->precise = !env->bpf_capable;
+	reg->precise = env->subprog_cnt > 1 || !env->bpf_capable;
 	__mark_reg_unbounded(reg);
 }
 
@@ -2102,42 +2102,12 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		return 0;
 	if (!reg_mask && !stack_mask)
 		return 0;
-
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
 		u32 history = st->jmp_history_cnt;
 
 		if (env->log.level & BPF_LOG_LEVEL)
 			verbose(env, "last_idx %d first_idx %d\n", last_idx, first_idx);
-
-		if (last_idx < 0) {
-			/* we are at the entry into subprog, which
-			 * is expected for global funcs, but only if
-			 * requested precise registers are R1-R5
-			 * (which are global func's input arguments)
-			 */
-			if (st->curframe == 0 &&
-			    st->frame[0]->subprogno > 0 &&
-			    st->frame[0]->callsite == BPF_MAIN_FUNC &&
-			    stack_mask == 0 && (reg_mask & ~0x3e) == 0) {
-				bitmap_from_u64(mask, reg_mask);
-				for_each_set_bit(i, mask, 32) {
-					reg = &st->frame[0]->regs[i];
-					if (reg->type != SCALAR_VALUE) {
-						reg_mask &= ~(1u << i);
-						continue;
-					}
-					reg->precise = true;
-				}
-				return 0;
-			}
-
-			verbose(env, "BUG backtracing func entry subprog %d reg_mask %x stack_mask %llx\n",
-				st->frame[0]->subprogno, reg_mask, stack_mask);
-			WARN_ONCE(1, "verifier backtracking bug");
-			return -EFAULT;
-		}
-
 		for (i = last_idx;;) {
 			if (skip_first) {
 				err = 0;
@@ -11896,9 +11866,6 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 			0 /* frameno */,
 			subprog);
 
-	state->first_insn_idx = env->subprog_info[subprog].start;
-	state->last_insn_idx = -1;
-
 	regs = state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
 		ret = btf_prepare_func_args(env, subprog, regs);
-- 
2.39.5



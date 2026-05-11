Return-Path: <stable+bounces-245282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCP2Ib4KAmqknQEAu9opvQ
	(envelope-from <stable+bounces-245282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:58:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F946512D44
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E383120210
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B83426ED4;
	Mon, 11 May 2026 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tim+BC4E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365B2425CFA
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516647; cv=none; b=THghDQD/LMRHRVjEVd+BZpN76tMvqacu+szWG0M+5M/m/sCm9f06YAiHwcTZL4HZTiJLlBWgxbtVKdq01C3YZEFJRip3WZMt4v+gMc81q9OBo+kgo/dnOVr+zIxVAhGpg4wSJc0fOTZGL43d5WIdD8ez7k9tSAWXq0CCOG5vooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516647; c=relaxed/simple;
	bh=T//RLLEKGrhZUcwo1eb1XUzoCEy4bYetBHS44ayWTBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhyOCdf1rSvkbXwzBw0m2BJWXfeQ7klNNhyqJgpvJ7/iBpaoZqu1B7POv0kbGDUTSWWJRyEIdTs0n3N3gZ8Q9gEeNM2+aDrgmAYJmdEiuIzyXOqOhG8mFfIErsT2j1Z21CJEf3RSeNc3Wmv+T7b/9snTzHAzbWQIpjvFMx0mAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tim+BC4E; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so53792035e9.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516644; x=1779121444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwspGHOvem5Tl8jx2BTD//u1PEqbJ8uDYA/oCHnG3q4=;
        b=Tim+BC4EquZQU1gKNtXHNwj0e9MeVB/HpWH0makRYNNvp2lCz7LGrOiW3xTFbr8hwr
         i66vlO4OS7DbA10omFuH8Bu+Pw4Xw8VKmVlKNaaaTl15uzN023YV7JIt3rd4xkypG9aZ
         IIZm0rdHFK6DL7y1tL6CJR0UAxNUqS2wTJ3iSFhgYGZFvOTgxwTJ/PLrqO0OOUWHk2Eb
         JcdXDU0/9pvxACFr127ka+IwEtB6cJFhBNuSeXza+Qvmb4yinC+ARqplox1PoFp7/Fku
         Njdw1h1/KA2W7OKXw8ks+bLMtye8+uxugMoYiZc6cx1FezpuzRFIsIRMKk4TbD0yl+hh
         5ARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516644; x=1779121444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwspGHOvem5Tl8jx2BTD//u1PEqbJ8uDYA/oCHnG3q4=;
        b=tMuxzOabpcab/EFK2K6vLa5s81NYZ7m/Fx6Rppt6HvE6NmR2eQcXGCPNUWOKZjTaG5
         kQeBeLueWvvS0WFaQeaGvkc4viV2NX3UopSJeeKopOLZnOL5n0cxyUI/fW6Lvg0s/10t
         8UNEe+EaNB/HcDXhCJTHohgaOp4uVdkG7r1H3Me4nhpCdTdeV64guHDW2+WBIbtA0HVE
         djnuF/7iEZ4A8/kO1JCXxLgCjxV/6p7ZV4esinRa9/EELS/wtP4kvR+uz/2ZrZ8C2z78
         7Hu+XLM3FflAuq3NGxtYoOqx/FcUL/zkFwPhTTHOci33fh7moCikSpVnA5s9hDU0adA3
         wTmA==
X-Gm-Message-State: AOJu0YxF6Hup3V3YXsbbEHDGE8W767ubDBW+f17qvan/T7OGes8hJyXG
	9ZJGuyv17TQ3xr4jD8oGYZ/HgnsCuSzjzunohDF9t8fWyXCcUnFF/+V6qrOuRwnX
X-Gm-Gg: Acq92OFyel9grnZUS6cCCVthRnCWB1691Ii1+473yf1EMHLNuUVohwv/sJLFLaeu+sc
	s9gAgQrYYm2+D5WwRkPz7F9NN3Yqf6IBulvfqYfm+zfebEEI+oa3/pGhpS4BuDGSmQhfCAcEzAk
	iqlQSXwBCi4icMTWsLU/UYkfg/WEIjOC0mBakBjWNrojzkfn7kG8gqwhIbfScOAOam9SnDg3aAx
	SojRm2OjU5/cEpsCMPAvfu+X5wi1yZDshZV2y98pfi3y3qZljDoXzy+l//1cwxUhvRQ5EQdYVjo
	/sadgd0i5ONbdiH25N1Ch+APrXP6++h9MwAM8b9mRpC0x2Jf34B6XD61vq9k9KEc4tz0ZqAm040
	WyMiM8ZZmFTsEs5UOZ+Lrm1Er/z0sykpBBI5n1hG6nZxfhMB0B0lklxCInvSYZWFJ9F/WNcz7Ej
	F9xkXu6cHNrlakjGedywkfINE8CP8zlshLCm0583dm6SqicgmLthZfjjeOO+FahE3q2S0isEq+O
	LhdpDilqs2M0BME8CKqhFVDdQ2ywL6YX9Pz+Ak5QgFuNXGeXjnfp4oHInAwWKZJFbJVbqFURftr
	GmBGSoxXEU9X8ytrhy0+srnvtO7qFcLdNMXOJJxXzQs=
X-Received: by 2002:a05:600c:8287:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48e706c0827mr161946925e9.11.1778516644402;
        Mon, 11 May 2026 09:24:04 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f76596008310132d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f765:9600:8310:132d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e5efe66sm158145e9.3.2026.05.11.09.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:24:03 -0700 (PDT)
Date: Mon, 11 May 2026 18:24:01 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Levi Zim <rsworktech@outlook.com>
Subject: [PATCH 6.6.y 04/10] selftests/bpf: validate STACK_ZERO is preserved
 on subreg spill
Message-ID: <ee7b83371ba51181ef7307e472c622468417f0c3.1778516196.git.paul.chaignon@gmail.com>
References: <cover.1778516196.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778516196.git.paul.chaignon@gmail.com>
X-Rspamd-Queue-Id: 0F946512D44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,epfl.ch,outlook.com];
	TAGGED_FROM(0.00)[bounces-245282-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Action: no action

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit b33ceb6a3d2ee07fdd836373383a6d4783581324 ]

Add tests validating that STACK_ZERO slots are preserved when slot is
partially overwritten with subregister spill.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231205184248.1502704-6-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 6115520154e3..d9dabae81176 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -4,6 +4,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include <../../../tools/include/linux/filter.h>
 
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
@@ -450,4 +451,43 @@ l0_%=:	r1 >>= 16;					\
 	: __clobber_all);
 }
 
+SEC("raw_tp")
+__log_level(2)
+__success
+__msg("fp-8=0m??mmmm")
+__msg("fp-16=00mm??mm")
+__msg("fp-24=00mm???m")
+__naked void spill_subregs_preserve_stack_zero(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+
+		/* 32-bit subreg spill with ZERO, MISC, and INVALID */
+		".8byte %[fp1_u8_st_zero];"   /* ZERO, LLVM-18+: *(u8 *)(r10 -1) = 0; */
+		"*(u8 *)(r10 -2) = r0;"       /* MISC */
+		/* fp-3 and fp-4 stay INVALID */
+		"*(u32 *)(r10 -8) = r0;"
+
+		/* 16-bit subreg spill with ZERO, MISC, and INVALID */
+		".8byte %[fp10_u16_st_zero];" /* ZERO, LLVM-18+: *(u16 *)(r10 -10) = 0; */
+		"*(u16 *)(r10 -12) = r0;"     /* MISC */
+		/* fp-13 and fp-14 stay INVALID */
+		"*(u16 *)(r10 -16) = r0;"
+
+		/* 8-bit subreg spill with ZERO, MISC, and INVALID */
+		".8byte %[fp18_u16_st_zero];" /* ZERO, LLVM-18+: *(u16 *)(r18 -10) = 0; */
+		"*(u16 *)(r10 -20) = r0;"     /* MISC */
+		/* fp-21, fp-22, and fp-23 stay INVALID */
+		"*(u8 *)(r10 -24) = r0;"
+
+		"r0 = 0;"
+		"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(fp1_u8_st_zero, BPF_ST_MEM(BPF_B, BPF_REG_FP, -1, 0)),
+	  __imm_insn(fp10_u16_st_zero, BPF_ST_MEM(BPF_H, BPF_REG_FP, -10, 0)),
+	  __imm_insn(fp18_u16_st_zero, BPF_ST_MEM(BPF_H, BPF_REG_FP, -18, 0))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0



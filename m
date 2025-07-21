Return-Path: <stable+bounces-163497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB4B0BF64
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 10:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B06D164A92
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 08:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC3528936F;
	Mon, 21 Jul 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g6Ox1ad4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780581F3B9E
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087550; cv=none; b=ig/I1YPUZGM1l/Z8HNs/H4cudzT3eFkly+ypJAueH1/vODo2zoiNanc5BfXfLFSNW9QuB9ACr920zw42BDPdQtthDWRWv8ewv/D+vhq/ue10lvMH/KAhW6WrHui9Z5KWglAYLZIxt/iYGhT0K59lJUoaDnd2DuOkHkeQwx3mqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087550; c=relaxed/simple;
	bh=+hty62VtLhcVODNKMj8j2y0zFMhV+F62r1hPfB3+hmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rt+iRBEgaMok3xP4lwnVI9pbsqQhY6hsKEXUW80KyEpGxI653dqn4dMC6YIvKs2vCUuXudVgE4EBr7M6hsOmIaipKeCAAqvyWxqUdD14/pMIfzmkXhYslRyehkwdhw21A4jXJ2izEwcfsNkZc9wUikLsexebNdbmKdNtgXtZY7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g6Ox1ad4; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so770793866b.1
        for <stable@vger.kernel.org>; Mon, 21 Jul 2025 01:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753087545; x=1753692345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxCBdWgxXCqS1feLe2pSXo59dqeJhgnNo9iHIHrDx5o=;
        b=g6Ox1ad4pQES5JQfH7NQoj/vGoywe4fWNliloDZmY2VUcMEzybMMu9WFuM1x6YQIEr
         2K194sCH1qkAS+uWoouou/TP7e1QMXPVX/EMkdi5bsOTO/UaIZR5cjsiV3WrUpccmdjF
         dHispJv8KijRJh6aZ8msN3LfqyuMaWM7DSOZw0MOwFBHTxaT1Z/APn/dOgYeHXOvVo5f
         NR//UW3E3ALlNoB0QEoPxYtyiOl7jLkOWn1DTpaeybWACDuPYDyXuDF+VljfBq33J74+
         hAP4SCOSCunm7AmvAghSO3RnxzOiDEX3v2ZRLqt/6S/GxXVXz4HCzZsaI6O/J7d7K8Zu
         Ax7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753087545; x=1753692345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxCBdWgxXCqS1feLe2pSXo59dqeJhgnNo9iHIHrDx5o=;
        b=kWtQht8ygtRFuxpdtNxoJdT6oTcW/97CWMNl8tfNmrbVbVIqSjMc/SU/UpDe59hF8m
         PMG0VkdTcuZuD5nIQr/FPRuIDkLEb9LdgQV47X5Qg4w10YKBxPpS4vLQQ0Fpaqv9MoDR
         an/vGTb12ONwgTN2zYzJ1YpClFkZipUfYTauhYjogFssuH1sKJvoCdTZmydG6OugJ51H
         H8fikI/EvGLabbWHMjkYlsicZsVGWp5wbYcz6IV3G1U4N4IOzvRXX4fT9Fvdjuf3TAXK
         3Vtb3W3zs3X3SusCEgB/iekZen/BSvZZRDmrPkUMzB1OW2v8Mj6fhmiI7O/h8WN/e9CH
         oKXQ==
X-Gm-Message-State: AOJu0YxcFw9Z1/jyzvadT/DF2zuhYcuqAd22O0iQ8A9fC4E4AXsBb+Du
	CzSfsw8wSqPBHR83jGRgCA2SOC+/5ZyOch0+ePfmLY2bzf3DwOI1BiVEANZiht1bRi8Yr3XGA8A
	T1ZMiRXa/7A==
X-Gm-Gg: ASbGnctxX07OISApO4hmG1C6PI1x5AVQhrfN8qw+HZIKp4P/kcPBlhnZKM6wo8l9bf2
	zywcwpXPKMAFXba7oRukKx6Ub5lR9AfM7ABWcDJnhAgR4YW0fkG7Y56BhVXf1qx056yAw19F4M8
	eyOKBr9c1p+jKmZzLOTHIgPE2dp2Y4nFvTaYvUYGW7PRv66mQj5FCJKein0ParWY9CHF3E66ozc
	tpI7LnuEmmEfSCdwZkiM3Tl7IWd51Zk8cf/kC4ENa5m5xm9V/EaEH4GCUbqmoF8sLq7NHpt/Klb
	EyuNx2N3GlZQwEOlqBGfGEyVyIOILqiRUc7VuAP84UFr1JWef/WyhnYhDztgYpq7DiKYPwfIGZY
	bv2fxwW3Rr78rGr9zIV44IgPmRIdrxdu3cZB+RH0lRwS9QzUuMaDf
X-Google-Smtp-Source: AGHT+IFMYMW9EdYbiRwYU3r0bfojOPzxvvPuZi3pf8eAWnMOAuB/8wQGiPbapqVyCm76WmHOGdmLXA==
X-Received: by 2002:a17:907:944f:b0:ae0:c441:d54b with SMTP id a640c23a62f3a-ae9cdd83544mr1821430666b.9.1753087545365;
        Mon, 21 Jul 2025 01:45:45 -0700 (PDT)
Received: from localhost (1-174-4-246.dynamic-ip.hinet.net. [1.174.4.246])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aec6c7d524asm637637666b.45.2025.07.21.01.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 01:45:45 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 1/1] selftests/bpf: Add tests with stack ptr register in conditional jmp
Date: Mon, 21 Jul 2025 16:45:29 +0800
Message-ID: <20250721084531.58557-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

Commit 5ffb537e416ee22dbfb3d552102e50da33fec7f6 upstream.

Add two tests:
  - one test has 'rX <op> r10' where rX is not r10, and
  - another test has 'rX <op> rY' where rX and rY are not r10
    but there is an early insn 'rX = r10'.

Without previous verifier change, both tests will fail.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250524041340.4046304-1-yonghong.song@linux.dev
[ shung-hsi.yu: contains additional hunks for kernel/bpf/verifier.c that
  should be part of the previous patch in the series, commit
  e2d2115e56c4 "bpf: Do not include stack ptr register in precision
  backtracking bookkeeping", which was incorporated since v6.12.37. ]
Link: https://lore.kernel.org/all/9b41f9f5-396f-47e0-9a12-46c52087df6c@linux.dev/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c                         |  7 ++-
 .../selftests/bpf/progs/verifier_precision.c  | 53 +++++++++++++++++++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f01477cecf39..531412c5103d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15480,6 +15480,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 		if (src_reg->type == PTR_TO_STACK)
 			insn_flags |= INSN_F_SRC_REG_STACK;
+		if (dst_reg->type == PTR_TO_STACK)
+			insn_flags |= INSN_F_DST_REG_STACK;
 	} else {
 		if (insn->src_reg != BPF_REG_0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -15489,10 +15491,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		memset(src_reg, 0, sizeof(*src_reg));
 		src_reg->type = SCALAR_VALUE;
 		__mark_reg_known(src_reg, insn->imm);
+
+		if (dst_reg->type == PTR_TO_STACK)
+			insn_flags |= INSN_F_DST_REG_STACK;
 	}
 
-	if (dst_reg->type == PTR_TO_STACK)
-		insn_flags |= INSN_F_DST_REG_STACK;
 	if (insn_flags) {
 		err = push_insn_history(env, this_branch, insn_flags, 0);
 		if (err)
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 6b564d4c0986..051d1962a4c7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -130,4 +130,57 @@ __naked int state_loop_first_last_equal(void)
 	);
 }
 
+__used __naked static void __bpf_cond_op_r10(void)
+{
+	asm volatile (
+	"r2 = 2314885393468386424 ll;"
+	"goto +0;"
+	"if r2 <= r10 goto +3;"
+	"if r1 >= -1835016 goto +0;"
+	"if r2 <= 8 goto +0;"
+	"if r3 <= 0 goto +0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("8: (bd) if r2 <= r10 goto pc+3")
+__msg("9: (35) if r1 >= 0xffe3fff8 goto pc+0")
+__msg("10: (b5) if r2 <= 0x8 goto pc+0")
+__msg("mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame1: regs=r2 stack= before 9: (35) if r1 >= 0xffe3fff8 goto pc+0")
+__msg("mark_precise: frame1: regs=r2 stack= before 8: (bd) if r2 <= r10 goto pc+3")
+__msg("mark_precise: frame1: regs=r2 stack= before 7: (05) goto pc+0")
+__naked void bpf_cond_op_r10(void)
+{
+	asm volatile (
+	"r3 = 0 ll;"
+	"call __bpf_cond_op_r10;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("3: (bf) r3 = r10")
+__msg("4: (bd) if r3 <= r2 goto pc+1")
+__msg("5: (b5) if r2 <= 0x8 goto pc+2")
+__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r2 stack= before 4: (bd) if r3 <= r2 goto pc+1")
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r3 = r10")
+__naked void bpf_cond_op_not_r10(void)
+{
+	asm volatile (
+	"r0 = 0;"
+	"r2 = 2314885393468386424 ll;"
+	"r3 = r10;"
+	"if r3 <= r2 goto +1;"
+	"if r2 <= 8 goto +2;"
+	"r0 = 2 ll;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.50.1



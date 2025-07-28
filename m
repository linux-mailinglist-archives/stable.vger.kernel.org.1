Return-Path: <stable+bounces-164886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EC8B135A6
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 09:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAFE1884E05
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 07:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAEB2116E0;
	Mon, 28 Jul 2025 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SbzQCJHA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452822222CB
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687229; cv=none; b=h0Z3R+NHl7OtsnipTVFGhF9T7cpZYlP1vkjKtmMMsTkJP6erGzGdxbn61rhLK2zVZrP1EIoAdG0im5md7Z7OI7aGqRM2hZJhYKlZ6iXf1fZj2/a8W2t+KgGHgR33UVSVWT81wdevi3BiNPFJX2J4XpbWp0rt27+c/LHCnNcTcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687229; c=relaxed/simple;
	bh=bcfV8PAfQKDzUOMvGhFS2O8IW/hFS55ufWFdAgCGYFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXgRFAn1AwrYjaQY4hzZ0pWeTLylu+txE09OkZV6RyUEvsAIJeCJWZtc+saYebsACMQVXzcAQLuD4pPPtSJcwcX11Fw8yqRnbi4ivCFJ/K37nBkudv36NxPhkrno702pfyb/yw2uwb706jpuwNkAVgidxY07P4iPnP8xWbkPmrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SbzQCJHA; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-45622a1829eso13295765e9.1
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 00:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753687225; x=1754292025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+UHVrcHsMB5Vp78BQj/kg0XXYLo73mbigKeMbyFXJqY=;
        b=SbzQCJHAOjKokwYEK7JvddeCQlAQB+GLOOY02cuZEcY6pwFg1CMkSk/jP5hGh+J9+Q
         JAV1WZTwrIboLpfC9xiuBxkQFWU4JeI6jsWJCZUM/1rmfkFaFba8CNDKS6cirMFtkwkF
         4Io0HKBMvUs5n6+bso9uCXUbV3IOITIPdxKb9vkQbk+H4bX81SO2ol3WohjZJ14TMpN2
         chNvvHPMTqixiN5iOrsHddOEMzDp1skh71FxQPpCpabo35pOq6NzKd6+vFXQ18t4xAts
         EfAO2u1iOJLX3j5LNk4LZiBFMuR9TKXViPQB5G19MZXbxtWc534XlsaYxG/+fs2x46XO
         P7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753687225; x=1754292025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UHVrcHsMB5Vp78BQj/kg0XXYLo73mbigKeMbyFXJqY=;
        b=gcCioAvCJPOYZ4sFWiFeRHkKElKlDNbdQwoSWgp29Yb1RVn1/LTjUQQXW19F1c3gUM
         bcbCj9x6GClg0enwo/sOz4P/qE3IVWvOP8BXXPBeBcKbgrfvdC/wAlLtR69UMUQrOaCB
         r+olU0qrMI/tNCAHmgOpZ7Go6Gnz5nK0jcIljX+3Ct/Wfc4ABjOeP6h1c0d9b+VdpbDH
         PrmUbQovuXzBvYvLZWaMYjGwH5L+1OxX+Kb0tenDj69LnJaT/LFGqxD7QX4RuSom10/w
         PJ91nwnj0camXz7MxbYSxAX1jbXGU87l7QhlRmxBCcBWrDIX3aPKwhm3iz4r5CmJvmmJ
         QuPg==
X-Gm-Message-State: AOJu0YyJ9XIR8Tk22oAkzvNF5c0Ordh7tc47YqLj4pBFGEQDO7N2Qtkg
	8/CA+8JUImfRcUDBJDmOc+dBtKfKnO5f7rf1Rd2mNnunzEr/sZDdrhESwmTuReEKYMxmR+36Jz5
	9M8RMBYPhGA==
X-Gm-Gg: ASbGncuLOCiJLhuArOmvSB/lpSnkO5uVYDMf4BzhsLPa9uzCQtAEl55B6mrrh4Q+9Br
	qnn6Uqv8J3prLQgZGudL/yA9EOtB2SHtCyRmvQky6WWQ3UeGWVnx462T4spX6i9sU/Zd7AJxVVc
	+7sywk0NSohfHw10NdFMLW64S83diK+XyKJLsgUXZPlBDBNxsqS3ubqQio2ck2vyB8KfU8TeeL5
	XXdr/DnWSDM/8RjJwrivRYUFWha7zj5iYnlJ1qTXo4Yw1xJP859XKLy/1WblTLfrVyVH3R4fItP
	8qvHEK9TtmzSkVWhIstMeOIYPCRapwK+xp1cDEYcntvFq50R+nmQrhQfGlFKFFo+kl6VAXNY2Yk
	s8qE5+8lPQy0uyIzqZlmiWRCQbK9mFirz+4boli9rM1XBA/ma8W7d47k=
X-Google-Smtp-Source: AGHT+IHcBWGfHfOd5VzuBSIhsjFqdKkY3yAB+5Efc9bsPHpCBZl3OsyKzVVqw9uEDV4q4+0LyEnncg==
X-Received: by 2002:a05:600c:6309:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-4588459921cmr33597545e9.2.1753687225209;
        Mon, 28 Jul 2025 00:20:25 -0700 (PDT)
Received: from localhost (61-227-70-84.dynamic-ip.hinet.net. [61.227.70.84])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458704aaf20sm148883305e9.0.2025.07.28.00.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 00:20:24 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 6.15 1/1] selftests/bpf: Add tests with stack ptr register in conditional jmp
Date: Mon, 28 Jul 2025 15:20:17 +0800
Message-ID: <20250728072018.40760-1-shung-hsi.yu@suse.com>
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
  backtracking bookkeeping", which already incorporated. ]
Link: https://lore.kernel.org/all/9b41f9f5-396f-47e0-9a12-46c52087df6c@linux.dev/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Verified that newly added test passes in 6.15.y[1] as well as 6.12.y[2]

1: https://github.com/shunghsiyu/libbpf/actions/runs/16561115937/job/46830912531
2: https://github.com/shunghsiyu/libbpf/actions/runs/16561115937/job/46830912533
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



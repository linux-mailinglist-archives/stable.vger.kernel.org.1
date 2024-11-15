Return-Path: <stable+bounces-93302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804A99CD876
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46773282022
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0548187FE8;
	Fri, 15 Nov 2024 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="exLVSpfP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA3187848;
	Fri, 15 Nov 2024 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653466; cv=none; b=Jmwm3EpItKSN9lWycHlxsvJ5OFcpl93P/2y4MrV3Kl5qoFUmprGkazOBHNon+fBzMz9lPwVa/xCpXGUt0P1eClkeMR6Qgz2SbA+m56U49bnDZdDNEFKrNdhelcWmjjydbS9MwOfjlF8DpoN98ScU1IzJkk3hukbAmkDZ0IR8rzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653466; c=relaxed/simple;
	bh=qqVSdnl0J0Zn6suODGagCacIBNohhCSyLlFg166DaDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoSH8uPv3Zug/Nn4kXyjT5cVH4LCL8VJUYExnefFICyzV7btLlWONhzyPfKRRTIlF0tHZIqZLCXiGdSONyyy1J7TKTdy/p5B2r7CLUs428ZEJoAJRUmkRycegZOw2+c+ostyufxhPrj/OIf9tO5ni1gjHGVJF5UXXz31y+HbBYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=exLVSpfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B997C4CECF;
	Fri, 15 Nov 2024 06:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653466;
	bh=qqVSdnl0J0Zn6suODGagCacIBNohhCSyLlFg166DaDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=exLVSpfPvFdB3yKQyw6EPvEQE0THA5e67Z9bHwGCAsBe0xa2BAPCKZw6DTS+BES4d
	 Hw1gWyREdMRhhrWaT2Tto8/LsU6qjT72EGW8xO+LjmtSeit/FGd829PRZokBtgDcqj
	 kVQezpQNmPYttAdz4QgD6gqoEfXlnGfF4vzvqSUE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 03/48] selftests/bpf: Verify that sync_linked_regs preserves subreg_def
Date: Fri, 15 Nov 2024 07:37:52 +0100
Message-ID: <20241115063723.088813298@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.962047137@linuxfoundation.org>
References: <20241115063722.962047137@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit a41b3828ec056a631ad22413d4560017fed5c3bd ]

This test was added because of a bug in verifier.c:sync_linked_regs(),
upon range propagation it destroyed subreg_def marks for registers.
The test is written in a way to return an upper half of a register
that is affected by range propagation and must have it's subreg_def
preserved. This gives a return value of 0 and leads to undefined
return value if subreg_def mark is not preserved.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20240924210844.1758441-2-eddyz87@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 13b29a7faa71a..d24d3a36ec144 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -656,4 +656,71 @@ __naked void two_old_ids_one_cur_id(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+/* Note the flag, see verifier.c:opt_subreg_zext_lo32_rnd_hi32() */
+__flag(BPF_F_TEST_RND_HI32)
+__success
+/* This test was added because of a bug in verifier.c:sync_linked_regs(),
+ * upon range propagation it destroyed subreg_def marks for registers.
+ * The subreg_def mark is used to decide whether zero extension instructions
+ * are needed when register is read. When BPF_F_TEST_RND_HI32 is set it
+ * also causes generation of statements to randomize upper halves of
+ * read registers.
+ *
+ * The test is written in a way to return an upper half of a register
+ * that is affected by range propagation and must have it's subreg_def
+ * preserved. This gives a return value of 0 and leads to undefined
+ * return value if subreg_def mark is not preserved.
+ */
+__retval(0)
+/* Check that verifier believes r1/r0 are zero at exit */
+__log_level(2)
+__msg("4: (77) r1 >>= 32                     ; R1_w=0")
+__msg("5: (bf) r0 = r1                       ; R0_w=0 R1_w=0")
+__msg("6: (95) exit")
+__msg("from 3 to 4")
+__msg("4: (77) r1 >>= 32                     ; R1_w=0")
+__msg("5: (bf) r0 = r1                       ; R0_w=0 R1_w=0")
+__msg("6: (95) exit")
+/* Verify that statements to randomize upper half of r1 had not been
+ * generated.
+ */
+__xlated("call unknown")
+__xlated("r0 &= 2147483647")
+__xlated("w1 = w0")
+/* This is how disasm.c prints BPF_ZEXT_REG at the moment, x86 and arm
+ * are the only CI archs that do not need zero extension for subregs.
+ */
+#if !defined(__TARGET_ARCH_x86) && !defined(__TARGET_ARCH_arm64)
+__xlated("w1 = w1")
+#endif
+__xlated("if w0 < 0xa goto pc+0")
+__xlated("r1 >>= 32")
+__xlated("r0 = r1")
+__xlated("exit")
+__naked void linked_regs_and_subreg_def(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	/* make sure r0 is in 32-bit range, otherwise w1 = w0 won't
+	 * assign same IDs to registers.
+	 */
+	"r0 &= 0x7fffffff;"
+	/* link w1 and w0 via ID */
+	"w1 = w0;"
+	/* 'if' statement propagates range info from w0 to w1,
+	 * but should not affect w1->subreg_def property.
+	 */
+	"if w0 < 10 goto +0;"
+	/* r1 is read here, on archs that require subreg zero
+	 * extension this would cause zext patch generation.
+	 */
+	"r1 >>= 32;"
+	"r0 = r1;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0





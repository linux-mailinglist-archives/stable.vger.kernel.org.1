Return-Path: <stable+bounces-238272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oACTHNGe4GlukQAAu9opvQ
	(envelope-from <stable+bounces-238272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:33:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3340B989
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9660F31D8DFB
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6838F656;
	Thu, 16 Apr 2026 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GdVHwBct"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC7311C32
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327977; cv=none; b=YPjLQ6vv4btqcEichFLG6LbWmW/Sf3DtvimwYYtcbdpLJ8Ui8oOC8+f0D/pIt9gB+qcN52vwIdCzwK5haHfSsY6jA2/epBFtO57LILZHjlt7j/yS5FU2fzODGHQwC+WxRHRjoVGj929/wqoGw93EdhOZSd/VC+s3631BZm/sYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327977; c=relaxed/simple;
	bh=gNmYBs4eB7PB1qP8zWRuEaTB4c6RzyRP997wV1O0+lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qpv9cVW2hrgGUh+wfvYa6MqcemSoOJ9nUQ1KZYjocpgZAzIz9nisfU/OdO0ZU48AgUfnNgg+aYnNfUcOwxtHlZsZ/xmN4Zt1zoLKLwE8XSeG2uZgOGeTESGxce8Y93Jk80CFFLkReRI7ylyJG4yxoheFyTETDiz3mGkG9GFGdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GdVHwBct; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so101623085e9.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776327974; x=1776932774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bD3DfLGn9PzqskvSxd4dMWxs0A7LqhF/1Zj5J3RfkGo=;
        b=GdVHwBctWvnL1LEN3wZt7FgnEloAXGxnrFXq92/0UUZ+iBJgpzT9/ipvubVoL0a5c1
         T5vTYAgvHjX6xtGoMqGMqBKQHwNZG42dJ9s7US12VZVjBeWVjGK49PN6nDVQ2wB0yIgM
         d+/W/9Rlx2xQzsL7dkKRPRXPBBZgx+Lw3Wakt0bsYIGX2eQZ96GFwrv3FCM/gnRVt4/L
         FiDB/wdTVIcW5tXQkgc+JD/oJYoBHH2t8ZT7CZlhu3bUhwXsKeTW9oexuprDsGydkWac
         dbbitduhBz2sc+8tP9BRVe5W7/Qx6hHXxdshzH+0QhgGhs241+hV7D+8soxOwUCPqxoQ
         C/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776327974; x=1776932774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD3DfLGn9PzqskvSxd4dMWxs0A7LqhF/1Zj5J3RfkGo=;
        b=XrXB/lHPtrWhwsDRgF+VwpynDNO+rCyGGPfaLKCwOhHihk+Cy/NecKfVoTxlbVgOoE
         BdKxdOD45ulVzZUGwCwqSE+LEHgH9D8b9keW816xlSqHwsBFb5P18Vk/PDuaO9awY10g
         b+9Y61B3SYeazndcIJW4DiQWq9UyJYgosdHk0JlE8fjavJk02qssz1rLjUxe0y9cWhMD
         r4/Z1Ntd/qJwYfUykZ8q2bsdMkUD82oTQv3oUr17NiAnVJcBwjXc0qL39ftO8m/jeiJp
         4r9hmv7N/EDNXTAX4iY4qYP8NtDNBTZzxmkjO9/KEQKMD7PPm5ejxaRGIVc72xJCrI1g
         pMlQ==
X-Gm-Message-State: AOJu0YzBpUASqxOV0SuTiCcD2W99Mvq9guRx7RVW8rU2EfppbfJvGoox
	bVg9dBnBVeWbVFKUE5NjIFD90chSDQHG4FcwtqJV+VWfp0BwmrBmoYoZ7M1AnwMBluno//1lpe1
	4qjrZJeU=
X-Gm-Gg: AeBDieuz02yi91TJMuMrxtKRrqwxAABPWHnRm0D5sy/Culzrw3bMGhBOSv0hvf6BjNC
	R6MwgGu2J+0fyWmH6H3+5LlhWABniDEnCZ8lpnY49+PDTa8yKU9JMgZ9k7z9a+hzHs3lk4YDqK3
	UYO2ivaWgJD2coJDhcNnH4nSIdgdcGI/L8FF614tJEZm9SUVnufB8qjTylZC4xV5UkbzhGBym4L
	9Z9lDnT3KBZraZI/jVwiZY4BRSIWN/eUsmH5vPGO88EloojEzSLBmyVljjrOXXcXfCWXUkv8ped
	10LDZX5DxJS+4DpwzijcWcEm91nV8MLKY3Q/im1U75wFbwsKkir9IA1L3nYEILhmMgdlqVxpBbm
	07V1zByWNFJ3oF//FePWVGfWRT0XszLt1v06WIVHbcN5rW/uzu9Hom39YHwFwiswBSWVo7YA86p
	Zt+5TFvzM64kIkCI9DB61UKmr220r3/OOq8/7sqP5Nn+Yh/hDhRTDOCkIsgQ==
X-Received: by 2002:a05:600c:c10f:b0:487:cd8:4c9 with SMTP id 5b1f17b1804b1-488d689ca8dmr236908545e9.27.1776327973664;
        Thu, 16 Apr 2026 01:26:13 -0700 (PDT)
Received: from localhost (27-51-42-31.adsl.fetnet.net. [27.51.42.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132cb874fsm1633453a91.8.2026.04.16.01.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 01:26:12 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Paul Chaignon <paul.chaignon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.18 6.19] selftests/bpf: Test refinement of single-value tnum
Date: Thu, 16 Apr 2026 16:26:05 +0800
Message-ID: <20260416082606.151196-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238272-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.com];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13E3340B989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Chaignon <paul.chaignon@gmail.com>

Commit e6ad477d1bf8829973cddd9accbafa9d1a6cd15a upstream.

This patch introduces selftests to cover the new bounds refinement
logic introduced in the previous patch. Without the previous patch,
the first two tests fail because of the invariant violation they
trigger. The last test fails because the R10 access is not detected as
dead code. In addition, all three tests fail because of R0 having a
non-constant value in the verifier logs.

In addition, the last two cases are covering the negative cases: when we
shouldn't refine the bounds because the u64 and tnum overlap in at least
two values.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Link: https://lore.kernel.org/r/90d880c8cf587b9f7dc715d8961cd1b8111d01a8.1772225741.git.paul.chaignon@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[shung-hsi.yu: test for backported upstream commit efc11a667878 ("bpf: Improve
bounds when tnum has a single possible value")]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
I intend to backport the whole "Fix invariant violation for single-value
tnums"[1] series to stable 6.12. Stable policy requires that those
commits to be backported to new stable branches first, and  this commit
was the only one that wasn't in 6.18 and 6.19 yet.

1: https://lore.kernel.org/r/cover.1772225741.git.paul.chaignon@gmail.com
---
 .../selftests/bpf/progs/verifier_bounds.c     | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 0a72e0228ea9..e772ae430915 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1709,4 +1709,141 @@ __naked void jeq_disagreeing_tnums(void *ctx)
 	: __clobber_all);
 }
 
+/* This test covers the bounds deduction when the u64 range and the tnum
+ * overlap only at umax. After instruction 3, the ranges look as follows:
+ *
+ * 0    umin=0xe01     umax=0xf00                              U64_MAX
+ * |    [xxxxxxxxxxxxxx]                                       |
+ * |----------------------------|------------------------------|
+ * |   x               x                                       | tnum values
+ *
+ * The verifier can therefore deduce that the R0=0xf0=240.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum on umax")
+__msg("3: (15) if r0 == 0xe0 {{.*}} R0=240")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void bounds_refinement_tnum_umax(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 |= 0xe0;			\
+	r0 &= 0xf0;			\
+	if r0 == 0xe0 goto +2;		\
+	if r0 == 0xf0 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test covers the bounds deduction when the u64 range and the tnum
+ * overlap only at umin. After instruction 3, the ranges look as follows:
+ *
+ * 0    umin=0xe00     umax=0xeff                              U64_MAX
+ * |    [xxxxxxxxxxxxxx]                                       |
+ * |----------------------------|------------------------------|
+ * |    x               x                                      | tnum values
+ *
+ * The verifier can therefore deduce that the R0=0xe0=224.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum on umin")
+__msg("3: (15) if r0 == 0xf0 {{.*}} R0=224")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void bounds_refinement_tnum_umin(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 |= 0xe0;			\
+	r0 &= 0xf0;			\
+	if r0 == 0xf0 goto +2;		\
+	if r0 == 0xe0 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test covers the bounds deduction when the only possible tnum value is
+ * in the middle of the u64 range. After instruction 3, the ranges look as
+ * follows:
+ *
+ * 0    umin=0x7cf   umax=0x7df                                U64_MAX
+ * |    [xxxxxxxxxxxx]                                         |
+ * |----------------------------|------------------------------|
+ * |     x            x            x            x            x | tnum values
+ *       |            +--- 0x7e0
+ *       +--- 0x7d0
+ *
+ * Since the lower four bits are zero, the tnum and the u64 range only overlap
+ * in R0=0x7d0=2000. Instruction 5 is therefore dead code.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum in middle of range")
+__msg("3: (a5) if r0 < 0x7cf {{.*}} R0=2000")
+__success __log_level(2)
+__naked void bounds_refinement_tnum_middle(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	if r0 & 0x0f goto +4;		\
+	if r0 > 0x7df goto +3;		\
+	if r0 < 0x7cf goto +2;		\
+	if r0 == 0x7d0 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test cover the negative case for the tnum/u64 overlap. Since
+ * they contain the same two values (i.e., {0, 1}), we can't deduce
+ * anything more.
+ */
+SEC("socket")
+__description("bounds refinement: several overlaps between tnum and u64")
+__msg("2: (25) if r0 > 0x1 {{.*}} R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))")
+__failure __log_level(2)
+__naked void bounds_refinement_several_overlaps(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	if r0 < 0 goto +3;		\
+	if r0 > 1 goto +2;		\
+	if r0 == 1 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test cover the negative case for the tnum/u64 overlap. Since
+ * they overlap in the two values contained by the u64 range (i.e.,
+ * {0xf, 0x10}), we can't deduce anything more.
+ */
+SEC("socket")
+__description("bounds refinement: multiple overlaps between tnum and u64")
+__msg("2: (25) if r0 > 0x10 {{.*}} R0=scalar(smin=umin=smin32=umin32=15,smax=umax=smax32=umax32=16,var_off=(0x0; 0x1f))")
+__failure __log_level(2)
+__naked void bounds_refinement_multiple_overlaps(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	if r0 < 0xf goto +3;		\
+	if r0 > 0x10 goto +2;		\
+	if r0 == 0x10 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0



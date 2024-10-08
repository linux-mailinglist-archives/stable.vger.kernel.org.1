Return-Path: <stable+bounces-82217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6625B994BB6
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14730283582
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC101DEFD6;
	Tue,  8 Oct 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O3OPkuyz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3811DE898;
	Tue,  8 Oct 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391532; cv=none; b=OYS5PogND9tFvXid1PeMtQoKClxCcC0mNH+av82JzwpZl+1r6HC2NQaT8Dyw1BTlzAzjOJfDlqjLm8D6G0XX30uQXH3FQ8dPtoQnngl9xLjtz322//5IlR/DpOcUspcfFVhwuvLrdy1h6ttpPey2LKkKzYTfa65o9/cZXv0Ptgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391532; c=relaxed/simple;
	bh=1JNG30GcwJtzLEZ9kH1DepijJd/0X7daWbwbvkhintM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnk1fCjooHYi6Bk11xDSp5MNCVNq1YCVkfIU8c7+O5xKSEchmRSONQu64vGBSQ3PYdvdGpXP/FFheRDE3YzL1EW1wdTqSRx2nPYtlG3H4XqiaEmFS98xVAeqYKZg8io0TCusbrlvSy+R9ForihnKXvYxyJqebjhq3t4Ta/EbxuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O3OPkuyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EFAC4CEC7;
	Tue,  8 Oct 2024 12:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391532;
	bh=1JNG30GcwJtzLEZ9kH1DepijJd/0X7daWbwbvkhintM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3OPkuyzRZzLcyjNRS1F1/DcsQYZlJ66VN6ZI5FLViBisYH5TwWoFd/xcfleEUh2+
	 6at7+LVR7DuL0k2yIazZPz2Ag+2Ty57Jv26jx3npkVUJhO+oQHLSb62SpuLUtIG29i
	 H2/hFaGFHBLZPUuU8DtGcgIChHPYJTk98YW5iLeA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Konstantin Ovsepian <ovs@ovs.to>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 112/558] blk_iocost: fix more out of bound shifts
Date: Tue,  8 Oct 2024 14:02:22 +0200
Message-ID: <20241008115706.773079385@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Ovsepian <ovs@ovs.to>

[ Upstream commit 9bce8005ec0dcb23a58300e8522fe4a31da606fa ]

Recently running UBSAN caught few out of bound shifts in the
ioc_forgive_debts() function:

UBSAN: shift-out-of-bounds in block/blk-iocost.c:2142:38
shift exponent 80 is too large for 64-bit type 'u64' (aka 'unsigned long
long')
...
UBSAN: shift-out-of-bounds in block/blk-iocost.c:2144:30
shift exponent 80 is too large for 64-bit type 'u64' (aka 'unsigned long
long')
...
Call Trace:
<IRQ>
dump_stack_lvl+0xca/0x130
__ubsan_handle_shift_out_of_bounds+0x22c/0x280
? __lock_acquire+0x6441/0x7c10
ioc_timer_fn+0x6cec/0x7750
? blk_iocost_init+0x720/0x720
? call_timer_fn+0x5d/0x470
call_timer_fn+0xfa/0x470
? blk_iocost_init+0x720/0x720
__run_timer_base+0x519/0x700
...

Actual impact of this issue was not identified but I propose to fix the
undefined behaviour.
The proposed fix to prevent those out of bound shifts consist of
precalculating exponent before using it the shift operations by taking
min value from the actual exponent and maximum possible number of bits.

Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Konstantin Ovsepian <ovs@ovs.to>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20240822154137.2627818-1-ovs@ovs.to
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 690ca99dfaca6..5a6098a3db57e 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2076,7 +2076,7 @@ static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 			      struct ioc_now *now)
 {
 	struct ioc_gq *iocg;
-	u64 dur, usage_pct, nr_cycles;
+	u64 dur, usage_pct, nr_cycles, nr_cycles_shift;
 
 	/* if no debtor, reset the cycle */
 	if (!nr_debtors) {
@@ -2138,10 +2138,12 @@ static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 		old_debt = iocg->abs_vdebt;
 		old_delay = iocg->delay;
 
+		nr_cycles_shift = min_t(u64, nr_cycles, BITS_PER_LONG - 1);
 		if (iocg->abs_vdebt)
-			iocg->abs_vdebt = iocg->abs_vdebt >> nr_cycles ?: 1;
+			iocg->abs_vdebt = iocg->abs_vdebt >> nr_cycles_shift ?: 1;
+
 		if (iocg->delay)
-			iocg->delay = iocg->delay >> nr_cycles ?: 1;
+			iocg->delay = iocg->delay >> nr_cycles_shift ?: 1;
 
 		iocg_kick_waitq(iocg, true, now);
 
-- 
2.43.0





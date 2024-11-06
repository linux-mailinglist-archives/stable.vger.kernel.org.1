Return-Path: <stable+bounces-90541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE94E9BE8DC
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C5C2831DF
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BD51DF995;
	Wed,  6 Nov 2024 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QngcRAEC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6F51DF986;
	Wed,  6 Nov 2024 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896077; cv=none; b=DlKE9t2KzOFXa9Ghu3Fz4AknGvGZ6/mUIJ7WKxh00dXyAfiz+aGbTI3ZThaUiByMkma7f+mEDuIBlF1q+Pm52NZsBmzAWuNtBRnanVNJjzp+JzGqtgkcIXq+La6BYiOZIpdfdQHzKQcrLOt9jlaaITqKK/IZAxsutpeH5g8wbiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896077; c=relaxed/simple;
	bh=Xz43xTj29Rl+ZVsgSUjK2omOlA09yI7wQSDpkrTIelY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXdY9iiNHsoZLb9ESEwF1TAhs/P7doMeImY3ynrzQBNs/N3o+ozxryCrduCK52BVtxPkM2xk9VRaScjz/gqTZrZDcpyxF8pq7i2cFvRl6wwVh7VHeNRt//GvdY9GR/CvkkRkWBy3N+iK5GRNJXrIstxiQghclTJ9r1F9B7A0Joc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QngcRAEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E846AC4CECD;
	Wed,  6 Nov 2024 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896077;
	bh=Xz43xTj29Rl+ZVsgSUjK2omOlA09yI7wQSDpkrTIelY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QngcRAECFxckDlnEijA5SoE7qpW1Z0IBqNYuRoQrl+AEonJeMIFYHETYuUmQtcShR
	 lTqSHOw/0lDVd+ExrcVRbattVfwqnU2de4fL69j1hAQn7kSKym0V2UhiESqo/jUKmL
	 a4ekaz7RHnR/0UppWo7YjrAMqb66qeTLkmWR+mBM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yafang Shao <laoar.shao@gmail.com>,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 046/245] bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
Date: Wed,  6 Nov 2024 13:01:39 +0100
Message-ID: <20241106120320.360706570@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
References: <20241106120319.234238499@linuxfoundation.org>
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

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 101ccfbabf4738041273ce64e2b116cf440dea13 ]

bpf_iter_bits_destroy() uses "kit->nr_bits <= 64" to check whether the
bits are dynamically allocated. However, the check is incorrect and may
cause a kmemleak as shown below:

unreferenced object 0xffff88812628c8c0 (size 32):
  comm "swapper/0", pid 1, jiffies 4294727320
  hex dump (first 32 bytes):
	b0 c1 55 f5 81 88 ff ff f0 f0 f0 f0 f0 f0 f0 f0  ..U...........
	f0 f0 f0 f0 f0 f0 f0 f0 00 00 00 00 00 00 00 00  ..............
  backtrace (crc 781e32cc):
	[<00000000c452b4ab>] kmemleak_alloc+0x4b/0x80
	[<0000000004e09f80>] __kmalloc_node_noprof+0x480/0x5c0
	[<00000000597124d6>] __alloc.isra.0+0x89/0xb0
	[<000000004ebfffcd>] alloc_bulk+0x2af/0x720
	[<00000000d9c10145>] prefill_mem_cache+0x7f/0xb0
	[<00000000ff9738ff>] bpf_mem_alloc_init+0x3e2/0x610
	[<000000008b616eac>] bpf_global_ma_init+0x19/0x30
	[<00000000fc473efc>] do_one_initcall+0xd3/0x3c0
	[<00000000ec81498c>] kernel_init_freeable+0x66a/0x940
	[<00000000b119f72f>] kernel_init+0x20/0x160
	[<00000000f11ac9a7>] ret_from_fork+0x3c/0x70
	[<0000000004671da4>] ret_from_fork_asm+0x1a/0x30

That is because nr_bits will be set as zero in bpf_iter_bits_next()
after all bits have been iterated.

Fix the issue by setting kit->bit to kit->nr_bits instead of setting
kit->nr_bits to zero when the iteration completes in
bpf_iter_bits_next(). In addition, use "!nr_bits || bits >= nr_bits" to
check whether the iteration is complete and still use "nr_bits > 64" to
indicate whether bits are dynamically allocated. The "!nr_bits" check is
necessary because bpf_iter_bits_new() may fail before setting
kit->nr_bits, and this condition will stop the iteration early instead
of accessing the zeroed or freed kit->bits.

Considering the initial value of kit->bits is -1 and the type of
kit->nr_bits is unsigned int, change the type of kit->nr_bits to int.
The potential overflow problem will be handled in the following patch.

Fixes: 4665415975b0 ("bpf: Add bits iterator")
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20241030100516.3633640-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/helpers.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cc8c00864a680..a4521d2606b6b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2835,7 +2835,7 @@ struct bpf_iter_bits_kern {
 		unsigned long *bits;
 		unsigned long bits_copy;
 	};
-	u32 nr_bits;
+	int nr_bits;
 	int bit;
 } __aligned(8);
 
@@ -2909,17 +2909,16 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 __bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
 {
 	struct bpf_iter_bits_kern *kit = (void *)it;
-	u32 nr_bits = kit->nr_bits;
+	int bit = kit->bit, nr_bits = kit->nr_bits;
 	const unsigned long *bits;
-	int bit;
 
-	if (nr_bits == 0)
+	if (!nr_bits || bit >= nr_bits)
 		return NULL;
 
 	bits = nr_bits == 64 ? &kit->bits_copy : kit->bits;
-	bit = find_next_bit(bits, nr_bits, kit->bit + 1);
+	bit = find_next_bit(bits, nr_bits, bit + 1);
 	if (bit >= nr_bits) {
-		kit->nr_bits = 0;
+		kit->bit = bit;
 		return NULL;
 	}
 
-- 
2.43.0





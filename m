Return-Path: <stable+bounces-80437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4EB98DD6E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9821C22B7D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFF71D12E3;
	Wed,  2 Oct 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vdy+Ssh1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685501D0E04;
	Wed,  2 Oct 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880372; cv=none; b=ab2XrdIEjS2qDpI8diSIc3vnbbccPI0AiNpLwVNvdHWOFw5yGQpc0wAcihwnz8N6P0VEyDVvpey8reDZe5+KIt7fza711EpDyrwZ38kQChUut35qXMMv1/ErNatJlHb4IdqQtiiVxlnDswB+Fmf85Y6wt3p9kEa1fjkaz79SdV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880372; c=relaxed/simple;
	bh=6NgQjIadXEBCHh7LQjcdlyzJ3fu7Zec5I1PxamLuf9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6xNnI5Kh7vqy+T1kPD5EYCFiA7mK0/PzyWhCe0zXqnp8TWN/PhsG9hFF8l1WuVSx46EYrAdym74lNivgUua/ygVfq+gqVEjENMfCV8zMB56DJvEnbC305gCmpK7C8JUbgqnNYqhPhGY+ie1ejjsQRIBD6iw3FfUS9hdsHG7mCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vdy+Ssh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4328C4CEC2;
	Wed,  2 Oct 2024 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880372;
	bh=6NgQjIadXEBCHh7LQjcdlyzJ3fu7Zec5I1PxamLuf9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vdy+Ssh17NmZdp45/3CpyQe+G87RwW6crK3kwYnCKhZb5iCu0PZn+8K2PM+AP1Ku7
	 MQFOKI8Y6JxfTr/YI75mQO1ReRxoebKeeBAXwAKIevBodOiODtMqZNjHN+HipLGO30
	 VppnUTczBBgPO7qTPvrx9z2WvPiTaNhL3K/r107c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	syzbot+16073ebbc4c64b819b47@syzkaller.appspotmail.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.6 405/538] iommufd: Protect against overflow of ALIGN() during iova allocation
Date: Wed,  2 Oct 2024 15:00:44 +0200
Message-ID: <20241002125808.423018693@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

From: Jason Gunthorpe <jgg@nvidia.com>

commit 8f6887349b2f829a4121c518aeb064fc922714e4 upstream.

Userspace can supply an iova and uptr such that the target iova alignment
becomes really big and ALIGN() overflows which corrupts the selected area
range during allocation. CONFIG_IOMMUFD_TEST can detect this:

   WARNING: CPU: 1 PID: 5092 at drivers/iommu/iommufd/io_pagetable.c:268 iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:268 [inline]
   WARNING: CPU: 1 PID: 5092 at drivers/iommu/iommufd/io_pagetable.c:268 iopt_map_pages+0xf95/0x1050 drivers/iommu/iommufd/io_pagetable.c:352
   Modules linked in:
   CPU: 1 PID: 5092 Comm: syz-executor294 Not tainted 6.10.0-rc5-syzkaller-00294-g3ffea9a7a6f7 #0
   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
   RIP: 0010:iopt_alloc_area_pages drivers/iommu/iommufd/io_pagetable.c:268 [inline]
   RIP: 0010:iopt_map_pages+0xf95/0x1050 drivers/iommu/iommufd/io_pagetable.c:352
   Code: fc e9 a4 f3 ff ff e8 1a 8b 4c fc 41 be e4 ff ff ff e9 8a f3 ff ff e8 0a 8b 4c fc 90 0f 0b 90 e9 37 f5 ff ff e8 fc 8a 4c fc 90 <0f> 0b 90 e9 68 f3 ff ff 48 c7 c1 ec 82 ad 8f 80 e1 07 80 c1 03 38
   RSP: 0018:ffffc90003ebf9e0 EFLAGS: 00010293
   RAX: ffffffff85499fa4 RBX: 00000000ffffffef RCX: ffff888079b49e00
   RDX: 0000000000000000 RSI: 00000000ffffffef RDI: 0000000000000000
   RBP: ffffc90003ebfc50 R08: ffffffff85499b30 R09: ffffffff85499942
   R10: 0000000000000002 R11: ffff888079b49e00 R12: ffff8880228e0010
   R13: 0000000000000000 R14: 1ffff920007d7f68 R15: ffffc90003ebfd00
   FS:  000055557d760380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 00000000005fdeb8 CR3: 000000007404a000 CR4: 00000000003506f0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   Call Trace:
    <TASK>
    iommufd_ioas_copy+0x610/0x7b0 drivers/iommu/iommufd/ioas.c:274
    iommufd_fops_ioctl+0x4d9/0x5a0 drivers/iommu/iommufd/main.c:421
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:907 [inline]
    __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

Cap the automatic alignment to the huge page size, which is probably a
better idea overall. Huge automatic alignments can fragment and chew up
the available IOVA space without any reason.

Link: https://patch.msgid.link/r/0-v1-8009738b9891+1f7-iommufd_align_overflow_jgg@nvidia.com
Cc: stable@vger.kernel.org
Fixes: 51fe6141f0f6 ("iommufd: Data structure to provide IOVA to PFN mapping")
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reported-by: syzbot+16073ebbc4c64b819b47@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/000000000000388410061a74f014@google.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iommufd/io_pagetable.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -111,6 +111,7 @@ static int iopt_alloc_iova(struct io_pag
 	unsigned long page_offset = uptr % PAGE_SIZE;
 	struct interval_tree_double_span_iter used_span;
 	struct interval_tree_span_iter allowed_span;
+	unsigned long max_alignment = PAGE_SIZE;
 	unsigned long iova_alignment;
 
 	lockdep_assert_held(&iopt->iova_rwsem);
@@ -130,6 +131,13 @@ static int iopt_alloc_iova(struct io_pag
 				       roundup_pow_of_two(length),
 				       1UL << __ffs64(uptr));
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	max_alignment = HPAGE_SIZE;
+#endif
+	/* Protect against ALIGN() overflow */
+	if (iova_alignment >= max_alignment)
+		iova_alignment = max_alignment;
+
 	if (iova_alignment < iopt->iova_alignment)
 		return -EINVAL;
 




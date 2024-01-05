Return-Path: <stable+bounces-9775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 927F78250EE
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 10:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93731C22D83
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189A42377E;
	Fri,  5 Jan 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qxv7dCah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92095399
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 09:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24C0C433C7;
	Fri,  5 Jan 2024 09:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704447440;
	bh=3jyfa2+EO0IzREDBp7AALSOCIoqTideZr6wWOqrTkBo=;
	h=Subject:To:From:Date:From;
	b=Qxv7dCah0Xi2BS1ARhMCJf3c2R4o8KYYussCkJvW2gB8offIO+VEZxwFQVvt6KGtk
	 m8pEn5HPu7QzIGaLl1msECFm8k4/5YvUDA/yBcImWZfcNw7AszJyZVtDg/szBUHvym
	 O3Kkdj1OE/R6mU3e8NQcA1aJQ9pR5hZ3wYv8aD/s=
Subject: patch "usb: mon: Fix atomicity violation in mon_bin_vma_fault" added to usb-next
To: 2045gemini@gmail.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jan 2024 10:37:08 +0100
Message-ID: <2024010508-synthesis-squash-631d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    usb: mon: Fix atomicity violation in mon_bin_vma_fault

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 2dd23cc4d0e6aa55cf9fb3b05f2f4165b01de81c Mon Sep 17 00:00:00 2001
From: Gui-Dong Han <2045gemini@gmail.com>
Date: Fri, 5 Jan 2024 13:24:12 +0800
Subject: usb: mon: Fix atomicity violation in mon_bin_vma_fault

In mon_bin_vma_fault():
    offset = vmf->pgoff << PAGE_SHIFT;
    if (offset >= rp->b_size)
        return VM_FAULT_SIGBUS;
    chunk_idx = offset / CHUNK_SIZE;
    pageptr = rp->b_vec[chunk_idx].pg;
The code is executed without holding any lock.

In mon_bin_vma_close():
    spin_lock_irqsave(&rp->b_lock, flags);
    rp->mmap_active--;
    spin_unlock_irqrestore(&rp->b_lock, flags);

In mon_bin_ioctl():
    spin_lock_irqsave(&rp->b_lock, flags);
    if (rp->mmap_active) {
        ...
    } else {
        ...
        kfree(rp->b_vec);
        rp->b_vec  = vec;
        rp->b_size = size;
        ...
    }
    spin_unlock_irqrestore(&rp->b_lock, flags);

Concurrent execution of mon_bin_vma_fault() with mon_bin_vma_close() and
mon_bin_ioctl() could lead to atomicity violations. mon_bin_vma_fault()
accesses rp->b_size and rp->b_vec without locking, risking array
out-of-bounds access or use-after-free bugs due to possible modifications
in mon_bin_ioctl().

This possible bug is found by an experimental static analysis tool
developed by our team, BassCheck[1]. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations. The above
possible bug is reported when our tool analyzes the source code of
Linux 6.2.

To address this issue, it is proposed to add a spin lock pair in
mon_bin_vma_fault() to ensure atomicity. With this patch applied, our tool
never reports the possible bug, with the kernel configuration allyesconfig
for x86_64. Due to the lack of associated hardware, we cannot test the
patch in runtime testing, and just verify it according to the code logic.

[1] https://sites.google.com/view/basscheck/

Fixes: 19e6317d24c2 ("usb: mon: Fix a deadlock in usbmon between ...")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
Link: https://lore.kernel.org/r/20240105052412.9377-1-2045gemini@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/mon/mon_bin.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index 9ca9305243fe..4e30de4db1c0 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1250,14 +1250,19 @@ static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
 	struct mon_reader_bin *rp = vmf->vma->vm_private_data;
 	unsigned long offset, chunk_idx;
 	struct page *pageptr;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rp->b_lock, flags);
 	offset = vmf->pgoff << PAGE_SHIFT;
-	if (offset >= rp->b_size)
+	if (offset >= rp->b_size) {
+		spin_unlock_irqrestore(&rp->b_lock, flags);
 		return VM_FAULT_SIGBUS;
+	}
 	chunk_idx = offset / CHUNK_SIZE;
 	pageptr = rp->b_vec[chunk_idx].pg;
 	get_page(pageptr);
 	vmf->page = pageptr;
+	spin_unlock_irqrestore(&rp->b_lock, flags);
 	return 0;
 }
 
-- 
2.43.0




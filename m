Return-Path: <stable+bounces-50502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824F4906A97
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0077AB239DE
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A90A14264D;
	Thu, 13 Jun 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E0YyBkVG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B513D534
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276368; cv=none; b=UFdGEJFpn2l68/uZptCjkFNlPEwWu3nOcoZr7CAGkghooqKJHyzCSEh5llVR+luEU48zllyCLwZFwX5sWPdyS077wWu6B7/Jd1y6X+N1HrqDNwP0sZdDTK7LZZu/s/repszGP3ReW5hBaZFWPgibSOdkG3zzDhmhOWHgcHB/DGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276368; c=relaxed/simple;
	bh=tdC+BrvmmPWHB80QohXRJZPqdyq3xvvu4fo00JzdrH8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QNMOP4GErEyLZ93cI+2pHCFKWj41rrB1w/mP5B03sWBHTIa9G7BXsO1z7WFSFzieWU1e0NMcXkmr/HbRPOLmr1OzMDllv9qJ8m7WSeVHNxV5wU56Rpbiirh9qMlrxzKEXrD52SRmKpVVSVgtF9xd+FPcjMZy+Pyvk2uFKnQEFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E0YyBkVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013ADC32786;
	Thu, 13 Jun 2024 10:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718276367;
	bh=tdC+BrvmmPWHB80QohXRJZPqdyq3xvvu4fo00JzdrH8=;
	h=Subject:To:Cc:From:Date:From;
	b=E0YyBkVGQNGFhfILf1/NQmrKrL4XEQDdbmYl5eAVZHtVqNipyBF2CZROA3DXxoHIj
	 YrDaRhWY2Nr8uGZ/LSpqyI8+B3lpUdjzkVpFk7P/K3qFODh4HG1Yy2O4bkjRmIHcaM
	 y1bUJ2i4OPscGmlAIgJBRVlCFNgwCqY5YhdyqvMo=
Subject: FAILED: patch "[PATCH] nilfs2: fix potential kernel bug due to lack of writeback" failed to apply to 6.6-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 12:59:24 +0200
Message-ID: <2024061324-prize-qualifier-989e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a4ca369ca221bb7e06c725792ac107f0e48e82e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061324-prize-qualifier-989e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

a4ca369ca221 ("nilfs2: fix potential kernel bug due to lack of writeback flag waiting")
ff5710c3f3c2 ("nilfs2: convert nilfs_segctor_prepare_write to use folios")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a4ca369ca221bb7e06c725792ac107f0e48e82e7 Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 30 May 2024 23:15:56 +0900
Subject: [PATCH] nilfs2: fix potential kernel bug due to lack of writeback
 flag waiting

Destructive writes to a block device on which nilfs2 is mounted can cause
a kernel bug in the folio/page writeback start routine or writeback end
routine (__folio_start_writeback in the log below):

 kernel BUG at mm/page-writeback.c:3070!
 Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
 ...
 RIP: 0010:__folio_start_writeback+0xbaa/0x10e0
 Code: 25 ff 0f 00 00 0f 84 18 01 00 00 e8 40 ca c6 ff e9 17 f6 ff ff
  e8 36 ca c6 ff 4c 89 f7 48 c7 c6 80 c0 12 84 e8 e7 b3 0f 00 90 <0f>
  0b e8 1f ca c6 ff 4c 89 f7 48 c7 c6 a0 c6 12 84 e8 d0 b3 0f 00
 ...
 Call Trace:
  <TASK>
  nilfs_segctor_do_construct+0x4654/0x69d0 [nilfs2]
  nilfs_segctor_construct+0x181/0x6b0 [nilfs2]
  nilfs_segctor_thread+0x548/0x11c0 [nilfs2]
  kthread+0x2f0/0x390
  ret_from_fork+0x4b/0x80
  ret_from_fork_asm+0x1a/0x30
  </TASK>

This is because when the log writer starts a writeback for segment summary
blocks or a super root block that use the backing device's page cache, it
does not wait for the ongoing folio/page writeback, resulting in an
inconsistent writeback state.

Fix this issue by waiting for ongoing writebacks when putting
folios/pages on the backing device into writeback state.

Link: https://lkml.kernel.org/r/20240530141556.4411-1-konishi.ryusuke@gmail.com
Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 60d4f59f7665..6ea81f1d5094 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1652,6 +1652,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			if (bh->b_folio != bd_folio) {
 				if (bd_folio) {
 					folio_lock(bd_folio);
+					folio_wait_writeback(bd_folio);
 					folio_clear_dirty_for_io(bd_folio);
 					folio_start_writeback(bd_folio);
 					folio_unlock(bd_folio);
@@ -1665,6 +1666,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_folio != bd_folio) {
 					folio_lock(bd_folio);
+					folio_wait_writeback(bd_folio);
 					folio_clear_dirty_for_io(bd_folio);
 					folio_start_writeback(bd_folio);
 					folio_unlock(bd_folio);
@@ -1681,6 +1683,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 	}
 	if (bd_folio) {
 		folio_lock(bd_folio);
+		folio_wait_writeback(bd_folio);
 		folio_clear_dirty_for_io(bd_folio);
 		folio_start_writeback(bd_folio);
 		folio_unlock(bd_folio);



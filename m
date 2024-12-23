Return-Path: <stable+bounces-105603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87C69FAE01
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F416D1884525
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB65E1A7060;
	Mon, 23 Dec 2024 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GoByon61"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6944C1A3BD7
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734955079; cv=none; b=Ft5GUYop6Sioc5RMALgxvi8NzAS/L3FkQ0eimncTZRFLBmPsaF2sEZxj4JBoA/D0R3sf8Rgxke/bXD7s1MF4OX7MmqzKrramDqqKqsb2lEH4yb0SQUKZiwnYCzfzN3EC9s9pPDYbCTNp3ZfxOmHsocQbkwaRDDG4x2yoHMtNeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734955079; c=relaxed/simple;
	bh=hbVDHRygm/ys++NLn8HsC4qmMeFAYEugga/QfbkRmtY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kInKvL8f9rHDvFlEKPYlLZpD7POJdZcAiEw6xdfhDcQ9zsZLUwcrSi8398WkIRJegQIzUOdLLq7Ysl48MRTD2xDj77InIN3VDI8lgSES7TtpNTh9tsRjHRmrfydO7Rgad15sfn2aGzzYSxL8zuSCljo3nx1Mh1OHIpXc9YLshc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GoByon61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9BFC4CED4;
	Mon, 23 Dec 2024 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734955078;
	bh=hbVDHRygm/ys++NLn8HsC4qmMeFAYEugga/QfbkRmtY=;
	h=Subject:To:Cc:From:Date:From;
	b=GoByon61gllWaktItTh0UnDECvVFoHcskXTAh5qRvVp3RwAVq8Xtx5LDuCqmk3Pj5
	 Sxdax7x16sumyaiE4HNOyXAxleZkSDRMeJPdfnBbsB604+LQ80OehpeGZZ8vQko+rs
	 RjTRSWYv8nsxTSCpOlcKGHbujSJkyEaAIROJ5TU8=
Subject: FAILED: patch "[PATCH] udmabuf: fix racy memfd sealing check" failed to apply to 6.1-stable tree
To: jannh@google.com,joel@joelfernandes.org,ju.orth@gmail.com,vivek.kasireddy@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 12:57:47 +0100
Message-ID: <2024122347-uncivil-decimal-1a11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9cb189a882738c1d28b349d4e7c6a1ef9b3d8f87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122347-uncivil-decimal-1a11@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9cb189a882738c1d28b349d4e7c6a1ef9b3d8f87 Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Dec 2024 17:26:19 +0100
Subject: [PATCH] udmabuf: fix racy memfd sealing check

The current check_memfd_seals() is racy: Since we first do
check_memfd_seals() and then udmabuf_pin_folios() without holding any
relevant lock across both, F_SEAL_WRITE can be set in between.
This is problematic because we can end up holding pins to pages in a
write-sealed memfd.

Fix it using the inode lock, that's probably the easiest way.
In the future, we might want to consider moving this logic into memfd,
especially if anyone else wants to use memfd_pin_folios().

Reported-by: Julian Orth <ju.orth@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219106
Closes: https://lore.kernel.org/r/CAG48ez0w8HrFEZtJkfmkVKFDhE5aP7nz=obrimeTgpD+StkV9w@mail.gmail.com
Fixes: fbb0de795078 ("Add udmabuf misc device")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241204-udmabuf-fixes-v2-1-23887289de1c@google.com

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 8ce1f074c2d3..c1d8c2766d6d 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -436,14 +436,19 @@ static long udmabuf_create(struct miscdevice *device,
 			goto err;
 		}
 
+		/*
+		 * Take the inode lock to protect against concurrent
+		 * memfd_add_seals(), which takes this lock in write mode.
+		 */
+		inode_lock_shared(file_inode(memfd));
 		ret = check_memfd_seals(memfd);
-		if (ret < 0) {
-			fput(memfd);
-			goto err;
-		}
+		if (ret)
+			goto out_unlock;
 
 		ret = udmabuf_pin_folios(ubuf, memfd, list[i].offset,
 					 list[i].size, folios);
+out_unlock:
+		inode_unlock_shared(file_inode(memfd));
 		fput(memfd);
 		if (ret)
 			goto err;



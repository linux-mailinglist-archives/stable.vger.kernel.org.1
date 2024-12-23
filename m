Return-Path: <stable+bounces-105606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21CD9FAE05
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE951884451
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3631A7060;
	Mon, 23 Dec 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tPHWaRy+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEBC166307
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734955089; cv=none; b=uxUH1OL9cOgXZ4Z6gs7y1i1FnGKES+nzUNbyQLefPaAxSqOimIzdMhauMkPgtNiNxXwEPvaaQn66y1nP5QNpQnXdcvkzgj9J/6Zc2mOL41mZWJ2P4n81oShEkg/yGBhXf7sOGt+f5LZh201Olr7fRB3T+PWfLgE3o/ncf9/0pYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734955089; c=relaxed/simple;
	bh=lJCxeUTL/Nl5bh8CoMxFBNps1k9wfnuND1wkveuJnF4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rfoa/cD/VRekTF0aYFL2unW28kNInqf1ACeG61R+aPOA4C4IGOAr3OuXNMsBo0vjVoQueDmagMyoeFu4IuBSaW5DvOS5sQu1lQ69z1S9o0/LywgJr2c9MYvsPn/J2S+kLhE26tBC0owlqBhaOvl2g2qLtrmNZlsFqHyY713StTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tPHWaRy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC39BC4CED3;
	Mon, 23 Dec 2024 11:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734955089;
	bh=lJCxeUTL/Nl5bh8CoMxFBNps1k9wfnuND1wkveuJnF4=;
	h=Subject:To:Cc:From:Date:From;
	b=tPHWaRy+g6B7qi6gLlhmSHMGNQTzfom8fiNLpLdfV4U9UnK31bd31OEQDHunPgUtD
	 RFCHMh6wU3ATDS4gkjW/if+TeKbdIdaPgP4Wn48KCc4BEu4GpPJoThAZCvOm8rXGy8
	 0d0LYY09Yoe3SqfQAlio1j9KgrYTcyR5Iwxixo9M=
Subject: FAILED: patch "[PATCH] udmabuf: fix racy memfd sealing check" failed to apply to 5.10-stable tree
To: jannh@google.com,joel@joelfernandes.org,ju.orth@gmail.com,vivek.kasireddy@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 12:57:49 +0100
Message-ID: <2024122349-unhinge-seduce-70ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9cb189a882738c1d28b349d4e7c6a1ef9b3d8f87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122349-unhinge-seduce-70ff@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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



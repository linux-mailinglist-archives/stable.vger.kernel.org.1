Return-Path: <stable+bounces-55037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51019915193
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0281A28AB41
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F15719E817;
	Mon, 24 Jun 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IEAdJy1w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CD519D086
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241784; cv=none; b=rZkbk1EkI/rz0akbByU8wBSpqvr1M0nDd21ID08fXsbPw4tnvl5sLXPRiux3aCnCq0x8E1UxrE3oNTOxVxDHOGU95qcl5B69ev2wv2iuC5tcAUR22YNCYS5IVZKripmFhWiiNvd0rjFxOLEYVMrTJNEXsjmacE0e+0xyb3Qcs98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241784; c=relaxed/simple;
	bh=htFtT49PtOLuVE/lsOBamHKSknuf2b5FleLHANh47nc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AqbMt7EH3ViTNG/cN8w+5Jw+Aj9/dICPMpex8vTII2/JKiHvxAhdIFTHFiX1EvUF9G9hJfuQPovVIJemiqXHWDDH2mnV2bxDgbYFKh2f0jaWYoPktYhSgefhhzlS5kGUXkEDucxoOoTosEwh3TxhGp10em85IdZYPDgU32m8+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IEAdJy1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202A8C4AF09;
	Mon, 24 Jun 2024 15:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719241783;
	bh=htFtT49PtOLuVE/lsOBamHKSknuf2b5FleLHANh47nc=;
	h=Subject:To:Cc:From:Date:From;
	b=IEAdJy1wCX3el/UJZQzIOrnNG9noRQZlUxKHe30kzhfP3gw2H+mCFTx5xBbFy5hXI
	 474xZ/66g/CAEH27kYqXWRES+qJczLptPyMgVSlAMp0byHgVk3mIrQ5ozgw7nM8lM+
	 heTojbpqTD4dXAWEUUjq5Y2taJg5oyy5UnqsWbtc=
Subject: FAILED: patch "[PATCH] cifs: drop the incorrect assertion in cifs_swap_rw()" failed to apply to 6.1-stable tree
To: baohua@kernel.org,anna@kernel.org,bharathsm@microsoft.com,chrisl@kernel.org,hanchuanhua@oppo.com,hch@lst.de,jlayton@kernel.org,neilb@suse.de,pc@manguebit.com,ronniesahlberg@gmail.com,ryan.roberts@arm.com,sfrench@samba.org,sprasad@microsoft.com,stable@vger.kernel.org,stfrench@microsoft.com,tom@talpey.com,trondmy@kernel.org,v-songbaohua@oppo.com,ying.huang@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 17:09:30 +0200
Message-ID: <2024062429-swinging-gully-4fc8@gregkh>
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
git cherry-pick -x 29433a17a79caa8680b9c0761f2b10502fda9ce3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062429-swinging-gully-4fc8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29433a17a79caa8680b9c0761f2b10502fda9ce3 Mon Sep 17 00:00:00 2001
From: Barry Song <baohua@kernel.org>
Date: Tue, 18 Jun 2024 19:22:58 +1200
Subject: [PATCH] cifs: drop the incorrect assertion in cifs_swap_rw()

Since commit 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS
swap-space"), we can plug multiple pages then unplug them all together.
That means iov_iter_count(iter) could be way bigger than PAGE_SIZE, it
actually equals the size of iov_iter_npages(iter, INT_MAX).

Note this issue has nothing to do with large folios as we don't support
THP_SWPOUT to non-block devices.

Fixes: 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS swap-space")
Reported-by: Christoph Hellwig <hch@lst.de>
Closes: https://lore.kernel.org/linux-mm/20240614100329.1203579-1-hch@lst.de/
Cc: NeilBrown <neilb@suse.de>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Steve French <sfrench@samba.org>
Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Chuanhua Han <hanchuanhua@oppo.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9d5c2440abfc..1e269e0bc75b 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3200,8 +3200,6 @@ static int cifs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t ret;
 
-	WARN_ON_ONCE(iov_iter_count(iter) != PAGE_SIZE);
-
 	if (iov_iter_rw(iter) == READ)
 		ret = netfs_unbuffered_read_iter_locked(iocb, iter);
 	else



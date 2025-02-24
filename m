Return-Path: <stable+bounces-118760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D617A41B10
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD897A6622
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E652505B8;
	Mon, 24 Feb 2025 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HW3n0tot"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3552505B1
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392959; cv=none; b=ZF/+/DJo6gjMN5Ikh9lB+h0dtqtpFkbzKdeDxu9hiNKUqLlAdSg44FCQNsFDY+oCK/i5SNIf8f41IMSjTj9mFYweDoJo3XEI5Ux3meC95mClnbZegsRkTtltdhdIn8usTo3k9c9SqXKYsWjDZhC1ihrs3cbsIu8lCHa+38ju6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392959; c=relaxed/simple;
	bh=0dw3tO0HsGLBKLEYo7b4Nxnw/zZGZtH3sw/XGhbvOZ4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MPArCatvyxEIg/XPA3d3AJFtxrxkiA++5KuvfM3AY62gxbVc5hxlrUlGXX5Zm1mbEfcKwmik8oFs7A2XhIUbeIuKhqrDrQpnmQTrLzMRB56W+NteyTAczQ87WMPipbZb3e7UAbE9mUlvOz3rmeT6vrY75VFiwGx6Kzp5uk70ecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HW3n0tot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2196C4CED6;
	Mon, 24 Feb 2025 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392959;
	bh=0dw3tO0HsGLBKLEYo7b4Nxnw/zZGZtH3sw/XGhbvOZ4=;
	h=Subject:To:Cc:From:Date:From;
	b=HW3n0totE3S4Q+QqGAaS4Qc830/K+7wEsSt/rvL3UdTo/QZpUDBg/i8vrkbphbPLv
	 EDRhdPZ4Vr4Q7pWG2SR5pbI+1ZWiosAviCq0Ip+ktpakwRrL5LSWKg4/bxUg1OFtkx
	 dmd04fENo1/2uG6SZRuj14iyA4AXYox1Us6BXXvI=
Subject: FAILED: patch "[PATCH] smb: client: fix chmod(2) regression with ATTR_READONLY" failed to apply to 6.6-stable tree
To: pc@manguebit.com,horst.reiterer@fabasoft.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:29:08 +0100
Message-ID: <2025022408-skincare-aide-8932@gregkh>
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
git cherry-pick -x 654292a0b264e9b8c51b98394146218a21612aa1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022408-skincare-aide-8932@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 654292a0b264e9b8c51b98394146218a21612aa1 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Sun, 16 Feb 2025 18:02:47 -0300
Subject: [PATCH] smb: client: fix chmod(2) regression with ATTR_READONLY

When the user sets a file or directory as read-only (e.g. ~S_IWUGO),
the client will set the ATTR_READONLY attribute by sending an
SMB2_SET_INFO request to the server in cifs_setattr_{,nounix}(), but
cifsInodeInfo::cifsAttrs will be left unchanged as the client will
only update the new file attributes in the next call to
{smb311_posix,cifs}_get_inode_info() with the new metadata filled in
@data parameter.

Commit a18280e7fdea ("smb: cilent: set reparse mount points as
automounts") mistakenly removed the @data NULL check when calling
is_inode_cache_good(), which broke the above case as the new
ATTR_READONLY attribute would end up not being updated on files with a
read lease.

Fix this by updating the inode whenever we have cached metadata in
@data parameter.

Reported-by: Horst Reiterer <horst.reiterer@fabasoft.com>
Closes: https://lore.kernel.org/r/85a16504e09147a195ac0aac1c801280@fabasoft.com
Fixes: a18280e7fdea ("smb: cilent: set reparse mount points as automounts")
Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 9cc31cf6ebd0..3261190e6f90 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1408,7 +1408,7 @@ int cifs_get_inode_info(struct inode **inode,
 	struct cifs_fattr fattr = {};
 	int rc;
 
-	if (is_inode_cache_good(*inode)) {
+	if (!data && is_inode_cache_good(*inode)) {
 		cifs_dbg(FYI, "No need to revalidate cached inode sizes\n");
 		return 0;
 	}
@@ -1507,7 +1507,7 @@ int smb311_posix_get_inode_info(struct inode **inode,
 	struct cifs_fattr fattr = {};
 	int rc;
 
-	if (is_inode_cache_good(*inode)) {
+	if (!data && is_inode_cache_good(*inode)) {
 		cifs_dbg(FYI, "No need to revalidate cached inode sizes\n");
 		return 0;
 	}



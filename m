Return-Path: <stable+bounces-8667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B7A81F81C
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 13:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4321F228D7
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E660E7475;
	Thu, 28 Dec 2023 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tft1jsiU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128C7461
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 12:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4DAC433C8;
	Thu, 28 Dec 2023 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703765429;
	bh=z/HH4KEkllwIqsU6Y15+vT6735DJfZ244M0hWzWc8JQ=;
	h=Subject:To:Cc:From:Date:From;
	b=tft1jsiUDKWbPNKMukDpYPEfJio3QU2N9vPUfkNHDdVGWLjjcX7Su1fdEvLg8/SOB
	 gl4+PFoRhP9+2o36LSYyRVHroyX9m2bjOMOBrLPiwoQScFHUqdmA7mhBpqw2OPL3PF
	 guhBO0OEvrvVPXikX89Uye73MGCCZE00ylAiCzIg=
Subject: FAILED: patch "[PATCH] fs: cifs: Fix atime update check" failed to apply to 5.10-stable tree
To: wozizhi@huawei.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 12:10:22 +0000
Message-ID: <2023122822-slimy-camping-f751@gregkh>
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
git cherry-pick -x 01fe654f78fd1ea4df046ef76b07ba92a35f8dbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122822-slimy-camping-f751@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

01fe654f78fd ("fs: cifs: Fix atime update check")
8f22ce708883 ("client: convert to new timestamp accessors")
9448765397b6 ("smb: convert to ctime accessor functions")
bc2390f2c884 ("cifs: update the ctime on a partial page write")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 01fe654f78fd1ea4df046ef76b07ba92a35f8dbe Mon Sep 17 00:00:00 2001
From: Zizhi Wo <wozizhi@huawei.com>
Date: Wed, 13 Dec 2023 10:23:53 +0800
Subject: [PATCH] fs: cifs: Fix atime update check

Commit 9b9c5bea0b96 ("cifs: do not return atime less than mtime") indicates
that in cifs, if atime is less than mtime, some apps will break.
Therefore, it introduce a function to compare this two variables in two
places where atime is updated. If atime is less than mtime, update it to
mtime.

However, the patch was handled incorrectly, resulting in atime and mtime
being exactly equal. A previous commit 69738cfdfa70 ("fs: cifs: Fix atime
update check vs mtime") fixed one place and forgot to fix another. Fix it.

Fixes: 9b9c5bea0b96 ("cifs: do not return atime less than mtime")
Cc: stable@vger.kernel.org
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index cf17e3dd703e..32a8525415d9 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -4671,7 +4671,7 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 	/* we do not want atime to be less than mtime, it broke some apps */
 	atime = inode_set_atime_to_ts(inode, current_time(inode));
 	mtime = inode_get_mtime(inode);
-	if (timespec64_compare(&atime, &mtime))
+	if (timespec64_compare(&atime, &mtime) < 0)
 		inode_set_atime_to_ts(inode, inode_get_mtime(inode));
 
 	if (PAGE_SIZE > rc)



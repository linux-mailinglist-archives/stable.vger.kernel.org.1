Return-Path: <stable+bounces-8664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AB081F819
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 13:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C131C2365C
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B356FDF;
	Thu, 28 Dec 2023 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XfjvkiP1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C76FD6
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 12:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0343DC433C7;
	Thu, 28 Dec 2023 12:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703765421;
	bh=uX/1jkFzfAeVa4MdslVNOco+LTQhuGKdA+ObJdmfwg0=;
	h=Subject:To:Cc:From:Date:From;
	b=XfjvkiP15MfmCFX+QLqr3k3IZmiuHzeEFKCWokaJqFTO+pdu69ccitMvAcL57MsO/
	 YjzaRGGc5dzQMvCstM1zUCGYn8jturR6k7LVIuVdNEq1ejJpk/bHCa7nLq0unGiXYw
	 4Xf9tpZT7njS9+XaAzW+AOhfNXKkqZOzQ0nNknbk=
Subject: FAILED: patch "[PATCH] fs: cifs: Fix atime update check" failed to apply to 6.6-stable tree
To: wozizhi@huawei.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 12:10:18 +0000
Message-ID: <2023122818-brute-scored-e2c7@gregkh>
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
git cherry-pick -x 01fe654f78fd1ea4df046ef76b07ba92a35f8dbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122818-brute-scored-e2c7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

01fe654f78fd ("fs: cifs: Fix atime update check")
8f22ce708883 ("client: convert to new timestamp accessors")

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



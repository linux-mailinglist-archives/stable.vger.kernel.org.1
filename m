Return-Path: <stable+bounces-5316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0393B80CA22
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A431C2106E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC73C06C;
	Mon, 11 Dec 2023 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TSuNkfLe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852D03BB5B
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 12:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ACBC433C8;
	Mon, 11 Dec 2023 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702298844;
	bh=cYL57jbHhytTaWxsGQ8aa0rD/t5vohf7IHBce5+hngY=;
	h=Subject:To:Cc:From:Date:From;
	b=TSuNkfLeSFKFcgj0wmpQi3UlGx6BsZK6fRV9dCFjekRjsyJNL9l4fJ7gxTJ04K0Vi
	 dZzuLf33WX36Z6rigPtmCTL5MZYdEaMOUHe55DDrr5JMcJSmm7UEv6zrRsWcaFO8ji
	 /SVl79Vwqy4bci073WBKHRgPjCcrFekJL++ZYNFQ=
Subject: FAILED: patch "[PATCH] cifs: Fix non-availability of dedup breaking generic/304" failed to apply to 5.4-stable tree
To: dhowells@redhat.com,darrick.wong@oracle.com,david@fromorbit.com,fengxiaoli0714@gmail.com,jlayton@kernel.org,nspmangalore@gmail.com,rohiths.msft@gmail.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Dec 2023 13:47:11 +0100
Message-ID: <2023121111-grieving-paced-f285@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 691a41d8da4b34fe72f09393505f55f28a8f34ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121111-grieving-paced-f285@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

691a41d8da4b ("cifs: Fix non-availability of dedup breaking generic/304")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 691a41d8da4b34fe72f09393505f55f28a8f34ec Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Mon, 4 Dec 2023 14:01:59 +0000
Subject: [PATCH] cifs: Fix non-availability of dedup breaking generic/304

Deduplication isn't supported on cifs, but cifs doesn't reject it, instead
treating it as extent duplication/cloning.  This can cause generic/304 to go
silly and run for hours on end.

Fix cifs to indicate EOPNOTSUPP if REMAP_FILE_DEDUP is set in
->remap_file_range().

Note that it's unclear whether or not commit b073a08016a1 is meant to cause
cifs to return an error if REMAP_FILE_DEDUP.

Fixes: b073a08016a1 ("cifs: fix that return -EINVAL when do dedupe operation")
Cc: stable@vger.kernel.org
Suggested-by: Dave Chinner <david@fromorbit.com>
cc: Xiaoli Feng <fengxiaoli0714@gmail.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Darrick Wong <darrick.wong@oracle.com>
cc: fstests@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/3876191.1701555260@warthog.procyon.org.uk/
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index c5fc0a35bb19..2131638f26d0 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1277,7 +1277,9 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	unsigned int xid;
 	int rc;
 
-	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
+	if (remap_flags & REMAP_FILE_DEDUP)
+		return -EOPNOTSUPP;
+	if (remap_flags & ~REMAP_FILE_ADVISORY)
 		return -EINVAL;
 
 	cifs_dbg(FYI, "clone range\n");



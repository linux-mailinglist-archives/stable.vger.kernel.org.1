Return-Path: <stable+bounces-3735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ACF8023DC
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFC29B209D8
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084A6DDC9;
	Sun,  3 Dec 2023 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H+ajR8b0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDF43D79
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 12:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177C4C433C7;
	Sun,  3 Dec 2023 12:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701607863;
	bh=oHs2kPX8HK61BU/agLFwHI1VdA9cb1kPVEY9Y8fNauY=;
	h=Subject:To:Cc:From:Date:From;
	b=H+ajR8b0D2d3Zg2VBu8Jdwk+8ybcpn6obep2CsMpK4ieGbLWcRImlA016Mp8r6XnT
	 qWNgX/JfMuaE/YAJdN89ye4HcQ9rppZoKNG8BSvJ1xbAq4BQLJAbewUVQysGO5/WWu
	 VCifMr7tALFB/s5/pkC898szKJqwCkPx185VlCaY=
Subject: FAILED: patch "[PATCH] cifs: Fix FALLOC_FL_INSERT_RANGE by setting i_size after EOF" failed to apply to 5.15-stable tree
To: dhowells@redhat.com,jlayton@kernel.org,nspmangalore@gmail.com,pc@manguebit.com,rohiths.msft@gmail.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 13:50:55 +0100
Message-ID: <2023120354-regulate-encourage-cb36@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 88010155f02b2c3b03c71609ba6ceeb457ece095
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120354-regulate-encourage-cb36@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

88010155f02b ("cifs: Fix FALLOC_FL_INSERT_RANGE by setting i_size after EOF moved")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 88010155f02b2c3b03c71609ba6ceeb457ece095 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Wed, 29 Nov 2023 16:56:18 +0000
Subject: [PATCH] cifs: Fix FALLOC_FL_INSERT_RANGE by setting i_size after EOF
 moved

Fix the cifs filesystem implementations of FALLOC_FL_INSERT_RANGE, in
smb3_insert_range(), to set i_size after extending the file on the server
and before we do the copy to open the gap (as we don't clean up the EOF
marker if the copy fails).

Fixes: 7fe6fe95b936 ("cifs: add FALLOC_FL_INSERT_RANGE support")
Cc: stable@vger.kernel.org
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index f1b0b2b11ab2..45931115f475 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3745,6 +3745,9 @@ static long smb3_insert_range(struct file *file, struct cifs_tcon *tcon,
 	if (rc < 0)
 		goto out_2;
 
+	truncate_setsize(inode, old_eof + len);
+	fscache_resize_cookie(cifs_inode_cookie(inode), i_size_read(inode));
+
 	rc = smb2_copychunk_range(xid, cfile, cfile, off, count, off + len);
 	if (rc < 0)
 		goto out_2;



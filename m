Return-Path: <stable+bounces-50515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7027A906AA6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A301F2248D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BDD1428F6;
	Thu, 13 Jun 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ygmBoYSd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D6DDB1
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276550; cv=none; b=sJEpWMVJLehQRnbwM8kGd00qZqjHD2LRrOx1DDjKJj9LIlLH3RBoX6pGHX/XTYHK7fNxMN8XROt/KStRbO7e2UAIj1VK2ypGaGibDyDeapS/wrnOqd/uWlZic182d0m+SF+jNgZoMo7+V31WPycrSuwAklsHyqJX35dsVnUVfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276550; c=relaxed/simple;
	bh=Y6Y9iLDa19mCqoZH5xnIDAz6Z9fmEdby8bzVQV7MC2Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UubjkTAvVqiSUgd+on9OBN+/cCQK3VuabRYN4OEqwB2ZSFNXHJO+Paj/gbq1Uqlg4x36aEvkRvmdpjLEwpQPmb27xOAgpYlTok4oq1utrkffDoMEXHi/dfpURo1Z2xpSGy4Ur7+HCqKtxq/DnaZK82DWI/5pHbd7iDXYHhoQ6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ygmBoYSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9664C4AF1A;
	Thu, 13 Jun 2024 11:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718276550;
	bh=Y6Y9iLDa19mCqoZH5xnIDAz6Z9fmEdby8bzVQV7MC2Y=;
	h=Subject:To:Cc:From:Date:From;
	b=ygmBoYSdyLgdzaXAvbfbivOxVRlIg1aXhpQmOEgfgfqKpUrkwXboDQeDbQNPsDdP2
	 w787IQTaGYncn85EaPjBQql2eaTGgfDCGcUIa5fVZpvawp9R6jc8naZXB1Ru4p1k4X
	 hLlYIxKTe3hgstF4ZiYW21GAcN0Gp15QRZXWYzoY=
Subject: FAILED: patch "[PATCH] cifs: fix creating sockets when using sfu mount options" failed to apply to 6.6-stable tree
To: stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 13:02:19 +0200
Message-ID: <2024061319-machine-lanky-74ba@gregkh>
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
git cherry-pick -x 518549c120e671c4906f77d1802b97e9b23f673a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061319-machine-lanky-74ba@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

518549c120e6 ("cifs: fix creating sockets when using sfu mount options")
c6ff459037b2 ("smb: client: instantiate when creating SFU files")
b0348e459c83 ("smb: client: introduce cifs_sfu_make_node()")
45e724022e27 ("smb: client: set correct file type from NFS reparse points")
539aad7f14da ("smb: client: introduce ->parse_reparse_point()")
ed3e0a149b58 ("smb: client: implement ->query_reparse_point() for SMB1")
72bc63f5e23a ("smb3: fix creating FIFOs when mounting with "sfu" mount option")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 518549c120e671c4906f77d1802b97e9b23f673a Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Wed, 29 May 2024 18:16:56 -0500
Subject: [PATCH] cifs: fix creating sockets when using sfu mount options

When running fstest generic/423 with sfu mount option, it
was being skipped due to inability to create sockets:

  generic/423  [not run] cifs does not support mknod/mkfifo

which can also be easily reproduced with their af_unix tool:

  ./src/af_unix /mnt1/socket-two bind: Operation not permitted

Fix sfu mount option to allow creating and reporting sockets.

Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index c46d418c1c0c..a2072ab9e586 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -2574,7 +2574,7 @@ typedef struct {
 
 
 struct win_dev {
-	unsigned char type[8]; /* IntxCHR or IntxBLK or LnxFIFO*/
+	unsigned char type[8]; /* IntxCHR or IntxBLK or LnxFIFO or LnxSOCK */
 	__le64 major;
 	__le64 minor;
 } __attribute__((packed));
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 262576573eb5..4a8aa1de9522 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -606,6 +606,10 @@ cifs_sfu_type(struct cifs_fattr *fattr, const char *path,
 				mnr = le64_to_cpu(*(__le64 *)(pbuf+16));
 				fattr->cf_rdev = MKDEV(mjr, mnr);
 			}
+		} else if (memcmp("LnxSOCK", pbuf, 8) == 0) {
+			cifs_dbg(FYI, "Socket\n");
+			fattr->cf_mode |= S_IFSOCK;
+			fattr->cf_dtype = DT_SOCK;
 		} else if (memcmp("IntxLNK", pbuf, 7) == 0) {
 			cifs_dbg(FYI, "Symlink\n");
 			fattr->cf_mode |= S_IFLNK;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 4ce6c3121a7e..c8e536540895 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4997,6 +4997,9 @@ static int __cifs_sfu_make_node(unsigned int xid, struct inode *inode,
 		pdev.major = cpu_to_le64(MAJOR(dev));
 		pdev.minor = cpu_to_le64(MINOR(dev));
 		break;
+	case S_IFSOCK:
+		strscpy(pdev.type, "LnxSOCK");
+		break;
 	case S_IFIFO:
 		strscpy(pdev.type, "LnxFIFO");
 		break;



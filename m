Return-Path: <stable+bounces-50514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9E7906AA5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61F61F22727
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664991428F6;
	Thu, 13 Jun 2024 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LCWNY7s8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0A7DDB1
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276542; cv=none; b=Bk26asLP2pY4mnYrCGcR2TWrlfVeY1uIuPPbbsZSI1TvJ3kaVcyE7Y/xej3FMt/N4Tk9ikPyo5ROGwpR1f84w/pg06Hye8dU0VMuk6n0D6I88ryjtU0F5rw23rlEyYVUDEz6Lpt5rwm8SN84HH6xn8698z4GAiGimmf9Bj45UGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276542; c=relaxed/simple;
	bh=nJCdI4cJdlHhbprlUWFbmdrNDxsOablLhFlaAAoiCCs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n+XWbZ7X+l5QDCk3+fRv0lMhbaHGNJ7ed1TZGN3YlKjPqj9rxEmb2pU1M79rFpD+spRSF7H9z2DZ7TAzyrZH8h87iFjZQKDGXCcA7f9bvEmeTacE2hgOrpJO6XqC0i9uiwuVuRO8AInXEn6Paq/59vGSv1JYR5XZinNZbJDYi5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LCWNY7s8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B0BC2BBFC;
	Thu, 13 Jun 2024 11:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718276541;
	bh=nJCdI4cJdlHhbprlUWFbmdrNDxsOablLhFlaAAoiCCs=;
	h=Subject:To:Cc:From:Date:From;
	b=LCWNY7s8LcC5cMJbPx3aYnf9BJcwiiESSfe9mdBoVxJowaDMEU3w4Fh8flMoD5NeY
	 IddEkLOMGL3Z5yEb/5zBlkd0nn8foAh3mKHSQn5cywsTTjWEOkD/Mkc4QpMxnGG1N5
	 TZ9k+2dUKHNmS4L/obMDmyr3c+8E+JJigkn+teKE=
Subject: FAILED: patch "[PATCH] cifs: fix creating sockets when using sfu mount options" failed to apply to 6.1-stable tree
To: stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 13:02:18 +0200
Message-ID: <2024061318-percolate-breeching-4de7@gregkh>
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
git cherry-pick -x 518549c120e671c4906f77d1802b97e9b23f673a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061318-percolate-breeching-4de7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

518549c120e6 ("cifs: fix creating sockets when using sfu mount options")
c6ff459037b2 ("smb: client: instantiate when creating SFU files")
b0348e459c83 ("smb: client: introduce cifs_sfu_make_node()")
45e724022e27 ("smb: client: set correct file type from NFS reparse points")
539aad7f14da ("smb: client: introduce ->parse_reparse_point()")
ed3e0a149b58 ("smb: client: implement ->query_reparse_point() for SMB1")
72bc63f5e23a ("smb3: fix creating FIFOs when mounting with "sfu" mount option")
a18280e7fdea ("smb: cilent: set reparse mount points as automounts")
9a49e221a641 ("smb: client: do not query reparse points twice on symlinks")
5f71ebc41294 ("smb: client: parse reparse point flag in create response")
348a04a8d113 ("smb: client: get rid of dfs code dep in namespace.c")
0a049935e47e ("smb: client: get rid of dfs naming in automount code")
561f82a3a24c ("smb: client: rename cifs_dfs_ref.c to namespace.c")
c5f44a3d5477 ("smb: client: make smb2_compound_op() return resp buffer on success")
8b4e285d8ce3 ("smb: client: move some params to cifs_open_info_data")
c071b34f62dd ("cifs: is_network_name_deleted should return a bool")
3ae872de4107 ("smb: client: fix shared DFS root mounts with different prefixes")
49024ec8795e ("smb: client: fix parsing of source mount option")
d439b29057e2 ("smb: client: fix broken file attrs with nodfs mounts")
33f736187d08 ("cifs: prevent use-after-free by freeing the cfile later")

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



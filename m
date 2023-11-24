Return-Path: <stable+bounces-122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB387F731D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DC81C20DAB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 11:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3CC1F95A;
	Fri, 24 Nov 2023 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ByfpT0S1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD021200B2
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30530C433C8;
	Fri, 24 Nov 2023 11:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700826856;
	bh=kx4pxmZsxHYNqtqbGs0PQut87dvVMnrvg94gv7nOXP0=;
	h=Subject:To:Cc:From:Date:From;
	b=ByfpT0S15D+5GEIZ0zfEIKLfJlDYNXE9qd9awCL/3YihgJzZXyo2ykH3pK45qjKpW
	 lfoobtlrJogweyk5eC2dAnnyp7iuqhwzsIWPTYZjk3bjiI8ggunuQcKzIhkysFBSPl
	 mUGGKzabeX20kWCKLCKl3s9eIyu4HtFMfSKqUdus=
Subject: FAILED: patch "[PATCH] smb3: allow dumping session and tcon id to improve stats" failed to apply to 6.1-stable tree
To: stfrench@microsoft.com,sprasad@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 11:54:15 +0000
Message-ID: <2023112415-attribute-dreamt-dc04@gregkh>
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
git cherry-pick -x de4eceab578ead12a71e5b5588a57e142bbe8ceb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112415-attribute-dreamt-dc04@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

de4eceab578e ("smb3: allow dumping session and tcon id to improve stats analysis and debugging")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
c19204cbd65c ("cifs: minor cleanup of some headers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From de4eceab578ead12a71e5b5588a57e142bbe8ceb Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Thu, 9 Nov 2023 15:28:12 -0600
Subject: [PATCH] smb3: allow dumping session and tcon id to improve stats
 analysis and debugging

When multiple mounts are to the same share from the same client it was not
possible to determine which section of /proc/fs/cifs/Stats (and DebugData)
correspond to that mount.  In some recent examples this turned out to  be
a significant problem when trying to analyze performance data - since
there are many cases where unless we know the tree id and session id we
can't figure out which stats (e.g. number of SMB3.1.1 requests by type,
the total time they take, which is slowest, how many fail etc.) apply to
which mount. The only existing loosely related ioctl CIFS_IOC_GET_MNT_INFO
does not return the information needed to uniquely identify which tcon
is which mount although it does return various flags and device info.

Add a cifs.ko ioctl CIFS_IOC_GET_TCON_INFO (0x800ccf0c) to return tid,
session id, tree connect count.

Cc: stable@vger.kernel.org
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifs_ioctl.h b/fs/smb/client/cifs_ioctl.h
index 332588e77c31..26327442e383 100644
--- a/fs/smb/client/cifs_ioctl.h
+++ b/fs/smb/client/cifs_ioctl.h
@@ -26,6 +26,11 @@ struct smb_mnt_fs_info {
 	__u64   cifs_posix_caps;
 } __packed;
 
+struct smb_mnt_tcon_info {
+	__u32	tid;
+	__u64	session_id;
+} __packed;
+
 struct smb_snapshot_array {
 	__u32	number_of_snapshots;
 	__u32	number_of_snapshots_returned;
@@ -108,6 +113,7 @@ struct smb3_notify_info {
 #define CIFS_IOC_NOTIFY _IOW(CIFS_IOCTL_MAGIC, 9, struct smb3_notify)
 #define CIFS_DUMP_FULL_KEY _IOWR(CIFS_IOCTL_MAGIC, 10, struct smb3_full_key_debug_info)
 #define CIFS_IOC_NOTIFY_INFO _IOWR(CIFS_IOCTL_MAGIC, 11, struct smb3_notify_info)
+#define CIFS_IOC_GET_TCON_INFO _IOR(CIFS_IOCTL_MAGIC, 12, struct smb_mnt_tcon_info)
 #define CIFS_IOC_SHUTDOWN _IOR('X', 125, __u32)
 
 /*
diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
index f7160003e0ed..73ededa8eba5 100644
--- a/fs/smb/client/ioctl.c
+++ b/fs/smb/client/ioctl.c
@@ -117,6 +117,20 @@ static long cifs_ioctl_copychunk(unsigned int xid, struct file *dst_file,
 	return rc;
 }
 
+static long smb_mnt_get_tcon_info(struct cifs_tcon *tcon, void __user *arg)
+{
+	int rc = 0;
+	struct smb_mnt_tcon_info tcon_inf;
+
+	tcon_inf.tid = tcon->tid;
+	tcon_inf.session_id = tcon->ses->Suid;
+
+	if (copy_to_user(arg, &tcon_inf, sizeof(struct smb_mnt_tcon_info)))
+		rc = -EFAULT;
+
+	return rc;
+}
+
 static long smb_mnt_get_fsinfo(unsigned int xid, struct cifs_tcon *tcon,
 				void __user *arg)
 {
@@ -414,6 +428,17 @@ long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg)
 			tcon = tlink_tcon(pSMBFile->tlink);
 			rc = smb_mnt_get_fsinfo(xid, tcon, (void __user *)arg);
 			break;
+		case CIFS_IOC_GET_TCON_INFO:
+			cifs_sb = CIFS_SB(inode->i_sb);
+			tlink = cifs_sb_tlink(cifs_sb);
+			if (IS_ERR(tlink)) {
+				rc = PTR_ERR(tlink);
+				break;
+			}
+			tcon = tlink_tcon(tlink);
+			rc = smb_mnt_get_tcon_info(tcon, (void __user *)arg);
+			cifs_put_tlink(tlink);
+			break;
 		case CIFS_ENUMERATE_SNAPSHOTS:
 			if (pSMBFile == NULL)
 				break;



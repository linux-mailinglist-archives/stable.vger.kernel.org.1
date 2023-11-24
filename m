Return-Path: <stable+bounces-1393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CAA7F7F6F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11A7B217CA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD05364C3;
	Fri, 24 Nov 2023 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ctsIlies"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A113A364A4;
	Fri, 24 Nov 2023 18:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304D3C433C8;
	Fri, 24 Nov 2023 18:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851286;
	bh=2WJt5NJGN7Q3m0aOpjeemFoVjNR7xShunb5DpWemYQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctsIliesmZa1cd91B9oiVePLrxmzF45q00YybcwhTLMMlBToB932IXO/Fa9OVMaMB
	 OQoI6XwABOTr088gAkywCLp5HUgRtGqCj33SoiYTmeEXWjORnl4ODnn/I8OVnzLQ+v
	 X5D8GyyD/UQFto9Rmk9hERAxmUYSlh/RKwDKGbyI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.5 388/491] smb3: allow dumping session and tcon id to improve stats analysis and debugging
Date: Fri, 24 Nov 2023 17:50:24 +0000
Message-ID: <20231124172036.260545403@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit de4eceab578ead12a71e5b5588a57e142bbe8ceb upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifs_ioctl.h |    6 ++++++
 fs/smb/client/ioctl.c      |   25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

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
--- a/fs/smb/client/ioctl.c
+++ b/fs/smb/client/ioctl.c
@@ -117,6 +117,20 @@ out_drop_write:
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
@@ -414,6 +428,17 @@ long cifs_ioctl(struct file *filep, unsi
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




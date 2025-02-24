Return-Path: <stable+bounces-118767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545A3A41B26
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9486A17407E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C662C18EB0;
	Mon, 24 Feb 2025 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XvK59kCt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721E2F37
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393080; cv=none; b=MQBe3dbFaDedBTh/QcolsNC0ghKjiRfb/8zbyEZbfXDVBNV0rujtqyyJCNUoQqRrjzVnVh9D/djaizG/lMC4a/NluK0gaZdY14EB2TANJ2sLlRkxlGG1DQdx4bcUx7+fmf4W9R1wpq9RuMo12XJjKJ9FqnjfSGTNRRBJmyLBOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393080; c=relaxed/simple;
	bh=oysNXrLon5S/NqLVF55ITQ2ApJMf/KhaKMVTd5xSUgk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uqbAqudiaFxRo+1Qh6yBAbjOGKRs6cePWjeHwbHC+buVdMBP5WpLqytTZogdF9mXjLPXDyiD6pxLowsF2qWxH1cmxDSqxscpZ/pFqApHYirVrV3mFJmuxjxaWpj/4hGbhqn9yi86lCx0nhPrCszT+ThsuHF6o/QxnkqV0PIQiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XvK59kCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB403C4CED6;
	Mon, 24 Feb 2025 10:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740393080;
	bh=oysNXrLon5S/NqLVF55ITQ2ApJMf/KhaKMVTd5xSUgk=;
	h=Subject:To:Cc:From:Date:From;
	b=XvK59kCtaWJUUSQSFBRer/hQHcK7keEKHx61l0XDkDCgc58mdXjWUebtEyAbkYvCM
	 MYanbIbvBdoMxsrFRR+Nw+HHLBQ8ZyDO/xCWjQBT5n0k2jBms3HSaYdoDMM45EViRh
	 HaeqBM0WFDVaLDCTEEdxI75JhJVoS0mOF3ygE1Io=
Subject: FAILED: patch "[PATCH] smb311: failure to open files of length 1040 when mounting" failed to apply to 5.4-stable tree
To: stfrench@microsoft.com,oleh.nyk@gmail.com,pc@manguebit.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:30:52 +0100
Message-ID: <2025022452-trance-mustang-a381@gregkh>
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
git cherry-pick -x 9df23801c83d3e12b4c09be39d37d2be385e52f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022452-trance-mustang-a381@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9df23801c83d3e12b4c09be39d37d2be385e52f9 Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Sun, 16 Feb 2025 22:17:54 -0600
Subject: [PATCH] smb311: failure to open files of length 1040 when mounting
 with SMB3.1.1 POSIX extensions

If a file size has bits 0x410 = ATTR_DIRECTORY | ATTR_REPARSE set
then during queryinfo (stat) the file is regarded as a directory
and subsequent opens can fail. A simple test example is trying
to open any file 1040 bytes long when mounting with "posix"
(SMB3.1.1 POSIX/Linux Extensions).

The cause of this bug is that Attributes field in smb2_file_all_info
struct occupies the same place that EndOfFile field in
smb311_posix_qinfo, and sometimes the latter struct is incorrectly
processed as if it was the first one.

Reported-by: Oleh Nykyforchyn <oleh.nyk@gmail.com>
Tested-by: Oleh Nykyforchyn <oleh.nyk@gmail.com>
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index bc06b8ae2ebd..cddeb2adbf4a 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -253,6 +253,7 @@ struct cifs_cred {
 struct cifs_open_info_data {
 	bool adjust_tz;
 	bool reparse_point;
+	bool contains_posix_file_info;
 	struct {
 		/* ioctl response buffer */
 		struct {
diff --git a/fs/smb/client/reparse.h b/fs/smb/client/reparse.h
index 5a753fec7e2c..c0be5ab45a78 100644
--- a/fs/smb/client/reparse.h
+++ b/fs/smb/client/reparse.h
@@ -99,14 +99,30 @@ static inline bool reparse_inode_match(struct inode *inode,
 
 static inline bool cifs_open_data_reparse(struct cifs_open_info_data *data)
 {
-	struct smb2_file_all_info *fi = &data->fi;
-	u32 attrs = le32_to_cpu(fi->Attributes);
+	u32 attrs;
 	bool ret;
 
-	ret = data->reparse_point || (attrs & ATTR_REPARSE);
-	if (ret)
-		attrs |= ATTR_REPARSE;
-	fi->Attributes = cpu_to_le32(attrs);
+	if (data->contains_posix_file_info) {
+		struct smb311_posix_qinfo *fi = &data->posix_fi;
+
+		attrs = le32_to_cpu(fi->DosAttributes);
+		if (data->reparse_point) {
+			attrs |= ATTR_REPARSE;
+			fi->DosAttributes = cpu_to_le32(attrs);
+		}
+
+	} else {
+		struct smb2_file_all_info *fi = &data->fi;
+
+		attrs = le32_to_cpu(fi->Attributes);
+		if (data->reparse_point) {
+			attrs |= ATTR_REPARSE;
+			fi->Attributes = cpu_to_le32(attrs);
+		}
+	}
+
+	ret = attrs & ATTR_REPARSE;
+
 	return ret;
 }
 
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 5dfb30b0a852..826b57a5a2a8 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -650,6 +650,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		switch (cmds[i]) {
 		case SMB2_OP_QUERY_INFO:
 			idata = in_iov[i].iov_base;
+			idata->contains_posix_file_info = false;
 			if (rc == 0 && cfile && cfile->symlink_target) {
 				idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
 				if (!idata->symlink_target)
@@ -673,6 +674,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			break;
 		case SMB2_OP_POSIX_QUERY_INFO:
 			idata = in_iov[i].iov_base;
+			idata->contains_posix_file_info = true;
 			if (rc == 0 && cfile && cfile->symlink_target) {
 				idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
 				if (!idata->symlink_target)
@@ -770,6 +772,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 				idata = in_iov[i].iov_base;
 				idata->reparse.io.iov = *iov;
 				idata->reparse.io.buftype = resp_buftype[i + 1];
+				idata->contains_posix_file_info = false; /* BB VERIFY */
 				rbuf = reparse_buf_ptr(iov);
 				if (IS_ERR(rbuf)) {
 					rc = PTR_ERR(rbuf);
@@ -791,6 +794,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		case SMB2_OP_QUERY_WSL_EA:
 			if (!rc) {
 				idata = in_iov[i].iov_base;
+				idata->contains_posix_file_info = false;
 				qi_rsp = rsp_iov[i + 1].iov_base;
 				data[0] = (u8 *)qi_rsp + le16_to_cpu(qi_rsp->OutputBufferOffset);
 				size[0] = le32_to_cpu(qi_rsp->OutputBufferLength);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index ec36bed54b0b..23e0c8be7fb5 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1001,6 +1001,7 @@ static int smb2_query_file_info(const unsigned int xid, struct cifs_tcon *tcon,
 		if (!data->symlink_target)
 			return -ENOMEM;
 	}
+	data->contains_posix_file_info = false;
 	return SMB2_query_info(xid, tcon, fid->persistent_fid, fid->volatile_fid, &data->fi);
 }
 
@@ -5146,7 +5147,7 @@ int __cifs_sfu_make_node(unsigned int xid, struct inode *inode,
 			     FILE_CREATE, CREATE_NOT_DIR |
 			     CREATE_OPTION_SPECIAL, ACL_NO_MODE);
 	oparms.fid = &fid;
-
+	idata.contains_posix_file_info = false;
 	rc = server->ops->open(xid, &oparms, &oplock, &idata);
 	if (rc)
 		goto out;



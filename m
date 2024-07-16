Return-Path: <stable+bounces-59862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D36932C26
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7562853FD
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1040219DFB3;
	Tue, 16 Jul 2024 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aS6Tqnz3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C219AD46;
	Tue, 16 Jul 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145132; cv=none; b=aDcljTJ62BoMSv8s0mOE22Tj50VJ74pS/WPk1TfDsOsH4X02fqT3uH+7/UFltuvkNDX5/EW+J4cUqXKx+zeL2HM9CdUxBuWCt8ywzYPoUdSNAgM/I0cXUJB+bcLdcbNqWETaJoF4CNIfMBotflILtFAF1vtTIAQDieCS4XQkaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145132; c=relaxed/simple;
	bh=D9MmMUgNZXfbMm+IwaBP3VOl/vRNpdbP86qvzraulto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3aOLznhTSeVSYsCmvFBUx9FG71CTHPHqvvMQRz0rCTkSHPXmNM+ETiEWw6J4HC0rep8QcTt4suoeXbEyj9LReUYWarkPSUDboNBipQimEP/MWQJl3U9ZZzbC8l8gBx8wV2jEy0zL8Fb/7Yuluu+yx5qu1Wvx101b4n4C2bF+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aS6Tqnz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408C8C116B1;
	Tue, 16 Jul 2024 15:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145132;
	bh=D9MmMUgNZXfbMm+IwaBP3VOl/vRNpdbP86qvzraulto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aS6Tqnz37wYcAtGtPTu7z68HfHF6zzaMqi8DFHVmo+QWIBmiRGmh3ItP1adV0aPas
	 +7McBKrb3ioDV2whCfMPAqnVv7CXqDkrB30+WXKM0mEgeS1mO3jR2FouLuz9FCuRS5
	 JP8uD5bFP3En+cDSKQcWXvS+0cLkz/OM/3naBM10=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yoonho Shin <yoonho.shin@samsung.com>,
	Hobin Woo <hobin.woo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.9 092/143] ksmbd: discard write access to the directory open
Date: Tue, 16 Jul 2024 17:31:28 +0200
Message-ID: <20240716152759.515830155@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
References: <20240716152755.980289992@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hobin Woo <hobin.woo@samsung.com>

commit e2e33caa5dc2eae7bddf88b22ce11ec3d760e5cd upstream.

may_open() does not allow a directory to be opened with the write access.
However, some writing flags set by client result in adding write access
on server, making ksmbd incompatible with FUSE file system. Simply, let's
discard the write access when opening a directory.

list_add corruption. next is NULL.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:26!
pc : __list_add_valid+0x88/0xbc
lr : __list_add_valid+0x88/0xbc
Call trace:
__list_add_valid+0x88/0xbc
fuse_finish_open+0x11c/0x170
fuse_open_common+0x284/0x5e8
fuse_dir_open+0x14/0x24
do_dentry_open+0x2a4/0x4e0
dentry_open+0x50/0x80
smb2_open+0xbe4/0x15a4
handle_ksmbd_work+0x478/0x5ec
process_one_work+0x1b4/0x448
worker_thread+0x25c/0x430
kthread+0x104/0x1d4
ret_from_fork+0x10/0x20

Cc: stable@vger.kernel.org
Signed-off-by: Yoonho Shin <yoonho.shin@samsung.com>
Signed-off-by: Hobin Woo <hobin.woo@samsung.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2051,15 +2051,22 @@ out_err1:
  * @access:		file access flags
  * @disposition:	file disposition flags
  * @may_flags:		set with MAY_ flags
+ * @is_dir:		is creating open flags for directory
  *
  * Return:      file open flags
  */
 static int smb2_create_open_flags(bool file_present, __le32 access,
 				  __le32 disposition,
-				  int *may_flags)
+				  int *may_flags,
+				  bool is_dir)
 {
 	int oflags = O_NONBLOCK | O_LARGEFILE;
 
+	if (is_dir) {
+		access &= ~FILE_WRITE_DESIRE_ACCESS_LE;
+		ksmbd_debug(SMB, "Discard write access to a directory\n");
+	}
+
 	if (access & FILE_READ_DESIRED_ACCESS_LE &&
 	    access & FILE_WRITE_DESIRE_ACCESS_LE) {
 		oflags |= O_RDWR;
@@ -3167,7 +3174,9 @@ int smb2_open(struct ksmbd_work *work)
 
 	open_flags = smb2_create_open_flags(file_present, daccess,
 					    req->CreateDisposition,
-					    &may_flags);
+					    &may_flags,
+		req->CreateOptions & FILE_DIRECTORY_FILE_LE ||
+		(file_present && S_ISDIR(d_inode(path.dentry)->i_mode)));
 
 	if (!test_tree_conn_flag(tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
 		if (open_flags & (O_CREAT | O_TRUNC)) {




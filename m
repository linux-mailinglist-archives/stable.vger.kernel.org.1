Return-Path: <stable+bounces-52569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE9290B889
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 19:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2380A285413
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B29718FC96;
	Mon, 17 Jun 2024 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wdjvNDkS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C618A93C
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646824; cv=none; b=a16Y8heZz3hNT6bKwpXtBjAXU4CxqhxVp+37O2YZAsxkS4TfQ0AlbkCcVkpE9Rd1D613iEGcKP+lbJHBayBUTyh9pWZLJDXY6ChPQ2Rf9mnV8FJ6ytHkxD/dLFHj7lhYgEwEPtsZi5cg/ZuLJzIyuigHSci9GuKAmJNVR/DxVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646824; c=relaxed/simple;
	bh=s9Y44Gg5VA/3nv2bi9+k7YFvaBNwDCPfawgRBpFJR/4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PMjIaRIvNwz9aBuPNyO0KEd6QiDKheJ37q1ILoaT57qUFLDv39JFZRoaxD3PV6ExADcAr0VIko7wQCvuaS7kzXAdvy+Ghpgr4x3F1jL+zg+RR0iMKcI+lEYTbbpsSjUR/6PTaSVf6b7WBPJuesC/1AfuBKBU5xAH33PRwuLftOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wdjvNDkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2553DC2BD10;
	Mon, 17 Jun 2024 17:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718646823;
	bh=s9Y44Gg5VA/3nv2bi9+k7YFvaBNwDCPfawgRBpFJR/4=;
	h=Subject:To:Cc:From:Date:From;
	b=wdjvNDkSKuzKLdQtPHbUOg5v+BCPT4PD4aQOy+Itv0LBkZ9mJQzzY92mikiuBwoaS
	 idH4ibAm71yW6WyQMcleC6Sj7LxI9b1BWg9p6ERoxbK0FRhehxqqYyDZX4L0rJP+Am
	 I3oUPon+UqCoCXrXuVHs1WbGZhSaq0Y6HMzAq5+Q=
Subject: FAILED: patch "[PATCH] ksmbd: move leading slash check to smb2_get_name()" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 19:53:32 +0200
Message-ID: <2024061732-skating-deceit-aae9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1cdeca6a7264021e20157de0baf7880ff0ced822
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061732-skating-deceit-aae9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

1cdeca6a7264 ("ksmbd: move leading slash check to smb2_get_name()")
c6cd2e8d2d9a ("ksmbd: fix potencial out-of-bounds when buffer offset is invalid")
a80a486d72e2 ("ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()")
6fc0a265e1b9 ("ksmbd: fix potential circular locking issue in smb2_set_ea()")
d10c77873ba1 ("ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()")
2e450920d58b ("ksmbd: move oplock handling after unlock parent dir")
864fb5d37163 ("ksmbd: fix possible deadlock in smb2_open")
5a7ee91d1154 ("ksmbd: fix race condition with fp")
e2b76ab8b5c9 ("ksmbd: add support for read compound")
e202a1e8634b ("ksmbd: no response from compound read")
2b57a4322b1b ("ksmbd: check if a mount point is crossed during path lookup")
7b7d709ef7cf ("ksmbd: add missing compound request handing in some commands")
81a94b27847f ("ksmbd: use kvzalloc instead of kvmalloc")
40b268d384a2 ("ksmbd: add mnt_want_write to ksmbd vfs functions")
6fe55c2799bc ("ksmbd: call putname after using the last component")
df14afeed2e6 ("ksmbd: fix uninitialized pointer read in smb2_create_link()")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
02f76c401d17 ("ksmbd: fix global-out-of-bounds in smb2_find_context_vals")
30210947a343 ("ksmbd: fix racy issue under cocurrent smb2 tree disconnect")
abcc506a9a71 ("ksmbd: fix racy issue from smb2 close and logoff with multichannel")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cdeca6a7264021e20157de0baf7880ff0ced822 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 10 Jun 2024 23:06:19 +0900
Subject: [PATCH] ksmbd: move leading slash check to smb2_get_name()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the directory name in the root of the share starts with
character like 镜(0x955c) or Ṝ(0x1e5c), it (and anything inside)
cannot be accessed. The leading slash check must be checked after
converting unicode to nls string.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b6c5a8ea3887..f79d06d2d655 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -630,6 +630,12 @@ smb2_get_name(const char *src, const int maxlen, struct nls_table *local_nls)
 		return name;
 	}
 
+	if (*name == '\\') {
+		pr_err("not allow directory name included leading slash\n");
+		kfree(name);
+		return ERR_PTR(-EINVAL);
+	}
+
 	ksmbd_conv_path_to_unix(name);
 	ksmbd_strip_last_slash(name);
 	return name;
@@ -2842,20 +2848,11 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 	if (req->NameLength) {
-		if ((req->CreateOptions & FILE_DIRECTORY_FILE_LE) &&
-		    *(char *)req->Buffer == '\\') {
-			pr_err("not allow directory name included leading slash\n");
-			rc = -EINVAL;
-			goto err_out2;
-		}
-
 		name = smb2_get_name((char *)req + le16_to_cpu(req->NameOffset),
 				     le16_to_cpu(req->NameLength),
 				     work->conn->local_nls);
 		if (IS_ERR(name)) {
 			rc = PTR_ERR(name);
-			if (rc != -ENOMEM)
-				rc = -ENOENT;
 			name = NULL;
 			goto err_out2;
 		}



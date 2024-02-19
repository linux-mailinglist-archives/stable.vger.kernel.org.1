Return-Path: <stable+bounces-20639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C385AAA8
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD91B2101F
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCC447F63;
	Mon, 19 Feb 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N4M38huV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B778446A1
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366327; cv=none; b=a0QA9ijuUhUufKTcdSQpXOcGjiy6yhmmAXC3LYnYnYqByV+WZhYQJwGI8qCaaYN3sBe4wxKzgqKjgC98nT8QErflgoeMRBcCIHjMMhRj8xrxyCugnSd4ztCv0OkXxekftFI6Ezt83Rlp9sbqegg0LOxRCxfOw/afAUXCCPZzvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366327; c=relaxed/simple;
	bh=jRJBuG+l5OlkSSDs0gkA5lp+Df5sL+jcb9DsTtdP0Sg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ckCUwKE5IKHEWcV2CvyaB5UskwLSuzbG4KDF25jZ8gEMCcQQsTLfJYXf4YUyRjq5hShk1qf7diYQL1CmN6dGxmfjsI42psQlR49QD21XLtcOTypAkg+ebPDk1oYIJTA4Prt52o72YScO6/Dh1jsaATYkZhM2LrXJsioLLzfXQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N4M38huV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5FDC43390;
	Mon, 19 Feb 2024 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366327;
	bh=jRJBuG+l5OlkSSDs0gkA5lp+Df5sL+jcb9DsTtdP0Sg=;
	h=Subject:To:Cc:From:Date:From;
	b=N4M38huVYcJ89z2iKvOYcFoBSd4exxjEP88L5RaqSEPWTUVVFAzb/XrLdcE2JtId8
	 7mqHwUK20dZaZH7cpM/udtBdCTtjbhbOUcO3VtY1V5/DF1W+TrfR77z43f1HlpIXPT
	 t5y14KlH2TC4K1WdWbcjbAwCSg9nllkp6ElDq+5s=
Subject: FAILED: patch "[PATCH] ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails" failed to apply to 5.15-stable tree
To: pchelkin@ispras.ru,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:11:54 +0100
Message-ID: <2024021954-gallows-product-204d@gregkh>
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
git cherry-pick -x 108a020c64434fed4b69762879d78cd24088b4c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021954-gallows-product-204d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

108a020c6443 ("ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails")
1903e6d05781 ("ksmbd: fix potential double free on smb2_read_pipe() error path")
e2b76ab8b5c9 ("ksmbd: add support for read compound")
e202a1e8634b ("ksmbd: no response from compound read")
7b7d709ef7cf ("ksmbd: add missing compound request handing in some commands")
81a94b27847f ("ksmbd: use kvzalloc instead of kvmalloc")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
30210947a343 ("ksmbd: fix racy issue under cocurrent smb2 tree disconnect")
abcc506a9a71 ("ksmbd: fix racy issue from smb2 close and logoff with multichannel")
ea174a918939 ("ksmbd: destroy expired sessions")
f5c779b7ddbd ("ksmbd: fix racy issue from session setup and logoff")
74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
34e8ccf9ce24 ("ksmbd: set NegotiateContextCount once instead of every inc")
42bc6793e452 ("Merge tag 'pull-lock_rename_child' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs into ksmbd-for-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 108a020c64434fed4b69762879d78cd24088b4c7 Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Mon, 5 Feb 2024 14:19:16 +0300
Subject: [PATCH] ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails

ksmbd_iov_pin_rsp_read() doesn't free the provided aux buffer if it
fails. Seems to be the caller's responsibility to clear the buffer in
error case.

Found by Linux Verification Center (linuxtesting.org).

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ba7a72a6a4f4..0c97d3c86072 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6173,8 +6173,10 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
 					     offsetof(struct smb2_read_rsp, Buffer),
 					     aux_payload_buf, nbytes);
-		if (err)
+		if (err) {
+			kvfree(aux_payload_buf);
 			goto out;
+		}
 		kvfree(rpc_resp);
 	} else {
 		err = ksmbd_iov_pin_rsp(work, (void *)rsp,
@@ -6384,8 +6386,10 @@ int smb2_read(struct ksmbd_work *work)
 	err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
 				     offsetof(struct smb2_read_rsp, Buffer),
 				     aux_payload_buf, nbytes);
-	if (err)
+	if (err) {
+		kvfree(aux_payload_buf);
 		goto out;
+	}
 	ksmbd_fd_put(work, fp);
 	return 0;
 



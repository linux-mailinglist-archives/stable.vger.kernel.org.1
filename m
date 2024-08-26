Return-Path: <stable+bounces-70162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F25F595EFE6
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 13:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317F91C215E2
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BCE1547D8;
	Mon, 26 Aug 2024 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PoH5Oqnd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B253153812
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672296; cv=none; b=Vih5mGvodPM9XY8PbQebazTzam7Jca4NS4BFKEgWC+2p57iM/B8wYG4JwVdO77l86kzvClEgF05NNnP5gWEcCxW3XbJ7IXqDlZroBgVf9aI6SvgwOWbhSbhwDkgUdg7wIankkcDvy9nExyzyNPrnx/BYBUPVzSsLk0yLp9Z6TxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672296; c=relaxed/simple;
	bh=BdZ3f3uYWlkdSBG0mExCAxWB6hN/eJ53d6nfgZkXuJU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LrJ9sdwBZYpPZyGgQ/4OGnx1PkEPcO6lwcrDgS/UdFQwF+qYZhf/1bnd332fGImrNUiIgWayuPePa0f0NfFE/fugfni1f/jY0yEcrGVocuOhI3uMirzITbvys7ybzZ0nRcvulCJJI2oXS//KKjJ2Cb2vLDjH5r5DqwLT4OBmlOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PoH5Oqnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B5AC51400;
	Mon, 26 Aug 2024 11:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724672296;
	bh=BdZ3f3uYWlkdSBG0mExCAxWB6hN/eJ53d6nfgZkXuJU=;
	h=Subject:To:Cc:From:Date:From;
	b=PoH5OqndcpKhK/54k+jjtMS6pa6fAsl0RYWXH2Ay8TIvmvv2pm6Psub7jUiEs+oCN
	 nd/iyYZ239DvAl7uNqsyKi1x0lFxre4RCEqESaR1vrp29V+dty4ByhqS0l6NwLk7g8
	 rFuBqUDpejYaD2G8aYBeqD+kRP4z9kOBo5h/Fvz0=
Subject: FAILED: patch "[PATCH] ksmbd: the buffer of smb2 query dir response has at least 1" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 13:38:04 +0200
Message-ID: <2024082604-depose-iphone-7d55@gregkh>
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
git cherry-pick -x ce61b605a00502c59311d0a4b1f58d62b48272d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082604-depose-iphone-7d55@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

ce61b605a005 ("ksmbd: the buffer of smb2 query dir response has at least 1 byte")
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

From ce61b605a00502c59311d0a4b1f58d62b48272d0 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 20 Aug 2024 22:07:38 +0900
Subject: [PATCH] ksmbd: the buffer of smb2 query dir response has at least 1
 byte

When STATUS_NO_MORE_FILES status is set to smb2 query dir response,
->StructureSize is set to 9, which mean buffer has 1 byte.
This issue occurs because ->Buffer[1] in smb2_query_directory_rsp to
flex-array.

Fixes: eb3e28c1e89b ("smb3: Replace smb2pdu 1-element arrays with flex-arrays")
Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 0bc9edf22ba4..e9204180919e 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4409,7 +4409,8 @@ int smb2_query_dir(struct ksmbd_work *work)
 		rsp->OutputBufferLength = cpu_to_le32(0);
 		rsp->Buffer[0] = 0;
 		rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
-				       sizeof(struct smb2_query_directory_rsp));
+				       offsetof(struct smb2_query_directory_rsp, Buffer)
+				       + 1);
 		if (rc)
 			goto err_out;
 	} else {



Return-Path: <stable+bounces-100324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950F99EAB49
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BD02811CD
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8664D230D36;
	Tue, 10 Dec 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wELIO3OD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B2230D2B
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821544; cv=none; b=mPjFWpWqsiKY/gI9S/NpVebiwBMYpXKPjwfmGovOWNXm+RKXrxfHS/UZ+Ch6uhgisQg4I52/5jBoDYbvJy39Pdfd11pR1y9jBpxCiw9sjYDhKdPOzYZItkEwCKRVnFUHFrw27MeDkYGDtu5FnkXhXxH1sOXCl5SNbheig3BGSYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821544; c=relaxed/simple;
	bh=LFWgODuLWJDOmPt/dorPRGL6eUC4UpFSfg4mRkVoUMU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jk0Ms2NDeIw69TXq4/IqhXQ9XnubzTBXoIZqrPYsi/7wTnmORKXg/zygJ0Y54FKXtBLVzbfBITiydkQPyQCe8TB6p+Y82Wkp37X/kWTW0My861Bg54L9eQS0Ou7LIpXQFQ7n6m4y/05QgawogSE4NCiGXyIStrf1gOhIyxFu6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wELIO3OD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32A2C4CEDD;
	Tue, 10 Dec 2024 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733821544;
	bh=LFWgODuLWJDOmPt/dorPRGL6eUC4UpFSfg4mRkVoUMU=;
	h=Subject:To:Cc:From:Date:From;
	b=wELIO3ODZHeB7xblb/y6//DIqjvDrLVuKmYVfiNxmbcDkYajIzcBPCDBnBcwqR/9k
	 GH7Q4VE67YS6z9PC9NfqopOyYov1i6/VVlZgBPQZXXR2iiUJHb0tX5tIHG0lLqsPKg
	 CuenWeRbIwfqh7rNcB+Dduby7jGiqjdqri1f6PIk=
Subject: FAILED: patch "[PATCH] ksmbd: fix Out-of-Bounds Write in ksmbd_vfs_stream_write" failed to apply to 5.15-stable tree
To: jordyzomer@google.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:05:08 +0100
Message-ID: <2024121007-alongside-neuter-46d3@gregkh>
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
git cherry-pick -x 313dab082289e460391c82d855430ec8a28ddf81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121007-alongside-neuter-46d3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 313dab082289e460391c82d855430ec8a28ddf81 Mon Sep 17 00:00:00 2001
From: Jordy Zomer <jordyzomer@google.com>
Date: Thu, 28 Nov 2024 09:33:25 +0900
Subject: [PATCH] ksmbd: fix Out-of-Bounds Write in ksmbd_vfs_stream_write

An offset from client could be a negative value, It could allows
to write data outside the bounds of the allocated buffer.
Note that this issue is coming when setting
'vfs objects = streams_xattr parameter' in ksmbd.conf.

Cc: stable@vger.kernel.org # v5.15+
Reported-by: Jordy Zomer <jordyzomer@google.com>
Signed-off-by: Jordy Zomer <jordyzomer@google.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7b6a3952f228..23879555880f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6882,6 +6882,8 @@ int smb2_write(struct ksmbd_work *work)
 	}
 
 	offset = le64_to_cpu(req->Offset);
+	if (offset < 0)
+		return -EINVAL;
 	length = le32_to_cpu(req->Length);
 
 	if (req->Channel == SMB2_CHANNEL_RDMA_V1 ||



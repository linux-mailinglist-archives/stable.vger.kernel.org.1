Return-Path: <stable+bounces-8040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BB281A438
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8216B26AE4
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E044A99F;
	Wed, 20 Dec 2023 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IyEZuLPv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF64A9B6;
	Wed, 20 Dec 2023 16:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862C7C433C8;
	Wed, 20 Dec 2023 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088743;
	bh=/W/RdHLWN699GX9ok1lpYYe1v/7qqZU7qG5Y4ds+RXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyEZuLPvD3h+EyNbbj1EOUlA36kQnpzMe7MajzURWflrg7+VKTjuaW7IYYG5XXI2Q
	 AstfL6XQiOFLKxB5gMnRn/4/qkhagIItDpslaG/aJdDtcgDwgu1B9uFja6iTz1i1qH
	 kqgs6Soo2Ub+Y7V9Lo11O9dhJqa289wXxDSj56vk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 043/159] ksmbd: remove duplicate flag set in smb2_write
Date: Wed, 20 Dec 2023 17:08:28 +0100
Message-ID: <20231220160933.318317744@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit 745bbc0995c25917dfafb645b8efb29813ef9e0b ]

The writethrough flag is set again if is_rdma_channel is false.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6564,6 +6564,7 @@ int smb2_write(struct ksmbd_work *work)
 		goto out;
 	}
 
+	ksmbd_debug(SMB, "flags %u\n", le32_to_cpu(req->Flags));
 	if (le32_to_cpu(req->Flags) & SMB2_WRITEFLAG_WRITE_THROUGH)
 		writethrough = true;
 
@@ -6577,10 +6578,6 @@ int smb2_write(struct ksmbd_work *work)
 		data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
 				    le16_to_cpu(req->DataOffset));
 
-		ksmbd_debug(SMB, "flags %u\n", le32_to_cpu(req->Flags));
-		if (le32_to_cpu(req->Flags) & SMB2_WRITEFLAG_WRITE_THROUGH)
-			writethrough = true;
-
 		ksmbd_debug(SMB, "filename %pd, offset %lld, len %zu\n",
 			    fp->filp->f_path.dentry, offset, length);
 		err = ksmbd_vfs_write(work, fp, data_buf, length, &offset,




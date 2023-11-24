Return-Path: <stable+bounces-1709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448FB7F80FD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EDFB21B4D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDD833CFD;
	Fri, 24 Nov 2023 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ekvbZoI5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1842E64F;
	Fri, 24 Nov 2023 18:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3848AC433C8;
	Fri, 24 Nov 2023 18:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852079;
	bh=HFdyrGPNcHm2VzTXAXUg7Q//XSuu0zlK+9M5zfxd2as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekvbZoI5uzPyhXv47HTUvng2PU1wOuWczWBkAEGnmLsqGroD8/k8PCFVIaJ75OLur
	 ZEMQNaxpyu/Qadh11gPxbeLEzX/8SyNkYsAIVP90cf+2FEtbx2ZwTeQpE6xJtJJKov
	 nnomnQ9ktBmdcam+yZPsi0dIf2PzlyGJ55ZS7K/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Morris <rtm@csail.mit.edu>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 211/372] ksmbd: handle malformed smb1 message
Date: Fri, 24 Nov 2023 17:49:58 +0000
Message-ID: <20231124172017.504196679@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 5a5409d90bd05f87fe5623a749ccfbf3f7c7d400 upstream.

If set_smb1_rsp_status() is not implemented, It will cause NULL pointer
dereferece error when client send malformed smb1 message.
This patch add set_smb1_rsp_status() to ignore malformed smb1 message.

Cc: stable@vger.kernel.org
Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb_common.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -372,11 +372,22 @@ static int smb1_allocate_rsp_buf(struct
 	return 0;
 }
 
+/**
+ * set_smb1_rsp_status() - set error type in smb response header
+ * @work:	smb work containing smb response header
+ * @err:	error code to set in response
+ */
+static void set_smb1_rsp_status(struct ksmbd_work *work, __le32 err)
+{
+	work->send_no_response = 1;
+}
+
 static struct smb_version_ops smb1_server_ops = {
 	.get_cmd_val = get_smb1_cmd_val,
 	.init_rsp_hdr = init_smb1_rsp_hdr,
 	.allocate_rsp_buf = smb1_allocate_rsp_buf,
 	.check_user_session = smb1_check_user_session,
+	.set_rsp_status = set_smb1_rsp_status,
 };
 
 static int smb1_negotiate(struct ksmbd_work *work)




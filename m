Return-Path: <stable+bounces-7776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AF9817638
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CCF1C227B3
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F16F5A866;
	Mon, 18 Dec 2023 15:43:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C734FF9F
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c68da9d639so1295912a12.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914196; x=1703518996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75ILOm/rnfdB4OBOhWFz8EUQZsOuUnqjfiJu9cGyLCY=;
        b=LCrkIrrKchQVzJcCglXQX6GuSEVXG+RhnWRZshprWwp9Dqk0BdtbWV1eo9gE8ClDX3
         f2thMiXKKApEe73FeyJSeIg02RjUY5ZdELVo3aA/orqpUThxE15SdMvOHXoPbNAMAS61
         YzJsKRS5sXEP1/gz2Hj/KVChiswSMUOJjn4P8HVX3kaDeI2UER6TC2hsB2WR1qT21EEp
         YK0wVZkHw9av8neJxKZDwrGBuiqZrzFjYjSiGpYADLkIW7iKzLUvbMPeW8ldDo4Xov9S
         PRo/UyDkACjSDqPlyM+RFrJYjnmOm/43km6jSjMzJe0PjohF2f5LN4zeIlbx5KzuI4nZ
         I/Wg==
X-Gm-Message-State: AOJu0Yw08Wch+V/X4snwCFXdVoJC1PrvXk1gRMwWIyYl/Kv4FdV1M+5z
	wB6QXo9LVPd6Hs/7ZIpCNYU=
X-Google-Smtp-Source: AGHT+IFNXLi4wnK9OVfBnAOcGp7JoJntchgT8JoxuTk47XcOghIvwFAKEQFBQhWFgyeqnXGeZauEog==
X-Received: by 2002:a17:90b:4a41:b0:28b:228b:9bb1 with SMTP id lb1-20020a17090b4a4100b0028b228b9bb1mr2369891pjb.16.1702914196056;
        Mon, 18 Dec 2023 07:43:16 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:43:15 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Robert Morris <rtm@csail.mit.edu>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 147/154] ksmbd: handle malformed smb1 message
Date: Tue, 19 Dec 2023 00:34:47 +0900
Message-Id: <20231218153454.8090-148-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 5a5409d90bd05f87fe5623a749ccfbf3f7c7d400 ]

If set_smb1_rsp_status() is not implemented, It will cause NULL pointer
dereferece error when client send malformed smb1 message.
This patch add set_smb1_rsp_status() to ignore malformed smb1 message.

Cc: stable@vger.kernel.org
Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb_common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index 894bf71218b6..d160363c09eb 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -366,11 +366,22 @@ static int smb1_allocate_rsp_buf(struct ksmbd_work *work)
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
-- 
2.25.1



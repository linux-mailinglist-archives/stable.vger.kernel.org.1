Return-Path: <stable+bounces-7762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16021817626
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997ECB24282
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7C274E11;
	Mon, 18 Dec 2023 15:42:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06ED3D546
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c690c3d113so2619344a12.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914149; x=1703518949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DM71LrcUPHVwRs/R19j9oEIui4BBhU2GlzpKZxtTVA=;
        b=XDhTxzZkPFK0E+/cH5MGn1xtyyMtkvsZOy4zLmwYZpS9cid1xvHtVPUyfrb5DDf8BG
         pcPRw68zK513WcJzK81h8t5o+raoNsGII6XDE3ffw2qTLeBaBAJ4cLM+812SGlET9lZH
         EBhxgJBdYkmHuJTNLBqQosOWDBAgWgUV996VPzQHQdMBzSb9w1woFZ6BzKOtBw0BkEHE
         baG9yI0al9YaBUWjwR0E0+vx0J6A74FxJjm0M1of4aDSvbFHazFqP7GDlp9szQIR46AH
         XthNdHGFCgHF3hqSTrrE/7eIMnbzAvp25wEpay5PbWvOr44NqrKGWeB5OnwM1YUyn2LL
         KAHg==
X-Gm-Message-State: AOJu0YzUohl39meei8/Xb8f/wPpmV6C+rUCjDkT2fMNVsBlyfyJYj5Er
	oFAcG1HX2hyEIerHzusjRd0=
X-Google-Smtp-Source: AGHT+IF4rNWe7wM4x8z464ZycPkLDAirCkJS6BDN/1QP8rdRWOhoA7GWWKSpARmQqWAL8SiWQMq+HQ==
X-Received: by 2002:a17:90a:aa82:b0:28a:ddfc:8b0 with SMTP id l2-20020a17090aaa8200b0028addfc08b0mr5667281pjq.33.1702914149082;
        Mon, 18 Dec 2023 07:42:29 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:28 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	luosili <rootlab@huawei.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 133/154] ksmbd: fix race condition from parallel smb2 logoff requests
Date: Tue, 19 Dec 2023 00:34:33 +0900
Message-Id: <20231218153454.8090-134-linkinjeon@kernel.org>
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

[ Upstream commit 7ca9da7d873ee8024e9548d3366101c2b6843eab ]

If parallel smb2 logoff requests come in before closing door, running
request count becomes more than 1 even though connection status is set to
KSMBD_SESS_NEED_RECONNECT. It can't get condition true, and sleep forever.
This patch fix race condition problem by returning error if connection
status was already set to KSMBD_SESS_NEED_RECONNECT.

Reported-by: luosili <rootlab@huawei.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 2f1ffd3bf2fb..924b561e8c81 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2164,17 +2164,17 @@ int smb2_session_logoff(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "request\n");
 
-	sess_id = le64_to_cpu(req->hdr.SessionId);
-
-	rsp->StructureSize = cpu_to_le16(4);
-	err = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_logoff_rsp));
-	if (err) {
-		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+	ksmbd_conn_lock(conn);
+	if (!ksmbd_conn_good(conn)) {
+		ksmbd_conn_unlock(conn);
+		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
 		smb2_set_err_rsp(work);
-		return err;
+		return -ENOENT;
 	}
-
+	sess_id = le64_to_cpu(req->hdr.SessionId);
 	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_RECONNECT);
+	ksmbd_conn_unlock(conn);
+
 	ksmbd_close_session_fds(work);
 	ksmbd_conn_wait_idle(conn, sess_id);
 
@@ -2196,6 +2196,14 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	ksmbd_free_user(sess->user);
 	sess->user = NULL;
 	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_NEGOTIATE);
+
+	rsp->StructureSize = cpu_to_le16(4);
+	err = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_logoff_rsp));
+	if (err) {
+		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+		smb2_set_err_rsp(work);
+		return err;
+	}
 	return 0;
 }
 
-- 
2.25.1



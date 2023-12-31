Return-Path: <stable+bounces-9080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 280C8820A21
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A9F1F22044
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576DF17F4;
	Sun, 31 Dec 2023 07:16:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239B17D3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2044ecf7035so3721027fac.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006984; x=1704611784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pszLq1Uv0o4KxKWXSYQYRFiLalYsjCQ1VoR5K5iTWYM=;
        b=LVm8ZmI/o5LNwhcZG32nqVIPvkE22n6tDKygUMUkcF4kipmXIaHnaCMrXppe8Zjkdm
         uhqQDL8PIe+cnQDxMQ1nvsUhpNhhX2ZBxnsKAjgiAry8e4EBffAdJ1O94/yXknNH0ydy
         sZGgOWtdeQ/4VDHBL2/Vm1gf1uLfugjNZ1mo2RxTXu+NBk69nq4yL5IcmUysieo8iip4
         F5kFI/AihiRuMZKzr5di/QATJAFCj8xArOaf+fkqeHlTw2qOQ5vz0BTv+i/uec+ww2IF
         dY9HhGsXSF3Jxssq1/YB6o+znpAOmB72IJf6W5ntNPENGlJckPVY+eopL9ir9jTQ3nxQ
         KsJA==
X-Gm-Message-State: AOJu0YygA2eE0QQkhdxhK6RQsxz0izbgh1JHVbVqR4GptD1E7ffxwRyB
	GX4WMWPQD9kOWzU+ZCJm9IE=
X-Google-Smtp-Source: AGHT+IE9/D8vTj0z4j7clBmrOBleQvqdtD0GdbWgyjGoPNd0pIHfb7S/J+K+lkdMtsyA6kz/HznaBw==
X-Received: by 2002:a05:6870:2307:b0:203:f6b9:993e with SMTP id w7-20020a056870230700b00203f6b9993emr18018079oao.96.1704006984166;
        Sat, 30 Dec 2023 23:16:24 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:23 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	luosili <rootlab@huawei.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 46/73] ksmbd: fix race condition from parallel smb2 logoff requests
Date: Sun, 31 Dec 2023 16:13:05 +0900
Message-Id: <20231231071332.31724-47-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
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
 fs/smb/server/smb2pdu.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 94213d0fd95f..805b51b815bd 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
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



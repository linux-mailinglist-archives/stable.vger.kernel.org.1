Return-Path: <stable+bounces-7646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCCC81757F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669AAB235AB
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B585BF8E;
	Mon, 18 Dec 2023 15:36:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E24238F
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b4d49293fso626305a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913773; x=1703518573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAgkP2rDMGJ7ftQXPz6WBf7sJ2jWPGma683jK/SvY/k=;
        b=CA62HLKBbnziJWeoCBP+Spu1552SaD6VBEg4HeeAat02V3SzFPMc17gJbig6ZXx778
         ifQSJPFMj09BXz8R7JIA9rxXBbu6gft8WKvofYDAPhefHOhU4FKH6IhBYXXiL4WISgvo
         HuEg4i38ylbV3/4+3ewgq6LsUP/o99ZDO9H5v6+19J77nzCGXSdjUGJUHU6Ns9ZJqrG2
         74HyNDgJ0AXnCiUE5Oe8gH8u2suC+Y6CfSckeOFE7D43cGEhPZOViPG7BZKyNWULIJid
         RkXgSwm9ngLrpBrMV87wHkDK3jrpbNhJ9DyLKVeAUX7h/s7kWfwNrwn7RLh5snaycY7l
         aBqg==
X-Gm-Message-State: AOJu0Yz+2bfyxrFGDrm43NGPgeCHcEcp1db0IqeKPSrY23N6CotvSIM2
	8JXXK9sbXOLTse2kKZhN+fs=
X-Google-Smtp-Source: AGHT+IGIAkEYPpBgKcc4WFoFNx2/PE/xw+lXmtM8zUDZ2WOB+FINsvMWeDCiuNR+fMmaQlyBnE2Now==
X-Received: by 2002:a17:90a:db0c:b0:28b:4010:1df7 with SMTP id g12-20020a17090adb0c00b0028b40101df7mr1246586pjv.74.1702913773446;
        Mon, 18 Dec 2023 07:36:13 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:13 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 017/154] ksmbd: set 445 port to smbdirect port by default
Date: Tue, 19 Dec 2023 00:32:37 +0900
Message-Id: <20231218153454.8090-18-linkinjeon@kernel.org>
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

[ Upstream commit cb097b3dd5ece9596a0a0b7e33893c02a9bde8c6 ]

When SMB Direct is used with iWARP, Windows use 5445 port for smb direct
port, 445 port for SMB. This patch check ib_device using ib_client to
know if NICs type is iWARP or Infiniband.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 15 ++++++++++++---
 fs/ksmbd/transport_rdma.h |  2 --
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 3bcca8e5a6c8..9d12ef4024e2 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -34,7 +34,8 @@
 #include "smbstatus.h"
 #include "transport_rdma.h"
 
-#define SMB_DIRECT_PORT	5445
+#define SMB_DIRECT_PORT_IWARP		5445
+#define SMB_DIRECT_PORT_INFINIBAND	445
 
 #define SMB_DIRECT_VERSION_LE		cpu_to_le16(0x0100)
 
@@ -60,6 +61,10 @@
  * as defined in [MS-SMBD] 3.1.1.1
  * Those may change after a SMB_DIRECT negotiation
  */
+
+/* Set 445 port to SMB Direct port by default */
+static int smb_direct_port = SMB_DIRECT_PORT_INFINIBAND;
+
 /* The local peer's maximum number of credits to grant to the peer */
 static int smb_direct_receive_credit_max = 255;
 
@@ -1948,7 +1953,7 @@ static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 
 	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
 					      KSMBD_TRANS(t)->conn, "ksmbd:r%u",
-					      SMB_DIRECT_PORT);
+					      smb_direct_port);
 	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
 		int ret = PTR_ERR(KSMBD_TRANS(t)->handler);
 
@@ -2025,6 +2030,10 @@ static int smb_direct_ib_client_add(struct ib_device *ib_dev)
 {
 	struct smb_direct_device *smb_dev;
 
+	/* Set 5445 port if device type is iWARP(No IB) */
+	if (ib_dev->node_type != RDMA_NODE_IB_CA)
+		smb_direct_port = SMB_DIRECT_PORT_IWARP;
+
 	if (!ib_dev->ops.get_netdev ||
 	    !rdma_frwr_is_supported(&ib_dev->attrs))
 		return 0;
@@ -2086,7 +2095,7 @@ int ksmbd_rdma_init(void)
 	if (!smb_direct_wq)
 		return -ENOMEM;
 
-	ret = smb_direct_listen(SMB_DIRECT_PORT);
+	ret = smb_direct_listen(smb_direct_port);
 	if (ret) {
 		destroy_workqueue(smb_direct_wq);
 		smb_direct_wq = NULL;
diff --git a/fs/ksmbd/transport_rdma.h b/fs/ksmbd/transport_rdma.h
index 3e6c4be3d560..e7b4e6790fab 100644
--- a/fs/ksmbd/transport_rdma.h
+++ b/fs/ksmbd/transport_rdma.h
@@ -7,8 +7,6 @@
 #ifndef __KSMBD_TRANSPORT_RDMA_H__
 #define __KSMBD_TRANSPORT_RDMA_H__
 
-#define SMB_DIRECT_PORT	5445
-
 #define SMBD_DEFAULT_IOSIZE (8 * 1024 * 1024)
 #define SMBD_MIN_IOSIZE (512 * 1024)
 #define SMBD_MAX_IOSIZE (16 * 1024 * 1024)
-- 
2.25.1



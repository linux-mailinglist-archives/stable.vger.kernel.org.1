Return-Path: <stable+bounces-7645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E988781757A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D51E1C24A39
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EE34238B;
	Mon, 18 Dec 2023 15:36:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582F5A851
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3c21a95e6so4312325ad.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913770; x=1703518570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3J1rNRQNWrnrjRT0sYF1c+xvvdXJXbXdMZdKUZZAEU=;
        b=GDCPhHkhLGKNuscvdNpNc4zj1XQhaY5+xqwpCs5XvJESmvIAbJDzrnyi9UD5FCQKYt
         5qCAqxzwpS9RdgdAjHfscAZGcgyL196w1dwlfUDVerO01/KW7SG/efln0HAlskBhuRtc
         A2blqbK3Cmd0tOnf8Hb9MN1LR6AzZg6iCt021Qk2OolxpK/NRS6YGQFTiJXHJk3T9puJ
         r3bB22ZwMwpQwXwwvxKVQj6KomWegJ0T3jEWgPWG0BZFWuu8M8M7CDQ7m7nh43pS0/xv
         8sdBsg4Wz+6HmFSC9+GwYHyg20cEY8icZt5/W4mA6sU2cvqCZFEIhchiWCqikz6ULgTt
         SI6g==
X-Gm-Message-State: AOJu0YylG2pTFOcJIcaNLfzKu3XeksW29Z93WdN3tdDDUPgscUuSVugT
	X/eL/k8zsbC7XVYi6QbHHEY=
X-Google-Smtp-Source: AGHT+IFO6NdXtm1SAz8I7GBPACKL9IzXBgpGvsg2gazibmZveclM1E42/CektoIanRCufaHRDTjC+Q==
X-Received: by 2002:a17:903:40cc:b0:1d3:62a6:98cf with SMTP id t12-20020a17090340cc00b001d362a698cfmr5282969pld.66.1702913770416;
        Mon, 18 Dec 2023 07:36:10 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:09 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 016/154] ksmbd: register ksmbd ib client with ib_register_client()
Date: Tue, 19 Dec 2023 00:32:36 +0900
Message-Id: <20231218153454.8090-17-linkinjeon@kernel.org>
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

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit 31928a001bed0d9642711d2eba520fc46d41c376 ]

Register ksmbd ib client with ib_register_client() to find the rdma capable
network adapter. If ops.get_netdev(Chelsio NICs) is NULL, ksmbd will find
it using ib_device_get_by_netdev in old way.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 107 ++++++++++++++++++++++++++++++++++----
 fs/ksmbd/transport_rdma.h |   2 +-
 2 files changed, 98 insertions(+), 11 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 9975ebc6fe63..3bcca8e5a6c8 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -79,6 +79,14 @@ static int smb_direct_max_read_write_size = SMBD_DEFAULT_IOSIZE;
 
 static int smb_direct_max_outstanding_rw_ops = 8;
 
+static LIST_HEAD(smb_direct_device_list);
+static DEFINE_RWLOCK(smb_direct_device_lock);
+
+struct smb_direct_device {
+	struct ib_device	*ib_dev;
+	struct list_head	list;
+};
+
 static struct smb_direct_listener {
 	struct rdma_cm_id	*cm_id;
 } smb_direct_listener;
@@ -2013,12 +2021,61 @@ static int smb_direct_listen(int port)
 	return ret;
 }
 
+static int smb_direct_ib_client_add(struct ib_device *ib_dev)
+{
+	struct smb_direct_device *smb_dev;
+
+	if (!ib_dev->ops.get_netdev ||
+	    !rdma_frwr_is_supported(&ib_dev->attrs))
+		return 0;
+
+	smb_dev = kzalloc(sizeof(*smb_dev), GFP_KERNEL);
+	if (!smb_dev)
+		return -ENOMEM;
+	smb_dev->ib_dev = ib_dev;
+
+	write_lock(&smb_direct_device_lock);
+	list_add(&smb_dev->list, &smb_direct_device_list);
+	write_unlock(&smb_direct_device_lock);
+
+	ksmbd_debug(RDMA, "ib device added: name %s\n", ib_dev->name);
+	return 0;
+}
+
+static void smb_direct_ib_client_remove(struct ib_device *ib_dev,
+					void *client_data)
+{
+	struct smb_direct_device *smb_dev, *tmp;
+
+	write_lock(&smb_direct_device_lock);
+	list_for_each_entry_safe(smb_dev, tmp, &smb_direct_device_list, list) {
+		if (smb_dev->ib_dev == ib_dev) {
+			list_del(&smb_dev->list);
+			kfree(smb_dev);
+			break;
+		}
+	}
+	write_unlock(&smb_direct_device_lock);
+}
+
+static struct ib_client smb_direct_ib_client = {
+	.name	= "ksmbd_smb_direct_ib",
+	.add	= smb_direct_ib_client_add,
+	.remove	= smb_direct_ib_client_remove,
+};
+
 int ksmbd_rdma_init(void)
 {
 	int ret;
 
 	smb_direct_listener.cm_id = NULL;
 
+	ret = ib_register_client(&smb_direct_ib_client);
+	if (ret) {
+		pr_err("failed to ib_register_client\n");
+		return ret;
+	}
+
 	/* When a client is running out of send credits, the credits are
 	 * granted by the server's sending a packet using this queue.
 	 * This avoids the situation that a clients cannot send packets
@@ -2042,30 +2099,60 @@ int ksmbd_rdma_init(void)
 	return 0;
 }
 
-int ksmbd_rdma_destroy(void)
+void ksmbd_rdma_destroy(void)
 {
-	if (smb_direct_listener.cm_id)
-		rdma_destroy_id(smb_direct_listener.cm_id);
+	if (!smb_direct_listener.cm_id)
+		return;
+
+	ib_unregister_client(&smb_direct_ib_client);
+	rdma_destroy_id(smb_direct_listener.cm_id);
+
 	smb_direct_listener.cm_id = NULL;
 
 	if (smb_direct_wq) {
 		destroy_workqueue(smb_direct_wq);
 		smb_direct_wq = NULL;
 	}
-	return 0;
 }
 
 bool ksmbd_rdma_capable_netdev(struct net_device *netdev)
 {
-	struct ib_device *ibdev;
+	struct smb_direct_device *smb_dev;
+	int i;
 	bool rdma_capable = false;
 
-	ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_UNKNOWN);
-	if (ibdev) {
-		if (rdma_frwr_is_supported(&ibdev->attrs))
-			rdma_capable = true;
-		ib_device_put(ibdev);
+	read_lock(&smb_direct_device_lock);
+	list_for_each_entry(smb_dev, &smb_direct_device_list, list) {
+		for (i = 0; i < smb_dev->ib_dev->phys_port_cnt; i++) {
+			struct net_device *ndev;
+
+			ndev = smb_dev->ib_dev->ops.get_netdev(smb_dev->ib_dev,
+							       i + 1);
+			if (!ndev)
+				continue;
+
+			if (ndev == netdev) {
+				dev_put(ndev);
+				rdma_capable = true;
+				goto out;
+			}
+			dev_put(ndev);
+		}
+	}
+out:
+	read_unlock(&smb_direct_device_lock);
+
+	if (rdma_capable == false) {
+		struct ib_device *ibdev;
+
+		ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_UNKNOWN);
+		if (ibdev) {
+			if (rdma_frwr_is_supported(&ibdev->attrs))
+				rdma_capable = true;
+			ib_device_put(ibdev);
+		}
 	}
+
 	return rdma_capable;
 }
 
diff --git a/fs/ksmbd/transport_rdma.h b/fs/ksmbd/transport_rdma.h
index 04a7a37685c3..3e6c4be3d560 100644
--- a/fs/ksmbd/transport_rdma.h
+++ b/fs/ksmbd/transport_rdma.h
@@ -56,7 +56,7 @@ struct smb_direct_data_transfer {
 
 #ifdef CONFIG_SMB_SERVER_SMBDIRECT
 int ksmbd_rdma_init(void);
-int ksmbd_rdma_destroy(void);
+void ksmbd_rdma_destroy(void);
 bool ksmbd_rdma_capable_netdev(struct net_device *netdev);
 void init_smbd_max_io_size(unsigned int sz);
 #else
-- 
2.25.1



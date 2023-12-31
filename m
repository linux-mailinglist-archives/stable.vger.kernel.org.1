Return-Path: <stable+bounces-9112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5EE820A42
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317A31F22170
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4112617C3;
	Sun, 31 Dec 2023 07:19:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F1820E7
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc02727c62so2316663a34.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007191; x=1704611991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13jl6Cu0OI7RM+iVVfSxybmX1GKuBKpk5JjIXU3C9S0=;
        b=AZIMazLe01utFInde420I4hcEM9O28VVS5Uk4hxIP3ZmpHYLYKZ4X3kXbz2I1KECf1
         nQaRnEIck937oMosA2XJiNWAsZGNOd0to3g/8wn+9dpbdMZuQldwoh/ji+tl9N4nij2B
         Qoi/vX+eBxr5yOeSqk0WJ03IV/lwERWajpCyz+4BmxfkF6EXlcEj8ZNvlv5sh+1GSwiy
         8tcaDCabUzmco91ph8YD2zdzanJjHVbwQZvBXuenRvGe0sYETT/l+qvONVp12iJVOuQv
         MiwOk0soJZ2Gatu8lmX/+oVz9iyFmJVEtc6UEf0VEmjYuHyzJgQ73/LmsD58m3CLBJWK
         Q0SQ==
X-Gm-Message-State: AOJu0Yw3SavT/OtR6qeJ50m44NwOfr1ZzPrE6ZMkru0+AEkNiEtUQ/GS
	2Kv41lCUCF4Lf3lnkyrMaaY=
X-Google-Smtp-Source: AGHT+IH5AV1mYaf/eeSjlU1kiWVf2LUpyidKzWzEFaRh0pTgfD9+6WupiDzXYNlnzd6p99Z3DnjuIg==
X-Received: by 2002:a05:6808:23d2:b0:3bb:c394:fd52 with SMTP id bq18-20020a05680823d200b003bbc394fd52mr8772625oib.105.1704007191011;
        Sat, 30 Dec 2023 23:19:51 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:19:50 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Kangjing Huang <huangkangjing@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 04/19] ksmbd: fix missing RDMA-capable flag for IPoIB device in ksmbd_rdma_capable_netdev()
Date: Sun, 31 Dec 2023 16:19:04 +0900
Message-Id: <20231231071919.32103-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071919.32103-1-linkinjeon@kernel.org>
References: <20231231071919.32103-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kangjing Huang <huangkangjing@gmail.com>

[ Upstream commit ecce70cf17d91c3dd87a0c4ea00b2d1387729701 ]

Physical ib_device does not have an underlying net_device, thus its
association with IPoIB net_device cannot be retrieved via
ops.get_netdev() or ib_device_get_by_netdev(). ksmbd reads physical
ib_device port GUID from the lower 16 bytes of the hardware addresses on
IPoIB net_device and match its underlying ib_device using ib_find_gid()

Signed-off-by: Kangjing Huang <huangkangjing@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/transport_rdma.c | 40 +++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 3b269e1f523a..c5629a68c8b7 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -2140,8 +2140,7 @@ static int smb_direct_ib_client_add(struct ib_device *ib_dev)
 	if (ib_dev->node_type != RDMA_NODE_IB_CA)
 		smb_direct_port = SMB_DIRECT_PORT_IWARP;
 
-	if (!ib_dev->ops.get_netdev ||
-	    !rdma_frwr_is_supported(&ib_dev->attrs))
+	if (!rdma_frwr_is_supported(&ib_dev->attrs))
 		return 0;
 
 	smb_dev = kzalloc(sizeof(*smb_dev), GFP_KERNEL);
@@ -2241,17 +2240,38 @@ bool ksmbd_rdma_capable_netdev(struct net_device *netdev)
 		for (i = 0; i < smb_dev->ib_dev->phys_port_cnt; i++) {
 			struct net_device *ndev;
 
-			ndev = smb_dev->ib_dev->ops.get_netdev(smb_dev->ib_dev,
-							       i + 1);
-			if (!ndev)
-				continue;
+			if (smb_dev->ib_dev->ops.get_netdev) {
+				ndev = smb_dev->ib_dev->ops.get_netdev(
+					smb_dev->ib_dev, i + 1);
+				if (!ndev)
+					continue;
 
-			if (ndev == netdev) {
+				if (ndev == netdev) {
+					dev_put(ndev);
+					rdma_capable = true;
+					goto out;
+				}
 				dev_put(ndev);
-				rdma_capable = true;
-				goto out;
+			/* if ib_dev does not implement ops.get_netdev
+			 * check for matching infiniband GUID in hw_addr
+			 */
+			} else if (netdev->type == ARPHRD_INFINIBAND) {
+				struct netdev_hw_addr *ha;
+				union ib_gid gid;
+				u32 port_num;
+				int ret;
+
+				netdev_hw_addr_list_for_each(
+					ha, &netdev->dev_addrs) {
+					memcpy(&gid, ha->addr + 4, sizeof(gid));
+					ret = ib_find_gid(smb_dev->ib_dev, &gid,
+							  &port_num, NULL);
+					if (!ret) {
+						rdma_capable = true;
+						goto out;
+					}
+				}
 			}
-			dev_put(ndev);
 		}
 	}
 out:
-- 
2.25.1



Return-Path: <stable+bounces-9563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABE78232EA
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F15F1C238A4
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F21C290;
	Wed,  3 Jan 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MD26wY0O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC971BDEC;
	Wed,  3 Jan 2024 17:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23407C433C8;
	Wed,  3 Jan 2024 17:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704302002;
	bh=ou7XetbFfL4sxZb7MBoOKTOVXuHl/tav7fYDxbm2Wco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MD26wY0OgAE6zYXL+VsCb5mTuePk9SavDvvzdYoNam4JFs3X8CrJ2TjTr5GRppaav
	 V3Rnaku8USCahRugYGzfFOcPz/avqMjLIk0SMcP/9Vguha9IsfJD7krQrvaSK6P75w
	 i7ltqNJOujUT4l9tllhARQV2Yq9K/ahfh4vBzwLg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kangjing Huang <huangkangjing@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 04/49] ksmbd: fix missing RDMA-capable flag for IPoIB device in ksmbd_rdma_capable_netdev()
Date: Wed,  3 Jan 2024 17:55:24 +0100
Message-ID: <20240103164835.626118820@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
References: <20240103164834.970234661@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/transport_rdma.c | 40 +++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 3b269e1f523a1..c5629a68c8b73 100644
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
2.43.0





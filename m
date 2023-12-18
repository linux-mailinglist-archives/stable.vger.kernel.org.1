Return-Path: <stable+bounces-7640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96598817567
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498AF1F248A0
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D77C3D556;
	Mon, 18 Dec 2023 15:35:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBF342395
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d32c5ce32eso30911575ad.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913752; x=1703518552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHL9aP1ehtdjRjTaCAqcm4ywAiPE0j/a5Mc9BW0UbJU=;
        b=K5IBI0zHG+b5e/7EmSKfKCndU3Fua1nopIfJx4iQ+0FyWpK+FLkj+XvFrfCwcjinBP
         3jIHHzly6oVvU4cWga/qemrmZJPBcivpr4vMC7t0iz1X/W/Fd5hbJ1TYWBiFcZyLXg6a
         fBFAFUlHq7PND8WEav2ZOKOfczFDz0HZiK8k8lW+2WeoiiTgheer4NEFafruOulB3u3z
         YnPqwr75X0WB/keGMKAYsbSvCjtqaILs+KfNobzLIVEq2AAoyTRtMl5nz81Nt/pviZRf
         F4aUVsh/s5rZwUp2HgWWR45xk7fq7UVo4ZV+FtdB1I8dBMS4GVgeUPxA53rBHCVNIdV/
         9ZlA==
X-Gm-Message-State: AOJu0YyMCkhWRTXN0wq2cmGWICO6WK2vi0gFInHqdgA9tMsbtJwpOIpA
	1nuFM40qYm12iidEo19HnNQ=
X-Google-Smtp-Source: AGHT+IFLxbPBfrCns/ktkC3NHRC1xHkBGmlHSK8RSRh9CnXHp8MpIpdFiXZ1V3QGPUG1lFaRwJjjRw==
X-Received: by 2002:a17:90a:1008:b0:28a:e7cc:bae1 with SMTP id b8-20020a17090a100800b0028ae7ccbae1mr10446197pja.42.1702913752396;
        Mon, 18 Dec 2023 07:35:52 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:51 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 011/154] ksmbd: set both ipv4 and ipv6 in FSCTL_QUERY_NETWORK_INTERFACE_INFO
Date: Tue, 19 Dec 2023 00:32:31 +0900
Message-Id: <20231218153454.8090-12-linkinjeon@kernel.org>
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

[ Upstream commit a58b45a4dbfd0bf2ebb157789da4d8e6368afb1b ]

Set ipv4 and ipv6 address in FSCTL_QUERY_NETWORK_INTERFACE_INFO.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index bf537080b2e0..cf883f9575bc 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -7327,15 +7327,10 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 	struct sockaddr_storage_rsp *sockaddr_storage;
 	unsigned int flags;
 	unsigned long long speed;
-	struct sockaddr_in6 *csin6 = (struct sockaddr_in6 *)&conn->peer_addr;
 
 	rtnl_lock();
 	for_each_netdev(&init_net, netdev) {
-		if (out_buf_len <
-		    nbytes + sizeof(struct network_interface_info_ioctl_rsp)) {
-			rtnl_unlock();
-			return -ENOSPC;
-		}
+		bool ipv4_set = false;
 
 		if (netdev->type == ARPHRD_LOOPBACK)
 			continue;
@@ -7343,6 +7338,12 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 		flags = dev_get_flags(netdev);
 		if (!(flags & IFF_RUNNING))
 			continue;
+ipv6_retry:
+		if (out_buf_len <
+		    nbytes + sizeof(struct network_interface_info_ioctl_rsp)) {
+			rtnl_unlock();
+			return -ENOSPC;
+		}
 
 		nii_rsp = (struct network_interface_info_ioctl_rsp *)
 				&rsp->Buffer[nbytes];
@@ -7375,8 +7376,7 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 					nii_rsp->SockAddr_Storage;
 		memset(sockaddr_storage, 0, 128);
 
-		if (conn->peer_addr.ss_family == PF_INET ||
-		    ipv6_addr_v4mapped(&csin6->sin6_addr)) {
+		if (!ipv4_set) {
 			struct in_device *idev;
 
 			sockaddr_storage->Family = cpu_to_le16(INTERNETWORK);
@@ -7387,6 +7387,9 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 				continue;
 			sockaddr_storage->addr4.IPv4address =
 						idev_ipv4_address(idev);
+			nbytes += sizeof(struct network_interface_info_ioctl_rsp);
+			ipv4_set = true;
+			goto ipv6_retry;
 		} else {
 			struct inet6_dev *idev6;
 			struct inet6_ifaddr *ifa;
@@ -7408,9 +7411,8 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 				break;
 			}
 			sockaddr_storage->addr6.ScopeId = 0;
+			nbytes += sizeof(struct network_interface_info_ioctl_rsp);
 		}
-
-		nbytes += sizeof(struct network_interface_info_ioctl_rsp);
 	}
 	rtnl_unlock();
 
-- 
2.25.1



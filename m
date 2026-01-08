Return-Path: <stable+bounces-206304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3085AD03F13
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CA8E30C4899
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993613A63E7;
	Thu,  8 Jan 2026 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AL5dAKmI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0148E8CE
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868021; cv=none; b=RZNgRnjx0bGzroJavCQFonAcOu/A656lbGTChIx55C7InAJGpiBIp86GRqfT+ueccq99nmeg0lmIp77z/OJedszs0SXntccoqzvpwQdGQQ10tonjG8UupTOe/0y2RVqM8xsBCdseaShFZe+B5EdrlWnJEBo/VRi8ePRM846G/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868021; c=relaxed/simple;
	bh=f31CHMhQWqNlQtDA++NF7UwXwugjtlGMeu/v6z0UZNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0xsSUlhbvmEOlbEJLv6xsK9LQAvY4LR9mPvbNfOkKq3dywm/HEpM4VfhjJDSQghWTY/O5ULWmAwAGqgAdWYHVogYe0gHtm01bHQFHIKZG+rWEYdPZoo1u5GaArqfpCK2F0S0h/EM+o0jN1dxtqFuy2mnV1js9VgAZlFWay4sVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AL5dAKmI; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a0bae9aca3so22803195ad.3
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 02:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868011; x=1768472811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRGzylfuTGBzLuULxrttYZ/W8538Ph4NnSuvcrcPCLg=;
        b=cYnF9+JjWyF0IKMNy6dx3oZOzmxS/gzcEPxR1jNEQRPrDSWtMpz1H6VspDiR6s3BTr
         /v9YsOWl/DGU1xdWjiPP0Woo+ZjQv7s2rQZDWfDxRehDBX1HfJRVWtsdB71gYnYO871n
         27YCJ38Wa8UEalGzbp3gATeiXTnccnoPqy+9+yGV2zWKchTkw3V2HQNuMx0LpX8dLfkc
         TGj9nRal8jKq0iu7llA6r2ESsGcFp7m/Z3XTZzWDpALa6804lVJmu9tR1fUh+/J8jbTm
         nPr6YiQs4rEwGnRGgEfQYAySFapevtyY6+U58VNTNx9kj+Al92XPFnydHoZ2fslqZUG+
         OoFQ==
X-Gm-Message-State: AOJu0YxLVyPWGJvYYca1T2V5HGmQ1MMyN9H+dt2OxwQ2+m/V9CMRHrkv
	IdRc4sBk6Y4Fe46CX9/4cFeQzR5BR8GyCPSy82mgSLe1WmHIVh6Tvo9UK7bDzNphTrsInSr2YeM
	Mpm/eqVRoi5wxsXs+e1d2JHrIfoArqcQ86w/Moz0j7Ao3jzNLuTQyCenKcmqsbHEj2hFSaiYc0r
	6NZZ88bcK9JkVhnB+rJuY6dZUQ1UNsxSqugyIkR2o6wOTmY03tMjymieEAwiavdyfdHkG/uQDc0
	QAAGgEF9MKCMNq7fg==
X-Gm-Gg: AY/fxX7MA0OgyQuPJ3zBffNdIjJWJmr8bVqbPmEVg8MMOojkZ3AlGBKZFEtY/4XvMgX
	zNx1zfmrgt62sZ4RbmLDXadmmr3gW1df0LXJMMpRD6VxsSNysOgLlVB0Hk496anG+1O2tiZ1q27
	Vj1B85zKizxcaUjcxMOAxIKf4V0hD24ko+H7RbBrFwbDi6eyOEd72ioGoAy4p8A5lecKsxpOsPC
	pNwXucrdn/HCW8hlxHz0bNSkuCR4U609R7TXCSLdl23YBmoAzXxa1gFza+KnPujbEH5m9x1TfKQ
	nOuMY6h4aWgEO4wBP1It90tPI9XkLOiP4KbtiLszzGbctga/Vfrn0/10XEUmvJZhmrc6Tut/iUY
	3H9hToxIafsjoXz9qkF2MvPFGYJ1XnU6OmoSjvgDy9h1XfUbeQWzcTF+f4/GOCc2t4UbEWWQyjx
	mGfEAScnceGdZQP41bWdAyl3NCTjUMC7FlCVBJffJ6SIWsfQ==
X-Google-Smtp-Source: AGHT+IH+RkWaW6eUr+gDzIAG9nvIG1AHFc1O8W86sRDlpDVZNwi4Xa4pl+1fDsZhCUfX9dGNn5+x57qc5tS6
X-Received: by 2002:a17:903:1510:b0:29f:5f5:fa91 with SMTP id d9443c01a7336-2a3ee472bb9mr53795395ad.27.1767868011186;
        Thu, 08 Jan 2026 02:26:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c3c3easm8658925ad.12.2026.01.08.02.26.50
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 02:26:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed74ab4172so65820211cf.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 02:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767868010; x=1768472810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRGzylfuTGBzLuULxrttYZ/W8538Ph4NnSuvcrcPCLg=;
        b=AL5dAKmIw8nU0d9kP+wke2jTCwKHdfOVBd7yhygZXOe8MpEdntDD3N8FJ9yrg1ebao
         +6M/e0zAH8ON7pWT3TYXBoDsdQy5NsotJ+A4FOGuCzCXcjdLYrzMOCZXt5E/tH56Woxc
         MRu30ZtZjK3AqAk2y2cfUZt3xzrr/AA90hy+I=
X-Received: by 2002:a05:622a:14d3:b0:4f4:c0ac:6666 with SMTP id d75a77b69052e-4ffb4b592e4mr72784911cf.77.1767868009641;
        Thu, 08 Jan 2026 02:26:49 -0800 (PST)
X-Received: by 2002:a05:622a:14d3:b0:4f4:c0ac:6666 with SMTP id d75a77b69052e-4ffb4b592e4mr72784471cf.77.1767868009156;
        Thu, 08 Jan 2026 02:26:49 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e362fdsm45124721cf.21.2026.01.08.02.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:26:48 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	mbloch@nvidia.com,
	parav@nvidia.com,
	mrgolin@amazon.com,
	roman.gushchin@linux.dev,
	wangliang74@huawei.com,
	marco.crivellari@suse.com,
	zhao.xichao@vivo.com,
	haggaie@mellanox.com,
	monis@mellanox.com,
	dledford@redhat.com,
	amirv@mellanox.com,
	kamalh@mellanox.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 2/2 v6.6] RDMA/rxe: Fix the failure of ibv_query_device() and ibv_query_device_ex() tests
Date: Thu,  8 Jan 2026 02:05:40 -0800
Message-Id: <20260108100540.672666-3-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108100540.672666-1-shivani.agarwal@broadcom.com>
References: <20260108100540.672666-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Zhu Yanjun <yanjun.zhu@linux.dev>

[ Upstream commit 8ce2eb9dfac8743d1c423b86339336a5b6a6069e ]

In rdma-core, the following failures appear.

"
$ ./build/bin/run_tests.py -k device
ssssssss....FF........s
======================================================================
FAIL: test_query_device (tests.test_device.DeviceTest.test_query_device)
Test ibv_query_device()
----------------------------------------------------------------------
Traceback (most recent call last):
   File "/home/ubuntu/rdma-core/tests/test_device.py", line 63, in
   test_query_device
     self.verify_device_attr(attr, dev)
   File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in
   verify_device_attr
     assert attr.sys_image_guid != 0
            ^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError

======================================================================
FAIL: test_query_device_ex (tests.test_device.DeviceTest.test_query_device_ex)
Test ibv_query_device_ex()
----------------------------------------------------------------------
Traceback (most recent call last):
   File "/home/ubuntu/rdma-core/tests/test_device.py", line 222, in
   test_query_device_ex
     self.verify_device_attr(attr_ex.orig_attr, dev)
   File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in
   verify_device_attr
     assert attr.sys_image_guid != 0
            ^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError
"

The root cause is: before a net device is set with rxe, this net device
is used to generate a sys_image_guid.

Fixes: 2ac5415022d1 ("RDMA/rxe: Remove the direct link to net_device")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://patch.msgid.link/20250302215444.3742072-1-yanjun.zhu@linux.dev
Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Tested-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 6.6.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/infiniband/sw/rxe/rxe.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 1fb4fa4514bf..50c583a55464 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -38,10 +38,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
 }
 
 /* initialize rxe device parameters */
-static void rxe_init_device_param(struct rxe_dev *rxe)
+static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
 {
-	struct net_device *ndev;
-
 	rxe->max_inline_data			= RXE_MAX_INLINE_DATA;
 
 	rxe->attr.vendor_id			= RXE_VENDOR_ID;
@@ -74,15 +72,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_pkeys			= RXE_MAX_PKEYS;
 	rxe->attr.local_ca_ack_delay		= RXE_LOCAL_CA_ACK_DELAY;
 
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
-	if (!ndev)
-		return;
-
 	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
 			ndev->dev_addr);
 
-	dev_put(ndev);
-
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
 }
 
@@ -115,18 +107,13 @@ static void rxe_init_port_param(struct rxe_port *port)
 /* initialize port state, note IB convention that HCA ports are always
  * numbered from 1
  */
-static void rxe_init_ports(struct rxe_dev *rxe)
+static void rxe_init_ports(struct rxe_dev *rxe, struct net_device *ndev)
 {
 	struct rxe_port *port = &rxe->port;
-	struct net_device *ndev;
 
 	rxe_init_port_param(port);
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
-	if (!ndev)
-		return;
 	addrconf_addr_eui48((unsigned char *)&port->port_guid,
 			    ndev->dev_addr);
-	dev_put(ndev);
 	spin_lock_init(&port->port_lock);
 }
 
@@ -144,12 +131,12 @@ static void rxe_init_pools(struct rxe_dev *rxe)
 }
 
 /* initialize rxe device state */
-static void rxe_init(struct rxe_dev *rxe)
+static void rxe_init(struct rxe_dev *rxe, struct net_device *ndev)
 {
 	/* init default device parameters */
-	rxe_init_device_param(rxe);
+	rxe_init_device_param(rxe, ndev);
 
-	rxe_init_ports(rxe);
+	rxe_init_ports(rxe, ndev);
 	rxe_init_pools(rxe);
 
 	/* init pending mmap list */
@@ -186,7 +173,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name,
 			struct net_device *ndev)
 {
-	rxe_init(rxe);
+	rxe_init(rxe, ndev);
 	rxe_set_mtu(rxe, mtu);
 
 	return rxe_register_device(rxe, ibdev_name, ndev);
-- 
2.43.7



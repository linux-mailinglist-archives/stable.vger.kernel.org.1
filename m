Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9F7ED581
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjKOVHb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjKOVHZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:07:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586BAD44
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:07:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E019CC4AF6B;
        Wed, 15 Nov 2023 20:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081400;
        bh=HjZQuBhWldjD5BwkbOyGGDRBRgqz8UemkqwR8FHh5F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrpBKKXSpAdtXcT8Avk6QkmvkeDm3efHlHAjy0DPTnq3JQmqC15L/Rzh+yF8KvIPO
         7VKc27yKQ8zPYIG0jmJVCFjrI5f2Yd4Qo0vkmaQiDM/1AM3yfzSlAl00nyXeecJohL
         PnFNiOa4VU6k30uUxBwkVStlhq54yp0iAFwHZZgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 130/244] RDMA/core: Use size_{add,sub,mul}() in calls to struct_size()
Date:   Wed, 15 Nov 2023 15:35:22 -0500
Message-ID: <20231115203556.172154982@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

[ Upstream commit 81760bedc65194ff38e1e4faefd5f9f0c95c19a4 ]

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` provides against potential integer
overflows is defeated. Fix this by hardening calls to `struct_size()`
with `size_add()`, `size_sub()` and `size_mul()`.

Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs attributes")
Fixes: a4676388e2e2 ("RDMA/core: Simplify how the gid_attrs sysfs is created")
Fixes: e9dd5daf884c ("IB/umad: Refactor code to use cdev_device_add()")
Fixes: 324e227ea7c9 ("RDMA/device: Add ib_device_get_by_netdev()")
Fixes: 5aad26a7eac5 ("IB/core: Use struct_size() in kzalloc()")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/ZQdt4NsJFwwOYxUR@work
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/device.c   |  2 +-
 drivers/infiniband/core/sa_query.c |  4 +++-
 drivers/infiniband/core/sysfs.c    | 10 +++++-----
 drivers/infiniband/core/user_mad.c |  4 +++-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ab2106a09f9c6..2c2ac63b39c42 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -803,7 +803,7 @@ static int alloc_port_data(struct ib_device *device)
 	 * empty slots at the beginning.
 	 */
 	pdata_rcu = kzalloc(struct_size(pdata_rcu, pdata,
-					rdma_end_port(device) + 1),
+					size_add(rdma_end_port(device), 1)),
 			    GFP_KERNEL);
 	if (!pdata_rcu)
 		return -ENOMEM;
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index c00f8e28aab75..1557c71dd152f 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -2132,7 +2132,9 @@ static int ib_sa_add_one(struct ib_device *device)
 	s = rdma_start_port(device);
 	e = rdma_end_port(device);
 
-	sa_dev = kzalloc(struct_size(sa_dev, port, e - s + 1), GFP_KERNEL);
+	sa_dev = kzalloc(struct_size(sa_dev, port,
+				     size_add(size_sub(e, s), 1)),
+			 GFP_KERNEL);
 	if (!sa_dev)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 253ccaf343f69..afc59048c40c8 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -902,7 +902,7 @@ alloc_hw_stats_device(struct ib_device *ibdev)
 	 * Two extra attribue elements here, one for the lifespan entry and
 	 * one to NULL terminate the list for the sysfs core code
 	 */
-	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
+	data = kzalloc(struct_size(data, attrs, size_add(stats->num_counters, 1)),
 		       GFP_KERNEL);
 	if (!data)
 		goto err_free_stats;
@@ -1001,7 +1001,7 @@ alloc_hw_stats_port(struct ib_port *port, struct attribute_group *group)
 	 * Two extra attribue elements here, one for the lifespan entry and
 	 * one to NULL terminate the list for the sysfs core code
 	 */
-	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
+	data = kzalloc(struct_size(data, attrs, size_add(stats->num_counters, 1)),
 		       GFP_KERNEL);
 	if (!data)
 		goto err_free_stats;
@@ -1125,7 +1125,7 @@ static int setup_gid_attrs(struct ib_port *port,
 	int ret;
 
 	gid_attr_group = kzalloc(struct_size(gid_attr_group, attrs_list,
-					     attr->gid_tbl_len * 2),
+					     size_mul(attr->gid_tbl_len, 2)),
 				 GFP_KERNEL);
 	if (!gid_attr_group)
 		return -ENOMEM;
@@ -1190,8 +1190,8 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 	int ret;
 
 	p = kvzalloc(struct_size(p, attrs_list,
-				attr->gid_tbl_len + attr->pkey_tbl_len),
-		    GFP_KERNEL);
+				size_add(attr->gid_tbl_len, attr->pkey_tbl_len)),
+		     GFP_KERNEL);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 	p->ibdev = device;
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index a61c9ede43387..5c284dfbe6923 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -1378,7 +1378,9 @@ static int ib_umad_add_one(struct ib_device *device)
 	s = rdma_start_port(device);
 	e = rdma_end_port(device);
 
-	umad_dev = kzalloc(struct_size(umad_dev, ports, e - s + 1), GFP_KERNEL);
+	umad_dev = kzalloc(struct_size(umad_dev, ports,
+				       size_add(size_sub(e, s), 1)),
+			   GFP_KERNEL);
 	if (!umad_dev)
 		return -ENOMEM;
 
-- 
2.42.0




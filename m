Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEDB75D2AF
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjGUTCc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjGUTCb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:02:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE230CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3961161D85
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B486C433C8;
        Fri, 21 Jul 2023 19:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966148;
        bh=i8v/spn9KkeYIeUZdEwqUa+gDynirXUXk0m8lyGdckc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqQYsLTkqTeUY0n0LeC3U4uCrmbKOLdtf/V8hsXTzCfCVVwwoHx+ByiWXzFlFA/1q
         /CBPBVIEjip/Ei+d2niIM80GIIRW/eSmoGEUD7fU5dj+QWXMKe3Yy1wqtCyGXV2mE7
         ut732H+MEutm34KLvj/lu71xM+F4XXdzl2//hkys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yongqiang Liu <liuyongqiang13@huawei.com>,
        Paul Cassella <cassella@hpe.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 241/532] dax: Introduce alloc_dev_dax_id()
Date:   Fri, 21 Jul 2023 18:02:25 +0200
Message-ID: <20230721160627.429949050@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit 70aab281e18c68a1284bc387de127c2fc0bed3f8 ]

The reference counting of dax_region objects is needlessly complicated,
has lead to confusion [1], and has hidden a bug [2]. Towards cleaning up
that mess introduce alloc_dev_dax_id() to minimize the holding of a
dax_region reference to only what dev_dax_release() needs, the
dax_region->ida.

Part of the reason for the mess was the design to dereference a
dax_region in all cases in free_dev_dax_id() even if the id was
statically assigned by the upper level dax_region driver. Remove the
need to call "is_static(dax_region)" by tracking whether the id is
dynamic directly in the dev_dax instance itself.

With that flag the dax_region pinning and release per dev_dax instance
can move to alloc_dev_dax_id() and free_dev_dax_id() respectively.

A follow-on cleanup address the unnecessary references in the dax_region
setup and drivers.

Fixes: 0f3da14a4f05 ("device-dax: introduce 'seed' devices")
Link: http://lore.kernel.org/r/20221203095858.612027-1-liuyongqiang13@huawei.com [1]
Link: http://lore.kernel.org/r/3cf0890b-4eb0-e70e-cd9c-2ecc3d496263@hpe.com [2]
Reported-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Reported-by: Paul Cassella <cassella@hpe.com>
Reported-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/168577284563.1672036.13493034988900989554.stgit@dwillia2-xfh.jf.intel.com
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dax/bus.c         | 56 ++++++++++++++++++++++++---------------
 drivers/dax/dax-private.h |  4 ++-
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index ce010040bcef8..7ad61c707687f 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -402,18 +402,34 @@ static void unregister_dev_dax(void *dev)
 	put_device(dev);
 }
 
+static void dax_region_free(struct kref *kref)
+{
+	struct dax_region *dax_region;
+
+	dax_region = container_of(kref, struct dax_region, kref);
+	kfree(dax_region);
+}
+
+void dax_region_put(struct dax_region *dax_region)
+{
+	kref_put(&dax_region->kref, dax_region_free);
+}
+EXPORT_SYMBOL_GPL(dax_region_put);
+
 /* a return value >= 0 indicates this invocation invalidated the id */
 static int __free_dev_dax_id(struct dev_dax *dev_dax)
 {
-	struct dax_region *dax_region = dev_dax->region;
 	struct device *dev = &dev_dax->dev;
+	struct dax_region *dax_region;
 	int rc = dev_dax->id;
 
 	device_lock_assert(dev);
 
-	if (is_static(dax_region) || dev_dax->id < 0)
+	if (!dev_dax->dyn_id || dev_dax->id < 0)
 		return -1;
+	dax_region = dev_dax->region;
 	ida_free(&dax_region->ida, dev_dax->id);
+	dax_region_put(dax_region);
 	dev_dax->id = -1;
 	return rc;
 }
@@ -429,6 +445,20 @@ static int free_dev_dax_id(struct dev_dax *dev_dax)
 	return rc;
 }
 
+static int alloc_dev_dax_id(struct dev_dax *dev_dax)
+{
+	struct dax_region *dax_region = dev_dax->region;
+	int id;
+
+	id = ida_alloc(&dax_region->ida, GFP_KERNEL);
+	if (id < 0)
+		return id;
+	kref_get(&dax_region->kref);
+	dev_dax->dyn_id = true;
+	dev_dax->id = id;
+	return id;
+}
+
 static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t len)
 {
@@ -516,20 +546,6 @@ static const struct attribute_group *dax_region_attribute_groups[] = {
 	NULL,
 };
 
-static void dax_region_free(struct kref *kref)
-{
-	struct dax_region *dax_region;
-
-	dax_region = container_of(kref, struct dax_region, kref);
-	kfree(dax_region);
-}
-
-void dax_region_put(struct dax_region *dax_region)
-{
-	kref_put(&dax_region->kref, dax_region_free);
-}
-EXPORT_SYMBOL_GPL(dax_region_put);
-
 static void dax_region_unregister(void *region)
 {
 	struct dax_region *dax_region = region;
@@ -1254,12 +1270,10 @@ static const struct attribute_group *dax_attribute_groups[] = {
 static void dev_dax_release(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
-	struct dax_region *dax_region = dev_dax->region;
 	struct dax_device *dax_dev = dev_dax->dax_dev;
 
 	put_dax(dax_dev);
 	free_dev_dax_id(dev_dax);
-	dax_region_put(dax_region);
 	kfree(dev_dax->pgmap);
 	kfree(dev_dax);
 }
@@ -1283,6 +1297,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
 
+	dev_dax->region = dax_region;
 	if (is_static(dax_region)) {
 		if (dev_WARN_ONCE(parent, data->id < 0,
 				"dynamic id specified to static region\n")) {
@@ -1298,13 +1313,11 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 			goto err_id;
 		}
 
-		rc = ida_alloc(&dax_region->ida, GFP_KERNEL);
+		rc = alloc_dev_dax_id(dev_dax);
 		if (rc < 0)
 			goto err_id;
-		dev_dax->id = rc;
 	}
 
-	dev_dax->region = dax_region;
 	dev = &dev_dax->dev;
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
@@ -1342,7 +1355,6 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	dev_dax->target_node = dax_region->target_node;
 	dev_dax->align = dax_region->align;
 	ida_init(&dev_dax->ida);
-	kref_get(&dax_region->kref);
 
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 1c974b7caae6e..afcada6fd2eda 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -52,7 +52,8 @@ struct dax_mapping {
  * @region - parent region
  * @dax_dev - core dax functionality
  * @target_node: effective numa node if dev_dax memory range is onlined
- * @id: ida allocated id
+ * @dyn_id: is this a dynamic or statically created instance
+ * @id: ida allocated id when the dax_region is not static
  * @ida: mapping id allocator
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
@@ -64,6 +65,7 @@ struct dev_dax {
 	struct dax_device *dax_dev;
 	unsigned int align;
 	int target_node;
+	bool dyn_id;
 	int id;
 	struct ida ida;
 	struct device dev;
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642877ECF9B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjKOTtd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjKOTtd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:49:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198CF19E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:49:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B8BC433C7;
        Wed, 15 Nov 2023 19:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077769;
        bh=eHHrRw9MNgR3xqXuPpBtFrVtK7JQ0KsB1ihz15lSiMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1+Thig7+G1gDg0+I9meu93Y6kEhvbt2RzguNNeR/SeLQNfEeHsMgkzO8WbISihGQ
         12eehLYkbnDmkIvc6uENqXBmywwQP2G1QPIo+/XuYG/R1n5TGG9+7sF7eRK+Wlb4BZ
         yc0bzqHPNIsxTfJX5JZqan8AnT0wchlr6Mzxg3jA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 491/603] cxl/pci: Clarify devm host for memdev relative setup
Date:   Wed, 15 Nov 2023 14:17:16 -0500
Message-ID: <20231115191646.298052351@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit f29a824b0b6710328a78b018de3c2cfa9db65876 ]

It is all too easy to get confused about @dev usage in the CXL driver
stack. Before adding a new cxl_pci_probe() setup operation that has a
devm lifetime dependent on @cxlds->dev binding, but also references
@cxlmd->dev, and prints messages, rework the devm_cxl_add_memdev() and
cxl_memdev_setup_fw_upload() function signatures to make this
distinction explicit. I.e. pass in the devm context as an @host argument
rather than infer it from other objects.

This is in preparation for adding a devm_cxl_sanitize_setup_notifier().

Note the whitespace fixup near the change of the devm_cxl_add_memdev()
signature. That uncaught typo originated in the patch that added
cxl_memdev_security_init().

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Stable-dep-of: 5f2da1971446 ("cxl/pci: Fix sanitize notifier setup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/memdev.c    | 16 ++++++++--------
 drivers/cxl/cxlmem.h         |  5 +++--
 drivers/cxl/pci.c            |  4 ++--
 tools/testing/cxl/test/mem.c |  4 ++--
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 6efe4e2a2cf53..63353d9903745 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -960,12 +960,12 @@ static const struct fw_upload_ops cxl_memdev_fw_ops = {
         .cleanup = cxl_fw_cleanup,
 };
 
-static void devm_cxl_remove_fw_upload(void *fwl)
+static void cxl_remove_fw_upload(void *fwl)
 {
 	firmware_upload_unregister(fwl);
 }
 
-int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
+int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 	struct device *dev = &cxlds->cxlmd->dev;
@@ -978,10 +978,9 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
 				       &cxl_memdev_fw_ops, mds);
 	if (IS_ERR(fwl))
 		return PTR_ERR(fwl);
-
-	return devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload, fwl);
+	return devm_add_action_or_reset(host, cxl_remove_fw_upload, fwl);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_memdev_setup_fw_upload, CXL);
+EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_fw_upload, CXL);
 
 static const struct file_operations cxl_memdev_fops = {
 	.owner = THIS_MODULE,
@@ -1019,9 +1018,10 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
 	}
 
 	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
- }
+}
 
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
@@ -1053,7 +1053,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	if (rc)
 		goto err;
 
-	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
+	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
 	return cxlmd;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 55f00ad17a772..fdb2c8dd98d0f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -84,9 +84,10 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds);
 struct cxl_memdev_state;
-int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds);
+int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds);
 int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 49d9b2ef5c5c0..58894b8b59dac 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -867,11 +867,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	cxlmd = devm_cxl_add_memdev(cxlds);
+	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-	rc = cxl_memdev_setup_fw_upload(mds);
+	rc = devm_cxl_setup_fw_upload(&pdev->dev, mds);
 	if (rc)
 		return rc;
 
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 464fc39ed2776..68118c37f0b56 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1450,11 +1450,11 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	mdata->mes.mds = mds;
 	cxl_mock_add_event_logs(&mdata->mes);
 
-	cxlmd = devm_cxl_add_memdev(cxlds);
+	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-	rc = cxl_memdev_setup_fw_upload(mds);
+	rc = devm_cxl_setup_fw_upload(&pdev->dev, mds);
 	if (rc)
 		return rc;
 
-- 
2.42.0




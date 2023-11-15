Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46F97ECFA0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjKOTtn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjKOTtm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:49:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774ABB9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:49:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4680C433C7;
        Wed, 15 Nov 2023 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077778;
        bh=sR+tJg+KSN6WBmxz/pkUX4lfdy8F4Sa5C92DxMviON0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMPPyY3aRRwPVwc18peujqUiHGY8D1gqImhgFAc+wMbBjZ/XdFDxXrxAu7ga3/oaW
         JIyv9oiMZfQc5BTLKYFo65m7jHUH7slIroD+KFHsaR+s9sdb3dRPFaSKVpG/afPIxT
         7b02UpHPeYhUGAOMB6NRnmfHlsGjHsolzN5MtYxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 492/603] cxl/pci: Fix sanitize notifier setup
Date:   Wed, 15 Nov 2023 14:17:17 -0500
Message-ID: <20231115191646.355835828@linuxfoundation.org>
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

[ Upstream commit 5f2da19714465739da2449253b13ac06cb353a26 ]

Fix a race condition between the mailbox-background command interrupt
firing and the security-state sysfs attribute being removed.

The race is difficult to see due to the awkward placement of the
sanitize-notifier setup code and the multiple places the teardown calls
are made, cxl_memdev_security_init() and cxl_memdev_security_shutdown().

Unify setup in one place, cxl_sanitize_setup_notifier(). Arrange for
the paired cxl_sanitize_teardown_notifier() to safely quiet the notifier
and let the cxl_memdev + irq be unregistered later in the flow.

Note: The special wrinkle of the sanitize notifier is that it interacts
with interrupts, which are enabled early in the flow, and it interacts
with memdev sysfs which is not initialized until late in the flow. Hence
why this setup routine takes an @cxlmd argument, and not just @mds.

This fix is also needed as a preparation fix for a memdev unregistration
crash.

Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Closes: http://lore.kernel.org/r/20230929100316.00004546@Huawei.com
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/memdev.c | 86 ++++++++++++++++++++-------------------
 drivers/cxl/cxlmem.h      |  2 +
 drivers/cxl/pci.c         |  4 ++
 3 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 63353d9903745..4c2e24a1a89c2 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -556,20 +556,11 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 }
 EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
 
-static void cxl_memdev_security_shutdown(struct device *dev)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
-
-	cancel_delayed_work_sync(&mds->security.poll_dwork);
-}
-
 static void cxl_memdev_shutdown(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
 	down_write(&cxl_memdev_rwsem);
-	cxl_memdev_security_shutdown(dev);
 	cxlmd->cxlds = NULL;
 	up_write(&cxl_memdev_rwsem);
 }
@@ -991,35 +982,6 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-static void put_sanitize(void *data)
-{
-	struct cxl_memdev_state *mds = data;
-
-	sysfs_put(mds->security.sanitize_node);
-}
-
-static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
-{
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct device *dev = &cxlmd->dev;
-	struct kernfs_node *sec;
-
-	sec = sysfs_get_dirent(dev->kobj.sd, "security");
-	if (!sec) {
-		dev_err(dev, "sysfs_get_dirent 'security' failed\n");
-		return -ENODEV;
-	}
-	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
-	sysfs_put(sec);
-	if (!mds->security.sanitize_node) {
-		dev_err(dev, "sysfs_get_dirent 'state' failed\n");
-		return -ENODEV;
-	}
-
-	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
-}
-
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds)
 {
@@ -1049,10 +1011,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 	if (rc)
 		goto err;
 
-	rc = cxl_memdev_security_init(cxlmd);
-	if (rc)
-		goto err;
-
 	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
@@ -1069,6 +1027,50 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
 
+static void sanitize_teardown_notifier(void *data)
+{
+	struct cxl_memdev_state *mds = data;
+	struct kernfs_node *state;
+
+	/*
+	 * Prevent new irq triggered invocations of the workqueue and
+	 * flush inflight invocations.
+	 */
+	mutex_lock(&mds->mbox_mutex);
+	state = mds->security.sanitize_node;
+	mds->security.sanitize_node = NULL;
+	mutex_unlock(&mds->mbox_mutex);
+
+	cancel_delayed_work_sync(&mds->security.poll_dwork);
+	sysfs_put(state);
+}
+
+int devm_cxl_sanitize_setup_notifier(struct device *host,
+				     struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct kernfs_node *sec;
+
+	if (!test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
+		return 0;
+
+	/*
+	 * Note, the expectation is that @cxlmd would have failed to be
+	 * created if these sysfs_get_dirent calls fail.
+	 */
+	sec = sysfs_get_dirent(cxlmd->dev.kobj.sd, "security");
+	if (!sec)
+		return -ENOENT;
+	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
+	sysfs_put(sec);
+	if (!mds->security.sanitize_node)
+		return -ENOENT;
+
+	return devm_add_action_or_reset(host, sanitize_teardown_notifier, mds);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_sanitize_setup_notifier, CXL);
+
 __init int cxl_memdev_init(void)
 {
 	dev_t devt;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index fdb2c8dd98d0f..fbdee1d637175 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -86,6 +86,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds);
+int devm_cxl_sanitize_setup_notifier(struct device *host,
+				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
 int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds);
 int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 58894b8b59dac..05f3d14921e6a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -875,6 +875,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
+	if (rc)
+		return rc;
+
 	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
 	for (i = 0; i < pmu_count; i++) {
 		struct cxl_pmu_regs pmu_regs;
-- 
2.42.0




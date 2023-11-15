Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12F97ECF8F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbjKOTtR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjKOTtQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:49:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E340B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:49:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A84C433C8;
        Wed, 15 Nov 2023 19:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077752;
        bh=+WHmeOmy3RSU98v88t7X0saDTwSbJBxUXZ0nxFyUzWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CUfWydGBOF4JuESyJ/vOT283qpZJ1y+hYagNnqFC6XB1Y9D9dl6Yyqqhp01BeprN
         B0zkvAUxLrB+D29NwE1puNMcsTV406QfzjpXcPpKuvRfcb4Vt4E0aoPt2TnDYKRyhS
         ANpPZ+js47r0ti5yJ9zvAiqzbVPZGUODn1D5AXdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 490/603] cxl/pci: Remove inconsistent usage of dev_err_probe()
Date:   Wed, 15 Nov 2023 14:17:15 -0500
Message-ID: <20231115191646.240186777@linuxfoundation.org>
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

[ Upstream commit 2627c995c15dc375f4b5a591d782a14b1c0e3e7d ]

If dev_err_probe() is to be used it should at least be used consistently
within the same function. It is also worth questioning whether
every potential -ENOMEM needs an explicit error message.

Remove the cxl_setup_fw_upload() error prints for what are rare /
hardware-independent failures.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Stable-dep-of: 5f2da1971446 ("cxl/pci: Fix sanitize notifier setup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/memdev.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 2a7a07f6d1652..6efe4e2a2cf53 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -970,7 +970,6 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 	struct device *dev = &cxlds->cxlmd->dev;
 	struct fw_upload *fwl;
-	int rc;
 
 	if (!test_bit(CXL_MEM_COMMAND_ID_GET_FW_INFO, mds->enabled_cmds))
 		return 0;
@@ -978,17 +977,9 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
 	fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
 				       &cxl_memdev_fw_ops, mds);
 	if (IS_ERR(fwl))
-		return dev_err_probe(dev, PTR_ERR(fwl),
-				     "Failed to register firmware loader\n");
-
-	rc = devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload,
-				      fwl);
-	if (rc)
-		dev_err(dev,
-			"Failed to add firmware loader remove action: %d\n",
-			rc);
+		return PTR_ERR(fwl);
 
-	return rc;
+	return devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload, fwl);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_setup_fw_upload, CXL);
 
-- 
2.42.0




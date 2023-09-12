Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1CC79BCF9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbjIKWmt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbjIKPRE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:17:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC54BFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:16:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF9AC433C8;
        Mon, 11 Sep 2023 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445418;
        bh=GmMMVPzc8cEJpJFowJqdLSJ4jiHT4GrEtiYJfQVNu4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5cip1/DwfnwAhr4NNuq6fROfOFpwV+CxeWq0wdydxPdUZ7ziVZpaFN1/JFxOzFeF
         3hKSAraOIkBf3sE68aydGDCqh/RRNeiAO7sa+rdNrCcmBFCphXJKbpSFD9VmJk5zwV
         z1NwOLV0ZZELUAZdsIhDSwW0/4Ja8/vxHfOlfBbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ee Wey Lim <ee.wey.lim@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 341/600] EDAC/igen6: Fix the issue of no error events
Date:   Mon, 11 Sep 2023 15:46:14 +0200
Message-ID: <20230911134643.756362958@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[ Upstream commit ce53ad81ed36c24aff075f94474adecfabfcf239 ]

Current igen6_edac checks for pending errors before the registration
of the error handler. However, there is a possibility that the error
occurs during the registration process, leading to unhandled pending
errors and no future error events. This issue can be reproduced by
repeatedly injecting errors during the loading of the igen6_edac.

Fix this issue by moving the pending error handler after the registration
of the error handler, ensuring that no pending errors are left unhandled.

Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC")
Reported-by: Ee Wey Lim <ee.wey.lim@intel.com>
Tested-by: Ee Wey Lim <ee.wey.lim@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20230725080427.23883-1-qiuxu.zhuo@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/igen6_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index a07bbfd075d06..8ec70da8d84fe 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -27,7 +27,7 @@
 #include "edac_mc.h"
 #include "edac_module.h"
 
-#define IGEN6_REVISION	"v2.5"
+#define IGEN6_REVISION	"v2.5.1"
 
 #define EDAC_MOD_STR	"igen6_edac"
 #define IGEN6_NMI_NAME	"igen6_ibecc"
@@ -1216,9 +1216,6 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&ecclog_work, ecclog_work_cb);
 	init_irq_work(&ecclog_irq_work, ecclog_irq_work_cb);
 
-	/* Check if any pending errors before registering the NMI handler */
-	ecclog_handler();
-
 	rc = register_err_handler();
 	if (rc)
 		goto fail3;
@@ -1230,6 +1227,9 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto fail4;
 	}
 
+	/* Check if any pending errors before/during the registration of the error handler */
+	ecclog_handler();
+
 	igen6_debug_setup();
 	return 0;
 fail4:
-- 
2.40.1




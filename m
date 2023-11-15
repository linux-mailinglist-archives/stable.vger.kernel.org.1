Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F9B7ED0C8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbjKOT5a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343608AbjKOT5a (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:57:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EE3B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:57:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86CDC433C8;
        Wed, 15 Nov 2023 19:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078246;
        bh=rNPu8325FqMezEDeLwyGj6IOvCIMxuvnj8914+Ix1EU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2WM/WIBqf+zRbxT6u+eZqDvJx9WbyvUUQfVBlVZmDwCxDuVkO2Vl23KzS/fVuruFi
         Mfq5QXuBoc8Oer/Q5jDBRCe2ztWR1plhp1rZpYlJiBRS9SObp3ovfmnH2KAC/AJXu1
         Q+zPHGUBJnarCP7QrqE/U9jXoy94gBp2vcJz/S08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chen Ni <nichen@iscas.ac.cn>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 203/379] libnvdimm/of_pmem: Use devm_kstrdup instead of kstrdup and check its return value
Date:   Wed, 15 Nov 2023 14:24:38 -0500
Message-ID: <20231115192657.123345198@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 6fd4ebfc4d61e3097b595ab2725d513e3bbd6739 ]

Use devm_kstrdup() instead of kstrdup() and check its return value to
avoid memory leak.

Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/of_pmem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 10dbdcdfb9ce9..0243789ba914b 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -30,7 +30,13 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
+	priv->bus_desc.provider_name = devm_kstrdup(&pdev->dev, pdev->name,
+							GFP_KERNEL);
+	if (!priv->bus_desc.provider_name) {
+		kfree(priv);
+		return -ENOMEM;
+	}
+
 	priv->bus_desc.module = THIS_MODULE;
 	priv->bus_desc.of_node = np;
 
-- 
2.42.0




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD9D713ED0
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjE1TjI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjE1TjH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:39:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6133AB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65C0661E8C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85141C4339B;
        Sun, 28 May 2023 19:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302745;
        bh=GmOMBMad9/UDTBV1fdiAF65EpRlvRm5nU56TV8pMOBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zlallnOGzlE6ZS8YK9C7qnJvf/35TFSbo8eJNHcvYObO7VvFyvFt5WNzVoCz8s1M
         wjg4FMzu5+rGnhsVLcsIX+bvtuXBnMFKKVPoZXt5Qac3gMs/7f34pVzfG4JxcSeBEG
         eF0fhQd8W8TRwH2o+pLr/B2X98zdwMeiazLcARKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 001/211] driver core: add a helper to setup both the of_node and fwnode of a device
Date:   Sun, 28 May 2023 20:08:42 +0100
Message-Id: <20230528190843.553081669@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit 43e76d463c09a0272b84775bcc727c1eb8b384b2 ]

There are many places where both the fwnode_handle and the of_node of a
device need to be populated. Add a function which does both so that we
have consistency.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: a26cc2934331 ("drm/mipi-dsi: Set the fwnode for mipi_dsi_device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/core.c    | 7 +++++++
 include/linux/device.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 9a874a58d690c..cb859febd03cf 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4352,6 +4352,13 @@ void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
 }
 EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
 
+void device_set_node(struct device *dev, struct fwnode_handle *fwnode)
+{
+	dev->fwnode = fwnode;
+	dev->of_node = to_of_node(fwnode);
+}
+EXPORT_SYMBOL_GPL(device_set_node);
+
 int device_match_name(struct device *dev, const void *name)
 {
 	return sysfs_streq(dev_name(dev), name);
diff --git a/include/linux/device.h b/include/linux/device.h
index 5dc0f81e4f9d4..4f7e0c85e11fa 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -818,6 +818,7 @@ int device_online(struct device *dev);
 void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
+void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
 
 static inline int dev_num_vf(struct device *dev)
 {
-- 
2.39.2




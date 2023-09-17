Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3945B7A3C5D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbjIQUaZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240945AbjIQU3y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:29:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E02B10A
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:29:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA4AC433C8;
        Sun, 17 Sep 2023 20:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982588;
        bh=IB2NMNugWKIFEG3hfaLog2ka5j2AsoDYTJT2PuNOpxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0SrkNlv6F1TFlKxLlpPA2VOq9aSQb8+PowQB2JJe4Fl1cZfxFrxsGFDNlPr7LxUS
         N2iU1ef4zjquYQC5KhTFkjfg5D9GljCbC+lpSFKsDBJ4giRA6iXpK9Sq0LG8/FMmMS
         IQRrrFNBo9pjfxid44lJvJvvHgHUlJyawvOlNygE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 294/511] amba: bus: fix refcount leak
Date:   Sun, 17 Sep 2023 21:12:01 +0200
Message-ID: <20230917191120.937523917@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit e312cbdc11305568554a9e18a2ea5c2492c183f3 ]

commit 5de1540b7bc4 ("drivers/amba: create devices from device tree")
increases the refcount of of_node, but not releases it in
amba_device_release, so there is refcount leak. By using of_node_put
to avoid refcount leak.

Fixes: 5de1540b7bc4 ("drivers/amba: create devices from device tree")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230821023928.3324283-1-peng.fan@oss.nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/amba/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 6c0f7f4f7d1de..1af5ff9231eb0 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -366,6 +366,7 @@ static void amba_device_release(struct device *dev)
 {
 	struct amba_device *d = to_amba_device(dev);
 
+	of_node_put(d->dev.of_node);
 	if (d->res.parent)
 		release_resource(&d->res);
 	kfree(d);
-- 
2.40.1




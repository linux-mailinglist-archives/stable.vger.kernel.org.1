Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC53D79B093
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbjIKWkE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbjIKPZK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:25:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD30FD8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:25:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AF2C433C8;
        Mon, 11 Sep 2023 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445906;
        bh=083G70o8nkbEnI0lyk8I8GlG23saf5sKaP8eH1vFqko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSWIB+hvOWA0C7ccRkf9JSYJIYf/Nm1EpHU6MPG7SLCaCc8cP/AYDz3j8YgEhLQO9
         yc6vyXNwI+tqnNxE5IgpHjHtagrsTQYYQG/HZHg9J8H9qH4qBJvcU83sgT4Pl3j+kH
         QnrJacPhJDhinQNSApP1lzwbM+M9yY7hEIVB1rJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 487/600] amba: bus: fix refcount leak
Date:   Mon, 11 Sep 2023 15:48:40 +0200
Message-ID: <20230911134648.013040131@linuxfoundation.org>
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
index 110a535648d2e..0aa2d3111ae6e 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -534,6 +534,7 @@ static void amba_device_release(struct device *dev)
 {
 	struct amba_device *d = to_amba_device(dev);
 
+	of_node_put(d->dev.of_node);
 	if (d->res.parent)
 		release_resource(&d->res);
 	mutex_destroy(&d->periphid_lock);
-- 
2.40.1




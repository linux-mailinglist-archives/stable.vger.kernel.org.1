Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D467E24DC
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjKFN0I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjKFN0H (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:26:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B151D6E
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:25:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3184AC433CB;
        Mon,  6 Nov 2023 13:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277156;
        bh=6uI5E4n6CRiUGZxgyl2jXde94FZAJVYf8Mxu6VuNEc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vrtdqdQkCiLFbAwzJlauDkzbcyBbXOBChV2AWh+G3glS2dpzEGqIsT952omiBjoXQ
         KpnfOWy9Aif1fl9h1Q58RprglhrMh4vfctR4kadmlF8nhfSiky5L3r2lg1tnKGsPiP
         mYrixk9JBsyxQLPstsThEzSktMgA1e5fJ4W4zjwI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liam Beguin <liambeguin@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 056/128] iio: afe: rescale: reorder includes
Date:   Mon,  6 Nov 2023 14:03:36 +0100
Message-ID: <20231106130311.644479223@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liam Beguin <liambeguin@gmail.com>

[ Upstream commit cd717ac6f69db4953ca701c6220c7cb58e17f35a ]

Includes should be ordered alphabetically which is already the case,
but follow what is done in other drivers by separation IIO specific
headers with a blank line.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20220108205319.2046348-6-liambeguin@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: bee448390e51 ("iio: afe: rescale: Accept only offset channels")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/afe/iio-rescale.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index cc28713b0dc8b..b0934f85a4a04 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -9,14 +9,15 @@
 
 #include <linux/err.h>
 #include <linux/gcd.h>
-#include <linux/iio/consumer.h>
-#include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
+
 struct rescale;
 
 struct rescale_cfg {
-- 
2.42.0




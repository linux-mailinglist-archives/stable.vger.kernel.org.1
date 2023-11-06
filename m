Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792E37E2568
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjKFNbg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjKFNbf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:31:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE93510B
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:31:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C6DC433CA;
        Mon,  6 Nov 2023 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277492;
        bh=hjT3yPZCEfvVQLOpcF5v5gMcteKQvbOcxqrZ8roIveY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yfrWDttLfGAaJES/D8BmWjiHciNg7xa8ZbXVKPkSImXJJqzM3ilfk+YeQ2hXuP4DS
         AeGLhw2VOSFJrS+FQ7eVggWSBu5RaCdbPADG811noxEar1ZRS5mnXM34S9Fd7rkC98
         iXhOfuC4E9C12sOWsTwft/MypPiWtfFchOVwP0/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Anand Ashok Dumbre <anandash@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 41/95] iio: adc: xilinx: use devm_krealloc() instead of kfree() + kcalloc()
Date:   Mon,  6 Nov 2023 14:04:09 +0100
Message-ID: <20231106130306.215378369@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

[ Upstream commit eab64715709ed440d54cac42f239e2d49df26c1f ]

We now have devm_krealloc() in the kernel Use it indstead of calling
kfree() and kcalloc() separately.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Tested-by: Anand Ashok Dumbre <anandash@xilinx.com>
Reviewed-by: Anand Ashok Dumbre <anandash@xilinx.com>
Link: https://lore.kernel.org/r/20201130142759.28216-3-brgl@bgdev.pl
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 8d6b3ea4d9ea ("iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature thresholds")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/xilinx-xadc-core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 8494eb424b331..6f89a97bb127b 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -585,15 +586,22 @@ static int xadc_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *mask)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
-	unsigned int n;
+	size_t new_size, n;
+	void *data;
 
 	n = bitmap_weight(mask, indio_dev->masklength);
 
-	kfree(xadc->data);
-	xadc->data = kcalloc(n, sizeof(*xadc->data), GFP_KERNEL);
-	if (!xadc->data)
+	if (check_mul_overflow(n, sizeof(*xadc->data), &new_size))
+		return -ENOMEM;
+
+	data = devm_krealloc(indio_dev->dev.parent, xadc->data,
+			     new_size, GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
+	memset(data, 0, new_size);
+	xadc->data = data;
+
 	return 0;
 }
 
@@ -1372,7 +1380,6 @@ static int xadc_remove(struct platform_device *pdev)
 	free_irq(xadc->irq, indio_dev);
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	clk_disable_unprepare(xadc->clk);
-	kfree(xadc->data);
 
 	return 0;
 }
-- 
2.42.0




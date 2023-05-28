Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4D1713C27
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjE1TF3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjE1TF2 (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 28 May 2023 15:05:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A775790
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 12:05:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4577C618C1
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 19:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6203CC433D2;
        Sun, 28 May 2023 19:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300726;
        bh=Bc48EMUwOxwWY0XBU8MT378VreyDl91iIt8rILDjW64=;
        h=Subject:To:From:Date:From;
        b=Y6pNkdboV75bU3MUUpuygbLxRZM+KAyyshsSSulIOdzBUMSWVigDQu4/ofKw80xZw
         ERD+xrUH04Bbb22BYpcZoKRCKIcYq4/XioyYHZfj+6iwwjYOGmEbaBBeWu7ddo5AiE
         ZLlKW9pBYKPFxmTdqZXDqSl1CAiecBhmNUvsUqoQ=
Subject: patch "iio: accel: kx022a fix irq getting" added to char-misc-linus
To:     mazziesaccount@gmail.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, error27@gmail.com, lkp@intel.com
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 20:04:43 +0100
Message-ID: <2023052842-anthology-unlaced-d2d6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    iio: accel: kx022a fix irq getting

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 56cd3d1c5c5b073a1a444eafdcf97d4d866d351a Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Fri, 12 May 2023 10:53:41 +0300
Subject: iio: accel: kx022a fix irq getting

The fwnode_irq_get_byname() was returning 0 at device-tree mapping
error. If this occurred, the KX022A driver did abort the probe but
errorneously directly returned the return value from
fwnode_irq_get_byname() from probe. In case of a device-tree mapping
error this indicated success.

The fwnode_irq_get_byname() has since been fixed to not return zero on
error so the check for fwnode_irq_get_byname() can be relaxed to only
treat negative values as errors. This will also do decent fix even when
backported to branches where fwnode_irq_get_byname() can still return
zero on error because KX022A probe should later fail at IRQ requesting
and a prober error handling should follow.

Relax the return value check for fwnode_irq_get_byname() to only treat
negative values as errors.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202305110245.MFxC9bUj-lkp@intel.com/
Link: https://lore.kernel.org/r/202305110245.MFxC9bUj-lkp@intel.com/
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
Link: https://lore.kernel.org/r/b45b4b638db109c6078d243252df3a7b0485f7d5.1683875389.git.mazziesaccount@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/kionix-kx022a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index f98393d74666..b8636fa8eaeb 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -1048,7 +1048,7 @@ int kx022a_probe_internal(struct device *dev)
 		data->ien_reg = KX022A_REG_INC4;
 	} else {
 		irq = fwnode_irq_get_byname(fwnode, "INT2");
-		if (irq <= 0)
+		if (irq < 0)
 			return dev_err_probe(dev, irq, "No suitable IRQ\n");
 
 		data->inc_reg = KX022A_REG_INC5;
-- 
2.40.1



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04736726C1D
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjFGUax (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjFGUai (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ACF26A8
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81087644DB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91842C433EF;
        Wed,  7 Jun 2023 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169828;
        bh=6VU2zzIwr+RE9Mo8aCwBp2NGZ4D6lf2FlnQQ66bN+3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbK7EpQdkRHzLcsZM3p2kBbb9uSu4mdGFW0wrpBJ3RdSrxHSJ2+cTwxHFtsOJO50c
         ZgIiGu2ul7eIReywhaYHNDivovOQaBW6fetbhoZFl9Wr7fM7XG7BrsAOFD3T5ePVJ4
         GKQYg5jP3/s4eZ6c3J/XmbIFuDpOeuVZUccFc9so=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.3 200/286] iio: accel: kx022a fix irq getting
Date:   Wed,  7 Jun 2023 22:14:59 +0200
Message-ID: <20230607200929.788653588@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matti Vaittinen <mazziesaccount@gmail.com>

commit 56cd3d1c5c5b073a1a444eafdcf97d4d866d351a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/kionix-kx022a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -1049,7 +1049,7 @@ int kx022a_probe_internal(struct device
 		data->ien_reg = KX022A_REG_INC4;
 	} else {
 		irq = fwnode_irq_get_byname(fwnode, "INT2");
-		if (irq <= 0)
+		if (irq < 0)
 			return dev_err_probe(dev, irq, "No suitable IRQ\n");
 
 		data->inc_reg = KX022A_REG_INC5;



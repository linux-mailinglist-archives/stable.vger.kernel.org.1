Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD26275D2DB
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjGUTE1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjGUTE0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:04:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A2B30CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3433161D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47150C433C7;
        Fri, 21 Jul 2023 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966264;
        bh=N0txIJK9m+Tke0rUyk9BBXW9NpZikMD7G70aXP5hwB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnNdCGcWM5KyKEOOaNW+4f7HcKSSrVyLrc7E8a2kdKPo2qyG+g3KiAg9jmkTi3Ne7
         qgMgLlwr2xSJYZ0395Is8LYGnTvlJKmbg8tz77TE5a4DOLilGxpCZKKyKVdCmHfzQB
         3XAVbHIbF/NiMalX+RbNFNfyV0p/F+TMihq3xoV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Nyekjaer <sean@geanix.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15 255/532] iio: accel: fxls8962af: errata bug only applicable for FXLS8962AF
Date:   Fri, 21 Jul 2023 18:02:39 +0200
Message-ID: <20230721160628.177095841@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Nyekjaer <sean@geanix.com>

commit b410a9307bc3a7cdee3c930c98f6fc9cf1d2c484 upstream.

Remove special errata handling if FXLS8964AF is used.

Fixes: af959b7b96b8 ("iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230605103223.1400980-2-sean@geanix.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/fxls8962af-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -656,9 +656,10 @@ static int fxls8962af_fifo_transfer(stru
 	int total_length = samples * sample_length;
 	int ret;
 
-	if (i2c_verify_client(dev))
+	if (i2c_verify_client(dev) &&
+	    data->chip_info->chip_id == FXLS8962AF_DEVICE_ID)
 		/*
-		 * Due to errata bug:
+		 * Due to errata bug (only applicable on fxls8962af):
 		 * E3: FIFO burst read operation error using I2C interface
 		 * We have to avoid burst reads on I2C..
 		 */



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF0275D2C4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGUTDZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGUTDY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:03:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EB630D7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:03:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18A3861D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EBFC433C8;
        Fri, 21 Jul 2023 19:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966202;
        bh=itNdLFpCd5BcD0nDAxq6C9Cltj3Ho5bFyjnuvW7mpAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPU82BIs0QaAb14ow+/6LQDYH/iLAiBJ4CrigZgPwa9wnqphYJrp7c6lIByrKRzTd
         SJPeqSR5op/CoHJ8LFsl/ovBdoZ7SVVLeEY7miYhZwlzJJuzo4tc0D1uPMP0gd6QxC
         fmk/g6vvKcNzg5Xodv0vzo3mE6+lIZRZ2r+xrtLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        Nuno Sa <nuno.sa@analog.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15 253/532] iio: adc: ad7192: Fix null ad7192_state pointer access
Date:   Fri, 21 Jul 2023 18:02:37 +0200
Message-ID: <20230721160628.074428301@linuxfoundation.org>
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

From: Fabrizio Lamarque <fl.scratchpad@gmail.com>

commit 9e58e3a6f8e1c483c86a04903b7b7aa0923e4426 upstream.

Pointer to indio_dev structure is obtained via spi_get_drvdata() at
the beginning of function ad7192_setup(), but the spi->dev->driver_data
member is not initialized, hence a NULL pointer is returned.

Fix by changing ad7192_setup() signature to take pointer to struct
iio_dev, and get ad7192_state pointer via st = iio_priv(indio_dev);

Fixes: bd5dcdeb3fd0 ("iio: adc: ad7192: convert to device-managed functions")
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230530075311.400686-2-fl.scratchpad@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7192.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -340,9 +340,9 @@ static int ad7192_of_clock_select(struct
 	return clock_sel;
 }
 
-static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
+static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 {
-	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
+	struct ad7192_state *st = iio_priv(indio_dev);
 	bool rej60_en, refin2_en;
 	bool buf_en, bipolar, burnout_curr_en;
 	unsigned long long scale_uv;
@@ -1015,7 +1015,7 @@ static int ad7192_probe(struct spi_devic
 		}
 	}
 
-	ret = ad7192_setup(st, spi->dev.of_node);
+	ret = ad7192_setup(indio_dev, spi->dev.of_node);
 	if (ret)
 		return ret;
 



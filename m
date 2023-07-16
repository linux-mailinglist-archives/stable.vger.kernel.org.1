Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448B2755127
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGPTxU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPTxT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:53:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927B2199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2437F60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F9CC433C8;
        Sun, 16 Jul 2023 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537197;
        bh=/SJTzf6cJ5rmORfMkdeRaBuuug8P0SJVYHhP41EdMjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eC3uLN15iYKK7CoYNix4htPLIgMW+Q8XU3WdH0zUOioCRmXidDel51yhmRDHP+AXn
         8ZUSXVoHmh/C5nsg5U3/dH9RkRzi2vo66twtx1CMutSLuZb1+xAwZoTAztpCWH4ctr
         4dTXKhE57oFAOdFwiQgMM/kSJO+Pjz7guJu4GylM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Nyekjaer <sean@geanix.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.4 011/800] iio: accel: fxls8962af: fixup buffer scan element type
Date:   Sun, 16 Jul 2023 21:37:44 +0200
Message-ID: <20230716194949.368554167@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Nyekjaer <sean@geanix.com>

commit d1cfbd52ede5e5fabc09992894c5733b4057f159 upstream.

Scan elements for x,y,z channels is little endian and requires no bit shifts.
LE vs. BE is controlled in register SENS_CONFIG2 and bit LE_BE, default
value is LE.

Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230605103223.1400980-1-sean@geanix.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/fxls8962af-core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -724,8 +724,7 @@ static const struct iio_event_spec fxls8
 		.sign = 's', \
 		.realbits = 12, \
 		.storagebits = 16, \
-		.shift = 4, \
-		.endianness = IIO_BE, \
+		.endianness = IIO_LE, \
 	}, \
 	.event_spec = fxls8962af_event, \
 	.num_event_specs = ARRAY_SIZE(fxls8962af_event), \



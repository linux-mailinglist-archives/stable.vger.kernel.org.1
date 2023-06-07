Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEC3726E7D
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjFGUuw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjFGUuZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051426A0
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D19DA646E1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4510C433D2;
        Wed,  7 Jun 2023 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171018;
        bh=odvwcAggtHNcPTfm+IXLPgezGhU2JT22FXQI+zmUYtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G00lE3nAmkbW666/DWgx37iQ21+pV8etEUVqqn0jr3GsE2KQJ05i5f9YSsYEpJEeW
         xmfg2mC7o/vde9yunY5CQUF12JFvUGwCo5JFvK5Ob/9KysvoEm7SlummEt9zgY2Wjv
         WJYEWdRJhRriGyWlgUeHReSux3A4vk55O+sbqK+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10 080/120] iio: dac: build ad5758 driver when AD5758 is selected
Date:   Wed,  7 Jun 2023 22:16:36 +0200
Message-ID: <20230607200903.419579131@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

commit a146eccb68be161ae9eab5f3f68bb0ed7c0fbaa8 upstream.

Commit 28d1a7ac2a0d ("iio: dac: Add AD5758 support") adds the config AD5758
and the corresponding driver ad5758.c. In the Makefile, the ad5758 driver
is however included when AD5755 is selected, not when AD5758 is selected.

Probably, this was simply a mistake that happened by copy-and-paste and
forgetting to adjust the actual line. Surprisingly, no one has ever noticed
that this driver is actually only included when AD5755 is selected and that
the config AD5758 has actually no effect on the build.

Fixes: 28d1a7ac2a0d ("iio: dac: Add AD5758 support")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Link: https://lore.kernel.org/r/20230508040208.12033-1-lukas.bulwahn@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_AD5592R_BASE) += ad5592r-ba
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
 obj-$(CONFIG_AD5755) += ad5755.o
-obj-$(CONFIG_AD5755) += ad5758.o
+obj-$(CONFIG_AD5758) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5770R) += ad5770r.o



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8F5726DC6
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjFGUpZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjFGUpG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF91226BB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:44:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EE196466D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF519C4339B;
        Wed,  7 Jun 2023 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170690;
        bh=kXg0VRiq1HvTPTg20ktQW2tm8uqGv4kUk5v7w0vgB2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFqvCm5Skomy8FmNoOsR4me5QN9KKoGfkB+JPhC7+ATvayVeiwS7wOIL/x0bvwiH+
         rubMuZZLA7qIoT743FKX2xtOdL7LMwpnTvJtcpEMDJ4vbQyPbwKNsLLPqo67Qk8BE1
         dCPgHOrB1/nWn6F0Gtgz+vmKDmBZ3Ht0r+hjGAdo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Nyekjaer <sean@geanix.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 153/225] iio: adc: stm32-adc: skip adc-diff-channels setup if none is present
Date:   Wed,  7 Jun 2023 22:15:46 +0200
Message-ID: <20230607200919.414822828@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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

From: Sean Nyekjaer <sean@geanix.com>

commit 9c0d6ccd7d6bbd275e390b55a3390b4274291d95 upstream.

If no adc differential channels are defined driver will fail with EINVAL:
stm32-adc: probe of 48003000.adc:adc@0 failed with error -22

Fix this by skipping the initialization if no channels are defined.

This applies only to the legacy way of initializing adc channels.

Fixes: d7705f35448a ("iio: adc: stm32-adc: convert to device properties")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://lore.kernel.org/r/20230503162029.3654093-1-sean@geanix.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/stm32-adc.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1882,16 +1882,15 @@ static int stm32_adc_get_legacy_chan_cou
 	 * to get the *real* number of channels.
 	 */
 	ret = device_property_count_u32(dev, "st,adc-diff-channels");
-	if (ret < 0)
-		return ret;
-
-	ret /= (int)(sizeof(struct stm32_adc_diff_channel) / sizeof(u32));
-	if (ret > adc_info->max_channels) {
-		dev_err(&indio_dev->dev, "Bad st,adc-diff-channels?\n");
-		return -EINVAL;
-	} else if (ret > 0) {
-		adc->num_diff = ret;
-		num_channels += ret;
+	if (ret > 0) {
+		ret /= (int)(sizeof(struct stm32_adc_diff_channel) / sizeof(u32));
+		if (ret > adc_info->max_channels) {
+			dev_err(&indio_dev->dev, "Bad st,adc-diff-channels?\n");
+			return -EINVAL;
+		} else if (ret > 0) {
+			adc->num_diff = ret;
+			num_channels += ret;
+		}
 	}
 
 	/* Optional sample time is provided either for each, or all channels */



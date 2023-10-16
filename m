Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854767CAC46
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjJPOw0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPOwZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:52:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829A795
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:52:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9577AC433C9;
        Mon, 16 Oct 2023 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467943;
        bh=q72QzUHmL7bZIamL0Umi4sCnBFtrEnJZFOnVkbFkUQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ch2n1Su73ctXWYf+N+7t5f5RqoHAZBqR5+CbSGMO1rC6bBgC4hNW811xh5zp8EEqu
         HWjKSK7fUA+fwiU6ZtCxbwsjbvi6R0fgVgg8BlBMlnMluL0BVP63ntXLCDbs8VNCff
         7drUmzJlSF5mbYcn9td1mk8jYD8HIHj81tCWDQwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Philipp Rossak <embed3d@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.5 112/191] iio: adc: imx8qxp: Fix address for command buffer registers
Date:   Mon, 16 Oct 2023 10:41:37 +0200
Message-ID: <20231016084018.000410041@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Rossak <embed3d@gmail.com>

commit 850101b3598277794f92a9e363a60a66e0d42890 upstream.

The ADC Command Buffer Register high and low are currently pointing to
the wrong address and makes it impossible to perform correct
ADC measurements over all channels.

According to the datasheet of the imx8qxp the ADC_CMDL register starts
at address 0x100 and the ADC_CMDH register starts at address 0x104.

This bug seems to be in the kernel since the introduction of this
driver.

This can be observed by checking all raw voltages of the adc and they
are all nearly identical:

cat /sys/bus/iio/devices/iio\:device0/in_voltage*_raw
3498
3494
3491
3491
3489
3490
3490
3490

Fixes: 1e23dcaa1a9fa ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC")
Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Acked-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://lore.kernel.org/r/20230904220204.23841-1-embed3d@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/imx8qxp-adc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -38,8 +38,8 @@
 #define IMX8QXP_ADR_ADC_FCTRL		0x30
 #define IMX8QXP_ADR_ADC_SWTRIG		0x34
 #define IMX8QXP_ADR_ADC_TCTRL(tid)	(0xc0 + (tid) * 4)
-#define IMX8QXP_ADR_ADC_CMDH(cid)	(0x100 + (cid) * 8)
-#define IMX8QXP_ADR_ADC_CMDL(cid)	(0x104 + (cid) * 8)
+#define IMX8QXP_ADR_ADC_CMDL(cid)	(0x100 + (cid) * 8)
+#define IMX8QXP_ADR_ADC_CMDH(cid)	(0x104 + (cid) * 8)
 #define IMX8QXP_ADR_ADC_RESFIFO		0x300
 #define IMX8QXP_ADR_ADC_TST		0xffc
 



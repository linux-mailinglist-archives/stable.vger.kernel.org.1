Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F997CAC68
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjJPOyQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjJPOyP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:54:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D735AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:54:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CEAC433C7;
        Mon, 16 Oct 2023 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468051;
        bh=whRvQcdNO3k4poJha3HM21sJOBsq9NcB9IS/BedCQGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XniOm8xlpyxp05MMwXy+qL2+tubHxWodthwhCjAmJpSFYQU11fwzWP1q18Cl0BYSP
         Kl5J4yxvZDLsGbKDQ32vSwtOpv9ZGUy5Gq897FZncH3bTMhDTZkS4OAXYh71PEpo1a
         feXbRi6uqk5c6p8K1LecyKsFJSYXxg2MmpFzSyLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.5 115/191] iio: pressure: dps310: Adjust Timeout Settings
Date:   Mon, 16 Oct 2023 10:41:40 +0200
Message-ID: <20231016084018.067649187@linuxfoundation.org>
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

From: Lakshmi Yadlapati <lakshmiy@us.ibm.com>

commit 901a293fd96fb9bab843ba4cc7be3094a5aa7c94 upstream.

The DPS310 sensor chip has been encountering intermittent errors while
reading the sensor device across various system designs. This issue causes
the chip to become "stuck," preventing the indication of "ready" status
for pressure and temperature measurements in the MEAS_CFG register.

To address this issue, this commit fixes the timeout settings to improve
sensor stability:
- After sending a reset command to the chip, the timeout has been extended
  from 2.5 ms to 15 ms, aligning with the DPS310 specification.
- The read timeout value of the MEAS_CFG register has been adjusted from
  20ms to 30ms to match the specification.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Fixes: 7b4ab4abcea4 ("iio: pressure: dps310: Reset chip after timeout")
Link: https://lore.kernel.org/r/20230829180222.3431926-2-lakshmiy@us.ibm.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/pressure/dps310.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -57,8 +57,8 @@
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
 
-/* Make sure sleep time is <= 20ms for usleep_range */
-#define DPS310_POLL_SLEEP_US(t)		min(20000, (t) / 8)
+/* Make sure sleep time is <= 30ms for usleep_range */
+#define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
 /* Silently handle error in rate value here */
 #define DPS310_POLL_TIMEOUT_US(rc)	((rc) <= 0 ? 1000000 : 1000000 / (rc))
 
@@ -402,8 +402,8 @@ static int dps310_reset_wait(struct dps3
 	if (rc)
 		return rc;
 
-	/* Wait for device chip access: 2.5ms in specification */
-	usleep_range(2500, 12000);
+	/* Wait for device chip access: 15ms in specification */
+	usleep_range(15000, 55000);
 	return 0;
 }
 



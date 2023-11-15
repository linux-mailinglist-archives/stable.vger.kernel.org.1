Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA27ECB14
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjKOTUA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjKOTT7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:19:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D67512C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:19:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5222C433C7;
        Wed, 15 Nov 2023 19:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700075996;
        bh=Qzk3evVISz2NP+5cMaDJ/Q9CONTa0Mrg5Rt1kFpZI9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6/KRLLcpB4J+NOjDiwVOkwRDlPbDdqWRAhm5gl0JtzrBWB5KUmrpwClhJnR6+suX
         Y2wVHWVQiwdUPpMrjPfLaw+08YZzOJzQi/t/XFJpbjx8CTjfLRox6nc8epOYB2JHJ+
         tYq73dTMAfQ4+ldJMInT52ZGBR0ir/ADWG+6IRJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zev Weiss <zev@bewilderbeest.net>,
        Thomas Zajic <zlatko@gmx.at>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.5 001/550] hwmon: (nct6775) Fix incorrect variable reuse in fan_div calculation
Date:   Wed, 15 Nov 2023 14:09:45 -0500
Message-ID: <20231115191600.816263857@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zev Weiss <zev@bewilderbeest.net>

commit 920057ad521dc8669e534736c2a12c14ec9fb2d7 upstream.

In the regmap conversion in commit 4ef2774511dc ("hwmon: (nct6775)
Convert register access to regmap API") I reused the 'reg' variable
for all three register reads in the fan speed calculation loop in
nct6775_update_device(), but failed to notice that the value from the
first one (data->REG_FAN[i]) is actually used in the call to
nct6775_select_fan_div() at the end of the loop body.  Since that
patch the register value passed to nct6775_select_fan_div() has been
(conditionally) incorrectly clobbered with the value of a different
register than intended, which has in at least some cases resulted in
fan speeds being adjusted down to zero.

Fix this by using dedicated temporaries for the two intermediate
register reads instead of 'reg'.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Fixes: 4ef2774511dc ("hwmon: (nct6775) Convert register access to regmap API")
Reported-by: Thomas Zajic <zlatko@gmx.at>
Tested-by: Thomas Zajic <zlatko@gmx.at>
Cc: stable@vger.kernel.org # v5.19+
Link: https://lore.kernel.org/r/20230929200822.964-2-zev@bewilderbeest.net
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/nct6775-core.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -1581,17 +1581,21 @@ struct nct6775_data *nct6775_update_devi
 							  data->fan_div[i]);
 
 			if (data->has_fan_min & BIT(i)) {
-				err = nct6775_read_value(data, data->REG_FAN_MIN[i], &reg);
+				u16 tmp;
+
+				err = nct6775_read_value(data, data->REG_FAN_MIN[i], &tmp);
 				if (err)
 					goto out;
-				data->fan_min[i] = reg;
+				data->fan_min[i] = tmp;
 			}
 
 			if (data->REG_FAN_PULSES[i]) {
-				err = nct6775_read_value(data, data->REG_FAN_PULSES[i], &reg);
+				u16 tmp;
+
+				err = nct6775_read_value(data, data->REG_FAN_PULSES[i], &tmp);
 				if (err)
 					goto out;
-				data->fan_pulses[i] = (reg >> data->FAN_PULSE_SHIFT[i]) & 0x03;
+				data->fan_pulses[i] = (tmp >> data->FAN_PULSE_SHIFT[i]) & 0x03;
 			}
 
 			err = nct6775_select_fan_div(dev, data, i, reg);



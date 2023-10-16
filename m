Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E847CAC7A
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjJPOzO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjJPOzN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:55:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEB1D9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:55:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F922C433C7;
        Mon, 16 Oct 2023 14:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468111;
        bh=QTp1pFRAeOX0WEwgHg60LvKH9DBJ/JDUrqrjwRpWg/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CiuGJmBFfZ8tzGP0/qOERhLdsmOg5UwYsAGuZ1FBuEQ2HEqtYuQC3WxE5CeeQFZmq
         wk4wfdoa/F78fAtdgBLepefusHfk/gtAhR3JRGtkPWJFVpimelLvFy2+RwJDhosFWJ
         5OqtDZsVGbypM+VqCzy6ILZoHvxd+f8IJ+tzj+mU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.5 160/191] power: supply: qcom_battmgr: fix battery_id type
Date:   Mon, 16 Oct 2023 10:42:25 +0200
Message-ID: <20231016084019.107583480@linuxfoundation.org>
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

From: Sebastian Reichel <sebastian.reichel@collabora.com>

commit 383eba9f9a7f4cd639d367ea5daa6df2be392c54 upstream.

qcom_battmgr_update_request.battery_id is written to using cpu_to_le32()
and should be of type __le32, just like all other 32bit integer requests
for qcom_battmgr.

Cc: stable@vger.kernel.org	# 6.3
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309162149.4owm9iXc-lkp@intel.com/
Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230919124222.1155894-1-sebastian.reichel@collabora.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/qcom_battmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index de77df97b3a4..a05fd00711f6 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -105,7 +105,7 @@ struct qcom_battmgr_property_request {
 
 struct qcom_battmgr_update_request {
 	struct pmic_glink_hdr hdr;
-	u32 battery_id;
+	__le32 battery_id;
 };
 
 struct qcom_battmgr_charge_time_request {
-- 
2.42.0




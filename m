Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39F57ECD71
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjKOTgh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjKOTgd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:36:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B6C1B1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:36:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49A3C433C9;
        Wed, 15 Nov 2023 19:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076990;
        bh=iYYlYwlhZUM0mh/4hMwKoPrkvaYTWXpJguY8XsOx40E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnO82zMVCk3gde2mhDNo0fktM4abKJYvqO7G2N71ajITHtMps+jeGONRVzuX4dd4g
         1itonn1ZjyRpluqX18pH53CyfMedSh65PUB+hOBF2oCj9XYrzNw/3ieY8D3z3SNcac
         biOyjh0LGur/EGxEaqrz3gZFXQHLcxQhwR3IlgJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jacob Keller <jacob.e.keller@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH 6.6 071/603] ice: fix pin assignment for E810-T without SMA control
Date:   Wed, 15 Nov 2023 14:10:16 -0500
Message-ID: <20231115191618.028346208@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 5a7cee1cb4b9ef99fe7acd571e1bd51b023b099a ]

Since commit 43c4958a3ddb ("ice: Merge pin initialization of E810 and E810T
adapters"), the ice_ptp_setup_pins_e810() function has been used for both
E810 and E810-T devices. The new implementation only distinguishes between
whether the device has SMA control or not. It was assumed this is always
true for E810-T devices. In addition, it does not set the n_per_out value
appropriately when SMA control is enabled.

In some cases, the E810-T device may not have access to SMA control. In
that case, the E810-T device actually has access to fewer pins than a
standard E810 device.

Fix the implementation to correctly assign the appropriate pin counts for
E810-T devices both with and without SMA control. The mentioned commit
already includes the appropriate macro values for these pin counts but they
were unused.

Instead of assigning the default E810 values and then overwriting them,
handle the cases separately in order of E810-T with SMA, E810-T without
SMA, and then standard E810. This flow makes following the logic easier.

Fixes: 43c4958a3ddb ("ice: Merge pin initialization of E810 and E810T adapters")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 81d96a40d5a74..c4270708a7694 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2246,18 +2246,20 @@ ice_ptp_setup_sma_pins_e810t(struct ice_pf *pf, struct ptp_clock_info *info)
 static void
 ice_ptp_setup_pins_e810(struct ice_pf *pf, struct ptp_clock_info *info)
 {
-	info->n_per_out = N_PER_OUT_E810;
-
-	if (ice_is_feature_supported(pf, ICE_F_PTP_EXTTS))
-		info->n_ext_ts = N_EXT_TS_E810;
-
 	if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
 		info->n_ext_ts = N_EXT_TS_E810;
+		info->n_per_out = N_PER_OUT_E810T;
 		info->n_pins = NUM_PTP_PINS_E810T;
 		info->verify = ice_verify_pin_e810t;
 
 		/* Complete setup of the SMA pins */
 		ice_ptp_setup_sma_pins_e810t(pf, info);
+	} else if (ice_is_e810t(&pf->hw)) {
+		info->n_ext_ts = N_EXT_TS_NO_SMA_E810T;
+		info->n_per_out = N_PER_OUT_NO_SMA_E810T;
+	} else {
+		info->n_per_out = N_PER_OUT_E810;
+		info->n_ext_ts = N_EXT_TS_E810;
 	}
 }
 
-- 
2.42.0




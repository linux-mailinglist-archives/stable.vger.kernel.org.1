Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610A37ECB92
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjKOTXH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjKOTXH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29EC19D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E98C433C7;
        Wed, 15 Nov 2023 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076183;
        bh=iEVRlnKVm2e3tqHeRl7OVftXfOW0RqloIKzQ+ffkow8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVBY6P9pxm7+njwpwGpwlzxE5AirFllmTi7FPOkcP7lWcxEJNNUVqpqcaqKWnWYNA
         JWfMxjHUpDUJDIqCD6pzHCxxushnHr7hh35ohux6ZRsWSjHAl+7UmB85TwX9hE1N0H
         HsknvX4dlT+KC8COD4+aXk0c1W74cn7vlVvb9dFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rotem Saado <rotem.saado@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 128/550] wifi: iwlwifi: yoyo: swap cdb and jacket bits values
Date:   Wed, 15 Nov 2023 14:11:52 -0500
Message-ID: <20231115191609.561122048@linuxfoundation.org>
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

From: Rotem Saado <rotem.saado@intel.com>

[ Upstream commit 65008777b9dcd2002414ddb2c2158293a6e2fd6f ]

The bits are wrong, the jacket bit should be 5 and cdb bit 4.
Fix it.

Fixes: 1f171f4f1437 ("iwlwifi: Add support for getting rf id with blank otp")
Signed-off-by: Rotem Saado <rotem.saado@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20231004123422.356d8dacda2f.I349ab888b43a11baa2453a1d6978a6a703e422f0@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 6dd381ff0f9e7..2a63968b0e55b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -348,8 +348,8 @@
 #define RFIC_REG_RD			0xAD0470
 #define WFPM_CTRL_REG			0xA03030
 #define WFPM_OTP_CFG1_ADDR		0x00a03098
-#define WFPM_OTP_CFG1_IS_JACKET_BIT	BIT(4)
-#define WFPM_OTP_CFG1_IS_CDB_BIT	BIT(5)
+#define WFPM_OTP_CFG1_IS_JACKET_BIT	BIT(5)
+#define WFPM_OTP_CFG1_IS_CDB_BIT	BIT(4)
 #define WFPM_OTP_BZ_BNJ_JACKET_BIT	5
 #define WFPM_OTP_BZ_BNJ_CDB_BIT		4
 #define WFPM_OTP_CFG1_IS_JACKET(_val)   (((_val) & 0x00000020) >> WFPM_OTP_BZ_BNJ_JACKET_BIT)
-- 
2.42.0




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487D87ECDE4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjKOTjC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjKOTjC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:39:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D388BB9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B27C433C9;
        Wed, 15 Nov 2023 19:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077138;
        bh=nxtplQbQbgrX3JfOiUMPVQLg0ZhJmKHWU61q9SBrP0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/n9OlDQcXcg1Y8I3BJgfLnYsOcvwCDv5K3Gs3u8tnHpbFerhDF+TwodB8L3Lsmkf
         H6ViALZZSAV1L7E9cmGAJL6UNZ53HdCJOW6BTG8omkfMZ4ukIJLw0C+1xL9TRVGXjl
         3nNIuuLmm9B4J4KVNYEoHxXxjSzKF6QSVQDgXH/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rotem Saado <rotem.saado@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 136/603] wifi: iwlwifi: yoyo: swap cdb and jacket bits values
Date:   Wed, 15 Nov 2023 14:11:21 -0500
Message-ID: <20231115191622.648056821@linuxfoundation.org>
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




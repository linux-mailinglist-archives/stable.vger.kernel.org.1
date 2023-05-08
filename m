Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9E76FAB9D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjEHLPZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjEHLPY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:15:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFDC36CD1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 161FD62BE0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5F6C433D2;
        Mon,  8 May 2023 11:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544522;
        bh=UKPW9F1OywHt3QkGmlWOzCZScoa0b8BXTlvOAqQcNq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfFP34igA0o07bK5yZG0NFfYFoKoJM5oU4Ufh1ADeuUtvD9yEebBN4sFA9vLJGBAw
         vXKIIsggeedQc/4+m9sUWmCwpMt/MfJfN251sGiguhz0ny8L60gvXE1eniWhuQu3IK
         Wu5U+klkWiVxXxRWeBprkg0kyO/F7Y/vpNkAqxYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Howard Hsu <howard-yh.hsu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 437/694] wifi: mt76: mt7915: rework init flow in mt7915_thermal_init()
Date:   Mon,  8 May 2023 11:44:32 +0200
Message-Id: <20230508094447.599860451@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Howard Hsu <howard-yh.hsu@mediatek.com>

[ Upstream commit 9c97df11dfe68b548a47744ba9fa6beddcfba2bc ]

If kernel do not enable CONFIG_HWMON, it may cause thermal
initialization to be done with temperature value 0 and then can not
transmit. This commit fixes it by setting trigger/restore temperature
before checking CONFIG_HWMON.

Fixes: 7d12b38ab6f6 ("wifi: mt76: mt7915: call mt7915_mcu_set_thermal_throttling() only after init_work")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 4f3efc942a4d8..71ccefd39cb20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -203,6 +203,10 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 			phy->cdev = cdev;
 	}
 
+	/* initialize critical/maximum high temperature */
+	phy->throttle_temp[MT7915_CRIT_TEMP_IDX] = MT7915_CRIT_TEMP;
+	phy->throttle_temp[MT7915_MAX_TEMP_IDX] = MT7915_MAX_TEMP;
+
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return 0;
 
@@ -211,10 +215,6 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
 
-	/* initialize critical/maximum high temperature */
-	phy->throttle_temp[MT7915_CRIT_TEMP_IDX] = MT7915_CRIT_TEMP;
-	phy->throttle_temp[MT7915_MAX_TEMP_IDX] = MT7915_MAX_TEMP;
-
 	return 0;
 }
 
-- 
2.39.2




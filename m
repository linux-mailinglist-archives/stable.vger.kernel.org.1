Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9827B8888
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244077AbjJDSRA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244189AbjJDSQm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:16:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC629E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:16:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AD1C433C8;
        Wed,  4 Oct 2023 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443398;
        bh=WdAkV3U2UUtblSRX0mCVxFEu482nLqvJx1D3hqRZ2SU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdv0oAgLVk+xkCPmUW1VMoFd4Fq4iPsYGiYnr5EB1Ui17FSBQLd5cb51CWvd5pZ+i
         WUQOn3+QI7PLMDkpft1dHIAfULbW/hTv7U2CJuV/TUbsub/jEusENasi2k5U2ALsAy
         srAIvIAvXYOgp/qC8sTG25DQV1KakCuf2xG6r67k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 125/259] power: supply: ucs1002: fix error code in ucs1002_get_property()
Date:   Wed,  4 Oct 2023 19:54:58 +0200
Message-ID: <20231004175223.095789196@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit e35059949daa83f8dadf710d0f829ab3c3a72fe2 ]

This function is supposed to return 0 for success instead of returning
the val->intval.  This makes it the same as the other case statements
in this function.

Fixes: 81196e2e57fc ("power: supply: ucs1002: fix some health status issues")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/687f64a4-4c6e-4536-8204-98ad1df934e5@moroto.mountain
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ucs1002_power.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index ef673ec3db568..332cb50d9fb4f 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -384,7 +384,8 @@ static int ucs1002_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		return ucs1002_get_usb_type(info, val);
 	case POWER_SUPPLY_PROP_HEALTH:
-		return val->intval = info->health;
+		val->intval = info->health;
+		return 0;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = info->present;
 		return 0;
-- 
2.40.1




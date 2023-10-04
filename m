Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F78A7B89B7
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244255AbjJDS2c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244257AbjJDS2c (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:28:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B998A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:28:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807A8C433C7;
        Wed,  4 Oct 2023 18:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444108;
        bh=bZHqgicDKgU8vKoQc+Nna4/Ud9DQDdho2LD7DUbXXaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQmN/ngblCy+1s3gB4rxC1BuM4wB4VmdpHk63o3oqkBeXAeV/QZ/tFdfua5o9yNUT
         qu7B9gM0cwdgfAgTeg07+t1ThqUVeTbm72xmnzWNvYHrl0srRc2HM6gNpXvwkuUlDw
         uhtXybin4CLx0d7KvusimGkp85T1k83s3ZXPzOv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 134/321] power: supply: ucs1002: fix error code in ucs1002_get_property()
Date:   Wed,  4 Oct 2023 19:54:39 +0200
Message-ID: <20231004175235.442971423@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 954feba6600b8..7970843a4f480 100644
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




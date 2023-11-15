Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BEA7ECE43
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjKOTly (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjKOTlx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:41:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4931AE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:41:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69456C433C7;
        Wed, 15 Nov 2023 19:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077309;
        bh=6mBF/LcgQrCnm5IZ3BuuyKSVRmvKVXp/1cOkZLZuC0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFycC+ShCDG6ksF2RdMj3m4WyVSQL7vNCynSVSSle04NmzHgN6A7Zql6DDdI42Y1Y
         dt1wvvaWmZdeLwFXKQJCb2utNTjmdSoRBGJo29nV2mMC/4QptEceo/Eey3k6DlKw0D
         tlszcuGI28yeYRPDweJy5PTOSWvkdcLFx9olSsrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 207/603] hwmon: (pmbus/mp2975) Move PGOOD fix
Date:   Wed, 15 Nov 2023 14:12:32 -0500
Message-ID: <20231115191627.592961971@linuxfoundation.org>
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

From: Naresh Solanki <naresh.solanki@9elements.com>

[ Upstream commit 9da2901c47332b030ea4d2a2302bc7c0b83fc67c ]

The PGOOD fix was intended for MP2973 & MP2971 & not for MP2975.

Fixes: acda945afb46 ("hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD")
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Link: https://lore.kernel.org/r/20231027103352.918895-1-naresh.solanki@9elements.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/mp2975.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 26ba506331007..b9bb469e2d8fe 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -297,6 +297,11 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
 	int ret;
 
 	switch (reg) {
+	case PMBUS_STATUS_WORD:
+		/* MP2973 & MP2971 return PGOOD instead of PB_STATUS_POWER_GOOD_N. */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		ret ^= PB_STATUS_POWER_GOOD_N;
+		break;
 	case PMBUS_OT_FAULT_LIMIT:
 		ret = mp2975_read_word_helper(client, page, phase, reg,
 					      GENMASK(7, 0));
@@ -380,11 +385,6 @@ static int mp2975_read_word_data(struct i2c_client *client, int page,
 	int ret;
 
 	switch (reg) {
-	case PMBUS_STATUS_WORD:
-		/* MP2973 & MP2971 return PGOOD instead of PB_STATUS_POWER_GOOD_N. */
-		ret = pmbus_read_word_data(client, page, phase, reg);
-		ret ^= PB_STATUS_POWER_GOOD_N;
-		break;
 	case PMBUS_OT_FAULT_LIMIT:
 		ret = mp2975_read_word_helper(client, page, phase, reg,
 					      GENMASK(7, 0));
-- 
2.42.0




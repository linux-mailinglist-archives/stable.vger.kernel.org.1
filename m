Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76C979BFAE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjIKUwL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238528AbjIKN6d (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:58:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAC4CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:58:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29DAC433C7;
        Mon, 11 Sep 2023 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440707;
        bh=FCORFtzPcMBE5PCZPpwyczDlFBbG5o9K7HUz5H1SaLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkcNQbLfsRiaLChNoGE8cqCOovxB/oriV057AJ+5GO1NoAAsoWewXalSznYJ3yVWe
         Nb4pp8uOWZ6/ZMbau4f99VifzbWAt8Z5i36TicwiuJG9R2BAj+fLUnZSSuh3mpMGoT
         Y1psOwjUQHibnRpg1aUVwFdaOoC27vSS/9VYriW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 156/739] hwmon: (asus-ec-sensosrs) fix mutex path for X670E Hero
Date:   Mon, 11 Sep 2023 15:39:15 +0200
Message-ID: <20230911134655.506458881@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugene Shalygin <eugene.shalygin@gmail.com>

[ Upstream commit 9c53fb0ad1acaf227718ccae16e8fb8e01c05918 ]

A user reported that they observe race condition warning [1] and after
looking once again into the DSDT source it was found that wrong mutex
was used.

[1] https://github.com/zeule/asus-ec-sensors/issues/43

Fixes: 790dec13c012 ("hwmon: (asus-ec-sensors) add ROG Crosshair X670E Hero.")
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
Link: https://lore.kernel.org/r/20230821115418.25733-2-eugene.shalygin@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index f52a539eb33e9..51f9c2db403e7 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -340,7 +340,7 @@ static const struct ec_board_info board_info_crosshair_x670e_hero = {
 	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
 		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
 		SENSOR_SET_TEMP_WATER,
-	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
 	.family = family_amd_600_series,
 };
 
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C49C735345
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjFSKnq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjFSKn1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95A5E76
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6184160670
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79088C433C9;
        Mon, 19 Jun 2023 10:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171381;
        bh=UOuf+ISkjVh8LEl8gJremwMY0utWFUL05SSdIZEVKks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwjXFc6Q5m/atPwsqf0TuL5Pwigh2kwKvKYQKYFOYSqbUk+8Egh4yOgHDEBaWbDhh
         qQ9mtu6RATeX67/Nac9IB6NxVi3hzJQV7OZ3Ugu7ZLzg8qynBtyItXUvbpaOeHrt4K
         JVlp4YrMKPBJvd53PyADmVB6DWjx7fTXakbvMtNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 011/166] power: supply: ab8500: Fix external_power_changed race
Date:   Mon, 19 Jun 2023 12:28:08 +0200
Message-ID: <20230619102155.228660101@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit a5299ce4e96f3e8930e9c051b28d8093ada87b08 ]

ab8500_btemp_external_power_changed() dereferences di->btemp_psy,
which gets sets in ab8500_btemp_probe() like this:

        di->btemp_psy = devm_power_supply_register(dev, &ab8500_btemp_desc,
                                                   &psy_cfg);

As soon as devm_power_supply_register() has called device_add()
the external_power_changed callback can get called. So there is a window
where ab8500_btemp_external_power_changed() may get called while
di->btemp_psy has not been set yet leading to a NULL pointer dereference.

Fixing this is easy. The external_power_changed callback gets passed
the power_supply which will eventually get stored in di->btemp_psy,
so ab8500_btemp_external_power_changed() can simply directly use
the passed in psy argument which is always valid.

And the same applies to ab8500_fg_external_power_changed().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ab8500_btemp.c | 6 ++----
 drivers/power/supply/ab8500_fg.c    | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 307ee6f71042e..6f83e99d2eb72 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -624,10 +624,8 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
  */
 static void ab8500_btemp_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_btemp *di = power_supply_get_drvdata(psy);
-
-	class_for_each_device(power_supply_class, NULL,
-		di->btemp_psy, ab8500_btemp_get_ext_psy_data);
+	class_for_each_device(power_supply_class, NULL, psy,
+			      ab8500_btemp_get_ext_psy_data);
 }
 
 /* ab8500 btemp driver interrupts and their respective isr */
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index c6c9804280dbe..71ce28eed463f 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2407,10 +2407,8 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
  */
 static void ab8500_fg_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_fg *di = power_supply_get_drvdata(psy);
-
-	class_for_each_device(power_supply_class, NULL,
-		di->fg_psy, ab8500_fg_get_ext_psy_data);
+	class_for_each_device(power_supply_class, NULL, psy,
+			      ab8500_fg_get_ext_psy_data);
 }
 
 /**
-- 
2.39.2




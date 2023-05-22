Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1D70C8C1
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjEVTl4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbjEVTli (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:41:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40A2CF
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:41:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A29A629E6
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F214C433EF;
        Mon, 22 May 2023 19:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784451;
        bh=IjRiUvLYQP+9kc1hC+PvjP2DMMMkl/v+LroeMGs/n30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WwtNfqTUu4Vi6R1kxrqAtWELYLQNWDq8WOkaISMqfSABjntW94IK/CG+29DX8GMgY
         T+DG1ojqrG5HeIoFUq/RFedb6GDKtOu+XKTJLYLtGJu9YIqR0VQGuXzFefJGS4+NCK
         BPtMU3WuUHlO2v2eqNdVbh2dygMkNkWQ2Jm+y3QE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aleksandr Mezin <mezin.alexander@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 087/364] hwmon: (nzxt-smart2) add another USB ID
Date:   Mon, 22 May 2023 20:06:32 +0100
Message-Id: <20230522190414.932960962@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aleksandr Mezin <mezin.alexander@gmail.com>

[ Upstream commit 4a148e9b1ee04e608263fa9536a96214d5561220 ]

This seems to be a new revision of the device. RGB controls have changed,
but this driver doesn't touch them anyway.

Fan speed control reported to be working with existing userspace (hidraw)
software, so I assume it's compatible. Fan channel count is the same.

Recently added (0x1e71, 0x2019) seems to be the same device.

Discovered in liquidctl project:

https://github.com/liquidctl/liquidctl/issues/541

Signed-off-by: Aleksandr Mezin <mezin.alexander@gmail.com>
Link: https://lore.kernel.org/r/20230219105924.333007-1-mezin.alexander@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nzxt-smart2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
index 2b93ba89610ae..a8e72d8fd0605 100644
--- a/drivers/hwmon/nzxt-smart2.c
+++ b/drivers/hwmon/nzxt-smart2.c
@@ -791,7 +791,8 @@ static const struct hid_device_id nzxt_smart2_hid_id_table[] = {
 	{ HID_USB_DEVICE(0x1e71, 0x2009) }, /* NZXT RGB & Fan Controller */
 	{ HID_USB_DEVICE(0x1e71, 0x200e) }, /* NZXT RGB & Fan Controller */
 	{ HID_USB_DEVICE(0x1e71, 0x2010) }, /* NZXT RGB & Fan Controller */
-	{ HID_USB_DEVICE(0x1e71, 0x2019) }, /* NZXT RGB & Fan Controller */
+	{ HID_USB_DEVICE(0x1e71, 0x2011) }, /* NZXT RGB & Fan Controller (6 RGB) */
+	{ HID_USB_DEVICE(0x1e71, 0x2019) }, /* NZXT RGB & Fan Controller (6 RGB) */
 	{},
 };
 
-- 
2.39.2




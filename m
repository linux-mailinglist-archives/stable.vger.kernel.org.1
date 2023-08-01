Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A778876AF19
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjHAJpO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjHAJov (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:44:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EAB469D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCBBB6126D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE20BC433C7;
        Tue,  1 Aug 2023 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882944;
        bh=KaFARStEbsP4AiT6iSo+JtrNslN+0r00H2IoIuavtDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ytmUZ6A+2cw347OQTEg1w+uUQcSqowGh5+OuP/pO5cVGllQPnCX/Pjdd2t5wbhU/8
         xpQuY3KsbJiT1AjV6CDFJTk9EsFGKYQW0ol7RpgVHp0HX+KAxCX+MwqmFsGEpyCO6B
         EKaPANbsGiAPTjyrWkw62P+QiXWPztmdbUvOFiXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 058/239] media: tc358746: Address compiler warnings
Date:   Tue,  1 Aug 2023 11:18:42 +0200
Message-ID: <20230801091927.725919778@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 9c2dcfc2cf0f2e4e0a0db33bc1a626e35928c475 ]

Address these compiler warnings by initialising the m_best and p_best
values to 0 and 1 respectively (as latter is used as a divisor):

   drivers/media/i2c/tc358746.c: In function 'tc358746_find_pll_settings':
>> drivers/media/i2c/tc358746.c:817:13: warning: 'p_best' is used uninitialized
[-Wuninitialized]
     817 |         u16 p_best, p;
         |             ^~~~~~
>> drivers/media/i2c/tc358746.c:816:13: warning: 'm_best' is used uninitialized
[-Wuninitialized]
     816 |         u16 m_best, mul;
         |             ^~~~~~

The warnings may well be a false positive but it is difficult for a
compiler to find out whether that truly is the case.

Closes: https://lore.kernel.org/oe-kbuild-all/202305301627.fLT3Bkds-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 80a21da3605 ("media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/tc358746.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/tc358746.c b/drivers/media/i2c/tc358746.c
index ec1a193ba161a..25fbce5cabdaa 100644
--- a/drivers/media/i2c/tc358746.c
+++ b/drivers/media/i2c/tc358746.c
@@ -813,8 +813,8 @@ static unsigned long tc358746_find_pll_settings(struct tc358746 *tc358746,
 	u32 min_delta = 0xffffffff;
 	u16 prediv_max = 17;
 	u16 prediv_min = 1;
-	u16 m_best, mul;
-	u16 p_best, p;
+	u16 m_best = 0, mul;
+	u16 p_best = 1, p;
 	u8 postdiv;
 
 	if (fout > 1000 * HZ_PER_MHZ) {
-- 
2.39.2




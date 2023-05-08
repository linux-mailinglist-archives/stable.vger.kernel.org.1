Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599676FA4C3
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjEHKDF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbjEHKDD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:03:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8511725713
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6307E622E4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD3AC433EF;
        Mon,  8 May 2023 10:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540173;
        bh=C3TNWy7E2eTHc/6V+meOjr38etecp82m9YMJVtbCKiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=THvWW5BFKpNEmH/6XqtxQ87foScsCKwz1stctI88kBRV893rlsLdIsSYhydrREjZ2
         x3j4tnnBDBLAsEr0+WS2D75Ea2FbozsUuiezcyn2IY9QfvMEJ88fRl6bbaRT3pyp7r
         m35waENIDNPtD1SV4UmN46du6BMzDgM1sNhJGwPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        =?UTF-8?q?Tom=C3=A1=C5=A1=20Pecka?= <tomas.pecka@cesnet.cz>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 264/611] hwmon: (pmbus/fsp-3y) Fix functionality bitmask in FSP-3Y YM-2151E
Date:   Mon,  8 May 2023 11:41:46 +0200
Message-Id: <20230508094430.980857636@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Tomáš Pecka <tomas.pecka@cesnet.cz>

[ Upstream commit 93822f5161a2dc57a60b95b35b3cb8589f53413e ]

The bit flags in pmbus_driver_info functionality for YM-2151E chip were
joined with a comma operator instead of a bitwise OR. This means that
the last constant PMBUS_HAVE_IIN was not OR-ed with the other
PM_BUS_HAVE_* constants for this page but it initialized the next element
of the func array (which was not accessed from anywhere because of the
number of pages).

However, there is no need for setting PMBUS_HAVE_IIN in the 5Vsb page
because this command does not seem to be paged. Obviously, the device
only has one IIN sensor, so it doesn't make sense to query it again from
the second page.

Fixes: 1734b4135a62 ("hwmon: Add driver for fsp-3y PSUs and PDUs")
Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
Signed-off-by: Tomáš Pecka <tomas.pecka@cesnet.cz>
Link: https://lore.kernel.org/r/20230420171939.212040-1-tomas.pecka@cesnet.cz
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/fsp-3y.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
index aec294cc72d1f..c7469d2cdedcf 100644
--- a/drivers/hwmon/pmbus/fsp-3y.c
+++ b/drivers/hwmon/pmbus/fsp-3y.c
@@ -180,7 +180,6 @@ static struct pmbus_driver_info fsp3y_info[] = {
 			PMBUS_HAVE_FAN12,
 		.func[YM2151_PAGE_5VSB_LOG] =
 			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT,
-			PMBUS_HAVE_IIN,
 		.read_word_data = fsp3y_read_word_data,
 		.read_byte_data = fsp3y_read_byte_data,
 	},
-- 
2.39.2




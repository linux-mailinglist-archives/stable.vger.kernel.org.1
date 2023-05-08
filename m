Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973456FA99F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjEHKxk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjEHKxV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9794690
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D33A6296B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD1BC4339B;
        Mon,  8 May 2023 10:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543159;
        bh=8zr1kOPTgKzYczvIe0anltLdNVwdCDHYFNsZaTgHBiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OfcVpRoUkXy5tBogJwUpAwYQuvUNyxFuDFhZaODwxfkfm07jzGZrTBNLUzh1jv1iw
         wUwA8yuqnSmLAmPXZ8xLvR1gwAqjv2eGOV9hH78D/6B/qvEnatPPulSID3sr29xTA/
         CasCSy5c5pwwPaf5mjo0oyg6OY8X94km6s7KljaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru gagniuc <mr.nuke.me@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        ValdikSS <iam@valdikss.org.ru>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.2 635/663] wifi: rtw88: rtw8821c: Fix rfe_option field width
Date:   Mon,  8 May 2023 11:47:41 +0200
Message-Id: <20230508094450.519656447@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Sascha Hauer <s.hauer@pengutronix.de>

commit 14705f969d98187a1cc2682e0c9bd2e230b8098f upstream.

On my RTW8821CU chipset rfe_option reads as 0x22. Looking at the
vendor driver suggests that the field width of rfe_option is 5 bit,
so rfe_option should be masked with 0x1f.

Without this the rfe_option comparisons with 2 further down the
driver evaluate as false when they should really evaluate as true.
The effect is that 2G channels do not work.

rfe_option is also used as an array index into rtw8821c_rfe_defs[].
rtw8821c_rfe_defs[34] (0x22) was added as part of adding USB support,
likely because rfe_option reads as 0x22. As this now becomes 0x2,
rtw8821c_rfe_defs[34] is no longer used and can be removed.

Note that this might not be the whole truth. In the vendor driver
there are indeed places where the unmasked rfe_option value is used.
However, the driver has several places where rfe_option is tested
with the pattern if (rfe_option == 2 || rfe_option == 0x22) or
if (rfe_option == 4 || rfe_option == 0x24), so that rfe_option BIT(5)
has no influence on the code path taken. We therefore mask BIT(5)
out from rfe_option entirely until this assumption is proved wrong
by some chip variant we do not know yet.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Alexandru gagniuc <mr.nuke.me@gmail.com>
Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
Tested-by: ValdikSS <iam@valdikss.org.ru>
Cc: stable@vger.kernel.org
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230417140358.2240429-3-s.hauer@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -47,7 +47,7 @@ static int rtw8821c_read_efuse(struct rt
 
 	map = (struct rtw8821c_efuse *)log_map;
 
-	efuse->rfe_option = map->rfe_option;
+	efuse->rfe_option = map->rfe_option & 0x1f;
 	efuse->rf_board_option = map->rf_board_option;
 	efuse->crystal_cap = map->xtal_k;
 	efuse->pa_type_2g = map->pa_type;
@@ -1537,7 +1537,6 @@ static const struct rtw_rfe_def rtw8821c
 	[2] = RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
 	[4] = RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
 	[6] = RTW_DEF_RFE(8821c, 0, 0),
-	[34] = RTW_DEF_RFE(8821c, 0, 0),
 };
 
 static struct rtw_hw_reg rtw8821c_dig[] = {



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0D7A3822
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbjIQTbo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbjIQTbU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:31:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7413D9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:31:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0804BC433CA;
        Sun, 17 Sep 2023 19:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979075;
        bh=TQnuNUQvaRyiJNVbUkTH28qwYUpCIS3DBBMfg7kMssk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CXOfH6fmttGxjj5bV/umpxGX+0MsL8ytyz3Dg0UPEhrLlPr3YYeeU/FMbCjG754f
         2AqKkMGlKfFp9K1JY5aSX6hzqlU5WyO/CElPKegvdu2Bm6eP9VSPmmjZo+I0cg1Tax
         PCMnP7zUCaMERIcz8ULVc811pnm3iyb6VZKH1lLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniil Dulov <d.dulov@aladdin.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 207/406] media: cx24120: Add retval check for cx24120_message_send()
Date:   Sun, 17 Sep 2023 21:11:01 +0200
Message-ID: <20230917191106.654452685@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniil Dulov <d.dulov@aladdin.ru>

[ Upstream commit 96002c0ac824e1773d3f706b1f92e2a9f2988047 ]

If cx24120_message_send() returns error, we should keep local struct
unchanged.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5afc9a25be8d ("[media] Add support for TechniSat Skystar S2")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/cx24120.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/cx24120.c b/drivers/media/dvb-frontends/cx24120.c
index 2464b63fe0cf4..307efef263f27 100644
--- a/drivers/media/dvb-frontends/cx24120.c
+++ b/drivers/media/dvb-frontends/cx24120.c
@@ -972,7 +972,9 @@ static void cx24120_set_clock_ratios(struct dvb_frontend *fe)
 	cmd.arg[8] = (clock_ratios_table[idx].rate >> 8) & 0xff;
 	cmd.arg[9] = (clock_ratios_table[idx].rate >> 0) & 0xff;
 
-	cx24120_message_send(state, &cmd);
+	ret = cx24120_message_send(state, &cmd);
+	if (ret != 0)
+		return;
 
 	/* Calculate ber window rates for stat work */
 	cx24120_calculate_ber_window(state, clock_ratios_table[idx].rate);
-- 
2.40.1




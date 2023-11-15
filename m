Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2167E23DA
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjKFNPY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjKFNPY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:15:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FE091
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:15:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71A3C433C9;
        Mon,  6 Nov 2023 13:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276521;
        bh=G57KZ0kAWGZ+sbflVgfS4Pm7usd+BKHkzVhiPBCVZNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1kvxXUiW/JfRk2eFvTA18YpYUSMLknUD/IfGO/8GbmlApsG9usb7jyF0dTpd/ZiWH
         qfdj0S5O4pfmVMFToyGzfDuubDEvqTvDBoXgrBqeTB8RmMVp9wTk4v7dQ3ZPu9oHjD
         /UPeA/2mchlreznvcZ931fEhCVPQ5qm7Z4+xSlsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 36/62] r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
Date:   Mon,  6 Nov 2023 14:03:42 +0100
Message-ID: <20231106130303.138624552@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit bc65cc42af737a5a35f83842408ef2c6c79ba025 ]

If the adapter is unplugged while we're looping in r8153b_ups_en() /
r8153c_ups_en() we could end up looping for 10 seconds (20 ms * 500
loops). Add code similar to what's done in other places in the driver
to check for unplug and bail.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 3cdb7ff25a3bc..345e341d22338 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3655,6 +3655,8 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
@@ -3695,6 +3697,8 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
-- 
2.42.0




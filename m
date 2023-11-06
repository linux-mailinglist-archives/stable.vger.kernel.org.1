Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263C97E2535
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjKFN3Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjKFN3X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:29:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DFB92
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:29:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78416C433C8;
        Mon,  6 Nov 2023 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277360;
        bh=28p+mE82HZ1V02TO4S4bHWkrORoA5UYm963oBr7UFoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufo2mhX4A39rpFbuWO1AsG0iDs/iEQkrDuCOtIFb9k4wkkbKhCnXqIMPgnL7oTKrN
         e4H9ayd1bdAd5a1L9OhaotGtNBJVvGaLklWndRFDqSmWqbeiMiLYznLFzaAytTS1jb
         iQJxdVESVl8L3T5psDpZ67Sk9cvFmNArvJs9kfjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 098/128] r8152: Check for unplug in rtl_phy_patch_request()
Date:   Mon,  6 Nov 2023 14:04:18 +0100
Message-ID: <20231106130313.625583367@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit dc90ba37a8c37042407fa6970b9830890cfe6047 ]

If the adapter is unplugged while we're looping in
rtl_phy_patch_request() we could end up looping for 10 seconds (2 ms *
5000 loops). Add code similar to what's done in other places in the
driver to check for unplug and bail.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f6d5fbb9dee07..15610d7d677ce 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4051,6 +4051,9 @@ static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
 	for (i = 0; wait && i < 5000; i++) {
 		u32 ocp_data;
 
+		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+			break;
+
 		usleep_range(1000, 2000);
 		ocp_data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
 		if ((ocp_data & PATCH_READY) ^ check)
-- 
2.42.0




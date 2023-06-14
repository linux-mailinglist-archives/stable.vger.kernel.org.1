Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA3713E0D
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjE1Tbf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjE1Tbe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF11D10E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A880361D77
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51DBC433EF;
        Sun, 28 May 2023 19:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302285;
        bh=Gav/1Q7W/gN/H/d16rPYVIUTv2fODYOFw3AGHDepxVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWr5vTFRsvJ8mSsP0S+cQv0XEOYCP0sRn3bRwabieaAW3Bn9oVZY6DDrMtSdB5inU
         4bX1uccSC4ikuhj+lRV5Ub3UHrmA1U1z2Yble3ysctmZecQ9TqACjZp5K9JgSRbQ43
         0j5tsz7YmTi8P9+JSUVMxZeCsmBf2iw5raLw0atM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.3 074/127] lan966x: Fix unloading/loading of the driver
Date:   Sun, 28 May 2023 20:10:50 +0100
Message-Id: <20230528190838.790555562@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>

commit 600761245952d7f70280add6ce02894f1528992b upstream.

It was noticing that after a while when unloading/loading the driver and
sending traffic through the switch, it would stop working. It would stop
forwarding any traffic and the only way to get out of this was to do a
power cycle of the board. The root cause seems to be that the switch
core is initialized twice. Apparently initializing twice the switch core
disturbs the pointers in the queue systems in the HW, so after a while
it would stop sending the traffic.
Unfortunetly, it is not possible to use a reset of the switch here,
because the reset line is connected to multiple devices like MDIO,
SGPIO, FAN, etc. So then all the devices will get reseted when the
network driver will be loaded.
So the fix is to check if the core is initialized already and if that is
the case don't initialize it again.

Fixes: db8bcaad5393 ("net: lan966x: add the basic lan966x driver")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230522120038.3749026-1-horatiu.vultur@microchip.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1013,6 +1013,16 @@ static int lan966x_reset_switch(struct l
 
 	reset_control_reset(switch_reset);
 
+	/* Don't reinitialize the switch core, if it is already initialized. In
+	 * case it is initialized twice, some pointers inside the queue system
+	 * in HW will get corrupted and then after a while the queue system gets
+	 * full and no traffic is passing through the switch. The issue is seen
+	 * when loading and unloading the driver and sending traffic through the
+	 * switch.
+	 */
+	if (lan_rd(lan966x, SYS_RESET_CFG) & SYS_RESET_CFG_CORE_ENA)
+		return 0;
+
 	lan_wr(SYS_RESET_CFG_CORE_ENA_SET(0), lan966x, SYS_RESET_CFG);
 	lan_wr(SYS_RAM_INIT_RAM_INIT_SET(1), lan966x, SYS_RAM_INIT);
 	ret = readx_poll_timeout(lan966x_ram_init, lan966x,



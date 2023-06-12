Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623E472C0CF
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbjFLKyq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjFLKyT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F042681
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAACC61297
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE5DC433D2;
        Mon, 12 Jun 2023 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566406;
        bh=Sg66cUkicRqodMZr/qck+e/ruS7sU0CTAz4k4bSSH8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=umU8bIyAveaK4oIJu4v55142axqDwBXAdoR6XXZzAGLZWFxxzCEHzb79BCpnThfwb
         wS+kN5OjDbxBRnVcFV+TffMGlW7mwXtrvrR+KEk5loF3sCAhGfdf9B8rpYZ3YkTmSh
         Oi5Rb7XpoCYCDfu1veTHa66W722taVHc72nZqTu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 002/132] net: sfp: fix state loss when updating state_hw_mask
Date:   Mon, 12 Jun 2023 12:25:36 +0200
Message-ID: <20230612101710.406917908@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

commit 04361b8bb81819efb68bf39c276025e2250ac537 upstream.

Andrew reports that the SFF modules on one of the ZII platforms do not
indicate link up due to the SFP code believing that LOS indicating that
there is no signal being received from the remote end, but in fact the
LOS signal is showing that there is signal.

What makes SFF modules different from SFPs is they typically have an
inverted LOS, which uncovered this issue. When we read the hardware
state, we mask it with state_hw_mask so we ignore anything we're not
interested in. However, we don't re-read when state_hw_mask changes,
leading to sfp->state being stale.

Arrange for a software poll of the module state after we have parsed
the EEPROM in sfp_sm_mod_probe() and updated state_*_mask. This will
generate any necessary events for signal changes for the state
machine as well as updating sfp->state.

Reported-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Fixes: 8475c4b70b04 ("net: sfp: re-implement soft state polling setup")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2199,6 +2199,11 @@ static void sfp_sm_module(struct sfp *sf
 			break;
 		}
 
+		/* Force a poll to re-read the hardware signal state after
+		 * sfp_sm_mod_probe() changed state_hw_mask.
+		 */
+		mod_delayed_work(system_wq, &sfp->poll, 1);
+
 		err = sfp_hwmon_insert(sfp);
 		if (err)
 			dev_warn(sfp->dev, "hwmon probe failed: %pe\n",



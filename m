Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82B6FA7CB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjEHKez (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjEHKeV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:34:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7403126744
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A29B62733
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E5EC433A4;
        Mon,  8 May 2023 10:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542017;
        bh=wLrLRllRxYtysd1IdSutGhdSsfpImBJVRWRAiAdScUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQGAORFmE/fB9yupC0Tc5hO08sLRyJoFnTxxTO9jxxaFAVi/dVxkp8gV7PEqlnJ+c
         jy5OBoXfzoFM9tv6Ap2mmzafZkT5Grqyzk9vnzY5z/wyPlkxD3iOvJE58DR3Ucg1rF
         TLuJ1s1gIwaOxIyHSf96xXct5tSlAGwm1Wl7BWao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 299/663] net: pcs: xpcs: remove double-read of link state when using AN
Date:   Mon,  8 May 2023 11:42:05 +0200
Message-Id: <20230508094437.888229775@linuxfoundation.org>
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

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit ef63461caf427a77a04620d74ba90035a712af9c ]

Phylink does not want the current state of the link when reading the
PCS link state - it wants the latched state. Don't double-read the
MII status register. Phylink will re-read as necessary to capture
transient link-down events as of dbae3388ea9c ("net: phylink: Force
retrigger in case of latched link-fail indicator").

The above referenced commit is a dependency for this change, and thus
this change should not be backported to any kernel that does not
contain the above referenced commit.

Fixes: fcb26bd2b6ca ("net: phy: Add Synopsys DesignWare XPCS MDIO module")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/pcs/pcs-xpcs.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index f6a038a1d51e4..c70b27c4c1d5e 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -323,7 +323,7 @@ static int xpcs_read_fault_c73(struct dw_xpcs *xpcs,
 	return 0;
 }
 
-static int xpcs_read_link_c73(struct dw_xpcs *xpcs, bool an)
+static int xpcs_read_link_c73(struct dw_xpcs *xpcs)
 {
 	bool link = true;
 	int ret;
@@ -335,15 +335,6 @@ static int xpcs_read_link_c73(struct dw_xpcs *xpcs, bool an)
 	if (!(ret & MDIO_STAT1_LSTATUS))
 		link = false;
 
-	if (an) {
-		ret = xpcs_read(xpcs, MDIO_MMD_AN, MDIO_STAT1);
-		if (ret < 0)
-			return ret;
-
-		if (!(ret & MDIO_STAT1_LSTATUS))
-			link = false;
-	}
-
 	return link;
 }
 
@@ -937,7 +928,7 @@ static int xpcs_get_state_c73(struct dw_xpcs *xpcs,
 	int ret;
 
 	/* Link needs to be read first ... */
-	state->link = xpcs_read_link_c73(xpcs, state->an_enabled) > 0 ? 1 : 0;
+	state->link = xpcs_read_link_c73(xpcs) > 0 ? 1 : 0;
 
 	/* ... and then we check the faults. */
 	ret = xpcs_read_fault_c73(xpcs, state);
-- 
2.39.2




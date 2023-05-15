Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105647034F8
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbjEOQyd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243193AbjEOQyR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58786A62
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:53:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 529FE62034
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A17C433D2;
        Mon, 15 May 2023 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169633;
        bh=MFv9DncEVvAIaGgja2/G99B4hEE8xRmZRPMG/9eAx5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8Qa7LkS5JE82prL7ovDr3x+X7goBXCvGkOVMTmzMeS488lSpS0ZNk8csyrbQmq7H
         UxpeshuN9t/07zkQQIYB75Sy0ut0d1vI8BLJtpCjHonD4h7N8pK6XbnoiiHIfGw79w
         cP2bJq3zE3HBAqev1FwfXlJ7Em9OEG8LNwCsuQAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 091/246] net: dsa: mt7530: fix network connectivity with multiple CPU ports
Date:   Mon, 15 May 2023 18:25:03 +0200
Message-Id: <20230515161725.309452992@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

[ Upstream commit 120a56b01beed51ab5956a734adcfd2760307107 ]

On mt753x_cpu_port_enable() there's code that enables flooding for the CPU
port only. Since mt753x_cpu_port_enable() runs twice when both CPU ports
are enabled, port 6 becomes the only port to forward the frames to. But
port 5 is the active port, so no frames received from the user ports will
be forwarded to port 5 which breaks network connectivity.

Every bit of the BC_FFP, UNM_FFP, and UNU_FFP bits represents a port. Fix
this issue by setting the bit that corresponds to the CPU port without
overwriting the other bits.

Clear the bits beforehand only for the MT7531 switch. According to the
documents MT7621 Giga Switch Programming Guide v0.3 and MT7531 Reference
Manual for Development Board v1.0, after reset, the BC_FFP, UNM_FFP, and
UNU_FFP bits are set to 1 for MT7531, 0 for MT7530.

The commit 5e5502e012b8 ("net: dsa: mt7530: fix roaming from DSA user
ports") silently changed the method to set the bits on the MT7530_MFC.
Instead of clearing the relevant bits before mt7530_cpu_port_enable()
which runs under a for loop, the commit started doing it on
mt7530_cpu_port_enable().

Back then, this didn't really matter as only a single CPU port could be
used since the CPU port number was hardcoded. The driver was later changed
with commit 1f9a6abecf53 ("net: dsa: mt7530: get cpu-port via dp->cpu_dp
instead of constant") to retrieve the CPU port via dp->cpu_dp. With that,
this silent change became an issue for when using multiple CPU ports.

Fixes: 5e5502e012b8 ("net: dsa: mt7530: fix roaming from DSA user ports")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 8cbde093fbd9e..0c81f5830b90a 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1008,9 +1008,9 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	mt7530_write(priv, MT7530_PVC_P(port),
 		     PORT_SPEC_TAG);
 
-	/* Disable flooding by default */
-	mt7530_rmw(priv, MT7530_MFC, BC_FFP_MASK | UNM_FFP_MASK | UNU_FFP_MASK,
-		   BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) | UNU_FFP(BIT(port)));
+	/* Enable flooding on the CPU port */
+	mt7530_set(priv, MT7530_MFC, BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) |
+		   UNU_FFP(BIT(port)));
 
 	/* Set CPU port number */
 	if (priv->id == ID_MT7621)
@@ -2326,6 +2326,10 @@ mt7531_setup_common(struct dsa_switch *ds)
 	/* Enable and reset MIB counters */
 	mt7530_mib_reset(ds);
 
+	/* Disable flooding on all ports */
+	mt7530_clear(priv, MT7530_MFC, BC_FFP_MASK | UNM_FFP_MASK |
+		     UNU_FFP_MASK);
+
 	for (i = 0; i < MT7530_NUM_PORTS; i++) {
 		/* Disable forwarding by default on all ports */
 		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
-- 
2.39.2




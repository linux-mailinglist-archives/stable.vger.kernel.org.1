Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E347075D355
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjGUTJ1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjGUTJ0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:09:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11B11BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 746EE61D7B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842BFC433CA;
        Fri, 21 Jul 2023 19:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966563;
        bh=sPz1MxRr+6LsyWbUCCTfAOXWyEDQdmrhqu54+YwkDn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVk3qaXp6fjW9/Xds9t7g1hIPU8IkqkM4XZy7+niPxT61OLRouokbVWPx2QWfUmVJ
         yBUXK6D1VVM4nbqtkHlh6y9+4Io431L343sUaL8C3aY5hyxtDEhbNZM0gL383ADYxb
         o5P9j2R+nHimpoOvdZpAuD/yzAB7nUdULaMqtX2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        UNGLinuxDriver@microchip.com, Moritz Fischer <moritzf@google.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15 389/532] net: lan743x: Dont sleep in atomic context
Date:   Fri, 21 Jul 2023 18:04:53 +0200
Message-ID: <20230721160635.575213924@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Moritz Fischer <moritzf@google.com>

commit 7a8227b2e76be506b2ac64d2beac950ca04892a5 upstream.

dev_set_rx_mode() grabs a spin_lock, and the lan743x implementation
proceeds subsequently to go to sleep using readx_poll_timeout().

Introduce a helper wrapping the readx_poll_timeout_atomic() function
and use it to replace the calls to readx_polL_timeout().

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Cc: stable@vger.kernel.org
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Signed-off-by: Moritz Fischer <moritzf@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20230627035000.1295254-1-moritzf@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -83,6 +83,18 @@ static int lan743x_csr_light_reset(struc
 				  !(data & HW_CFG_LRST_), 100000, 10000000);
 }
 
+static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *adapter,
+					   int offset, u32 bit_mask,
+					   int target_value, int udelay_min,
+					   int udelay_max, int count)
+{
+	u32 data;
+
+	return readx_poll_timeout_atomic(LAN743X_CSR_READ_OP, offset, data,
+					 target_value == !!(data & bit_mask),
+					 udelay_max, udelay_min * count);
+}
+
 static int lan743x_csr_wait_for_bit(struct lan743x_adapter *adapter,
 				    int offset, u32 bit_mask,
 				    int target_value, int usleep_min,
@@ -671,8 +683,8 @@ static int lan743x_dp_write(struct lan74
 	u32 dp_sel;
 	int i;
 
-	if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-				     1, 40, 100, 100))
+	if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL, DP_SEL_DPRDY_,
+					    1, 40, 100, 100))
 		return -EIO;
 	dp_sel = lan743x_csr_read(adapter, DP_SEL);
 	dp_sel &= ~DP_SEL_MASK_;
@@ -683,8 +695,9 @@ static int lan743x_dp_write(struct lan74
 		lan743x_csr_write(adapter, DP_ADDR, addr + i);
 		lan743x_csr_write(adapter, DP_DATA_0, buf[i]);
 		lan743x_csr_write(adapter, DP_CMD, DP_CMD_WRITE_);
-		if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-					     1, 40, 100, 100))
+		if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL,
+						    DP_SEL_DPRDY_,
+						    1, 40, 100, 100))
 			return -EIO;
 	}
 



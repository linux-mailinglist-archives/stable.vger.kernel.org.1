Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813367352DA
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjFSKis (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjFSKir (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:38:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EA1E9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:38:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BB6F60B62
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465E2C433C8;
        Mon, 19 Jun 2023 10:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171124;
        bh=s23RElRo4I1+btZKi2DFt49uU+2pyWw/JgJmuo7oVGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGydXn/RTYr3ZtqiAgyV7xRo9iulvwLRCltBYfPZ1Dglz/RFR+/jiD33K9AYsZN0/
         CY6J2X5Z0mxLLQP6D76Zy8/o92CJ1WuHxrL8wH0lgp5M7R4tWxN2aiPFtWb/sz2ZtL
         V0bS/yyfIseA3YWbHrbEcNFo88nnBMwO70A8i3MI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kamil Maziarz <kamil.maziarz@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH 6.3 121/187] ice: Fix XDP memory leak when NIC is brought up and down
Date:   Mon, 19 Jun 2023 12:28:59 +0200
Message-ID: <20230619102203.392476661@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Kamil Maziarz <kamil.maziarz@intel.com>

[ Upstream commit 78c50d6961fc05491ebbc71c35d87324b1a4f49a ]

Fix the buffer leak that occurs while switching
the port up and down with traffic and XDP by
checking for an active XDP program and freeing all empty TX buffers.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0d8b8c6f9bd35..0c949ed22a313 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7048,6 +7048,10 @@ int ice_down(struct ice_vsi *vsi)
 	ice_for_each_txq(vsi, i)
 		ice_clean_tx_ring(vsi->tx_rings[i]);
 
+	if (ice_is_xdp_ena_vsi(vsi))
+		ice_for_each_xdp_txq(vsi, i)
+			ice_clean_tx_ring(vsi->xdp_rings[i]);
+
 	ice_for_each_rxq(vsi, i)
 		ice_clean_rx_ring(vsi->rx_rings[i]);
 
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1057352C6
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjFSKiE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjFSKhy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB2A10C8
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B469760B42
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C856AC433C0;
        Mon, 19 Jun 2023 10:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171072;
        bh=a3o3G1GJnVFqp1aaRHmbz0DXWo5dGagTNEw6KYUpR/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XolFs1k/8OEB5xGWf9L6x9Tet7J38zlUABeDOlNESCVBQmMYC9no1Obf1J+FC1jXH
         po0skBshDZwSqyqJwNoqHNn/2amMIsaDedzaW4eOCmaXS95EYnIBhnMsxOWIJ/Z5aO
         tYJykruP4UQLFUdPPJjkCSTG6PkxPkIeLLmDNFtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nithin Dabilpuram <ndabilpuram@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 138/187] octeontx2-af: fix lbk link credits on cn10k
Date:   Mon, 19 Jun 2023 12:29:16 +0200
Message-ID: <20230619102204.314407886@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

[ Upstream commit 87e12a17eef476bbf768dc3a74419ad461f36fbc ]

Fix LBK link credits on CN10K to be same as CN9K i.e
16 * MAX_LBK_DATA_RATE instead of current scheme of
calculation based on LBK buf length / FIFO size.

Fixes: 6e54e1c5399a ("octeontx2-af: cn10K: Add MTU configuration")
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 1e058b96cbe27..f01d057ad025a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4081,10 +4081,6 @@ int rvu_mbox_handler_nix_set_rx_cfg(struct rvu *rvu, struct nix_rx_cfg *req,
 
 static u64 rvu_get_lbk_link_credits(struct rvu *rvu, u16 lbk_max_frs)
 {
-	/* CN10k supports 72KB FIFO size and max packet size of 64k */
-	if (rvu->hw->lbk_bufsize == 0x12000)
-		return (rvu->hw->lbk_bufsize - lbk_max_frs) / 16;
-
 	return 1600; /* 16 * max LBK datarate = 16 * 100Gbps */
 }
 
-- 
2.39.2




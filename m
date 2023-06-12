Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521E972C1D9
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbjFLLBC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbjFLLAq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DB4449B
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9804662490
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE87BC4339C;
        Mon, 12 Jun 2023 10:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566851;
        bh=dQ8kHY01IsBZ+NL69o6CokUYu8fBV5DXd10gW+5eH5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zfncRhE8g2GYkQQFMlH737WzAn6g1a8fcqSnUKPJLrnPdTbm7Pad5Pp46zvfE6b9d
         fR0b8uHreg1OXQwyBbvp1gxntkd6Bgpb1HV8QBqkD9BLd71WrcGQWTPDYkLuXmB3uf
         plPWuBxV3dh40Zowtc+/EoEU+BonNEgyE2AEciKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Fang <wei.fang@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 016/160] net: enetc: correct rx_bytes statistics of XDP
Date:   Mon, 12 Jun 2023 12:25:48 +0200
Message-ID: <20230612101715.819698574@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit fdebd850cc065495abf1d64756496050bb22db67 ]

The rx_bytes statistics of XDP are always zero, because rx_byte_cnt
is not updated after it is initialized to 0. So fix it.

Fixes: d1b15102dd16 ("net: enetc: add support for XDP_DROP and XDP_PASS")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index f7248aed93d98..24024745ecef6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1564,6 +1564,14 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 		enetc_build_xdp_buff(rx_ring, bd_status, &rxbd, &i,
 				     &cleaned_cnt, &xdp_buff);
 
+		/* When set, the outer VLAN header is extracted and reported
+		 * in the receive buffer descriptor. So rx_byte_cnt should
+		 * add the length of the extracted VLAN header.
+		 */
+		if (bd_status & ENETC_RXBD_FLAG_VLAN)
+			rx_byte_cnt += VLAN_HLEN;
+		rx_byte_cnt += xdp_get_buff_len(&xdp_buff);
+
 		xdp_act = bpf_prog_run_xdp(prog, &xdp_buff);
 
 		switch (xdp_act) {
-- 
2.39.2




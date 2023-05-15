Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B95703A8C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244879AbjEORwW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244740AbjEORwD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:52:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6B616920
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8052462F0F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8164DC4339B;
        Mon, 15 May 2023 17:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172971;
        bh=xMrFAoh38Lf0+4jQsrvPJxGNdrMitewQdeJ/LJiL4nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2VJLg1zqD+aqIjXKae86ODsypzMvWkRBGlDVMNXDcpGvEd10liBocvCjLWo3RFQx
         TB1t1eTgNuMwC0n3Up5JFHz04kTpIOh5eWDGGTpaRoyYAqdZtBiPEuixkOOAecNIaV
         Ga5m4Q8AssNdXefDYk9AxZBCkMX1VyYO0jqbEIj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Fang <wei.fang@nxp.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 327/381] net: enetc: check the index of the SFI rather than the handle
Date:   Mon, 15 May 2023 18:29:38 +0200
Message-Id: <20230515161751.575423067@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit 299efdc2380aac588557f4d0b2ce7bee05bd0cf2 ]

We should check whether the current SFI (Stream Filter Instance) table
is full before creating a new SFI entry. However, the previous logic
checks the handle by mistake and might lead to unpredictable behavior.

Fixes: 888ae5a3952b ("net: enetc: add tc flower psfp offload driver")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 5841721c81190..8d92dc6bc9945 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -1266,7 +1266,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 		int index;
 
 		index = enetc_get_free_index(priv);
-		if (sfi->handle < 0) {
+		if (index < 0) {
 			NL_SET_ERR_MSG_MOD(extack, "No Stream Filter resource!");
 			err = -ENOSPC;
 			goto free_fmi;
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D221755408
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGPUZu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjGPUZt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:25:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105971B7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A53260EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA533C433C8;
        Sun, 16 Jul 2023 20:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539148;
        bh=LBFDSlMYGa2AvTCgdLFaCibJvefSHD+d3UqB7OUccqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9NDRbve6spaPqw/elWHGvndLzOpoozWxnBA3Ry+8zKAFzqkCflmX4l8D0hDpBqnr
         idLzgd9crClNnyf4pbVTq1x9T/1pwc7Tm2oK73leawRjtN9MjybYoJb/91+7m84dMh
         +WilBK/Q7NKzrVMMDCfG7i92OkfIjD3bqqfVo6nQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 705/800] octeontx-af: fix hardware timestamp configuration
Date:   Sun, 16 Jul 2023 21:49:18 +0200
Message-ID: <20230716195005.496095998@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit 14bb236b29922c4f57d8c05bfdbcb82677f917c9 ]

MAC block on CN10K (RPM) supports hardware timestamp configuration. The
previous patch which added timestamp configuration support has a bug.
Though the netdev driver requests to disable timestamp configuration,
the driver is always enabling it.

This patch fixes the same.

Fixes: d1489208681d ("octeontx2-af: cn10k: RPM hardware timestamp configuration")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 4b8559ac0404f..095b2cc4a6999 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -763,7 +763,7 @@ static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16 pcifunc, bool enable)
 	cgxd = rvu_cgx_pdata(cgx_id, rvu);
 
 	mac_ops = get_mac_ops(cgxd);
-	mac_ops->mac_enadis_ptp_config(cgxd, lmac_id, true);
+	mac_ops->mac_enadis_ptp_config(cgxd, lmac_id, enable);
 	/* If PTP is enabled then inform NPC that packets to be
 	 * parsed by this PF will have their data shifted by 8 bytes
 	 * and if PTP is disabled then no shift is required
-- 
2.39.2




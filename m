Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2CA761222
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjGYK7u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjGYK7Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC871FD3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:56:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF35E6166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EB6C433C8;
        Tue, 25 Jul 2023 10:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282578;
        bh=Brdlo8b9PQ91L9E8OYoZ37v5QyHFrWOJuQKU2DiFZXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/GywvDa6Zanwzgf4CWICV96mlYHGuWdWObzwCmbgXTfYhlz2VJoM85DOFEh2b8J+
         QOVBZLAo4o+545Epx3R678+Ia4hZG0balLuAhfAifmlQXiprCg3ar00Sl9I3d0s2Z2
         rxEB62fmj4ECqCnDQ0kiafTDWgIfXJvcPCXKqQeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Geetha sowjanya <gakula@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 179/227] octeontx2-pf: Dont allocate BPIDs for LBK interfaces
Date:   Tue, 25 Jul 2023 12:45:46 +0200
Message-ID: <20230725104522.235898022@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Geetha sowjanya <gakula@marvell.com>

[ Upstream commit 8fcd7c7b3a38ab5e452f542fda8f7940e77e479a ]

Current driver enables backpressure for LBK interfaces.
But these interfaces do not support this feature.
Hence, this patch fixes the issue by skipping the
backpressure configuration for these interfaces.

Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool").
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Link: https://lore.kernel.org/r/20230716093741.28063-1-gakula@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 18284ad751572..384d26bee9b23 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1452,8 +1452,9 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	if (err)
 		goto err_free_npa_lf;
 
-	/* Enable backpressure */
-	otx2_nix_config_bp(pf, true);
+	/* Enable backpressure for CGX mapped PF/VFs */
+	if (!is_otx2_lbkvf(pf->pdev))
+		otx2_nix_config_bp(pf, true);
 
 	/* Init Auras and pools used by NIX RQ, for free buffer ptrs */
 	err = otx2_rq_aura_pool_init(pf);
-- 
2.39.2




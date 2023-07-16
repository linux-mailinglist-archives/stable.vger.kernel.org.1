Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0FB7553F4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjGPUYy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjGPUYx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16959F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77DF960EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DFAC433C7;
        Sun, 16 Jul 2023 20:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539091;
        bh=H9FIY/Na+OMcJuPlbpyr2AflDyB9HGFfSbjH/P6nK2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1jjVRYanX1QHDVRczrotegyS42kjSctMVTrfcClF/qWocg99Uq+HQXAtGLJxiGLwR
         O7xP2MTKDtboMwjVMHoJ0XrIG+NElAJbwjm8n2npkzED4S+azQaSrO6Ymo7qNPmfWt
         y1rcx9gEKnTJLiyeENSayOfED9yF7sVmSWnaKWGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 684/800] octeontx2-af: cn10kb: fix interrupt csr addresses
Date:   Sun, 16 Jul 2023 21:48:57 +0200
Message-ID: <20230716195005.011954981@linuxfoundation.org>
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

[ Upstream commit 4c5a331cacda995e995a7857f0e44e8937d98d2c ]

The current design is that, for asynchronous events like link_up and
link_down firmware raises the interrupt to kernel. The previous patch
which added RPM_USX driver has a bug where it uses old csr addresses
for configuring interrupts. Which is resulting in losing interrupts
from source firmware.

This patch fixes the issue by correcting csr addresses.

Fixes: b9d0fedc6234 ("octeontx2-af: cn10kb: Add RPM_USX MAC support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index de0d88dd10d65..a433f92c51eae 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -47,7 +47,7 @@ static struct mac_ops		rpm2_mac_ops   = {
 	.int_set_reg    =       RPM2_CMRX_SW_INT_ENA_W1S,
 	.irq_offset     =       1,
 	.int_ena_bit    =       BIT_ULL(0),
-	.lmac_fwi	=	RPM_LMAC_FWI,
+	.lmac_fwi	=	RPM2_LMAC_FWI,
 	.non_contiguous_serdes_lane = true,
 	.rx_stats_cnt   =       43,
 	.tx_stats_cnt   =       34,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index 22147b4c21370..be294eebab265 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -94,7 +94,8 @@
 
 /* CN10KB CSR Declaration */
 #define  RPM2_CMRX_SW_INT				0x1b0
-#define  RPM2_CMRX_SW_INT_ENA_W1S			0x1b8
+#define  RPM2_CMRX_SW_INT_ENA_W1S			0x1c8
+#define  RPM2_LMAC_FWI					0x12
 #define  RPM2_CMR_CHAN_MSK_OR				0x3120
 #define  RPM2_CMR_RX_OVR_BP_EN				BIT_ULL(2)
 #define  RPM2_CMR_RX_OVR_BP_BP				BIT_ULL(1)
-- 
2.39.2




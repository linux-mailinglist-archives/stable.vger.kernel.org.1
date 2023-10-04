Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39257B8838
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbjJDSNy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243752AbjJDSNy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:13:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09855A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:13:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB7FC433C7;
        Wed,  4 Oct 2023 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443230;
        bh=QM4Hn4l4cr3zBEogZ+8L9Fn2DshVGHyV3Esy9VkpSjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvCZfETUYYu/TT48W4nfzRCVpCDDLDtLpUYF8y+FFsI/BoDQIoNwbzDF39g2ACW7F
         KRuf8if6yNsNY29BadFDzP9p05vlA54WoB2JRDK9TF4wLzAko6V8WTN2WgJ3B/IHLY
         wzQbOtxV2pqQrGobcuJrnuva4KKmTLdU966rSAS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Chan <michael.chan@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 082/259] bnxt_en: Flush XDP for bnxt_poll_nitroa0()s NAPI
Date:   Wed,  4 Oct 2023 19:54:15 +0200
Message-ID: <20231004175221.136969834@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit edc0140cc3b7b91874ebe70eb7d2a851e8817ccc ]

bnxt_poll_nitroa0() invokes bnxt_rx_pkt() which can run a XDP program
which in turn can return XDP_REDIRECT. bnxt_rx_pkt() is also used by
__bnxt_poll_work() which flushes (xdp_do_flush()) the packets after each
round. bnxt_poll_nitroa0() lacks this feature.
xdp_do_flush() should be invoked before leaving the NAPI callback.

Invoke xdp_do_flush() after a redirect in bnxt_poll_nitroa0() NAPI.

Cc: Michael Chan <michael.chan@broadcom.com>
Fixes: f18c2b77b2e4e ("bnxt_en: optimized XDP_REDIRECT support")
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 969db3c45d176..e81cb825dff4c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2654,6 +2654,7 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
 	struct rx_cmp_ext *rxcmp1;
 	u32 cp_cons, tmp_raw_cons;
 	u32 raw_cons = cpr->cp_raw_cons;
+	bool flush_xdp = false;
 	u32 rx_pkts = 0;
 	u8 event = 0;
 
@@ -2688,6 +2689,8 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
 				rx_pkts++;
 			else if (rc == -EBUSY)	/* partial completion */
 				break;
+			if (event & BNXT_REDIRECT_EVENT)
+				flush_xdp = true;
 		} else if (unlikely(TX_CMP_TYPE(txcmp) ==
 				    CMPL_BASE_TYPE_HWRM_DONE)) {
 			bnxt_hwrm_handler(bp, txcmp);
@@ -2707,6 +2710,8 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
 
 	if (event & BNXT_AGG_EVENT)
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
+	if (flush_xdp)
+		xdp_do_flush();
 
 	if (!bnxt_has_work(bp, cpr) && rx_pkts < budget) {
 		napi_complete_done(napi, rx_pkts);
-- 
2.40.1




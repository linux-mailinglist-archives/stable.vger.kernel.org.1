Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C175CD65
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjGUQKq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjGUQKo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CBD3588
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED5EF61D1D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE96C433C8;
        Fri, 21 Jul 2023 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955838;
        bh=KF3R1KxvvUF/VOgEwbPTeziXH5AI9BcQJpkGSiETgBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmYhw09C1Fa8aeEHVcL/3Qpjkm3BXCO3A9M27Km369ogB1VTeAiJHsvRfJeqJXZze
         KLEIvMIk5U5zbDqvRy9C1g1QS/R7+3gByxw5TO8NAwaiV/04A+rWFNF3R2RZgcDvDy
         mGP1mvMipLuF4J0jtfyOVzoFWfsz0N8MOhANkLiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 023/292] igc: Add igc_xdp_buff wrapper for xdp_buff in driver
Date:   Fri, 21 Jul 2023 18:02:12 +0200
Message-ID: <20230721160529.798525346@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 73b7123de0cfa4f6609677e927ab02cb05b593c2 ]

Driver specific metadata data for XDP-hints kfuncs are propagated via tail
extending the struct xdp_buff with a locally scoped driver struct.

Zero-Copy AF_XDP/XSK does similar tricks via struct xdp_buff_xsk. This
xdp_buff_xsk struct contains a CB area (24 bytes) that can be used for
extending the locally scoped driver into. The XSK_CHECK_PRIV_TYPE define
catch size violations build time.

The changes needed for AF_XDP zero-copy in igc_clean_rx_irq_zc()
is done in next patch, because the member rx_desc isn't available
at this point.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Yoong Siang <yoong.siang.song@intel.com>
Link: https://lore.kernel.org/bpf/168182464779.616355.3761989884165609387.stgit@firesoul
Stable-dep-of: 175c241288c0 ("igc: Fix TX Hang issue when QBV Gate is closed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc.h      |  5 +++++
 drivers/net/ethernet/intel/igc/igc_main.c | 16 +++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 9902f726f06a9..3bb48840a249e 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -502,6 +502,11 @@ struct igc_rx_buffer {
 	};
 };
 
+/* context wrapper around xdp_buff to provide access to descriptor metadata */
+struct igc_xdp_buff {
+	struct xdp_buff xdp;
+};
+
 struct igc_q_vector {
 	struct igc_adapter *adapter;    /* backlink */
 	void __iomem *itr_register;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index b131c8f2b03df..c6169357f72fc 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2246,6 +2246,8 @@ static bool igc_alloc_rx_buffers_zc(struct igc_ring *ring, u16 count)
 	if (!count)
 		return ok;
 
+	XSK_CHECK_PRIV_TYPE(struct igc_xdp_buff);
+
 	desc = IGC_RX_DESC(ring, i);
 	bi = &ring->rx_buffer_info[i];
 	i -= ring->count;
@@ -2530,8 +2532,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		union igc_adv_rx_desc *rx_desc;
 		struct igc_rx_buffer *rx_buffer;
 		unsigned int size, truesize;
+		struct igc_xdp_buff ctx;
 		ktime_t timestamp = 0;
-		struct xdp_buff xdp;
 		int pkt_offset = 0;
 		void *pktbuf;
 
@@ -2565,13 +2567,13 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		}
 
 		if (!skb) {
-			xdp_init_buff(&xdp, truesize, &rx_ring->xdp_rxq);
-			xdp_prepare_buff(&xdp, pktbuf - igc_rx_offset(rx_ring),
+			xdp_init_buff(&ctx.xdp, truesize, &rx_ring->xdp_rxq);
+			xdp_prepare_buff(&ctx.xdp, pktbuf - igc_rx_offset(rx_ring),
 					 igc_rx_offset(rx_ring) + pkt_offset,
 					 size, true);
-			xdp_buff_clear_frags_flag(&xdp);
+			xdp_buff_clear_frags_flag(&ctx.xdp);
 
-			skb = igc_xdp_run_prog(adapter, &xdp);
+			skb = igc_xdp_run_prog(adapter, &ctx.xdp);
 		}
 
 		if (IS_ERR(skb)) {
@@ -2593,9 +2595,9 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		} else if (skb)
 			igc_add_rx_frag(rx_ring, rx_buffer, skb, size);
 		else if (ring_uses_build_skb(rx_ring))
-			skb = igc_build_skb(rx_ring, rx_buffer, &xdp);
+			skb = igc_build_skb(rx_ring, rx_buffer, &ctx.xdp);
 		else
-			skb = igc_construct_skb(rx_ring, rx_buffer, &xdp,
+			skb = igc_construct_skb(rx_ring, rx_buffer, &ctx.xdp,
 						timestamp);
 
 		/* exit if we failed to retrieve a buffer */
-- 
2.39.2




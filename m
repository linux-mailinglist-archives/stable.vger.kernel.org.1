Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F79375CD67
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjGUQKx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGUQKq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:10:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E983E30C1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC4CB61D2D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C810BC433C7;
        Fri, 21 Jul 2023 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955841;
        bh=sINM0OUyVdukkM1eoTKZNlmFGBz7k1oI/cghlVZclb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSY6ONMnjzEOCX0nYSNyQtb6/PdIP5TlEvCfL9s6tHFYr3G8rjsVgIYH2kTA8Ry9W
         RwirH+DjnOftCRt4p3WuIew+jGBdqCGUWv/Yoo+OtU/cYOlSvJM1qOwZTcVQLKSmq+
         U/BfYQthDM4HLWcgyhffLucI/+B6COWggkL8qK0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 024/292] igc: Add XDP hints kfuncs for RX hash
Date:   Fri, 21 Jul 2023 18:02:13 +0200
Message-ID: <20230721160529.840909050@linuxfoundation.org>
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

[ Upstream commit 8416814fffa9cfa74c18da149f522dd9e1850987 ]

This implements XDP hints kfunc for RX-hash (xmo_rx_hash).
The HW rss hash type is handled via mapping table.

This igc driver (default config) does L3 hashing for UDP packets
(excludes UDP src/dest ports in hash calc).  Meaning RSS hash type is
L3 based.  Tested that the igc_rss_type_num for UDP is either
IGC_RSS_TYPE_HASH_IPV4 or IGC_RSS_TYPE_HASH_IPV6.

This patch also updates AF_XDP zero-copy function igc_clean_rx_irq_zc()
to use the xdp_buff wrapper struct igc_xdp_buff.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Yoong Siang <yoong.siang.song@intel.com>
Link: https://lore.kernel.org/bpf/168182465285.616355.2701740913376314790.stgit@firesoul
Stable-dep-of: 175c241288c0 ("igc: Fix TX Hang issue when QBV Gate is closed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 53 +++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 3bb48840a249e..f09c6a65e3ab8 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -505,6 +505,7 @@ struct igc_rx_buffer {
 /* context wrapper around xdp_buff to provide access to descriptor metadata */
 struct igc_xdp_buff {
 	struct xdp_buff xdp;
+	union igc_adv_rx_desc *rx_desc;
 };
 
 struct igc_q_vector {
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index c6169357f72fc..c0e21701e7817 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2572,6 +2572,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 					 igc_rx_offset(rx_ring) + pkt_offset,
 					 size, true);
 			xdp_buff_clear_frags_flag(&ctx.xdp);
+			ctx.rx_desc = rx_desc;
 
 			skb = igc_xdp_run_prog(adapter, &ctx.xdp);
 		}
@@ -2698,6 +2699,15 @@ static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
 	napi_gro_receive(&q_vector->napi, skb);
 }
 
+static struct igc_xdp_buff *xsk_buff_to_igc_ctx(struct xdp_buff *xdp)
+{
+	/* xdp_buff pointer used by ZC code path is alloc as xdp_buff_xsk. The
+	 * igc_xdp_buff shares its layout with xdp_buff_xsk and private
+	 * igc_xdp_buff fields fall into xdp_buff_xsk->cb
+	 */
+       return (struct igc_xdp_buff *)xdp;
+}
+
 static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 {
 	struct igc_adapter *adapter = q_vector->adapter;
@@ -2716,6 +2726,7 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 	while (likely(total_packets < budget)) {
 		union igc_adv_rx_desc *desc;
 		struct igc_rx_buffer *bi;
+		struct igc_xdp_buff *ctx;
 		ktime_t timestamp = 0;
 		unsigned int size;
 		int res;
@@ -2733,6 +2744,9 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 
 		bi = &ring->rx_buffer_info[ntc];
 
+		ctx = xsk_buff_to_igc_ctx(bi->xdp);
+		ctx->rx_desc = desc;
+
 		if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
 			timestamp = igc_ptp_rx_pktstamp(q_vector->adapter,
 							bi->xdp->data);
@@ -6490,6 +6504,44 @@ u32 igc_rd32(struct igc_hw *hw, u32 reg)
 	return value;
 }
 
+/* Mapping HW RSS Type to enum xdp_rss_hash_type */
+static enum xdp_rss_hash_type igc_xdp_rss_type[IGC_RSS_TYPE_MAX_TABLE] = {
+	[IGC_RSS_TYPE_NO_HASH]		= XDP_RSS_TYPE_L2,
+	[IGC_RSS_TYPE_HASH_TCP_IPV4]	= XDP_RSS_TYPE_L4_IPV4_TCP,
+	[IGC_RSS_TYPE_HASH_IPV4]	= XDP_RSS_TYPE_L3_IPV4,
+	[IGC_RSS_TYPE_HASH_TCP_IPV6]	= XDP_RSS_TYPE_L4_IPV6_TCP,
+	[IGC_RSS_TYPE_HASH_IPV6_EX]	= XDP_RSS_TYPE_L3_IPV6_EX,
+	[IGC_RSS_TYPE_HASH_IPV6]	= XDP_RSS_TYPE_L3_IPV6,
+	[IGC_RSS_TYPE_HASH_TCP_IPV6_EX] = XDP_RSS_TYPE_L4_IPV6_TCP_EX,
+	[IGC_RSS_TYPE_HASH_UDP_IPV4]	= XDP_RSS_TYPE_L4_IPV4_UDP,
+	[IGC_RSS_TYPE_HASH_UDP_IPV6]	= XDP_RSS_TYPE_L4_IPV6_UDP,
+	[IGC_RSS_TYPE_HASH_UDP_IPV6_EX] = XDP_RSS_TYPE_L4_IPV6_UDP_EX,
+	[10] = XDP_RSS_TYPE_NONE, /* RSS Type above 9 "Reserved" by HW  */
+	[11] = XDP_RSS_TYPE_NONE, /* keep array sized for SW bit-mask   */
+	[12] = XDP_RSS_TYPE_NONE, /* to handle future HW revisons       */
+	[13] = XDP_RSS_TYPE_NONE,
+	[14] = XDP_RSS_TYPE_NONE,
+	[15] = XDP_RSS_TYPE_NONE,
+};
+
+static int igc_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			   enum xdp_rss_hash_type *rss_type)
+{
+	const struct igc_xdp_buff *ctx = (void *)_ctx;
+
+	if (!(ctx->xdp.rxq->dev->features & NETIF_F_RXHASH))
+		return -ENODATA;
+
+	*hash = le32_to_cpu(ctx->rx_desc->wb.lower.hi_dword.rss);
+	*rss_type = igc_xdp_rss_type[igc_rss_type(ctx->rx_desc)];
+
+	return 0;
+}
+
+static const struct xdp_metadata_ops igc_xdp_metadata_ops = {
+	.xmo_rx_hash			= igc_xdp_rx_hash,
+};
+
 /**
  * igc_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -6563,6 +6615,7 @@ static int igc_probe(struct pci_dev *pdev,
 	hw->hw_addr = adapter->io_addr;
 
 	netdev->netdev_ops = &igc_netdev_ops;
+	netdev->xdp_metadata_ops = &igc_xdp_metadata_ops;
 	igc_ethtool_set_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 
-- 
2.39.2




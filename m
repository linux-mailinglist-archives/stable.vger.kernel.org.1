Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A804A73E7DE
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjFZSUD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjFZSTw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:19:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD37494
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B22F60E76
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB5CC433C8;
        Mon, 26 Jun 2023 18:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803589;
        bh=RnWInlsMppCAO5MVSCRG6uKZcXCVJoaXTeKTpLWHHYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPqE9RLoh1WSH66i2GN1vREupaoceadkcE395XjLHnWmYPez1AwiEUsN25OmJKKYi
         MCd8pVUAjB/W71qY8D5imlZIKSRI82hU03BGLlwJNgVN3o5X/kGe89ge/b7ZUtUrdq
         /QGtiTyKttlig9aRjBIPrKtZfkhpewfEEFQ2/+Qs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fei Liu <feliu@redhat.com>,
        =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 112/199] sfc: use budget for TX completions
Date:   Mon, 26 Jun 2023 20:10:18 +0200
Message-ID: <20230626180810.559355636@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Íñigo Huguet <ihuguet@redhat.com>

[ Upstream commit 4aaf2c52834b7f95acdf9fb0211a1b60adbf421b ]

When running workloads heavy unbalanced towards TX (high TX, low RX
traffic), sfc driver can retain the CPU during too long times. Although
in many cases this is not enough to be visible, it can affect
performance and system responsiveness.

A way to reproduce it is to use a debug kernel and run some parallel
netperf TX tests. In some systems, this will lead to this message being
logged:
  kernel:watchdog: BUG: soft lockup - CPU#12 stuck for 22s!

The reason is that sfc driver doesn't account any NAPI budget for the TX
completion events work. With high-TX/low-RX traffic, this makes that the
CPU is held for long time for NAPI poll.

Documentations says "drivers can process completions for any number of Tx
packets but should only process up to budget number of Rx packets".
However, many drivers do limit the amount of TX completions that they
process in a single NAPI poll.

In the same way, this patch adds a limit for the TX work in sfc. With
the patch applied, the watchdog warning never appears.

Tested with netperf in different combinations: single process / parallel
processes, TCP / UDP and different sizes of UDP messages. Repeated the
tests before and after the patch, without any noticeable difference in
network or CPU performance.

Test hardware:
Intel(R) Xeon(R) CPU E5-1620 v4 @ 3.50GHz (4 cores, 2 threads/core)
Solarflare Communications XtremeScale X2522-25G Network Adapter

Fixes: 5227ecccea2d ("sfc: remove tx and MCDI handling from NAPI budget consideration")
Fixes: d19a53721863 ("sfc_ef100: TX path for EF100 NICs")
Reported-by: Fei Liu <feliu@redhat.com>
Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
Acked-by: Martin Habets <habetsm.xilinx@gmail.com>
Link: https://lore.kernel.org/r/20230615084929.10506-1-ihuguet@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/ef10.c      | 25 ++++++++++++++++++-------
 drivers/net/ethernet/sfc/ef100_nic.c |  7 ++++++-
 drivers/net/ethernet/sfc/ef100_tx.c  |  4 ++--
 drivers/net/ethernet/sfc/ef100_tx.h  |  2 +-
 drivers/net/ethernet/sfc/tx_common.c |  4 +++-
 drivers/net/ethernet/sfc/tx_common.h |  2 +-
 6 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index d30459dbfe8f8..b63e47af63655 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -2950,7 +2950,7 @@ static u32 efx_ef10_extract_event_ts(efx_qword_t *event)
 	return tstamp;
 }
 
-static void
+static int
 efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 {
 	struct efx_nic *efx = channel->efx;
@@ -2958,13 +2958,14 @@ efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 	unsigned int tx_ev_desc_ptr;
 	unsigned int tx_ev_q_label;
 	unsigned int tx_ev_type;
+	int work_done;
 	u64 ts_part;
 
 	if (unlikely(READ_ONCE(efx->reset_pending)))
-		return;
+		return 0;
 
 	if (unlikely(EFX_QWORD_FIELD(*event, ESF_DZ_TX_DROP_EVENT)))
-		return;
+		return 0;
 
 	/* Get the transmit queue */
 	tx_ev_q_label = EFX_QWORD_FIELD(*event, ESF_DZ_TX_QLABEL);
@@ -2973,8 +2974,7 @@ efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 	if (!tx_queue->timestamping) {
 		/* Transmit completion */
 		tx_ev_desc_ptr = EFX_QWORD_FIELD(*event, ESF_DZ_TX_DESCR_INDX);
-		efx_xmit_done(tx_queue, tx_ev_desc_ptr & tx_queue->ptr_mask);
-		return;
+		return efx_xmit_done(tx_queue, tx_ev_desc_ptr & tx_queue->ptr_mask);
 	}
 
 	/* Transmit timestamps are only available for 8XXX series. They result
@@ -3000,6 +3000,7 @@ efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 	 * fields in the event.
 	 */
 	tx_ev_type = EFX_QWORD_FIELD(*event, ESF_EZ_TX_SOFT1);
+	work_done = 0;
 
 	switch (tx_ev_type) {
 	case TX_TIMESTAMP_EVENT_TX_EV_COMPLETION:
@@ -3016,6 +3017,7 @@ efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 		tx_queue->completed_timestamp_major = ts_part;
 
 		efx_xmit_done_single(tx_queue);
+		work_done = 1;
 		break;
 
 	default:
@@ -3026,6 +3028,8 @@ efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 			  EFX_QWORD_VAL(*event));
 		break;
 	}
+
+	return work_done;
 }
 
 static void
@@ -3081,13 +3085,16 @@ static void efx_ef10_handle_driver_generated_event(struct efx_channel *channel,
 	}
 }
 
+#define EFX_NAPI_MAX_TX 512
+
 static int efx_ef10_ev_process(struct efx_channel *channel, int quota)
 {
 	struct efx_nic *efx = channel->efx;
 	efx_qword_t event, *p_event;
 	unsigned int read_ptr;
-	int ev_code;
+	int spent_tx = 0;
 	int spent = 0;
+	int ev_code;
 
 	if (quota <= 0)
 		return spent;
@@ -3126,7 +3133,11 @@ static int efx_ef10_ev_process(struct efx_channel *channel, int quota)
 			}
 			break;
 		case ESE_DZ_EV_CODE_TX_EV:
-			efx_ef10_handle_tx_event(channel, &event);
+			spent_tx += efx_ef10_handle_tx_event(channel, &event);
+			if (spent_tx >= EFX_NAPI_MAX_TX) {
+				spent = quota;
+				goto out;
+			}
 			break;
 		case ESE_DZ_EV_CODE_DRIVER_EV:
 			efx_ef10_handle_driver_event(channel, &event);
diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
index 4dc643b0d2db4..7adde9639c8ab 100644
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -253,6 +253,8 @@ static void ef100_ev_read_ack(struct efx_channel *channel)
 		   efx_reg(channel->efx, ER_GZ_EVQ_INT_PRIME));
 }
 
+#define EFX_NAPI_MAX_TX 512
+
 static int ef100_ev_process(struct efx_channel *channel, int quota)
 {
 	struct efx_nic *efx = channel->efx;
@@ -260,6 +262,7 @@ static int ef100_ev_process(struct efx_channel *channel, int quota)
 	bool evq_phase, old_evq_phase;
 	unsigned int read_ptr;
 	efx_qword_t *p_event;
+	int spent_tx = 0;
 	int spent = 0;
 	bool ev_phase;
 	int ev_type;
@@ -295,7 +298,9 @@ static int ef100_ev_process(struct efx_channel *channel, int quota)
 			efx_mcdi_process_event(channel, p_event);
 			break;
 		case ESE_GZ_EF100_EV_TX_COMPLETION:
-			ef100_ev_tx(channel, p_event);
+			spent_tx += ef100_ev_tx(channel, p_event);
+			if (spent_tx >= EFX_NAPI_MAX_TX)
+				spent = quota;
 			break;
 		case ESE_GZ_EF100_EV_DRIVER:
 			netif_info(efx, drv, efx->net_dev,
diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
index 29ffaf35559d6..849e5555bd128 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.c
+++ b/drivers/net/ethernet/sfc/ef100_tx.c
@@ -346,7 +346,7 @@ void ef100_tx_write(struct efx_tx_queue *tx_queue)
 	ef100_tx_push_buffers(tx_queue);
 }
 
-void ef100_ev_tx(struct efx_channel *channel, const efx_qword_t *p_event)
+int ef100_ev_tx(struct efx_channel *channel, const efx_qword_t *p_event)
 {
 	unsigned int tx_done =
 		EFX_QWORD_FIELD(*p_event, ESF_GZ_EV_TXCMPL_NUM_DESC);
@@ -357,7 +357,7 @@ void ef100_ev_tx(struct efx_channel *channel, const efx_qword_t *p_event)
 	unsigned int tx_index = (tx_queue->read_count + tx_done - 1) &
 				tx_queue->ptr_mask;
 
-	efx_xmit_done(tx_queue, tx_index);
+	return efx_xmit_done(tx_queue, tx_index);
 }
 
 /* Add a socket buffer to a TX queue
diff --git a/drivers/net/ethernet/sfc/ef100_tx.h b/drivers/net/ethernet/sfc/ef100_tx.h
index e9e11540fcdea..d9a0819c5a72c 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.h
+++ b/drivers/net/ethernet/sfc/ef100_tx.h
@@ -20,7 +20,7 @@ void ef100_tx_init(struct efx_tx_queue *tx_queue);
 void ef100_tx_write(struct efx_tx_queue *tx_queue);
 unsigned int ef100_tx_max_skb_descs(struct efx_nic *efx);
 
-void ef100_ev_tx(struct efx_channel *channel, const efx_qword_t *p_event);
+int ef100_ev_tx(struct efx_channel *channel, const efx_qword_t *p_event);
 
 netdev_tx_t ef100_enqueue_skb(struct efx_tx_queue *tx_queue, struct sk_buff *skb);
 int __ef100_enqueue_skb(struct efx_tx_queue *tx_queue, struct sk_buff *skb,
diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
index 67e789b96c437..755aa92bf8236 100644
--- a/drivers/net/ethernet/sfc/tx_common.c
+++ b/drivers/net/ethernet/sfc/tx_common.c
@@ -249,7 +249,7 @@ void efx_xmit_done_check_empty(struct efx_tx_queue *tx_queue)
 	}
 }
 
-void efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index)
+int efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index)
 {
 	unsigned int fill_level, pkts_compl = 0, bytes_compl = 0;
 	unsigned int efv_pkts_compl = 0;
@@ -279,6 +279,8 @@ void efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index)
 	}
 
 	efx_xmit_done_check_empty(tx_queue);
+
+	return pkts_compl + efv_pkts_compl;
 }
 
 /* Remove buffers put into a tx_queue for the current packet.
diff --git a/drivers/net/ethernet/sfc/tx_common.h b/drivers/net/ethernet/sfc/tx_common.h
index d87aecbc7bf1a..1e9f42938aac9 100644
--- a/drivers/net/ethernet/sfc/tx_common.h
+++ b/drivers/net/ethernet/sfc/tx_common.h
@@ -28,7 +28,7 @@ static inline bool efx_tx_buffer_in_use(struct efx_tx_buffer *buffer)
 }
 
 void efx_xmit_done_check_empty(struct efx_tx_queue *tx_queue);
-void efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index);
+int efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index);
 
 void efx_enqueue_unwind(struct efx_tx_queue *tx_queue,
 			unsigned int insert_count);
-- 
2.39.2




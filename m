Return-Path: <stable+bounces-148063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B89DAC79F5
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 09:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE041BA7E24
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 07:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77EA2192FB;
	Thu, 29 May 2025 07:53:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91EE2192F4
	for <stable@vger.kernel.org>; Thu, 29 May 2025 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748505219; cv=none; b=sMM6dziG4tZ3v5EugDFngHLrSWrxhDajNAWBzfRVvA6ypBctu60o0BIc3rFooEAXt+6HkB7/7wPbd272XHNrgtJ/5A1IF80Gj6uUuVauDIFhhAhhLF9sAECZ4DbLb0Oft5wlq7CJ/7zPkzRLjff844rnD2aop+7NaXlEtgGWlVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748505219; c=relaxed/simple;
	bh=kr73x78PzXCikBaKHpPQM6784ek/MZapQ/9WUk5LZes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYVETthdUMc8jYhnOyXQytqQdPQWPg0/yZpZ8B9G5HQJ/BqxA3D4dOKOlOPB0fTqGSL8dS8P0nLHRQg+X6HH0oRfLhvFCFE6kKuQYQf5x64F2AylXE/kAbxXUIF6WuXXCAQ2VdgT1pZoTPLKtN08a+uDor6Tgl2tE8Hzc+HlD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKY52-0006LX-4Z
	for stable@vger.kernel.org; Thu, 29 May 2025 09:53:36 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKY51-000igZ-33
	for stable@vger.kernel.org;
	Thu, 29 May 2025 09:53:35 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9A8D241BF14
	for <stable@vger.kernel.org>; Thu, 29 May 2025 07:53:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 61EFC41BF0A;
	Thu, 29 May 2025 07:53:26 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a96490de;
	Thu, 29 May 2025 07:53:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net] can: kvaser_pciefd: refine error prone echo_skb_max handling logic
Date: Thu, 29 May 2025 09:49:30 +0200
Message-ID: <20250529075313.1101820-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250529075313.1101820-1-mkl@pengutronix.de>
References: <20250529075313.1101820-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

From: Fedor Pchelkin <pchelkin@ispras.ru>

echo_skb_max should define the supported upper limit of echo_skb[]
allocated inside the netdevice's priv. The corresponding size value
provided by this driver to alloc_candev() is KVASER_PCIEFD_CAN_TX_MAX_COUNT
which is 17.

But later echo_skb_max is rounded up to the nearest power of two (for the
max case, that would be 32) and the tx/ack indices calculated further
during tx/rx may exceed the upper array boundary. Kasan reported this for
the ack case inside kvaser_pciefd_handle_ack_packet(), though the xmit
function has actually caught the same thing earlier.

 BUG: KASAN: slab-out-of-bounds in kvaser_pciefd_handle_ack_packet+0x2d7/0x92a drivers/net/can/kvaser_pciefd.c:1528
 Read of size 8 at addr ffff888105e4f078 by task swapper/4/0

 CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 6.15.0 #12 PREEMPT(voluntary)
 Call Trace:
  <IRQ>
 dump_stack_lvl lib/dump_stack.c:122
 print_report mm/kasan/report.c:521
 kasan_report mm/kasan/report.c:634
 kvaser_pciefd_handle_ack_packet drivers/net/can/kvaser_pciefd.c:1528
 kvaser_pciefd_read_packet drivers/net/can/kvaser_pciefd.c:1605
 kvaser_pciefd_read_buffer drivers/net/can/kvaser_pciefd.c:1656
 kvaser_pciefd_receive_irq drivers/net/can/kvaser_pciefd.c:1684
 kvaser_pciefd_irq_handler drivers/net/can/kvaser_pciefd.c:1733
 __handle_irq_event_percpu kernel/irq/handle.c:158
 handle_irq_event kernel/irq/handle.c:210
 handle_edge_irq kernel/irq/chip.c:833
 __common_interrupt arch/x86/kernel/irq.c:296
 common_interrupt arch/x86/kernel/irq.c:286
  </IRQ>

Tx max count definitely matters for kvaser_pciefd_tx_avail(), but for seq
numbers' generation that's not the case - we're free to calculate them as
would be more convenient, not taking tx max count into account. The only
downside is that the size of echo_skb[] should correspond to the max seq
number (not tx max count), so in some situations a bit more memory would
be consumed than could be.

Thus make the size of the underlying echo_skb[] sufficient for the rounded
max tx value.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 8256e0ca6010 ("can: kvaser_pciefd: Fix echo_skb race")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Link: https://patch.msgid.link/20250528192713.63894-1-pchelkin@ispras.ru
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 7d3066691d5d..52301511ed1b 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -966,7 +966,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		u32 status, tx_nr_packets_max;
 
 		netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
-				      KVASER_PCIEFD_CAN_TX_MAX_COUNT);
+				      roundup_pow_of_two(KVASER_PCIEFD_CAN_TX_MAX_COUNT));
 		if (!netdev)
 			return -ENOMEM;
 
@@ -995,7 +995,6 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->tx_max_count = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
 
 		can->can.clock.freq = pcie->freq;
-		can->can.echo_skb_max = roundup_pow_of_two(can->tx_max_count);
 		spin_lock_init(&can->lock);
 
 		can->can.bittiming_const = &kvaser_pciefd_bittiming_const;

base-commit: 271683bb2cf32e5126c592b5d5e6a756fa374fd9
-- 
2.47.2




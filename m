Return-Path: <stable+bounces-224116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPt/Iw0AsGmoeQIAu9opvQ
	(envelope-from <stable+bounces-224116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:27:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF4B24AB70
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7923C3233373
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEEF36EA89;
	Tue, 10 Mar 2026 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtmTyZC7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32887389108;
	Tue, 10 Mar 2026 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141249; cv=none; b=NWV0AX9eFBGO47z5F2H9i7Lx4v32VviRQ7JqnreXYHd+bulwoECD/l+56t4krck4Bm+hDT1aeAvZuNuK4XaUVMyoldMz1MDKGYapcqsmuVMjmPS8Sq3/EOIF2l/KDtNQYV+uKP1e8ul5PCapVo85Vz9xjA7kxTKNc0cRnipz3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141249; c=relaxed/simple;
	bh=64S2yWuK24xY6fH+j5RONgS8TV1Jk+Jm4CVdAbLPUeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOJB5Ygw7K4hym2qErLVsyed5jjO2by3aVCvHpuONsXkTUBLLIDuMZZICnw0FmEopFVmFh0KlNBjptM6jDJ1u+m0B5Px/lKpFJD31AJdDpUPNH39xBfEfaD4rGPz38oRR3HaqkTHT3xTuoTVL3aU3cNT2yPgTbNs5UlF5/8KM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtmTyZC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D753C19423;
	Tue, 10 Mar 2026 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141249;
	bh=64S2yWuK24xY6fH+j5RONgS8TV1Jk+Jm4CVdAbLPUeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtmTyZC74KQhZd24IU0P6ylfkWX4zC3PPJgImtGXENRaNCOratUGXvvCSf5FAVUX3
	 /XkXeQYFwY5JZ8gDPiRUVgOGb99MmxdfP8CRukHrizlwSIxf5EtBwGrk1xB1CUZt6B
	 wG2mD9Ya1wUzyBma40priqGknFu2NhHOjxzqNjTnLgP3A6phkPpezrtGxcCg4cPXZu
	 gRFmxtrgl3SFsWf/MgsGprOtMLGtOnmD2PqbvRGYjx2vSC8E+Tm+a0F9vNRu/4dNog
	 3mr/aAW0Qa0ntBYhMtgySvKaPw9qrFyJjsWDffGQxEfoWyKFTSs/P0SFpKpYywAjDS
	 9q1aaPBLdFcaQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Vivek Behera <vivek.behera@siemens.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Saritha Sanigani <sarithax.sanigani@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 251/311] igb: Fix trigger of incorrect irq in igb_xsk_wakeup
Date: Tue, 10 Mar 2026 07:04:58 -0400
Message-ID: <4b4aff87742c4e2c35b918693436e9dc78bb5960.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BCF4B24AB70
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224116-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Vivek Behera <vivek.behera@siemens.com>

[ Upstream commit d4c13ab36273a8c318ba06799793cc1f5d9c6fa1 ]

The current implementation in the igb_xsk_wakeup expects
the Rx and Tx queues to share the same irq. This would lead
to triggering of incorrect irq in split irq configuration.
This patch addresses this issue which could impact environments
with 2 active cpu cores
or when the number of queues is reduced to 2 or less

cat /proc/interrupts | grep eno2
 167:          0          0          0          0 IR-PCI-MSIX-0000:08:00.0
 0-edge      eno2
 168:          0          0          0          0 IR-PCI-MSIX-0000:08:00.0
 1-edge      eno2-rx-0
 169:          0          0          0          0 IR-PCI-MSIX-0000:08:00.0
 2-edge      eno2-rx-1
 170:          0          0          0          0 IR-PCI-MSIX-0000:08:00.0
 3-edge      eno2-tx-0
 171:          0          0          0          0 IR-PCI-MSIX-0000:08:00.0
 4-edge      eno2-tx-1

Furthermore it uses the flags input argument to trigger either rx, tx or
both rx and tx irqs as specified in the ndo_xsk_wakeup api documentation

Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
Signed-off-by: Vivek Behera <vivek.behera@siemens.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Saritha Sanigani <sarithax.sanigani@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_xsk.c | 38 +++++++++++++++++++-----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 30ce5fbb5b776..ce4a7b58cad2f 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -524,6 +524,16 @@ bool igb_xmit_zc(struct igb_ring *tx_ring, struct xsk_buff_pool *xsk_pool)
 	return nb_pkts < budget;
 }
 
+static u32 igb_sw_irq_prep(struct igb_q_vector *q_vector)
+{
+	u32 eics = 0;
+
+	if (!napi_if_scheduled_mark_missed(&q_vector->napi))
+		eics = q_vector->eims_value;
+
+	return eics;
+}
+
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 {
 	struct igb_adapter *adapter = netdev_priv(dev);
@@ -542,20 +552,32 @@ int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 
 	ring = adapter->tx_ring[qid];
 
-	if (test_bit(IGB_RING_FLAG_TX_DISABLED, &ring->flags))
-		return -ENETDOWN;
-
 	if (!READ_ONCE(ring->xsk_pool))
 		return -EINVAL;
 
-	if (!napi_if_scheduled_mark_missed(&ring->q_vector->napi)) {
+	if (flags & XDP_WAKEUP_TX) {
+		if (test_bit(IGB_RING_FLAG_TX_DISABLED, &ring->flags))
+			return -ENETDOWN;
+
+		eics |= igb_sw_irq_prep(ring->q_vector);
+	}
+
+	if (flags & XDP_WAKEUP_RX) {
+		/* If IGB_FLAG_QUEUE_PAIRS is active, the q_vector
+		 * and NAPI is shared between RX and TX.
+		 * If NAPI is already running it would be marked as missed
+		 * from the TX path, making this RX call a NOP
+		 */
+		ring = adapter->rx_ring[qid];
+		eics |= igb_sw_irq_prep(ring->q_vector);
+	}
+
+	if (eics) {
 		/* Cause software interrupt */
-		if (adapter->flags & IGB_FLAG_HAS_MSIX) {
-			eics |= ring->q_vector->eims_value;
+		if (adapter->flags & IGB_FLAG_HAS_MSIX)
 			wr32(E1000_EICS, eics);
-		} else {
+		else
 			wr32(E1000_ICS, E1000_ICS_RXDMT0);
-		}
 	}
 
 	return 0;
-- 
2.51.0



Return-Path: <stable+bounces-207427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F13D6D09D3F
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9A4B3067332
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068AD358D38;
	Fri,  9 Jan 2026 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JGa67xn+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2554336EDA;
	Fri,  9 Jan 2026 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962023; cv=none; b=VpHlS82Nu9r4IKtv7tMN6qo7x06Csf1sM0iu0owRg95HPrfDPjx7xR2EJyZHF6KKaaUqBwQyDA2NgGLNOQ+Y9X/PcFPsJflyXBfuvEC72ER96HH/9+pXDWwr7MUP6kdgb078ZQEffeQU2dCbhxi1uRMDIobPZsi4jbqzbl4pWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962023; c=relaxed/simple;
	bh=FAQZqr84nOSkdsWT5idmhIWQbrVvcQvgBYbpSvyPVqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iX7DM1lhZ2JgC4ZJDEpmy+PikkbnKFBWHklfX+bEzG9AP11ekBSsZxPuELJYpaJgcTV+oB7fpPyZWnMi+EYEZA5d+1lyof/mx+ruMfQIR3Ig54HKBtCDBGZJVg0RXPyuO83ASnYaCnDvvAWrY2CEfOZ0elnwJgq8qzqEyJmYJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JGa67xn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE93C4CEF1;
	Fri,  9 Jan 2026 12:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767962023;
	bh=FAQZqr84nOSkdsWT5idmhIWQbrVvcQvgBYbpSvyPVqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGa67xn+PIrGGtHZHaenXzp2fCcJLr532qsvvyBN2T8v1AJoaNlKWTX4KoPA/LH0p
	 60TVVHe5NuKHuATTorVr8PpATpaRcH9CuYEnFGit096JfXIPnIdp0Ekpg/CsuNo7fh
	 brpbuB09Vpi6lAQx9yf25iE+kvt6ipNSLmmZpf+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Zhang, Liyin(CN)" <Liyin.Zhang.CN@windriver.com>,
	Thangaraj Samynathan <thangaraj.s@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 220/634] net: lan743x: Allocate rings outside ZONE_DMA
Date: Fri,  9 Jan 2026 12:38:18 +0100
Message-ID: <20260109112125.711900987@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thangaraj Samynathan <thangaraj.s@microchip.com>

commit 8a8f3f4991761a70834fe6719d09e9fd338a766e upstream.

The driver allocates ring elements using GFP_DMA flags. There is
no dependency from LAN743x hardware on memory allocation should be
in DMA_ZONE. Hence modifying the flags to use only GFP_ATOMIC. This
is consistent with other callers of lan743x_rx_init_ring_element().

Reported-by: Zhang, Liyin(CN) <Liyin.Zhang.CN@windriver.com>
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250415044509.6695-1-thangaraj.s@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2627,8 +2627,7 @@ static int lan743x_rx_process_buffer(str
 
 	/* save existing skb, allocate new skb and map to dma */
 	skb = buffer_info->skb;
-	if (lan743x_rx_init_ring_element(rx, rx->last_head,
-					 GFP_ATOMIC | GFP_DMA)) {
+	if (lan743x_rx_init_ring_element(rx, rx->last_head, GFP_ATOMIC)) {
 		/* failed to allocate next skb.
 		 * Memory is very low.
 		 * Drop this packet and reuse buffer.




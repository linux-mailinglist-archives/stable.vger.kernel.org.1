Return-Path: <stable+bounces-45711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E648CD37C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4231F21F87
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC91E504;
	Thu, 23 May 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Exc4M77P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C261D52D;
	Thu, 23 May 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470143; cv=none; b=ij5DnLZ9AEmTjiM46Y//reCt9bBRYDdlLRtuzHeN2O23bScKOr4TJKCTlZs8OmAfSHuSEfw4dvlCKoDHKHlHhHuobKTyv1PZmcLKtrbYtbC8kwOreVJdEpJBRbzo2lwGp8m6es00S5SnIg5uI/tm0zuiC1p/y2uKA6e3N0RXIGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470143; c=relaxed/simple;
	bh=L4e9tyCkpYXLTfBdsD0nBEUA77SWTvM8LVp9x1siVoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdwtOS9+5XUm2K4CVaEU49U3LafHnrfDh1CHOsWp9bQ8OUuJo/ziIi1qtnReI8OonLRPTak/3wZHJDxHKFLmaIFJUi/LPgRlq+L9ivBpKrngukBF1CtHRDozCsFxP+LKFIyZ3/o8/wRkXjiH4MDZuDtUwbdxfEQWaCCYh7ybaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Exc4M77P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A0CC2BD10;
	Thu, 23 May 2024 13:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470142;
	bh=L4e9tyCkpYXLTfBdsD0nBEUA77SWTvM8LVp9x1siVoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Exc4M77PQ+GiHlsbteWo6vQH6z6eYLCW1UcnmeqeOli7AmmWtsIRrkigrCDIBfAHU
	 YDFuPazjG6TRC+Zhstvq33ocaorMXJx54alGz+Q0p1VHVCBwtral3PS3Y0Zabk6js5
	 I19ZUriJL/WlyaJyEHb7vcNnqtumm5IhvWN7otYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 07/16] net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
Date: Thu, 23 May 2024 15:12:40 +0200
Message-ID: <20240523130326.024826874@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130325.743454852@linuxfoundation.org>
References: <20240523130325.743454852@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Berger <opendmb@gmail.com>

commit 2dbe5f19368caae63b1f59f5bc2af78c7d522b3a upstream.

The ndo_set_rx_mode function is synchronized with the
netif_addr_lock spinlock and BHs disabled. Since this
function is also invoked directly from the driver the
same synchronization should be applied.

Fixes: 72f96347628e ("net: bcmgenet: set Rx mode before starting netif")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2882,7 +2882,9 @@ static void bcmgenet_netif_start(struct
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
 	/* Start the network engine */
+	netif_addr_lock_bh(dev);
 	bcmgenet_set_rx_mode(dev);
+	netif_addr_unlock_bh(dev);
 	bcmgenet_enable_rx_napi(priv);
 
 	umac_enable_set(priv, CMD_TX_EN | CMD_RX_EN, true);




Return-Path: <stable+bounces-109194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF28EA12FA8
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373A67A04D0
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDEE8F6E;
	Thu, 16 Jan 2025 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOXRxL1W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A079EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987155; cv=none; b=ZmFIZqV3H8D5EaMa3HDCFoKND8gtc7ZA7UcNslFyySd1dLTDSwpuN2b4LK2CZjOepkTB2mOHl9JRr3/NVXnhU7/lqSIQmM/zDzR9jvlTwRVRDsnoy7v1maoQ/qf6jz4nY+bT3BwjZYfu5RXzIzlodLgAfGR7MpI6P8PWwqeRf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987155; c=relaxed/simple;
	bh=HEiqext8iNe3heJ3AIbAdK6RyUVOqxzoMfwnE9lRLcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lq8v3/N8vL1KNSo6SQ+Hc3x3KWy/I2q9ogRo7CzJIybXxI3nnlNIXtNn5heMJF3DI54ZTLpSIRvATuGZ1R4iupKCOLTOT2FEGZNugVAmXCs3JNMQ3ub+MSVQGwBWw3PAybDP34FVI9e6T/LSQUwuACKTzVIVrY7UrgYujZUN6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOXRxL1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9542BC4CED1;
	Thu, 16 Jan 2025 00:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987155;
	bh=HEiqext8iNe3heJ3AIbAdK6RyUVOqxzoMfwnE9lRLcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOXRxL1WUtfOE1W08N8uRHukLB+tGa9g1dcvPV829/cwrpMy8t7rCVkwMQ+O496S+
	 13GSaWrVJUGIBU95vKaTUJl+9jj7zIuO4lVDyKTdIE6uL9ko3xHrZt/HVlj10SMbuy
	 I0udvUwlfl1nBixSCFEPWAcT01IAfUfjIZfB0Xnih3hYgD4CnNYMV+J9X2WeVkR/kh
	 6xIIGKVoY87D2UqUG/wsYaId1FKADfJMh0YCOVg1TrgUUummIXHa4I9dI2XlzSNObg
	 oTaA58X9m086fYLvxOuzjrVI383GttDoBRFiUV1PpjcuF4rwOx8X09a6Jj6z6dAh5y
	 tUg+V5xik8zrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10/5.15] can: hi311x: hi3110_can_ist(): fix potential use-after-free
Date: Wed, 15 Jan 2025 19:25:50 -0500
Message-Id: <20250115153633-e699a15416d3092c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250115090118.334324-1-kovalev@altlinux.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 9ad86d377ef4a19c75a9c639964879a5b25a433b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev<kovalev@altlinux.org>
Commit author: Dario Binacchi<dario.binacchi@amarulasolutions.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: bc30b2fe8c54)
6.6.y | Present (different SHA1: 112802200944)
6.1.y | Present (different SHA1: 4ad77eb8f2e0)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  9ad86d377ef4 ! 1:  6ca160114ff4 can: hi311x: hi3110_can_ist(): fix potential use-after-free
    @@ Metadata
      ## Commit message ##
         can: hi311x: hi3110_can_ist(): fix potential use-after-free
     
    +    [ Upstream commit 9ad86d377ef4a19c75a9c639964879a5b25a433b ]
    +
         The commit a22bd630cfff ("can: hi311x: do not report txerr and rxerr
         during bus-off") removed the reporting of rxerr and txerr even in case
         of correct operation (i. e. not bus-off).
    @@ Commit message
         Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
         Link: https://patch.msgid.link/20241122221650.633981-5-dario.binacchi@amarulasolutions.com
         Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
    +    [kovalev: changed the call order of netif_rx_ni()
    +    according to netif_rx() of the upstream patch]
    +    Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
     
      ## drivers/net/can/spi/hi311x.c ##
     @@ drivers/net/can/spi/hi311x.c: static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
      			tx_state = txerr >= rxerr ? new_state : 0;
      			rx_state = txerr <= rxerr ? new_state : 0;
      			can_change_state(net, cf, tx_state, rx_state);
    --			netif_rx(skb);
    +-			netif_rx_ni(skb);
      
      			if (new_state == CAN_STATE_BUS_OFF) {
    -+				netif_rx(skb);
    ++				netif_rx_ni(skb);
      				can_bus_off(net);
      				if (priv->can.restart_ms == 0) {
      					priv->force_quit = 1;
     @@ drivers/net/can/spi/hi311x.c: static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
    - 				cf->can_id |= CAN_ERR_CNT;
    + 			} else {
      				cf->data[6] = txerr;
      				cf->data[7] = rxerr;
    -+				netif_rx(skb);
    ++				netif_rx_ni(skb);
      			}
      		}
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |


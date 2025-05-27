Return-Path: <stable+bounces-147066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C6AC561D
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B053A3301
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3679627D766;
	Tue, 27 May 2025 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rrmUzdCz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7C1E89C;
	Tue, 27 May 2025 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366178; cv=none; b=S5TG5lC+/TK5nLXL91/dOy/2tNi0a20wsHOq+fHHx+mIclT5OmNynJdIcSRPebDYTjW2iB/gFplbR+18TGq0dSClDFqN9+4kLAyqzVRNLekt2VkjNhvlhhWxWqSqgCHWEMfyyna5CLiSH2vzpvNEKX9ocg31UxUaNwXS4Le12t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366178; c=relaxed/simple;
	bh=My1oLgqx8Q3D96Uu2OkhLpceyk5Keg0kWYq8w5CBM+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMBprqSqw+S2RPrRpTTv5Qdy0XeHsuDh84m2DuF5LPFX9Cjz3BWXAJqnGHWl2y2M0Tq8+FSJzGnZ6MpgrUcff1B0+lyigb87Ce4mN7mb6HjzpiRGBI2t7YltlmJoojOKEq7ADBJfmn5DbVWtNCrK17m1c6IjzgYm7+3Gy80TbxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rrmUzdCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1DDC4CEE9;
	Tue, 27 May 2025 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366177;
	bh=My1oLgqx8Q3D96Uu2OkhLpceyk5Keg0kWYq8w5CBM+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrmUzdCzwxJt98pkqjf60PZOdVbG+PcGjYoPAmCxue/FLIlykOkaC1Z/Tw7ruaVmR
	 huKTxHle0NmGkLlLxVuHMa27fHu9HXyD13GfO7d1K5bamXxbtgh7tJG35MrUzjaLid
	 n5tHkPyKPQFzOf7DoyvR6ugFedv6Kz61HH8t0GMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Axel Forsman <axfo@kvaser.com>,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12 582/626] can: kvaser_pciefd: Continue parsing DMA buf after dropped RX
Date: Tue, 27 May 2025 18:27:55 +0200
Message-ID: <20250527162508.624803936@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Axel Forsman <axfo@kvaser.com>

commit 6d820b81c4dc4a4023e45c3cd6707a07dd838649 upstream.

Going bus-off on a channel doing RX could result in dropped packets.

As netif_running() gets cleared before the channel abort procedure,
the handling of any last RDATA packets would see netif_rx() return
non-zero to signal a dropped packet. kvaser_pciefd_read_buffer() dealt
with this "error" by breaking out of processing the remaining DMA RX
buffer.

Only return an error from kvaser_pciefd_read_buffer() due to packet
corruption, otherwise handle it internally.

Cc: stable@vger.kernel.org
Signed-off-by: Axel Forsman <axfo@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250520114332.8961-4-axfo@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/kvaser_pciefd.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1200,7 +1200,7 @@ static int kvaser_pciefd_handle_data_pac
 		skb = alloc_canfd_skb(priv->dev, &cf);
 		if (!skb) {
 			priv->dev->stats.rx_dropped++;
-			return -ENOMEM;
+			return 0;
 		}
 
 		cf->len = can_fd_dlc2len(dlc);
@@ -1212,7 +1212,7 @@ static int kvaser_pciefd_handle_data_pac
 		skb = alloc_can_skb(priv->dev, (struct can_frame **)&cf);
 		if (!skb) {
 			priv->dev->stats.rx_dropped++;
-			return -ENOMEM;
+			return 0;
 		}
 		can_frame_set_cc_len((struct can_frame *)cf, dlc, priv->ctrlmode);
 	}
@@ -1230,7 +1230,9 @@ static int kvaser_pciefd_handle_data_pac
 	priv->dev->stats.rx_packets++;
 	kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
 
-	return netif_rx(skb);
+	netif_rx(skb);
+
+	return 0;
 }
 
 static void kvaser_pciefd_change_state(struct kvaser_pciefd_can *can,




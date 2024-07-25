Return-Path: <stable+bounces-61710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB393C598
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B577280F8B
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE29219AD93;
	Thu, 25 Jul 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yhgPXwdY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B179FC19;
	Thu, 25 Jul 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919193; cv=none; b=rYXnDJYT9si4ZHeDFuHLEyVNp3bVl4DMxwnxigp4CYXXFZlHgjVAGUeNweBLkLeT1/I0QhHh84qw3pJvmZyDRStc2KMs68uJe7MbUn2/RFPX4Y3p/+HkfJtA4PiQdfN9BIJP555Ai5AWGllocIqElcVKbgL6cuz/WQrgCbemh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919193; c=relaxed/simple;
	bh=kcSy3AisUCaK/35C3QIjg8E2iIfszmH8VbCjmCi26KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlgzJF1x85j9JzBK3IIl4uuRna/sR6ree4uWGuqw6NyuZixufcNaiNTEGdl+cX/TgLWm80r+ch/ah5lDxUhMH4P/F9YeGjEs+A81Vbj1NNUVdR2Hq2tepZkpbXfx3iraBZW7dyCQu6IhuHdbFQfK6/7x98bBN0qkjxIcwHywfkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yhgPXwdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12A2C116B1;
	Thu, 25 Jul 2024 14:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721919193;
	bh=kcSy3AisUCaK/35C3QIjg8E2iIfszmH8VbCjmCi26KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yhgPXwdYxRQclrmLh2TNDjQKIQgZxLSG7A2M1xCIGvu0jr2pO7ghd69J0uzKy8NIu
	 8rVSiUk3hzX6Tcz/NwAt3NmY2laCR6BKq66quwFU6FzyaIsIma55hERNzekegdAxjG
	 OvdERGw/0X7zrAdvUMpsDKtt+FuS2Reauifc2300=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yunshui Jiang <jiangyunshui@kylinos.cn>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 52/87] net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()
Date: Thu, 25 Jul 2024 16:37:25 +0200
Message-ID: <20240725142740.396845104@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142738.422724252@linuxfoundation.org>
References: <20240725142738.422724252@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunshui Jiang <jiangyunshui@kylinos.cn>

[ Upstream commit b8ec0dc3845f6c9089573cb5c2c4b05f7fc10728 ]

mac802154 devices update their dev->stats fields locklessly. Therefore
these counters should be updated atomically. Adopt SMP safe DEV_STATS_INC()
and DEV_STATS_ADD() to achieve this.

Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
Message-ID: <20240531080739.2608969-1-jiangyunshui@kylinos.cn>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac802154/tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index c829e4a753256..7cea95d0b78f9 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -34,8 +34,8 @@ void ieee802154_xmit_worker(struct work_struct *work)
 	if (res)
 		goto err_tx;
 
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
+	DEV_STATS_INC(dev, tx_packets);
+	DEV_STATS_ADD(dev, tx_bytes, skb->len);
 
 	ieee802154_xmit_complete(&local->hw, skb, false);
 
@@ -86,8 +86,8 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 			goto err_tx;
 		}
 
-		dev->stats.tx_packets++;
-		dev->stats.tx_bytes += len;
+		DEV_STATS_INC(dev, tx_packets);
+		DEV_STATS_ADD(dev, tx_bytes, len);
 	} else {
 		local->tx_skb = skb;
 		queue_work(local->workqueue, &local->tx_work);
-- 
2.43.0





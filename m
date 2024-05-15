Return-Path: <stable+bounces-45215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59CB8C6C04
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 20:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E29F284DB3
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 18:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E3158DDF;
	Wed, 15 May 2024 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKUqQOrb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB5E158DB5;
	Wed, 15 May 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796913; cv=none; b=q4EfGdw6+G3eOlPg3AduzmUIMfW4OYIzzCPerPPrueLKknmyVd+CKjAUUsvb1a/sA0un3diV4SjX6tQnuJiG71XaoBfbKm6KrXwBjQiqdZUK882SMMXRfgAZIvt5zsWoF9mcJvT+6Nq8Ok8ivj8E/6nB3ICpIIlM+nZQkSTCxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796913; c=relaxed/simple;
	bh=E4Iwtxu2+/Psbmp/h4kJfXYz2OBjkeQjEI+8/JjX5EQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CZO2liQI1eIMxRsKJBK1CTHO+4/jFZsrUB5Q7d9tKTMjDRRaIdc8ome7Zi6d3lJxVaRSgQ+F8aensaruHP9EtmOhqZ2gMBGaOSWHoKWZ1n/APw1BdSl0KyI0OzWPVELLya5R1u3/qyVFlTDpbOTcqK0KuDOs00yXPgp8aBA8pow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKUqQOrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB7CBC32789;
	Wed, 15 May 2024 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715796912;
	bh=E4Iwtxu2+/Psbmp/h4kJfXYz2OBjkeQjEI+8/JjX5EQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sKUqQOrbz6+9qshSPT2m6n9CPcGSpJYbgbS4SDi0MrIy6RHgArm68GqmaXKrkeaGD
	 aNSQYFNyduY4YcVwM1FF0YkWvEz6g7AfDON19cVhn7hs00pj+1tWY7wgDvi9d+k3NE
	 JceTtG8UNk7+qUzK3mjYuFgXLzeFGqpl986LbLTbkkegvC84FnGAt016nXBtv2g3Ev
	 uBPD0DoZjMhvCPuB0Cyhr6OxnZ0DPs1wFPC/ceSqwVRShdHWJNGdg1Akbw8Pp7ZLsr
	 t+EoubXP+pHp+AaCB1EO5Co0MldOti9/8bvfd12H+erKgJSVdPTF6HFfLDX5GPNiZr
	 0CjDztkf1oJVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A291DC25B79;
	Wed, 15 May 2024 18:15:12 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Wed, 15 May 2024 18:15:04 +0000
Subject: [PATCH v2 3/3] Bluetooth: hci_bcm4377: Fix msgid release
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-btfix-msgid-v2-3-bb06b9ecb6d1@svenpeter.dev>
References: <20240515-btfix-msgid-v2-0-bb06b9ecb6d1@svenpeter.dev>
In-Reply-To: <20240515-btfix-msgid-v2-0-bb06b9ecb6d1@svenpeter.dev>
To: Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@svenpeter.dev>, stable@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715796911; l=1005;
 i=sven@svenpeter.dev; s=20240512; h=from:subject:message-id;
 bh=S7xKEZCg+8p3UVaw49Z8FtTJmOjvz1UbYciOj2+ura0=;
 b=Ozstng7yF96uysi12zXuTli9Av64oDUsLQGnA5QC7XKF+rkN/vFAN8YmgOFkBAkzcgLMw+oG8
 v1/n4dTc7moC9rw82K6I7tGXE6vhBtG/SHGdxQJmXK/iIGr0pvp3Djb
X-Developer-Key: i=sven@svenpeter.dev; a=ed25519;
 pk=jIiCK29HFM4fFOT2YTiA6N+4N7W+xZYQDGiO0E37bNU=
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/20240512 with
 auth_id=159
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Hector Martin <marcan@marcan.st>

We are releasing a single msgid, so the order argument to
bitmap_release_region must be zero.

Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
Cc: stable@vger.kernel.org
Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/bluetooth/hci_bcm4377.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 5b818a0e33d6..92d734f02e00 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -717,7 +717,7 @@ static void bcm4377_handle_ack(struct bcm4377_data *bcm4377,
 		ring->events[msgid] = NULL;
 	}
 
-	bitmap_release_region(ring->msgids, msgid, ring->n_entries);
+	bitmap_release_region(ring->msgids, msgid, 0);
 
 unlock:
 	spin_unlock_irqrestore(&ring->lock, flags);

-- 
2.34.1




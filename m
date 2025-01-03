Return-Path: <stable+bounces-106692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A22A009FA
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 14:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5713F163E21
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BD91F9428;
	Fri,  3 Jan 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fz7rDcDC"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B813AD0;
	Fri,  3 Jan 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735911670; cv=none; b=D6O+Itu62wR/wpRm7Y2J+FXhpK+31wqj47D2j0WncmlBKX8PZRDNYT1++dY5zeFnP8Px3oSR9H46dNNZgQPmsPqL9wVU4S45RjcjaVFTUV/UTDSiLFn2/pr9GhMcO0keLxF3PnyvC8osStFazpCyUhs0qy/WjOnF1Pokaspgz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735911670; c=relaxed/simple;
	bh=2LoD89fr0gA0mToAdYXNti+rZqJbFVeRGGzGfWKuLW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s99pHM2KjvbFqMDWdAgUm6pT1sLHfqW71JEvlBRMrfvr1aUz/GSP08W72KtkfbVk3dgfqj4Z9fMLiJ8dByap9JaVKqlDs4haHLbmqvMPWcVuGkAHlrE0ENi7j+Z+3Vuxvt/qNYSEP/HJdYqNXbs2xGcTjLvu6gjHWZ/IExgcpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fz7rDcDC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735911655;
	bh=2LoD89fr0gA0mToAdYXNti+rZqJbFVeRGGzGfWKuLW8=;
	h=From:Date:Subject:To:Cc:From;
	b=fz7rDcDCq6lsjCCc0Uy4EYINp8j+vfO0ZOujqppZ3Bo6eYQm77elD7VEDtOROkmRC
	 pMcp6p5+XI/ZxRH3zwHMNzeq/bweAfHnts1/TJ2cnq71Qtls1rbZXn0MgOyDmzNck9
	 sMSI8uLKfu4UDqj1Zb76YakDAGzE7Gof5B3yGM+Y=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 03 Jan 2025 14:40:49 +0100
Subject: [PATCH net] ptp: limit number of virtual clocks per physical clock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250103-ptp-max_vclocks-v1-1-2406b8eade97@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAODod2cC/x3MTQqAIBBA4avIrBOmpBZdJSL8mWqoTFQiiO6et
 PwW7z2QKDIl6MUDkS5OfPqCuhJgV+0XkuyKocGmxRqVDDnIQ9/TZffTbkmi06Y1qAxiB6UKkWa
 +/+MAnjKM7/sBqssLWWYAAAA=
X-Change-ID: 20250103-ptp-max_vclocks-0dab5b03b006
To: Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yangbo Lu <yangbo.lu@nxp.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cheung wall <zzqq0103.hey@gmail.com>, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735911655; l=1977;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2LoD89fr0gA0mToAdYXNti+rZqJbFVeRGGzGfWKuLW8=;
 b=w82DqGyX9o/stC4bGVg2KUYn5zlZeQZvDY1lfm/JUFQnLu/r+9NcwaF1fAB1fe/Zo+w2UIZMt
 ebrO0q5mVsCDbVW6TzL7I2m6tQRraepBXxwFTHUEE9ulAKwSgL6d1Qd
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs interface can be used to trigger arbitrarily large memory
allocations. This can induce pressure on the VM layer to satisfy the
request only to fail anyways.

Reported-by: cheung wall <zzqq0103.hey@gmail.com>
Closes: https://lore.kernel.org/lkml/20250103091906.GD1977892@ZenIV/
Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
The limit is completely made up, let me know if there is something
better.

I'm also wondering about the point of the max_vclocks sysfs attribute.
It could easily be removed and all its logic moved into the n_vclocks
attribute, simplifying the UAPI.
---
 drivers/ptp/ptp_private.h | 1 +
 drivers/ptp/ptp_sysfs.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 18934e28469ee6e3bf9c9e6d1a1adb82808d88e6..07003339795e9c0fb813887e47eaee4ba0e20064 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -22,6 +22,7 @@
 #define PTP_MAX_TIMESTAMPS 128
 #define PTP_BUF_TIMESTAMPS 30
 #define PTP_DEFAULT_MAX_VCLOCKS 20
+#define PTP_MAX_VCLOCKS_LIMIT 2048
 #define PTP_MAX_CHANNELS 2048
 
 struct timestamp_event_queue {
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 6b1b8f57cd9510f269c86dd89a7a74f277f6916b..200eaf50069681eecc87d63c0e0440f28cccab77 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -284,7 +284,7 @@ static ssize_t max_vclocks_store(struct device *dev,
 	size_t size;
 	u32 max;
 
-	if (kstrtou32(buf, 0, &max) || max == 0)
+	if (kstrtou32(buf, 0, &max) || max == 0 || max > PTP_MAX_VCLOCKS_LIMIT)
 		return -EINVAL;
 
 	if (max == ptp->max_vclocks)

---
base-commit: 582ef8a0c406e0b17030b0773392595ec331a0d2
change-id: 20250103-ptp-max_vclocks-0dab5b03b006

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>



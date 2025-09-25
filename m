Return-Path: <stable+bounces-181747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A01BA18BE
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 23:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E2B2A1454
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C93321F35;
	Thu, 25 Sep 2025 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IfCdi0xJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y/sdl6mO"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0322E62A6;
	Thu, 25 Sep 2025 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835973; cv=none; b=Q1M3Hd29q1yKTWU90GBVArGCKYC3BPBbN1cJs/RRcdAPx5NZy7v4iVx13iNF+YT4Oxm5RsIREBqIeUhGMzQkGTp9L9T/iT8lsEl0t6Ul7OhGcAr/xSb/HxvxJlJu2A5pYtazXnHKbXXDlbYwr6YoJXHXouD8SxE0xuHAzRTdj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835973; c=relaxed/simple;
	bh=xBSf93f6TMzU/O2T9L9MSgxWr1yOmbvjltfbvUWmJW4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Xt7meLrdUazGlqSrDwBCvtlnvETXdp7Wy+CziGc3783gFuQ8Lba5nJxUYAzj/GS7GeI0y792iKPElNu7vTkh4Ge6BJr0i1fW+vPpLN6auwx2LcDD7xC+MJbDNv1KouFJPOYReWixuBfqQJX4TiWPmQv8syO8hLmQTXQhCnNfoSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IfCdi0xJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y/sdl6mO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:32:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DcvbQrEl/eB4wtbm9nHwP8xVQbSO/Neuc4/TKb8skTU=;
	b=IfCdi0xJcD9juz8Wb0aW6YwUhSk4z3I5ZOhiBWoRTX9NiaidMWlN6xnU0F21/TkH6gLI2H
	Hk553b5NulZdLoPeVzebjROd6TgSwDxs09i0v1cUuguqI8BqLVRYIQ7RyCrg6KF+ir6gef
	UINLsim7dq8U2O92gnlQd93I0ido0LCxDYS7xB9kXYKijxK1hBnzGd+zjgTsTfkLkIEHZ8
	qIlIj8zQ4NSMq55D+oaYncbtbauplgqJ7FTFxSSRV4sr3u6Go5FwnlvAYuoqLhEdgLv3gg
	BY/bMYwzj3jDYIVEN7IZ/CdXG4sqFzpsW8Ii0m+aCBM14FQ9JUqsPJu/JMg7Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835970;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DcvbQrEl/eB4wtbm9nHwP8xVQbSO/Neuc4/TKb8skTU=;
	b=y/sdl6mORvDL//ejvuY2ZD2uzoceXQDkcJSjaPsMtZB9cKbxqtFb5YGJh+kjXUvPnAzwlP
	AAJwtTpoRz/yFqCQ==
From: "tip-bot2 for Zhen Ni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/clps711x: Fix resource
 leaks in error paths
Cc: Zhen Ni <zhen.ni@easystack.cn>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883596914.709179.1345970973507632298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     cd32e596f02fc981674573402c1138f616df1728
Gitweb:        https://git.kernel.org/tip/cd32e596f02fc981674573402c1138f616d=
f1728
Author:        Zhen Ni <zhen.ni@easystack.cn>
AuthorDate:    Thu, 14 Aug 2025 20:33:24 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:42:27 +02:00

clocksource/drivers/clps711x: Fix resource leaks in error paths

The current implementation of clps711x_timer_init() has multiple error
paths that directly return without releasing the base I/O memory mapped
via of_iomap(). Fix of_iomap leaks in error paths.

Fixes: 04410efbb6bc ("clocksource/drivers/clps711x: Convert init function to =
return error")
Fixes: 2a6a8e2d9004 ("clocksource/drivers/clps711x: Remove board support")
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250814123324.1516495-1-zhen.ni@easystack.cn
---
 drivers/clocksource/clps711x-timer.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps7=
11x-timer.c
index e95fdc4..bbceb02 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -78,24 +78,33 @@ static int __init clps711x_timer_init(struct device_node =
*np)
 	unsigned int irq =3D irq_of_parse_and_map(np, 0);
 	struct clk *clock =3D of_clk_get(np, 0);
 	void __iomem *base =3D of_iomap(np, 0);
+	int ret =3D 0;
=20
 	if (!base)
 		return -ENOMEM;
-	if (!irq)
-		return -EINVAL;
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
+	if (!irq) {
+		ret =3D -EINVAL;
+		goto unmap_io;
+	}
+	if (IS_ERR(clock)) {
+		ret =3D PTR_ERR(clock);
+		goto unmap_io;
+	}
=20
 	switch (of_alias_get_id(np, "timer")) {
 	case CLPS711X_CLKSRC_CLOCKSOURCE:
 		clps711x_clksrc_init(clock, base);
 		break;
 	case CLPS711X_CLKSRC_CLOCKEVENT:
-		return _clps711x_clkevt_init(clock, base, irq);
+		ret =3D  _clps711x_clkevt_init(clock, base, irq);
+		break;
 	default:
-		return -EINVAL;
+		ret =3D -EINVAL;
+		break;
 	}
=20
-	return 0;
+unmap_io:
+	iounmap(base);
+	return ret;
 }
 TIMER_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);


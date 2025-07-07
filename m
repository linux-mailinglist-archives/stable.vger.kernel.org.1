Return-Path: <stable+bounces-160381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DF2AFB8C1
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 18:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1C81AA1701
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA77223DE9;
	Mon,  7 Jul 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="XZxpJ37K"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425081E47A3;
	Mon,  7 Jul 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906317; cv=pass; b=MDvk2gcsAX+AEsEbKyFN88POJqdH0biZmRQFzMJspqHjcPcacsg5k6tebON2gsJVUxPaK2ZV9jJdj6xl0nOf/zN3a2T5yd6/eTmwp1rPWCdi+/OYwBTafnEeMRkEb6DMtzRDeFdleBn4QdtVHUq01T2hayGvfOCPXNN2NB412zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906317; c=relaxed/simple;
	bh=VW6qCL3HT0607+mfs7x9eeWmKIz8GBk9I/5r+z4hm1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9RI9xbU038nSeel9KxX2JTFGyB8rsujI7kCWmO/QMOu1WXYdyTRIH73i/QSzRTgGLmJPgCZ6w+Qi04K0PK7eXPvmK7NGJwcRwjj9q4dkhsIgRPR+hOi9TOv0QeKJZ07IiNy1X547gcTAS3Do7fJEsUnKUaFQgyqqChifRUutP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=XZxpJ37K; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1751906300; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HBFnSxYdLaJwDGMeCobJTVGFwYjuVysBYidBm3j8gMLPNKRoeXHd2Ac/kh1TmBwQMwUnFg6JLcEwPISpYhErJsJjEyzdtNN68Gk0HCjnHVbqj7MfWWYKNwwmLIYax12dik6Ly1mKaSLTkfi/v7GR/yBzcvuWqzWGIYXKNoGtIWw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751906300; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SO1xnxAOgUJL8OK/On5b8uvNV1rDGaM/iKs1dsCmxGc=; 
	b=BcdNvD8fgAAW00mBtwnIXc3VbT50CNRNmDfzA9ryCXKoAf5pSnqJ1CIQNF414YtcdfEUqAd7wMZwHftePHlnnTt/vOpVqr7ywm0r1wVytmXGIUx1Is4x92bPtvqJ2AlHQKPmjX8xWk56ThVwx/uZ03jPZbgkOQ3VOErcZd1/cGs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751906300;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SO1xnxAOgUJL8OK/On5b8uvNV1rDGaM/iKs1dsCmxGc=;
	b=XZxpJ37KsWO3GD8h1+Lp0ZxVRKR3e1BB2kiRUncOYEQlPSXbs6blR/ucOWqhH2jd
	bi6SgO0/0gFb7iojLpU3YpAuaqQdGHvLgQdnqJbQzyHXuDlLXTTplO0Zl9zrdtnfYZo
	7w8PkTaFOHnYkc3KhIF7fHDV6B3PVka0VhczxzD8=
Received: by mx.zohomail.com with SMTPS id 1751906298234764.0185668158953;
	Mon, 7 Jul 2025 09:38:18 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gergo Koteles <soyer@irl.hu>,
	=?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: ideapad-laptop: Fix FnLock not remembered among boots
Date: Tue,  8 Jul 2025 00:38:06 +0800
Message-ID: <20250707163808.155876-2-i@rong.moe>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707163808.155876-1-i@rong.moe>
References: <20250707163808.155876-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On devices supported by ideapad-laptop, the HW/FW can remember the
FnLock state among boots. However, since the introduction of the FnLock
LED class device, it is turned off while shutting down, as a side effect
of the LED class device unregistering sequence.

Many users always turn on FnLock because they use function keys much
more frequently than multimedia keys. The behavior change is
inconvenient for them. Thus, set LED_RETAIN_AT_SHUTDOWN on the LED class
device so that the FnLock state gets remembered, which also aligns with
the behavior of manufacturer utilities on Windows.

Fixes: 07f48f668fac ("platform/x86: ideapad-laptop: add FnLock LED class device")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/ideapad-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index b5e4da6a6779..62a72b09fc3a 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1728,7 +1728,7 @@ static int ideapad_fn_lock_led_init(struct ideapad_private *priv)
 	priv->fn_lock.led.name                    = "platform::" LED_FUNCTION_FNLOCK;
 	priv->fn_lock.led.brightness_get          = ideapad_fn_lock_led_cdev_get;
 	priv->fn_lock.led.brightness_set_blocking = ideapad_fn_lock_led_cdev_set;
-	priv->fn_lock.led.flags                   = LED_BRIGHT_HW_CHANGED;
+	priv->fn_lock.led.flags                   = LED_BRIGHT_HW_CHANGED | LED_RETAIN_AT_SHUTDOWN;
 
 	err = led_classdev_register(&priv->platform_device->dev, &priv->fn_lock.led);
 	if (err)
-- 
2.50.0



Return-Path: <stable+bounces-119473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C57A43C81
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F6117A412
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620E4267B82;
	Tue, 25 Feb 2025 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ObSs2RLa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E83267B0B
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481164; cv=none; b=Fy0Dc99yN+X8DI2Cr42jZ7hMowXyEvNaVHfixE5EEOJfnPoGdnBRPija3TJexmQvTLWf3NH5FM/HKShRGWN6DSTnaEuhXiVbMv24mWUrzVdTjJnrFp728KM/Q5YMza58A5jaCxkvMIq9gUCr15Lf4F4htkzCV0dUj4+D7oOyV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481164; c=relaxed/simple;
	bh=y651O+anxjWjbDnEXvCcVWHQZHRy4LozMZWKz+3pUNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT0F5mz4vHxR/e8f4NwpIkcSBVMxwNz6fXy+Vhp0kdz13jSLj4YnpOfs/CmBHD0xdEIYE3IaJBlsti7h/BHy3AIm7yyBe7Wl3QTzhTTVlbhPvyIQeXcFWzRAnydtRqnE+Vc4nnLUIcQVAhOmEqhRYz6IslGH9/VLMDGD6DeCzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ObSs2RLa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439950a45daso33582435e9.2
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 02:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740481160; x=1741085960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvELEwWWQBEiORRake36OoQXvOrT2uHpRxrgYMRnO6c=;
        b=ObSs2RLaSgSSHKZMiGnoxHB9p0S/lH1Y5LQW5wV7NtkXcrxrPOhIYIgsl7Fm1Zzr+V
         iYIhjJlqTrb8CcaUiOW0By0MLacCQYbtOtW+kX0D2w72Fk90o2k9XTPtlCP+ooPzIX+N
         ggK8ZrrXZ4oZI3Jnx77wy09ujasS1kIYT92NynJG6agjrYWIHyvLoUT6bd98nKgWCMZN
         CL0T4YHdjGk0MM/0GgtQ0ui8CbvgneaE7r1EdsoVpShy72sAhwtPE9+o0BOqpH0/SX1h
         DArO3nc4xJWkWaYRFmZXbkoTYgTXUcxkljA87kutaoBExceFKShwnj237R0ve+OmmkEE
         LGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481160; x=1741085960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvELEwWWQBEiORRake36OoQXvOrT2uHpRxrgYMRnO6c=;
        b=kN8lfEuWp+4a45f2ymoj9OtuP5CBAFgy3NurNIXniZkOhnWEae0wyVh3Nz1+xbIipR
         yFTAa+8mmYAv7+645xcsDDJ2vVhBNtb+fu0hSZA0wdqOBPXLgU7CZyDCytHy3N01C0Vi
         ZgbMMsnhRrbUo8HvvIp6JSQnGb93NNT2WeeecNgeoJfX42pAb+5N/blEFWYkA5Wsj0vy
         RVido9RPYeMSL5JC0kHHGpOghFeb7RMkTQqd95bk1QRwu0cXU8Us1CVlPuCw4lbGRnbJ
         5Cdy1YHJnVR5j5InbhIeZ5aB4tHqCEF5kRwTKF2lHsu+Tr+2ySd9kpiAOesF+C3rN51n
         usiA==
X-Forwarded-Encrypted: i=1; AJvYcCUProq/eKdg+yUPog6/h/wxQRlXXpBFyslXK7SMbgl7ViBo7sV5epCb43cR1exWTK00+XlAuYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwguGqma/ZSDdZsvaGzyDlsOJE4Bm7a/FsetO/q1j1gkWooY7EI
	W61zlRZqqGsU7pHFh35cWeGGPIHiq2l07B0wSLP7mqZRFc+PE7NnXAWzFVtrFqs=
X-Gm-Gg: ASbGnctB/9Tf9A2+YZ7ouNh3tGXYocAXVA7EUZBBFghKsAiNZWSOdvF1cPVp3VgZsXn
	WgLQD8qT8U5t27pDlrt6Hv+Oa3d2of9efSQY7VuX8AcTHEu87c3Q0f67r55JGDoxSGObcLl/t4q
	QHQ9eICr4iNWqMEN9+bkkbWFjgYhTFDWswpj5pwsZCsY3wjOjQqLBH3wF2TMerKOzuCSmOZEikp
	j/Nxxd07oTZsq41MT93KNkTu0O9ygWJNV1XaCpfNXoG3JWA7w3zE5TS/UV8RwKcNNtS+mfDwK+X
	LDa4O422Kq39zvapdiO1cIc/meUNaPvtDYCAAX+rxi9Vna7/2zvciCM=
X-Google-Smtp-Source: AGHT+IHtRIhZcnRthP8uOU/cg1Oi5cOCbCc+gYuPmxUUUX5BgUtaRXrGdvBE+71WlZEL5TaXm3qZ/w==
X-Received: by 2002:a05:600c:3111:b0:439:9f42:c137 with SMTP id 5b1f17b1804b1-43ab0f31010mr26280405e9.11.1740481160397;
        Tue, 25 Feb 2025 02:59:20 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c50dcfsm12588815e9.0.2025.02.25.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:59:19 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: yoshihiro.shimoda.uh@renesas.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	horms+renesas@verge.net.au,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/5] phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off
Date: Tue, 25 Feb 2025 12:59:06 +0200
Message-ID: <20250225105907.845347-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225105907.845347-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250225105907.845347-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Assert PLL reset on PHY power off. This saves power.

Fixes: f3b5a8d9b50d ("phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags
- add an empty line after definition of val to get rid of
  the checkpatch.pl warning

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 5c0ceba09b67..21cf14ea3437 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -537,9 +537,17 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 	struct rcar_gen3_chan *channel = rphy->ch;
 	int ret = 0;
 
-	scoped_guard(spinlock_irqsave, &channel->lock)
+	scoped_guard(spinlock_irqsave, &channel->lock) {
 		rphy->powered = false;
 
+		if (rcar_gen3_are_all_rphys_power_off(channel)) {
+			u32 val = readl(channel->base + USB2_USBCTR);
+
+			val |= USB2_USBCTR_PLL_RST;
+			writel(val, channel->base + USB2_USBCTR);
+		}
+	}
+
 	if (channel->vbus)
 		ret = regulator_disable(channel->vbus);
 
-- 
2.43.0



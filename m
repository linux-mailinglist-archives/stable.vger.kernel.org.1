Return-Path: <stable+bounces-119475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 755E5A43CDC
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE55442955
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E6C268FC2;
	Tue, 25 Feb 2025 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GOLogiGy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B51DF759
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481380; cv=none; b=OkZLMI7X66injxWd1She0XKs1rECSxsMYOmw3NL1SpCjlZU/f4utiWCZb2cyI16lzIS0ddKol3f3fudIZ66OTJ/RF2qIAHEIKUu2nfJzk3AN/2mPd6pvN9E/hUquvtQ3A5lU3EwanpfA5L5pKNi8oG9gpXNCwWRpGPuZuEKxOnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481380; c=relaxed/simple;
	bh=gQc+M1MxzMAK4raon5GNtplgYSMzzyLfAB8UOS9YtMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kP1w4jPurQ7NFA1nfuWU9b24AuGC94b26L/64jOXxxMs9VipbGWIBRqvWNez3q3AM2In4u4x3qYEz2is/8g6QR8h8sGEew6h5GNkn0rDLQwQP+oc8KfpfxayCdQy+MEXKgyO1t0hzPEFid1R1TDBxDTyE2/iq2XYwbtYYMcJPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GOLogiGy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso2784491f8f.2
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 03:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740481376; x=1741086176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyShyny9G2/yY7DkjMFQ2r6rzy1CSrizU536iAKhGig=;
        b=GOLogiGyWvjTaJcyC7f6K0r5ZP9Mb8CFXnYuEN/xjq2YpZhOd8sc+I2Zw9h6vSwuR0
         ZQBdgV+cGtoZe55K2jGhTsPTyFvYpiBbs3vB+wpa6f23OQ6qDHQ6kd3bPzjMg4HM/ZWP
         8F7UmYi5Ef/0VwI1ElmOMN19FY0Dj3WWHvBid2Tu7xwHaMorPxIEvHTJeZIubiJFipEp
         sXqEAxa/ymuT4dYYbuJvf8clH13U2ggpInsxz8XxcuABqvkBQiVTLnt9v5ofkSQbxA0G
         XLYrUhty4pWn5UjONMjugI2hREyDiHQ8TmSgczhn3OJKr8Z2PC3wH+z6o2KBwP/7PAGW
         /zHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481376; x=1741086176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyShyny9G2/yY7DkjMFQ2r6rzy1CSrizU536iAKhGig=;
        b=UlpJoJEQM89drobAwMpYUvquXJDoy/EKrQGDePEdydrRK7MbKK1Npkfp1XV+/NPvga
         slx5R3AoPAoSt8aitewQsvYTrcRQnajLGVDAxoKd7Qq5vIFHF1BXar+XS1G3H7eve7oM
         WWy/ldLiCgWcMkahqjlQVS59grEpGdNqM+uuO/7jKvdfccnBANZC4Y0brDaopUFH5WKk
         gmjkHtjoJc0EVzRcRaUly3E/Ve82bCSjPN32bw7lUBco6UGsge+NODJvUleOirNVOGAD
         YZFEv9icgdIi5BsuK08P4Vrwuo7nGJx8oPFmgkmOK3WEwdPAfRWuvRf4IeoSxKd1bB9l
         /qjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAHbAYvJDj4rV2fUoxct0L+2P9aKfM4jVvMeOkbE/0Nauc9dv0aFoxKFT+dM9D01KtJ2exSV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBW6mJP/QvX7Br2X2It37XGR4zBkJ6BtA/VySsMdgMzgHndJ1H
	7Vx93sRjTPezSfgpL47T/MCM4/5ICq4wBtScJ88My2asPTxdZFbnGN46orKSxBs=
X-Gm-Gg: ASbGncslF3ZbJC6jkOZslyP5DFpTPwvee1/xK1t7AXm4EC2SCj+5v/tjbLaBC6lW6sr
	OdEzF4bzCTxwqV5A4GHg8rV579mAEkJs5xuqTJLrHI13/DA3x5iDH3LcEtfxR73IvZTXriKnR3I
	JRnMeoUQfifYE1Tq3nj/lWtInlbNEPgFcGBNKb0d0Sp2gA9dCFJHCiYLwtgTAZRfGy16ZNaiCaq
	NFWOoOcrkpDEMqBvVkDeiVd4cGQ06UaI0fsw9BrhB9INJuGFJ7JvWAAtwNHPxh/sIExTdgLKBWz
	v7abnH8YTV+bGeuRt/JgMihaHIe7otCyLqrpGuR19IKzlCkuoUxPLp8=
X-Google-Smtp-Source: AGHT+IHGZ6gHlw9kSoahDWlxrbg/CLJ26q2dMB3XznLEbdWlGW9T87Nbkw4gSgN5rUEuHOYL93HXMQ==
X-Received: by 2002:a05:6000:1541:b0:38f:38eb:fcff with SMTP id ffacd0b85a97d-390cc60a682mr2129316f8f.29.1740481376531;
        Tue, 25 Feb 2025 03:02:56 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532dccsm21972385e9.7.2025.02.25.03.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:02:56 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	yoshihiro.shimoda.uh@renesas.com,
	phil.edworthy@renesas.com,
	balbi@ti.com,
	laurent.pinchart@ideasonboard.com,
	kuninori.morimoto.gx@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] usb: renesas_usbhs: Call clk_put()
Date: Tue, 25 Feb 2025 13:02:46 +0200
Message-ID: <20250225110248.870417-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225110248.870417-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250225110248.870417-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Clocks acquired with of_clk_get() need to be freed with clk_put(). Call
clk_put() on priv->clks[0] on error path.

Fixes: 3df0e240caba ("usb: renesas_usbhs: Add multiple clocks management")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/usb/renesas_usbhs/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 935fc496fe94..6c7857b66a21 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -312,8 +312,10 @@ static int usbhsc_clk_get(struct device *dev, struct usbhs_priv *priv)
 	priv->clks[1] = of_clk_get(dev_of_node(dev), 1);
 	if (PTR_ERR(priv->clks[1]) == -ENOENT)
 		priv->clks[1] = NULL;
-	else if (IS_ERR(priv->clks[1]))
+	else if (IS_ERR(priv->clks[1])) {
+		clk_put(priv->clks[0]);
 		return PTR_ERR(priv->clks[1]);
+	}
 
 	return 0;
 }
-- 
2.43.0



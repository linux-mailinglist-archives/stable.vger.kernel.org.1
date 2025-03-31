Return-Path: <stable+bounces-127034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFA4A76049
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 09:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B9A16802D
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0B31C07C3;
	Mon, 31 Mar 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwxUtLTB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7213D8A4;
	Mon, 31 Mar 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743407069; cv=none; b=aE28NAYH1E/jl326v+ZyjSSARJ5HvU7o+AzVEvxP9TIp6txGsdpxxv3WKLdzBKgUAWhs7bfokiT9BFlAnx/virlnMlmghbj0vwvgVpIB6nqHotatevcJb/sL9lxwDj32XqHLeT6RHbNVTezcMihwfevPL3HSgHtSpNpnT07zdpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743407069; c=relaxed/simple;
	bh=xmT1Q5a6AFUPK9f/ucAFOyzxGK4M6ko0iruMsYTwOog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kWIk0Y5J5VuxeMioxdUYierfYJasQYC9aag3ZmbAANOgcE5hVju0q3Ta517ErRWrS5J9uam8qLdidMV7djNlksnrIm+KATaABtGfDTY05eZRjrKQj913YJ+9iopGxDTA9bUqyuUPnynboMIQlEXVaFyUDKKKs1H/DOfEXpgNbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwxUtLTB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso26111025e9.3;
        Mon, 31 Mar 2025 00:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743407066; x=1744011866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8L3gLHE0iXx8zQGDJ8LlLcTKVC/8dXUo9ajwXYWTFg=;
        b=NwxUtLTBsC5GdkchlO9r7BjGTBt6UkIcPcs9ls+YjHNpqwtzhdjAtxRLqkiwCOBfAq
         FSYuwvOLFUzcmObNsqhTz5fBfoAQ5aPnARKu6B8sSis5rlZmRiGpJ3jtFb9pbuMfq3al
         DrO6SDfAzOl+CuTjF0Z4Mi7qHlHa3oOkND1TFri86eQD73GWS8yIr54RCIX6i65Q52U5
         YeYYew+JGT6h9Z2fJ2PLbd1lhA+TX/ls2t+v1LQVZiW9yuW1ruM6As4GnLhav0dIKkvA
         487+9GCaEcY8UpAHR7+4YgpSHzuXXo8NN53eqv99A64QIhUlsn7uEIMw94PlMT21WiOy
         wA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743407066; x=1744011866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8L3gLHE0iXx8zQGDJ8LlLcTKVC/8dXUo9ajwXYWTFg=;
        b=uutd2oy2OTly3p0ypqv4qJgWZ2tzw/0qXDK+Etq76smp6vEye7c9cI+uLYcXAMbMkv
         4vkyuQf+bS00xBHqVEzVaKhWuwt0Fo8J0Kw20xQbiRN2ttA6bMkZHPXUKd8SYf3+b8wx
         OqB0KcTEUq8DL3H4hFUqlZKlS9w1frsxuYw5hQgzs7LnPJcjRu0Bdi6HpyA6dlEokXyb
         6EhQmkpAXB+hB2fS5EJYZjvbB+kjz6N5ZCSrEO2ihOU0lZtw96KxbIL/9inmZU7Vlo7w
         ErLXAE2Wdy2gtJFz0Fdx01BVm+alr26QhLTzkRaJtjTDHNk5ekDU6ktLHOcT5x7Iz34v
         XG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7xXW4cXXSbWMz3gWBY+du7gpv8PtXYk3/wyMnh187vnVjSwdoFK8b1O2J/+2uMbLlZXVYVCzG@vger.kernel.org, AJvYcCXVaVAis6mKHnxOU7e8pNh+si+dyTh351uKBsyw9vjKs2ApAiUMgMcLBOD5Ttkqdysuj1XCxZLYDzme86A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy53LUtWMSY9HiqNoJQCW6CS6spnoqTSuBHR/S8pjXFyqkMFg3W
	GWMRGf0qFGHp2mwTPOOYf4ptdhcSWwgshbcOlL069inQMTlLdK9J
X-Gm-Gg: ASbGnctkJcSUA+2uYnuc/rG7Fs9t5YMimA97a+U3mxTd7VqdPP1cISg8pViedhdaH7U
	Z/LksQEy98gHa+af1yx3yU1oGw8hCBshpHa00hLU0/0q1CdlmfBbhpUYTgDEhhxgqG3XZMqsn6P
	iNRPLz50hE1eG8BQ96DTHAHKHPNMZ6TT8jIL4iF9BmFqWq4iZL5tasBUYmFTNhpEX4Ci1mk21rq
	O9X9XJCTCJFJC/yI7DMJip7fyqUoFyUOTTzjwLdhbg6zTOJ6M5f5H2XnezJF2VRi1SIsAU8qeoQ
	uhcY8iQQbtGH3m/yWZMn7df6exuSyJSvk/4d8Tyg9H2HHBsiAA==
X-Google-Smtp-Source: AGHT+IEU6fWpjT/iTPyqpawIrj8kideGZRhmNQegpvlEXo12tPGNrAQ7TR+EVkOdgUcKFpnGqAnuvw==
X-Received: by 2002:a05:600c:5119:b0:43d:526:e0ce with SMTP id 5b1f17b1804b1-43db62bb97dmr49667695e9.21.1743407066132;
        Mon, 31 Mar 2025 00:44:26 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6588e9sm10812284f8f.14.2025.03.31.00.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 00:44:25 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Da Xue <da@libre.computer>
Subject: [PATCH v2] net: mdio: mux-meson-gxl: set 28th bit in eth_reg2
Date: Mon, 31 Mar 2025 07:44:20 +0000
Message-Id: <20250331074420.3443748-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Da Xue <da@libre.computer>

This bit is necessary to enable packets on the interface. Without this
bit set, ethernet behaves as if it is working, but no activity occurs.

The vendor SDK sets this bit along with the PHY_ID bits. U-boot also
sets this bit, but if u-boot is not compiled with networking support
the interface will not work.

Fixes: 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support");
Signed-off-by: Da Xue <da@libre.computer>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Resending on behalf of Da Xue who has email sending issues.
Changes since v1 [0]:
- Remove blank line between Fixes and SoB tags
- Submit without mail server mangling the patch
- Minor tweaks to subject line and commit message
- CC to stable@vger.kernel.org

[0] https://patchwork.kernel.org/project/linux-amlogic/patch/CACqvRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx=8=9VhqZi13BCQQ@mail.gmail.com/

 drivers/net/mdio/mdio-mux-meson-gxl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c b/drivers/net/mdio/mdio-mux-meson-gxl.c
index 00c66240136b..fc5883387718 100644
--- a/drivers/net/mdio/mdio-mux-meson-gxl.c
+++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
@@ -17,6 +17,7 @@
 #define  REG2_LEDACT		GENMASK(23, 22)
 #define  REG2_LEDLINK		GENMASK(25, 24)
 #define  REG2_DIV4SEL		BIT(27)
+#define  REG2_RESERVED_28	BIT(28)
 #define  REG2_ADCBYPASS		BIT(30)
 #define  REG2_CLKINSEL		BIT(31)
 #define ETH_REG3		0x4
@@ -65,7 +66,7 @@ static void gxl_enable_internal_mdio(struct gxl_mdio_mux *priv)
 	 * The only constraint is that it must match the one in
 	 * drivers/net/phy/meson-gxl.c to properly match the PHY.
 	 */
-	writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
+	writel(REG2_RESERVED_28 | FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
 	       priv->regs + ETH_REG2);
 
 	/* Enable the internal phy */
-- 
2.34.1


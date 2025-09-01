Return-Path: <stable+bounces-176789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E5AB3DB17
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8269B3B2F6B
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744FC26D4CA;
	Mon,  1 Sep 2025 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDIB7jxY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89DA26F2AE;
	Mon,  1 Sep 2025 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756711956; cv=none; b=OdFs5epGIenuIVoR/DjP07LywMnIje959WUfP4M1tcVcW78H2d/l+zFhlQoRfWY1422FUER0334ZLRTuKxThfjs/Jn7BUSxhBNf4IvTBm6sm2xpajKQvc5x/+f/1h8dMHsnlq08XKByr9kCwvkvFwVkiNBgsTQP4bVTmxoTlLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756711956; c=relaxed/simple;
	bh=Tib9W/CgGxKrTG7tutz+gnQpqUXs0++EMfobtgtr6bY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hIEwkwwPisU3cp0sFkh7n1y/cPZ5IhWEk77iYIFjnLpCrONJYrrmLBHb7Z1RLgtlj8ZGkqTpv2ZkQZRGoPotFyN+RsUG8VzEau8+1gEc5fQSbvO8u2mwU4XGASSHWPDUJYs0KwNr43ddUQWIi0LjdnU+YCEBt7r0bgnHuCIWCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDIB7jxY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2487a60d649so49827455ad.2;
        Mon, 01 Sep 2025 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756711954; x=1757316754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6rOAxdmOETfgsAaqbaLTN5ale6TV6rPQAy9mKOuAnE8=;
        b=gDIB7jxYWvaRBeJpLG1aU2K5TTeV3ik3qq8NYqoaH5xljJysTkHVB03JtwkmLmyalj
         1F1cRoGkWem5zphLH9dsE05o/23jOnfQmLM818FfWI5tKn52LhyKScp9noaCK5QcY+V0
         U14inozlUA0tMfBS6vVH9TNCWjeaA+QXJKwYPFkLjTyv0swlBdTgiPlOkfYgC4fVsT4E
         yg5hL6iRiAvSQuZJpaxTbQfy031ASSaztp6I2oCX/TVVLgzPUf8skIx/7V68nVfJTjUq
         BZ1azWoDE0l0dactydWtgNZ5bM9DSyk/kCUPoBrJTG12jSbdtcITHi6Vsk0Us9A0NUur
         P84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756711954; x=1757316754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rOAxdmOETfgsAaqbaLTN5ale6TV6rPQAy9mKOuAnE8=;
        b=aChK0npyHXuxeCwd8bvL+biYmXvU/ko7r6sHckOMbHpeyz2ZISKAM/1VWlCjCfIhGD
         o8yPQPMuyKqhww3zQjioDtV3hNrML6ovJ9ZQMs3RkO7FKWotVHakZyL62gzisuXLN25V
         DydQ2v/f+0mmCP5Zk7shp/qnyFivmYSXSLXzulNGOp/2lFhwKeGf0TsL5oks/oBnaowk
         fYfMlB2ONpl1P2ahFncCPNDHTqLVffY1+RlMMZpsAdHesrB8qVUoUCLV/o682FhT/UtG
         AjN5Pjefoht3A4BAiuQbU2dfc9DHR0+YGlkJ+ka3F23RaF+JCPZx9kdIeA85LQFPsX1f
         /w9A==
X-Forwarded-Encrypted: i=1; AJvYcCU3XjsFu31aG0eVWJfO8RPTGPkZncKj7174YB3PdS8Exe0pPSDniImx6dzPGM9L9YJlPORhi244@vger.kernel.org, AJvYcCVH8EDjoRObU/PUrbfc/MDvB6vYVQFpDf42R25V3To93fensAEj4PEpNIsM8D5G7ifcaHtap+Mdqa/WjIY=@vger.kernel.org, AJvYcCWG5I9c1Q2AaCVFZq97NnD8GQwb8A0YgtTSAwpxvfQRNXQFvSpGrxphbteEmZbk1vOAJ4/bkHRF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vF/7siaFKzCdPweDsUsY5L8vrVyqQ55w4SUjswQNpImFeZ1x
	3Rp02S17yAMlS4p7awkT2LIlxv1+kCW1S1xuQMt4gcRwHBovWgNS2XBW3CnPhezo0VE=
X-Gm-Gg: ASbGncv19v2SyjAtbR8sYcx8gh/UhGrkeqXjq2OGU+DE5X/EJOPcsMlIICvA/GBFviZ
	i2Y+nEfWyom+SyjtNgRJkRgeG78LRTd4CcTnQPFWILi0rCxDCAe1tTGtxLKha87yEL5byoEDJd5
	JGAf+8VeIywmtDZLPFVfxhxcM0AazNFLwOoL1aKdIiUVJ+Sk188fSuYwYd2SNPJOvo0YHqwax4x
	cPyy+/ki3Yac1ATLgqzn6U+pdVu/+BoJ96th2nUC3V/BwsFg4ymTExm30BVSqXvPdrTY7UA2CQk
	b107HYqojf2fcac1k40SDPOiCHUXbbXO5lb/g1aBLSFN66pm8jGlEeFUP0+MfZaUWm4R3eYlh6N
	xOUKOtohKpP5JnpxtLNqVtr5aC/NocZoHkL+BLlaDkrgml6qnZMBjBMbIAlnbr71om+RlmYo8ZO
	0I6qDBrSHgCgcci6WUVVDILk3W+Wpb03/dB8gwY0mdBTSftw==
X-Google-Smtp-Source: AGHT+IFkslgfwDMpPMAmqLBkJ/nBUu/MN7hOY4lUTgPiIxx0vtJ9uHgXIQjTess/VvF7BwLR1zVzhQ==
X-Received: by 2002:a17:903:1a2e:b0:249:10a1:5332 with SMTP id d9443c01a7336-24944873f1fmr85728725ad.9.1756711954035;
        Mon, 01 Sep 2025 00:32:34 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.116.239.33])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24903704060sm95957675ad.20.2025.09.01.00.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 00:32:33 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] net: dsa: mv88e6xxx: Fix fwnode reference leaks in mv88e6xxx_port_setup_leds
Date: Mon,  1 Sep 2025 15:32:23 +0800
Message-Id: <20250901073224.2273103-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix multiple fwnode reference leaks:

1. The function calls fwnode_get_named_child_node() to get the "leds" node,
   but never calls fwnode_handle_put(leds) to release this reference.

2. Within the fwnode_for_each_child_node() loop, the early return
   paths that don't properly release the "led" fwnode reference.

This fix follows the same pattern as commit d029edefed39
("net dsa: qca8k: fix usages of device_get_named_child_node()")

Fixes: 94a2a84f5e9e ("net: dsa: mv88e6xxx: Support LED control")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- use goto for cleanup in error paths
- v1: https://lore.kernel.org/all/20250830085508.2107507-1-linmq006@gmail.com/
---
 drivers/net/dsa/mv88e6xxx/leds.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/leds.c b/drivers/net/dsa/mv88e6xxx/leds.c
index 1c88bfaea46b..ab3bc645da56 100644
--- a/drivers/net/dsa/mv88e6xxx/leds.c
+++ b/drivers/net/dsa/mv88e6xxx/leds.c
@@ -779,7 +779,8 @@ int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
 			continue;
 		if (led_num > 1) {
 			dev_err(dev, "invalid LED specified port %d\n", port);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put_led;
 		}
 
 		if (led_num == 0)
@@ -823,17 +824,25 @@ int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
 		init_data.devname_mandatory = true;
 		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d:0%d", chip->info->name,
 						 port, led_num);
-		if (!init_data.devicename)
-			return -ENOMEM;
+		if (!init_data.devicename) {
+			ret = -ENOMEM;
+			goto err_put_led;
+		}
 
 		ret = devm_led_classdev_register_ext(dev, l, &init_data);
 		kfree(init_data.devicename);
 
 		if (ret) {
 			dev_err(dev, "Failed to init LED %d for port %d", led_num, port);
-			return ret;
+			goto err_put_led;
 		}
 	}
 
+	fwnode_handle_put(leds);
 	return 0;
+
+err_put_led:
+	fwnode_handle_put(led);
+	fwnode_handle_put(leds);
+	return ret;
 }
-- 
2.35.1



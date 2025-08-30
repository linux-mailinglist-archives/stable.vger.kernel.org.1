Return-Path: <stable+bounces-176739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E35B3C989
	for <lists+stable@lfdr.de>; Sat, 30 Aug 2025 10:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B318D3B0A66
	for <lists+stable@lfdr.de>; Sat, 30 Aug 2025 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D938A247284;
	Sat, 30 Aug 2025 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQZDp433"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446951DDA18;
	Sat, 30 Aug 2025 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756544118; cv=none; b=dCtLFO5QJVUHnZxuTXwexIkS3WXCZwE54lzsTzWfj4ySbzaI4+KSDB+iJ7jjyopAa89MYAxfp8I3otJmdBFEUPQ/wCaWhD4ABp6eLBl9mJhkL/tLyOf24IfYn0jSD2zxLn6aOp9tECnaURMxL8sE/K2OZOUvzCbW8SxIB1TFLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756544118; c=relaxed/simple;
	bh=i/mN1sgpxt2Dt6aoQYRdO4ESSsvQ5P9r2eVyi3rcGqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XWCF75w+jENf3lZShL0RxFkpxh7OYEZuoNEU/+9pCHHUv7iehZzKfjR5VUjFMtcu4yYTQHTY0oR6wkfi1D2nFTQ5oKhzyWXXKJIoeDO9DpeqT9VmvFpyWB49tzIAwNakGh5PhFkqq+rx6xHD28UGA9dbPOtf+6MUhg5HHkVz9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQZDp433; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7704799d798so2381529b3a.3;
        Sat, 30 Aug 2025 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756544115; x=1757148915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/g/9jlkjpAHQDAZ+36D2vqfG5gOdTRj2+Yr8N1lRDG4=;
        b=cQZDp4330nHzVo9Y8zsIsyVABWViMsxek5eFQDydmWLewigJsEBLhzb88D0+GEpxGv
         nHXh34BcyJ+e+RKbqLrgtD4p7u4wNA+oFdFxHcEESlsHs1gYmg1iDsvAXRtMd5b4METD
         YZKg8FmJ2FWfLWEKswN8NmtugUfxFgE+7JvenXNgX8/vrmR1LhRI041tGJltZp1VehLf
         UdLEnShPCfjS0EluLs7Rgtv89NDrodi7DpVkmQXEYU7ukbzXnMgTzib+VSquss7SE5Xw
         kMvMeiZXXPsikcBfTkoeEn+F0VVbilxwngbOCqu0up+kNS17kOP2GUpV9s6Z+o7N1bgY
         AwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756544115; x=1757148915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/g/9jlkjpAHQDAZ+36D2vqfG5gOdTRj2+Yr8N1lRDG4=;
        b=wdgdwagNPdDBvTZsCZGeT+lZNLxYy43+Seb7VugnyUEY15P4csG1JuiB/4SmC7g0bS
         1OoBsk52HPFTtnStssai07gfu5Mj0o+Fc0EbmB8eue0evZjsPc+45Ho7PvF2aWU/6BFl
         hAaVf2RjsrHnGZr1BvABLE4HsBJNcDweGId26SarXG0tGCJaC09sziaZPXGpB9AdILiK
         5tlAQNVTHdCZMBZe41sIUYXPmsiUqGsxUw32v66JjNgGwSFKO3iwVtpRd8sqd1ZQcPVx
         RlaxNQyqq7Jxfix1H1oL20V+RAMP57dWYWyBhRYKYkzjMdSmWKX22I3EWL5i5+KThl0A
         lEcg==
X-Forwarded-Encrypted: i=1; AJvYcCVMVPFk41kRVbGNqWFInBNPddHtNLPe3E7pouO+w1miJba/Tsu2f6uhiqgy8rSHyQ0UkbTofurvZcLFIno=@vger.kernel.org, AJvYcCVQPRxKzo53AjW2WD94oWoLIhIn/pO3KuIBR4fXLPx+JGFuqjsUJGaFRXLoPwg6DkSI2URWjkIp@vger.kernel.org, AJvYcCWvHv53Io55YEg5mWStrz+kIOFJbEAM0c0KWfk/yvg+i7peW8266EaENt9wOxw3+LGZ6aST5qXa@vger.kernel.org
X-Gm-Message-State: AOJu0YxI44j9tLPlYVK3cLl5b7J7+xIcwsLBN3zFxcceYFLHZcwKtrcU
	jlmAXUWrIoSPM+EATEpY3X+bHmIkrs2mceqPlppRdCoXESNQlt9BIB4S
X-Gm-Gg: ASbGnctej1H5bfxwftI9un3F3pdBJ1Bzoth4lrkH4ooHo8UBnO2JJfMxVGKHffI+6W5
	d5FcwvP923j3DATdcAa9g0k1yECIfcUo9VWxgrH/ghwfCKQNAeGqA3X3r4z2lNpvANz4v0y0EkZ
	CVDs12mafjxo92jTbFQYlxreTLTKClmqEQaja/h5MjR0ZNMJfQZiucJOvHkAlJt9O3SUfX2TNWj
	ggfxiguzknbMoWHoHWTPXW6szoEJ6yHjgVZUueUHVUja0SP0p8983P48BOLWyZSNaZO4PkOT6F/
	TP3vY2Fd7JRQoP4DAEkr+1btKsOVfh58q3i90RBnVDvD8gE3MVkfq0CVn1yJufFoX8mSz53FCB4
	hOTMBXd4Az6O3vMu61nyBmsTVt5ELMEMjx8vl1eIhDIoY/A194yJ+RvIt/GwGeN19qBZ+H34TBr
	CxltybnCKIdkMf/u8ftpLoGN8pkq8+vph0S72h/SMOeyPsfNleJM4BVwg=
X-Google-Smtp-Source: AGHT+IFufVgDFn3jScqiTqDiEv4K379j2VpA4sl2gvYUjCnALZlR4vQ/abr6HCgG/Oy8R9lh6f5tZg==
X-Received: by 2002:a05:6a00:4b56:b0:772:2c15:230e with SMTP id d2e1a72fcca58-7723e21e99fmr2115295b3a.6.1756544115367;
        Sat, 30 Aug 2025 01:55:15 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.22.11.163])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7723d79fed2sm1426111b3a.9.2025.08.30.01.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 01:55:14 -0700 (PDT)
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
Subject: [PATCH] net: dsa: mv88e6xxx: Fix fwnode reference leaks in mv88e6xxx_port_setup_leds
Date: Sat, 30 Aug 2025 16:55:08 +0800
Message-Id: <20250830085508.2107507-1-linmq006@gmail.com>
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
 drivers/net/dsa/mv88e6xxx/leds.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/leds.c b/drivers/net/dsa/mv88e6xxx/leds.c
index 1c88bfaea46b..dcc765066f9c 100644
--- a/drivers/net/dsa/mv88e6xxx/leds.c
+++ b/drivers/net/dsa/mv88e6xxx/leds.c
@@ -779,6 +779,8 @@ int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
 			continue;
 		if (led_num > 1) {
 			dev_err(dev, "invalid LED specified port %d\n", port);
+			fwnode_handle_put(led);
+			fwnode_handle_put(leds);
 			return -EINVAL;
 		}
 
@@ -823,17 +825,23 @@ int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
 		init_data.devname_mandatory = true;
 		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d:0%d", chip->info->name,
 						 port, led_num);
-		if (!init_data.devicename)
+		if (!init_data.devicename) {
+			fwnode_handle_put(led);
+			fwnode_handle_put(leds);
 			return -ENOMEM;
+		}
 
 		ret = devm_led_classdev_register_ext(dev, l, &init_data);
 		kfree(init_data.devicename);
 
 		if (ret) {
 			dev_err(dev, "Failed to init LED %d for port %d", led_num, port);
+			fwnode_handle_put(led);
+			fwnode_handle_put(leds);
 			return ret;
 		}
 	}
 
+	fwnode_handle_put(leds);
 	return 0;
 }
-- 
2.35.1



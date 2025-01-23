Return-Path: <stable+bounces-110271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69548A1A418
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 13:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30DC1627F3
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 12:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A9520E6F3;
	Thu, 23 Jan 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWUcp+pE"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09320E035;
	Thu, 23 Jan 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737634846; cv=none; b=KiJKMCRrwwstUAzKplamuWA2gS9blhNYVS7yOrAnv3X7kKh+4+EVb0Dj61RXqRPb11qyfuUxTU7/VvLq390pNWOectNRo4PBC2EH6L7YzIpGvsaozCeumEge0NcFf4rlXlTwMj85gBzjSCPnTyGA9n/hvctGdNg24VT7QQW5Jbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737634846; c=relaxed/simple;
	bh=991pwosZTNeCjRCZvbKHp7Ffpmv7T89c+Civg60jQ/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ErRM7suNhcWHlUvDAbHpK+F931DrEoqBz7ZexcowfyFt1nPJ3nB6PjZfnSK03d1/9iW6WwReb8ZORfpNViz8PwsbuqAf5T8HXGB6+10wcJU3jLA+FrnN9XlMes30EoEsOABwqqOJfeq94mVJLh5X0ATLoxxeBUk6aA+d/bfQbsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWUcp+pE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5401be44b58so991158e87.0;
        Thu, 23 Jan 2025 04:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737634843; x=1738239643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4qYFQg17lPWWI/P3x77cxigTrSYOa7HHPOEIY0DqiMU=;
        b=AWUcp+pERtm/jzNybJnqGXZ5mbrbNvNmC+F/SkSsDmZWuP5mXCMFX2Bayd2b2TWOsy
         zrwyxjuFE5Tuws1a/ZN6Kt4NikOaahWw6vpSxfhbVxLjt6Umvs0bPdMQMji99Ng3NN0a
         WL3+YCUh0rb+PbO5ZHm+cvRsrerRrYonwdZa+jj3d5MOy/bl+gnyDo8RzfyDQEhhtW5p
         RCYOHsQTBXlngCYglbyXF6vXApBse1A5Lb83CrkK9z+f7IRcJoA3DfeMgrL8KS1JnRxd
         goAAZg+kB/b2MJqr+KEPO6d5ZP5BSw85jk9JesPXBzMBSPJHF7LGPPmNslg1xC6C8dcU
         7CFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737634843; x=1738239643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qYFQg17lPWWI/P3x77cxigTrSYOa7HHPOEIY0DqiMU=;
        b=eYb3hY81ia8kds29hG9vO9p4Qpe1ladgP2sxCg5DxK4j9j+uI3s4W72MvmdUKn5T4e
         Q+9kLDvEA9506V72e7tcXjKOTprHOtvjgQ5mAbseEL6Q4Kr3fMTSYX2KrI4Syr/g19x/
         LylinfvGkLA+h8yJiMjaPINm7Vaa8+ciSrTrzN7cR7HRoAPPGNF3UDuvRz0dYCjJBJ3l
         4Isu1oCCzZf6Sguf6tClK8JLrIRrjv4RdC7pwpZTY5bGIPkYKbETd10AZLpIOebVmWOr
         /vjoJn1kaFN18WSKcrE+o2xNBPoIodNlhlV7hKUMz1r6d8hTQ1ytesdEg79KhhnDHUh5
         WWYw==
X-Forwarded-Encrypted: i=1; AJvYcCW8JWi+v2npFjdK5JzfJt5cetCQ3CYCNDIC4xuycu5cYxQgxksN8FfEzH5nixI/KqpMMx6dl0Mu@vger.kernel.org, AJvYcCXWxSDppbBXCIiKEyOMqfHV4gFXJy3S8kfTwJOmaMJdJdDhWZad+YJ5EFo1SHD8QyXzOBGTtUhjwxz6Jw==@vger.kernel.org, AJvYcCXabo/WjjKo+FvPpKx1LXwOoQPS4dEg2OG4FJpD7QzCspnc9ghKO1YpWR8jvjE0pOIBAr8u5ohGVREV/DG7@vger.kernel.org
X-Gm-Message-State: AOJu0YyPpGPoDa9VBdVomsHw/SpN65yOGboiiTWWXiPfJpK/E6HGMJiA
	krMGrblv8POxfWPeCeq/h3k4TUOvwyLmQEzipzuTD9slke/QGGX1
X-Gm-Gg: ASbGncsyp0bMvS9Usx30IrRUp0ptj6N8c9aGvS6czn1ZshUjbyV7n4ThEhOdfCEmz40
	fKySUpMT0XPx2Ybi65TZryWz9LRYGTVDNBgLp+StBxIILEbiox+346l7wiLabff8+Py0oKPmsJb
	aLBA+pV2uCeCWtjl1PaR7/H31n64ejoLBrpaGPMpEhdwqL8K5O9C5ijJN8CSIn77taIGTJKq/lO
	N2jmQr0Kd1GQi4UJG1H7cXcbRzrKQdPXHyxx6RImMlJQakCFZRGobS52tytYT4Bcmyb11mk1jj0
	PWvHXvTIp8aVBpSP/1g=
X-Google-Smtp-Source: AGHT+IFh/38xtOnDXSxnSHxS0Vf37RqJLjOETl12HDi2Hz14nXUfDH/FUeDLCk7E7rFbZ3IaOP/JsQ==
X-Received: by 2002:ac2:4c56:0:b0:53e:fa8b:8227 with SMTP id 2adb3069b0e04-5439c27b239mr10309500e87.45.1737634842696;
        Thu, 23 Jan 2025 04:20:42 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af78febsm2604588e87.248.2025.01.23.04.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 04:20:42 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 50NCKbA6006054;
	Thu, 23 Jan 2025 15:20:38 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 50NCKYtm006053;
	Thu, 23 Jan 2025 15:20:34 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Iwona Winiarska <iwona.winiarska@intel.com>,
        Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Cc: Joel Stanley <joel@jms.id.au>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Paul Fertser <fercerpav@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] hwmon: (peci/dimmtemp) Do not provide fake thresholds data
Date: Thu, 23 Jan 2025 15:20:02 +0300
Message-Id: <20250123122003.6010-1-fercerpav@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an Icelake or Sapphire Rapids CPU isn't providing the maximum and
critical thresholds for particular DIMM the driver should return an
error to the userspace instead of giving it stale (best case) or wrong
(the structure contains all zeros after kzalloc() call) data.

The issue can be reproduced by binding the peci driver while the host is
fully booted and idle, this makes PECI interaction unreliable enough.

Fixes: 73bc1b885dae ("hwmon: peci: Add dimmtemp driver")
Fixes: 621995b6d795 ("hwmon: (peci/dimmtemp) Add Sapphire Rapids support")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 drivers/hwmon/peci/dimmtemp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
index d6762259dd69..fbe82d9852e0 100644
--- a/drivers/hwmon/peci/dimmtemp.c
+++ b/drivers/hwmon/peci/dimmtemp.c
@@ -127,8 +127,6 @@ static int update_thresholds(struct peci_dimmtemp *priv, int dimm_no)
 		return 0;
 
 	ret = priv->gen_info->read_thresholds(priv, dimm_order, chan_rank, &data);
-	if (ret == -ENODATA) /* Use default or previous value */
-		return 0;
 	if (ret)
 		return ret;
 
@@ -509,11 +507,11 @@ read_thresholds_icx(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 13, 0, 2, 0xd4, &reg_val);
 	if (ret || !(reg_val & BIT(31)))
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 13, 0, 2, 0xd0, &reg_val);
 	if (ret)
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	/*
 	 * Device 26, Offset 224e0: IMC 0 channel 0 -> rank 0
@@ -546,11 +544,11 @@ read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 30, 0, 2, 0xd4, &reg_val);
 	if (ret || !(reg_val & BIT(31)))
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 30, 0, 2, 0xd0, &reg_val);
 	if (ret)
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	/*
 	 * Device 26, Offset 219a8: IMC 0 channel 0 -> rank 0
-- 
2.34.1



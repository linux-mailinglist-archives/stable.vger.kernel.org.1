Return-Path: <stable+bounces-134723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A22EA9457A
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 23:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5451B3BAE92
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 21:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB3E1E5702;
	Sat, 19 Apr 2025 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XR/8a+tt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B01F14901B;
	Sat, 19 Apr 2025 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745098499; cv=none; b=aGnoa5CYIh7ZT8WCN6KiZJDdNG0lLLCBHkDC/IDAr8/C2NYr/9/XxkImZiLdi/FU22OPMbK1fVozA55BdAxhypWajfq8SC9CDf9H6ct2KLCe06aWUXBZhJicObIgg/WswLT8e4WdOt9uONnyMLJtR96LT9CsRTx+iUohAbgCq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745098499; c=relaxed/simple;
	bh=PRfH/elj0OQ52dJFa9t0pmk1G8zdnOeDskIHX4/5Ru4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnJXT9ON8Jd6NURr3Ft+Ht6hlXPmm92GcO3UvZ2gyPwMahXdNLA6KFNa+pM/8r4RQn7Iy9EWIOxGHdcXBLABvJADZB5VtFAn3ozrWNVExCQQ6gylhmF1Db7MvP0uOO9GPD/GSFLl/GnvUgN1axI7JHlwSuIo1s3fgHL32lNJqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XR/8a+tt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso3729818a12.3;
        Sat, 19 Apr 2025 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745098496; x=1745703296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxYKThiSP5CpC8ECIauIBDHNEvnQh43dWazKFIWJZDU=;
        b=XR/8a+ttEpwdHvrupJSFCNTTFB6ijN7Aik3uakmvqkzVdxhuvotv7bK8cq2eKS3JW/
         ybJE3B8S7g3mIu4NC/3lHPnwEjOyEQNKMQr8doebKylqOipmYXQZ0+iYgeZ61EzbSj/G
         oLcmCXgwSsceP7TipJ7UO47kh/7MSxu9a/SPwIs7jXFkorggx3YVqjTcmLsydvPFclOW
         NxQSmURIK/FkHkcUG1YzC8JOlHzSsRZY9zwkhrbgYtm8avve+Vk8P1X3dxxgXlDwuHnu
         iUOeLE8rGcwqr1SPNlYzoxnYnMrfqCAP6+FHOtHE6lXp8IB4Ywf6y53IN4CsSVAtT9QV
         +mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745098496; x=1745703296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxYKThiSP5CpC8ECIauIBDHNEvnQh43dWazKFIWJZDU=;
        b=UMD8/NuPcX3AKhH+eorZ+6YzL1Eba2PEg7/aNZKbcejiHJW257SQfMzjv0+m1Ng+HG
         J1PlEJBD5uXhdzcMYkeyGhv9EAPzojUF7CwcNM0J1k7Zy4uXG5flfOcqmHV3lPNsuSlw
         N8pECGugUEtCa6DrVebEe6UHL9BnI5ZWNzIXRB0FaV3vUXnb/msAJJXCDrAYwxC2MQeG
         pRDKEkVr8mDRUOUEsV4cFk03U91oq2KRgHVtamuBdleevvIsGa+Xq5XH8xvkZItGPQoi
         lIkEHlKkt8uoqx9rmEMxyBRJqbUh1nK2V+176B+IwYYNrXPaYKTfQCVpPxW+J9zPZFD3
         Z3iw==
X-Forwarded-Encrypted: i=1; AJvYcCVDoA5xbbiUQPurjGhTIuFNzDwsD1+3neBFeLSunm64rHN0JAjQPO1DZ/5kJLqGgYh5ggK/aGwj@vger.kernel.org, AJvYcCXtRezHIkp/s0fZDlBnRQhs9k85R0s/vDmBJGJMnCQ459xEnlMpg0WVVacoS6M7ZJsqLEjo783q5ODv5fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8UexKjrDMfv99A3m5YhcE3LTEmfG+xOJGbE02clWGSlKW2zn
	om+KR1Zl4V3E92NZqBYhchdMS3WOa0IdIaFib6tTQpwcWraG+2bodGIq6A==
X-Gm-Gg: ASbGncva7NqxIFyXs+Qrp2NT1gfVLdzdmRq+GM3Ht1WLrucdosRnYaDaU68+dMDwxy3
	7UujZzXlHbZSaf2GFtZo5xhiny6enDPcOlGJC+PEhDNUAc5FkiC4BlcUXItuwksLseADg35S2Qr
	xITvnKn/XmtqzVnaqdO5ZXC2p3T5XIrlCkDHVmHdWpGPCq0ql7q/JQzRMzzFU3DjDnGlAxNt/0d
	3Ztp0oQjgt7Xf780bPJtNMlGMb84Qg0bzRva8VV/FUu4JMoYFBncpSq1svK41cJDPZHgOXtftpN
	rpWx4MT1u8qPov+1YiUvzmewH+c6thP0fdfc6nxN0F1VB5eLmcTsfvG3frKr6MDD++OFxgv8cnS
	2280Uh+58Zc2YvGHYbaYcFk0rhWJFjlJkKMUvV0H9Aw1ZifHedRfMZtlRRJBV9H7vFw==
X-Google-Smtp-Source: AGHT+IFu9MAPI6bhOcadFv7sdrdXp++L30ws8oMOqAOpHPkw1HcqkypIEaEE/ckknmH+OoGsiLtYkw==
X-Received: by 2002:a05:6402:5204:b0:5e5:edf8:88f2 with SMTP id 4fb4d7f45d1cf-5f628603ad4mr4778873a12.23.1745098495728;
        Sat, 19 Apr 2025 14:34:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b1ff-f000-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:b1ff:f000::e63])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5f625852a55sm2660022a12.66.2025.04.19.14.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 14:34:54 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-sound@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Cc: jbrunet@baylibre.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: meson: meson-card-utils: use of_property_present() for DT parsing
Date: Sat, 19 Apr 2025 23:34:48 +0200
Message-ID: <20250419213448.59647-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c141ecc3cecd ("of: Warn when of_property_read_bool() is used on
non-boolean properties") added a warning when trying to parse a property
with a value (boolean properties are defined as: absent = false, present
without any value = true). This causes a warning from meson-card-utils.

meson-card-utils needs to know about the existence of the
"audio-routing" and/or "audio-widgets" properties in order to properly
parse them. Switch to of_property_present() in order to silence the
following warning messages during boot:
  OF: /sound: Read of boolean property 'audio-routing' with a value.
  OF: /sound: Read of boolean property 'audio-widgets' with a value.

Fixes: 7864a79f37b5 ("ASoC: meson: add axg sound card support")
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 sound/soc/meson/meson-card-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index cfc7f6e41ab5..68531183fb60 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -231,7 +231,7 @@ static int meson_card_parse_of_optional(struct snd_soc_card *card,
 						    const char *p))
 {
 	/* If property is not provided, don't fail ... */
-	if (!of_property_read_bool(card->dev->of_node, propname))
+	if (!of_property_present(card->dev->of_node, propname))
 		return 0;
 
 	/* ... but do fail if it is provided and the parsing fails */
-- 
2.49.0



Return-Path: <stable+bounces-98771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95749E5208
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB31C166D45
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7521D63C7;
	Thu,  5 Dec 2024 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tarLBTty"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131BC192589
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394125; cv=none; b=XNB3FdNqKH8XWD7fSwE9ydQBTgWWG65dSIt2WiSRZ/FG4GuZ69bK8RkybOG/f6tLjh+QLo8tpfZJbCMuWAWw434Sx4MF7zxiuw+evm4kMHr6cgtHXLkndvbB5NgxU5gKIDcNOnNls6cB1NfLaUPLjcwGU3657ethTaJW24yZuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394125; c=relaxed/simple;
	bh=plXtOKz29GTft7oIa1xpVOqkG4eCLvwhQNSboWbCoo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fMV6oQE3P8InwiZRefUTYGb9b0S+WtjpiTbd0hSgQmQnfCMhGByB4ERjP6A/gU5nDERAu/rBoUfWmzIEw0JhBl55FpysX2j0hSJfLHzrmXTvAUHjlelOiOt1hUgNoNxEtv/+fR7qYSWGbsm9RvRwDmo5ISdJi8qKlFeS+LREgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tarLBTty; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e8522445dso130980266b.1
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 02:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733394121; x=1733998921; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2qCz2oyAWXcySnvC/YTGdboyjGwCf8uvEh34M5NQ1w=;
        b=tarLBTtyIxG789Wi2HydCwg6vBxQtscctZ4kbdPpu4HrYKw4sgBRbA41gD4qHEObd4
         88a/ZCvSovQAiKsnOvOSPsw/ZbO714p45GXjNzJWWXYWN+A9ULxS8KGa3dJXhw3Zfdir
         S9F425i8sFvQwbHuUF5MsDC4SqZYT3ZgbJw/W9mS9W/OM8Qg3bzEV0fmjUUwroRbGn+N
         MS7o8gM3XdQs0QxR2q5UpL9uAgEbft9j8q6wWBjK9aRt/9J2Fd3TdJQYlhnwnRedluBh
         41YHOqOlIAPDWiT9k1NWRirADF6BXCUVX7nde1w8y719od33qhBMXjSp4QnSx92+2oja
         KvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394121; x=1733998921;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2qCz2oyAWXcySnvC/YTGdboyjGwCf8uvEh34M5NQ1w=;
        b=Rgk3gUmQHBisapoHt65Qrf+9LkeLH1hW/G6EYrdCkPpaOqoAoiTGIo94yujkZO/uMK
         wmr1FSL2Kga+fVK82YpTpU7jTuMqb2Vywzl3KBgA84BuoklB7/vmASOmN6qQJQViFCXf
         84lfueaFL5MGRTcR2IfMP3el2UKlP/RkV7j3GRxFQSZisK8tlQUyJt+RiORUx9OF2CKj
         RQqx2vhOwbMbhv1Qg9OtoHaF6AntTOvCvMm15XZGgMH03Xk5mP1CO87MBGA0nxm0qPWS
         5xhxxnAQtpBCCMhEjiXfa/Y8vHyql/JFDsaDy2ChmrGp9OzpBB81IwoSaGH8WXpwxZvl
         qCtw==
X-Forwarded-Encrypted: i=1; AJvYcCV4aTzm1T5xyqf9c4xD3HhQpR8GmB3cyRGYAptoT1cI1IbwZSBmu2PjfWx2ApI80Hd2Px9DDyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWeJF/srEI0/UZRIvYZulckYClPMTHD9FyQ2sLup30ldHxqgYI
	YFsUgC58feAhs5lUXff4kAch5YBRO3XJyVym58eJFXQ6pKmAddijjCkzIvfmE+c=
X-Gm-Gg: ASbGncsJvmNzIA6aXY7m4oCY+gdysHE3LiPctc63qKdaux58GYCAaxZY/Yc++dsCvOD
	qFCLmtINYEze5F3WocU0yEiBH6GJe5h7kUfKx2ynJN91PxhnCTQ2DF66ds+niVKSGbE+Xt++0RP
	mXjHw3x9yRvrLZc1Hazuj2PxdRY9d5bF9r20grqjOBzbyKJFpI9gAKJFd8Bk5e2orOfsCqdvQeg
	AaY4xRX+wJfe/PLVH58L9j2QP8mU3uHpxPS310D3DF2HQnLi+ERIKtpqa2Er4JK9YP/sL1+FjJ9
	Xmp3We8iQViXbqA8ErSogCNb9VD6+tYWOA==
X-Google-Smtp-Source: AGHT+IGIzS6w8nmzLwTehZGRCWLb5o+CLPa7VmxDEuLmOqo4b1mzG0cAAJu2wok4wnlPx8fiTWLtkA==
X-Received: by 2002:a17:906:3d31:b0:aa5:41b2:e23e with SMTP id a640c23a62f3a-aa5f7da9717mr766598566b.30.1733394120780;
        Thu, 05 Dec 2024 02:22:00 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62608f57fsm71606166b.146.2024.12.05.02.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:22:00 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Dec 2024 10:22:00 +0000
Subject: [PATCH v4] phy: exynos5-usbdrd: gs101: ensure power is gated to SS
 phy in phy_exit()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-gs101-usb-phy-fix-v4-1-0278809fb810@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMd+UWcC/x2MQQqAMAzAviI9W9iqA/Ur4mFq3XpRWVEU8e8Oj
 wkkDygnYYWueCDxKSrbmqEuC5iiXwOjzJmBDNWWjMOg1lg8dMQ93rjIhTQ513hvqpY85G5PnPX
 /7If3/QBAd16DYwAAAA==
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, kernel-team@android.com, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

We currently don't gate the power to the SS phy in phy_exit().

Shuffle the code slightly to ensure the power is gated to the SS phy as
well.

Fixes: 32267c29bc7d ("phy: exynos5-usbdrd: support Exynos USBDRD 3.1 combo phy (HS & SS)")
CC: stable@vger.kernel.org # 6.11+
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v4:
- separate this patch out from original series
- Link to v3: https://lore.kernel.org/all/20241205-gs101-phy-lanes-orientation-phy-v3-5-32f721bed219@linaro.org/

Changes in v3:
- none
- Link to v2: https://lore.kernel.org/all/20241203-gs101-phy-lanes-orientation-phy-v2-5-40dcf1b7670d@linaro.org/

Changes in v2:
- add cc-stable and fixes tags to power gating patch (Krzysztof)
- Link to v1: https://lore.kernel.org/all/20241127-gs101-phy-lanes-orientation-phy-v1-6-1b7fce24960b@linaro.org/
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index c421b495eb0f..e4699d4e8075 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1296,14 +1296,17 @@ static int exynos5_usbdrd_gs101_phy_exit(struct phy *phy)
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 	int ret;
 
+	if (inst->phy_cfg->id == EXYNOS5_DRDPHY_UTMI) {
+		ret = exynos850_usbdrd_phy_exit(phy);
+		if (ret)
+			return ret;
+	}
+
+	exynos5_usbdrd_phy_isol(inst, true);
+
 	if (inst->phy_cfg->id != EXYNOS5_DRDPHY_UTMI)
 		return 0;
 
-	ret = exynos850_usbdrd_phy_exit(phy);
-	if (ret)
-		return ret;
-
-	exynos5_usbdrd_phy_isol(inst, true);
 	return regulator_bulk_disable(phy_drd->drv_data->n_regulators,
 				      phy_drd->regulators);
 }

---
base-commit: c245a7a79602ccbee780c004c1e4abcda66aec32
change-id: 20241205-gs101-usb-phy-fix-2c558aa0392a

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>



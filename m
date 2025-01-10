Return-Path: <stable+bounces-108202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B78AEA094E1
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 16:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AE73A6AA5
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99FF211466;
	Fri, 10 Jan 2025 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W14AQlqF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29FB210F7A;
	Fri, 10 Jan 2025 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522346; cv=none; b=YMwP6TNUGsMOwoKcvQPZrgApSBaUVFVeWrxzrTBy+aMvL6CA/vj1DlLGha4U7geCWCym2/YMOGf0XyIt8K/bE7V4/Qd5mNOGmCjQf7g0JqcJg7bEzAWG8op0NnUaSJu8sGTsDeeyQwHYrAALzc4NnhLk6tPi+M6mP5iGOK+tJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522346; c=relaxed/simple;
	bh=GdxQAAhkvYNc45ogZEOTdokhwj27OmZxfHC7bNT6WS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lt84ipP5xY+6tU5+GjNRrLdNoV1PdVUP8MLqTdGVUF5057c8EgsP3eQB8jwgTg/7MVmsf9r5kUUtXiPIuxgBF50lD3WI/c1tJO0puzclSf3v1xWjO4FTg067ZU55Zd1R7jZvnQSWfLQhBGqd7lV0tfSejuR7KK6oEwwa+ZpcwP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W14AQlqF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43623f0c574so16516995e9.2;
        Fri, 10 Jan 2025 07:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736522343; x=1737127143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5aEpMmoZZCQQPaRUNn2M/cjTXlmafGJ+ljwOWiSLUI=;
        b=W14AQlqF+3O9P4HZT06GxD2w9nRuLl+03Uqxw7fUQDZeUwKY0/psJeZyEVaGUA9+b1
         IjH1fWOL+UHwatF0gPvD1HJhktHU3ozWcrQ95Q8Kb9pTi3lAJJoqLenvkDg7lhu/l7mG
         6u/c2uplmVi6GVl/jdTKu4zg6GB6OlPBqhm0RTK3tm2eQs1lFPYwkj9z6D8+zlWGeHj2
         Gg5xvBID3cpnSJrFglWM7oOZB94e+sXYabsuh8g9pfVqnGsutp5J/IQHtd3yHp/bPPkw
         nPsw7Q26gLfMU58GaFNU2pAFBMSvHpl2c4Aal/wL3CNHJLBRRcxHjbYoI/HYyMs+Vg1O
         x3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736522343; x=1737127143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5aEpMmoZZCQQPaRUNn2M/cjTXlmafGJ+ljwOWiSLUI=;
        b=rMkiPDbHaJGZRgqa8W+vitqbxsuxXYmpc672gaQWDZTZGbxBY9M+RP24YDLNjV1zMy
         /jRYKCEHn/1PNJpZBNaf69XDK643pTBYbITZPJnY3Puljisi5HvHMrMvDZMhAwGR3uW1
         GsXU+STTz2zcsc39c9JSLD9K6N3WiRa5lftpXH+oEVrXLThzlgwPwT/k5ua5PoAyk5s2
         Ha2lShza6U13HvpdwF0wdH28byM6DKF0w6OnZce1eLC0UaqIougGJyBhqyXIEKoK+rMO
         vOU4+bIG75Cpwi8Fh65jGC2KfYWTBeajLuxrPM2vpmmsuTU1+B5X9jkxin1x/b3vR8/9
         E9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVKVOHWaEyWTGERWUwksmvUEWbHoD+xOjv4lHjYePJ/Dy4TAUjACUrjpV6Bp/ycw9Net3HudYH0VHdOXY=@vger.kernel.org, AJvYcCX5+KZ7jq8EGPy6tWM41yfxcp8a72dQ+2uJj5ravZJ9HFN5shb5+c1HBzS9iB177xEQdUaFz4Vh@vger.kernel.org
X-Gm-Message-State: AOJu0YwgSauNUqytED1XsXHEuKuR38yUumk2wYWwE/Ont2AT43wypnME
	cKbnuEOgp7Gidpi2v0xcoY8dgUYePdGFrTbvaufCADEffa0iGtwj
X-Gm-Gg: ASbGnctUjvpuq26U992mvMeEd4unQ/dTAUrDTuIcHAx7JoFijHy4L2y28hI1Q+/EsHA
	vdrfTxa+YrbuVxLCw1d2vhkJHJRr3lzefgSQx4hxxAlzLh4mNhBgFeyd22rCw5dT5qgtnnCGtUP
	HIRaqWKIqZorhpDINLEZDwAzPDtEnjBjplUExgstOEGtxaOpa4s0G/ZdWCDnmoIP31CJWyoN1pK
	Ueelcot6CKcq0IqaMD5KiFmUKaXz0xjOXA0dy7WzVZJU+4FpGms3y9+8uPUQh3j8HgIWDem
X-Google-Smtp-Source: AGHT+IECfAJ2WoCuNj7wvzCw79nESfWsenN47zMVWMkB4VRz8D5aWBaZsf1e+N3uhc6SbLU9mvw4vw==
X-Received: by 2002:a05:600c:1e17:b0:434:9d62:aa23 with SMTP id 5b1f17b1804b1-436e26dda97mr99240525e9.20.1736522343081;
        Fri, 10 Jan 2025 07:19:03 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:d0fc:3598:a372:ece6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e6249csm54511425e9.38.2025.01.10.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:19:02 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	max.krummenacher@toradex.com,
	francesco.dolcini@toradex.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6
Date: Fri, 10 Jan 2025 16:18:29 +0100
Message-ID: <20250110151846.214234-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The current solution for powering off the Apalis iMX6 is not functioning
as intended. To resolve this, it is necessary to power off the
vgen2_reg, which will also set the POWER_ENABLE_MOCI signal to a low
state. This ensures the carrier board is properly informed to initiate
its power-off sequence.

The new solution uses the regulator-poweroff driver, which will power
off the regulator during a system shutdown.

CC: stable@vger.kernel.org
Fixes: 4eb56e26f92e ("ARM: dts: imx6q-apalis: Command pmic to standby for poweroff")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
index 1c72da417011..614b65821995 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
@@ -108,6 +108,11 @@ lvds_panel_in: endpoint {
 		};
 	};
 
+	poweroff {
+		compatible = "regulator-poweroff";
+		cpu-supply = <&vgen2_reg>;
+	};
+
 	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
 		regulator-always-on;
@@ -236,10 +241,6 @@ &can2 {
 	status = "disabled";
 };
 
-&clks {
-	fsl,pmic-stby-poweroff;
-};
-
 /* Apalis SPI1 */
 &ecspi1 {
 	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
@@ -527,7 +528,6 @@ &i2c2 {
 
 	pmic: pmic@8 {
 		compatible = "fsl,pfuze100";
-		fsl,pmic-stby-poweroff;
 		reg = <0x08>;
 
 		regulators {
-- 
2.45.2



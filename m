Return-Path: <stable+bounces-127033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD903A7601A
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 09:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 133677A2F6E
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 07:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0623418CBE1;
	Mon, 31 Mar 2025 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lilYTrAL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8AB4A35
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406442; cv=none; b=vF2p+V1+odt18g/aDr1dNPMGhRHtBgZJ8FCVTtAdoaCqmZnE9pJhRQj70Sz+ZLW31D1qSkewNLD1TPbwQ0JK6T/MdBEoYjITAMJkI7e+j+la9/PUE32/xxsxVPE+m9gVTMfkm3/C+qo0ag5dT+I2qqTpOYmB//+9JBH3YuZhjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406442; c=relaxed/simple;
	bh=H3noSuLRqppGXZZpybzZ0kmfA35iwqBGQqevQBzJLuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idH5NXJN6HVizavif3xFmMG29QPF+6+RnOzTj3i+aZN/QyFXXecgSZLrIaPlgpC8Nzw4uMWUV1C1RBXazwHyGaM/+uvuUu69NLZMLaZIsjYNfqZ1GD9NtiWb7iPoQLOzAqysM+hYXsGxM3keRoj9fUA8Nnvyd5RSjPDLLdMQ2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lilYTrAL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so28566475e9.1
        for <stable@vger.kernel.org>; Mon, 31 Mar 2025 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743406439; x=1744011239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsJn1/lD61gg9beTFeKU1ta88fegvilMlDEHUW9v1p4=;
        b=lilYTrALeLMdNPK3s7mf6877zZ+932ra7hg/S9n1M2Jz0RLDW9o4jmrFAT5WIqrmuL
         +mpOrgXqCV/eTgY/Cbx6Y5gcialeZwzeHQebshO7E3csNfnxMECIL92zaZrF5Ez7XEAo
         owdVSoimxS/RU90HyUBm4joSbUBBlsxhOiTUzzEIFerx0oDl4bb43njfJfLobHQrsNtj
         oKA83PHfQHkjXIu6Ii1ITpfSTOiRm6mSbcBgvO4FQLX/1wj4oQ2jxCEFRvOph6GucYrq
         N5QUr5aCMrKTEK9W3Niru9WYrEJc6i8q0pD0s3IXNSh3isPSPlUPz81y7N4hfB80Jztb
         jZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743406439; x=1744011239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsJn1/lD61gg9beTFeKU1ta88fegvilMlDEHUW9v1p4=;
        b=nOSop5ffLSm9S8XGWQ5fJEaGcMTpnaY8zb4aciNJBBlu21B3jkbyTbWaWpkPVm/de0
         RBbAsmO/NSAvb+Ifwbeg5gC+MawqYGDQD4xJZNYQcFFdVc86F/qqbq0ZmXm92QeoYH7G
         ZLC/2LEe9WFR+46XAn+AbfjAFt1e0iOc/dhmyDOjFjJ1sUA+Oa2jLb0j6xuAlBOvw5pu
         +zfJQAT2L9hIMKxWdqze1T8IruWaxmEJKbzrhWo1Pq5YWkoHjr1BQZK3j/8Zw+A0TXAv
         JJ2A3rQlLBdGGTJwOfeJ52eU0xKag7L9/b+GxnUtu220loYbHaYZ0/aVexiZXu882Z9n
         LcoQ==
X-Gm-Message-State: AOJu0YzudHUiq9l85frRiqpCMFEYUal93nvZIErcoYl6KPJ+/A6ZSTau
	dIbX53p26JvKBhuJZNrVKjs8pOZBjEY1pHdz0zX+E4ya1CKm/rJBTQAATg==
X-Gm-Gg: ASbGnctH9qCGuXYIt8DS8fw6zNGezHMwjC3BI8TJ1fieJtcmhp5K5nhQCotUxK/Cl88
	+oWDDGLkYRGzbY1aZqF3kNFzItRwRTqLuQFey4wGJycHhbrtKKxyA280/Jpl5NIJkV8NkZkNLSG
	aXDAjX9Qy5NrD/XqVvhM60G4raFhECfLugBF7FtlI27I0/Nh9giGEtyo5xOeP/s8AWBKTrtTUX1
	7u91t5A4av1ZGmcZo/HPkrIbVdKap+Gz6V3FtYPAyclfWPrbzZ7+J/hisASlZWm/eb+KeBEtZSN
	kqAZJBoQ1xj0808SmtWEecfit8uMQL4KNbD3/VrQa8PBnVXaaQ==
X-Google-Smtp-Source: AGHT+IECboQaK8Bhzd6eaiQvXHaewH9bnkMgpfTYpTszjT6ipjOxd/ilDOc8eA6JE626BeJ9igjnBQ==
X-Received: by 2002:a05:600c:1d9b:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-43e9dea091amr17654215e9.30.1743406438553;
        Mon, 31 Mar 2025 00:33:58 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:8643:8378:653c:f3e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8ff02e84sm112630115e9.32.2025.03.31.00.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 00:33:58 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: stable@vger.kernel.org
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 6.1.y] ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6
Date: Mon, 31 Mar 2025 09:33:24 +0200
Message-ID: <20250331073350.12287-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2025032458-hammock-twitter-2596@gregkh>
References: <2025032458-hammock-twitter-2596@gregkh>
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

Cc: <stable@vger.kernel.org>
Fixes: 4eb56e26f92e ("ARM: dts: imx6q-apalis: Command pmic to standby for poweroff")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
(cherry picked from commit 83964a29379cb08929a39172780a4c2992bc7c93)
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 7c17b91f09655..dc170a68c42f6 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -101,6 +101,11 @@ lvds_panel_in: endpoint {
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
@@ -220,10 +225,6 @@ &can2 {
 	status = "disabled";
 };
 
-&clks {
-	fsl,pmic-stby-poweroff;
-};
-
 /* Apalis SPI1 */
 &ecspi1 {
 	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
@@ -511,7 +512,6 @@ &i2c2 {
 
 	pmic: pmic@8 {
 		compatible = "fsl,pfuze100";
-		fsl,pmic-stby-poweroff;
 		reg = <0x08>;
 
 		regulators {
-- 
2.45.2



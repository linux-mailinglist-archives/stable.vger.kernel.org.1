Return-Path: <stable+bounces-139529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C10AA7F7E
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 10:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E64465D1D
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA31BD9C8;
	Sat,  3 May 2025 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3RmIGQe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877391B85CA;
	Sat,  3 May 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746261892; cv=none; b=Faw2rfpDdhbUAHfuUjEyRfv/7qSdXH5vZ/6H0+LOzILYd5BqbnrPssYcODfWiQrlRL+N2W+yYDgKPmcXtvHii5X7uTf4gzN3FSREh/3+AnBj6Y5KIpx2P1WrZnHJX/mwNhdRE6/i7ROE7GXX1YBI9QgNIW6+8EXzVYKMxkg8lzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746261892; c=relaxed/simple;
	bh=lIZ+ri7usr2lHtPUFh4PKTcvWPnZvdlWXsHumh6W270=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y82uQAIP/PXqPaFMw0VAChyW0krEkCvzVke2bW+fKncLixc4YT6CCY5h1cpG2g01Yd7ZEUkzgGjVPoYcXgQJJ9VEHeLIlWQ16tDX4n/5x0AVSpfnCjfMCGK6GjXXSCngPquY7cje+2lWBSh4Lq7a9Xt0ypqU8iKZu5Upi2QdGzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3RmIGQe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so14305655e9.0;
        Sat, 03 May 2025 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746261889; x=1746866689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FIyhDFD2ShaUnQ5aPpqXckNI3ybWXEGGWfQs3+aXXb8=;
        b=V3RmIGQecdsVH7WObmCovdURJeObVr3gHwHXMeJZQGFQ6TtakhTn52eT2k9P0iFA2R
         yWppYkgmwCpDSOO3eFGHgUDkaeSsU1YynemoxlGq2jqugRlnZEhtIYrY0Z4JQ5R3z/NQ
         PV19+EvrDxKXr26zrq+4Y1kPG6Kg/lX+FLhlADo0NNaAaMlXk4sgvdVhdpN1W7FPT2JT
         1aTriwIsV3jtU5A9h0tnPF27Sh5LnmYDJP/iN3QL4fmjkYHHcefwWVCv3gTADYs0yyqo
         bdPxEwnl1Ed1n6oZI7GTY8DLDMYAF8So8mzH/RAHXCj1d7+cegIHKYPvwKA+5TmCUR7y
         4BKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746261889; x=1746866689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIyhDFD2ShaUnQ5aPpqXckNI3ybWXEGGWfQs3+aXXb8=;
        b=je5Ap3I5FRJ+yQHDkHuf0Kg7E3jZntLjh2GIVIYkBW5KDrfqYsfX840bYt4fLcVG+M
         AuxMlRGPt76RyJ/m1ePIWtMio5fRIxHRZpN6pNTsu9J7oC0CW/19BwufbPjKLMPl+PRU
         2KtU6AUImU9JYX0M6T5AhY3zh35GbUZjpfnkE5YkYV15qru2CBXqXrYVmZBDKXWVNUaW
         2Y4ejFEY2rsZLfSo3V5j0rjv/68UcCTGwvOwoWOWBhhdzVF/iX++QtlIkQ0Qo2/W4tIV
         yGdC7Y2mEp8SrfGyZBVQYx8OBCfZblzwalb1wCYEoiEnEHyC9AZo6l9IVlrsRE2s/RZi
         D7Ug==
X-Forwarded-Encrypted: i=1; AJvYcCU7IdPv4x+upgO2ISwUhXXVLroHwbZN0wMb30gZW5pYNJeG2UvPiFiYGLFwPkXjt8Y3gfh31hfH4KvGyMcK@vger.kernel.org, AJvYcCVtCl0+IdG1/dYYwdf7yWRPp5fz+IoK/nhwQao4bQO6mGWHMcajWV+vJQzfI2TEh9AhLm1FHSa2ZuhW@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjyJwT0m6sDRmne6iAtw4Q5WrAkSMsMGdFCbR9H11LbbG7C6d
	V9qibKJI2sUvrkuIeg7R8JPr0figdFIK0hm6ksfuFxws5j2i1DqDkgVxmQ==
X-Gm-Gg: ASbGncvLPtAqDQ1Blcq5m/ya6YhYvltXtKwFElB8iHEEm2v69rL+iBgLxNO6XAVbHb5
	djD/WNTQ7x4UOsJIOVX4kdu2376O1y9MPIJhzFQ2x50ndkLhUYqTidkFXEzAO9VZnPO9kv/nmWc
	4URaJgpOqKki7So/kpWPaH15MwU77Wwr/dEJ6eOYm1LTQgwlFwSbqZM7RImGEfF759SV+pQdHwZ
	k4CaBXptoeoVrzAGceT2/U7PAyMo/Bx3cIL0n/O89rKYJVdAwjrEmFjSlbzLIH47aiPzKPjjWKq
	EeuyxoFhwTLwSXE9XChg9IpkrwCx/Af4C8XWh+E6nsa+6A==
X-Google-Smtp-Source: AGHT+IGHW91E9x7iKdlAm0GzfPNQ5njfrFDGWCgFzsQFKF/kcqFtWAJemLt2n3WbhqAF87oSE1YCNw==
X-Received: by 2002:a05:600c:8210:b0:440:94a2:95b8 with SMTP id 5b1f17b1804b1-441c48dc3edmr3167525e9.16.1746261888396;
        Sat, 03 May 2025 01:44:48 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2ad78f6sm115007475e9.2.2025.05.03.01.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 01:44:47 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Emanuel Strobel <emanuel.strobel@yahoo.com>
Subject: [PATCH] arm64: dts: amlogic: dreambox: fix missing clkc_audio node
Date: Sat,  3 May 2025 08:44:43 +0000
Message-Id: <20250503084443.3704866-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the clkc_audio node to fix audio support on Dreambox One/Two.

Fixes: 83a6f4c62cb1 ("arm64: dts: meson: add initial support for Dreambox One/Two")
CC: <stable@vger.kernel.org>
Suggested-by: Emanuel Strobel <emanuel.strobel@yahoo.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi
index de35fa2d7a6d..8e3e3354ed67 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi
@@ -116,6 +116,10 @@ &arb {
 	status = "okay";
 };
 
+&clkc_audio {
+	status = "okay";
+};
+
 &frddr_a {
 	status = "okay";
 };
-- 
2.34.1



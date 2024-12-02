Return-Path: <stable+bounces-95966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29069DFEDE
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C406161CCA
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36401FC117;
	Mon,  2 Dec 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg+I9iMo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC89F1FBC84;
	Mon,  2 Dec 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135279; cv=none; b=uViRsU4pxt67QGLS4eKCRRw346l4gNDNuJo/xmSmJfdUhKcIIitFCqWcd5HZFkNjHYpLZezeP0eF1+455ZyKWfbPhRVj6s0BXAkvtf13jBVOEePEm6rSN2TQ2VC/08bHbTZ8x7yjewaPQyQiLPOVscFN+odoOl5uayBkis7xEjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135279; c=relaxed/simple;
	bh=BkUn3FMsNhDblXI75Naua904u4McBVaZYep6S0B5egI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EpjT8RZsbU3tT7X4Qch8PCiPSbBLjscsI8fWnJQtzFA1ScwKf2xfHi7k66OrdEfUipCvoqORo+71s2pliPaNQ0q1MqTFHwQA1PGpqVJUJaDSzgteE0fTrTzyG3oPxbpzILpvtLbr7qQsT1kwln1DxYi2ByenaveldI+xz1DvEjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gg+I9iMo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so37339215e9.0;
        Mon, 02 Dec 2024 02:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733135276; x=1733740076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QALA3vJFqR8NKYOn5MTUFDxKO0FcS0aiXq3k1iQUdts=;
        b=Gg+I9iMoRFTxVkZ9GQSixIIBCBlULGEpYeHRmhpA80KA9K+FtrE+7Qz+2eKZ5uROTC
         yli3T8JFe5Gpn3gI792S83hlsfTlV4Wk5bdx8AK1S9opPiyInAkMpx6HDF2CMeZTJD/R
         R98LSPla4EojhLmbTj5w0RGgs60FDLrIQAhE8N6hWo/YLvNrRnJ8ZXv7DXrMWtK/r+t4
         3ISsn9rDjdQtVa6TBB/QFuiQNKYqe1Lhg4pXyX5pxKlt3vrPe7s0RW75vl5E8POP2izR
         e0GI5Y/ofelR61nUHLyJDpzZo2o/BgbzxxL5qRkzKXlWr8DjKiMT40fFgDlpcKDKNGmd
         6VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733135276; x=1733740076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QALA3vJFqR8NKYOn5MTUFDxKO0FcS0aiXq3k1iQUdts=;
        b=PR/vYqnYRCjw8wq+4GHjr9iXM00fiDZx2sMnNOKu/2JPBgaHCVFeWKv6N42wn0s7d8
         0pVj28RIuc3LXRyK9k/avw0earCiuhUfVtMXFUDJjE509aJM3ardzEZ3lTL65frrJdkk
         0IDoHipjjuUhnDOT8dnYuLwMrE/QUtClChUg+vQjOJpaTyNjo5+18Rhq98QvaWE6eiOC
         UZSyDLcDuiKFO98FXow75dQLV+i9M+gHNq2Q+uaWyOSOLusGJgaOvh1qp7e8N/OJQrG1
         DFZepS4OB6Tdyj30sTVq//8gJLv+xew0NENqoOoaABqHldoPRDIVe3K/pHhPzVo7Ae0u
         0UEg==
X-Forwarded-Encrypted: i=1; AJvYcCWuSNQCE0/g1Nd22N4ob5vKgUBORCKbPDk1wJzhSD2IiA54/MKHIfkyA40JcoOhcUP1RHS95JNwdU3x5mZ3@vger.kernel.org, AJvYcCX0iJY6Zrin0vQPM87BijK1GUU3e+FrZ691aGVuULa3+0a0WA9+HSPYDWa4+hAyz1P87yeRpjWoq8LY@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCP44B3dWDvbd2HCZZRzlPspOY73YsCULs4jbVgRj2wthzx7S
	t244ieW7NzmWZJlGMMKsXKg4JEdLdsc6c1IoTUtjb+ujAcinUD7P
X-Gm-Gg: ASbGncsklh85smWXp3e3YcBfIxoPrOPzcbJXMxYZ+BiaCR5I7DfFHBxftJE/BGi9w+C
	qfCLESTBWlw5HyMLWSVLjcb9o2d56HOuqw+O/qW3n7LHpo0DPXye5O8aPOcJv9KzSPfgCql6JTw
	kg+0PTi1p5JifK4P9VcTU5O2SGnBX5NbQvuczTu6WJikLM3owG7+7q1Vdn6xwkRE8FZYt03mKBU
	VMpYzazVnxohiDDVf/07hB46ELG/O3DxLnwGVOcfkG4uel3paHNECUxXTSayIM4DKDjzFwo3w2p
	j6MYSIi2H72zheUxVtA=
X-Google-Smtp-Source: AGHT+IEtcv376POJl9E2bAxspbhqve3Y2tJ7pgMGWk2qvbJcgbnauunS2AuXTdMYxck6zEO85ZI3Tg==
X-Received: by 2002:a05:6000:4610:b0:385:df43:2179 with SMTP id ffacd0b85a97d-385df432337mr10679245f8f.17.1733135275802;
        Mon, 02 Dec 2024 02:27:55 -0800 (PST)
Received: from opti3050-1.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385eeb999f4sm3781643f8f.109.2024.12.02.02.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:27:55 -0800 (PST)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Iskander Amara <iskander.amara@theobroma-systems.com>,
	Sasha Levin <sashal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>,
	Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: increase gmac rx_delay to 0x11 on rk3399-puma
Date: Mon,  2 Dec 2024 11:25:44 +0100
Message-Id: <20241202102543.204154-1-jakob.unterwurzacher@cherry.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During mass manufacturing, we noticed the mmc_rx_crc_error counter,
as reported by "ethtool -S eth0 | grep mmc_rx_crc_error" to increase
above zero during nuttcp speedtests.

Cycling through the rx_delay range on two boards shows that there is a
large "good" region from 0x11 to 0x35 (see below for details).

This commit increases rx_delay to 0x11, which is the smallest
possible change that fixes the issue we are seeing on the KSZ9031 PHY.
This also matches what most other rk3399 boards do.

Tests for Puma PCBA S/N TT0069903:

	rx_delay mmc_rx_crc_error
	-------- ----------------
	0x09 (dhcp broken)
	0x10 897
	0x11 0
	0x20 0
	0x30 0
	0x35 0
	0x3a 745
	0x3b 11375
	0x3c 36680
	0x40 (dhcp broken)
	0x7f (dhcp broken)

Tests for Puma PCBA S/N TT0157733:

	rx_delay mmc_rx_crc_error
	-------- ----------------
	0x10 59
	0x11 0
	0x35 0

Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")
Cc: <stable@vger.kernel.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
v2: cc stable, add "Fixes:", add omitted "there" to commit msg,
    add Reviewed-by.

 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 9efcdce0f593..13d0c511046b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -181,7 +181,7 @@ &gmac {
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
 	tx_delay = <0x10>;
-	rx_delay = <0x10>;
+	rx_delay = <0x11>;
 	status = "okay";
 };
 
-- 
2.39.5



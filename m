Return-Path: <stable+bounces-64693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F953942526
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 05:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4E8282272
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 03:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC701AAD7;
	Wed, 31 Jul 2024 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B6T3zytL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9D18030
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722397468; cv=none; b=mbu52AnzBcRVTnxdbMgh4cc0a8zNi5a5jKXxtcOHNtmFOONvmer/ksdIggUWdlcsZEpvFtrThTnFbvSTLFu3wUQhf2UkPzCr7MseWU0fpUhJKdHPlYChK3k6qqGCsRCxZDxV5BoyyZTrdhxRUXRdN4Sc1CxeGEyWW2i2P/1pOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722397468; c=relaxed/simple;
	bh=4Z3xOpbbzckA9G2MkMEHJZLQkoZ8bGPOZvpOB4n0Fv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwYnvDXTjX2Vz8uj9i9gJ8tsHvze/3Rw2EgMLGw73SNCbMl4zc6PIkdXpWWJom9X5Hu6IPdSyS/L+ZME40A7QzX8jSUFABfDBMy0YI5uL5ZC96vUmIzTNce/qYRuGjjd1iQ4ifUiXcNusrj5lqGWN7dRRzsWhak6Pv83VYpZoVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B6T3zytL; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d9e13ef8edso3525591b6e.2
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 20:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722397466; x=1723002266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UbdYL0//iy1qTkoAHNN3QDl4lYvN+Ijx1oBz/ie38k=;
        b=B6T3zytLPKCejnnDaOTbppme/xdCccYZ+aCongvIea2XFDTsM8vOlXVx7PVUte5x+j
         R/CYoAAMDb9LAjpOzDXkqFsC1kkPIy0s5fEYL158miFH3JV2PtwiYD47v+8/GCzX//0f
         dql3dA21eQPtQvg0snly09/dGb81fEU6Fy5l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722397466; x=1723002266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UbdYL0//iy1qTkoAHNN3QDl4lYvN+Ijx1oBz/ie38k=;
        b=KDzKLH6b+B4sM8K23gV1YVKLyJ5KG+w/FcamhayQd3UnlSpUF52aLD+0xomeBeATpv
         dre5qHiw0P5HQoyRUpYfeVlQDnUxBNptsgGm/huHp9dKFR76FcJSETW+mN5PV/LDIKFH
         SOI9GMFzfIzoA3Kikkr0XjRjZthyRkTnVY3zofFDHsBBR+iOOq3nxYva2LPDKHRnsYNK
         z8SaOtcTjUGmKHTG05ONHRkFBc6hwJ5KJfduL8dsGSi1te9t0KYxe72UEw9+4aUbp4QO
         yQ4+xDb0uhhzwXN/nz7FzvNBd2QEgJeG66OXfsbrLwZ49/DF5+rSNh4jxx8zABDueDvq
         ro+A==
X-Forwarded-Encrypted: i=1; AJvYcCXf1zSBoFUOZ87UOUdyNc9P2zSyKsis2R/QD4vsUnP3DTpQt7+AdZ1XyURChs4Xiiu4alRn81wpBO410993sOg+XRF8TZr7
X-Gm-Message-State: AOJu0YwxOsBAkU9cpw6bptHYUvwK79lajr/EmtbIx8y7sbVXPuG+lQwP
	6hZ2K52z8Wc8GvrQbmZtqyrM57evUVte+ocuYI7/IxkqlEDzk8UaBn477vc9LQ==
X-Google-Smtp-Source: AGHT+IEivlqEbXkttxrz/Rxzu9Cp9uzqYmDsPqNMDSXXzrPkDIW0pOckbHR0f0HuMPjBNI+AfizI8A==
X-Received: by 2002:a05:6870:6120:b0:261:1fdc:4945 with SMTP id 586e51a60fabf-267d4d94a43mr16322317fac.26.1722397466358;
        Tue, 30 Jul 2024 20:44:26 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1cfb:e012:babc:3f68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead81230bsm9093008b3a.120.2024.07.30.20.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 20:44:25 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled
Date: Wed, 31 Jul 2024 11:44:08 +0800
Message-ID: <20240731034411.371178-2-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240731034411.371178-1-wenst@chromium.org>
References: <20240731034411.371178-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

USB 3.0 on xhci1 is not used, as the controller shares the same PHY as
pcie1. The latter is enabled to support the M.2 PCIe WLAN card on this
design.

Mark USB 3.0 as disabled on this controller using the
"mediatek,u3p-dis-msk" property.

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
Fixes: b6267a396e1c ("arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index fe5400e17b0f..d3a52acbe48a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1404,6 +1404,7 @@ &xhci1 {
 	rx-fifo-depth = <3072>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
+	mediatek,u3p-dis-msk = <1>;
 };
 
 &xhci2 {
-- 
2.46.0.rc1.232.g9752f9e123-goog



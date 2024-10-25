Return-Path: <stable+bounces-88132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191869AFBA3
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 09:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B638B23E87
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 07:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79BF1C4A12;
	Fri, 25 Oct 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dvxmrz1D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940BC1C3025
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843001; cv=none; b=H/VXVDsSL7be8xVvEg78DgXMT08pEtYQG615MM20sNxZAnWzvOHpfCw/Xnu4+QGkDNpFCxBww2ao2tL4qBkJchj8uaGId+fqN7lOKYAQqxBDVevHWAFv7zNFv00xAerXGr28XXM/GTwO5N2bT6tLE/X61cKQztHJ5HGKmIwmEaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843001; c=relaxed/simple;
	bh=laKWV2RpmCyH/YcI4Xx9fpf8SVY0NnUQ2fFtJ730LB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Js05DwOA53d/Z9rx3AiCyp8DdlgJmC9/FGtZRs5W8YPKNPA4lyQ5xVw7lgdsXUEmXqhpKhhm9WyjEPUWNm7jYcfxFm/nInRg9WQ/98NfHId4tvnGolTunA3XGBoWhlJDaLXCXCEJ6qinxTaAFUzn0ijc6p6zKVUWgUXdc3/6ZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dvxmrz1D; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso1273194a91.0
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729842999; x=1730447799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6laKqa55/o0629X+75d0Pfs5pGBVZ/MLyO3PoLeX31M=;
        b=dvxmrz1DcRSWsRRbeTTRXklv/9hY17IJIzYhYks7G69GS3jUQUR5Wnz83qjrzMl4Pu
         fe8hrGfy8A/xSEXoToG4Lju2L7tPaHlm75oP3Rujwd/pA2JDI0R/WKEVQukMxOltZzMQ
         bZ/py5aDMhadgC/I+6qh6Z4cW2T8sexKecjSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729842999; x=1730447799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6laKqa55/o0629X+75d0Pfs5pGBVZ/MLyO3PoLeX31M=;
        b=YFicoD7bqs4zDBSJGP8cfSPXhkKSl8asZ64Ka1ng0DjUq0jbj2WdPOYrZlXwga76I3
         gfpFXMYoPBcVWnyyHPIhlnTdsob/Zi7Eo21nLxQVJ/kHS47w+pK/eoJ1dfmblH3CVHYH
         uvRHScUbgbUImsndpAmmeFADGDwD15aWTEPyQUI+z/MxxsKoAKmkf7wZujcRgeMHDYq9
         kau8b7/7kJt8Skdue1mNV4y2XszZZPjsOri0v7sQrCyFAQ6yn1bm+5oSq8H9UQ7lRLNa
         GjSNAsg85e1tk9nBSs/pxFaFsDIP+5YbB2fjdOxgp2wrMsdJJvFZqXA0sRsrvf3qKKrK
         9PZg==
X-Forwarded-Encrypted: i=1; AJvYcCXCm8gPJ3rw4kY+YcZXimZWTWyvrTpvK1siauR7NhI27lnE+hzwhlrSx+0d6LXzPWxgj7LkuWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXEMgF5eQ26ARhd8B1Cc8PHeaKzTdh8ZqAMp2LXK5qRNwQmcM
	lgsR6z2myg84wi8rmIkzVtD6IA8CALfnAf5kVOUIx1QzccMqE/39aSKBHNv1dw==
X-Google-Smtp-Source: AGHT+IFmmKGI2cs990SRzNz65POmVSt+7jqG6ghbGRlWIcpYgMGvGVtY/qLmA8mHzd2tQ8d9uEfU1g==
X-Received: by 2002:a17:90b:3850:b0:2e2:d1a3:faf9 with SMTP id 98e67ed59e1d1-2e76b716566mr7196222a91.40.1729842998905;
        Fri, 25 Oct 2024 00:56:38 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d8f:752c:c7f1:3169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4c9c1bsm2797553a91.19.2024.10.25.00.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 00:56:38 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: mediatek: mt8183: Disable DPI display output by default
Date: Fri, 25 Oct 2024 15:56:27 +0800
Message-ID: <20241025075630.3917458-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 377548f05bd0905db52a1d50e5b328b9b4eb049d.

Most SoC dtsi files have the display output interfaces disabled by
default, and only enabled on boards that utilize them. The MT8183
has it backwards: the display outputs are left enabled by default,
and only disabled at the board level.

Reverse the situation for the DPI output so that it follows the
normal scheme. For ease of backporting the DSI output is handled
in a separate patch.

Fixes: 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183")
Fixes: 377548f05bd0 ("arm64: dts: mediatek: mt8183-kukui: Disable DPI display interface")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 5 -----
 arch/arm64/boot/dts/mediatek/mt8183.dtsi       | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 07ae3c8e897b..22924f61ec9e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -290,11 +290,6 @@ dsi_out: endpoint {
 	};
 };
 
-&dpi0 {
-	/* TODO Re-enable after DP to Type-C port muxing can be described */
-	status = "disabled";
-};
-
 &gic {
 	mediatek,broken-save-restore-fw;
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 1afeeb1155f5..8f31fc9050ec 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1845,6 +1845,7 @@ dpi0: dpi@14015000 {
 				 <&mmsys CLK_MM_DPI_MM>,
 				 <&apmixedsys CLK_APMIXED_TVDPLL>;
 			clock-names = "pixel", "engine", "pll";
+			status = "disabled";
 
 			port {
 				dpi_out: endpoint { };
-- 
2.47.0.163.g1226f6d8fa-goog



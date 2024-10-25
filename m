Return-Path: <stable+bounces-88133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D38AC9AFBA5
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 09:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A9C2843A4
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 07:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5C1C07F9;
	Fri, 25 Oct 2024 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YG39SEZn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB21C4622
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843003; cv=none; b=T7adsNBAkS23mkBIRgA2fKMA5Km5f+rBgitVXeNCu7cOClCISF93FT2SCAyrIoNYbASzo0slcgJpocYmK6hBBy104qaf6Pyq6zfuHn88DrCmpFGy1/2HwioQv50CDXQqJ8s01XaExq9BHldibJ9xB+nunznJKziKARfGfaKw+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843003; c=relaxed/simple;
	bh=O0ZPXfmEtbLq9bEA6uggS+2nZDv5E8meibf9NtJRtqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUcwQUA5iXEtqiAIA6mMA65IiuyvfCzCEZW1HKZgzJpcWLB4aip5q4oYKgadgQHTMTlUELhkmwTkkng2r/FVaqOryvnmiY+XkElhWEeFS/VJD6Ju+Eu3halON0ffFBAb7JeUCF7cUlaUSx/GHFu29A8v55GfzJinfEjrU+eVHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YG39SEZn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso1327855a91.3
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729843001; x=1730447801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ocz8O19Ri16sCIqDKqqWyBeGwEbvKhFKD3K8dqT+N6c=;
        b=YG39SEZnpMQIF3M4YRgXp63HeCypZAK9FCipr+g1ji2cvz9P5M1HL4kqAO42xRCNgJ
         vkoylHdnfcY9qwU38secXt8tc/uCUKW4KQJmoXh6XbH8GdxuljDYJOFxGlDZllexfZa9
         0tszhapU8agXfTdGIzw4TvSr/4t+MWPpwJTTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843001; x=1730447801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ocz8O19Ri16sCIqDKqqWyBeGwEbvKhFKD3K8dqT+N6c=;
        b=Mw7aLW4FCiUe34KDgAnoK+/27RW6DMU1jhNPSvBiOivMZBuzIkxn6Qvm9rhL7s0/PX
         z2+pvBjItVEYVCP2ou2Qx547tNZGkK31wla40+Emc+k2461r5WDujnrnJSR32H+a73yh
         p5VQFJAWlvnFBGJas8C/+S4tBjaLekvzKAH4DjAaGFJyiCfEm4QEC6BmswCUnLjsO5iw
         0bC7WyPk+mOR6wy66nCONrv2fWqY8iTkU0YueTOeu3xjam4ih4W/Lzcp4jDqcK/v9HDm
         V8dO8v5mf+gPZp7+yeeNmzDIDpPli/YV9zEzj106wqXWiMLmMbxG3zc2YMLGfWl6xhFQ
         P/2g==
X-Forwarded-Encrypted: i=1; AJvYcCXGYlFb1coGH0BkALZkvbh9+neEWiSp1Blqwx11SJnvZk53JVBACXMjaDhu3S5V5msJBTDwx1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx70i5MtX2o2hahvOlJ/x6PKnxcujCj7xNQrn4aEggqUTFpY0UU
	JkafsDYePHG0kRWldtkdGnyAqNTw6JfehAYIaGfEDuNQhn0VB0qVZHHf+MX7Eg==
X-Google-Smtp-Source: AGHT+IEhpzhZePgnGrlXh89W3IHK0viadpu28ous3jPT9MS8vhveF6ukqC0oYeARpOE5I3mtsl0sYA==
X-Received: by 2002:a17:90b:30f:b0:2e2:e82d:48cf with SMTP id 98e67ed59e1d1-2e77f4a274amr4863299a91.16.1729843000877;
        Fri, 25 Oct 2024 00:56:40 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d8f:752c:c7f1:3169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4c9c1bsm2797553a91.19.2024.10.25.00.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 00:56:40 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8183: Disable DSI display output by default
Date: Fri, 25 Oct 2024 15:56:28 +0800
Message-ID: <20241025075630.3917458-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241025075630.3917458-1-wenst@chromium.org>
References: <20241025075630.3917458-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most SoC dtsi files have the display output interfaces disabled by
default, and only enabled on boards that utilize them. The MT8183
has it backwards: the display outputs are left enabled by default,
and only disabled at the board level.

Reverse the situation for the DSI output so that it follows the
normal scheme. For ease of backporting the DPI output is handled
in a separate patch.

Fixes: 88ec840270e6 ("arm64: dts: mt8183: Add dsi node")
Fixes: 19b6403f1e2a ("arm64: dts: mt8183: add mt8183 pumpkin board")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts | 4 ----
 arch/arm64/boot/dts/mediatek/mt8183.dtsi        | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index 61a6f66914b8..dbdee604edab 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -522,10 +522,6 @@ &scp {
 	status = "okay";
 };
 
-&dsi0 {
-	status = "disabled";
-};
-
 &dpi0 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&dpi_func_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 8f31fc9050ec..c7008bb8a81d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1834,6 +1834,7 @@ dsi0: dsi@14014000 {
 			resets = <&mmsys MT8183_MMSYS_SW0_RST_B_DISP_DSI0>;
 			phys = <&mipi_tx0>;
 			phy-names = "dphy";
+			status = "disabled";
 		};
 
 		dpi0: dpi@14015000 {
-- 
2.47.0.163.g1226f6d8fa-goog



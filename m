Return-Path: <stable+bounces-69773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E059593A9
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 06:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89E7284F45
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 04:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F6F15DBB7;
	Wed, 21 Aug 2024 04:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IGXPgDQE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17B4206B
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 04:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724214536; cv=none; b=DxYneBi/4zkH2WvwJHMUZERBEgpJhNZzcuIxkYxM2TJ/uuIThaWOcUTcRDG/0S37oNNc3y+nCwiulPdKZw6cfUzmvKNXYcZW87JVaJWDyxd+Rz/e77VfsPWcMrsO1HaI8KOKNi7DKP3OrVJEk01s0+Q+kAbg7qVeYQEfNrDUPAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724214536; c=relaxed/simple;
	bh=sbYXK+0vPI8Bhkp+0jm/br7/Rhw0yjMsC3ImDA4sgyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/XdpuL8Ye9s86GAVYDOznnw7HTHGH+T58iKdGSjOF8wvun0jlrvTgWql8rFXu/rZmedrteUnQn6Wly44OVbUXgLQc+Cx9sbcyutWNawvdq2/7xfqIMiHJ+3rrxGY4g+LrrVSv8wqkJZXXeQ534YgdYVAaoaP8UFR5h4Zcy3dgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IGXPgDQE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20219a0fe4dso34149805ad.2
        for <stable@vger.kernel.org>; Tue, 20 Aug 2024 21:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724214533; x=1724819333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oL35AxGZkldIWibynmnAKaJ2u5VoZnYoTxaz2S8FjO8=;
        b=IGXPgDQETZCh+HYds+EdSIdPvQ8/p1vBC6Q7F4YJpfG71k/ZHYIVAAWtMnOTgNj74K
         BUJlNfcfknDohGaNnJok5t5NfMymEiL9EnBR72S/vR95eb2wdn0y6IrAyQkqQP6AvsYQ
         B/OD6U15Ro0ywGEI9oxfpEf//vMfZWBBpHC0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724214533; x=1724819333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oL35AxGZkldIWibynmnAKaJ2u5VoZnYoTxaz2S8FjO8=;
        b=kWF0SSqpINKIMlItX9VxMvT3dwTrB+f9YAosqOE5RxiLUadRm0nlbJjBvDE1fqxkbX
         zBZZcFNmA4SeYm5zdPm9CVtQG3M5opSbzgtmTShywGSfx0t4hZUHirLkbADuzou0beUr
         DCHl7Zn2lRt0MklujWwU7fQjQt8hI+QYThLA5RMVDlYYz0BtfWajpJ54JE28/TsZyAfE
         jnOgMDh6hMG3a+yjRUGakhnJFmKtnurhCjMuWK1srOz0FXrie457LihqiETrZ80dyfjz
         S4/zFoNy7/CW42jmiNUVPBOW9LPL5nHotRNmAaAFFZIk4xK/ZUs4oivvL1nGVxEmmUXR
         GxEw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3bHItfZIzCoq3y5n06HmdXuc9XwztmTv4OR8yc91/T1VMiV6dzalIPBk0gvayZQAhTh+WCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Qha52OINhcbW+kY0F7pp81M8FIwTgb+UqYMEFbar5IhSux3p
	FPS7AmfOUXE72VA9pulKxExky8unPqS+V5QOywqG+o60ytKzSB8MixI9ZUqzjg==
X-Google-Smtp-Source: AGHT+IGkQFvAxR6OHQmrEF1NWLA3JRjVj9a5qfWqVB0iBHec1ZP8Pwv8bCGoy0noetly9gAjy0fz3w==
X-Received: by 2002:a17:902:6903:b0:202:1fe:bd0a with SMTP id d9443c01a7336-2036807428amr9688345ad.46.1724214533083;
        Tue, 20 Aug 2024 21:28:53 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8d56:286b:9a9c:b7d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375acasm85652345ad.161.2024.08.20.21.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 21:28:52 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Stephen Boyd <swboyd@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8186-corsola: Disable DPI display interface
Date: Wed, 21 Aug 2024 12:28:34 +0800
Message-ID: <20240821042836.2631815-1-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DPI display interface feeds the external display pipeline. However
the pipeline representation is currently incomplete. Efforts are still
under way to come up with a way to represent the "creative" repurposing
of the DP bridge chip's internal output mux, which is meant to support
USB type-C orientation changes, to output to one of two type-C ports.

Until that is finalized, the external display can't be fully described,
and thus won't work. Even worse, the half complete graph potentially
confuses the OS, breaking the internal display as well.

Disable the external display interface across the whole Corsola family
until the DP / USB Type-C muxing graph binding is ready.

Reported-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Closes: https://lore.kernel.org/linux-mediatek/38a703a9-6efb-456a-a248-1dd3687e526d@gmail.com/
Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Stephen has recently posted the "platform/chrome: Add DT USB/DP
muxing/topology support" patch series, which is now up to v3 [1].
More work based on this series is needed for the DP bridge drivers.

[1] https://lore.kernel.org/dri-devel/20240819223834.2049862-1-swboyd@chromium.org/
---
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index 0c4a26117428..682c6ad2574d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -353,7 +353,8 @@ &dpi {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&dpi_pins_default>;
 	pinctrl-1 = <&dpi_pins_sleep>;
-	status = "okay";
+	/* TODO Re-enable after DP to Type-C port muxing can be described */
+	status = "disabled";
 };
 
 &dpi_out {
-- 
2.46.0.184.g6999bdac58-goog



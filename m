Return-Path: <stable+bounces-89179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CA39B4654
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 11:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355391F238FA
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 10:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5450204034;
	Tue, 29 Oct 2024 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YILfGrWY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F52187FE0
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196153; cv=none; b=oFUefNpidUuac5dUsWLI60aIe4xcExoF3MdukaS7tI8x6a+6GuN1k5kG8MNivjxmO6Xm4yBSMhZ24BC+qRGBpe9OdVo4zasM4uf7HSfw/djY6AJmZtzBBrMmemLIw372+QQncLvxXCY46N/6nXg1X2sbgx51rWR1+wbjFPF09h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196153; c=relaxed/simple;
	bh=V9yrLlvpjMhAOtTUuzUbS/PuBDjwNV+agqaeXIEXbGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ht18nceSuxFL1moyGqBCCiOhF6+15T8BC3vY5CqrCJAAzDqoWaOFFx2YPvoyUWH8oGYYPVqVdt8wZBXPRU+lRx4l6qi49XORSnMTEAj2ghsXjwBX3vUpmCsKmV09YVT/C9skL9WEFLAfl8ZNKQpVB3Hdoe/gtnxV/aMi67VBYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YILfGrWY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20e576dbc42so52887645ad.0
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730196151; x=1730800951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dP0KAMyVWS6Yj9qu9bHMDh95jkCq6kFe5y2/InwDUyI=;
        b=YILfGrWY7CaTHRKCIRw5iDpaRqxT0fAn2HQ59GqNawfk/lOIz4lBD7RUcGIrGt6W4g
         bj/nEROdOS5UCy+rQFPY566tNNFFg6pvrUSlD9YxqklHX95BqgmxC97Ymm/F49wza42d
         34TqaH1mXPKoIgrQOCnMXoE+7WwSuPOirLiQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730196151; x=1730800951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dP0KAMyVWS6Yj9qu9bHMDh95jkCq6kFe5y2/InwDUyI=;
        b=EH1XK038pzYIGKjw1l/SEe20yjyRrt8IKdB5lS90OtRBbVdowjNcxQo8DLWzAQRgZt
         SMOPK3joKhuaTwXFLr+DSrXfu5LU5ERqr42fRmftFvuiaEosS68p3oYGwGMdZBoRC2JH
         0/D6wAhUXVBp/d0LwneWQH0bTeKp5HXmEE53dHA+w6PD0b7G1DJ8w0RPLchP979BFeQv
         s9vZW0Se1EMR1is++jH10PXnNoWUTbUEKXWIhBnOAIaj/UW8HnDlRIcKAO+TS/VVh8Oq
         E++tRTrMpu54FQe8JDUJcMOPlvnoc9XMy6xePBpTXkWnDNoknYfyzkYOBwiI+ewfl5vX
         15tw==
X-Forwarded-Encrypted: i=1; AJvYcCXjHuZ2vBlJjKHGDsQfxFPpx9clRwIbn7Q4DDTP/GCVsuaCfvdJfv+Dh4tg3g8iG+ejQJeCSfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznFtyRj6lGSAxC7pkncL+b96OlfC58XylIPMi08plU0zv6moE6
	JpNB6v8T4ZhERXqkn0mE6YgHe2gWaqfNvTkD1uwyTbv509557fTiduXDZr/p/g==
X-Google-Smtp-Source: AGHT+IEVCUvA4kLgKRzZ3vDr/KBHeqsWpmQJtKxeUYRTf/PK4hHx+6K7t3YF7nEmIdBRHb+IdCV2Zw==
X-Received: by 2002:a17:902:c411:b0:202:28b1:9f34 with SMTP id d9443c01a7336-210c6d3c766mr153604875ad.56.1730196150884;
        Tue, 29 Oct 2024 03:02:30 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1fef:f494:7cba:476])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04532csm62785665ad.254.2024.10.29.03.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:02:30 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8186-corsola: Fix IT6505 reset line polarity
Date: Tue, 29 Oct 2024 18:02:25 +0800
Message-ID: <20241029100226.660263-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset line of the IT6505 bridge chip is active low, not active high.
It was incorrectly inverted in the device tree as the implementation at
the time incorrectly inverted the polarity in its driver, due to a prior
device having an inline inverting level shifter.

Fix the polarity now while the external display pipeline is incomplete,
thereby avoiding any impact to running systems.

A matching fix for the driver should be included if this change is
backported.

Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
The matching driver change can be found at

    https://lore.kernel.org/all/20241029095411.657616-1-wenst@chromium.org/

 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index e3b58641f2c9..43c83620e479 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -422,7 +422,7 @@ it6505dptx: dp-bridge@5c {
 		#sound-dai-cells = <0>;
 		ovdd-supply = <&mt6366_vsim2_reg>;
 		pwr18-supply = <&pp1800_dpbrdg_dx>;
-		reset-gpios = <&pio 177 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 177 GPIO_ACTIVE_LOW>;
 
 		ports {
 			#address-cells = <1>;
-- 
2.47.0.163.g1226f6d8fa-goog



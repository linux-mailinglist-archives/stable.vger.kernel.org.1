Return-Path: <stable+bounces-87570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E0B9A6B8B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787D11C21A21
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07BF1F472D;
	Mon, 21 Oct 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FSrckexO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC638479
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519552; cv=none; b=LHofr+90a6K6g+5G4eGDanOR3icDo/mA64aX1uJeEGWNwx0C2zt4nFhstGHf6lxI9JRk652IeZJIy34QL5bRVlsLeUMucFVuVEuvNk60ownQJRmO//KlZdORNSJEGBbb0I/bAgyNR4rwS7caJ2AZeQl42ftGOfMk7UtTeKN1F84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519552; c=relaxed/simple;
	bh=eedBscw/LGWNdzKVkTU7WWL5VO1Qm3yPV32Z9qjHYBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyNrZTVPyhzHmnzzsin8j9tYb0Rfs2iqT7q6sy2/6p90bHMCAniDRIZ9sTCTyWZTSPF9O9Vny7mYf+XRfQt9znyiioXH0hBjMDdUg/QNuDlNTBNg9WxZD+NGF010MrWV1gLPDwLXstk2RkFfvZ4iF9WokitenvU1Y0F+qZpJrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FSrckexO; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso3459770a12.2
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 07:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729519550; x=1730124350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lVisE+PE807hpO8CSAN7tilp7Z5USiSARLUB5mQ6sGE=;
        b=FSrckexOgwmjvmNzAZf4P15GD6f/ullMommleZNlODPiqg1U9kP/ThP9EmGTzO95rA
         4L+8KFs5W7DHXeruEccgXZo5Zc8qaU4i5y3cm45J1xT+LiMbsvkWR7wJOkR3DfLiU0jp
         mkvdWAbCNHGaDOuhj5eGSyYSbNWhLfVFzuPIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729519550; x=1730124350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVisE+PE807hpO8CSAN7tilp7Z5USiSARLUB5mQ6sGE=;
        b=St4oxTsdbQazZqPBd0Ymp0SWssPpSfKxCvcY1e+0tbFx9tktNw2JAgGnhc6sRKkpS2
         Z1PmDELCq4hpBZaPDCrJLTHA3vCOljbD5MoBCag7KV3GO28aMDFwCeUmAJPmOgtJVj00
         BgOvcMpSRDXPUST4DzGrUSFGElZFcIXl0ttyFvTtyKl1mSugNLU9u7FoM3LvTyvmMiOG
         aIaT4LuJPHLK+5vA+HrNN/UIsjpFTQB7NtGLfvI/UzTCqwfiNG5mmqgIldIhr4kCK84d
         l8XEwzuEkGNS422xJ3eBRkqvLNW13NxOYR0jFKN6u+zTZTU0LmO9qeN35ErIrLDRL3qO
         OYJA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8HmMetPPMvkXpYAHf2rwJLWs7B2ho3en2j6GGgNEBiEyUzwStGcacf1SqeUngQwbtDYzdjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHhI4riuDzaTsZZEswgaJiJ7ek2w6BCQvPB92B15H/EPHc8BQ
	Yug/mNOPKn+J/NCR4lvu8V9pinazbQ9vqu2eO9xqQUnefBns5bvM+RFzLv1etQ==
X-Google-Smtp-Source: AGHT+IFKl8bzamnuWMLgNJkuqVRi9dnOVZzxVFFalqgJLx3tvd/wT7dAvKU2gZg1sxaZIisSRMrfSg==
X-Received: by 2002:a05:6a21:350d:b0:1d9:ea5:19da with SMTP id adf61e73a8af0-1d96b6b6ed5mr25344637.17.1729519549873;
        Mon, 21 Oct 2024 07:05:49 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ecc1:dced:8a05:e4d8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab57e36sm3133318a12.43.2024.10.21.07.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:05:49 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8186-corsola: Fix GPU supply coupling max-spread
Date: Mon, 21 Oct 2024 22:05:36 +0800
Message-ID: <20241021140537.3049232-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPU SRAM supply is supposed to be always at least 0.1V higher than
the GPU supply. However when the DT was upstreamed, the spread was
incorrectly set to 0.01V.

Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Noticed this while trying to align the downstream Mali driver to the
upstream device tree and binding.

 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index cf288fe7a238..db2aca079349 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -1352,7 +1352,7 @@ mt6366_vgpu_reg: vgpu {
 				regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO
 							   MT6397_BUCK_MODE_FORCE_PWM>;
 				regulator-coupled-with = <&mt6366_vsram_gpu_reg>;
-				regulator-coupled-max-spread = <10000>;
+				regulator-coupled-max-spread = <100000>;
 			};
 
 			mt6366_vproc11_reg: vproc11 {
@@ -1561,7 +1561,7 @@ mt6366_vsram_gpu_reg: vsram-gpu {
 				regulator-ramp-delay = <6250>;
 				regulator-enable-ramp-delay = <240>;
 				regulator-coupled-with = <&mt6366_vgpu_reg>;
-				regulator-coupled-max-spread = <10000>;
+				regulator-coupled-max-spread = <100000>;
 			};
 
 			mt6366_vsram_others_reg: vsram-others {
-- 
2.47.0.rc1.288.g06298d1525-goog



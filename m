Return-Path: <stable+bounces-64694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F1E94252A
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 05:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3165D283B37
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 03:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECADA219FF;
	Wed, 31 Jul 2024 03:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c024FdBo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F7C1BC20
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722397470; cv=none; b=pFBujpJyDPoNU0pjV3E1pEH6bSIbgHpuC8uAvINokrmUX1iZGw2ZJz32p6V6wbzVwH40EcKIEz9K4Y45XFQwMsaYrFNWmSPBDrgHA6KZc89f5oK26FQkNdJAHXSGja+qIIdIWtHrzTl2XDfWNd4XoKRtTbHLe6RNcJhNocYJxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722397470; c=relaxed/simple;
	bh=OSVnN8tXzjBnuh8EDyw1UDmViT36WcO5dTyBCaOFmEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkFUFtO8lErBG0E/5ze5Noc5+XuSIrxuhhKYOl+CNnr5rTCnHw7vJI0qn9i8wHUnV0GRu5kUQmBd7I++jC3on1kwVFaW0cVEZYNdCGIPH4KDD7s2nXxkKq8CUK2uVjnYXnhsTHUKXy1BVl+5PhaX987SMlFq0hZQFJIGtNxhlE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c024FdBo; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so2553852a12.3
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 20:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722397468; x=1723002268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNo1lCfbQqGMSbbgOcd9nX2zDqzbGx3C0Iq0m1Inhbk=;
        b=c024FdBoslqLLRltTlZwEVlxv2ud0mmdB3mKgbDu6/WMDYn/RKdOkinYeSu4jplhfa
         /GpclPxdsEpUVFJITNwYt4J9Fo0ICcEu0dA1l5teYEqN3n+/Rnzwy1HgX2xCcqrYBlRk
         kNx8Vy+1K9xJ8eG5VyAY0HZBwCzNARaUuLr4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722397468; x=1723002268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNo1lCfbQqGMSbbgOcd9nX2zDqzbGx3C0Iq0m1Inhbk=;
        b=HvDzk8WLc7ou6PmL/HIjGSWhnlmskhcNZIOFV2dO3CMh8u83XuEgIRmtj+2PxR9QN7
         stEulm7LjI6xWWJquvoGNSvmYdIT6OwGN2nHsOzl67mmwr/uqZ/Jt4rimWuq9bmd/1R1
         OtHfP0i8wJuJbJp+7wOyrpaMPG9ymZWTmFwQBzZTNv9O5jNLG6/Af9rK1rL/TPSiGL0e
         2ZnOEkrMOWIn2NwzpzPiwY2jBTD0rcYx31adV4R52PqAk/tSRMHP9rTKp5cpzNK6VVjt
         yLV1fFRrilnDEyBwjkebRYCKhFHeYA61IYNuJKuMPvLn35ajmphBR+Dk8rWpXNpGpJXP
         gU4w==
X-Forwarded-Encrypted: i=1; AJvYcCV5PcZTr4iISdtBeaT+wIE55YOWp7oPO7nIo2VbT8rNJIRCOVMUCgV58OHO8zG6hKTGVS/Ao2Cq+qsiMS8HGqGlQn8dfmgt
X-Gm-Message-State: AOJu0Yz3SkOLTeyOTM5bOLmRCMaA/QkftCovC6wzjJ31O7/TYRu8npwY
	i1KHQN/dWLOiBrvDBcQVzDfXC9DY9XjsmA6oxJZgrNS4VOHRW14U0Mtgm8V3nw==
X-Google-Smtp-Source: AGHT+IE4FtnaiOt7PwGIeleyxseVrMrvg2bK54AvWowVA2QcZrnOLaPels+TJcjIfagIHeg10n/CWA==
X-Received: by 2002:a05:6a21:328c:b0:1c3:b47d:d53f with SMTP id adf61e73a8af0-1c4a12e1129mr17571072637.25.1722397468531;
        Tue, 30 Jul 2024 20:44:28 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1cfb:e012:babc:3f68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead81230bsm9093008b3a.120.2024.07.30.20.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 20:44:28 -0700 (PDT)
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
Subject: [PATCH 2/3] arm64: dts: mediatek: mt8395-nio-12l: Mark USB 3.0 on xhci1 as disabled
Date: Wed, 31 Jul 2024 11:44:09 +0800
Message-ID: <20240731034411.371178-3-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240731034411.371178-1-wenst@chromium.org>
References: <20240731034411.371178-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

USB 3.0 on xhci1 is not used, as the controller shares the same PHY as
pcie1. The latter is enabled to support the M.2 PCIe WLAN card on this
design.

Mark USB 3.0 as disabled on this controller using the
"mediatek,u3p-dis-msk" property.

Fixes: 96564b1e2ea4 ("arm64: dts: mediatek: Introduce the MT8395 Radxa NIO 12L board")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 4b5f6cf16f70..096fa999aa59 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -898,6 +898,7 @@ &xhci1 {
 	usb2-lpm-disable;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&vsys>;
+	mediatek,u3p-dis-msk = <1>;
 	status = "okay";
 };
 
-- 
2.46.0.rc1.232.g9752f9e123-goog



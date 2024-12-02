Return-Path: <stable+bounces-95937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6901D9DFBC1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9DD16148D
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A831F9F47;
	Mon,  2 Dec 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZzzNTeF+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D071F9EB9
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127395; cv=none; b=nJyKjle0LTOUdUsiny8lsm9yKdArl/ZzLXGCEdzuZUonqV7XxhD7ChwyJMiUpE35DIkp/6FpFdeaHf1jmR+aDNDqY1bmthiSddUM5PV0FXusx9I7CG292zAvHArAwssA0nBA6KZmriwX7ojZizx/9FXCfWH1dufkjiOzQUlrKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127395; c=relaxed/simple;
	bh=jNVl0lD7jk3nZ2MHo3V6R2KlUMMo0S3tjigEX4OgbeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fam4yxpnHnGIYMcS5GMjGB2DN3/2LOrWs9p4Mic/p7wu8VnhrlXR/+JWndTzhOE0akDsqtR0ULVWQc/0iTSXV8PTkJsGxK/RoXsJRByZUob3R+fvkubOlTtAbHKhEZulOFENcNA4wfhDMpbgNYI6C4I11OcGO4e+iObbYMWC2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZzzNTeF+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso2794105a91.0
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 00:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733127393; x=1733732193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZ+V8gAQS0krBkG0WVrb6zVz1qUQ2D1EuHAFBRDqmVc=;
        b=ZzzNTeF+OUiaKuhm0cPcWLXfADkC3aJ7TmA1lbmwI5qahb9yX07IVmQVrY8hl6kTOe
         phAAwswqf1JkcNdRy9M5CusrnTudXUk1UgJ0b4IGptt72Wyuu2iTKDo0y90XKX34fNjK
         yf7Hoz+HovQMPY/s2M0q55jJd7UajoC9B9jNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127393; x=1733732193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZ+V8gAQS0krBkG0WVrb6zVz1qUQ2D1EuHAFBRDqmVc=;
        b=W63sFWiQea33Maxza7pNvcJGbd2QFaGzBacgcQncwDRef4CzQOZc7zO59h9oSsbMe8
         YVPORu17Pl99wJT7+Fmcbv/HaJ9lg/O+4aY+AXs68lJprLryzwDKN7Bs/8UICtEiAMbd
         ExiGXkNfcTziS87ywTJO7f/1PVmt09wJJl8/cdKD1QP5F0TmatymoOI2UuOf1QO/qj8b
         nqxj0gNi6/xYX2PoedwkNICPBnuNyUR6Kdn/bfX1ULHkDsCZp2o20ezVZ3Lmfe9WwB1S
         XZlwzXfrVFy74BX27vuYCIQKA3x7D6qpkd+SHoQwzsLpUK61+pfqIJjK1FJ62EWomKs7
         MbEw==
X-Forwarded-Encrypted: i=1; AJvYcCXv8Ve3jGcssxf6fTELD/OL66MafPdBeweIiyCNonY9lP4EggWBX+V13yBlqsaTV1BBZQaP/N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyhlUXLmEvvtvy9jeRtfc7IghPS83tEj4kKoyjcGhcfpyDLDGl
	nn9A27/DM2DlEtV+pZIe0RHYkO9ZBLWjFVDta+Cj+sOOXl9F7PejnZADczuPjw==
X-Gm-Gg: ASbGncvh3DN+sMIYyxffsy6KnklgEYsA+YGrt4C5h8A5dyTlsLEy1LZGU+BSpOR+l5o
	Seh2lFQy4kZ7xpMk9JkmDhGBAiPsGXHk8IjJsfTRyHc/tlFIh7q/8gXqV/b7DBnbWMER1b++1UL
	kDmb8vmIANdlDRBAnLpvbNQWUfx0FaSO+BI3jAn21cKgIwxDfUtIyvL6MgztItytZN9vBiMp+Wm
	cbTOUKXPL4k0vB31QMXbjIY/yIKnoxIFRxj6IDqBcXGZMLXq7KMPe4OlDFNGzpAlXs8
X-Google-Smtp-Source: AGHT+IGt9cTgxCtovdz1WM+2VFqEZhhh4JaKNavNwPJgr8fK5Ri/wVS1DDwHKI8QEXh5bTEbIZqezg==
X-Received: by 2002:a17:90b:3c4b:b0:2ee:bbd8:2b7e with SMTP id 98e67ed59e1d1-2eebbd82e62mr6847321a91.12.1733127393173;
        Mon, 02 Dec 2024 00:16:33 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:94c8:21f5:4a03:8964])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee488af41dsm6312844a91.28.2024.12.02.00.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:16:32 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Koichiro Den <koichiro.den@canonical.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH 6.1 2/2] arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled
Date: Mon,  2 Dec 2024 16:16:22 +0800
Message-ID: <20241202081624.156285-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241202081624.156285-1-wenst@chromium.org>
References: <20241202081624.156285-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit 09d385679487c58f0859c1ad4f404ba3df2f8830 ]

USB 3.0 on xhci1 is not used, as the controller shares the same PHY as
pcie1. The latter is enabled to support the M.2 PCIe WLAN card on this
design.

Mark USB 3.0 as disabled on this controller using the
"mediatek,u3p-dis-msk" property.

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
Fixes: b6267a396e1c ("arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240731034411.371178-2-wenst@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 9180a73db066..0243da99d9c6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -906,6 +906,7 @@ &xhci1 {
 
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
+	mediatek,u3p-dis-msk = <1>;
 };
 
 &xhci2 {
-- 
2.47.0.338.g60cca15819-goog



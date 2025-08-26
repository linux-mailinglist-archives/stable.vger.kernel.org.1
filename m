Return-Path: <stable+bounces-174926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BD2B364B2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C296E7A5A5D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D771123D28F;
	Tue, 26 Aug 2025 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S7lNyTaX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538C227EA8;
	Tue, 26 Aug 2025 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215681; cv=none; b=gUn7gA/hqHUjAjuu6E6/V1TinzxIVS7L3UbrdpuE9913229ZBBRRtiKhoV7+EzwYx1IQcftuSQ7moZZj1ihyVH/BYEFJDU3vKMrlNMg+jpB9230l8wrqkKFIqQZrbxEReUpbz1hehln8VjrvlCUodbvbqJDvuN9voMV/7XPD5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215681; c=relaxed/simple;
	bh=T1hVc8D7X6Lh9AVEQpUjHbw+F3PsIDvjaCe4LftoOjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTPisBG9Z+fRb4zGtXv2Z0LMJzaZXsnDGk3VZ/0AVieBjtGtGe8i1yl9+cAEYxkm8jxDMEKiVrlJPmuY25tNSYyl1aD0z+/6cnzeUHNi6hxuPFPIy+JVKINq5q52qlBHoHFRwrDGis3MrA2Ia36Grnov2JGKHbhBpIWNIi1tdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S7lNyTaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270EFC113CF;
	Tue, 26 Aug 2025 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215681;
	bh=T1hVc8D7X6Lh9AVEQpUjHbw+F3PsIDvjaCe4LftoOjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7lNyTaXuj/JSi/rOtv6UIktqu2xeC4cijwNVAdlRaKV5p4AZhSHvJluYEOV79AT3
	 v8gipd3/6snWcWJ5nUa/yQ4oZgb7Eux3skeOVNhF9TOvNiZrutpE8KRfWDvkEflQQo
	 HEIyfQEJtj3SjIH/UwgCIcu6ABShuePf1r5PVLmg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Albin=20T=C3=B6rnqvist?= <albin.tornqvist@codiax.se>,
	Kevin Hilman <khilman@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 124/644] arm: dts: ti: omap: Fixup pinheader typo
Date: Tue, 26 Aug 2025 13:03:35 +0200
Message-ID: <20250826110949.591395465@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Albin Törnqvist <albin.tornqvist@codiax.se>

[ Upstream commit a3a4be32b69c99fc20a66e0de83b91f8c882bf4c ]

This commit fixes a typo introduced in commit
ee368a10d0df ("ARM: dts: am335x-boneblack.dts: unique gpio-line-names").
gpio0_7 is located on the P9 header on the BBB.
This was verified with a BeagleBone Black by toggling the pin and
checking with a multimeter that it corresponds to pin 42 on the P9
header.

Signed-off-by: Albin Törnqvist <albin.tornqvist@codiax.se>
Link: https://lore.kernel.org/r/20250624114839.1465115-2-albin.tornqvist@codiax.se
Fixes: ee368a10d0df ("ARM: dts: am335x-boneblack.dts: unique gpio-line-names")
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 9312197316f0..db1bf9452e57 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -34,7 +34,7 @@ &gpio0 {
 		"P9_18 [spi0_d1]",
 		"P9_17 [spi0_cs0]",
 		"[mmc0_cd]",
-		"P8_42A [ecappwm0]",
+		"P9_42A [ecappwm0]",
 		"P8_35 [lcd d12]",
 		"P8_33 [lcd d13]",
 		"P8_31 [lcd d14]",
-- 
2.39.5





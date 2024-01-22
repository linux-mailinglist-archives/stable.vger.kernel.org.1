Return-Path: <stable+bounces-13927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBB7837ED9
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC381C2836B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3282605C0;
	Tue, 23 Jan 2024 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1lYlYbcG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174260268;
	Tue, 23 Jan 2024 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970781; cv=none; b=GGVOtcmTh1Ng0aTmk+mjho56TO/vZDTT5eZf/mKNC/ceOb/2UL2HRoaEUTs89uWIYQlakQ1/61HiaPOP99quGx8+fOxWaHJwTkfVfm/qmJfrmhFWLKbmpPQrCD0u2ncHgSZ6epUZRDm51/tqHdjy3RvH4GaLDq6ah112k5YeKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970781; c=relaxed/simple;
	bh=jtj3eVd7HCTqQNWS+egAtziw8CVYjU5RjW1IOa49suc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXP7f8uXOXuJzu5NqyqY9KCCUjiLc/ZN1yDNxj1WRaX8ha0JV/E+xL8KpkVwhsaZUiv4pHWyXvSC+at5a6nlVVGjyiB0Vv9OhRlLZcPQuG4InkK1+sYMJP/t1JEtb1XWJAVUFHBwhzjWByZsNj5oeSifGlHFmKeMsfiEIKz7Pu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1lYlYbcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A760C433F1;
	Tue, 23 Jan 2024 00:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970781;
	bh=jtj3eVd7HCTqQNWS+egAtziw8CVYjU5RjW1IOa49suc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1lYlYbcGZ3obU+36VY6sfyThv27lmrjTX/R/Sdh3I1PHAaKNzbCwXsxL1nGYwHgf8
	 ciTNkrvWJOhpIs8db54d/KdltWdSMC6h3VQ1b2u/6AMGP/d83NTVIplKlpz1gyEHp2
	 8dAW1YFJvEgMHnhVoFmVWI2M+7NxfxeO9/vYFQfU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Wei Xu <xuwei5@hisilicon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 108/417] arm64: dts: hisilicon: hikey970-pmic: fix regulator cells properties
Date: Mon, 22 Jan 2024 15:54:36 -0800
Message-ID: <20240122235755.477439624@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 44ab3ee76a5a977864ba0bb6c352dcf6206804e0 ]

The Hi6421 PMIC regulator child nodes do not have unit addresses so drop
the incorrect '#address-cells' and '#size-cells' properties.

Fixes: 6219b20e1ecd ("arm64: dts: hisilicon: Add support for Hikey 970 PMIC")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
index 970047f2dabd..c06e011a6c3f 100644
--- a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
@@ -25,9 +25,6 @@ pmic: pmic@0 {
 			gpios = <&gpio28 0 0>;
 
 			regulators {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				ldo3: ldo3 { /* HDMI */
 					regulator-name = "ldo3";
 					regulator-min-microvolt = <1500000>;
-- 
2.43.0





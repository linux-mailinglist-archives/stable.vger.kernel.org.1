Return-Path: <stable+bounces-13348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF0D837B80
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567E029313C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E401350FB;
	Tue, 23 Jan 2024 00:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IZ93vlWW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264BD1350EE;
	Tue, 23 Jan 2024 00:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969354; cv=none; b=MKIkgQoUUBmbBFoBeqtuoS/JpsXiBxK2Keajbe5Bn3DT86gpsBdGn0SSyQ2zOh9lDttiYrWDcV8bRNxIExE3lNwWFOa4UbeJ4q3fKLYe0TZkxrbmxkL42cMKuhj1kYLidMNV3eF3EvLj38QnmUk1gW9KV70Fyvi5StsPdCjwEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969354; c=relaxed/simple;
	bh=ZKII2TeeI/UuhqOWPCDiSdjJlix0BaqTA7G3iymHLVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qq23ZGERQkQIVrANkBhZC19FlGzj+bg2aADF2uINwr675a1FDuIUTEyg44xFH86FkLqT4HILV1EBlDbF8IPTM0E/BLns4OEdOmycRmRjThffhe0zx/soDbrqooudKeN7hqM0sg4hf4e3uRwa/SFTZuSqKutTxpxsthNwk4V+Ctw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IZ93vlWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C57BC43394;
	Tue, 23 Jan 2024 00:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969353;
	bh=ZKII2TeeI/UuhqOWPCDiSdjJlix0BaqTA7G3iymHLVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZ93vlWWOC/u23z17LASIIZ6Uga+DiLJ7DH9SzeBF/GPUIj50R7115wsqxwPYujVT
	 eUm4lzRTyzrHVBgqfGF4sgJLivl+BXNe1AxD87crmscgyqGDbUQH6yIM5FvaRS2ang
	 4EXMfcbQu5RnFhywZaf9VyjmPWLzZv4QnS8x6s50=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Wei Xu <xuwei5@hisilicon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 157/641] arm64: dts: hisilicon: hikey970-pmic: fix regulator cells properties
Date: Mon, 22 Jan 2024 15:51:01 -0800
Message-ID: <20240122235822.941419118@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

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





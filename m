Return-Path: <stable+bounces-11614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C42282F9A4
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 22:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51151F29325
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 21:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20041474AF;
	Tue, 16 Jan 2024 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg6glQcD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C27D1474A4;
	Tue, 16 Jan 2024 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435010; cv=none; b=XTJOCVra6voeS6bz2l1H5m6nOVVu3ZVz+LxqPsepSxvuOmyFIvgqXhvaGAV+x+f5CIdCo+qDxrqoBwphy28ZoO72Ip7mYCtzOG4sVxs2xeYc8BVU7Q+q1X0AjP9+n3Qu9K9WFabkqzWBw+1psW5NOClkl4EBtlpapf6JtTxrBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435010; c=relaxed/simple;
	bh=HVw7LWMua6rQY28klKZgL+y9hxK77Z1K7/QuQuTOWIc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=fp1KKdnsPz+Ab3NpBDVVcaO5wxUJINe+u9ORMp6x22nf6o4/M+W1pAeK4MEuXbzN2pCxYlkYodkTqvKoLV1EJFwSdvlxfko57mVT2w7oh7rWXqMIrlTx7lOB78Moeviah/S9giCarCM4Init5wqGPSpd0aAQB9c0WuPqW6LU8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg6glQcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E40AC433F1;
	Tue, 16 Jan 2024 19:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435010;
	bh=HVw7LWMua6rQY28klKZgL+y9hxK77Z1K7/QuQuTOWIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gg6glQcDVlVVcjUrHJjm92koFQOy5PFdmsfRZUx++NvaK2CJpptjlTlgCrR3DDYxa
	 xkgpaUnGj54/QUlFULUFM9n7mg02kJImA9ffIJhSUPcEl3+Xp+/lyBIvMpQ2jYa6yY
	 oJx1KgqzAQw9YT+oc7rtRmEJQA6GRm5NT+0SuacuempxpmIEzP3Tz5euyqFLtx5Z7q
	 0QYv867EsJLyKMsONVq31cF4hI/dF9bCMWH451UihGSGaF6AqARL/zMhxQknnasfvl
	 93X7J8lS8jb4PFYOZ6IDhgRx0plq2tZtx13mbLDF1Lah9bhz+H2kPNLj9ULFasrxg1
	 4Nvt6kpBHEScw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 40/68] ARM: dts: imx25: Fix the iim compatible string
Date: Tue, 16 Jan 2024 14:53:39 -0500
Message-ID: <20240116195511.255854-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit f0b929f58719fc57a4926ab4fc972f185453d6a5 ]

Per imx-iim.yaml, the compatible string should only contain a single
entry.

Use it as "fsl,imx25-iim" to fix the following dt-schema warning:

imx25-karo-tx25.dtb: efuse@53ff0000: compatible: ['fsl,imx25-iim', 'fsl,imx27-iim'] is too long
	from schema $id: http://devicetree.org/schemas/nvmem/imx-iim.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx25.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 5f90d72b840b..5ac4549286bd 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -543,7 +543,7 @@ pwm1: pwm@53fe0000 {
 			};
 
 			iim: efuse@53ff0000 {
-				compatible = "fsl,imx25-iim", "fsl,imx27-iim";
+				compatible = "fsl,imx25-iim";
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <19>;
 				clocks = <&clks 99>;
-- 
2.43.0



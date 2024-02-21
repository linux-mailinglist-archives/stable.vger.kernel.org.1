Return-Path: <stable+bounces-22666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43EB85DD24
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E3F281810
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210917E595;
	Wed, 21 Feb 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wCBVznvf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B77C09C;
	Wed, 21 Feb 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524103; cv=none; b=d89oTF7DA4Rp4nEJldUmdJ/a2O08EoIyPEWv9PGKphNDq8QbR79k1zBoWnjpl9hTM7PdpvwaKKttQn7QsWFoacOZsjsV+jI84AuLDNywzaNp5+qq6jAXSeOMrQrgWagEfeBUxNlRH/Kwddg6ps9hyqT0mUsCDyd7RVXV83vCXg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524103; c=relaxed/simple;
	bh=csD3+yC1pUUtP6gUm/OzFbaeBjeSg8KsLpza2/rPAI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzOXdkxMsx1Yuy0nG6qlU5zDN0jNbQ4bt8C9kLHR3A/sA5a7gyZBhtDC2/lKCRAJcfWWzYTkWAZupf7fnzP2NsVC93WrM9YN9O5Cpe/7q2V2io1pRVW8hMMtPI8utdo+YfNPiJLbgqgGHKypsHPexiA1wKLBnD9g37XAN55RB0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wCBVznvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8B7C433F1;
	Wed, 21 Feb 2024 14:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708524103;
	bh=csD3+yC1pUUtP6gUm/OzFbaeBjeSg8KsLpza2/rPAI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wCBVznvf5tv1XV2QMQqBWy2EnvfShUv2Nmn0eYoKZdNNqIBz9JVl4gso4cxKKi+ik
	 zW46SuC/OXQPXJls5rMjYiHvsirPrM3TvYM6oga7M2Yaoo5R01qdFvJJN5sxD2ewCe
	 wjSCTUPauZIrBjeQeDWOj2tmfZlZ9zfhvLtNmoqY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 145/379] ARM: dts: imx7s: Fix lcdif compatible
Date: Wed, 21 Feb 2024 14:05:24 +0100
Message-ID: <20240221125959.213532459@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 5f55da4cc37051cda600ea870ce8cf29f1297715 ]

imx7d-lcdif is compatible to imx6sx-lcdif. MXSFB_V6 supports overlay
by using LCDC_AS_CTRL register. This registers used by overlay plane:
* LCDC_AS_CTRL
* LCDC_AS_BUF
* LCDC_AS_NEXT_BUF
are listed in i.MX7D RM as well.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 622c60bd8b75..31ccf65d159b 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -773,7 +773,7 @@
 			};
 
 			lcdif: lcdif@30730000 {
-				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				compatible = "fsl,imx7d-lcdif", "fsl,imx6sx-lcdif";
 				reg = <0x30730000 0x10000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
-- 
2.43.0





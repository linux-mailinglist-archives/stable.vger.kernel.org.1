Return-Path: <stable+bounces-114919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA86A30E8F
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4378D3A8A55
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11E5250C0F;
	Tue, 11 Feb 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oYCFRrO/"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488E250BFC;
	Tue, 11 Feb 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284771; cv=none; b=XbKGhufuvVjWNeyngduHkK2E73Snm3Ujaem+gRyHPLwbMxrW6/jXCF0DT7+X5PA8rb8BrXjzDjaro0002m1PoRkUez8tlaKB9666uujl3GGnbdfJcbDhn+aDhHh+58ubfdtmdSWBOKdrRVmdIMXkVNN2T2J0WuODXl8S7EHPahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284771; c=relaxed/simple;
	bh=vwvT0IV6zmeOtXSkiICUs3PNA74HF+q9L26ymYs58uA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k8TEMONjcOUNcoRJZrijNpqYdEO63KZ2FzG9Ai/pBPkQ0MRvclOkFhLXVJOko5yYJEhv4R58Yh2FglnVppTIEQZKklxsUElyH0/cBezFDr2TeNXeQZ/wAFIXtZeWMBSwhJjqor91evK4LOL+UmT2i2AiHdbm4xCFYVmB8Pb9L00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oYCFRrO/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739284767;
	bh=vwvT0IV6zmeOtXSkiICUs3PNA74HF+q9L26ymYs58uA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oYCFRrO//YgoqO/DWnNYn5svT2uWsQbcG7xfLxGH9/DEx7GNbhgGg4usxoyJiqtf7
	 3IBJ3XJzcazrb0L9+X4KcAfI+pPP92dC6eLh5NysTbNVvDaxTx8nPstlPbZmIzG355
	 DnsdIarIGT1u1nnNSeWAM7/45gHY8rnQtNC1ONJ/AFPLNrJnIIqIGa10He6a0qTaea
	 nRZwFiaOu9JUEll0dntr+cCDdMsfOyzYwhaYoJyDWXbwgHD5b40k5YNFFaiEIxbuu/
	 5685xsz1PNX/BluoLan8nLMbmrp5gQnv+qNRMbOAJZm5Fkj9UU+wVmS4jN7VIUtNSV
	 DfHvwv8ZmGGzg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C588B17E0CA2;
	Tue, 11 Feb 2025 15:39:26 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fei Shao <fshao@chromium.org>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Trevor_Wu_=28=E5=90=B3=E6=96=87=E8=89=AF=29?= <Trevor.Wu@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250207-mt8188-afe-fix-hang-disabled-apll1-clk-v2-1-a636d844c272@collabora.com>
References: <20250207-mt8188-afe-fix-hang-disabled-apll1-clk-v2-1-a636d844c272@collabora.com>
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8188: Assign apll1 clock as
 parent to avoid hang
Message-Id: <173928476672.1551988.2336306121447017501.b4-ty@collabora.com>
Date: Tue, 11 Feb 2025 15:39:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Fri, 07 Feb 2025 14:41:24 -0300, Nícolas F. R. A. Prado wrote:
> Certain registers in the AFE IO space require the apll1 clock to be
> enabled in order to be read, otherwise the machine hangs (registers like
> 0x280, 0x410 (AFE_GAIN1_CON0) and 0x830 (AFE_CONN0_5)). During AFE
> driver probe, when initializing the regmap for the AFE IO space those
> registers are read, resulting in a hang during boot.
> 
> This has been observed on the Genio 700 EVK, Genio 510 EVK and
> MT8188-Geralt-Ciri Chromebook, all of which are based on the MT8188 SoC.
> 
> [...]

Applied to v6.14-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8188: Assign apll1 clock as parent to avoid hang
      commit: 301d44afbdcfd523a8c126c52b9d597ec27c473a

Cheers,
Angelo




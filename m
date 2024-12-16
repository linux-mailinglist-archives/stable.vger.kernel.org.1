Return-Path: <stable+bounces-104350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C1C9F3250
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583F318865C1
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA772205E04;
	Mon, 16 Dec 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="glWcTs8S"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6451C8FD7;
	Mon, 16 Dec 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358229; cv=none; b=WIcanlNiCuf4ShNYXjwLjpEP0loJhFBYVSStoAJvan9a3G/ZqMVKQRnSsPjhiayYQYFoRuataVEvYxt5bCGjH2oubKtuAx5s5uhtep7q2pTZs/XVIcG3e05NO3FT9BYyzl/AouMzx8TPzG58wqSu8z2VlHCULO6yzs35ka4K/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358229; c=relaxed/simple;
	bh=9BMq611RSXimAJ+Nd4yXmLpN4KwHNrEW5UBvFhxngaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IKOYSHNsm8F9FxOGslHuUSG1xO1FUdsnuubX9Q0wS4Pac8/xGU3aIc10i4GuVkiY6Ip7cbze4eeIPcJtS7dL5gCyKzEOLQRbFM/JGlcaDABAsk7NLx50RVwSP4jInwL50hUsgzIDPwstebzUlSJPU4SjBVBw/xWikj6G+tPgNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=glWcTs8S; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734358225;
	bh=9BMq611RSXimAJ+Nd4yXmLpN4KwHNrEW5UBvFhxngaA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=glWcTs8SLz86Y9sW9NLV7fe4D7IiBZoL2azvS+FTKDl0SO1vgDkOEoODHM/+65/xW
	 6JzAxgEy20rAmA4CCmxCHGbMB+uOH4aRgLjqpVXBnIZRs1ZKd5Ud0nwlrFm04i9Nqi
	 50YtPCScf7X9y6DtbarvMVN+8mPLJE5A1+4KUIT4U0O2WRarHF021l/Hq+WOjEbE+d
	 U3aacBdYv1mEOClv0hJBnWk4VJ9ZNbmXWS5ipj1U1O7XRtcazHWomPYf0ac1TIuVq2
	 b1bFPofH8FGNIYYPYaWLIl4iEbabKoDO50deZ3N9vhjHx7mSY3Q+vZ4P4AkZU7UWR5
	 PRN1RSx3v3Srw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7DBC617E377C;
	Mon, 16 Dec 2024 15:10:24 +0100 (CET)
Message-ID: <016f8f1a-e408-43d7-9a76-1a025ba159e8@collabora.com>
Date: Mon, 16 Dec 2024 15:10:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] clk: mediatek: mt2701-img: add missing dummy clk
To: Daniel Golle <daniel@makrotopia.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Miles Chen <miles.chen@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>,
 Frank Wunderlich <frank-w@public-files.de>, John Crispin <john@phrozen.org>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
References: <b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org>
 <d677486a5c563fe5c47aa995841adc2aaa183b8a.1734300668.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <d677486a5c563fe5c47aa995841adc2aaa183b8a.1734300668.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/12/24 23:14, Daniel Golle ha scritto:
> Add dummy clk for index 0 which was missed during the conversion to
> mtk_clk_simple_probe().
> 
> Fixes: 973d1607d936 ("clk: mediatek: mt2701: use mtk_clk_simple_probe to simplify driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



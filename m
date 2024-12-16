Return-Path: <stable+bounces-104353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A1F9F3260
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911A01687C3
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736482063D7;
	Mon, 16 Dec 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i4O2T5f1"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B34F206264;
	Mon, 16 Dec 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358233; cv=none; b=AGgUi1JGIMpFv/HfraPpV+ALm+3wnSUXRnqHXzhx1J5o2dAo+R7nOJLlf+TF5hlDWv7/q9PFPfR27DUlwJSDnva1Sdx/dEQctHpM0gHPggAsf989SIh3efN0V9Nk8RivBR+4OR8nsMs9jZlaIIcHfc+v4NkQkND5jaKqtn0/ZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358233; c=relaxed/simple;
	bh=9BMq611RSXimAJ+Nd4yXmLpN4KwHNrEW5UBvFhxngaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SLEt0/Y7e9vYCaLhhdRcwTESB/OvksmMDxZUoBgBOQAmiP/p5TzutulUQbyXMqGFcEcm2KaF+jqvRPTRRVjNRGXrFzNiGEAApeLbudM5VhXWqiiD6KDfwrBe8lQ1lFFSGa0SPAvZ8A3ChaoPFthrcJdXp2fOtcCbTW0qBcj2rlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i4O2T5f1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734358229;
	bh=9BMq611RSXimAJ+Nd4yXmLpN4KwHNrEW5UBvFhxngaA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=i4O2T5f16Dzv3jt1OKIrqbLlsFrA/yJsbYUxcbwErnPLRe80ecZsKlAuc42QcgSMy
	 +GKqIL01nWFrc13rtnwYAsRsUk8thykoy0lbq5mZg0jNl659bPmx+J7eMArQEEpSq4
	 gP4EwqnzSJO4ZJJCO7gupib3RP+iLHo9bEF2Ytgfi8jJZ/F/UKE/sXB20teCxJMMsj
	 P/VQgbn1fFp3nSsIrgMclakVUBWm8jl4KzIt+EMCkTIRPPbxlfysPgfQf5DwYWF5pQ
	 WrwFS1YQG70NrzMUQpxU9HCUmWr+Fp/HxOK7WKyGjPOrpTB9CKzqc9p5lZVPC33S8c
	 xffdNCYAxpK8Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E32B617E3782;
	Mon, 16 Dec 2024 15:10:28 +0100 (CET)
Message-ID: <f816383a-0409-44c3-973d-8e0dcd786b68@collabora.com>
Date: Mon, 16 Dec 2024 15:10:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] clk: mediatek: mt2701-bdp: add missing dummy clk
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
 <b8526c882a50f2b158df0eccb4a165956fd8fa13.1734300668.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <b8526c882a50f2b158df0eccb4a165956fd8fa13.1734300668.git.daniel@makrotopia.org>
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



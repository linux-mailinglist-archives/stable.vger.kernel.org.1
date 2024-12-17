Return-Path: <stable+bounces-105060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C79F576E
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 21:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C8016EB67
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4300E1F76BA;
	Tue, 17 Dec 2024 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP8a9f91"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8822170822;
	Tue, 17 Dec 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466568; cv=none; b=UcYfvj1EEjIQfHM8FOQy/QTadUZYd+s57te0eaHaBFOQfyojkCF7W+7emhMvBaWr1XJbaJ0RZglODzTEIdvPIcmddmkTxpLkoW6qfQGerzNTWBEhDZYOfZDoXsqq3QujNx8ouLLLPkaGr/FT+NooH4WhVtqUV0J3ytZaiHj9GzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466568; c=relaxed/simple;
	bh=fODY4GbeslrRf8S2Td9p5PvayYul9ddz8tUOiCrByLA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=pqjJm0pgHL3IEyDmselmcy4m3mLBJurR1xsMZdN6ul1Xt1En1MhQFpzad+X+P9Ot/MIjVw9T+IpQlspVTJPODzB9iQ8F5wjngtF6yb3Y3b2llRv8dWuMHUd6/fUp68vclV9Hs6SeI2vboolbnsWahX+NQMUdqz98cDjcnO1IGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP8a9f91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A32CC4CED3;
	Tue, 17 Dec 2024 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734466566;
	bh=fODY4GbeslrRf8S2Td9p5PvayYul9ddz8tUOiCrByLA=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=aP8a9f910Ja4dw8BV2TTr0n9+MpP8HTdRvXGsc7A/YPIeS3e57iQ9UC+LXr7/FR/x
	 2I1ky3YkWMCAp4ASZzdPPs+vkTFO13wa0TWX/DXwNa1Ul8H/87ThecrDWno2HTwPja
	 hzpjiem/JVHBwXXs1IsF07EZu9x1NwVXiER7/MP8g69qMxpZZeGhHTTLynb+ARgvG5
	 VCfl8DP//km1DhC0kJmMJWAXGgL1MXP43qHpP8Y0S1/xNT9yM5GH5PZxcUPUOMKaQI
	 2PmfFi6J3aquuG949y/AloQJXy9Ce/Fsx+z9qjqTxv8ISoYc+msfAVQYG8cDRvz674
	 xzmjTukVmg51Q==
Message-ID: <fab3fb3ad72809ef2ab94098b18eae73.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org>
References: <b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org>
Subject: Re: [PATCH 1/5] clk: mediatek: mt2701-vdec: fix conversion to mtk_clk_simple_probe
From: Stephen Boyd <sboyd@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frank-w@public-files.de>, Geert Uytterhoeven <geert+renesas@glider.be>, John Crispin <john@phrozen.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Miles Chen <miles.chen@mediatek.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Date: Tue, 17 Dec 2024 12:16:04 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Daniel Golle (2024-12-15 14:13:49)
> Commit 973d1607d936 ("clk: mediatek: mt2701: use mtk_clk_simple_probe to
> simplify driver") broke DT bindings as the highest index was reduced by
> 1 because the id count starts from 1 and not from 0.
>=20
> Fix this, like for other drivers which had the same issue, by adding a
> dummy clk at index 0.
>=20
> Fixes: 973d1607d936 ("clk: mediatek: mt2701: use mtk_clk_simple_probe to =
simplify driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Applied to clk-next


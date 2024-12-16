Return-Path: <stable+bounces-104354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9632C9F326A
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1965161E9E
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8CB2066E2;
	Mon, 16 Dec 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SVr93H2q"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90B620628E;
	Mon, 16 Dec 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358234; cv=none; b=V01JNu6TgSmYKvE0LmdaUaH8JyFmdSEdtld5v4iSyeknSk6udwyd2tdzHWITlrAbHaFinYnYsGnDx6cDNwoCi1c284QvfVXMItBYDigTWg2ID2+Kz7lvhwBD2xT/02JE80dqQjnCeO6+I1ipo164r1M3A7pV4yCiBkFJeDFMdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358234; c=relaxed/simple;
	bh=emtkLwwySWPoWElXvJPFdw/cj1Vtoq6kbUzlYSmOgAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qy9WhiYcaWsifC+KJtXfDWkYN2nOQBQAAbXgiPZ2zk7g0+PqkLl/Y4pMSIacYzF2DLDoaLGlOiD3lcwFUieQaPdyIboEXgNF5mR7AcSdKvlam22N0iFfHbbWybx1/emtGTbRsq36+E7oD5A+xSJ8AEXIWSCdFY1Z6AGOriylafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SVr93H2q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734358230;
	bh=emtkLwwySWPoWElXvJPFdw/cj1Vtoq6kbUzlYSmOgAU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=SVr93H2qBzeUxWA7TxhTrqzCuPtPio1LUz/b3TvykZVUKWqPpMACsC9N4uueT2xSX
	 aUYRAXYT+0RCPgZOeuh9Twn8vdFiyD6MX/2ntlUCkxVtJ9908xy67kcXryunfrAuM+
	 RpDL0dOJ02ayjKx7vnAcb4rFjz9aQfo7NNB/uemSU5SdE5AXllOdrKEZ8xlrURli4p
	 txBHOCQ98PmAGqCkeLH28QCZTssvs9y1PkeRwCtNpscDAgDiQVgP/bc9aEWWugSvcW
	 W3bUMPOcZH48rHLEGgdkkwcjprUW0EX4K1qGQ6U0sRduQe88NRJ/hVuV7GhByZGkhI
	 /21+GQLNSTexg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0876817E3783;
	Mon, 16 Dec 2024 15:10:29 +0100 (CET)
Message-ID: <8cf8accf-51dd-47b1-9b02-07a96e897714@collabora.com>
Date: Mon, 16 Dec 2024 15:10:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] clk: mediatek: mt2701-aud: fix conversion to
 mtk_clk_simple_probe
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
 <a07584d803af57b9ce4b5df5e122c09bf5a56ac9.1734300668.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <a07584d803af57b9ce4b5df5e122c09bf5a56ac9.1734300668.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/12/24 23:14, Daniel Golle ha scritto:
> Some of the audio subsystem clocks defined in clk-mt2701.h aren't
> actually used by the driver. This broke conversion to
> mtk_clk_simple_probe which expects that the highest possible clk id is
> defined by the ARRAY_SIZE.
> 
> Add additional dummy clocks to fill the gaps and remain compatible with
> the existing DT bindings.
> 
> Fixes: 0f69a423c458 ("clk: mediatek: Switch to mtk_clk_simple_probe() where possible")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



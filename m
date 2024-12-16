Return-Path: <stable+bounces-104352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C389F3258
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B5B7A224B
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0F2206281;
	Mon, 16 Dec 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="in0zhueL"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68224205E1A;
	Mon, 16 Dec 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358232; cv=none; b=dPzoRdWhX0JWflaPZukNV0YIQvw6VttK0OS1GaWb4S/Rtr9KI0Rs+fEvDw/eKHrc0hI2miHdz7TymH1/0tweBTYciUFthG0TtBNhA8TA3hWk2B5byD+JEH9rqXCvO0YH/tA294c1kJ+8nsEIVpFaqqj1/PCCPms1OzLeaGEA3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358232; c=relaxed/simple;
	bh=7BmQDn6Yuc2KbvneId228CgnxSdUyRhjp8eBVEZmStg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tLLuYYzUNrOvNLbvnUkiEmpCrmuKvzKzIu2HNtaZh0CmPiDoFff2XQkRgP75c4aNECeMDqhoxcdbOdvVcxLFmpdL1QWB0aMbOG/LOGRolFkjXApGYxUmdAc7oi5uZVXbsv6l0jaVnyMiF+f2/hqHZ6QbC8iv9BUFruGj9yoKw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=in0zhueL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734358228;
	bh=7BmQDn6Yuc2KbvneId228CgnxSdUyRhjp8eBVEZmStg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=in0zhueLaBy8Ehm9jZ+TwjGhOCva0+k4uCWrKmX/22p4DQt4V8jiUFow6sBSGHnXG
	 WYPpPP8tOYljRw9v1pW9/VX0LDOLakx+vHuW5xs6fNqRJ8WxApwH7cwYX3Ioa+6vfa
	 G3Uw8qPevb7KSRg7aKKUZWE16VJ3fvSID0alsDl3fLC/x9QNbBTFz6K94AB+7QwGEX
	 PdIKlDPhut+G5Zr2UL3MVhWV2hZ8Baoox9Wz84+55m1ebmLpYt2o8knDoQqIweSamy
	 m8TtR838Or/aQD+YZveYyUdhxJ5mNDZlvFBSwktaQY30Tk3tXcoMWzgqPv3yq2RAss
	 +XgAmzCorXCXw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C97DD17E3780;
	Mon, 16 Dec 2024 15:10:27 +0100 (CET)
Message-ID: <73431558-89cf-4ef9-a0c5-fb9209eeb040@collabora.com>
Date: Mon, 16 Dec 2024 15:10:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: mediatek: mt2701-mm: add missing dummy clk
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
 <9de23440fcba1ffef9e77d58c9f505105e57a250.1734300668.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <9de23440fcba1ffef9e77d58c9f505105e57a250.1734300668.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/12/24 23:14, Daniel Golle ha scritto:
> Add dummy clk which was missed during the conversion to
> mtk_clk_pdev_probe() and is required for the existing DT bindings to
> keep working.
> 
> Fixes: 65c10c50c9c7 ("clk: mediatek: Migrate to mtk_clk_pdev_probe() for multimedia clocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



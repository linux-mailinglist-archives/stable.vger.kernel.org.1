Return-Path: <stable+bounces-104351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C969F3253
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E8B18820BF
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DD5206261;
	Mon, 16 Dec 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X/Kut5C9"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646DC204585;
	Mon, 16 Dec 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358231; cv=none; b=Gv48D2pz5Apy0woNtRf5EJxHtf14YPZlTobdbOizxyBRV8tusZF7Ss6gSwOGoTymBfRyAC40TJZjbY2bl2rT0Jsi8T1LK8P85qiD1GiLkpa7F2oAI49m+PTIdUjvHU5RbAtBW02Y/k73V0DmLH07zyFGn5Nif+QShR+zhe4ofRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358231; c=relaxed/simple;
	bh=nG37q2u8on3vNP2Zolwo/se6L9hAgrE+qzx/aLiEgHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ivkw5suN+QbzRkFh+J05zauTWQa8+vIb8KPGmWFjcUzwHVU1WTJ1XmPztADx4rrvE+SVXB79mOlbNf+ZD956BFu7B7UQl+7lZUGLuDcjDLH5tJeDAjWAqdvPX6f5xXd4ea7Z6P1T/b+HNkMr2anQkhKIGZN+WROTFUcTQ7v/tTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X/Kut5C9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734358227;
	bh=nG37q2u8on3vNP2Zolwo/se6L9hAgrE+qzx/aLiEgHI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=X/Kut5C9BR/t6lHy/V2i347zv2+fSQK6z43ppMtXf3XoZ8zx9bPmwyUX/9fq1hPUy
	 SMjT/t1UZChMLCPo3j1rJsCU2bLxZPYiushZsu2xMhAnIwXY499upS13XDnuX/G+be
	 XEHJkk2r4DFAuwu4pI08PqK6n1wyMQjQ2mZdx5r7ftQooTxB8+MesnNFeb5YmSlf8y
	 fIZKz2vBbE4/ft58kmF0/1Tj8dVz5JWcwreH44kPFZVnu5YyHtSOpIgdTpVYgBBgmu
	 Pok9P3s39Fcmz1LBsMXdWYENdBNJDR9FxyV1fOBtSHoETWS9ILEGUSyYqDYnFNA3SX
	 4m5dz4bQImqhA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF96D17E377E;
	Mon, 16 Dec 2024 15:10:26 +0100 (CET)
Message-ID: <33c632c4-a14b-4901-b758-43763dfb271f@collabora.com>
Date: Mon, 16 Dec 2024 15:10:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] clk: mediatek: mt2701-vdec: fix conversion to
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/12/24 23:13, Daniel Golle ha scritto:
> Commit 973d1607d936 ("clk: mediatek: mt2701: use mtk_clk_simple_probe to
> simplify driver") broke DT bindings as the highest index was reduced by
> 1 because the id count starts from 1 and not from 0.
> 
> Fix this, like for other drivers which had the same issue, by adding a
> dummy clk at index 0.
> 
> Fixes: 973d1607d936 ("clk: mediatek: mt2701: use mtk_clk_simple_probe to simplify driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




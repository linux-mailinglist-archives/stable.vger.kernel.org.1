Return-Path: <stable+bounces-96224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 461A19E16DE
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95E7164CA1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746CC1DFDAB;
	Tue,  3 Dec 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bu9xPqeT"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC861DED71;
	Tue,  3 Dec 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217090; cv=none; b=gJ+xT0VqxQ5BNHljB+ED5OwyDR2qiiTgmsxpKWLkQjwNAQrDT0nc+d4N4BEYeZBVxAG/kYMB3tTUXX5a7ycxXGBM3wkM0NR2N31gYbA8RFO+ca59MDwPxngpCLThKupJavV1y4HG/5g+H/tXzN1cAkzX6AZ2DCw8fbz4JCuwTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217090; c=relaxed/simple;
	bh=76A10C0+a+1sqcPCvHskNVyiLtHtVGvnW0mmH/vp9SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ov3coZKtFj+Wi0p74vIxFa3Uw6oO6aoQJByk++z/747WpZ//8jigNVMdMcaDuChFu5u8cfu+G0obAXtOhZrl4dc08VP5paivv8ValuAe0uwq5fcKeLQAse4ZzchvGevqHkhRDRNMGKO/xetghm8OEHV040DGTVO/cTRXkqBcJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bu9xPqeT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733217084;
	bh=76A10C0+a+1sqcPCvHskNVyiLtHtVGvnW0mmH/vp9SM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bu9xPqeTxO4dscqc9VgQViTib7TqSFnpanUdnKfQWyGwm1YIjpZZbkWCLJI/L6Gho
	 xIITRDYl00sLEe0ifC7Fook7juoWG/ODjQkdnGUNN00bI3dGMDqCgghpzrKk68hJp9
	 xX6wOJwBPZW3qGvGDHUneeop5CSm2M14Pb2A2CkSn7/QATtEY/Y2Wyb65zDqYTqtsO
	 SQxiUPSjzfQOhD9s8G+tFopQkS0Q+rSrPxCA08m0T2X2WWOtUaPXjyFQBzi14otJJo
	 8/xmH/jLex+EDqhuUP7vT/46s3HWc0B5ccihTj9h0DFtZmOPJxGBk37RcBryYWicWO
	 5Unk3i9eKLjHQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1BF9617E14FB;
	Tue,  3 Dec 2024 10:11:24 +0100 (CET)
Message-ID: <4fd73e67-1f39-4f5e-87d7-31e9c355b049@collabora.com>
Date: Tue, 3 Dec 2024 10:11:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 2/2] arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0
 on xhci1 as disabled
To: Chen-Yu Tsai <wenst@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Koichiro Den
 <koichiro.den@canonical.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
References: <20241202081552.156183-1-wenst@chromium.org>
 <20241202081552.156183-2-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202081552.156183-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/12/24 09:15, Chen-Yu Tsai ha scritto:
> [ Upstream commit 09d385679487c58f0859c1ad4f404ba3df2f8830 ]
> 
> USB 3.0 on xhci1 is not used, as the controller shares the same PHY as
> pcie1. The latter is enabled to support the M.2 PCIe WLAN card on this
> design.
> 
> Mark USB 3.0 as disabled on this controller using the
> "mediatek,u3p-dis-msk" property.
> 
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
> Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
> Fixes: b6267a396e1c ("arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240731034411.371178-2-wenst@chromium.org
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




Return-Path: <stable+bounces-96221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D649E18F6
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F1EB37ED2
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56351DE3CF;
	Tue,  3 Dec 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TrHsJBIr"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C765416EBE9;
	Tue,  3 Dec 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217085; cv=none; b=EOFn0J5zsqQumIp/HkiSpMsF8a6B1+Yeopp9UWrTfRVOA4LhQUhgrtBoAJ1pb8Q8xO7oWQ9UnQYadkHqFcS0X53hhXOR9tcSoZwv/cRdRGC9Sn3unPxxTZS5NyqdxxrCuBOa26ZPRlNWDgtlST7QsBu0hztRTxK8UQ9WTOiX+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217085; c=relaxed/simple;
	bh=4z9wjMw37079j2r6buoMpzHyFC0KucYZv+vs9hrEA/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+WDWMd+YSP0/Mz/dmCWHpPqrDI4bXrG52kwzRxP5ivC3PnsSlfse1WRYplX2CRzEdtpMRYtHRpcywsvyWRTIi1cqU9I8Rwewm9j7qFHaBK1MmEKvFqGuCO0cMQYVThktIEwqDsDONwCrGaE+F96XwLEgVX3kcMXJvSEA9FEt7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TrHsJBIr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733217081;
	bh=4z9wjMw37079j2r6buoMpzHyFC0KucYZv+vs9hrEA/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TrHsJBIrhKoyAXs2t27PWe6JrA4sJubI0VZ+lfObSmLFwW/otfwIiCH/fgoy8dXZ3
	 2E85Vyg+ilRC0a40QiXQD2beli51yd8OtB5jy7vrdbSVmKaC4/I745iWJRYlJoGlcw
	 tj/rxrCUneW7twPwuqKmGTlcCFMdqOzv/h+TaHPxtuMihU2Nz/tVcSKGdkDFiqrg1k
	 iPypeQta1oGG+AjXVZB5okA74vyKCXcJiy5RSZxHImbWyi2xImRcSeJdPw0rgpSwOW
	 SgbRVmtqthdAxZkroxMu19GOyGO3aAQ9n7gtkkL538F5xCS3YRacoE93aYt6R84D88
	 5t92VNze4Etiw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7601117E14D7;
	Tue,  3 Dec 2024 10:11:21 +0100 (CET)
Message-ID: <a06f1b59-7f50-41c0-94b4-9c7ebefdc58f@collabora.com>
Date: Tue, 3 Dec 2024 10:11:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 2/2] arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0
 on xhci1 as disabled
To: Chen-Yu Tsai <wenst@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Koichiro Den
 <koichiro.den@canonical.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
References: <20241202081624.156285-1-wenst@chromium.org>
 <20241202081624.156285-2-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202081624.156285-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 02/12/24 09:16, Chen-Yu Tsai ha scritto:
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




Return-Path: <stable+bounces-152552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DF9AD706E
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 14:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796543A40EB
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 12:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82567221FDC;
	Thu, 12 Jun 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pdr3jsG8"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5687B46B8;
	Thu, 12 Jun 2025 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731441; cv=none; b=SpsbHFIUyaU/x6nNCJXUPI6EOC1NzNZRgEevN4UmmoBTqD062cVsdnfoEcsD0qag1EGwVMdnoYAvm52+2uuaLXJIfnhTDJkAYdxoYIaSfk60AOeEqvF6LENVuTGQ7K+jSi/3wNYzg74nCEyxKZoVdOfxSuEbe0YAIBQ3Ubomr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731441; c=relaxed/simple;
	bh=xMj0PeXUpejsICB72qzZq/FU9wUca+EJE4sWUqWhTeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7VMaqWD4eU68EnxbP99yz5RrT+JDjUYMq4rZaWMCH4L73bwsuaP1Z+4SCovQ5+dyF91JBvRLPPRz7QV6mE6EmgrLPPYg6ZufvUDLwgiV/DyLrTSe5QlC1iRE7KA2HLrt+AAr/nYZGY1JYvnHOsC4NL/WN+zA+/Krrz5qV1fL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pdr3jsG8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749731436;
	bh=xMj0PeXUpejsICB72qzZq/FU9wUca+EJE4sWUqWhTeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pdr3jsG8LEBbrTq48ZzhTF8vjLwU0K+gNO+X2iv7Gdtf7LmKBdaFEIz5QMWdeccwD
	 GLCxrTWkvx74UkGx64K3aPq/B4r5m2wWanFUdRsvxE/zkUcEWjvmC0tdmaSl7DthRD
	 5BeuUwEdjAOZP363EEtatAdEPq2wvbL19UMWfJpDqLJEWqCebJY82sVUPdY5Cah+Bp
	 d6wLrrwIXhisc4G9pCT8qm9/8yoDg9PO+QNBA6isGJKMkProKjiDrtP+vHW8of9oIv
	 T0bBlbb2VBZy8YlsWjQe1n9JNo/CshEopiXzxi9osJgM+NETN7+2eF9RvK13lDKGw6
	 5cndkuogjgGWQ==
Received: from [192.168.1.90] (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 48C9D17E06BF;
	Thu, 12 Jun 2025 14:30:35 +0200 (CEST)
Message-ID: <85cb44fd-f597-443e-81b4-e259513aec9f@collabora.com>
Date: Thu, 12 Jun 2025 15:30:23 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: dts: rockchip: Fix HDMI output on RK3576
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-rockchip@lists.infradead.org
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
 <3011644.e9J7NaK4W3@workhorse>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <3011644.e9J7NaK4W3@workhorse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Nicolas,

On 6/12/25 3:13 PM, Nicolas Frattaroli wrote:
> On Wednesday, 11 June 2025 23:47:46 Central European Summer Time Cristian Ciocaltea wrote:
>> Since commit c871a311edf0 ("phy: rockchip: samsung-hdptx: Setup TMDS
>> char rate via phy_configure_opts_hdmi"), the workaround of passing the
>> PHY rate from DW HDMI QP bridge driver via phy_set_bus_width() became
>> partially broken, unless the rate adjustment is done as with RK3588,
>> i.e. by CCF from VOP2.
>>
>> Attempting to fix this up at PHY level would not only introduce
>> additional hacks, but it would also fail to adequately resolve the
>> display issues that are a consequence of the system CRU limitations.
>>
>> Therefore, let's proceed with the solution already implemented for
>> RK3588, that is to make use of the HDMI PHY PLL as a more accurate DCLK
>> source in VOP2.
>>
>> It's worth noting a follow-up patch is going to drop the hack from the
>> bridge driver altogether, while switching to HDMI PHY configuration API
>> for setting up the TMDS character rate.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>> Cristian Ciocaltea (3):
>>       dt-bindings: display: vop2: Add optional PLL clock property for rk3576
>>       arm64: dts: rockchip: Enable HDMI PHY clk provider on rk3576
>>       arm64: dts: rockchip: Add HDMI PHY PLL clock source to VOP2 on rk3576
>>
>>  .../bindings/display/rockchip/rockchip-vop2.yaml   | 56 +++++++++++++++++-----
>>  arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  7 ++-
>>  2 files changed, 49 insertions(+), 14 deletions(-)
>> ---
>> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
>> change-id: 20250611-rk3576-hdmitx-fix-e030fbdb0d17
>>
> 
> For the whole series:
> 
> Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> This fixes HDMI output for 4K resolutions on my RK3576 ArmSoM Sige5.
> The DTB checks and bindings checks pass as well.
Many thanks for the additional testing!

Regards,
Cristian


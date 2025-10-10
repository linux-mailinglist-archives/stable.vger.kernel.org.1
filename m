Return-Path: <stable+bounces-183857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 625E3BCBF71
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 09:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20D284ED235
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25931275111;
	Fri, 10 Oct 2025 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qFSrUJhm"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB4273D8D;
	Fri, 10 Oct 2025 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082225; cv=none; b=hzq/cBJq6yLcotZ3uzup9j8Ror0+ulTqQzRublgMOK+A5IMixLV5kCdoRPE/GyZ779ZXV6091ISl1DwhJ6F35N7BStKL7dlOuPV86q1731zLzo8MiVhw+ZN6caue/cxZAOYopyqDoiNX2pSdxo0vW9etY6J51CxbYlSGzd7Swys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082225; c=relaxed/simple;
	bh=3A2EGFLTM971QVCxPoquHgIyEqh4wjem+jnI3wK3TrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s6ZHM7oflIE93kXEbbR4ZeFjpB4JF0Ih2rlxlth2n6tX5202ruhiRl4wpjqwnPr/ugDFs6aKDaEYWzuFTgXb9dNfl/f/MM5iI2tDhd7+RyGat6s0rdk8zxh2PjlqmY8Oxqe1zho7rRwntG2ddbVB0uasJUYa5cljhDs67WAl5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qFSrUJhm; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59A7h9A8717190;
	Fri, 10 Oct 2025 02:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760082189;
	bh=OFHaJMRCGTbH1ynZiPBQNjStBPjTRzsryo3/+riboCc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qFSrUJhmgUCsUC+RY3Adb3GufRoCIt1R9PU1vp9L152451g0nAzDIIGiXYI3iWkLK
	 i47qtlSQP1WnOTX10zs2iv6ac9PlF+RA/nlpaYO3Mmh+sTp+xcGPaY9q65KLULnTvx
	 Lwn4ZfPsdTx0IJoV+DyFTLet2pjovZAXvGCgTJ60=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59A7h89a625699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 10 Oct 2025 02:43:08 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 10
 Oct 2025 02:43:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Oct 2025 02:43:08 -0500
Received: from [10.249.128.221] ([10.249.128.221])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59A7gwGp1307479;
	Fri, 10 Oct 2025 02:42:59 -0500
Message-ID: <7b728ed9-4aaf-4e79-b8be-d355f82cb96b@ti.com>
Date: Fri, 10 Oct 2025 13:12:57 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drm/tidss: Fixes data edge sampling
To: Louis Chauvet <louis.chauvet@bootlin.com>, Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, "Sam
 Ravnborg" <sam@ravnborg.org>,
        Benoit Parrot <bparrot@ti.com>, Lee Jones
	<lee@kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, <devarsht@ti.com>
CC: <thomas.petazzoni@bootlin.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ti.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>
References: <20250730-fix-edge-handling-v1-0-1bdfb3fe7922@bootlin.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20250730-fix-edge-handling-v1-0-1bdfb3fe7922@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Louis,

On 30-07-2025 22:32, Louis Chauvet wrote:
> Currently the driver only configure the data edge sampling partially. The
> AM62 require it to be configured in two distincts registers: one in tidss
> and one in the general device registers.
> 
> Introduce a new dt property to link the proper syscon node from the main
> device registers into the tidss driver.
> 
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
> ---
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> ---

Just wanted to check if you're planning to send a v2?

Regards,
Swamil

> Louis Chauvet (4):
>        dt-bindings: display: ti,am65x-dss: Add clk property for data edge synchronization
>        dt-bindings: mfd: syscon: Add ti,am625-dss-clk-ctrl
>        arm64: dts: ti: k3-am62-main: Add tidss clk-ctrl property
>        drm/tidss: Fix sampling edge configuration
> 
>   .../devicetree/bindings/display/ti/ti,am65x-dss.yaml       |  6 ++++++
>   Documentation/devicetree/bindings/mfd/syscon.yaml          |  3 ++-
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi                   |  6 ++++++
>   drivers/gpu/drm/tidss/tidss_dispc.c                        | 14 ++++++++++++++
>   4 files changed, 28 insertions(+), 1 deletion(-)
> ---
> base-commit: 85c23f28905cf20a86ceec3cfd7a0a5572c9eb13
> change-id: 20250730-fix-edge-handling-9123f7438910
> 
> Best regards,



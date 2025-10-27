Return-Path: <stable+bounces-190063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3436C0FCE5
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 168104F9AE2
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4DE311C15;
	Mon, 27 Oct 2025 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DfT9TLL1"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0856316911;
	Mon, 27 Oct 2025 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587682; cv=none; b=SbMdZ1lSSCNqwgHxIKS4OTm5nqIt+BbPdPxumDzVcpeGLQ8USx4cn08FaJHN5GQkKMoNQIt7lpW4m6lj/tTKW2oGwy/YOMqf0x1fNzTO7o9cnn1dOKxXvFeDdcALONm6erp+4iLkjuVGrGv14HJ3IvG2nA5rIJksNJwsJ1yL9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587682; c=relaxed/simple;
	bh=KJjCjEUAXMGf93l+7ab3kNT6BgnFhiKNhk4r970RuRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JItwuhY+q1NbPiQg7Z0y0Q3zTAbPCHGr7psfulQHGTCARzNIc9w2Zhfzlipo0fY/tgaE5pfkQJboA+lqzIC3eIqy4RJy2ghc8Az8dGeZGig6AtrsyIM9WgydFoNnfKpdIBMGgEyIUi9T/a8BN1JvvZD0hZVj1C4pC57brP0xxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DfT9TLL1; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59RHrssW2479401;
	Mon, 27 Oct 2025 12:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761587634;
	bh=gFyTNoE2X2hQrZXZgQ1MBu5TC8MY83aQCzpJALZfkd4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=DfT9TLL1J4E5CSALY/kZQMoepMNVcrZdFJ8G15x4Q9Um4UiFHL4anwgTSzoDcKX1P
	 2AOpvzY1e81vSYXz2PEnEreCy/rByPtzdWqPFQattLfXetkj1E4vOmFbyZxBqFzc6A
	 HnYhVaehSyU5gmGxes8Pgh7UejjHh3LcA0DPOZgY=
Received: from DLEE212.ent.ti.com (dlee212.ent.ti.com [157.170.170.114])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59RHrrD81816199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Oct 2025 12:53:53 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 12:53:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 12:53:53 -0500
Received: from [10.249.128.221] ([10.249.128.221])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59RHriYB1061461;
	Mon, 27 Oct 2025 12:53:45 -0500
Message-ID: <dcf71d6b-f453-425f-a49e-2408d0caad20@ti.com>
Date: Mon, 27 Oct 2025 23:23:44 +0530
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
        Tero Kristo <kristo@kernel.org>, "Thakkar, Devarsh"
	<devarsht@ti.com>
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

We are planning to re-spin the series with a v2.
If you have any concerns please inform.

Regards,
Swamil

> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> ---
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



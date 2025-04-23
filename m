Return-Path: <stable+bounces-136463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1497A9977E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 20:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F0446227B
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADA728DEF0;
	Wed, 23 Apr 2025 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="etJnk9LL"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B128C5CA;
	Wed, 23 Apr 2025 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431720; cv=none; b=lJzwUoNYPEgX8w7vKKscVN2roCj1+YFgAEGFoeq1quaHGj+cB0wNC4dj8wDNK1BGSzPHNVhVlk/wTU5oBpaSO6aNKtwlWl/lA79Nq8HB2d3jb46eeJif5degacRGz0vQhyC3eI1S5LDSpLXJiphWfPAIwa18qTAAlf73x5qFPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431720; c=relaxed/simple;
	bh=+Ki4H7wivjI2Q8MWTECBILoqGHb0mMSFqBmPA79zYnk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juagi0Mtc6TKy8sjj+12V4cNPoUF8/PPizdwtdQA3tdWlvz95L/kgF/kGhSnxbCFPgj7+6wr0cMDc++kSjFo8nkbhU6KEO1rTYm8N25yv/SR6toeugKw9JNiWdFm6vN3jBuzeLPZFScnvWgBH9x3oEOPqXv545wfE9y5LQBwejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=etJnk9LL; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53NI8ATV1615961
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 13:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745431690;
	bh=EFWPuqQMAL7NxNHoKz6mQkM5FY+ToS1fRX2hOlbxr9M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=etJnk9LL5YyulNfARr1RPpEstaU5mXL0BY4HyWpMQ0Gf47Ckr+BDOp/N94jB/ydmO
	 ugPHD9U1x8CCzjCg3DnCM7mcrF8MhJ/7/2c4LIGltEzVM+jJRoD3UW7d57RmnHaXVJ
	 k3PysXHTXqvBiBCFZ3BfnwQkf08+VkB4hcdtvUrY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53NI8AMr116997
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Apr 2025 13:08:10 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Apr 2025 13:08:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Apr 2025 13:08:09 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53NI89wp126662;
	Wed, 23 Apr 2025 13:08:09 -0500
Date: Wed, 23 Apr 2025 13:08:09 -0500
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>, Josua Mayer <josua@solid-run.com>,
        "Sverdlin,
 Alexander" <alexander.sverdlin@siemens.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Josua Mayer
	<josua@solid-run.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Hiago De Franco <hiagofranco@gmail.com>, Moteen Shah
	<m-shah@ti.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH RESEND v3 0/3] Add ti,suppress-v1p8-ena
Message-ID: <20250423180809.l3l6sfbwquaaazar@shrank>
References: <20250422220512.297396-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250422220512.297396-1-jm@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 17:05-20250422, Judith Mendez wrote:
> Resend patch series to fix cc list
> 
> There are MMC boot failures seen with V1P8_SIGNAL_ENA on Kingston eMMC
> and Microcenter/Patriot SD cards on Sitara K3 boards due to the HS200
> initialization sequence involving V1P8_SIGNAL_ENA. Since V1P8_SIGNAL_ENA
> is optional for eMMC, do not set V1P8_SIGNAL_ENA by default for eMMC.
> For SD cards we shall parse DT for ti,suppress-v1p8-ena property to
> determine whether to suppress V1P8_SIGNAL_ENA. Add new ti,suppress-v1p8-ena
> to am62x, am62ax, and am62px SoC dtsi files since there is no internal LDO
> tied to sdhci1 interface so V1P8_SIGNAL_ENA only affects timing.
> 
> This fix was previously merged in the kernel, but was reverted due
> to the "heuristics for enabling the quirk"[0]. This issue is adressed
> in this patch series by adding optional ti,suppress-v1p8-ena DT property
> which determines whether to apply the quirk for SD.
[...]
> 
> [0] https://lore.kernel.org/linux-mmc/20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com/

Why cant we use compatible to enable the quirk instead of blindly
enabling for all IPs including ones that have onchip LDOs? That was the
reason it failed in the first place for am64x.

This is very much like a quirk that seems to go hand-in-hand with the
compatible for am62-sdhci ?

Is it worth exploring that option in the driver thread? from where I
stand, this sounds very much like an issue that AM62x IP has, and should
be handled by the driver instead of punting to dts to select where to
use and not to use the quirk.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


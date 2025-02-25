Return-Path: <stable+bounces-119444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDF8A434DB
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 06:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80F43B4F9A
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 05:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4512561D6;
	Tue, 25 Feb 2025 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E6eCWB0J"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324F254856;
	Tue, 25 Feb 2025 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740463093; cv=none; b=Hf1yHSj6mfWoLiDZyhENRb0zGLUJi5gf/t0buKHSI0ezo5/11iXakOyxO9QchiTNmmWe3HLivsh7TF+VQ4bCq31VJtbITj3lZ1BcyIE/2XDL0PBHy9Z7KZE/gD+ZKjccueOSRIhnP0i1cwGPAk6rD9FjgOzp9l5mUjCj8LSLrDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740463093; c=relaxed/simple;
	bh=XFQddjupwHWDf1QiMntCRT3sbOOb0aS0zpeXx93gHx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gm9dvARczmBwT40iVH6yQDqPLtvwsotYY73KQ1MsHnWtTuL4lyZMEenRXohWyaY0o/vDLPJDSzneoucIlch70s2rP05t2RBuz6dTNNRdLkLqnxc581nnAFuuZfyQawoVFRlEOYCjE1WKYzfMw9cIvTACtYFv5qZ8j+eE3uhl/hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E6eCWB0J; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51P5vpku1682408
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 24 Feb 2025 23:57:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740463071;
	bh=Sa7ucSJKWasZ2KGuuAlceNV2b8JCAsYjJZF+dbJsVKo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=E6eCWB0J1TLY5hBPfkrtc1a2eK8EFTk/UyJiTby3O9u/0pw/qwRsMItfJ80h2z3uw
	 +qwXG1ZvE8PrNcO3YTTjFj8sNzEM4UKN+O+XsFh3j2FgLAig7jZYb6v8dMC57zoyex
	 KcK5ejqvpwXouATTxqPcQcCK2OJSpzLyQ/rO+DBk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51P5vp7g009513;
	Mon, 24 Feb 2025 23:57:51 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Feb 2025 23:57:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Feb 2025 23:57:51 -0600
Received: from [172.24.25.83] (lt5cd2489kgj.dhcp.ti.com [172.24.25.83])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51P5vlMG101472;
	Mon, 24 Feb 2025 23:57:48 -0600
Message-ID: <1c110279-ed22-4505-8fe2-2664b9880132@ti.com>
Date: Tue, 25 Feb 2025 11:27:47 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j784s4-j742s2-main-common: Correct
 the GICD size
To: Keerthy <j-keerthy@ti.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzk+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20250218052248.4734-1-j-keerthy@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250218052248.4734-1-j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 2/18/2025 10:52 AM, Keerthy wrote:
> Currently we get the warning:
>
> "GICv3: [Firmware Bug]: GICR region 0x0000000001900000 has
> overlapping address"
>
> As per TRM GICD is 64 KB. Fix it by correcting the size of GICD.
>
> Fixes: 9cc161a4509c ("arm64: dts: ti: Refactor J784s4 SoC files to a common file")
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Cc: stable@vger.kernel.org
> ---

Acked-by: Udit Kumar <u-kumar1@ti.com>


> Changes in V2:
>
> 	* Added the fixes tag
> 	* Cc: stable
>
>   arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> index 83bbf94b58d1..3b72fca158ad 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> @@ -193,7 +193,7 @@
>   		ranges;
>   		#interrupt-cells = <3>;
>   		interrupt-controller;
> -		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
> +		reg = <0x00 0x01800000 0x00 0x10000>, /* GICD */
>   		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
>   		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
>   		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */


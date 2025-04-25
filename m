Return-Path: <stable+bounces-136709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B0DA9CB93
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63573BD6B0
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DD025A341;
	Fri, 25 Apr 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CMPbCM5j"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25422586C4;
	Fri, 25 Apr 2025 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590794; cv=none; b=tcKujb81vLm5UeX+1ilRsdI3n1fAhqV33kmT3tV8L8dLLwrEaigoMja+pz5Xb03LkrOMFeF7Pzo0H77QpgWHXYQZWpzGbdZ+6W4gAr8LjD5i3C6IHSpqmTrcG1+tAn+02K1vP7xG9bXEN14QPQYGSTcHfW3Qq5vDP+lScqkkToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590794; c=relaxed/simple;
	bh=JQVnAF6dZO16oEBhuYTIAHl18b3ICR96jEOLGuSRRkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NrL48uZ9ZTPnWDKTcw9xkF1y3jWZ3mHxV+9VDmoY8AVayy10N3/ueHFbeABxuSkz+ZKBqMF5t0P1OYwJRtazl2dHwv4sB3FuEgLMyGRndYYIKajT3BOX2V/bO487Fy0SkzRM8lYY6x57IDqnxxvkhsJBow9YbRMfbMnqQVfBJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CMPbCM5j; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PEJYF32958153
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 09:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745590774;
	bh=K4BkpaId2cQLJVzZSSqTKt4CRWF10paVXfUx/kEGsA4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CMPbCM5jp4F3Yiw9uztBLruU7FwLSPkZCPZkjgPgu83Du9WlEqBsSUFSwdJRssoxx
	 byDduY3gG7zoZlHvfRZ+X+hAjfSveFB5sYdb/Fb/61qQ4KoyUYMFjyGvNTkhGs1dB1
	 ORfVLxKz1LC+E1C3d9M3R0gTLYVq7qklzrN7n9dc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PEJYuU129550
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 09:19:34 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 09:19:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 09:19:34 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PEJXGO019327;
	Fri, 25 Apr 2025 09:19:33 -0500
Message-ID: <1c657cc6-7667-4a59-85d7-a6f6b29c169b@ti.com>
Date: Fri, 25 Apr 2025 09:19:33 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 1/3] dt-bindings: mmc: sdhci-am654: Add
 ti,suppress-v1p8-ena
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>,
        Adrian
 Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Josua Mayer
	<josua@solid-run.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Hiago De Franco <hiagofranco@gmail.com>, Moteen Shah
	<m-shah@ti.com>,
        <stable@vger.kernel.org>
References: <20250422220512.297396-1-jm@ti.com>
 <20250422220512.297396-2-jm@ti.com>
 <20250425-agile-imported-inchworm-6ae257@kuoka>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250425-agile-imported-inchworm-6ae257@kuoka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,

On 4/25/25 2:48 AM, Krzysztof Kozlowski wrote:
> On Tue, Apr 22, 2025 at 05:05:10PM GMT, Judith Mendez wrote:
>> Some Microcenter/Patriot SD cards and Kingston eMMC are failing init
>> across Sitara K3 boards. Init failure is due to the sequence when
>> V1P8_SIGNAL_ENA is set. The V1P8_SIGNAL_ENA has a timing component tied
>> to it where if set, switch to full-cycle timing happens. The failing
>> cards do not like change to full-cycle timing before changing bus
>> width, so add flag to sdhci-am654 binding to suppress V1P8_SIGNAL_ENA
>> before changing bus width. The switch to full-cycle timing should happen
>> with HIGH_SPEED_ENA after change of bus width.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
>> index 676a74695389..0f92bbf8e13b 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
>> @@ -201,6 +201,11 @@ properties:
>>         and the controller is required to be forced into Test mode
>>         to set the TESTCD bit.
>>   
>> +  ti,suppress-v1p8-ena:
> 
> Do not tell what the drivers should do, but tell what is the issue with
> the hardware, e.g. some cards do not like full-cycle.... and this will
> also hint you that it should be most likely generic, not specific to
> this device.
> 

Thanks for your review, but this patch has been dropped in v4 since
we adopted a new implementation [0] using compatible string.

[0] 
https://lore.kernel.org/linux-devicetree/20250423180809.l3l6sfbwquaaazar@shrank/

~ Judith



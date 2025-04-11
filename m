Return-Path: <stable+bounces-132277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4202A86259
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 17:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96FD3B2955
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAB42135C3;
	Fri, 11 Apr 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T4zt6GBZ"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839FC35961;
	Fri, 11 Apr 2025 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386739; cv=none; b=GULv4SLwgCLnV3NPIsyKuJcEPIiMTtVVSbia/WUcU2OhKou/TJxOyLQruS5gT/grkujfG/9m5HdiPGQx6QcuTPLabT/S039gYzTCNpnjeQMgRG96LwtbozvlqUJB9uXlTF5xatgoiJeTfEXp5v/75r9q0OgYXOAyX6Hs8lNEr7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386739; c=relaxed/simple;
	bh=E8+IDs1XgDEHII66e1FhtR8QtgunZIE14bTYSZOPaYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j5KnP48F3lY2mf7IN3vxs15PO5Bzf6uxP/56c0wZH1Wki8n5kvVoBijXvE566k7ONSv4xEJbgL5jL4n3ZCkGeS+rtdNprcegDwWOhjrjmDrcSQI7Jp7M8knH6v0GBFiSYVwqLg6DD8YmMywtkk13Ty2q8rldPOog16HGS/sIeHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T4zt6GBZ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BFq57r1486028
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 10:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744386725;
	bh=VEBB3+nk9eRMLAfQSWyx+3KioB6f3dgvNv/THggbzWE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=T4zt6GBZzgqzkard/K33ATb/J8UEtV1ATL2CoVX6zoLf3NqE+q+B632UQ+o3WNjdQ
	 fjCFyGf7+NwZ+fTX6DTSFxTkz+4bOVH6V1X9Wcn7XhaRRPkU2TQS1KiElgDpB9DIfk
	 mb8Q4etS63M/MZirOyG+nGK8UOMoGI/KpWTI3Wt0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BFq52E035194
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 10:52:05 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 10:52:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 10:52:05 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BFq1dm026503;
	Fri, 11 Apr 2025 10:52:01 -0500
Message-ID: <28f1e0b7-9947-43f3-9a47-f3c6ecd69b91@ti.com>
Date: Fri, 11 Apr 2025 21:22:00 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j722s-main: Disable
 "serdes_wiz0" and "serdes_wiz1"
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <u-kumar1@ti.com>
References: <20250408103606.3679505-1-s-vadapalli@ti.com>
 <20250408103606.3679505-3-s-vadapalli@ti.com>
 <7b2f69ad-48aa-4aa9-be0e-f0edae272bdb@ti.com>
 <475a1ac1-abb1-4c6e-b5b2-3f1a3399d5c4@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <475a1ac1-abb1-4c6e-b5b2-3f1a3399d5c4@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi

On 4/11/2025 7:47 PM, Siddharth Vadapalli wrote:
> On Fri, Apr 11, 2025 at 07:31:52PM +0530, Kumar, Udit wrote:
>
> Hello Udit,
>
>> On 4/8/2025 4:06 PM, Siddharth Vadapalli wrote:
>>> Since "serdes0" and "serdes1" which are the sub-nodes of "serdes_wiz0"
>>> and "serdes_wiz1" respectively, have been disabled in the SoC file already,
>>> and, given that these sub-nodes will only be enabled in a board file if the
>>> board utilizes any of the SERDES instances and the peripherals bound to
>>> them, we end up in a situation where the board file doesn't explicitly
>>> disable "serdes_wiz0" and "serdes_wiz1". As a consequence of this, the
>>> following errors show up when booting Linux:
>>>
>>>     wiz bus@f0000:phy@f000000: probe with driver wiz failed with error -12
>>>     ...
>>>     wiz bus@f0000:phy@f010000: probe with driver wiz failed with error -12
>>>
>>> To not only fix the above, but also, in order to follow the convention of
>>> disabling device-tree nodes in the SoC file and enabling them in the board
>>> files for those boards which require them, disable "serdes_wiz0" and
>>> "serdes_wiz1" device-tree nodes.
>>>
>>> Fixes: 628e0a0118e6 ("arm64: dts: ti: k3-j722s-main: Add SERDES and PCIe support")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>
>>> v1 of this patch is at:
>>> https://lore.kernel.org/r/20250408060636.3413856-3-s-vadapalli@ti.com/
>>> Changes since v1:
>>> - Added "Fixes" tag and updated commit message accordingly.
>>>
>>> Regards,
>>> Siddharth.
>>>
>>>    arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
>>> index 6850f50530f1..beda9e40e931 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
>>> @@ -32,6 +32,8 @@ serdes_wiz0: phy@f000000 {
>>>    		assigned-clocks = <&k3_clks 279 1>;
>>>    		assigned-clock-parents = <&k3_clks 279 5>;
>>> +		status = "disabled";
>>> +
>> Since you are disabling parent node.
>>
>> Do you still want to carry status = "disabled" in child nodes serdes0 and
>> serdes1.
> I could drop it, but then the patches will look something like:
> 1) Patch 1: Same as the first patch in this series
> 2) Patch 2: Current patch + Remove status = "disabled" within serdes0/1
> 3) Patch 3: Removed redundant status = "okay" within serdes0/1 in
>              k3-j722s-evm.dts
>
> Updated Patch 2 and the new Patch 3 mentioned above aren't necessarily a
> complete "Fix" and have other changes in addition to the "Fix". For that
> reason, the changes associated with the updated patch 2 and the new patch 3
> could be a separate series, unless you believe that they should go
> together in the current series. Please let me know.

I don't see any use case where serdes_wiz0 is enabled and serdes0 is 
disabled.

So your comment 3) is valid. you can take this clean up in other series


For now

Reviewed-by: Udit Kumar <u-kumar1@ti.com>



> Regards,
> Siddharth.


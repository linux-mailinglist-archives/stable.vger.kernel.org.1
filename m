Return-Path: <stable+bounces-166875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96972B1ECFC
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D9E7AA0B4
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59602874E9;
	Fri,  8 Aug 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XMWxkwQ0"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3F285CB6;
	Fri,  8 Aug 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670436; cv=none; b=dF97d7fIwU71iqnqA6vLKzitljidsGp5VJ5+0Y/uPEadrMkaFEtr36YYSd4AbdhyYfphpGZREMyVj3owb023HwdSupruFma7MM7mfz2jkuVTKOYznbbzk4B88qL156gHd/TFI/hR1Zp9Qkdls/dTaL3Cxj0PbXzVUdzc2477bGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670436; c=relaxed/simple;
	bh=xFne119Sk5jVHcgB6+/zQd+cP6Yd4d8i+fOvItwcJQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P8HJJcBjQj3emVm3elt4RMg2hEANROKxjtmpONdJnbnH/oJQ34hU1ZIu8PioXwLUkeo5h7sEq4IdJD2davKK8kQM/htivLNUpYgDVu5DBernkYY0d1CiRkXxZpT4gAYMAxVAJWilGpOAJ44uzz32YTre3wYcV1neQMrZ038aLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XMWxkwQ0; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 578GQZeC634811;
	Fri, 8 Aug 2025 11:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754670395;
	bh=4ACrg0VZ/ROx1Hmh9K1St6WzunO2A1EMiSibHesgeF0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XMWxkwQ0jmo691K7riYPdzo3PLTS2eGjFMQIu2d14I6FVIqLU7Kz+fPQN1tGIP5Sb
	 Enhm7s1Oa9cCSFprWvAa+20CQUeuJOy3sVvNRWYgWFVBPFP6rVcDFciafiHzGJUzEb
	 v8Rqo9nCFfN7TbQHA3RcG4UJ+zyFIJ5iRlVGORNo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 578GQZCE1746701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 8 Aug 2025 11:26:35 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 11:26:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 11:26:34 -0500
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 578GQRKY3012854;
	Fri, 8 Aug 2025 11:26:28 -0500
Message-ID: <f15779ad-788a-4dc6-b5a6-4187b9a9c986@ti.com>
Date: Fri, 8 Aug 2025 21:56:26 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/tidss: Fix sampling edge configuration
To: devarsh <devarsht@ti.com>, Louis Chauvet <louis.chauvet@bootlin.com>,
        "Jyri Sarha" <jyri.sarha@iki.fi>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sam
 Ravnborg <sam@ravnborg.org>,
        Benoit Parrot <bparrot@ti.com>, Lee Jones
	<lee@kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: <thomas.petazzoni@bootlin.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ti.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>
References: <20250730-fix-edge-handling-v1-0-1bdfb3fe7922@bootlin.com>
 <20250730-fix-edge-handling-v1-4-1bdfb3fe7922@bootlin.com>
 <71ef3203-e11d-4244-8d2d-8e47e8ba6140@ti.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <71ef3203-e11d-4244-8d2d-8e47e8ba6140@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 8/8/25 19:16, devarsh wrote:
> Hi Louis,
> 
> Thanks for the patch.
> 
> On 30/07/25 22:32, Louis Chauvet wrote:
>> As stated in the AM62x Technical Reference Manual (SPRUIV7B), the data
>> sampling edge needs to be configured in two distinct registers: one in the
>> TIDSS IP and another in the memory-mapped control register modules.
> 
> I don't think AM62x is thee only one which requires this and on the
> contrary not all SoCs require this extra setting. We had been waiting on
> confirmations from hardware team and very recently they gave a list of
> SoCs which require this, as per that I think we need to limit this to
> AM62x and AM62A per current supported SoCs.
> 
> Swamil,
> Please confirm on this and share if any additional details required here.
> 

Yeah Devarsh, as you mentioned, this is valid for AM62X, AM62A and 
AM62P. We would have upstreamed this feature, but there are some 
corrections in Technical Reference Manual for these SoCs regarding 
programming CTRL_MMR_DPI_CLK_CTRL register fields, we are in loop with 
H/W team, waiting for their official confirmation regarding this issue.

Thanks Louis for working on this patch, but we should wait for H/W 
team's confirmation.

Regards,
Swamil.

> Regards
> Devarsh
> 
>   Since
>> the latter is not within the same address range, a phandle to a syscon
>> device is used to access the regmap.
>>
>> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
>> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>>
>> ---
>>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/gpu/drm/tidss/tidss_dispc.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
>> index c0277fa36425ee1f966dccecf2b69a2d01794899..65ca7629a2e75437023bf58f8a1bddc24db5e3da 100644
>> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
>> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
>> @@ -498,6 +498,7 @@ struct dispc_device {
>>   	const struct dispc_features *feat;
>>   
>>   	struct clk *fclk;
>> +	struct regmap *clk_ctrl;
>>   
>>   	bool is_enabled;
>>   
>> @@ -1267,6 +1268,11 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
>>   		       FLD_VAL(mode->vdisplay - 1, 27, 16));
>>   
>>   	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1, 0, 0);
>> +
>> +	if (dispc->clk_ctrl) {
>> +		regmap_update_bits(dispc->clk_ctrl, 0, 0x100, ipc ? 0x100 : 0x000);
>> +		regmap_update_bits(dispc->clk_ctrl, 0, 0x200, rf ? 0x200 : 0x000);
>> +	}
>>   }
>>   
>>   void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
>> @@ -3012,6 +3018,14 @@ int dispc_init(struct tidss_device *tidss)
>>   
>>   	dispc_init_errata(dispc);
>>   
>> +	dispc->clk_ctrl = syscon_regmap_lookup_by_phandle_optional(tidss->dev->of_node,
>> +								   "ti,clk-ctrl");
>> +	if (IS_ERR(dispc->clk_ctrl)) {
>> +		r = dev_err_probe(dispc->dev, PTR_ERR(dispc->clk_ctrl),
>> +				  "DISPC: syscon_regmap_lookup_by_phandle failed.\n");
>> +		return r;
>> +	}
>> +
>>   	dispc->fourccs = devm_kcalloc(dev, ARRAY_SIZE(dispc_color_formats),
>>   				      sizeof(*dispc->fourccs), GFP_KERNEL);
>>   	if (!dispc->fourccs)
>>
> 


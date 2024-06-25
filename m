Return-Path: <stable+bounces-55135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD5B915E19
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 07:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6A61C2264B
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 05:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BC1143C69;
	Tue, 25 Jun 2024 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nyFwUeDW"
X-Original-To: stable@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206547F46;
	Tue, 25 Jun 2024 05:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292649; cv=none; b=UcZGVKsOpf6jbn1MjkLunlbaGt6hk3bonJAIp4A47y/QbV/ISh5QyRANRTqrf7LLC48BJydVeOUf3wFysdbT9MujVJVC3N0VTt3j4dv3BAzfa0AhvTUSNY5Q9tp4+tSFQcj3x1lE1lcePC6vkvu30e+y/qz14h3s3Lq97EdUTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292649; c=relaxed/simple;
	bh=kKEzwIllrYUuw0Sa+Do/4ImEmbkmUx5yhS9oPBdKIdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=thJbRETbKPUbjZ2HmSp04yhpIwfefJlXcNWByqxqFfFBb/CKw+D27ApVQUCNdWCHovBfZN4RdbXLzs9Y59gwH8g/Z3o/LvynTti5XIoDammUBhe3AOQdstk0Is74/LnNpLdQiQ7lgA5DenEfLX9LmsiTyKLvitfsUjmjOlhFs9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nyFwUeDW; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45P5H9Pp049307;
	Tue, 25 Jun 2024 00:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719292629;
	bh=kKEzwIllrYUuw0Sa+Do/4ImEmbkmUx5yhS9oPBdKIdA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=nyFwUeDWl5kxo+Iaj2X42YugKv7mwl+yIh77y+8rnsIvH6OPJ4OVPKMkdiI4h3aFp
	 thlsslkv95Sm1rBdyZCOt8VGofnK4RRguz+epyDjh+3kTTh+dxvMeni7rfpGUoLCmo
	 mQOew2jf6P9ZtIcqschtinw45TvXpCDFMIIRNgic=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45P5H9kJ019142
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 00:17:09 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 00:17:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 00:17:08 -0500
Received: from [172.24.18.200] (lt5cd2489kgj.dhcp.ti.com [172.24.18.200])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45P5H4wS050209;
	Tue, 25 Jun 2024 00:17:05 -0500
Message-ID: <ffbe6439-9696-4abe-976b-07286b37a219@ti.com>
Date: Tue, 25 Jun 2024 10:47:04 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] serial: 8250_omap: Implementation of Errata i2310
To: Greg KH <gregkh@linuxfoundation.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <tony@atomide.com>, <jirislaby@kernel.org>,
        <ronald.wahl@raritan.com>, <thomas.richard@bootlin.com>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <stable@vger.kernel.org>
References: <20240624165656.2634658-1-u-kumar1@ti.com>
 <2024062525-venue-twine-aa79@gregkh>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <2024062525-venue-twine-aa79@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Thanks Greg

On 6/25/2024 10:10 AM, Greg KH wrote:
> On Mon, Jun 24, 2024 at 10:26:56PM +0530, Udit Kumar wrote:
>> As per Errata i2310[0], Erroneous timeout can be triggered,
>> if this Erroneous interrupt is not cleared then it may leads
>> to storm of interrupts, therefore apply Errata i2310 solution.
>>
>> [0] https://www.ti.com/lit/pdf/sprz536 page 23
>>
>> Fixes: b67e830d38fa ("serial: 8250: 8250_omap: Fix possible interrupt storm on K3 SoCs")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> As I have already taken the v3 patch to my tree, please send a "fix"
> patch on top of it, as I can not rebase a public tree.


I posted delta patch on top

https://lore.kernel.org/all/20240625051338.2761599-1-u-kumar1@ti.com/


> thanks,
>
> greg k-h


Return-Path: <stable+bounces-78247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF741989FF1
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 12:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604D41F23804
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A7618F2D6;
	Mon, 30 Sep 2024 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJzrVGhr"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931D18D625
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693766; cv=none; b=LJTP6VV66rOkPQ+FwOYHNQY3UzAA8HmbKfrm9xoi1YvM4M1zVjg6qDUqDCEiTWkCjLtaGjdqdjMh5/hAdPwN4qG/wl+nPvyWi8cRSi9VuT2y93duS1obg95mO8D/r1CqXzPrNcz0UuqENmpaMFjYcFiWHf6GELMArdYzDgo5Bss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693766; c=relaxed/simple;
	bh=dR9suNrRJ44duM3r1Q6StJC59Z452p8Rii9pMStewp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suaOWsOp38BCwzNJ793f+oInbyj0ROQZKG+QM1si5Yog/xlEVQZX/E0TvLPpWG99GsPdOYN7RZFW7gRj9qzb3D1LKc0nQHm5gn0jI5Hg/ZYOKq9aHoAJ0roEeOxscRIbQTIPX7dMyM6gszDHfguHo3JD+CrwlDLmcSy0AP7Emd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJzrVGhr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727693763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtxN+3cHW/MCbFS+sS78zrnOjkifHZNOHgOrxlJNQsM=;
	b=EJzrVGhrTAPM7Tqtueasq99RKNLxdqzsP+QQRPU911Fu0gzt3zMLTaeUMV3xlY5n1Ovkr3
	w6kMZE0Z7qF86Y0C9pmy6TaLwM7Z49nJhXlsjeMZj70eyReTRSM3FhcTMLh1AE2ljR9sQh
	TvGfP6O2CaOaHjypwjOH9lXB5Q3wswI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-QsMqEGJZNryxCW_RI3Sklg-1; Mon, 30 Sep 2024 06:56:02 -0400
X-MC-Unique: QsMqEGJZNryxCW_RI3Sklg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8a8308cceaso529521566b.0
        for <stable@vger.kernel.org>; Mon, 30 Sep 2024 03:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727693759; x=1728298559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtxN+3cHW/MCbFS+sS78zrnOjkifHZNOHgOrxlJNQsM=;
        b=JCYOdcBme7B16lqWaN7NPz/UDd64ckAL+nMkAYQ8xix/JIdIc4bEXqgDU+YGGycg0H
         oSPwNWt0ecv8NAuYz/MVHGnEzg1s/JieFKOcjMmoNTp914CwPMtFmpHCI/gB/hWcvFb8
         1qHbHeuwUc62mMHHGQqEOkqVCYyOLAKM3mpSnJnoBf+OifFs1TPug+00oJ6pZ18KAzve
         OLBdPBcwi4nZwCJGGrT4L1zE1wAJe7XiV6nmCtyS3HQTVaDKajeFifqb578eBMCrFyCx
         irkHp22VknUeqjeXKjs+vh3k94EiUbTejHXtBWd+hbmlTZfHQROuf+JOFa/WKofk+Jxq
         jIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTsg6jOqs8YWjdtL9hDRurxSgyLHH3zOiVbJG+gm4E2VH/hRC6KvinFscl2TGfNX3/oa+ySfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOLn4Rq1aB1ZUb40J/5UR5+O5b9TkleG5gWja/jpD4ijZA4ZQ+
	8o1976IsUo1JAmYUPD3V6wHK/4gxi3fOBkOiHOQI6RAsc1clYv3e56BQ/SHu6WqZmfD67jvyyO7
	/oS/kBFeNEQO2q9KSd/ly1FVNfrMVmqw7iORP8e1t3CFpFxB5j9RfgQ==
X-Received: by 2002:a17:907:3e1c:b0:a6f:996f:23ea with SMTP id a640c23a62f3a-a93c30f0cccmr1238477266b.15.1727693759577;
        Mon, 30 Sep 2024 03:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi/hs7OEbEIGmJT/V/6dxdvcEhceTNVfUUTlc3IUi2sJzt/o81jkPPQLkXkiAKRM160Y83RA==
X-Received: by 2002:a17:907:3e1c:b0:a6f:996f:23ea with SMTP id a640c23a62f3a-a93c30f0cccmr1238475466b.15.1727693759184;
        Mon, 30 Sep 2024 03:55:59 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2998d5dsm514130166b.199.2024.09.30.03.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 03:55:58 -0700 (PDT)
Message-ID: <d69af7ad-244d-45e8-ad7e-4a3ebf30d04d@redhat.com>
Date: Mon, 30 Sep 2024 12:55:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ACPI: resource: Loosen the Asus E1404GAB DMI match to
 also cover the E1404GA
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Ben Mayo <benny1091@gmail.com>,
 Tamim Khan <tamim@fusetak.com>, linux-acpi@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <20240927141606.66826-1-hdegoede@redhat.com>
 <20240927141606.66826-2-hdegoede@redhat.com>
 <2f45a6ac-5bb7-4954-adb5-3bf706363062@molgen.mpg.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2f45a6ac-5bb7-4954-adb5-3bf706363062@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 30-Sep-24 12:42 PM, Paul Menzel wrote:
> Dear Hans,
> 
> 
> Thank you for your patch.
> 
> Am 27.09.24 um 16:16 schrieb Hans de Goede:
>> Like other Asus Vivobooks, the Asus Vivobook Go E1404GA has a DSDT
>> describing IRQ 1 as ActiveLow, while the kernel overrides to Edge_High.
>>
>>      $ sudo dmesg | grep DMI:.*BIOS
>>      [    0.000000] DMI: ASUSTeK COMPUTER INC. Vivobook Go E1404GA_E1404GA/E1404GA, BIOS E1404GA.302 08/23/2023
>>      $ sudo cp /sys/firmware/acpi/tables/DSDT dsdt.dat
>>      $ iasl -d dsdt.dat
>>      $ grep -A 30 PS2K dsdt.dsl | grep IRQ -A 1
>>                  IRQ (Level, ActiveLow, Exclusive, )
>>                      {1}
>>
>> There already is an entry in the irq1_level_low_skip_override[] DMI match
>> table for the "E1404GAB", change this to match on "E1404GA" to cover
>> the E1404GA model as well (DMI_MATCH() does a substring match).
> 
> Ah, good to know. Thank you for fixing it.
> 
>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219224
>> Cc: Tamim Khan <tamim@fusetak.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Note this patch replaces Paul Menzel's patch which added a new entry
>> for the "E1404GA", instead of loosening the "E1404GAB" match:
>> https://lore.kernel.org/linux-acpi/20240911081612.3931-1-pmenzel@molgen.mpg.de/
>> ---
>>   drivers/acpi/resource.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 1ff251fd1901..dfe108e2ccde 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -504,10 +504,10 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
>>           },
>>       },
>>       {
>> -        /* Asus Vivobook Go E1404GAB */
>> +        /* Asus Vivobook Go E1404GA* */
> 
> I guess people are going to grep for the model, if something does not work, so maybe the known ones should listed. I know it’s not optimal, as the comments are very likely be incomplete, but it’s better than than not having it listed, in my opinion.

That is a valid point, OTOH I don't think we want to take patches later just to update
the comment if more models show up.

I guess we could change the comment to:

		/* Asus Vivobook Go E1404GA / E1404GAB */

Rafael any preference from you here ?   (1)

Regards,

Hans





1) Other then coming up with a better fix which does not require this quirks at all ...


> 
>>           .matches = {
>>               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> -            DMI_MATCH(DMI_BOARD_NAME, "E1404GAB"),
>> +            DMI_MATCH(DMI_BOARD_NAME, "E1404GA"),
>>           },
>>       },
>>       {
> 
> 
> Kind regards,
> 
> Paul
> 



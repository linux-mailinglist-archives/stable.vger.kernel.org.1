Return-Path: <stable+bounces-74013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3482F971901
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3267E2859DA
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830521B78FA;
	Mon,  9 Sep 2024 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nta8qH1k"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B21B78F7
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883917; cv=none; b=aD/SIFR2xvaIXzZMRwqFq/AjOFToCpqnJg3SZ0JxOAfY3Pkha2bMXntzJPnHKmqG1odsh7SZNgEww9nhzMjMA61KhZ8qNZE6QRFThKeZp00GkcmpWS2N0RLFk6udvLkzvPVjhSUIeKubn456bIjSPspiHx6sEP/+tZ4IcGo5Bp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883917; c=relaxed/simple;
	bh=dUQj9zWUfU/akRgrXFiIBsQ/RyA2KdiEw7fJtNodFug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FK+wN0PTFY4VTvSzBYpuu+43zFfDmb2JDkWHKvaa9iEzNAXB70oFyN0iuhi37/UGtP0mDPHbLdMkZyBAhT41waBZ2mJHXTJPXfqbMPUzqsBJh/3y0tkBTRMxVyvKKh/YioXM+9NofQR0Q+VFpCODe+S+tjmWBVoHT95rCSs2OHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nta8qH1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725883914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INtvbWXQtYAK0r10sLjdX9ETH/d5KrFD0FlLWwAg8cI=;
	b=Nta8qH1klJv2oalh0CL7xnruD9Aurhuuki/tPd1D5el8z2ZGndQYVbYr6B58vNFs42266E
	jPLqwnOW7tTuHbTRwOEaIMAbFpsEzwlofzu336XAzXGmjuwRHrHx0sWXdrLyxonoPq9h6K
	83fvpIotq/6MOLS4XzLyTZfDw5mdph8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-c6fagGk1OJe8Fj6Cij8hFQ-1; Mon, 09 Sep 2024 08:11:53 -0400
X-MC-Unique: c6fagGk1OJe8Fj6Cij8hFQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8a8d9a2a12so215014266b.3
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 05:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725883912; x=1726488712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INtvbWXQtYAK0r10sLjdX9ETH/d5KrFD0FlLWwAg8cI=;
        b=KE91Oc3AfeSC/4bajEEYU11Meizc2yAZyeGdAx79YiI3MIKyTU2y4YfgsfPy8XYo9c
         4Olr/wvkMgjrFOFG0IZWNvu74aq34bv1rFVYO3C6GrXnJbE7cByO+yj15wPql+w4sdwD
         Ri/WI1piWnGpwrFiApf2nUIa1NYrb2BIZDAPjWPZx/A+CGMKrbkhAgBE/cHNDlNa8J8W
         K0Ug1LleMyctgMH5IRlAycabjY7SacBBSLNSMy3nVlZm1++eGUg8pqgzaTZqDYTQXyM8
         mR4uKZ/wMnV+SHT7XSA1coJeCxSJEvplNJijnhLZLU+KUh06oADSA54ZDz220eGQ3Jyc
         Tcig==
X-Forwarded-Encrypted: i=1; AJvYcCU6XC8ZEn2zna+rvwWk0OetE9W/Fq9cl3auBGc5hAOA5rALV/WtsEqen5D2b5wlTVQMdp7b1yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznL37youhqMu+OS8+C0sgNLtfPCvWz9pnotiKwVl/SSDeUX1cl
	jhOt3+7KXsepimBZl4kOS7ic1LTTBa8bjLFGEmsZTy1Fc03y0hXdSq+Y4Kd5uKLxEPqSbl+4ch1
	XT71yoDSr0IjYCQXpLu6kkBqJaFMAM0uOkLTuvnshrFUddNrduGg8hg==
X-Received: by 2002:a17:907:f1d1:b0:a87:31c:c6c4 with SMTP id a640c23a62f3a-a8d2457be3cmr439707266b.24.1725883912027;
        Mon, 09 Sep 2024 05:11:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwqZSYmIbXYEfKEoLHC6r7yAv3jN4sCFK0fSKNiG5IJ6voTB2jO0YvO7eT0t66seATKx2Kbw==
X-Received: by 2002:a17:907:f1d1:b0:a87:31c:c6c4 with SMTP id a640c23a62f3a-a8d2457be3cmr439703466b.24.1725883911379;
        Mon, 09 Sep 2024 05:11:51 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c62541sm336253766b.111.2024.09.09.05.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 05:11:50 -0700 (PDT)
Message-ID: <a8fc0357-8358-4a35-b094-4667e5aa20d5@redhat.com>
Date: Mon, 9 Sep 2024 14:11:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] platform/x86: panasonic-laptop: Fix SINF array out
 of bounds accesses
To: Andy Shevchenko <andy@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 James Harmison <jharmison@redhat.com>, platform-driver-x86@vger.kernel.org,
 stable@vger.kernel.org
References: <20240909113227.254470-1-hdegoede@redhat.com>
 <Zt7kzwtNRdohoC-x@smile.fi.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Zt7kzwtNRdohoC-x@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/9/24 2:06 PM, Andy Shevchenko wrote:
> On Mon, Sep 09, 2024 at 01:32:25PM +0200, Hans de Goede wrote:
>> The panasonic laptop code in various places uses the SINF array with index
>> values of 0 - SINF_CUR_BRIGHT(0x0d) without checking that the SINF array
>> is big enough.
>>
>> Not all panasonic laptops have this many SINF array entries, for example
>> the Toughbook CF-18 model only has 10 SINF array entries. So it only
>> supports the AC+DC brightness entries and mute.
>>
>> Check that the SINF array has a minimum size which covers all AC+DC
>> brightness entries and refuse to load if the SINF array is smaller.
>>
>> For higher SINF indexes hide the sysfs attributes when the SINF array
>> does not contain an entry for that attribute, avoiding show()/store()
>> accessing the array out of bounds and add bounds checking to the probe()
>> and resume() code accessing these.
> 
> ...
> 
>> +static umode_t pcc_sysfs_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct acpi_device *acpi = to_acpi_device(dev);
>> +	struct pcc_acpi *pcc = acpi_driver_data(acpi);
> 
> Isn't it the same as dev_get_drvdata()?

No I also thought so and I checked. It is not the same,
struct acpi_device has its own driver_data member, which
this gets.


> 
>> +	if (attr == &dev_attr_mute.attr)
>> +		return (pcc->num_sifr > SINF_MUTE) ? attr->mode : 0;
>> +
>> +	if (attr == &dev_attr_eco_mode.attr)
>> +		return (pcc->num_sifr > SINF_ECO_MODE) ? attr->mode : 0;
>> +
>> +	if (attr == &dev_attr_current_brightness.attr)
>> +		return (pcc->num_sifr > SINF_CUR_BRIGHT) ? attr->mode : 0;
>> +
>> +	return attr->mode;
>> +}
> 
> ...
> 
>> +	/*
>> +	 * pcc->sinf is expected to at least have the AC+DC brightness entries.
>> +	 * Accesses to higher SINF entries are checked against num_sifr.
>> +	 */
>> +	if (num_sifr <= SINF_DC_CUR_BRIGHT || num_sifr > 255) {
>> +		pr_err("num_sifr %d out of range %d - 255\n", num_sifr, SINF_DC_CUR_BRIGHT + 1);
> 
> acpi_handle_err() ?

The driver is using pr_err() already in 18 other places, so IMHO it is better
to be consistent and also use it here.

Regards,

Hans



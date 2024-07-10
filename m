Return-Path: <stable+bounces-58986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1FC92CEBA
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 12:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808761C20B24
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 10:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694E118FC6F;
	Wed, 10 Jul 2024 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyFb3FRj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960618FA32
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605597; cv=none; b=I4khLFLpmX0RqQWaQgYczTWbLoQHQqw53hPxXTpRO0RKUmMvs0tmvGqxl3sH+hOLaO8gmDhnb9dzIueaUhOCmyhFM+Rv+dkQoXVUgFnBdgD8ZnTbHkKMkxl65issETB4CBhtRIIhynDl3y5YMK5yiazxjZxk89EjmQmHRgykhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605597; c=relaxed/simple;
	bh=ZkE1bV+5dqKs9zBEfCKHUdeXbA/g6X79LkJPlrpjd8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kInVFYgHiRIhQt0mrP0oxnN+24F+1IfHB3jQFPFIk2rolNWtv5nTlW2XXZ7Q447A+giCgy/4Z38IbyRY+tXtoAhXrPLjtAbpUlBZHRu/OrV2Rg/d2aZ8lIEKMaB2Dr5/JKh1AuIAvnXxzLDEG68ZgzlrqfyP7uS0AMlItH58TdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyFb3FRj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720605594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLxyb06M9OF7tGSK1sebYwuTJMPMxYQY3JflFoHNWPk=;
	b=iyFb3FRjY0bfuweFhFvu/laOld1KivgpPQT42m+H1ENYNmyZsv55uQkEkUVeRMGktkFgL0
	dPB0woTbOzgijetIiurnDgcQdPjZQtL41cOLMz9reaekbaaFb3gisLf7ASZGsU5QcIiW+n
	f02GbvOzA4RnSBrP3NR+fhKtvK9I4NY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-rD5dSwUyPd2mRBonmMO9gA-1; Wed, 10 Jul 2024 05:59:52 -0400
X-MC-Unique: rD5dSwUyPd2mRBonmMO9gA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a77f0eca75bso281585366b.1
        for <stable@vger.kernel.org>; Wed, 10 Jul 2024 02:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720605590; x=1721210390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLxyb06M9OF7tGSK1sebYwuTJMPMxYQY3JflFoHNWPk=;
        b=aY6GbDnhesbNzkG33zjDPIKztnqp/YiZPqaL6qxnFRRujyPF/NKvGMw5nfShHQJiEx
         rAJtojRW/vGRaOEqr1SVW26er1ROHqcJEjl7gn6qqv5UWrOnK9UT+jUv292ovymCfq8Q
         uusFPEYZwqjnWnc1IinKpl7N3gzU0yG3YlWwsyGWMOZerg/WPsOzmHsfePKEBeJztrjr
         KTTiImVCU7HMdyuA08FIVdgMf1CnPICmfNKGfRVtbPaNYwuUpqGg1PKfcdRgaOTptjax
         A7+TOEw8K3ANzvjp+5DwEh7MvGBzIbc0GLtVjcP8+PzbPGkb5wqycBpeLvkF2EU2za4B
         DodQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzffnkT5GqF3hmHx14XP7+7LFAnYmTURZ1cM8fMZOZyQ2nI6qCSp4A8jn0OQq3gVjuu2TQ4twH8ZD6088ISmBl/h7Zhk5N
X-Gm-Message-State: AOJu0YyW0GWXdLB0ON0n5J+TSN93MReuo+Viz/AdILLvJibNki4lL+Am
	bcF/jefdqg+d+CFZ5AmyxD2gl/l+XF3ZHwTKafx+p43V4CzegyfDKfocIhdEDl4vdBqzRCN/ecK
	/nceBhI8LHPyQAxAAXKfbWzkhEuMVULOQeC8QTST8nJ1Ys+N4mgSQvKts8C2Mrl22
X-Received: by 2002:a17:907:2d2b:b0:a75:2d52:8ca8 with SMTP id a640c23a62f3a-a780b89f457mr432509366b.75.1720605590299;
        Wed, 10 Jul 2024 02:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOVv5tjV+ZXhGBNceewPQ0SKgmJuebVyZTWcQNIYlT/xWngzHd590SoEr9Bq/atGdH5wEU1A==
X-Received: by 2002:a17:907:2d2b:b0:a75:2d52:8ca8 with SMTP id a640c23a62f3a-a780b89f457mr432506866b.75.1720605589935;
        Wed, 10 Jul 2024 02:59:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dfa84sm146172166b.63.2024.07.10.02.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 02:59:49 -0700 (PDT)
Message-ID: <3fece177-f6b4-41e4-a781-7c4c923ff7d9@redhat.com>
Date: Wed, 10 Jul 2024 11:59:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.1 23/29] Input: silead - Always support 10
 fingers
To: Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240618124018.3303162-1-sashal@kernel.org>
 <20240618124018.3303162-23-sashal@kernel.org> <Zo5bML7Q2ke/CsG/@duo.ucw.cz>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Zo5bML7Q2ke/CsG/@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Pavel,

On 7/10/24 11:58 AM, Pavel Machek wrote:
> Hi!
> 
>> From: Hans de Goede <hdegoede@redhat.com>
>>
>> [ Upstream commit 38a38f5a36da9820680d413972cb733349400532 ]
>>
>> When support for Silead touchscreens was orginal added some touchscreens
>> with older firmware versions only supported 5 fingers and this was made
>> the default requiring the setting of a "silead,max-fingers=10" uint32
>> device-property for all touchscreen models which do support 10 fingers.
>>
>> There are very few models with the old 5 finger fw, so in practice the
>> setting of the "silead,max-fingers=10" is boilerplate which needs to
>> be copy and pasted to every touchscreen config.
>>
>> Reporting that 10 fingers are supported on devices which only support
>> 5 fingers doesn't cause any problems for userspace in practice, since
>> at max 4 finger gestures are supported anyways. Drop the max_fingers
>> configuration and simply always assume 10 fingers.
> 
> This does not fix a serious bug, should not be in stable.

This patch is necessary for clean backporting of new DMI quirks added
to drivers/platform/x86/touchscreen_dmi.c, so IMHO it does make sense
as a stable series patch.

Regards,

Hans




Return-Path: <stable+bounces-124351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 428EDA5FFE8
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 19:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30E919C5BB1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 18:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D261F03C2;
	Thu, 13 Mar 2025 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xgll2/B1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C961EF099
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891638; cv=none; b=f8vyz/L2dDD7lXj73UdU7Af8xxSs6r0CuBqIy1XAA9LjYmSFnjZp43WUZ2my3WNRQUFkFFxUNERsK0S/bnOGL+gTUh+psaMmxkQ0CA55Z9mxxqnj1/LIfVnxnMo31lnjmx28m5H5VZuWHf49l0+n9jnYwbPk9cqpvMhZQWjKGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891638; c=relaxed/simple;
	bh=1Wj0bufZ7EjYi7U/RFgZ/s0fjo6rJSEGTvGZw1CTU4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r140GXX20ehOU4tjMhtRK9wUeDgfyrDDd5rM4iNnlTjK31Y/5UAwqASv/Vfgn/X/bn7kEpvI0hBi7iUoWkdpvS4NTwduS5T+DQxYBtTzmTx20yYGm/MVNrDRbGei9l1GyWzVXiB4cZczJBaFKVddcRPpbpdpw1YxNkdqxo8lOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xgll2/B1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741891636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GojteExoK1LwIk/yNQWtkCvbvibA9jZBZEt4xD5tPU=;
	b=Xgll2/B1yB8kpwaPlhSbGd4G06xr+qBgY2Vc++chuBOZLxQGM/yzgbqIIVKL4jirZReOD4
	rjdvg/MixzUYITCLPWyHhDFWrEdTjVS3xaUqqei3ZfDcOl8JKNnJa0cxr5y46QT55GW3U+
	p0Td6Iwhg4uIARQ9VQTcOhGDsosoeSQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-TxawA0tONxye4p4ktHXcCA-1; Thu, 13 Mar 2025 14:47:14 -0400
X-MC-Unique: TxawA0tONxye4p4ktHXcCA-1
X-Mimecast-MFC-AGG-ID: TxawA0tONxye4p4ktHXcCA_1741891633
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab39f65dc10so146596266b.1
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 11:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741891633; x=1742496433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GojteExoK1LwIk/yNQWtkCvbvibA9jZBZEt4xD5tPU=;
        b=fCbiCUkDarF03mf1j8pIxiYK2z5F/YPigryY0O33T8xntSynYb4J7S+SFBGk789a59
         dcvXDi5FqnzPXeRI0u0ff4SbaJDIM4/3bpa+q7T29Vwb/zuSD61x8hAixd7UldGn8MYG
         ssPEq0Mmv7IiOlHaB2Z7UxRIyL2oriP/PSa01cwW1gikrtw92CJRFTtF/gcJwfnrsCpM
         6a5V25uNeGLSBbsfiAYOMAeP2kxB3Xpi9P9IZ5rM5cqMWgDYpQXGnLiapqvuGZsFISa0
         ekFEawTsMTpzemUE1WpUZ6AHsZ+THHC+WHOMpAHn5KGq4DlmZrvObWI5ggPlfG5fGyp8
         lysg==
X-Forwarded-Encrypted: i=1; AJvYcCXWBoguglbzdMIhXN1D+BkYwZ2NRH5sO43Uv9ezETSX0dmPAjKf9JZSrX/J5hEZbSw3xITrGFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/8Ayeu6jkzGRtOjX2fe0zQ6gcJJKW9C6hwzPlnBCUnh2sG3c
	tbVYLKlzoSULrxb0VG5ZnjcIANrnM/kxRQ33ywuPh454CsUqHkOhdsm6WxPmNJyBXa+dsRe1QG1
	pns+Iop4EYTbmyetykbgq2hs/zxHNXGqGtc/A5v5CaFYs52JSerhPXA==
X-Gm-Gg: ASbGncsVNn+4aomK1pblQRMikJnI+bWbTmkhpUnsUqyfcEfumxhnaOwHN5+ZRjjTMmY
	Ri8Q1WU0Qf1asYmEr3gpb247RSmsoh1o2nI4UdnQILsOuSnrUKWClJSX/ISEJ7/soEkHbOLbTNA
	UDYhGRHM+q6+JdX3+3IReE1xZMeM2YgZDMI9mQfzP9t3w0If8LFN+LyaSUDkOvEsg/yZN+gK9T3
	z6LZ+K2oIHor35wwBpVtXmijIZgzR2zAgtljvaUBjLRxPSTQQyMp8BLDlut8SyNYqC/wNEwMmBf
	M4ktGQ5LORX4hkiiUE5DUJGxepS4OER4DTTDCMIeCsk7Hdxm9VL0eMOGBNqCtjBPHdJPW2a8DJ8
	WdeUj6NO7l8SsTDChFXvQKG80qMQw7SZAeH+Jrhl5KalNMACTt4D6a/aPywFSKA8ESg==
X-Received: by 2002:a17:906:f59d:b0:ac2:8428:c5c2 with SMTP id a640c23a62f3a-ac328fbd7a2mr59818066b.20.1741891633359;
        Thu, 13 Mar 2025 11:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF200838Q9PH//rlXMgJcC7gCBuHjGntLC+HFTNJDzLV0/czimB9kN73ACIsQRgz1KoSS/F/Q==
X-Received: by 2002:a17:906:f59d:b0:ac2:8428:c5c2 with SMTP id a640c23a62f3a-ac328fbd7a2mr59815866b.20.1741891633001;
        Thu, 13 Mar 2025 11:47:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a48b51sm112898266b.149.2025.03.13.11.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 11:47:12 -0700 (PDT)
Message-ID: <6d125c69-35b2-45b5-9790-33f3ea06f171@redhat.com>
Date: Thu, 13 Mar 2025 19:47:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
To: Niklas Cassel <cassel@kernel.org>
Cc: Eric <eric.4.debian@grabatoulnz.fr>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen> <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
 <Z88rtGH39C-S8phk@ryzen> <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
 <Z9BFSM059Wj2cYX5@ryzen> <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com>
 <Z9LUH2IkwoMElSDg@ryzen> <d5470665-4fee-432a-9cb7-fff9813b3e97@redhat.com>
 <Z9L5p6hTp6MATJ80@ryzen>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z9L5p6hTp6MATJ80@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13-Mar-25 4:28 PM, Niklas Cassel wrote:
> Hello Hans,
> 
> On Thu, Mar 13, 2025 at 04:13:24PM +0100, Hans de Goede wrote:
>>>
>>> Considering that DIPM seems to work fine on the Maxtor drive, I guess your
>>> initial suggestion of a Samsung only quirk which only disables LPM on ATI
>>> is the best way?
>>
>> I have no objections against going that route, except that I guess this
>> should then be something like ATA_QUIRK_NO_DIPM_ON_ATI to not loose the
>> other LPM modes / savings? AFAIK/IIRC there still is quite some powersaving
>> to be had without DIPM.
> 
> I was thinking like your original suggestion, i.e. setting:
> ATA_QUIRK_NO_LPM_ON_ATI
> 
> for all the Samsung devices that currently have:
> ATA_QUIRK_NO_NCQ_ON_ATI
> 
> Considering that this Samsung device only supports DIPM
> (and not HIPM), I'm guessing the same is true for the other
> Samsung devices as well.

Ah I see ...

> So we might as well just do:
> ATA_QUIRK_NO_LPM_ON_ATI

Yes I agree and that will nicely work as a combination of
ATA_QUIRK_NO_LPM + ATA_QUIRK_NO_NCQ_ON_ATI functionality
so using tested code-paths in a slightly new way.

Regards,

Hans




> to disable both HIPM and DIPM
> (since only DIPM would have been enabled without this quirk anyway).
> 
> 
>> Yes the most severe problems do seem to come from that specific mix,
>> although the long list of other ATI controller quirks also shows those
>> controllers are somewhat finicky.
> 
> Definitely!
> 
> 
> Kind regards,
> Niklas
> 



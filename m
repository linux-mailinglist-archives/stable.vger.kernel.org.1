Return-Path: <stable+bounces-114008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A284BA29CCE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 23:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10DE1888D04
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE0C21772B;
	Wed,  5 Feb 2025 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="l3jsynMb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAEB21518D;
	Wed,  5 Feb 2025 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738795727; cv=none; b=QfiIVOwGGIijmxonIqpdt1mIqHiYTvKffT/8ksNE7rZY6CaB1cI5+RyFPrMNvSaLBChQPIZCT59qya00KhKDM4YC1dNv+6+iiAaeRpUazA3zXDOVLSZC2yBpP1BNQS49Wp7AEmJ6uHg9yJFLWKRJQqHEMqPfd4dPryFAxUIQl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738795727; c=relaxed/simple;
	bh=RE+O/s0Ns8XzQSTV9EwIp/przX/hXIBK6qruLIswKdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQKXy5mTT3e1Niyhuyl7O+V9IylsadeO0rmIdZHe1pX4wMXqd8i2x3/RiiBnK+NDhCF295sS60jCduwEPwJsHoEzvQm00hehJU9EzjwSCv+HSt0aJ2nxMc9BM0EkJwXRuPvBTt2p/q2i9yWgNpu7FOWnxMNnUKI+TDfRl9ZYeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=l3jsynMb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436345cc17bso1887645e9.0;
        Wed, 05 Feb 2025 14:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738795724; x=1739400524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUoT971StPXDa9X9MRqFUXadUeqjdkEOpabHJfRRv4o=;
        b=l3jsynMb6YC9+xVMamarCcHUTSywI3WnvkLB4ey8p6SXGVA9tGd2bjMN4C+i825SPj
         FiAYUt9z3ZxHcOw8RUgXMYroIeaXuh0wQhWUaZ0U+JRm0CSkgP1V/YOP8Vc5obgDnBtx
         OlEjpP22xeIHwL68cBJlRZXXaC6v4HBd1V5EHYz063gCs80UhO9fE265liu3owXBGO0G
         c64Cl1yWqyRXAz8NMuiIgfVok02SMqB+G+vbNxwiWcCoXo59Y+yAjKlhbqkNSbAARZTu
         Ja7Bq78nnhimspr8vIVPkK8QiiT+weP3i0Vojq94CXSkfKPTCZy5UEn1/lLM8Z1yIAXL
         Xsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738795724; x=1739400524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUoT971StPXDa9X9MRqFUXadUeqjdkEOpabHJfRRv4o=;
        b=UjTZqQzvpuSPNrPcVMbNjDJvv14ESQ7oTA7vck/rA2W+k0fqkd6q/o9/ZEhR+CY+46
         tLoZ9SM2ZrXu9ES2ym644j/RH7tdv3NziiRimL22LGAXvXmO7AGiQCCSbzIo4rmCMN5X
         XSIHpglqN6Y5i3blMUmdxiUnrAEbA5TskKFnOIAlaVJOu/WPSaWW02F//FTZZ6XmKjV6
         UOx8GyVDQ7VjmNNzooSK2LV4RQBeX2bmkOrlmaGZS2FGe4Zh5+/3xz2cFjOsMDGRNg8c
         IvcwW/8j8OEjDKnXedan7XtAn/5WLXWc6orwk/ol3QsUTrbVPDDblLFHNlHZpiOyIy1b
         6bsA==
X-Forwarded-Encrypted: i=1; AJvYcCUT7yMSiA5I0b80J//NiC93wkS+Hs+/aFf5fr9ZfWpuZwb95PYczf1urVVDDsp5YiVUr2G2sD+NnlyRrck=@vger.kernel.org, AJvYcCXEmoynYVLJRwgeJXVNOUXE6OB5mVr1S29k8AGEHRxjk8PWD2OG7R0FHjk/o6EmI52dzLLE9Qzo@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+srn1b2zQjT8U8mOAFfooYgNS+zLHfURe+YL+eorhvK+NTPw
	tnJz8qntDfXbAo+ZbfxfD8BQgS5KXoHoHjIa2ThK/29+WFXgQ8M=
X-Gm-Gg: ASbGncsGJufLy07A7NpiV+F5pLQRBqdkyzYx9fuwV7b3ZVG9i3uLI9lGnFyfZgycMOw
	8BIiY/zL4BdkOQ4apW9OXgICwia8J6X2vXkReha6N7bHjwYfnubFTu96YEgO3XtkuAvh9O3HyVL
	4f/UmFsN16QLUpEoEf6o4ZkjDt2U1ufj7lqolJyqFjkOdNa4/pqOAoX9N5qhokxiYAPULTmFQ0B
	yc1N0ITLAmgf1fK29BxVDe/VJ98WcTT85g+UzP5rsgz5otupeWOlA9daIWCQFOD8w0kZq4x3Uak
	VbDVocNHL7Ev45KccV7NZyrQzM8bEoKqaihlvfCN05JYGOWQ5bpSS6cXSM24EOJbcogZ
X-Google-Smtp-Source: AGHT+IF0au+xnGsaCJy1dVT3VMGmlxCV68Ry0i86RGuJdLPbHXNpecwjnwCEE3cb45RRkXmZeupW0g==
X-Received: by 2002:a05:6000:1a8b:b0:38c:5d42:1529 with SMTP id ffacd0b85a97d-38db491fa85mr3025509f8f.36.1738795723728;
        Wed, 05 Feb 2025 14:48:43 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4bac.dip0.t-ipconnect.de. [91.43.75.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde2f4c7sm13734f8f.92.2025.02.05.14.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 14:48:42 -0800 (PST)
Message-ID: <4ad1662d-44bc-4284-915c-183aa6736cbc@googlemail.com>
Date: Wed, 5 Feb 2025 23:48:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/393] 6.6.76-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250205134420.279368572@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.02.2025 um 14:38 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.76 release.
> There are 393 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com


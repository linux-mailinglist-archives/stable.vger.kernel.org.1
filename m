Return-Path: <stable+bounces-41805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE28B6C00
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 09:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB312B20E72
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 07:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72666211C;
	Tue, 30 Apr 2024 07:40:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04262C853
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462811; cv=none; b=mQKEowGuOX9KTa+MysOHTaLG+T1NgDL3q+lYEQjyM8tvYoXyenI6kp0boPSD0eIBWcEsa8V19fauKWqf/RA5wyB+Wxnp0EvuYKDLS7bA3grkYC6H2KT3Dwzw6VBjLoelB6qPSFJGjR6DvgO/3i2q3XEQW1LoMApSMacU9BSVOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462811; c=relaxed/simple;
	bh=MT548KJG+mnFq2gACfhhZsIifjK9dbAEpRFnJ6jZy2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQYfGfZqJj8eHooroqz/mkbPICz4ITbVb6OpX5x+EPAioYlqpa+eZeEBhyEcw9exjGpJJl66TC3yIJW5brUiWckzUjdlzTKZkIk9xYDf003c+HI4rAWtzv4qPDWpSS+KmFauCOYb7ZX50qNhvQF558Vi9M1a0qfbacwjQO4jat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51967f75729so6348933e87.0
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 00:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714462808; x=1715067608;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MVeT2vwH2CCY3eRLkvZQlWopJU0v6zj0vqgNR0YyYE=;
        b=Yu2y+ZVP5udQOAhYJI1mPttNuV7bJjKjmH1IcKi18lLY7jSf9ThULM/QWadO9V87/u
         CZfVgOoROP+aZvP6ae7Oi5Qr3/e9ans93YpbfFu9eS07Tj+sKcaEzSZY7s6DolPQbaLg
         ROJPAaAA3OWqrmpWsfDT3T5TFBQuXiXCP0Axkipf9jDV8iN8yXtFbM8N0BP9Y0Mdi2Yc
         AKQOSav2GSLA3GAzYZLk7yHQ/zdkUXAGGqCd8fjjEjCAP4s2fB6HU4q1/pKKRU0Edp4k
         7QBa/r+TnDcX9WEEfJGuTH/g/QVe92DaBMaRh1KISEsfeq18La6o/wEKqdfAgFts1SSO
         +ocg==
X-Forwarded-Encrypted: i=1; AJvYcCWLZj+zN+2xjPmRBNzCerRQPQjRF6RtUblcbzJ7rrATVIQzYCU/QkU5O2unzq/8hgtAXAB4XSkloBEffYyHujBUlgiB/Tog
X-Gm-Message-State: AOJu0Yxjq25WQIdCvBjmnT0gptA0YZudQIeOEhLSvERRpZOg0kG74dRM
	/vHoBBVhgAD0TW8SSbsLy+hIjUsgN7S1h5Ao1LdGYCf1TWu3cUwLdgomgnd8
X-Google-Smtp-Source: AGHT+IEZHpBS69VgYTiNqPXD5KKLeuYD9FkHjSP80gQDRWpocxqWm1cvkgK3lgPGAru7p0Tx/BTDnQ==
X-Received: by 2002:a05:6512:114c:b0:51d:8553:cfc0 with SMTP id m12-20020a056512114c00b0051d8553cfc0mr1533049lfg.37.1714462807585;
        Tue, 30 Apr 2024 00:40:07 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709065f8e00b00a559bbe8a00sm11997345eju.100.2024.04.30.00.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 00:40:07 -0700 (PDT)
Message-ID: <96d6ea26-3d3e-4ad0-875a-e705e17db23a@kernel.org>
Date: Tue, 30 Apr 2024 09:40:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 117/273] e1000e: Workaround for sporadic MDI error on
 Meteor Lake systems
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Nikolay Mushayev <nikolay.mushayev@intel.com>,
 Nir Efrati <nir.efrati@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Naama Meir <naamax.meir@linux.intel.com>
References: <20240408125309.280181634@linuxfoundation.org>
 <20240408125312.934033981@linuxfoundation.org>
 <809b5785-e65f-47f4-b52b-f9d2af0a3484@kernel.org>
 <1f4367b6-7d56-4a81-a271-9a4e7089f6ef@kernel.org>
 <7158eded-ff79-9de2-d918-f4a32e216822@intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <7158eded-ff79-9de2-d918-f4a32e216822@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19. 04. 24, 17:38, Tony Nguyen wrote:
> On 4/19/2024 2:03 AM, Jiri Slaby wrote:
>> On 19. 04. 24, 10:44, Jiri Slaby wrote:
>>> This crashes the kernel as a spinlock is held upper in the call stack 
>>> in e1000_watchdog_task():
>>>    spin_lock(&adapter->stats64_lock);
>>>    e1000e_update_stats(adapter);
>>>    -> e1000e_update_phy_stats()
>>>       -> e1000e_read_phy_reg_mdic()
>>>          -> usleep_range() ----> Boom.
>>>
>>> It was reported to our bugzilla:
>>> https://bugzilla.suse.com/show_bug.cgi?id=1223109
>>>
>>> I believe, the mainline has the same bug.
>>>
>>> Any ideas?
>>
>> Obviously change the usleeps back to udelays? Or maybe only when
>> retry_enabled is set?
> 
> Hi Jiri,
> 
> Should be the former. Could you give this patch a try?
> https://lore.kernel.org/intel-wired-lan/20240417190320.3159360-1-vitaly.lifshits@intel.com/T/#u

Thanks, now pushed to the openSUSE kernel.

-- 
js
suse labs



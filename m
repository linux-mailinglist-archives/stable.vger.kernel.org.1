Return-Path: <stable+bounces-146114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246DDAC12AC
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 19:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFEE189436C
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 17:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0751607B4;
	Thu, 22 May 2025 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="SUFtu+YG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB2726AFB
	for <stable@vger.kernel.org>; Thu, 22 May 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747936323; cv=none; b=ltsA9XGuyjBvV8PeAhwLGxfvEL2orqiTmxnY5WNGobbl50yA8g5+Q6FOA2ybkKJNk4Q8RfjJkfof/1b8skKJkWd2CDdpC3A6ItokYPDktl9klOlTShex1PdoZ+HsBB/pAspGVb5gCC3wuUmI4oZUTsR4JH6XqvN19UD+T2+o9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747936323; c=relaxed/simple;
	bh=Na405tLBQE2M4JgPZr2eDoKOSH0qTpUEu/oe9KHBawY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMPyj92CRAGP5wxcTbwWQF3vhN5bUYNS6SnyHlZYIs+t4uWq6WmFatiJ22ctqQ2FrrTEJ/8vNLUiUGd69WquBvNtJQY5WulzUyTwmf/BiFxtTGQklB898De1ZJXO8L4RRNCePRS73OuS8bLMZZq6xjvRUXNfR2wqT/f7aGo2RKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=SUFtu+YG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso15449940a12.3
        for <stable@vger.kernel.org>; Thu, 22 May 2025 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1747936319; x=1748541119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Na405tLBQE2M4JgPZr2eDoKOSH0qTpUEu/oe9KHBawY=;
        b=SUFtu+YGFUAVjNvQruS/oTpwb5HHZqOMNHGCfKMnwUfSZHOXAn9VC09Dnn9+yFONEP
         9OpxKS2EeeMNApDShc5sD2dr+uq/YBH/E3GEmNLHhoqSCHFLICQHBXkiUhG+0bsOe+Tu
         +6L3TcOuAyE9Dje5Qg4pX1TnNoHCyi1NECY0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747936319; x=1748541119;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na405tLBQE2M4JgPZr2eDoKOSH0qTpUEu/oe9KHBawY=;
        b=pC+ykmCuZ1xN3geA7PUdWrGLWAAut/JTiUqs0309WBXt6r7yzKfvS8q3+lrz6Gw51j
         W0Jw4jko+Lq6b7fYmlEjHkImxCohlVFrrdRteyJ1hOO8zGqQ2jAqC7CZ3i9f95Yky7Mm
         LJmJoGDZ+YkiXMXl6AdHfLJNQpA9yDaWl5lFr6KQFM8WKMH3s1t91nps7FR7OaLyYe7+
         4/egj0gLRdAMydwccsrGHR0GXHBjBDdrUmA44ZtkZ1xH1vBfMYzxmzgRVKKcg2McutSZ
         k2DmeIWcD0SixIxZDbknfWH3Oiio+dNgCbzVTkdMxaA7y69qZsfY7kbx838jONo6nuEf
         mXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCrvU9fAcmlsTT3UCfV5fvV0RpHnJG1UisFUkdnqhbQWGDVGswlvFvJxa3sAGokjTKwrmakCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL02A8eXm3cpXbZjnKxOGyqBri9B/q31ZG1TMqVepFYWkbMU1P
	PhVdnU6/oWRZzAcn91hHigJCzDsslCxdN6uc6H6fw3FxCbvdh8T7bM4vZ/KcU0Upjaw=
X-Gm-Gg: ASbGncuTUTiL3DXOa2OQ2pk/a2k0YtWDnPxa3yEyp/QZnozJ66sZX01CDENnucDVSGB
	sMPSbWw6/ubsSDpFh9yjOu1XzT+F3KJVJLoN5zCiq9MhEOnQ5TYwYpbDL0tflb4VFkGZ3I4iGCn
	QbSFunCjsTon2g0tNeLGe64rL7+k/yYgmL/4ogujEVlhQIYwGvIOs1pAr7myhFLs1s9Soii7wPl
	sbdf8tICyFkryS/H+0YvrwF0fVe7P5E2JCnXFFJ66j+73wW5eJhcMOiOfNLaXAJ0Vwtpv0ipRve
	L6+cALf5GzxXes4saLSDqRc9lGYMRtq2DYvcVvXL7bYRuAyw2i3ozG2DSLneaRGOMn+mQoFKNrx
	PzkeOrBLydwyBAn2t
X-Google-Smtp-Source: AGHT+IFKZgwXCUTYpLcjUDx7t410Bco0xIZLm/OSG82CavP4uf8WvCP67Q6fkOArRMyQSNJuvppxzw==
X-Received: by 2002:a17:907:d716:b0:ad2:55e4:4558 with SMTP id a640c23a62f3a-ad536ffbaf6mr2449232066b.56.1747936319031;
        Thu, 22 May 2025 10:51:59 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d04af1esm1100078866b.20.2025.05.22.10.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 10:51:58 -0700 (PDT)
Message-ID: <005d4d4c-f385-42e0-8a30-62c6d77ff0f0@citrix.com>
Date: Thu, 22 May 2025 18:51:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred/signal: Prevent single-step upon ERETU
 completion
To: Xin Li <xin@zytor.com>, kernel test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, stable@vger.kernel.org
References: <20250522060549.2882444-1-xin@zytor.com>
 <202505230141.4YBHhrPI-lkp@intel.com>
 <83b013fb-2057-4097-ac8c-b5c38d019a0f@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <83b013fb-2057-4097-ac8c-b5c38d019a0f@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/05/2025 6:33 pm, Xin Li wrote:
> On 5/22/2025 10:20 AM, kernel test robot wrote:
>> Hi Xin,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on 6a7c3c2606105a41dde81002c0037420bc1ddf00]
>>
>> url:   
>> https://github.com/intel-lab-lkp/linux/commits/Xin-Li-Intel/x86-fred-signal-Prevent-single-step-upon-ERETU-completion/20250522-140954
>> base:   6a7c3c2606105a41dde81002c0037420bc1ddf00
>> patch link:   
>> https://lore.kernel.org/r/20250522060549.2882444-1-xin%40zytor.com
>> patch subject: [PATCH v1 1/1] x86/fred/signal: Prevent single-step
>> upon ERETU completion
>> config: i386-buildonly-randconfig-003-20250522
>> (https://download.01.org/0day-ci/archive/20250523/202505230141.4YBHhrPI-lkp@intel.com/config)
>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>> reproduce (this is a W=1 build):
>> (https://download.01.org/0day-ci/archive/20250523/202505230141.4YBHhrPI-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new
>> version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes:
>> https://lore.kernel.org/oe-kbuild-all/202505230141.4YBHhrPI-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from arch/x86/kernel/signal_32.c:32:
>>     arch/x86/include/asm/sighandling.h: In function
>> 'prevent_single_step_upon_eretu':
>>>> arch/x86/include/asm/sighandling.h:44:21: error: 'struct pt_regs'
>>>> has no member named 'fred_ss'
>>        44 |                 regs->fred_ss.swevent = 0;
>>           |                     ^~
>>
>
> Hmm, this statement is under IS_ENABLED(CONFIG_X86_FRED), which should
> be a compile time FALSE with i386.  Why it is still being compiled?

Because what the compiler is seeing is:

if (0 && ...)
    regs->fred_ss.swevent = 0;

and the bad field name is found at parse time, while the whole
expression is only discarded during optimisation.

The one thing you can't IS_ENABLED() around is conditional fields.  That
needs to be full #ifdef.

~Andrew


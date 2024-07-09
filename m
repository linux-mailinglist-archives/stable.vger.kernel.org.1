Return-Path: <stable+bounces-58263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E24292AF8A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 07:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA94AB21999
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 05:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCBF4501A;
	Tue,  9 Jul 2024 05:46:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B51139F;
	Tue,  9 Jul 2024 05:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503961; cv=none; b=i2Zn1kg1ib1Oc4IdQd5qMUJq0HNAzBnhpxFSSpW3vsetHTRkV/lbyLYq2sDo8y5FrBjkpaIed/75Yf6nHRg3t0UHE7ekyVsX3+u16G7EJZCnpjRBkOHfZnTu9FUcSWBttDBCfP3RzXPlr5Y42v6O65E1d2AEcT6ccs6TE43n5Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503961; c=relaxed/simple;
	bh=lc2/zIBSSJtP5Kv8nXf7skUOjFUMaCCwG5nwhtNkPgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRGsxFtEZZ7xSg40PtZrf0060LW6S4w7OJrIzsuB21wXm014GZd67k6PbAOG//jZD6SU67mpvUj2uCpAs/GpYo1F5OqmqfOimshOX0xnzzBO9CL8yEAUPAaX8PbwJuQ91t7l8VHE1TtvYjwTIwN3brSQneI1WW3hJ354wMAAZl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-425809eef0eso32157335e9.3;
        Mon, 08 Jul 2024 22:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720503958; x=1721108758;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW9hJ1QTEF4SJp8RFEawLqJV+PssPZCmRu3montUhds=;
        b=Pa40uOlro64h/pHgUedYS5w5/RpiRQgh7/dAcEfbHnITJM2nVgl6bWI1/jrir89yR5
         tzCTt67ED7mgs8mBHXjjRDx3XsUdhxq0gGZV240AHXj+25aiVgRKZFQ8GzfkBwYQfMd3
         lV5vt0WMeZ/sKVCf1HcGwhQUG3fSTwXuaK86tYloFgFNf8KR8AER6SwDJQsE4ZRn9X2p
         5ROhPH64yRNVeFNaOZBxguIn4vqjdNytq+yBMpUeQURXM1kJv2NPOiqz/kPY0eUdZBa2
         RMHt+2ZLYkWh8jtG4IS/juB1cdQ36XQta5KQhjGroNBARSVyTyO58gp660i3N+drc2s8
         wvzw==
X-Forwarded-Encrypted: i=1; AJvYcCVERgg9x6ODwfFv2rDItWR5hk8sheteBGQI5F5Nu7ULPnMCejYfw5hIl2qA3lACBVO6xmBIKWJKdcgOcsklsBOU8e+xKoU7WNX6coXj6UF2mwTw4Lpe2+K0YrZ29YB/Uzf35VQS
X-Gm-Message-State: AOJu0YwccBEUZUgKnTJSxz3hfViijBSUFO6aQiLZLQQclAkiAyBS/MwM
	TuZKqCfg0Q3r3kudIX5qrarx61cfW/VTRxXRvBG9vqnJLZ/C0vjjnu8z70I9fck=
X-Google-Smtp-Source: AGHT+IFTAAGKJeePUcWerlrV7PFrPAlfTU8VX3mFGNu/CWKoxoi0yi5ICUut9/0yzrNWsdFcFuma9Q==
X-Received: by 2002:a05:6000:1046:b0:367:9088:fecc with SMTP id ffacd0b85a97d-367cea467b2mr1079336f8f.7.1720503957549;
        Mon, 08 Jul 2024 22:45:57 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89198sm1449039f8f.60.2024.07.08.22.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 22:45:57 -0700 (PDT)
Message-ID: <cabc0b75-6536-4aee-9d6b-57712bb2e1a8@kernel.org>
Date: Tue, 9 Jul 2024 07:45:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
To: Dexuan Cui <decui@microsoft.com>, Borislav Petkov <bp@alien8.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "open list:X86 TRUST DOMAIN EXTENSIONS (TDX)" <linux-coco@lists.linux.dev>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang
 <kai.huang@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240708183946.3991-1-decui@microsoft.com>
 <20240708191703.GJZow7L9DBNZVBXE95@fat_crate.local>
 <SA1PR21MB1317816DFCE6EF38A92CF254BFDA2@SA1PR21MB1317.namprd21.prod.outlook.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <SA1PR21MB1317816DFCE6EF38A92CF254BFDA2@SA1PR21MB1317.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08. 07. 24, 23:45, Dexuan Cui wrote:
>> From: Borislav Petkov <bp@alien8.de>
>>> Cc: stable@vger.kernel.org
>>
>> Why?
>>
>> Fixes: what?
> 
> Please refer to my reply above.
> 
> This is not to fix a buggy commit. The described scenario never worked before,
> so I suppose a "Fixes:" tag is not needed.

If you cc stable, fixes *is* actually needed. So again, why to cc stable 
when this is a feature? I suppose you will receive a Greg-bot reply 
anyway ;).

>>  From reading this, it seems to me you need to brush up on
>> https://kernel.org/doc/html/latest/process/submitting-patches.html
> Thanks for the link! I read it and did learn something.
> 
>> while waiting.
...> I hope I have provided a satisfactory reply above.
> 
> How do you like the v12 below? It's also attached.
> If this looks good to you, I can post it today or tomorrow.

Then you need to enumerate what changed in v1..v12. In every single 
revision. Do it under the "---" line below. And add v12 to the subject 
as you did below (but not above).

>  From 132f656fdbf3b4f00752140aac10f3674b598b5a Mon Sep 17 00:00:00 2001
> From: Dexuan Cui <decui@microsoft.com>
> Date: Mon, 20 May 2024 19:12:38 -0700
> Subject: [PATCH v12] x86/tdx: Fix set_memory_decrypted() for vmalloc() buffers
> 
...
> 
> hv_netvsc is the first user of vmalloc() + set_memory_decrypted(), which
> is why nobody noticed this until now.
> 
> Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Cc: stable@vger.kernel.org # 6.6+
> ---

The revision log belongs here. I believe you had to meet that 
requirement in the submittingpatches document.

And to avoid future confusion, I would list the links to received 
"Signed-off-by"/"Reviewed-by"s here too. The links you listed earlier.

>   arch/x86/coco/tdx/tdx.c | 43 ++++++++++++++++++++++++++++++++++-------
>   1 file changed, 36 insertions(+), 7 deletions(-)

regards,
-- 
js
suse labs



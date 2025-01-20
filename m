Return-Path: <stable+bounces-109565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE5BA17035
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 17:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1AB169001
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D5B1E9B07;
	Mon, 20 Jan 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XAZI2Gme"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED536124
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390793; cv=none; b=VhT4sHreQLTEruAdXppSFmRxzt/YaNVx08gTV+CjCWWKFRIdYhPLFHsyqYcbHn9kAWw50pHD5w3e6YQUuri99sAdA1Umf1TOSAx93I8/X615cfhRwy10JW43fuPeojn1Crwjr0rRgn+IwwwCmdGg4GU52jx5CItD1RDxWeqCcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390793; c=relaxed/simple;
	bh=FiUWQlpYfrA8YD6qvNL+vrYo5ZVa5Q5qHvNjyjkjU9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6yiulYxwEg3v0djTjBLvhxJJlN5KD3aFhnRbu+245Rjm76LAFAhBE+RlX7zxPhegrmbuJ1Uc6wZAA7Z5eYnKPlCAxYcorx2nGpqNnovdwS5bI1/49rXWz5aJ2+c3o9PUpNgMGLXoDh0RkDC7cCORXIlTRUOOo4v2QKryIfLt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XAZI2Gme; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2165448243fso101472035ad.1
        for <stable@vger.kernel.org>; Mon, 20 Jan 2025 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737390791; x=1737995591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C9UtmECkUOGKbPSUc5188JHwLBFmNC0aGmF3i6qmQOo=;
        b=XAZI2Gme8/SYlDvIMRwUN/5kLrWgZANIb2+n2RrOZVEMF8pFTG0Wi6aiTmVw8c5Vei
         dT84Ht13Nf0C1WSrh+nHQOYS66zzUu2lDL/AhPAi57pIr9B2JdG/u3hHpgMVRzfkpX6R
         k9xzEl/SLCXLx6pUBFzJCCrcZlgz65GDtpDyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737390791; x=1737995591;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9UtmECkUOGKbPSUc5188JHwLBFmNC0aGmF3i6qmQOo=;
        b=hGT6L1QhEQM2KdyI3rMl5ysvV90YS0yiRDU8EZjBdldeamfe2gW5FCyHShe/F8hj7t
         sWp3Rpa/qTpEZnfYva7SuuWvwN1c1Ytygcrj+kb2syQ+Dx/QjLR4e4SWRmSvbGHOO8w/
         f/wbiCtalWR+/u/WiHV0RgwvoaA7wI++uRyoDKgQHVzdvNB7EcCHZTho0ViO2w4Rh7BQ
         jsr8fwwQkgcUglBjNPp9ENWdXz/jIgroPFl/tcHbOpcIofQ1jxqF5jl0wgUkOPu5b1j7
         MFGGIsgk6f5L1TQg13lkMCR4rOlrSnh7hCskK03MB9DtPFLwcZ0lL/g+xK7u6O+RMJD+
         9LNg==
X-Gm-Message-State: AOJu0YzvNMUiINrKaQPz55lbpQZ1UWHFz8y/Kx1XkS/oOocnrG7brSXz
	rAjJxugvQ4YuL/2no+gEybyWgitmAYzdWrfDP7It/wmtUMJOZteS4C3c2uX8RQ==
X-Gm-Gg: ASbGnctWwxoWqma1aRDtky0Q5KI79xfAepUdDtfEqI1tBTNScmVezGDH7PTm8vjSVOy
	8nt5u3q4ocq9cuVOwg1nWpcFMijGqgkoGEcBX0PkyXK/wotLkEDqDDfMZUoth14XCqkE79w9vqd
	voK8PLLGB1UYhCbsKF6xqzMn3nVWIlDCnxFR/C7wAO4f674+I+eogMwYpzXaEtE/e8T8xcUT5kK
	k+ceE+VEpq3msnjoKrCJjfHQ+sGxLK/Dw15UimIr0/wNeL0YyqfzUqvXlrMj+HutoPtxMO3wQcb
	JnAX4AeO40JoGcs5tgmm3zHSu0Ni7ZQ/AJyAfeRXQbGa
X-Google-Smtp-Source: AGHT+IFMpRo8h8RDCjagWiVwQZq/mBuVjymV9n8680cV1bdSUPqob1X9eEp6TCLVDGnqJlSrty23Sw==
X-Received: by 2002:a17:903:2449:b0:21c:1140:136d with SMTP id d9443c01a7336-21c355fb6bbmr230924425ad.40.1737390790581;
        Mon, 20 Jan 2025 08:33:10 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3acf2csm62483555ad.121.2025.01.20.08.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 08:33:09 -0800 (PST)
Message-ID: <41550c7f-1313-41b4-aa2e-cb4809ad68c2@broadcom.com>
Date: Mon, 20 Jan 2025 08:33:12 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: account for hotplug memory when randomizing
 the linear region
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Will Deacon
 <will@kernel.org>, Steven Price <steven.price@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Baruch Siach <baruch@tkos.co.il>,
 Petr Tesarik <ptesarik@suse.com>, Mark Rutland <mark.rutland@arm.com>,
 Joey Gouly <joey.gouly@arm.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>,
 "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250109165419.1623683-1-florian.fainelli@broadcom.com>
 <20250109165419.1623683-2-florian.fainelli@broadcom.com>
 <62786457-d4a1-4861-8bec-7e478626f4db@broadcom.com>
 <2025011247-enable-freezing-ffa2@gregkh>
 <27bbea11-61fa-4f41-8b39-8508f2d2e385@broadcom.com>
 <2025012002-tactics-murky-aaab@gregkh>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <2025012002-tactics-murky-aaab@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/20/2025 5:59 AM, Greg KH wrote:
> On Mon, Jan 13, 2025 at 07:44:50AM -0800, Florian Fainelli wrote:
>>
>>
>> On 1/12/2025 3:54 AM, Greg KH wrote:
>>> On Thu, Jan 09, 2025 at 09:01:13AM -0800, Florian Fainelli wrote:
>>>> On 1/9/25 08:54, Florian Fainelli wrote:
>>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>>
>>>>> commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream
>>>>>
>>>>> As a hardening measure, we currently randomize the placement of
>>>>> physical memory inside the linear region when KASLR is in effect.
>>>>> Since the random offset at which to place the available physical
>>>>> memory inside the linear region is chosen early at boot, it is
>>>>> based on the memblock description of memory, which does not cover
>>>>> hotplug memory. The consequence of this is that the randomization
>>>>> offset may be chosen such that any hotplugged memory located above
>>>>> memblock_end_of_DRAM() that appears later is pushed off the end of
>>>>> the linear region, where it cannot be accessed.
>>>>>
>>>>> So let's limit this randomization of the linear region to ensure
>>>>> that this can no longer happen, by using the CPU's addressable PA
>>>>> range instead. As it is guaranteed that no hotpluggable memory will
>>>>> appear that falls outside of that range, we can safely put this PA
>>>>> range sized window anywhere in the linear region.
>>>>>
>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>> Cc: Will Deacon <will@kernel.org>
>>>>> Cc: Steven Price <steven.price@arm.com>
>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>> Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
>>>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>>
>>>> Forgot to update the patch subject, but this one is for 5.10.
>>>
>>> You also forgot to tell us _why_ this is needed :(
>>
>> This is explained in the second part of the first paragraph:
>>
>> The consequence of this is that the randomization offset may be chosen such
>> that any hotplugged memory located above memblock_end_of_DRAM() that appears
>> later is pushed off the end of the linear region, where it cannot be
>> accessed.
>>
>> We use both memory hotplug and KASLR on our systems and that's how we
>> eventually found out about the bug.
> 
> And you still have 5.10.y ARM64 systems that need this?  Why not move to
> a newer kernel version already?

We still have ARM64 systems running 5.4 that need this, and the same bug 
applies to 5.10 that we used to support but dropped in favor of 
5.15/6.1. Those are the kernel versions used by Android, and Android TV 
in particular, so it's kind of the way it goes for us.

> 
> Anyway, I need an ack from the ARM64 maintainers that this is ok to
> apply here before I can take it.

Just out of curiosity, the change is pretty innocuous and simple to 
review, why the extra scrutiny needed here?
-- 
Florian



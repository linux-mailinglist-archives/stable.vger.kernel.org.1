Return-Path: <stable+bounces-111242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F8A226F3
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 00:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3457A15C6
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6CE19D898;
	Wed, 29 Jan 2025 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hWt5xBJ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB851DDCD
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738193509; cv=none; b=Pa+8WV2Tp6jbObBrNHUsh4cNnzPoutZrafPHhOxtXERVpe3kTzhxzU6CylPVjUU5ty30W1niPoXotxwkIJ57ygfDYN0JYfIhjuaE2Zquqjdyj88YmyjKaEQA5lXjCJDTJZToLrDXzns5iaJLrZuEqDMjLTQ0SFw1ryiLxYOleNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738193509; c=relaxed/simple;
	bh=McZR2fjgrfB1pvRjTQIdqAi1D97YwP8vaqlfgOyMohY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYfrD4zvh/zQvgUBYUCj0m/Ed3y/pmfppMyOSbak3pHM5IKn0BAEka2OZOYW9NbXMPgOrzTVB7FR5QhjoGG3O8G2C76UXUXmNFJ5KbqWtUoJmL0vtS3LKFJWKsFThiBgqgrIusBZc3bxz4yg6NzQnC5+I/Ajkq4wY/foQcIENRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hWt5xBJ/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2156e078563so2388565ad.2
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 15:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738193507; x=1738798307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SBorovLxISpQxReRWbAY3IawlYtW7E9RhIDIPvbSmv4=;
        b=hWt5xBJ/GRAtMFXJDk9a23wslmFy0/DUvLM42f0RdUQClbEvTV25RosuLNaQRlok57
         Cflb4jqPxmaxPtrkjdvrxelhHZ9b5qn/ouwKI7J3TLVLY6a+0fl1CiKpgIkC6xuEp+1z
         sC1fB7Czzu7bvjNzerXunQyx9i5tZPUcslYk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738193507; x=1738798307;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBorovLxISpQxReRWbAY3IawlYtW7E9RhIDIPvbSmv4=;
        b=rvf/2jA0mYiEyOHbVCJDo+r8qhH/vQ60TkFdFByaCzuYhNyaQrSEoUE+e8sDghWXbT
         pCd+DYI9bqyqkRj0J87efenyRkcOaLk6sUkAq55Qo8BKpU0PosnnHcAxoLWkXxZPtBBI
         9uodvJWi8k56tgZRk7d0ej1m/OITzHF0TkQvt7wuz4PQgC/sqSLTdK2/RKTvLDFAkdp4
         zUDXwK/vOz73NW9nuAnFDSo9CzvSJBZgwJANCnzzTG/ENliTMC5OHSeQotY7sXZY9ZuV
         AEXx5ZT0s8X0SfenHtIPrWSaCbgG1Lkzz3RkvZcxTT7ujL8QFEcmEbc33AwHhsuLYDvQ
         1skQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2I4W8UE3x9qYOBqVTeE40/eDUflXxDzjUSk1KZFBSh2zAXqID6PvvqiZsg+RQY78pbrvYPm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPt2CKLtWiSHVw6XFW+WjLTsfxDlno3Q4hEdhCrNT51o9NTXJj
	8sj39+tdgDuMxClFVM4i8uLjohDwL2zEsVJuTR0YNBF8VSv3P+kOG7a/IZ3Ymg==
X-Gm-Gg: ASbGncvRRNMeZ95/Dcm+RO/KrR3PnNxWmgW1BaPS+HMN8QjP6d5+A1l2KUdoBbOzAm8
	XPbkUwehUR6Okg5jmKGJqW63WwT5tF3d7PO7AVPaf7hteRFPIqoQCEarMO+bRxJJKXgaiNMH45D
	+mgmhYYp9ZqLuw3b+XZr14588MF48fW+swx4uzsgvZJgP3zurtQVd9CDqprm+W2TouPB77WwyCV
	6yIXG3BjQc8ey2bUZMK1lUKWMJ60cLqBNJZ4N3iwx/i9auS5ED2uRP0ASjCZstBTFMzK7pLSXiR
	MOxbxqavJPESYjMy48BTMAuY7TYI2pSNr97zhkt4hSC/FPyiiI3eMic=
X-Google-Smtp-Source: AGHT+IFoX3f/KqkRzhPCJukJxXKDS1QIoLOImU8F/rN6UPjtfSTa550gLEFAuRbStb7vmSKrNvKshw==
X-Received: by 2002:a05:6a20:7fa8:b0:1e1:ae4a:1d48 with SMTP id adf61e73a8af0-1ed7a6e1696mr8610257637.40.1738193506894;
        Wed, 29 Jan 2025 15:31:46 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cdf76sm33681b3a.129.2025.01.29.15.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 15:31:45 -0800 (PST)
Message-ID: <8994e7c5-812c-4605-9bdf-18a5b402196a@broadcom.com>
Date: Wed, 29 Jan 2025 15:31:40 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: account for hotplug memory when randomizing
 the linear region
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
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
 <41550c7f-1313-41b4-aa2e-cb4809ad68c2@broadcom.com>
 <2025012938-abreast-explain-f5f7@gregkh>
 <1fc6d5c8-80ec-4d6b-bc14-c584d89c15b4@broadcom.com>
 <CAMj1kXHheRQYHddgehLbZot6o-xAxkbeHBUq7nS8npyB9A0FvQ@mail.gmail.com>
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
In-Reply-To: <CAMj1kXHheRQYHddgehLbZot6o-xAxkbeHBUq7nS8npyB9A0FvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/25 14:15, Ard Biesheuvel wrote:
> On Wed, 29 Jan 2025 at 18:45, Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> On 1/29/25 01:17, Greg KH wrote:
>>> On Mon, Jan 20, 2025 at 08:33:12AM -0800, Florian Fainelli wrote:
>>>>
>>>>
>>>> On 1/20/2025 5:59 AM, Greg KH wrote:
>>>>> On Mon, Jan 13, 2025 at 07:44:50AM -0800, Florian Fainelli wrote:
>>>>>>
>>>>>>
>>>>>> On 1/12/2025 3:54 AM, Greg KH wrote:
>>>>>>> On Thu, Jan 09, 2025 at 09:01:13AM -0800, Florian Fainelli wrote:
>>>>>>>> On 1/9/25 08:54, Florian Fainelli wrote:
>>>>>>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>>>
>>>>>>>>> commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream
>>>>>>>>>
>>>>>>>>> As a hardening measure, we currently randomize the placement of
>>>>>>>>> physical memory inside the linear region when KASLR is in effect.
>>>>>>>>> Since the random offset at which to place the available physical
>>>>>>>>> memory inside the linear region is chosen early at boot, it is
>>>>>>>>> based on the memblock description of memory, which does not cover
>>>>>>>>> hotplug memory. The consequence of this is that the randomization
>>>>>>>>> offset may be chosen such that any hotplugged memory located above
>>>>>>>>> memblock_end_of_DRAM() that appears later is pushed off the end of
>>>>>>>>> the linear region, where it cannot be accessed.
>>>>>>>>>
>>>>>>>>> So let's limit this randomization of the linear region to ensure
>>>>>>>>> that this can no longer happen, by using the CPU's addressable PA
>>>>>>>>> range instead. As it is guaranteed that no hotpluggable memory will
>>>>>>>>> appear that falls outside of that range, we can safely put this PA
>>>>>>>>> range sized window anywhere in the linear region.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>>>>> Cc: Steven Price <steven.price@arm.com>
>>>>>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>>>>>> Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
>>>>>>>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>>>>>>
>>>>>>>> Forgot to update the patch subject, but this one is for 5.10.
>>>>>>>
>>>>>>> You also forgot to tell us _why_ this is needed :(
>>>>>>
>>>>>> This is explained in the second part of the first paragraph:
>>>>>>
>>>>>> The consequence of this is that the randomization offset may be chosen such
>>>>>> that any hotplugged memory located above memblock_end_of_DRAM() that appears
>>>>>> later is pushed off the end of the linear region, where it cannot be
>>>>>> accessed.
>>>>>>
>>>>>> We use both memory hotplug and KASLR on our systems and that's how we
>>>>>> eventually found out about the bug.
>>>>>
>>>>> And you still have 5.10.y ARM64 systems that need this?  Why not move to
>>>>> a newer kernel version already?
>>>>
>>>> We still have ARM64 systems running 5.4 that need this, and the same bug
>>>> applies to 5.10 that we used to support but dropped in favor of 5.15/6.1.
>>>> Those are the kernel versions used by Android, and Android TV in particular,
>>>> so it's kind of the way it goes for us.
>>>>
>>>>>
>>>>> Anyway, I need an ack from the ARM64 maintainers that this is ok to
>>>>> apply here before I can take it.
>>>>
>>>> Just out of curiosity, the change is pretty innocuous and simple to review,
>>>> why the extra scrutiny needed here?
>>>
>>> Why shouldn't the maintainers review a proposed backport patch for core
>>> kernel code that affects everyone who uses that arch?
>>
>> They should, but they are not, we can keep sending messages like those
>> in the hope that someone does, but clearly that is not working at the
>> moment.
>>
>> This patch cherry picked cleanly into 5.4 and 5.10 maybe they just trust
>> whoever submit stable bugfixes to have done their due diligence, too, I
>> don't know how to get that moving now but it fixes a real problem we
>> observed.
>>
> 
> FWIW, I understand why this might be useful when running under a
> non-KVM hypervisor that relies on memory hotplug to perform resource
> balancing between VMs. But the upshot of this change is that existing
> systems that do not rely on memory hotplug at all will suddenly lose
> any randomization of the linear map if its CPU happens to be able to
> address more than ~40 bits of physical memory. So I'm not convinced
> this is a change we should make for these older kernels.

Are there other patches that we could backport in order not to lose the 
randomization in the linear range?
-- 
Florian


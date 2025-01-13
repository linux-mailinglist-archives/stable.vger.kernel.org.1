Return-Path: <stable+bounces-108461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD60A0BC5A
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3068161595
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757814B08A;
	Mon, 13 Jan 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zg1ZR15B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71524023A
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783095; cv=none; b=OOt8xyeRrJCAG0zrwLUJm8O0kVYteVJqUTXyiWw5GDuHJENC4UxKKr1j02lWiLEvcf5lcIWhaYhtUfIrr6WT/D7B/T7YbFkzfPZfCTzljXkoA/z8W3G5Qklur0xtcds2MleTnVgrYrZ4NCuZzZ8fo+OvCOHuW9ZSoyX/5la/S4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783095; c=relaxed/simple;
	bh=ENFfmbG+5kC0JnCC64QR7jexqlm6+gluThfjSWiQimw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZmyCRzogrT1/R9/+Je4jVGFb0kuREHh7uX2/jJUHo0WcbaWkObcYtTPHAvf5aOSkZu5v58Dw+a9JE/IubfwR0gFKaSnHCLKSZWK9DHsOKtGg+ikWB+FW1I3eR0P6qK7FhK98AjVQAYC+7xvz2W5rbgGCR4GgTJxtOHIblPY1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zg1ZR15B; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2162c0f6a39so97392495ad.0
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 07:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736783092; x=1737387892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ybO6ITDKL39JrzdH2h1fx5NTW8wMD1w8dNTpzC9u4NU=;
        b=Zg1ZR15BtgwocZaKCEoHtnqDhvXaqUeilHykb7ieHicMRbNyWWaQmWv0Zc5pjwO7V5
         12cLrCCaxZpC1nKYVWUfGKoZHmgDIFb8HBezsFNDePS/LF+nNX1imAMjG48D+WM7eVfr
         p5WLTMidHK+81NcjWgfySAaORHJuS1BCaIkeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736783092; x=1737387892;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybO6ITDKL39JrzdH2h1fx5NTW8wMD1w8dNTpzC9u4NU=;
        b=mTpOoX3Dz1iFuKqaDA6X7zPbg0eRvwcpWKUq7I6LUpJAujQtuxbatNgBiBY3oHEPVG
         UMDcKyUS2Y0i/GY+IgLv7INIZT0NfIPaFsS6pzpMOymbWRcJuI85wLaxaj1wgUp2Ogm6
         Zk/VtcfnXbc75KDYIwhh/fIzMgWeOBqsrhI86DMrWEkSvXa7kvxu1JbsOBZkMeBOAN+W
         ro2AJG2y2+woXBGcKVCiXgm9Za9gWBEen5Q+Xk5IOwFX9arP1TW7gHgXd8WwOulsY5WC
         trdOWtf8rJid2rjFnLQoNYO03du0uOVy9g054KklfDBYqOPKaDomO9dx8BSjmYJuIimK
         /51A==
X-Gm-Message-State: AOJu0YyLiISkfi+tT3prixzDu9x9Vr/CqoCdhNtKvh9lnk0KB9R1O854
	SE50HOkd/G0UcXbKkJAnbWS1O8SfN1aSoDYCZSCO6v9PMSG+6q1oIy5BRyKwDQ==
X-Gm-Gg: ASbGncvdL1WyvL5Y31b0Vl/3i3apFXrbURfA5RJwmc+CySCuLG6e5vAQZvD43hev3T2
	8UrN0reoPRmw18K781MY334u1LcLJfTAArnP1rMHlapaGCMm7BI1ypp2DYi6CYhpcAWXPUKqPvr
	Za08Ty52qSdy7akhouDl2rcLQPfYm/52pEruq0hA5jzWY6zfR2HcDRWn1NmvRXVdHihOBVRz9yU
	vnA5KE+2dISfDbm1OZHiMo7Nx3uA+6y7qbcfrAYndoFFJxtXfZt63YZ9wf+gLk60Qi41XEuJLbV
	Mqg1ftOIqeWWRsJoMA09O+OZOyqX8Cc=
X-Google-Smtp-Source: AGHT+IGlAhNAFoSw1pfaDXYYvQLgA24oACquxpnCb8GPzdZGolbKjMMQc6+01MzaSXFKM8+X02TZhQ==
X-Received: by 2002:a05:6a00:1747:b0:725:f1e9:5334 with SMTP id d2e1a72fcca58-72d30393fa8mr28590318b3a.8.1736783092544;
        Mon, 13 Jan 2025 07:44:52 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658a73sm6047441b3a.119.2025.01.13.07.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 07:44:51 -0800 (PST)
Message-ID: <27bbea11-61fa-4f41-8b39-8508f2d2e385@broadcom.com>
Date: Mon, 13 Jan 2025 07:44:50 -0800
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
In-Reply-To: <2025011247-enable-freezing-ffa2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/12/2025 3:54 AM, Greg KH wrote:
> On Thu, Jan 09, 2025 at 09:01:13AM -0800, Florian Fainelli wrote:
>> On 1/9/25 08:54, Florian Fainelli wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> commit 97d6786e0669daa5c2f2d07a057f574e849dfd3e upstream
>>>
>>> As a hardening measure, we currently randomize the placement of
>>> physical memory inside the linear region when KASLR is in effect.
>>> Since the random offset at which to place the available physical
>>> memory inside the linear region is chosen early at boot, it is
>>> based on the memblock description of memory, which does not cover
>>> hotplug memory. The consequence of this is that the randomization
>>> offset may be chosen such that any hotplugged memory located above
>>> memblock_end_of_DRAM() that appears later is pushed off the end of
>>> the linear region, where it cannot be accessed.
>>>
>>> So let's limit this randomization of the linear region to ensure
>>> that this can no longer happen, by using the CPU's addressable PA
>>> range instead. As it is guaranteed that no hotpluggable memory will
>>> appear that falls outside of that range, we can safely put this PA
>>> range sized window anywhere in the linear region.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Steven Price <steven.price@arm.com>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Link: https://lore.kernel.org/r/20201014081857.3288-1-ardb@kernel.org
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>
>> Forgot to update the patch subject, but this one is for 5.10.
> 
> You also forgot to tell us _why_ this is needed :(

This is explained in the second part of the first paragraph:

The consequence of this is that the randomization offset may be chosen 
such that any hotplugged memory located above memblock_end_of_DRAM() 
that appears later is pushed off the end of the linear region, where it 
cannot be accessed.

We use both memory hotplug and KASLR on our systems and that's how we 
eventually found out about the bug.
-- 
Florian



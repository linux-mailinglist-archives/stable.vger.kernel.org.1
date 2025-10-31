Return-Path: <stable+bounces-191953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0556AC2686F
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 19:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DA7934E047
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D133502AA;
	Fri, 31 Oct 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VGs+GKO8"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12BE2FE579
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934231; cv=none; b=PA3VAzdd5spNmLBe1MMEiJ6enKVwVMKykEOINNpslLBMx3OtD5AjEJ+YbtqTHrux7rv0QQDCigqWE6FDmzp1xa9E3mP2zWl5ce28QpsHa+jHLP6tUVFltGC77WxaTMI52O04vxBCUNEf2h7wDLbNxIDSn5KBZcUyDvdH8fCd230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934231; c=relaxed/simple;
	bh=a9xIUxH3kQc8g4WoNuUJFjo3JZiZ14L74BIdEuGYacI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oE4j+bn9Etf6EldpakmofbNGjzdoVSSKI9NVaBzxhs1UJS7ZbgtzyhejwwAKZj0+fFBAvjpxhMtb+XEyo76B36siti6s3iqRDfIYv5Pe8PGbii5WFNZ8+YtvjlTBORkhosEP1KN/2yOp5YpeBjbVtcX3bxMS4olZEXuUBbZzTsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VGs+GKO8; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-430d06546d3so21567945ab.3
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 11:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761934229; x=1762539029;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aTRxWRn5jXTZmg3iJpHPOm7f9rtaLnt98Sh1XgXqZo=;
        b=kFJWVxdZjhwWCMvqmMJNJixSaq9dM1rUD8u/qpIndpMDJU/KfCN56kifEgMaUAh5rb
         ci1aQB6P4bKWKo35sw9jJXa4q1fYgbhfR3obwu99LvPir5Dma9imECFA9alNjtkhFHo3
         AhqfKSzZYx0nMa4sGnXbU6oUTSS84V+is9rtOCyBvcRas0rCeI/kFNguViwy0syRiLm4
         lm4Wm1BcdMIrWK7pe682g/Vh+RkfouZi6xP037X5aTxcQs3saQI8aWSoNaWmHHuHnzih
         c+rbq848Y3nuZDafctCRKYmeqg3/QXFxdjkQ/ZHohVLn9bJshIbUbBJwiGYr/4aaMnx/
         tO7Q==
X-Gm-Message-State: AOJu0Yy8ot7F7BXbHOUX2VkSOVvTkeOogcxwrqJByd8HlmXybCxQHvG6
	7DYCztbt8NREkaJx/Y3fmt3XGt5TEQ0wcsajgXhTCvt5ooSVGTqN64BGAk9CcqEIbo+uAVW8lyd
	q/5r83cV/637w9Kk9C9DkS5sRV2CrBcnCMn9MMe6Db7ruJFIXEbvi9pOZkvU0j4+eBtIHC1lpcP
	tqnOMx53nK8eeDEH6WerujOqFckqxBJQUba49aw/1SI3YdQApT0lCWFKMSX3u0W8O5vWrjeN0JW
	PcwYylNf71h5o1s
X-Gm-Gg: ASbGncvpz6OF0Ai3uqkriSSmsEGZhsz1VkDGgGA++49KVjxGzWVLFgxQFtKxQmmLcXZ
	CrRjcVMld6/zVgAZB9VnhUpte86dXp8aXLkm5o/N4O3LBC0ZnCV7juWT3C7FfXvZ2oRLOawbZ2t
	mP28XZFLjE0W30PpPOvKHk1UqEnk0DGEKpZiaKbCFmPuHGz3+V3m/NCJxmfnv34LXEYo/O/bDm8
	dKJqP8mjOtIojrGevhWch/NCWpHz1ci82VafwttW+cHCMPM/Kg1pyuX4ryzS3MuxR9HctKk0tjx
	aP9eUEhj/648qLSucDUda07p0RE6C81U5j4T8voxZXUZ9c9ikqX098crE7xpAbEPSzp9MVtGnHi
	+Nn6O8RmEoOwkh4GD06jUMQC2d/i3QfcFQJethPv/PH0zKFTHEz76HareQopW5R60kdDqFVNUdH
	7l2R6KDI6zoMe5NDKbu2muyYQNHQefDTSdATBbNWs=
X-Google-Smtp-Source: AGHT+IG+qlFtgoytgbQDJ2I62OZqOb5TbIFvRBvD0YsHZiAUPx7/tMId9VgdgA25AEa8JrW97ilt/P+fVUaM
X-Received: by 2002:a05:6e02:144e:b0:430:a3b0:8458 with SMTP id e9e14a558f8ab-4330d125c22mr73967065ab.3.1761934228756;
        Fri, 31 Oct 2025 11:10:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b6a55c16d2sm221209173.20.2025.10.31.11.10.28
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Oct 2025 11:10:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8802e9d2a85so32635716d6.2
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761934228; x=1762539028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0aTRxWRn5jXTZmg3iJpHPOm7f9rtaLnt98Sh1XgXqZo=;
        b=VGs+GKO8EwbHAtktIvjYIfn119hiRbI8XnH/nT/H18J1QzahgJdlDWWLasA4OvbcbL
         OBT84haxhGhb65dSszbLCI+5bgmTN5Zl6Fho32nJxrBxZgdhEnWSzhTraxwC/GtWVUmb
         IwFpMsnbnDtQsNKGdsWi63ji5XPpCSqv+ELHQ=
X-Received: by 2002:a05:6214:2688:b0:80e:327d:be66 with SMTP id 6a1803df08f44-8802f46f505mr64085756d6.39.1761934227730;
        Fri, 31 Oct 2025 11:10:27 -0700 (PDT)
X-Received: by 2002:a05:6214:2688:b0:80e:327d:be66 with SMTP id 6a1803df08f44-8802f46f505mr64085346d6.39.1761934227324;
        Fri, 31 Oct 2025 11:10:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88035fdd424sm15354046d6.1.2025.10.31.11.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 11:10:26 -0700 (PDT)
Message-ID: <31316499-4007-4211-add8-eb6bab565e0d@broadcom.com>
Date: Fri, 31 Oct 2025 11:10:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.12] sched/deadline: only set free_cpus for online
 runqueues
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Doug Berger
 <doug.berger@broadcom.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>, bcm-kernel-feedback-list@broadcom.com
References: <20251027224351.2893946-1-florian.fainelli@broadcom.com>
 <20251027224351.2893946-5-florian.fainelli@broadcom.com>
 <2025103157-effective-bulk-f9f6@gregkh>
Content-Language: en-US, fr-FR
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
In-Reply-To: <2025103157-effective-bulk-f9f6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/31/25 05:27, Greg Kroah-Hartman wrote:
> On Mon, Oct 27, 2025 at 03:43:49PM -0700, Florian Fainelli wrote:
>> From: Doug Berger <opendmb@gmail.com>
>>
>> [ Upstream commit 382748c05e58a9f1935f5a653c352422375566ea ]
> 
> Not a valid git id :(

This is valid in linux-next, looks like this still has not reached 
Linus' tree for some reason, I will resubmit when it does, sorry about that.
-- 
Florian


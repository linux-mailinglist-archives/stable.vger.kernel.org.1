Return-Path: <stable+bounces-198130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACA6C9CA6A
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 19:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520693A673D
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 18:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3389729BDBF;
	Tue,  2 Dec 2025 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XJIKYiQI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A5255248
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700355; cv=none; b=G/d8EnOKbncDm5wIe9VXu9PXj9DhsHdc+SgTn1HAk5H+NhqAS8ycTRXRO3d6TsYRa2nw5m4dMb5iMQ5SRmSdP0RQZlBvgM5RzvFdPxiRhg983562M00zL9etZuF6bLpYAFEgHAQlLQnOWxzAZL349OzJmZut6UJzGqBk/sIL5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700355; c=relaxed/simple;
	bh=dOyNtuxzHriSmeSaHB/Dm8FAk3+w4hUALnQ4kUsRg3Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O3ArexbLAlSpDtx+DQyQRh5qZ0sd+vfZQp+jRvyQIF3/CV6SkB4p+E+YKB4mtER6wdiH3HkgDAwKwY0YSFhyuPru93XnGEaOxfnS9eb+WKLT+19IuRxW64aWtATZ5KWdk7JgdsQHOI/mgrCD3HVRgkd/DK/GSraGLgrQkjNMIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XJIKYiQI; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-297e982506fso74614695ad.2
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 10:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764700353; x=1765305153;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zv30SafIBAF+kokTeMhdiibrNnq6sB1NjabSHNT/4fs=;
        b=q3MSJXj1T5+6+Af2+3SDd63y9pfNtkPakaJeK5kwyNmjGiwtAN4pXJIg3OFZWyfRE7
         dYMs2bFG2VrxxV6wF9Hvq3tTdhbdcfSFTS8wzeoCuYy+gypbDSRL3vHfQTo/uzEIqLpz
         Lco0b1faDj30+fmpNzXq4uAqeJBAWWDQMrwlN9wETBIrwtasSt+ruJ4SHScXr4ZT58Z3
         mwHLL8/WorsgSYOqzid19m0C++ovLBVUApEC/19heWetb/oIhbQcbZwzvaew6hK4onmt
         wqnqychfpTRY5ebyPE3lkDc+/hx9c1Zirtc1TadUtDbXE9MlbIw4sSbkHxvaPbp+wIAP
         rKdQ==
X-Gm-Message-State: AOJu0YxmmM62UQQpc1irP74IQ5heOMsNQsqe+lLeMcTIXVX6WfYOeAFK
	kPYfScDno5ckhRshnQ2oC53ABrmxXOY3kanytih34ED5OuSib1EQB2EafkuFB0jCctJGny8IsE1
	ct9jr4SIgZeqE4ouJaT8NXexW2CLjsyZnHOZu1FljD17CKWlrhooQ6nKEBxTHxdHnn+Er9cHlKu
	5Zym6VqLCaR01oeuxORJ7a/yVTD5b+M9MpoVt4MDh8YYK8oIJFLUc2SXPO8NSiX1eIubewylLn2
	/7J5zc9qn7mDTOO
X-Gm-Gg: ASbGncv6NzCT3+VT9n1QZBCdz0qdtoFrayIqX3+Pe6DszrDpd1ykxE65zPYTiSd328T
	nWPRt/Y6MJkSa38ip6y4xUi6B7O2vDGVk4UrG62OR3dNqjyQcNdE6FESjmTzYctzEWesT5Jder7
	YHEdr4PnHuwLOuSTDVR+L7c3xCrNJ2z0YaM9vKNGRu0fhyCX30uStZb/oUn/j/BQ/8dbejTfKY6
	bofgs456UwcPTITCXfudn9c41is//K8ZErb/y0IpCsVWv4Za2z2BhbK0HHFuYo53rcF8fL/YvS0
	q8YqTJuUDFft/5/1cbLQ55FaefpK6gfXrRThcMz256gaY88w3fPGL0M17jPDmVYYdgp3RkEepWN
	6kHV6cH5sDKU+zD+lNDO+WJkuP7ptuhV6Q+zzledO9pOd71pLtgKjoIvGjSSG/Y8CCY1EW7c4MV
	HdBIF88KjVz+ezjSPN3Lygqnl2l8rQAf8P4N+/tBQNYJgoPJJX1L1W
X-Google-Smtp-Source: AGHT+IFEeWymynDHh5K7u/MHmJhB/iOGH3ZvcJO/rl4e6dCtg7Slhm6bo1Jc75ZQgn1Yrb9OdCpCxDLbWEgI
X-Received: by 2002:a17:903:245:b0:298:90f:5b01 with SMTP id d9443c01a7336-29b6bf7f21bmr499740375ad.52.1764700352706;
        Tue, 02 Dec 2025 10:32:32 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29bceaabf04sm20913825ad.35.2025.12.02.10.32.32
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Dec 2025 10:32:32 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47918084ac1so45321365e9.2
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 10:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764700350; x=1765305150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv30SafIBAF+kokTeMhdiibrNnq6sB1NjabSHNT/4fs=;
        b=XJIKYiQIU6Wy4cFgx89I+RBI5+RZlfHliTc77+BVvDllTUFd4nOWKkTFW+U7WwJ1ZG
         WVLOSCkFR3bFLcZP9E044CwYkeboenaadNEOs7iPIabxR3jkqsnY/n2/RHMXcWah90mi
         FTqkO0WmNq40VnQ2AVRcPXhZczqqGCuy4b7pA=
X-Received: by 2002:a05:600c:474e:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4792a4c07b6mr5250985e9.33.1764700350057;
        Tue, 02 Dec 2025 10:32:30 -0800 (PST)
X-Received: by 2002:a05:600c:474e:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4792a4c07b6mr5250665e9.33.1764700349593;
        Tue, 02 Dec 2025 10:32:29 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a7a78a0sm3483965e9.10.2025.12.02.10.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 10:32:29 -0800 (PST)
Message-ID: <6df70e8d-86b5-48ce-8228-699f28f7ef2b@broadcom.com>
Date: Tue, 2 Dec 2025 10:32:23 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.12] sched/deadline: only set free_cpus for online
 runqueues
From: Florian Fainelli <florian.fainelli@broadcom.com>
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
 <31316499-4007-4211-add8-eb6bab565e0d@broadcom.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <31316499-4007-4211-add8-eb6bab565e0d@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/31/25 11:10, Florian Fainelli wrote:
> On 10/31/25 05:27, Greg Kroah-Hartman wrote:
>> On Mon, Oct 27, 2025 at 03:43:49PM -0700, Florian Fainelli wrote:
>>> From: Doug Berger <opendmb@gmail.com>
>>>
>>> [ Upstream commit 382748c05e58a9f1935f5a653c352422375566ea ]
>>
>> Not a valid git id :(
> 
> This is valid in linux-next, looks like this still has not reached 
> Linus' tree for some reason, I will resubmit when it does, sorry about 
> that.

The commit is now in upstream in Linus' tree, can you pick up the stable 
patches when you get a chance? Thanks!
-- 
Florian


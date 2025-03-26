Return-Path: <stable+bounces-126737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3FA71B2D
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398601887381
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190231F4297;
	Wed, 26 Mar 2025 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ehYVPtdF"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920A1F4160
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004410; cv=none; b=WsHFpGexce3p7ELJC0iQSdn30w8EjDerbXV4BmcQvwzNvoOL/eLia4MBaO7lFwKzMq8NGVTBIyEhkmQ0/JinppI7BenKFMvOx7NmgCdQGjpbPUt2x2r5YiX6goXs/ZF3NWr4/VhB2JPo4IxR9kD9GyaMtEh1C0jZSCGeeBoGpQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004410; c=relaxed/simple;
	bh=Cmgc9jxK6Ofoo2XQp4Jk7gnBtwLWf98tvySpbz1N580=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUbT0K4VQzdjawEvJzZx3IpOgqeOAWLCM6IyBeRI6c+Td2Ey5zq0+mOlRxOPyRlUgCdC/NqgwTXu12t8b2xj5WVTNGLQiLF6Axr8K01xOYqUoPfsF35ssRYhFRJ7ETeF+zBiRUP2kOwP9mfYWnPPNmP56CtVdw/DaLStzfsJRRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ehYVPtdF; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3fbaa18b810so2052989b6e.2
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743004408; x=1743609208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SM5fPhKH3eo9QWVzWqGRULqwyyIH1WW4d5YRJrpPBCU=;
        b=ehYVPtdFhMCYtM9DbsS9zJfc6DbaUSKKCSEItpjmSxyfIV78afqOTXjPhRgqnpvsXk
         h6vSXpz7NgQiljvaK/CglVay+BGgy4UOrn6J57w6+bQb0Wz+KEK+nsooX+3jMC3UuShD
         6/e3c0OdVB5AXSYqmODKayaqMua7clPha022w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743004408; x=1743609208;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM5fPhKH3eo9QWVzWqGRULqwyyIH1WW4d5YRJrpPBCU=;
        b=pL99O1NrU5yIkjzxs5XEpYoeChYiqryhmYnK73JtLOzYUKxKAXRgEQIkHGNdS5itxI
         w7Q3SMiM2d5CKWdngmAOjghHUmZSjKFdfUxFvezWKd+Lea8NV1B02/+mKKkHwm0ff0JF
         0Ed6WTpM0KCgO4KzD2qXz8840xyz7lTyFpEmAWAlOdhp55F2QixfHRfXFMqHNGboBo1I
         f7G0f1cXujroc6+Hsdd84Ze2O/7qHcwgmtfIT5Mj8BTMf17K1SXx+YVgtyTMjeA3P31M
         GVcIh6/GNan43hQlh3Fx8FH5e+xbRKaW3O8Y5ibzhvH8qt0PprOxLp4PjiN0APqFDZai
         mt3A==
X-Gm-Message-State: AOJu0YxU2So1zwqzvIHF7nhMh5gV2b0ksPSS3UW18S3WK6w6mUSBfmmc
	3eRF6gS2cmckOFm5haMu5ApKTdu8PwclGQrl2kSAXI9moDOXXG2ReGpBAPM/FA==
X-Gm-Gg: ASbGncuqM2m5x6PF2NW2ZYYQ4KXqM4wKLcbffDpRm6bO/7iRTQGiCmaWybS+zIDKI9E
	w/s4VB/n5WAxOXTCoQNNBkCCFcPCuj17SPNdaZN9YWfVzlnBOjiYnsfLn5UVjMD/buzWSuhJchW
	jTr672y20SNpoYc05RjjD0Pgbvpn0l9VrnakM5mEQg3U1SzgdKwUxnOR3QAM988HSQ5fRixUBdX
	pG6OmxC0Z650wG+hUB5ncOejnGksdZNUFlFUOjKquiY1KB5l7Wuh9YNjse/7nyjBClHG9OMjpht
	yK6we8jAGMiIfZWwHXZx1klqdCYor+kx08eGjHbxuik+4AK6+pRsV8M2AshKOZf9pXAp+ywTdOc
	XgOZv7BTdat9s+YebSXs=
X-Google-Smtp-Source: AGHT+IGAqY1afSx2VOLR53tgrTQpoT0AFaUAQGaXTStPgH9gc/ljordP841Cx+qYslm1PKBCzo1JIA==
X-Received: by 2002:a05:6808:10c9:b0:3f8:a72f:a976 with SMTP id 5614622812f47-3fefa540987mr23090b6e.11.1743004408340;
        Wed, 26 Mar 2025 08:53:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf6bd815sm2389722b6e.9.2025.03.26.08.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 08:53:27 -0700 (PDT)
Message-ID: <fe0b5fc5-a365-45e2-8e87-24b2830255bf@broadcom.com>
Date: Wed, 26 Mar 2025 08:53:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 5.15 v2 2/2] openvswitch: fix lockup on tx to
 unregistering netdev with carrier
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
 Friedrich Weber <f.weber@proxmox.com>, Aaron Conole <aconole@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
 Carlos Soto <carlos.soto@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Pravin B Shelar <pshelar@ovn.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Felix Huettner <felix.huettner@mail.schwarz>,
 Breno Leitao <leitao@debian.org>, Yan Zhai <yan@cloudflare.com>,
 =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@gmx.fr>,
 Joe Stringer <joestringer@nicira.com>, Justin Pettit <jpettit@nicira.com>,
 Andy Zhou <azhou@nicira.com>, Luca Czesla <luca.czesla@mail.schwarz>,
 Simon Horman <simon.horman@corigine.com>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:OPENVSWITCH" <dev@openvswitch.org>,
 "open list:BPF (Safe dynamic programs and tools)" <bpf@vger.kernel.org>
References: <20250325192246.1849981-1-florian.fainelli@broadcom.com>
 <20250325192246.1849981-3-florian.fainelli@broadcom.com>
 <2025032620-protract-reassign-f3e7@gregkh>
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
In-Reply-To: <2025032620-protract-reassign-f3e7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/25 08:39, Greg KH wrote:
> On Tue, Mar 25, 2025 at 12:22:46PM -0700, Florian Fainelli wrote:
>> From: Ilya Maximets <i.maximets@ovn.org>
>>
>> [ Upstream commit 82f433e8dd0629e16681edf6039d094b5518d8ed ]
> 
> As Sasha's bot said, this is the wrong git id :(

Sorry, I have been down with the flu over the weekend and am clearly not 
fully recovered :D
-- 
Florian


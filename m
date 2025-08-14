Return-Path: <stable+bounces-169632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B4AB270B0
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 23:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441EE5A7185
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 21:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE60326C3AA;
	Thu, 14 Aug 2025 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ErQ4pAp+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD112DF68
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206314; cv=none; b=ZH8mv5xKCWoCP9VeOZ4PJ4ukdUO9EEmM/ch5myfcnwGcNEnyc6nBvhuxC8D8f7a+Y82d72ooJzmtatg7MzYrJR8/KxffgHc3d7+GnA0JCem+diR6g3Ml/GFLEGgkp0m1olSw5/UHarP9hurdQ6fMzf0ZKRJnqJu3xXkCWarHYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206314; c=relaxed/simple;
	bh=DGT/jWa8qfrlAoBv9pWpgQ5DVzDhdHztGsHRb9C0uD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BU3N21bhAImW3DT8SVZLQj0oKGqr++LwkzlwoPPdc7F7p9FRxI3NxAWv1OvVPV68jGZc3SEVC+DTSIyv/DKzC3/OpUxUefpPF9SOjHONC41DByh9p25oF9Fb/Ha8qgQQGi124/wDHmkNcsTtVMjXIudYNI+MyJtt3KSP/wDIoJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ErQ4pAp+; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109add472so16847921cf.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755206312; x=1755811112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JAdg0B99nBx176JSa2IHf0Gqum3MIVsaAKCTeNllKPY=;
        b=ErQ4pAp+Q2phEVPynngi6eZVkntSCSZDJyTU78/37UCwnUlkSeOkoiZrDlDZYuzfA3
         ObKrN2/tAVfwjJYyA7cfgJUbM7feVzjsyu4cd1cWHvbkgY2aW+3rn+rSzUWamoP+pFmz
         ZQfBiDbM7pTt0lZWqukielgQOaTfthDBXTMqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755206312; x=1755811112;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAdg0B99nBx176JSa2IHf0Gqum3MIVsaAKCTeNllKPY=;
        b=BI4F6saj2zpuJbcYHPUCecKjfLQzOAlcUbeopg7PHffdppjyyEBSvAMhucz1y40xaW
         jQ/Px0cNO01DNJYBRa33fJHug3UWo5brnuf4pbtq/vrice75XB3r3VsbHnBO8MXVkKWc
         p/FL4AZzDl97zQGK7MXPQdq0IHv73INnpf0MFP/5QcEK/toV5vQZbgXYMDk5h2CWn9WG
         iCnimjfavu/V6qf35cE49oREatI8+aLjInur39WLU0Wq3L7kENsO0RJFRokeXUzGtW5D
         hQBlTDFXtJWpX7FQwI/J9RkT7jOMnOcc9uoX0lYGTa1Tps9iqhUeusuqcP1APT9C7xTy
         +ARQ==
X-Gm-Message-State: AOJu0Yzf7zqDDiM4EHUx4+VkYbYNNrhHHT3oYRxPvgToKrDaFSysVJDt
	3uwWrgBI4m+rsQi/4/EZhBtbfqq7gvHD4aQfhtn6lrsZNSYKalyRtz9KK9ZdIAES+mOUBgbbWdG
	WmiI=
X-Gm-Gg: ASbGncuYdbjdxha0xNw19PyzoG17VdU7NwITN0qXzi0qi/81Lvu+/WQYd+h5uTHoUbd
	ddtJDg+rV4decHa0HF4RYrAaC693dWt3gPXhYsz5ce6rlhvNaOUdyINDwqsyc4OKpq949jQsNg7
	QiZFKg//8UYwv1b8aS04ZlwPlgJOlhAT6wotq4tqYIxhAMV5ZNt+paUSdp7ZFUktAV1rco955EW
	QYTYIU4DX9/AfQuqeJ+1SDePPDLEQwqJF5h/O0e3Ufc2eUCXKNViPBJrNU3dJj1uywr7QUWcf3D
	dd4AcXdx1kqxXkwiVEzfvJw5WpU9Qo+Pl9+c8hdPps1SXQlJ6VKLwCA2zYNl9CM/Axj1yDrISE/
	460SAfL4rAnDu/Egif9I+wLqZFpdKYWySXfJcdtD/1Qrk6iMFpjaQNPsLm8CuyXjN5w==
X-Google-Smtp-Source: AGHT+IEkyDNQAVKyJmRDAdsYevWYyNxbZ/vyLLcRBzDMVeiEDD92XcTmdKvPGNmmapwrDIe+yHQzFQ==
X-Received: by 2002:a05:622a:5b0d:b0:4b0:89c2:68fe with SMTP id d75a77b69052e-4b10c5d9357mr58049511cf.52.1755206312164;
        Thu, 14 Aug 2025 14:18:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11aa1216fsm1550341cf.37.2025.08.14.14.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 14:18:31 -0700 (PDT)
Message-ID: <84811e34-05ca-4988-b5e5-64c31e2733e9@broadcom.com>
Date: Thu, 14 Aug 2025 14:18:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: brcm,bcm7271-uart: Constrain clocks
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Al Cooper <alcooperx@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250812121630.67072-2-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20250812121630.67072-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 05:16, Krzysztof Kozlowski wrote:
> Lists should have fixed constraints, because binding must be specific in
> respect to hardware, thus add missing constraints to number of clocks.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 88a499cd70d4 ("dt-bindings: Add support for the Broadcom UART driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
--
Florian


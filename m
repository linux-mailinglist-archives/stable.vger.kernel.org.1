Return-Path: <stable+bounces-89231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C219B501D
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 18:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B811C22B26
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6CD1D8E0F;
	Tue, 29 Oct 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D8sDe5Mn"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71D1D8E01
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221623; cv=none; b=qWtiYrAGiW8IripekLnzdHmtK70C8jCp4MhXnttqwhe1psTbMFdtpRdwka2JYExqOvtYVeV+egv+akIDO25opvGk5YSUXwNWKdoIPrPFBQWAD9P66rcxMBK72wwgY0qLxuUzfyhQSaI/DFnduMAhhCPfqiR1oVBw0LXH8PBzBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221623; c=relaxed/simple;
	bh=eUfsLPOfT8Cle1sRpu2ISxuTElP7SH6uxbtfA3tu5HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLbqJq6G0jaOw4NkogxRuE197vI9sFgLsx9AdL9yOKR0XfsgYQastRWnx41/CwZp+yf8JJ+U04GyiZS00h/jiFfcm6iRzbUprWFTfKklm73DQSPVPQ9/cI4aksmacU76Pr4orHKlDH4F3j+xakkTxa5oDDs02qRaKd+CR1MWtgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=D8sDe5Mn; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbcd8ce5f9so42707436d6.2
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730221620; x=1730826420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XUJvc61OU63bFccHPQvUU/nZDfsgPsRPvd/ZVSTIseM=;
        b=D8sDe5MnigQ3ALBz9z62uYEz8ZVcrrpcgXH0tX/MWomEUgRHLJkh+9VWl4Gve8+759
         ZizwjQ5eeSs/dXmVSk5FASDM8a+88r9WNVnyo8gzoJkjf30jU8kUbAousFUdseCYg+Xx
         uJJPZlNBMGcoFPNIHFZ6w/BxdpQ6Gr5HMxlYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730221620; x=1730826420;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUJvc61OU63bFccHPQvUU/nZDfsgPsRPvd/ZVSTIseM=;
        b=mTi634xuY0VINtjgRK2hsMIzUMpn+abee+gMbBJfh8QkVZeAibydXwrKkgk0RwGSIB
         Cqs5JDE3YWwcpy97GFOywmp/s6rzn4QfBgEYrmAtDExbbnliqSqOA9K17vZ58PqNIeE2
         28CwoFMh0bbPQt5L39YV29zNZsmJ/Vzc3d/Nvi1cdn4GzZrRMs3Zc8WPHHQHzMrzX6p8
         /YW/JmSqB+fj1DRpe3mlN9ujdm0DNu6qbz8Lhw5Jweu9o7kEDXORvDQ7wh6PYq08pyHv
         YUnMBVezL9AkqHbeeWC0Lz4jUgKqxS91gnD2JVnHGido5nAVI7srKDZO2pch/DlYRHzB
         sP0A==
X-Forwarded-Encrypted: i=1; AJvYcCXSjaxMurri4H3iwf+WT0zpBThA28w92XrqLEvBJVEHqoYc32p+LBF0aVraXqaLoRhSi9GQi70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgaXrpbWVUc7coOxVmAj9DRoMm0Cuyd2pfoLDQl9A+C62j6xM
	8Q3bMK+sOS0XkRc8r3z3SpPqgtFuKMsqRB/3ILhFKJFRtLRJskmwAxfJ57ppTA==
X-Google-Smtp-Source: AGHT+IHCGKwhf8zI6C5EC15lum4w7t4OGXmxeXEVnk6hKfTc2d8BQmiWhoi2TM0vTYSCnfcEJSq+DQ==
X-Received: by 2002:a0c:db83:0:b0:6d3:4055:e92c with SMTP id 6a1803df08f44-6d34055f03emr22792006d6.8.1730221620060;
        Tue, 29 Oct 2024 10:07:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17972f73esm43780016d6.16.2024.10.29.10.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 10:06:59 -0700 (PDT)
Message-ID: <51b6692c-4e71-4f4e-ac73-fc87b9f2ac5b@broadcom.com>
Date: Tue, 29 Oct 2024 10:06:56 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "cpufreq: brcmstb-avs-cpufreq: Fix initial command
 check"
To: Colin Ian King <colin.i.king@gmail.com>,
 Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241029152227.3037833-1-colin.i.king@gmail.com>
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
In-Reply-To: <20241029152227.3037833-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 08:22, Colin Ian King wrote:
> Currently the condition ((rc != -ENOTSUPP) || (rc != -EINVAL)) is always
> true because rc cannot be equal to two different values at the same time,
> so it must be not equal to at least one of them. Fix the original commit
> that introduced the issue.
> 
> This reverts commit 22a26cc6a51ef73dcfeb64c50513903f6b2d53d8.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sorry for not replying earlier on.
-- 
Florian


Return-Path: <stable+bounces-112049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D288A262A0
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 19:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57507A142F
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C3E15C158;
	Mon,  3 Feb 2025 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S3om0FC6"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82177770E2
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738607900; cv=none; b=MH2PI1ihLOEZSKPuPbLQcKeZgwlOzzcQVWm/U/jdpeWSZuXTMwiiJ/jemZtcPtiJ+gdeqOCktneBRgMxuM68cMtHS5u4U2kguX9vnYR9o6/oZY8zuwCODVbK62VmWbEZqZ92sUg0Q2FtQKwhqRDSSrBtYOedGqu9iW92DKfyIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738607900; c=relaxed/simple;
	bh=NfoHEeS9ety3RUabRC5wtZ/YDZzyPb5mVsFRQaWmcaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRQ0uc/7mfVhbo3+VvZBCe6rCfYcxCut/KiPS4w+sebxiCyw58v3csO56LTa4L6ufNmncUbPSiEcNOMaMrvxc/R7mpKzcsLEXfdxWpON3fQ+m3UGBmSCJfVdDmSOJ1/dVmBheN96VUAfjNmcl9t0MD+JLSsWjqUzrVRhXkw4rVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S3om0FC6; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f2dee7d218so2115734eaf.2
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 10:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738607897; x=1739212697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SVQO+IqVJBjIpGvloQABHH8Rsr9K0FypYEqAHJLTov4=;
        b=S3om0FC66+7ID3mVH850TojMM6AuCcuipWVG63N+rPmEinDNwBQm1h6j3VLmOH9E59
         lcF4CpagEuXuGgPbQJzY1NXZwhl81++opQaCRgEkdZpekFF5gsbYzJddChA1HEerocMj
         02sA+W7L4yVzolgvBfCi+9I0/X3wv+3IgkO58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738607897; x=1739212697;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVQO+IqVJBjIpGvloQABHH8Rsr9K0FypYEqAHJLTov4=;
        b=M95Krde+2BX8ecV/yxmVGb91w1CuwTbBKltW8enepn/3qGL3wWemOVw5xVEYuTDfTX
         6rYu6GVWZRQxOL38wxYZ+UgEvu/TLJdOKdQwwsux35aI+PBLHJQIlAAbwlV9sngsHQ//
         OWW52kBSHH6zYNW0k9JQlui3FjXLOeN5hq5bPSlQ3xIiJxlY7QWZTxspYyzeHf5QkXKf
         BMO2kZ6FmgEigxU7Uvqmfjh67VPDF05SmBedD3IwWsoyKKhqGIlO5P+jk61ZEWjSu59R
         I/5Z5PeUv5YJ4UN+Z7H9hMitfy9B5jdeaDvszlIymY0enSlieTWpu++W7xgir90a5HpN
         BOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPDpQzFQW76Q+dYrHr1j3GCYZVLCB5Dvye68Xw4d4MhHe+UQ5n7kRdHRMa0+FU0FYuxODf1G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpjI5518EqHptZJzt03JsAws+9StT+UzIuiMiq5iQtVWlpMR/n
	ELZzq6B5/WX8U/P/E9zFFsMxtv6XrMnZv5mJxVGLABj+A+hjvMY0soxNQljh3w==
X-Gm-Gg: ASbGncsz0fgof1/jAIdTU5NvXGEJtrXxkr2/ntKapKhPrlF6uwG7FhNrN0hBjPB5JAU
	TbaCsMovgGV49Ijba374z+Tcf/715/Di/2zhf3WvNzGZ4tuxJINs62riVBYoIgobDTOeA+RHws9
	Cb1zVYOi0dna8FVBQVvt8f4vaKl37PKwYQTDRWW87lYdNw7sTcZd+dwjHKUaTqtjLx7aKTl2/G9
	BjmGw/3mXzK2waOvvr7+0trlUvO6QhQqHrGdUOmM2Jx7nnMy+pLtkvI9yej85WkJE8BSk/RYRyf
	uIfViiX4F3sZchAYrDG8D9Df0mgzFferM+wuU6F49eusAKvuxQCBRW8=
X-Google-Smtp-Source: AGHT+IHq0UgRpgomIh9PzY77Gg9Jllh5zVnpCNlPjS94WHuq2Eom48xqYLcjpklGGEZPFXErKSueNA==
X-Received: by 2002:a05:6820:2d43:b0:5f8:89bd:b99b with SMTP id 006d021491bc7-5fc0045ccccmr13214655eaf.8.1738607897456;
        Mon, 03 Feb 2025 10:38:17 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc1059ae47sm2782744eaf.28.2025.02.03.10.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 10:38:16 -0800 (PST)
Message-ID: <682b3f4e-7a32-4baf-a4ac-04ddf9c01a3c@broadcom.com>
Date: Mon, 3 Feb 2025 10:38:13 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: brcmstb: Fix for missing of_node_put
To: Stanimir Varbanov <svarbanov@suse.de>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 stable@vger.kernel.org
References: <20250122222955.1752778-1-svarbanov@suse.de>
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
In-Reply-To: <20250122222955.1752778-1-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/25 14:29, Stanimir Varbanov wrote:
> A call to of_parse_phandle() is incrementing the refcount, of_node_put
> must be called when done the work on it. Add missing of_node_put() after
> the check for msi_np == np and MSI initialization.
> 
> Cc: stable@vger.kernel.org # v5.10+
> Fixes: 40ca1bf580ef ("PCI: brcmstb: Add MSI support")
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


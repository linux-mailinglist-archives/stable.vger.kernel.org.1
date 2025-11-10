Return-Path: <stable+bounces-192927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4D4C461A6
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D33DA3450B1
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B363081D7;
	Mon, 10 Nov 2025 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IL2wBUnZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9643081C6
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772654; cv=none; b=MmYhyC9t4nmmYEDNIr10n1wTsIBdt2uTQcLM0Wh0seFW3+csoR8wRv/qtCHpLkpGNw/s3pqMDDhaGMLTIkA9n2vWI10v7zrb6T0Q9GG0Twcqgcwdf/6uqus5MhnJ+hClGXmLxMN1yG6bQg0Abhp7ZvHH632683kwSHGxKwlJu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772654; c=relaxed/simple;
	bh=1Z+gaT40oj3T5r3ek/hMQ0J0ma0x2pMde1fuBz+MOWc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gt4G7VNAgyJKecikgrahjCc0Fj0i38wjOzrOkfKMp1WBuRvozR0TFDl5tEGp0vw5ksOnSc3FYeW6utKyQo6LGrDma6MaRqw8F+FdJ6+39pB6SQwv9uu+alV4AngBwEstyTJYnLPegVlWuLu1R8PsO6zvXyXnRKGEQnTtHzxZaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IL2wBUnZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477632cc932so10879855e9.3
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 03:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762772650; x=1763377450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIWnZ8dEqAIo6e04DNrTq+ZCsjQol4ZAc5Df0I8mreM=;
        b=IL2wBUnZGYGVWNEpyCph9/ihdD+tX5BiyHigu9uHwImLuvHER+s21IVTwJxByNOF08
         IFvBbqHjowPabtmwGtm0uyxuFXgyPhQWBj34PVJRWXl9JMeBQ1NHNZIxK9JI3e5eQwy+
         RjWOtbEmfUGMGn5bkY89LCsOWdc8PF+x3CkBE5XiALHxJErI2NMutfBlpBcRjBqifYOL
         kWMM5L8Fgs+KffgNNWNO0nqZ2pIb1y5GkTRBD43WZBd2DX/db9714XGUtoz1cnTVrrRD
         46IGtLXprJxPW71shUaijrKUHLoXLGt5Oyo9/HhFRgyfHNMny9GZW3tdaXwkFx0xYivc
         2djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772650; x=1763377450;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIWnZ8dEqAIo6e04DNrTq+ZCsjQol4ZAc5Df0I8mreM=;
        b=nArx/efJP7u4E6oVfRcVI93+XQOWTaTSXuK4ZBMYgAsEsb110jopmlGxW+wMj3fh42
         QXrDRf20+PT4wFnF28yNpFNBIpguGTjJ5rJN8tc7+MsjjPCl54IVaLg+MlhSeoT2oULo
         /8VhMFeWLCFuki6EOT0TqFW1uYE0n7EiCzMz5ewFNsZ88CSOFWbWOE31Q5YXDbzm6TLS
         ps0sjdt2s1KPzkKHp9JLee5OjhjfaacOM0FK/lvyqanGXEyjozRByaSINMw5DHFTsnYw
         /cNKNgREZembmDEA1DfBnPwQsz39KmYOD8hVrS3xgADUw+jO3fAxJnpPU8VW3BWPvaDM
         58Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXcE3DF/WHcdjsPdH3HiVh2ZBygvOU6VgLEbHyTv7paBuq35cmRJvHoH5xaat98xtUITh+j6m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt025jnpkf6p2aIrDF2tAHPRCpEQhEfdmxJYBiiZWeSRIyit+L
	gDKNiIx2bkSlBHCp1ujs9NqgHsIjLsz8zJzUxOUEOLRhv+w+ACQH2Fu6E6XswS7rrk8=
X-Gm-Gg: ASbGncskS3JL+7aB9VT0TZRwlfsWYUiycsq1QhWXIli+3dxdeOy1/d9xzxTKALsRSue
	RxjQvdidaRguAAO9FWiL0J7JleW5ONRGntk37QGGoYB7ZjxuZYxrXOr294EJrWJRP/eGDbmd264
	sfAGUSbC6tj78Ni2Rm1fZ2qhsbqDY38+QIDl47+QWEzcuW9k1jMmLi0dLR72kfEpAT21lEJM/A9
	PzpiYL/lmNoq/EkpsLamIAyTJeN2wQ3+YgoW57NR5lfaO/izXy+ENe1aDDWFKz8IdmJv7VBJyVK
	NKQlYXIG1eTJt/YMCxHx/ptx8Q12VKt58YJCRaZDM3dVdHbW2CxZ07fhNTx3/k1FMhjL+9aF8Xv
	KTo2dn8Hy0dTvqwAHgLLcIRKZKVp0+pXrS8FoqOyb+1ON1sT41YCIQzRQO4NVwH39EUcEtdedWF
	VviqH0/R+M9lWZpCeRAVlhc014CLHK3sKq64jmsHU6vTm+mn937i0p
X-Google-Smtp-Source: AGHT+IH0yKFYlADFFoNgI+vt5Nvr3682vUUZksEIjYehH1HnbB5yCLv9XtMdyOspZEkknqy2NTGIgA==
X-Received: by 2002:a05:600c:c84:b0:46e:3f75:da49 with SMTP id 5b1f17b1804b1-477732a1d2bmr55933905e9.37.1762772649975;
        Mon, 10 Nov 2025 03:04:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:f168:a23e:c1b2:ae61? ([2a01:e0a:3d9:2080:f168:a23e:c1b2:ae61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4f13dsm106249415e9.5.2025.11.10.03.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:04:09 -0800 (PST)
Message-ID: <3c98a3f1-ca68-41ed-a8bb-f99a57ac57d7@linaro.org>
Date: Mon, 10 Nov 2025 12:04:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] PCI: meson: Remove meson_pcie_link_up() timeout, message,
 speed check
To: Bjorn Helgaas <helgaas@kernel.org>, Yue Wang <yue.wang@Amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Linnaea Lavia <linnaea-von-lavia@live.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
References: <20251103221930.1831376-1-helgaas@kernel.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20251103221930.1831376-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 23:19, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously meson_pcie_link_up() only returned true if the link was in the
> L0 state.  This was incorrect because hardware autonomously manages
> transitions between L0, L0s, and L1 while both components on the link stay
> in D0.  Those states should all be treated as "link is active".
> 
> Returning false when the device was in L0s or L1 broke config accesses
> because dw_pcie_other_conf_map_bus() fails if the link is down, which
> caused errors like this:
> 
>    meson-pcie fc000000.pcie: error: wait linkup timeout
>    pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)
> 
> Remove the LTSSM state check, timeout, speed check, and error message from
> meson_pcie_link_up(), the dw_pcie_ops.link_up() method, so it is a simple
> boolean check of whether the link is active.  Timeouts and and error
> messages are handled at a higher level, e.g., dw_pcie_wait_for_link().
> 
> Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
> Reported-by: Linnaea Lavia <linnaea-von-lavia@live.com>
> Closes: https://lore.kernel.org/r/DM4PR05MB102707B8CDF84D776C39F22F2C7F0A@DM4PR05MB10270.namprd05.prod.outlook.com
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Linnaea Lavia <linnaea-von-lavia@live.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/pci/controller/dwc/pci-meson.c | 36 +++-----------------------
>   1 file changed, 3 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 787469d1b396..13685d89227a 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -338,40 +338,10 @@ static struct pci_ops meson_pci_ops = {
>   static bool meson_pcie_link_up(struct dw_pcie *pci)
>   {
>   	struct meson_pcie *mp = to_meson_pcie(pci);
> -	struct device *dev = pci->dev;
> -	u32 speed_okay = 0;
> -	u32 cnt = 0;
> -	u32 state12, state17, smlh_up, ltssm_up, rdlh_up;
> +	u32 state12;
>   
> -	do {
> -		state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
> -		state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
> -		smlh_up = IS_SMLH_LINK_UP(state12);
> -		rdlh_up = IS_RDLH_LINK_UP(state12);
> -		ltssm_up = IS_LTSSM_UP(state12);
> -
> -		if (PM_CURRENT_STATE(state17) < PCIE_GEN3)
> -			speed_okay = 1;
> -
> -		if (smlh_up)
> -			dev_dbg(dev, "smlh_link_up is on\n");
> -		if (rdlh_up)
> -			dev_dbg(dev, "rdlh_link_up is on\n");
> -		if (ltssm_up)
> -			dev_dbg(dev, "ltssm_up is on\n");
> -		if (speed_okay)
> -			dev_dbg(dev, "speed_okay\n");
> -
> -		if (smlh_up && rdlh_up && ltssm_up && speed_okay)
> -			return true;
> -
> -		cnt++;
> -
> -		udelay(10);
> -	} while (cnt < WAIT_LINKUP_TIMEOUT);
> -
> -	dev_err(dev, "error: wait linkup timeout\n");
> -	return false;
> +	state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
> +	return IS_SMLH_LINK_UP(state12) && IS_RDLH_LINK_UP(state12);
>   }
>   
>   static int meson_pcie_host_init(struct dw_pcie_rp *pp)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on BananaPi M2S

Thanks !

Neil



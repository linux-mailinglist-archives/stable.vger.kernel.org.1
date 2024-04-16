Return-Path: <stable+bounces-39996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E88A66D3
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 11:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B331F23EF3
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 09:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845C84DE4;
	Tue, 16 Apr 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkqRZErT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5284D05
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258951; cv=none; b=Jt4uPQxQ1NXwx8K50237o2KM6KI6JyXQpbLbQra7izPV5H7NUze7BW2+sBPCVH3MJQta7EfFvHh8awNLHT2YXimY+L0Ia7yGK8iMQbdZsfUDfQpLRaIuPzDBf5Aj6iCJtmQT2MT4O4323daTdXw5GrrpbI39bzImrfHzQw4/7sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258951; c=relaxed/simple;
	bh=opn339ttoq96FjiCnT2o+VV6JFJcSp80Zl/+xFr3kTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMFTdMjyvP3R0BmO3S+5U0FSLzr04B1aCo5HrHap5ZDOImeWbXL512NY+4vsByZpMth13UCSf8s/3klZgBtB4nI+N1dvlqUwTTz/L5herwncBGhu0riYYxUSoAl7vtccwyh3fciSABfQiG7ZJXUoiHb8NMt9ZKfOXkzzbleVF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TkqRZErT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3f6f03594so26528945ad.0
        for <stable@vger.kernel.org>; Tue, 16 Apr 2024 02:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713258949; x=1713863749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rk1WQ+3QpO/6QliySx3KZ6AYelQe+QF9yeCh3moO8CY=;
        b=TkqRZErTwLuYuJKzZZ3ywI/G1GhKsLP7L0eFxQgyGz5I9F/+KxF/peLCzkTiBfYxkM
         CEy3PiyqwcLN/VI9YwnwmxNTTBYfRGyrM7Ikh+u+fE03Lp0ubVXSVQsh+56pLn5e6OeW
         CCCwEe5ny3Be5WVaJyl3efgzTSPL5t2Q0K+nNYyclaLoOvdWNM33jcvAde4hcNotmFnN
         liSupgITfytQBIlxBn7z/A0CkrEeI1mtxDzq8pfBzmoAMQmLLPOsxcmgTUe6RhcJITrS
         UzVKUVH17Nu/+KVAFu5xZ++a0Rk0PyVSNYkt3fTc5g9xcYxn207vtIWT1PrucoD9DJBn
         ASzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713258949; x=1713863749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rk1WQ+3QpO/6QliySx3KZ6AYelQe+QF9yeCh3moO8CY=;
        b=NU+5ZkBDVEQicEMy+PqHWDOrLKQVq6AbKN8OjWziH6O7ViSQNGgrEdDa+5HIIegZkD
         HPIoO9YKBT7Icey5EItaW0VUbsHWEKEbYDVp3063GLeM9KClQVwMVx4b85IVI6MfP1Pq
         jtlHdXysllCHFw25lijh3QQEdhKxD1p2cEpTqobnKqCc89VN1LJImSjO3Cg/0R1+Qyyb
         rvJZmmcoD5DMCcHJishBI3JJemuqASjC1FI3i0lLrQnacdfQWvXvamMWTqsGkRa1pqSj
         Gm12PkXa3JPzV+naqjL38wBRpZVdDvmYPzEfbuZtDgocpLxXj8husrtCeo/PKJfIIkM7
         r5gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd847+u1yD6eJKo2G30U1FwM4V2NRTvo3G3pWNKD3fTr72hZF4cDBD5zdyZZZWT55Gy9DDOFVN0fN3JKziKvNZ3liPZvzz
X-Gm-Message-State: AOJu0YweeC3wrZk9i64N+ohjo6zdI8pP1rz+H4LnvFoR0kWNB/jahB7o
	kDyl1JV4C7o3nq8QQIMi/XsHyGF0nqx4vbB+0WJdLRAS0ktuLj3u+VA2I42O2g==
X-Google-Smtp-Source: AGHT+IGJRCNlmDxyYYpADaPdST7LOgSRNL4oGeHhdQUfIc//HnzuAijx9v/ViY50hJoABvTNWua86A==
X-Received: by 2002:a17:903:41c9:b0:1e4:8870:7758 with SMTP id u9-20020a17090341c900b001e488707758mr12202867ple.39.1713258948828;
        Tue, 16 Apr 2024 02:15:48 -0700 (PDT)
Received: from thinkpad ([120.56.207.234])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e5cb00b001e20587b552sm9323787plf.163.2024.04.16.02.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:15:48 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:45:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Brian Norris <briannorris@chromium.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, stable@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: Re: [PATCH] PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting
 ep_gpio
Message-ID: <20240416091542.GA2454@thinkpad>
References: <20240416-pci-rockchip-perst-fix-v1-1-4800b1d4d954@linaro.org>
 <Zh4fkbQTh0Z1GNGK@ryzen>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh4fkbQTh0Z1GNGK@ryzen>

On Tue, Apr 16, 2024 at 08:49:53AM +0200, Niklas Cassel wrote:
> On Tue, Apr 16, 2024 at 11:12:35AM +0530, Manivannan Sadhasivam wrote:
> > Rockchip platforms use 'GPIO_ACTIVE_HIGH' flag in the devicetree definition
> > for ep_gpio. This means, whatever the logical value set by the driver for
> > the ep_gpio, physical line will output the same logic level.
> > 
> > For instance,
> > 
> > 	gpiod_set_value_cansleep(rockchip->ep_gpio, 0); --> Level low
> > 	gpiod_set_value_cansleep(rockchip->ep_gpio, 1); --> Level high
> > 
> > But while requesting the ep_gpio, GPIOD_OUT_HIGH flag is currently used.
> > Now, this also causes the physical line to output 'high' creating trouble
> > for endpoint devices during host reboot.
> > 
> > When host reboot happens, the ep_gpio will initially output 'low' due to
> > the GPIO getting reset to its POR value. Then during host controller probe,
> > it will output 'high' due to GPIOD_OUT_HIGH flag. Then during
> > rockchip_pcie_host_init_port(), it will first output 'low' and then 'high'
> > indicating the completion of controller initialization.
> > 
> > On the endpoint side, each output 'low' of ep_gpio is accounted for PERST#
> > assert and 'high' for PERST# deassert. With the above mentioned flow during
> > host reboot, endpoint will witness below state changes for PERST#:
> > 
> > 	(1) PERST# assert - GPIO POR state
> > 	(2) PERST# deassert - GPIOD_OUT_HIGH while requesting GPIO
> > 	(3) PERST# assert - rockchip_pcie_host_init_port()
> > 	(4) PERST# deassert - rockchip_pcie_host_init_port()
> > 
> > Now the time interval between (2) and (3) is very short as both happen
> > during the driver probe(), and this results in a race in the endpoint.
> > Because, before completing the PERST# deassertion in (2), endpoint got
> > another PERST# assert in (3).
> > 
> > A proper way to fix this issue is to change the GPIOD_OUT_HIGH flag in (2)
> > to GPIOD_OUT_LOW. Because the usual convention is to request the GPIO with
> > a state corresponding to its 'initial/default' value and let the driver
> > change the state of the GPIO when required.
> > 
> > As per that, the ep_gpio should be requested with GPIOD_OUT_LOW as it
> > corresponds to the POR value of '0' (PERST# assert in the endpoint). Then
> > the driver can change the state of the ep_gpio later in
> > rockchip_pcie_host_init_port() as per the initialization sequence.
> > 
> > This fixes the firmware crash issue in Qcom based modems connected to
> > Rockpro64 based board.
> > 
> > Cc:  <stable@vger.kernel.org> # 4.9
> > Reported-by: Slark Xiao <slark_xiao@163.com>
> > Closes: https://lore.kernel.org/mhi/20240402045647.GG2933@thinkpad/
> > Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> 
> I sent a similar fix for the DWC-based rockchip driver a few weeks ago:
> https://lore.kernel.org/linux-pci/20240327152531.814392-1-cassel@kernel.org/
> 

What a coincidence :)

> If your fix is picked up, it would be nice if mine got picked up as well,
> such that both drivers get fixed.
> 

I can see the same issue in drivers/pci/controller/dwc/pcie-histb.c but the
severity is high in that. The driver assumes that the PERST# polarity is
ACTIVE_LOW while poplar devicetree defines ACTIVE_HIGH [1]. And there is no
external polarity inversion in the PCB.

I don't know if anyone ever validated PCIe on that board. I will check
internally.

But this situation is not ideal IMO. The drivers and DTs are not consistent
w.r.t PERST# and WAKE# handling.

- Mani

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts#n182

-- 
மணிவண்ணன் சதாசிவம்


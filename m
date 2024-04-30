Return-Path: <stable+bounces-42793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A3D8B79C0
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 16:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2661C22D36
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E512F77103;
	Tue, 30 Apr 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc+FhXRl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B40770EC;
	Tue, 30 Apr 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487350; cv=none; b=JQzm4qqVkVsrTbmfcxdXTLJShmiVNIEVUF5XI0e9pF97B8xOtBim/B0POfq15avkJ3azRDJMbjrpDlMZd8YqGi45wBy7gu/nXtArhaMyfpa5K6JtIm78CWpTfeCQrD3vaPa580720wzoV2Jv92cPrA2yOgFN8tAiJt0OuuNhiOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487350; c=relaxed/simple;
	bh=6NIKwIAgQIqfLUNhD59Qy8vhbZmxIPCs/aaOGchDrVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBD3cwuMM9oPJYIXSJquxqCefqaZqFxaLSpqx0HE7tXJHLDlzyDBazR59ogzDEwYumAJ7KKPGiL/1GFYQljhH8kbvflfc1LHZvSNkaAJPiZy7DdfbqyTpcj76W6RApZe9JzwQmQXtL5QC2Z/LX8brSJa0EEo8QPOHGbk3bdOwls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc+FhXRl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b79450f8cso36519755e9.3;
        Tue, 30 Apr 2024 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714487347; x=1715092147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5R2Gz95K7Dus/X9dZx6gkPx9GDyp9rkLxQjqXwkPrA=;
        b=Vc+FhXRlugiTR/Z7xhZj5vgVDhUcBb8w7Fta0FBImtAHE0r/aByA7eGsR6oSBwruoH
         rKr6zjiqfKaw19OSnLx0wL4x0bAHvrJe9NqRFcfJaAdFATwfnFlpJfHvyjd3f4kB501i
         iVKLIGdBz2RrEKZuned0RYXnrQ5XammyIxMTWDYegF42CZ6jvH0LFx8yqC1++SotJp4G
         JffS7Mrjt6cxA7HEhEJLAmP2LBKY1BzBBT/3Mg3pY95HunVCJcUFE8KgcOBV+Xuj6Ck5
         2JDE8/KBv2iCrQA+LoN6uwbUGFFw7olPqoiCrIKkOI01lg+1ZQXny5Hjrfhx0gIfVJEK
         ubXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714487347; x=1715092147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5R2Gz95K7Dus/X9dZx6gkPx9GDyp9rkLxQjqXwkPrA=;
        b=YqntTQ2zQjI0CnHXlO9FkLVP27E/mjFKr1hAU3aaMWWCL5750XxyXFfTLrI39DMbjA
         A3HVVuW6cy/nfx4aHoURSMf6D6GzjtFiVftwIj1W1DsXjEBOS4HpG4qYESna29ZaTdCU
         uULd/smpu7MKl5wttww2fLK2tx41MOD0d92pARriQpSzFL04AAhdqa0tEgiRpy1PPLah
         +oYY/d4Ayx6AcxxgfSW01jphWVo2lwkIdRjI4mDb49my8TGyFjolaF76gR0uUe+EiKJW
         gHTfLoHYJA1YbFlimzloPy4IHzlqEDD9MEV9zLU/AuhbTTsbLJkLEfoll/1Qf9vb2+iO
         N3Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUd76hQVTo9qDnVfORKa7Yz5D37EtN5wfnN5tvuccgJRClvV7HO+xWUeLV80nXPt43PyFpB/bz3XyGGA6Ag7LIP33cEpXJLRcQBkXVxJ3E=
X-Gm-Message-State: AOJu0YyfNP3LDzhYGf+HcAa5aZZiG0QGyuWFxhjMGWh1PhgOdgyvUXZy
	O97nIcdx0ahgPQS+6sO5r5eq7PgRwezymMUNNn5Wdia6hW8hkw4mqZQEqIU3rZ0=
X-Google-Smtp-Source: AGHT+IHIYiD8v8xqKl5BVetZpuizRCSao9/O5h0P7FLqKkZeQSqKpLOoFNktktlyPgS83dWvs3dwTg==
X-Received: by 2002:a05:600c:1f82:b0:41a:1d3a:3fc1 with SMTP id je2-20020a05600c1f8200b0041a1d3a3fc1mr2273611wmb.3.1714487347110;
        Tue, 30 Apr 2024 07:29:07 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8c00:20:c41a:2f65:eacd:b1dd? (megane.afterburst.com. [2a01:4a0:11::2])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b0041c130520fbsm9928639wmn.46.2024.04.30.07.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 07:29:06 -0700 (PDT)
Message-ID: <a70070a8-abf5-4d3c-9b14-081ff9c5bc61@gmail.com>
Date: Tue, 30 Apr 2024 16:29:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "arm64: dts: mediatek: mt7622: fix ethernet controller
 "compatible"" has been added to the 4.19-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org, rafal@milecki.pl
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20240428112456.2019376-1-sashal@kernel.org>
Content-Language: en-US
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20240428112456.2019376-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/28/24 13:24, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
> 
> to the 4.19-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       arm64-dts-mediatek-mt7622-fix-ethernet-controller-co.patch
> and it can be found in the queue-4.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit b6f34784d92ba280c8a4f42e22fee3c41cd09c3f
> Author: Rafał Miłecki <rafal@milecki.pl>
> Date:   Sun Mar 17 23:10:49 2024 +0100
> 
>      arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
>      
>      [ Upstream commit 208add29ce5b7291f6c466e4dfd9cbf61c72888e ]
>      
>      Fix following validation error:
>      arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: ethernet@1b100000: compatible: ['mediatek,mt7622-eth', 'mediatek,mt2701-eth', 'syscon'] is too long
>              from schema $id: http://devicetree.org/schemas/net/mediatek,net.yaml#
>      (and other complains about wrong clocks).
>      

DTS validation fix, not a real bug. From my point of view it shouldn't 
be in stable. I won't go on in the list, I would like to hear from 
others how serious they see it. With my distro hat on, this kind of 
stable fixes are not helpfull to make a code base stable (as there is no 
stability issue).

Matthias

>      Fixes: 5f599b3a0bb8 ("arm64: dts: mt7622: add ethernet device nodes")
>      Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>      Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>      Link: https://lore.kernel.org/r/20240317221050.18595-4-zajec5@gmail.com
>      Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 5c12e9dad9167..76297dac2d459 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -846,9 +846,7 @@ hsdma: dma-controller@1b007000 {
>   	};
>   
>   	eth: ethernet@1b100000 {
> -		compatible = "mediatek,mt7622-eth",
> -			     "mediatek,mt2701-eth",
> -			     "syscon";
> +		compatible = "mediatek,mt7622-eth";
>   		reg = <0 0x1b100000 0 0x20000>;
>   		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_LOW>,
>   			     <GIC_SPI 224 IRQ_TYPE_LEVEL_LOW>,


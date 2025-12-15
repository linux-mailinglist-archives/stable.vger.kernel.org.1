Return-Path: <stable+bounces-201000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E023CBC8EB
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 06:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D5A8300D42C
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 05:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA17324B1D;
	Mon, 15 Dec 2025 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="seppDYHU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB553242AD
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 05:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765776259; cv=none; b=BvKxNnudq0/q2lUy0aOt01Qv94Cdgy+7B562ZzlvH/QofaXkk82kc+TRf/zMkx1Vc64t51SPTHmZA3+AR9VQLSy31+6XBfmUbYccgqOOBCgWvxFpL0AaPyP27S3RQIZTq0l9YzKGioaZ4NseXgT+RmI73WXUAwZ5KqvHjSARO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765776259; c=relaxed/simple;
	bh=POFd9M9zUC0KxFxoe4gSkNmeH8eJscdCkjl5X59utZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VldfU14n1ZxhjHYlkudKBi/5f5Kx2ENNjDFBWA1F2A7S7Mre8hrsNycJWjRXG00i8TP8uFHgDVpm62gUBav3UazqyvAi25OYd7idzVT31/mlS7JddmFy9a1rJjbSF3en7W6s5eiF9GZDgtd8aRuTosgPmJA0oOP8/i6inTccXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=seppDYHU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0c20ee83dso11122405ad.2
        for <stable@vger.kernel.org>; Sun, 14 Dec 2025 21:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765776257; x=1766381057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmmxZTmEMkdYAdK/pJCpdNbxZ/BTXU9Mug79unJZ37w=;
        b=seppDYHUO2besGd5geqSsRIEntntN26vOhIHAlWjNXkjgWWxzcMMaAXLbD/NKeFOF0
         1ToiTNDgCZK79gjGuv4o1oUzkHAwLYss4e6yAq+R8LJwexn3CjqYJKIUI4Gkpb5lPZq2
         q4i8/Ta4uKyzA+4ZH/byfI2odZkVMQ+K5kOkR56ka/83rfVWExkOocFGZs/UQWJBHe8k
         1jCPw3ls2BT55pseGhihv/tEIprOeNFuJs647WGXI8Rwcw7PM/NdRJwHMqkgYbmjVYZd
         alsx2u9Hjw0FrzM7PDR1UwOgL4cwJNgfXLziRSozX06YIGW2WTNb5VWJ6t/XME9e7i+y
         CvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765776257; x=1766381057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmmxZTmEMkdYAdK/pJCpdNbxZ/BTXU9Mug79unJZ37w=;
        b=bjHUReivaexdLNNoycRglu207WzkSBENF+LIG4fJW5BTVoMYPnTunyUYRfeGGxFV28
         pTGxo1/YThbcp/D8a1SeWF8zwu7bTTDxKFy2njy39VwtAa2KkuP8qi5HcMTP+8mt/wQD
         dS1yLI+ILg6sf84GT+sE4mA93SuhDdh8iV06pyTYOziOk2eOd3y1p6OUTx2EzHLH3CaU
         +pzP+8+giXEa4ETiEUSsjueXsjNnBmy2smroh7Xrvw10w+e0w/OmymyOJ9JoJaKY5mn9
         NvCV6rhWQDWQENA8qtR64zdEQnlSpZHxAWMAsGqoCuOnUO4va5KzaHp4CZFL5g/70oGO
         2uHg==
X-Forwarded-Encrypted: i=1; AJvYcCXNa95biPVEp3wQN/knLxBI43OUxYzUv3V+NyA7fn9VPOIVYCj2Pc7FYxNIQNjMqasDdHVh7SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwufmMVy6oBtNVs5rafJtNvEy337BHEFgP+vFox4myw9Sb/gisU
	ehyJtfPRSJd4YBXbdZRTdelV+oq81xAYjQY5esnY1u/oR+v3jM855Gd+j4i618iVrRY=
X-Gm-Gg: AY/fxX6VMXLDBJ3djkYqztsVnT1rtTmtxRsZ/qFpA0DY3ej21ATc+zyZsh1IudhkFUa
	NXnJCodwywxgVmE/pZwq9OP9UEZR1tJCS+4wi0YU6s1oazQ7pchFEC07/pyC+9JPjdbF1pCcIaf
	tRE87GbHYWWcmAt0Ojax9tzzZCES3WsZse2J4Qa1MwBEsWGk5/tUHg7xE555hm9qprymQpu5TX8
	9JdMMQegQa4mAKwvca7SUbU/T5cKTRC5Bd22+4Y0diPRSyV0gBqdbJunRUHLD5g3e3X6pAjVz33
	uzi0djI7N+NWNf8AUbWY2Si9MO1b6enivOnVBFbgsY3da8kqTNnwO0JgBrUS8p/pg474xP5f7T0
	XEE1xhFOgp+cu5lwNMdnLe437912wFp7j4qCMA6uEc9TkSiyAdiTl1BjQoHNLEwa2WEzk2R9z1M
	CdDXm87dD0f0k=
X-Google-Smtp-Source: AGHT+IEd41nLow/C/F1F8kEt0tXjl1QE6vzy70JC5wiTjrDdUwnfg8mZsdGVruncG42i4nuvAMIN5g==
X-Received: by 2002:a17:903:1250:b0:295:6122:5c42 with SMTP id d9443c01a7336-29f23b6f3fbmr83337755ad.24.1765776256905;
        Sun, 14 Dec 2025 21:24:16 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f177ff327sm88774495ad.101.2025.12.14.21.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 21:24:16 -0800 (PST)
Date: Mon, 15 Dec 2025 10:54:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Paul Mackerras <paulus@ozlabs.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pmac64-cpufreq: Fix refcount leak on error paths
Message-ID: <oitkhsra7pax76dnz7r2b6wrpcljck5mwjubrjqclrerpp2kif@alms5oodo5h4>
References: <20251212092910.2454034-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212092910.2454034-1-linmq006@gmail.com>

On 12-12-25, 13:29, Miaoqian Lin wrote:
> of_cpu_device_node_get obtain a reference to the device node which
> must be released with of_node_put().
> 
> Add missing of_node_put() on error paths to fix.
> 
> Found via static analysis and code review.
> 
> Fixes: 760287ab90a3 ("cpufreq: pmac64-cpufreq: remove device tree parsing for cpu nodes")
> Fixes: 4350147a816b ("[PATCH] ppc64: SMU based macs cpufreq support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/cpufreq/pmac64-cpufreq.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> index 80897ec8f00e..0e0205b888ba 100644
> --- a/drivers/cpufreq/pmac64-cpufreq.c
> +++ b/drivers/cpufreq/pmac64-cpufreq.c
> @@ -356,8 +356,10 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
>  		use_volts_smu = 1;
>  	else if (of_machine_is_compatible("PowerMac11,2"))
>  		use_volts_vdnap = 1;
> -	else
> -		return -ENODEV;
> +	else {
> +		rc = -ENODEV;
> +		goto bail_noprops;
> +	}
>  
>  	/* Check 970FX for now */
>  	valp = of_get_property(cpunode, "cpu-version", NULL);
> @@ -430,8 +432,11 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
>  	 * supporting anything else.
>  	 */
>  	valp = of_get_property(cpunode, "clock-frequency", NULL);
> -	if (!valp)
> -		return -ENODEV;
> +	if (!valp) {
> +		rc = -ENODEV;
> +		goto bail_noprops;
> +	}
> +
>  	max_freq = (*valp)/1000;
>  	g5_cpu_freqs[0].frequency = max_freq;
>  	g5_cpu_freqs[1].frequency = max_freq/2;

I would rather handle this in the function that gets the reference of the node
in the first place: g5_cpufreq_init().

-- 
viresh


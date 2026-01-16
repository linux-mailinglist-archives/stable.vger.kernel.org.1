Return-Path: <stable+bounces-210072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE191D33555
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 16:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BFD2301460E
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8FC33D4FB;
	Fri, 16 Jan 2026 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLOpIHnQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2/u0iU9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D733AD8B
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578802; cv=none; b=Y7Pl4xW2KpLFZ0CM4IkRVBa7pm/zk8XS0Ytdg/7xEiYi9muqmE7nf4BflQOgjuNYvbk8uPUiVOuJxxD16BUV+NRBEcStLa+kqd0X8uJBwxidPWDIrWBKpbzCKSNyqbCqycr1uXFeAu8HMYBa73CyDaIyOYo8nyAEl5yb3X8ONp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578802; c=relaxed/simple;
	bh=tUIzXBRcsa82Ow3akZ9yIu7FKEN2cx3y9Mw0/MZvzz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyZcYC+Z5XgljCaEeQjQB6vMCIW+XZOWKdPwLnEn+pcz0nxAWybFv3g9Sgl1+yP/C744oNPvhWZojTDF6KIMg4NKKn7bHu75ohf/WlMqr4FNhNE3DNgGGqQ6vsYbDrcNT34L4FnmYI9Bth2BwB/2q+Ea4xhZB7mZJulSGUo+cxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLOpIHnQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2/u0iU9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768578800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WU6nLWwBmoRVgJX2Z7FpKifeDQ1VOBSEjGQogfq6V+M=;
	b=eLOpIHnQjlSh2W/SSN2OuSIRmkVb5J2+421sb/Hl7V4HBPjULXkLMYrT43rSNiSvX8Rj7B
	h3jMsvP8bvnGAETktsJtVUK0pbL1WgthuftIBxWfieXE+rWm2HY92L7snxxq4rXzXyU6m7
	/miYq3pu+YR+1mtzjmDIrAPUwLacr9k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-pCL9rVFtPG-6S8RXF9zfXw-1; Fri, 16 Jan 2026 10:53:19 -0500
X-MC-Unique: pCL9rVFtPG-6S8RXF9zfXw-1
X-Mimecast-MFC-AGG-ID: pCL9rVFtPG-6S8RXF9zfXw_1768578798
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c5296c7e57so804638885a.1
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 07:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768578798; x=1769183598; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU6nLWwBmoRVgJX2Z7FpKifeDQ1VOBSEjGQogfq6V+M=;
        b=P2/u0iU93WQ6GTcz4EID7JzLZrnHvkl0Wa6qKZeXO2HRmp9bGk/Ez0yOnlF6knzQBk
         M1yuNgVDIICnxsG6flZcaYhVeFT+vPCK6ONXtvYmkW1fA7LhUEfhDY7eFGfop+xkBrgH
         MWLiipifB8ZbKqumWmtEOY4wSFCS8CYnXZ23a+QXjv/A7LhO9vTBJDCcUiYSy42kqiAL
         NexSCMG8goNcpPb0G99MlikpUAooj7HBXkyAdgxYcG648s6TDjxxn4MmC1WOxySmxyuA
         7lPIIt4HIV7Jk91sz8Uz65VRwsje6YIVIK6K5/L0nYiSYxxBc8E5+6TAS+F5ouk6kUVs
         p5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768578798; x=1769183598;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WU6nLWwBmoRVgJX2Z7FpKifeDQ1VOBSEjGQogfq6V+M=;
        b=D5suZ8qU8LkUrCuvT4ph9H6VG8e9jt0TUji4tLga294wYPg0vNB4cp7+6AHAh86wsP
         M+FXpbjHVFeZpiPsaUtAgNfUJN4FDKoT4YnSxmEfXilKHyMlkuSJisi4RL206JtGCchc
         eoe/ySQ7PQavJSL9aC6EQkH3xO90WMSm3ml6Q82OCU1cACoitb2oyH7ZLsOUGPHCHpid
         6T7Bg9hQbbYnyKkZYtwfXCq8FvK6W8rcCzNSYPYN1QNHx+SWfCnHxK+rQ7DVlujZoaAj
         5xtjEp7kKdHcXQAFuXQ2Y7s5UgAk5HxWm42xF6fz1AnmDRqrkyqziCu9Qi4EBl1KQaYJ
         LLDA==
X-Forwarded-Encrypted: i=1; AJvYcCWvF/GcoNu9kD9duJ57h6LHU7xcqPHkFzFC5m2ps6emCpwvkzomPD1/nvKU6XXBXwyY/HBsv6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCF2wrEzbT6sC37tEQlQ6GWv2lBmpVhWKz9XetVkt1F/nOq+tm
	n2Wj8dp/EP/XZ//eRiLo5km9xdeVnO+SDC/+kC+8wGKvdni4OHlriskgiO8Nab/D6VYPVaKInq9
	Vyx/jQQ2UuwU8XJmebqITe26+ZGDJLi5j5uWF9/bCql+u9fDxa0mS+bw00g==
X-Gm-Gg: AY/fxX5BDInUeEMQqz7qExC7GzEufVilwH2JKl6zF2zM5jC0+KLmviPfTIktZoazZGW
	Fw4GU6LLsubaYvZZx67VXTY4gIL1WFcrGS8SIleB9Tlry8piHj8JH0F2wmqX2f9vxp4NMt7Idlw
	YjE/YdNnDG+lgWCgyDvobUGRUJuQiz49Cn1fqh8Kh94w0/A5jjE00o3Zqx0tGszuvippA/XQNj6
	pZO7VzVmRU0v8I2RQsX3xwddlgf9QKjsJ1dfkrzvIbxSpdFPCM8QZ4Y++EUggyBuh2ChdnKl2A/
	AmOQWV5V+38OEOhsin21cZXSz85hFHYhcPoNdssUFsI+DWWec35xGFvLwa0OweVGUJyE23mzQHk
	p2nqJG8Hgl9laFv/DKcif067z1NgNWPq5Z+hTU2V3y31W
X-Received: by 2002:a05:620a:1a89:b0:8bb:a037:fd8f with SMTP id af79cd13be357-8c6a68155ccmr452317285a.0.1768578798491;
        Fri, 16 Jan 2026 07:53:18 -0800 (PST)
X-Received: by 2002:a05:620a:1a89:b0:8bb:a037:fd8f with SMTP id af79cd13be357-8c6a68155ccmr452314785a.0.1768578798104;
        Fri, 16 Jan 2026 07:53:18 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71d8314sm256755585a.24.2026.01.16.07.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 07:53:17 -0800 (PST)
Date: Fri, 16 Jan 2026 10:53:16 -0500
From: Brian Masney <bmasney@redhat.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 7/7] clk: st: clkgen-pll: Add clk_unregister for odf_clk
 in clkgen_c32_pll_setup()
Message-ID: <aWpe7MWiJlduga23@redhat.com>
References: <20260116113847.1827694-1-lihaoxiang@isrc.iscas.ac.cn>
 <20260116113847.1827694-8-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116113847.1827694-8-lihaoxiang@isrc.iscas.ac.cn>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Haoxiang,

On Fri, Jan 16, 2026 at 07:38:47PM +0800, Haoxiang Li wrote:
> In clkgen_c32_pll_setup(), clkgen_odf_register() allocated
> clk_gate and clk_divider memory and registered a clk. Add
> clk_unregister() and kfree() to release the memory if
> error occurs. Initialize odf to zero for safe.
> 
> Fixes: b9b8e614b580 ("clk: st: Support for PLLs inside ClockGenA(s)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/clk/st/clkgen-pll.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
> index 89f0454fa72e..3fc0af4b77c6 100644
> --- a/drivers/clk/st/clkgen-pll.c
> +++ b/drivers/clk/st/clkgen-pll.c
> @@ -761,10 +761,12 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
>  	struct clk *pll_clk;
>  	const char *parent_name, *pll_name;
>  	void __iomem *pll_base;
> -	int num_odfs, odf;
> +	int num_odfs, odf = 0;
>  	struct clk_onecell_data *clk_data;
>  	unsigned long pll_flags = 0;
>  	struct clkgen_pll *pll;
> +	struct clk_gate *gate;
> +	struct clk_divider *div;
>  
>  	parent_name = of_clk_get_parent_name(np, 0);
>  	if (!parent_name)
> @@ -808,7 +810,7 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
>  			if (of_property_read_string_index(np,
>  							  "clock-output-names",
>  							  odf, &clk_name))
> -				return;
> +				goto err_odf_unregister;
>  
>  			of_clk_detect_critical(np, odf, &odf_flags);
>  		}
> @@ -816,8 +818,8 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
>  		odf_clk = clkgen_odf_register(pll_name, pll_base, datac->data,
>  				odf_flags, odf, &clkgena_c32_odf_lock,
>  				clk_name);
> -			goto err;
>  		if (IS_ERR(odf_clk))
> +			goto err_odf_unregister;
>  
>  		clk_data->clks[odf] = odf_clk;
>  	}
> @@ -825,6 +827,14 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
>  	of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
>  	return;
>  
> +err_odf_unregister:
> +	while (--odf >= 0) {

I think the prefix -- is not appropriate here. If clkgen_odf_register()
fails for the first odf (ie odf=0), then when we jump to
err_odf_unregister, odf will still be set to 0, --odf will set it to -1,
the while loop will not run, and won't free anything.

What do you think about using the postfix operator instead?

	while (odf-- >= 0)

Brian



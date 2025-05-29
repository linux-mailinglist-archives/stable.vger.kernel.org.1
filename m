Return-Path: <stable+bounces-148044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF8AC74C1
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 02:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C4F5011ED
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 00:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84EA10785;
	Thu, 29 May 2025 00:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DV50x740"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3825228
	for <stable@vger.kernel.org>; Thu, 29 May 2025 00:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476905; cv=none; b=fehzdc49mOjolqK3T+WfmwFzS2sXtwgBlyXivx5S7XCX9OLXxh02/j5lDhpZ+LiZcn4gSl6WJe8kk/xF1k8yc6rRh/4ZH09hVNH1rkuW3srB/yrpy8SKxw4gQaGK73U8ngVJ+Y4tnhKor6BnY8iFn6YZrcb7BP/j1KAfOjtgqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476905; c=relaxed/simple;
	bh=T3juE1hOUm6DFe5iT/pHd3UmRK7XfYewH+PUs5EwYN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKlHcPH+I7HP2uCBIeFdvfC9GA45sUeTB88NAmzclAEIV4YT0xhsM05yVzAL4ikaq9A8kge+FtqPJhVMX2lkcQoB/DaV+u1qS4L0/sQmW636arc9cqoCiMEmmrKkaumdPI/0cAWgBGsl0e5MhScwdZClTz9ibOUyuEIAG9Ug30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DV50x740; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742caef5896so218036b3a.3
        for <stable@vger.kernel.org>; Wed, 28 May 2025 17:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1748476903; x=1749081703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHrYl8KlTDJV9fZehVT6wNYFoGVLZmH/YM7SP1Otey4=;
        b=DV50x740ZiLdVCWqwMXcv60Mn8RJ2GTIDm9RssFMLLKlsTVJ7qvZwzKSQvTUMFKcDm
         pX9NFcvIoO6gQTqCB/XXC+I4YTZDJf2DJaP1h2NtUzIB009Rr8fxhRLWX0mbOhsFihZJ
         Ipefk4NVQBOSKfNa6+g3fpZlkts8X2YOoSY5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476903; x=1749081703;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHrYl8KlTDJV9fZehVT6wNYFoGVLZmH/YM7SP1Otey4=;
        b=kaycKYmcm/qbSVWG0DoliHcclDKZmeMqm1dgwBf1/HUeLD2z7q+X0ng5PV5s6KHiHL
         ieDb0NoPVu5nfFhEMjp/thyOM/8VX5FTF9rNYYeMXwpR0WFF566JbzmScLWkJbnysIB6
         kMhrDCMC3hYJKpS8w3rImn5b80Z6k7vTP3JezP093nmQfaoowL69Cyn1BzwFxG2Op3yx
         s8Ql2Y4H/i1cnioSZ5C5yEM6lPVvqufh9PXUMjfHNW2zm8FH3RTHX9B424NuzeZ85iKw
         WrYYb2c78FNRnbStI5YACwHLR2NregdkIbI/sXbQrRwYi/fjftGY7/gg7HOycTiOK2kk
         +uyw==
X-Forwarded-Encrypted: i=1; AJvYcCUuwacDOSbD0SnuzogGenRTjLXX3YjLJ1qZcQta90YEucMm/IM9mp8iraZfbQs+EXuKaA2OfMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8My693lcIR8RJ0jdszfHRitrTCKURQQUhNN5cwDTNMzPCJKNj
	LppFcTITz76ornsvurjolVq51SB0sBYWqy7eWNiVsjsnoTZ/8UN2njWUM0XMMGsO4S8=
X-Gm-Gg: ASbGncu0otHwlhinhPAfqqlLVIShyDnANXrNChUfVrmFHEhZ9i+aVrU57g9dXcoZu/5
	jPQVfU+WYITggHJS4QXhXX7RR14piSAq4gApJnWiAMDgVi+o8nIOhyzt/i9n7a/qVLPGyoVWGsj
	73PPdrY59mostXjwKQS3JaEgRhwCD9BQHYEVpSHlehoR+89II0oerI7uSR1vn/f2H4GqgP4NqVu
	yCFqev1yEN4e3+44NThPQZJ5c8orrASlPc750UXjAcxy/P/XkjIc0+obxymVyCvgfoBVuYx9Mgz
	yKL4lePDMyULj42yjGJXdomH3FO/o8CbkfWAz2mu5SXXlHkIRTU8uMas7qYDyk2eUVNsIkN6ksf
	EqDUJou3IERPrIuCpVeECzUw=
X-Google-Smtp-Source: AGHT+IGh6QFynq+YuUMFZqTG/73Ufan/2rkYRYNy6qC4rW91iir86PkvuJN/O02OksGF7UPuPg4WFQ==
X-Received: by 2002:a05:6a00:1407:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-747b0c72ba6mr275550b3a.4.1748476901844;
        Wed, 28 May 2025 17:01:41 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafaebsm165546b3a.87.2025.05.28.17.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 17:01:41 -0700 (PDT)
Date: Wed, 28 May 2025 17:01:38 -0700
From: Joe Damato <jdamato@fastly.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: niklas.soderlund@ragnatech.se, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: rtsn: Fix a null pointer dereference in
 rtsn_probe()
Message-ID: <aDej4pD_ZzB8ZQdP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Haoxiang Li <haoxiang_li2024@163.com>,
	niklas.soderlund@ragnatech.se, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20250524075825.3589001-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524075825.3589001-1-haoxiang_li2024@163.com>

On Sat, May 24, 2025 at 03:58:25PM +0800, Haoxiang Li wrote:
> Add check for the return value of rcar_gen4_ptp_alloc()
> to prevent potential null pointer dereference.

Was the null deref observed in the wild? Asking because I am
wondering if this is clean up instead of a Fixes ?

> Fixes: b0d3969d2b4d ("net: ethernet: rtsn: Add support for Renesas Ethernet-TSN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/net/ethernet/renesas/rtsn.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
> index 6b3f7fca8d15..f5df3374d279 100644
> --- a/drivers/net/ethernet/renesas/rtsn.c
> +++ b/drivers/net/ethernet/renesas/rtsn.c
> @@ -1260,6 +1260,10 @@ static int rtsn_probe(struct platform_device *pdev)
>  	priv->pdev = pdev;
>  	priv->ndev = ndev;
>  	priv->ptp_priv = rcar_gen4_ptp_alloc(pdev);
> +	if (!priv->ptp_priv) {
> +		ret = -ENOMEM;
> +		goto error_free;
> +	}
>  
>  	spin_lock_init(&priv->lock);
>  	platform_set_drvdata(pdev, priv);
> -- 
> 2.25.1
> 
> 


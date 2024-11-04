Return-Path: <stable+bounces-89737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930889BBCD5
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 19:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F811C21DA6
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337CF1CB531;
	Mon,  4 Nov 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ge8JaytE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BB1CB318
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743491; cv=none; b=qi2JiGi9PWfvEw1kEzZYg265epmi/iQsfZ5KpMPUBk9WK0aLC+OyTUsQbKo8aCrG94YSgEGZS0DWtxTXmwqxI6BnNphVUByZy8kaEEwjwegfenBVlaA5deBKISA+gC/MejPDLM5wKTJXVC8WEg+iFlBBrA3HBSUm9jIc+3BMnUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743491; c=relaxed/simple;
	bh=GVl1UEr0NWZX9IevbvvM2P+0VKWLEsKWWi7/kLeYQ/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz9vb9DFt6L8hAxYhixCtC+JBITa/0rMpBvWqI6hkqCSPM339FtdEYEwSkQMuHPIBVJjdEeWBb9nVVcE9iOydmWGW13ZdAZfS4mdxHE83W1PNuTlExWF9VxjPBNjU73ZuD8di4E1Qg9zHvsvYsbFsHGhqHio8I1hFy6diqa02xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ge8JaytE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-207115e3056so42729055ad.2
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730743489; x=1731348289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRvQf1xuqfHPBwS7luz0cb6H5Ugq9JMPjVW+YufCtSs=;
        b=Ge8JaytEEaAH6vCxwNZm8IcfvdwY00Rx2DT/rhn2sEvr3LT/9dlImoTSf+pxYFkQ/h
         AAAIvVvyuY26pStdt9fMoe6e9wC9JnrSCS1RB0pffHyBtkEL0Zhwq5bIy94JtW7RH3xG
         dQtPWGNqHzcgPOQJ+TOQvh/FJAFbTqEIazLkFZJSRQjJuY7nOGW6nH1wvws0YcYS22Wz
         csi52ldxj2n3dPMD9oD4o9Nxzc207XvdbU3xraI9s+LykwodzrK8d7XklpvBaKtcmLUm
         yWZ6ivmWSZ/a7lcrQMtDWTKKbGwRD2gtpNtUwZDYrhEhzuC5J+2DSWCFa0AOa7k/s7iC
         fQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730743489; x=1731348289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRvQf1xuqfHPBwS7luz0cb6H5Ugq9JMPjVW+YufCtSs=;
        b=AhXb5qFokaFcA6sCKjgEJ3Pn1VfW3cMr/DSYEmkt6d7x1TsJ3yqJJ+XR++WUDbjLg+
         R6D2XhkHzcsdHHNUUfxdtQ9GJ4mY0NF50b4w/UL3SZNL4oqY9h8uff179c2ZJFx5+QQe
         FxH7/MlS1T5+o3ReXLWjAEJN5MgqrJsA7hj38HjbyySmCAomtakSkWvcoluY46G1aXYc
         YY5lizZBhN2GzvWhZhnf2FdZX60HPeqd7K3JkSJ37jVQaHbP9VcZEAxh15aghSinTk8c
         gHzDuWR353J/jtovBl8Smcr6d+od5MwfiUfBw2fpOnRx15KjrBobMUrgg1hmOc0Ypes7
         H0aw==
X-Forwarded-Encrypted: i=1; AJvYcCUc7KrGFJDOh+DsZv4i9+Ou3jpP+MkYvnp3FtVlLKybgz4/QW2lFp0sqyx4Dg5cg/GChPZ4b7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YysOUMGt0WObNzjDPhnFRaRBz7CwKdg0vU2srvu4pXgl4Wse/0Q
	YZSyJAcV1b2URds7Ouo2zaN/CrptnBJASmUhvcsr8s24ll7A6zIT+WY/AY2neQ==
X-Google-Smtp-Source: AGHT+IFvuvps9+tEEfjMCZ4O3+x8fIkpxluQUBg5LTSx8jxApvw7eE44IevfvcA3aT6CY7QxgNhUjg==
X-Received: by 2002:a17:903:182:b0:20b:8a71:b5c1 with SMTP id d9443c01a7336-210c6872b1amr454253325ad.1.1730743488429;
        Mon, 04 Nov 2024 10:04:48 -0800 (PST)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057063f9sm63286905ad.65.2024.11.04.10.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:04:47 -0800 (PST)
Date: Mon, 4 Nov 2024 10:04:44 -0800
From: William McVicker <willmcvicker@google.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dhruva Gole <d-gole@ti.com>, sashal@kernel.org,
	Chris Morgan <macroalpha82@gmail.com>,
	Vishal Mahaveer <vishalm@ti.com>, msp@baylibre.com, srk@ti.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: fix fault at system suspend if device was
 already runtime suspended
Message-ID: <ZykMvEXywBRuhZAM@google.com>
References: <20241104-am62-lpm-usb-fix-v1-1-e93df73a4f0d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-am62-lpm-usb-fix-v1-1-e93df73a4f0d@kernel.org>

Hi Roger,

On 11/04/2024, Roger Quadros wrote:
> If the device was already runtime suspended then during system suspend
> we cannot access the device registers else it will crash.
> 
> Also we cannot access any registers after dwc3_core_exit() on some
> platforms so move the dwc3_enable_susphy() call to the top.
> 
> Cc: stable@vger.kernel.org # v5.15+
> Reported-by: William McVicker <willmcvicker@google.com>
> Closes: https://lore.kernel.org/all/ZyVfcUuPq56R2m1Y@google.com
> Fixes: 705e3ce37bcc ("usb: dwc3: core: Fix system suspend on TI AM62 platforms")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

I verified the patch works on my Pixel 6 device with runtime PM enabled. Thanks
for the fix! Feel free to add

Tested-by: Will McVicker <willmcvicker@google.com>

Thanks,
Will

> ---
>  drivers/usb/dwc3/core.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 427e5660f87c..98114c2827c0 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2342,10 +2342,18 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  	u32 reg;
>  	int i;
>  
> -	dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
> -			    DWC3_GUSB2PHYCFG_SUSPHY) ||
> -			    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
> -			    DWC3_GUSB3PIPECTL_SUSPHY);
> +	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
> +		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
> +				    DWC3_GUSB2PHYCFG_SUSPHY) ||
> +				    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
> +				    DWC3_GUSB3PIPECTL_SUSPHY);
> +		/*
> +		 * TI AM62 platform requires SUSPHY to be
> +		 * enabled for system suspend to work.
> +		 */
> +		if (!dwc->susphy_state)
> +			dwc3_enable_susphy(dwc, true);
> +	}
>  
>  	switch (dwc->current_dr_role) {
>  	case DWC3_GCTL_PRTCAP_DEVICE:
> @@ -2398,15 +2406,6 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  		break;
>  	}
>  
> -	if (!PMSG_IS_AUTO(msg)) {
> -		/*
> -		 * TI AM62 platform requires SUSPHY to be
> -		 * enabled for system suspend to work.
> -		 */
> -		if (!dwc->susphy_state)
> -			dwc3_enable_susphy(dwc, true);
> -	}
> -
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> change-id: 20241102-am62-lpm-usb-fix-347dd86135c1
> 
> Best regards,
> -- 
> Roger Quadros <rogerq@kernel.org>
> 




Return-Path: <stable+bounces-96167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9080A9E0DB1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 22:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75FFB288E1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE0F1DEFE8;
	Mon,  2 Dec 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkGgz8VU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D331DE3C1;
	Mon,  2 Dec 2024 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172931; cv=none; b=omx0P132r/5N9RBeEUYXAayxZ89WjlOqkYeJ8E2lrnCslw0I/f5vwv6BmM27RsVLvtNb8aqeZZrni9Kc9Zr4ubDkCYjCrjhd6wbloKq+VA6v4Lv5xsjttF643wA4PSGpoghKheqFGmptcGXp+3JN2dLwcLr7txc9S33Z11ptt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172931; c=relaxed/simple;
	bh=I6UFKe8dkyc5kPGgizqXsmvegeO2C7hOpnig+uuVm4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVqAN8L0l24hJTnVfMvQZh0m35HEn3CBTdC1JFgZzzrM9XjVgmMU40p3qztI3Ei3dGyHlF9Pu331JNFx14jvCcgFdwLgylnGCgrXMf2nxZQftgK6S6HXaITG0gtR01GO+cD0+RwW3MYWo5HyCKa4jSHTJtXbHe2QmTl2ySj3Fk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkGgz8VU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21578cfad81so14994695ad.3;
        Mon, 02 Dec 2024 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733172929; x=1733777729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZosFDZP4vQYcO/8JOiXFBV0OyJNAbeoH1oN1YWzR81s=;
        b=IkGgz8VUjcCN+EDrCUlMxFR2KtF5ULadyzRk8ifpFUKh+iiUQ5qFBFdrjA3pxhc8L6
         RVMzY4L2FQpjlkJXrX0oHL+nM0CQhvfQNWXI5SsoeLIM99Y89nKEmR6TEK+Adlxoqbze
         80hEUlJkar5EpsFrglK98MTXGXgsr/YS7mGEK7N16T6cCMYvFbWJd/+Q6otY/E6fJ7WX
         ktHq5rPr8ZH3V9XSBc7sLK1qN5d8iqGdG/KipJ2rfZpt4A5AkpsNv/tyn1i9mT9ovjtn
         3+HZd6xkS3s/JkKOyN59WpvrTxDyKG5JqPK8WbR8y0OYkGGkHyu90ooM3mUfRPplPseO
         muvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172929; x=1733777729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZosFDZP4vQYcO/8JOiXFBV0OyJNAbeoH1oN1YWzR81s=;
        b=qNFL4eydeVoVLbMYiMRYscdyy4mEoKJZGFM2JDD9tb9cRMiNXoomfTb6LksT/sw2zb
         Xbre2SKSfymg44Xr2gXsO0qWDe8XeMvqNlFIflT5kNbUDdPtKRYMgQGL4PFVlnTKRjpQ
         NGb2QQX3+YVbBazySHn2z4wvPUiCx0Ue/IXh1Mx0VTSJ7dxS4TS7E0LTlLpoijmZ+zDw
         Qi1btbJ2Lttp6BcKmL3ItyD912EFKIRVaow5YVblH/Z6RjIrs3rLHSnBhzGnk3uI2Vvk
         XGL5wf6D9YJHI7v9EvCElNz0LLE0O71S1pLYN4AHU+jMOsy5sUG2GxFBOped1vpZl3tF
         X3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVYcsRo96Wms2bLLIirJqg6wuA+pPliUO3LsGpFrYaIu+vafVnujttJiobNErj+N6ROtdENS9ofZs5P/EI=@vger.kernel.org, AJvYcCXKMxrTJ4hy7Bvgp3S11STDXJ9o5ngoqA+uztoOv31FovgWzfHkOKom3peAqzt1Uv+PI4xDz0pK@vger.kernel.org
X-Gm-Message-State: AOJu0YxHub6Jr3P27d0gZhE1iFpD8wRp6Fq/DxTai6d5JLGJiTzlSqHV
	MZM5QtYV+JvSe1bhYeQu+c0JdKNsnko9qflchukVSz20XQUpMy8b
X-Gm-Gg: ASbGncv0VHHuyNnU3WtXNg4+axAtVQ61x4MgGgJMUDaPF1MHMWBt1+9FzwSu8lcLhhU
	WxzphLNq/3BJ3xIhiH5BM8y/YpWXMdm2B0zjSMhQQupmygPHyBvyy99uzz/gWlix6fwO/hon7GY
	oQE2e6PBOUrRXHbH2jSqmZndyPBzs/CgN0AdB5Twx+e/AioByzoip7xF5594WhywwPzYVC+gVcu
	+WqPzWwrIHTirKB8NRXd6AKwohuQ42DZNBigHb7TVJdEuThVSjgtkpogMNPBJQ=
X-Google-Smtp-Source: AGHT+IElGGe59u//tXIW1SDvRdMG0YvH5t0Jv776Opki8hoQ0vLT2C5tixdBFyywAdKgliaQYUenXA==
X-Received: by 2002:a17:903:2442:b0:215:9a73:6c45 with SMTP id d9443c01a7336-2159a7376e6mr69749205ad.22.1733172928757;
        Mon, 02 Dec 2024 12:55:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21589aa5478sm27696925ad.59.2024.12.02.12.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 12:55:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Dec 2024 12:55:27 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org, mkarsten@uwaterloo.ca, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net] net: Make napi_hash_lock irq safe
Message-ID: <ddeca293-5938-42f3-9722-748050ab0aa0@roeck-us.net>
References: <20241202182103.363038-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202182103.363038-1-jdamato@fastly.com>

On Mon, Dec 02, 2024 at 06:21:02PM +0000, Joe Damato wrote:
> Make napi_hash_lock IRQ safe. It is used during the control path, and is
> taken and released in napi_hash_add and napi_hash_del, which will
> typically be called by calls to napi_enable and napi_disable.
> 
> This change avoids a deadlock in pcnet32 (and other any other drivers
> which follow the same pattern):
> 
>  CPU 0:
>  pcnet32_open
>     spin_lock_irqsave(&lp->lock, ...)
>       napi_enable
>         napi_hash_add <- before this executes, CPU 1 proceeds
>           spin_lock(napi_hash_lock)
>        [...]
>     spin_unlock_irqrestore(&lp->lock, flags);
> 
>  CPU 1:
>    pcnet32_close
>      napi_disable
>        napi_hash_del
>          spin_lock(napi_hash_lock)
>           < INTERRUPT >
>             pcnet32_interrupt
>               spin_lock(lp->lock) <- DEADLOCK
> 
> Changing the napi_hash_lock to be IRQ safe prevents the IRQ from firing
> on CPU 1 until napi_hash_lock is released, preventing the deadlock.
> 
> Cc: stable@vger.kernel.org
> Fixes: 86e25f40aa1e ("net: napi: Add napi_config")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/netdev/85dd4590-ea6b-427d-876a-1d8559c7ad82@roeck-us.net/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  net/core/dev.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 13d00fc10f55..45a8c3dd4a64 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6557,18 +6557,22 @@ static void __napi_hash_add_with_id(struct napi_struct *napi,
>  static void napi_hash_add_with_id(struct napi_struct *napi,
>  				  unsigned int napi_id)
>  {
> -	spin_lock(&napi_hash_lock);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&napi_hash_lock, flags);
>  	WARN_ON_ONCE(napi_by_id(napi_id));
>  	__napi_hash_add_with_id(napi, napi_id);
> -	spin_unlock(&napi_hash_lock);
> +	spin_unlock_irqrestore(&napi_hash_lock, flags);
>  }
>  
>  static void napi_hash_add(struct napi_struct *napi)
>  {
> +	unsigned long flags;
> +
>  	if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
>  		return;
>  
> -	spin_lock(&napi_hash_lock);
> +	spin_lock_irqsave(&napi_hash_lock, flags);
>  
>  	/* 0..NR_CPUS range is reserved for sender_cpu use */
>  	do {
> @@ -6578,7 +6582,7 @@ static void napi_hash_add(struct napi_struct *napi)
>  
>  	__napi_hash_add_with_id(napi, napi_gen_id);
>  
> -	spin_unlock(&napi_hash_lock);
> +	spin_unlock_irqrestore(&napi_hash_lock, flags);
>  }
>  
>  /* Warning : caller is responsible to make sure rcu grace period
> @@ -6586,11 +6590,13 @@ static void napi_hash_add(struct napi_struct *napi)
>   */
>  static void napi_hash_del(struct napi_struct *napi)
>  {
> -	spin_lock(&napi_hash_lock);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&napi_hash_lock, flags);
>  
>  	hlist_del_init_rcu(&napi->napi_hash_node);
>  
> -	spin_unlock(&napi_hash_lock);
> +	spin_unlock_irqrestore(&napi_hash_lock, flags);
>  }
>  
>  static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
> -- 
> 2.25.1
> 


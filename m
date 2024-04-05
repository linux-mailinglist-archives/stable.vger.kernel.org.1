Return-Path: <stable+bounces-35989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3188993C0
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 05:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CCA2832D5
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 03:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC8818E01;
	Fri,  5 Apr 2024 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpCXI3Bg"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076015E9B
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287447; cv=none; b=mxz7nHpXzPFtqdIXxwgSe+iLxy2MMZCzZuxDintvUpQcahR5p4SREpL0hX0QaSZFWUNUBNrXk6ryBIkQL5Txx/O/TVv+Q0KeV+yoKEqaYDFMjD5pRbLBtxJ8HFAu1hIa6+bvIB5zkBn2gEFVP0xVZDAd2oFWaETtANVIZDlTwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287447; c=relaxed/simple;
	bh=CB7pDIt+kAzdjoh+MM+OZcWbUSgDWUl+4OlpDmEa5vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k28JNS/Xzk058YwDO3QKfoX/W0bPingGGk6Yz+Sqw0chWnGJxRQg962HVCFxZzaEXwjBNrrA/c5a/UNo1UfF03wqK/sWg+X5M+suIsk8ugIBeJ3UoV7q8m28NDI3xThc9baMQzqOPQ88+wS6K9gWpCGkwaL5RhVUFN7D45LliAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpCXI3Bg; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d536f6f2so77462e87.2
        for <stable@vger.kernel.org>; Thu, 04 Apr 2024 20:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712287443; x=1712892243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=djoX0jMYV8yyXli2/egywXNwRqExDcF+IAyDdSCliAI=;
        b=tpCXI3BgbDsyYWkUX9GvlQLTcVyZGeNNJWuc7zpduIZcR+JjcInqykzy1StQA0xqFl
         MDodlLbYvD7H2NLo+76UWu27+PO1uwb0Gc6vMt5mfH44E8L5bl3uDYEmm64nz1v9UpNT
         1ZiyVYGTU7CsJ2BZtRTBteaiPyfuPc7qC0/dslx4zbx/Do5cpeigzmwMF0wT6LuBfvg0
         pbRBjSKhaFcQwO4MgO8voOzO+ZtbCGyL9xyLw6PhIcpBiWO0QG7dX/u732i6MbPOJq2K
         BCg7SPyrQWv5GNDnzQDDJ+hnJtIINLQPyclCxxUQFnvr5PMJ77F4iX5M7K4Z1agMCii4
         T+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712287443; x=1712892243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djoX0jMYV8yyXli2/egywXNwRqExDcF+IAyDdSCliAI=;
        b=qBP1q8tJeOlf5UBcc3XdL8KyJEnnryWJ0GvSonUkvFYGOZZtC3j8tTHAJ/ePMwVsNw
         YxKQi5JF40KP5MLLUvVD5BzQGwuKGtc3Xqsprjr5FeEQ/y2MahbHvD6SWU34oOVJRDpE
         k2I6b0K6sT5Pn5RGJTk0h/S1OXJGpUN6aCs3xHvNpXtNY/sy1W4dgsE4ZwijEMIYFm2U
         FVN9z+N5JvjjtTQeR/aefx56Z3OVj3WJkb5BhL+pfVGW4T+COB7RgUBl3j1URaDco+VN
         iOwcj/YbuDX+akVkQ3jV6Mja81LqAVCxeKzL8RcpLpkPQw5PnFUIo+BVBjocopTnQalJ
         igEg==
X-Forwarded-Encrypted: i=1; AJvYcCVrLMlKtRf/Aeal6UcIwoAxmU1VUB0FDnoGobUepIYN90iWlAiZ60zox0XpBTVFg1CbI2zw1lEh9ATyh5VrBCQ+sxhi/Y4E
X-Gm-Message-State: AOJu0YzNTMCOMe9HbfveGv8V8D9ZxumfT7eVZPA5DodM5e/XyL8aCvEx
	yLmFS9UlGXj6BnCX3Ueq9zqZffjS0cP2XXllDJqM87aePx/dEtbh3ypINBVbFqEIwYrJwRmLZeF
	9
X-Google-Smtp-Source: AGHT+IEIYG99dBzN4VueKpfW7+dyTWa53Fr9LTF5gytJHu7FYsHu+6uYU2u16oTmwD5X3RZ8TFDawQ==
X-Received: by 2002:a05:6512:3e17:b0:516:cc31:dbf0 with SMTP id i23-20020a0565123e1700b00516cc31dbf0mr191938lfv.17.1712287443372;
        Thu, 04 Apr 2024 20:24:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id c5-20020ac24145000000b00516c8826719sm70778lfi.197.2024.04.04.20.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 20:24:02 -0700 (PDT)
Date: Fri, 5 Apr 2024 06:24:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 01/12] drm/client: Fully protect modes[] with
 dev->mode_config.mutex
Message-ID: <jeg4se3nkphfpgovaidzu5bspjhyasafplmyktjo6pwzlvpj5s@cmjtomlj4had>
References: <20240404203336.10454-1-ville.syrjala@linux.intel.com>
 <20240404203336.10454-2-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240404203336.10454-2-ville.syrjala@linux.intel.com>

On Thu, Apr 04, 2024 at 11:33:25PM +0300, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> The modes[] array contains pointers to modes on the connectors'
> mode lists, which are protected by dev->mode_config.mutex.
> Thus we need to extend modes[] the same protection or by the
> time we use it the elements may already be pointing to
> freed/reused memory.
> 
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10583
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I tried looking for the proper Fixes tag, but it looks like it might be
something like 386516744ba4 ("drm/fb: fix fbdev object model + cleanup properly.")


> ---
>  drivers/gpu/drm/drm_client_modeset.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index 871e4e2129d6..0683a129b362 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -777,6 +777,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
>  	unsigned int total_modes_count = 0;
>  	struct drm_client_offset *offsets;
>  	unsigned int connector_count = 0;
> +	/* points to modes protected by mode_config.mutex */
>  	struct drm_display_mode **modes;
>  	struct drm_crtc **crtcs;
>  	int i, ret = 0;
> @@ -845,7 +846,6 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
>  		drm_client_pick_crtcs(client, connectors, connector_count,
>  				      crtcs, modes, 0, width, height);
>  	}
> -	mutex_unlock(&dev->mode_config.mutex);
>  
>  	drm_client_modeset_release(client);
>  
> @@ -875,6 +875,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
>  			modeset->y = offset->y;
>  		}
>  	}
> +	mutex_unlock(&dev->mode_config.mutex);
>  
>  	mutex_unlock(&client->modeset_mutex);
>  out:
> -- 
> 2.43.2
> 

-- 
With best wishes
Dmitry


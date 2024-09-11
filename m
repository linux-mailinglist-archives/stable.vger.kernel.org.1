Return-Path: <stable+bounces-75900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E09759E0
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 20:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A17C286653
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8634E1B3728;
	Wed, 11 Sep 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDFWnCCv"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC81A7AD2
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726077846; cv=none; b=twtQ2HB0UHb4yEf71hNg4uCHIqgUEOsAC8AOi3Tn2ZICC8X4X+VxzRXxDzKq3FnaS9Iwk0/ziKPYfcFCf0nln3LPr34ms6QBNjU4QIzgVdLY6IrcGFz6LUxQqx46tYpF1Bx2EPMrmiu6dsNH4i7fi7Shby0ZSR3qMUIWy7zFy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726077846; c=relaxed/simple;
	bh=Rw0HYoUjUK+L3ACEPUXcViiOi8IqipyTgLTRVmCtdpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nq+6lthm17wMKGYKQAL3J8CgtmBXANH09uvLpC/sU3Q+BRmqvsOXDHwSp8KPAuIWfccJxsyJaH74+jhIM/FF4o6lO/3eiMvcZ1d7KZCi7saXxrfkYCHQmuFqeb+iB2X7PT6FNP6g1abTcdQ+aLrorpU97YFkAH18HDOi+Qzsf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDFWnCCv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726077843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IH+Ib1b5pn8WaOZaeFGsrZvEitMV86mg5/DLE/udy2g=;
	b=bDFWnCCvvB60JQIRd+w42qxJQafJJc+vmo8olrGucJc1mjdLWnW7ymL8y5l5ign2jf3yGq
	E6VQOoyHCQgCVQVEAfHyREat8MCx5MXy4jqB5nmgBajJ6FS3IWZCDP5ELKXWAFVQYaaA4m
	3b47tpxqH0POARh6rIyEtUhQ85i8WO4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-cp0gSRVeNyqPIRphAvoI7g-1; Wed, 11 Sep 2024 14:04:02 -0400
X-MC-Unique: cp0gSRVeNyqPIRphAvoI7g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a870f3a65a0so7631266b.0
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 11:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726077841; x=1726682641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IH+Ib1b5pn8WaOZaeFGsrZvEitMV86mg5/DLE/udy2g=;
        b=uZkILhgrHhQpM7dd4lODNWcMc0Zbh/hpAPfRlei1+rG6wPP19Ch6WIu9I4OmW8IDK+
         d4XpUyeA8sIXM9zmoBe6cL9nqHtHhO4WNzcbIcfx7Oww05di+TdoV43jijaqLWbYsIRu
         FLZ9K3FvFF48SkoYICXZkCemKjb+WSV/Ux5ogEPBFz1mbagV4oSe87ZMveXcHwkveOQH
         lPvml7masA6jVjOZAjCAyCzKBDXcCDfjdFgBjKa27+HJwqF1r2I9CrlI3IyrG6mB7jp2
         lpQmShWn0Lzmz1GUK0LPLXxpyV5Bu3xD97Ow828SCYePJmzhTKCrsrF0jFDvH08sfrAA
         eQsA==
X-Forwarded-Encrypted: i=1; AJvYcCWM+M6vnMjx6gujwoDQ/ub6Ujsoph2Uq+A1BL6Sg0yGbLPj8ZI+yQ8O4HKtsD0DTz+2JHzd9Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfoC7wju+nOriV9z3fVFz9/WZw/BI7tD3Z9Sg6cAqROBW8ZGah
	Ibm/mCx1VQdKrS9eprwNTlI+qM2p3kW7cWojtqujWPrmMwhOMR+S6Uoe8rFjt8QUHSt2J//3iGy
	WxfN+AphMGAk2bwOhs5Kypmasai9qgDt30hFeUziUIvPn4mWbrNcA8A==
X-Received: by 2002:a17:907:3e1d:b0:a83:8591:7505 with SMTP id a640c23a62f3a-a902966f459mr27777866b.59.1726077840912;
        Wed, 11 Sep 2024 11:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGiOUHQziAMSw1ySVvdKoiB3VewkXKRFTMsAed1ndUNhLmUSoKhACnYsZh/d6DuW5PXkj6CQ==
X-Received: by 2002:a17:907:3e1d:b0:a83:8591:7505 with SMTP id a640c23a62f3a-a902966f459mr27774766b.59.1726077840333;
        Wed, 11 Sep 2024 11:04:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a079bcsm638970366b.83.2024.09.11.11.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:03:59 -0700 (PDT)
Message-ID: <bfd0243f-9159-4397-9f8a-e26372ce85a5@redhat.com>
Date: Wed, 11 Sep 2024 20:03:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.11 v2 3/3] minmax: reduce min/max macro expansion
 in atomisp driver
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Narron <richard@aaazen.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Arnd Bergmann <arnd@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-mm@kvack.org,
 Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <dan.carpenter@linaro.org>,
 stable@vger.kernel.org
References: <cover.1726074904.git.lorenzo.stoakes@oracle.com>
 <b38d8936eaddd524d19823f7429138e2ef24e0d1.1726074904.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <b38d8936eaddd524d19823f7429138e2ef24e0d1.1726074904.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/11/24 7:51 PM, Lorenzo Stoakes wrote:
> Avoid unnecessary nested min()/max() which results in egregious macro
> expansion. Use clamp_t() as this introduces the least possible expansion.
> 
> Not doing so results in an impact on build times.
> 
> This resolves an issue with slackware 15.0 32-bit compilation as reported
> by Richard Narron.
> 
> Presumably the min/max fixups would be difficult to backport, this patch
> should be easier and fix's Richard's problem in 5.15.
> 
> Reported-by: Richard Narron <richard@aaazen.com>
> Closes: https://lore.kernel.org/all/4a5321bd-b1f-1832-f0c-cea8694dc5aa@aaazen.com/
> Fixes: 867046cc7027 ("minmax: relax check to allow comparison between unsigned arguments and signed constants")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  .../staging/media/atomisp/pci/sh_css_frac.h   | 26 ++++++++++++++-----
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/sh_css_frac.h b/drivers/staging/media/atomisp/pci/sh_css_frac.h
> index b90b5b330dfa..8ba65161f7a9 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css_frac.h
> +++ b/drivers/staging/media/atomisp/pci/sh_css_frac.h
> @@ -32,12 +32,24 @@
>  #define uISP_VAL_MAX		      ((unsigned int)((1 << uISP_REG_BIT) - 1))
> 
>  /* a:fraction bits for 16bit precision, b:fraction bits for ISP precision */
> -#define sDIGIT_FITTING(v, a, b) \
> -	min_t(int, max_t(int, (((v) >> sSHIFT) >> max(sFRACTION_BITS_FITTING(a) - (b), 0)), \
> -	  sISP_VAL_MIN), sISP_VAL_MAX)
> -#define uDIGIT_FITTING(v, a, b) \
> -	min((unsigned int)max((unsigned)(((v) >> uSHIFT) \
> -	>> max((int)(uFRACTION_BITS_FITTING(a) - (b)), 0)), \
> -	  uISP_VAL_MIN), uISP_VAL_MAX)
> +static inline int sDIGIT_FITTING(int v, int a, int b)
> +{
> +	int fit_shift = sFRACTION_BITS_FITTING(a) - b;
> +
> +	v >>= sSHIFT;
> +	v >>= fit_shift > 0 ? fit_shift : 0;
> +
> +	return clamp_t(int, v, sISP_VAL_MIN, sISP_VAL_MAX);
> +}
> +
> +static inline unsigned int uDIGIT_FITTING(unsigned int v, int a, int b)
> +{
> +	int fit_shift = uFRACTION_BITS_FITTING(a) - b;
> +
> +	v >>= uSHIFT;
> +	v >>= fit_shift > 0 ? fit_shift : 0;
> +
> +	return clamp_t(unsigned int, v, uISP_VAL_MIN, uISP_VAL_MAX);
> +}
> 
>  #endif /* __SH_CSS_FRAC_H */
> --
> 2.46.0
> 



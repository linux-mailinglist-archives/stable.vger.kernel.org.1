Return-Path: <stable+bounces-245411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLcMMUjbAmrJyAEAu9opvQ
	(envelope-from <stable+bounces-245411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:48:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FA051C23F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30EA33061976
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5C648124F;
	Tue, 12 May 2026 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2ZXKStP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA144D6BD
	for <stable@vger.kernel.org>; Tue, 12 May 2026 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571990; cv=none; b=W6UHvQCy1q4blXcyMNKBO2Vd7/T5jUQLf9d3X2SWKRRkd5yrbGv4mhcq0OnXFL/rPq/Qx7W15X4Oz44U0Dpqp9hPE+zN7ngGwgfCWgcHppovA47nONpGzKU3oNINvvwugH7d2y/31qMA0AnvQIk8sK2hJrM0q3FEuODXYa3Uui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571990; c=relaxed/simple;
	bh=R0ToAlzpi8O9RonCUOJfjicwYLthpIGNBfL+IRceIWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQuWX451gP7bi0GqW6KFs24tDE0pstvuLIcgYQAnGVdS1DEfr0lqEe1l2LaWRFWGzxnEj4GXaCNpeu5PsfhGRtOeEYLfFeubTpA5smLi9DK6WG+K4lKmCJexZHWcC5LPLblOKGFDccBJ8yALbSCKYvuIQ9Uvc5lHK9O0SscSl3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2ZXKStP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-449de065cb3so4696725f8f.2
        for <stable@vger.kernel.org>; Tue, 12 May 2026 00:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778571984; x=1779176784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVy/L8Jze54TojCR0KZX0SV4kvXWoRSdNBWT9WiqX2M=;
        b=F2ZXKStPuKjTVvf9KxbXGkCZo/wv0q02R29u2pUtipvVHzi5sR8BOVYCiIGRQl7x5I
         39mx1herCiH0nFfHpse9t5+tJeMYxmTr49nWrV91igoHeRCQ8xf/XJIzYiWR7uRuZ5h7
         nrU2lXVjXU1QWvrTaTaJ14CcPQHp6NEuQs+cW4EDp1bh/T2a8K4DFpsKlBajMBKdegV9
         ryj+BZc9WzXz3V8B5RB6f4cbU2pNYF52TqF2lwahbXxUugNtg02+C1Wp2L2hoOo9LeP9
         FGgllfrZKQ3N2fAIbTPFiGj+dBFb79gG8Qx7BflF41zSe9Ju/sgz+Ex91j+ZO7Vz/UHS
         Jktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571984; x=1779176784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVy/L8Jze54TojCR0KZX0SV4kvXWoRSdNBWT9WiqX2M=;
        b=QuaSTfThJMZIByIFpRoXvqBFhYIV39hwdpzCKJsqH0OQNgpqzXMjVdj/ORK4stX8T9
         STWySsjNCNWoeQl0eHUiI0pmDPG6O9r5pv/vNIDMEGHb42EAjr9p0s+Bet2RF+jSsm4L
         G0LeuG9ExRbZ6Aab6Cx8N30xoJYqxrIlbfpSiJxWNRqtaLeyOH7+mYUhrbXHa/CoeB8H
         0uflGepdRvMGQIm8hlzTWmTtTkFpYBCyYJjiEoHGGX7ug4D0nbj77P7Ym/Ih6B+T0f6h
         TPXOTCH3II/lS9wMwA7Dz6QwWKMRWuQko+qL5FPFTR6mIpgsb/kqvwVQrELcvCRU5IdG
         fhfg==
X-Forwarded-Encrypted: i=1; AFNElJ9+cud4f0npfw861SRmZhmNwrXpu3m4N4Wb+3loECicuwFYKvyXBj/slEvCYSomLcHObWGHiPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfzbBP3LSx4BdN6QIxBRKLxMGk7TIjWaFEGX4Dzm4Gyybrson
	jYbm+iIWQ19QoOKOZjgd5rGh6Dpi3VzmhlVZqiBDBC7Fi82T9j/eJRYE
X-Gm-Gg: Acq92OEUQm/9QU7Y4eOdJXwRLyPZCG/IaebTlWn8ZYpElecTl2VsS4T35uvyprVMFZo
	a96Y/EIAr0NfGRuyQQW4wGY3s/LJtRPcO/W+5m36vU5l5sxQ9o1yKSCl8njuiiCRDvnF52up1ag
	Asv2CUGwmy/HN26rQkszAbHyXsNuA+3w96vFPH0F7TDoUJuTZ8Ox3O4ehkaQRA3IN6BuymZe2jy
	8sGdttktTYTdQnWbzwtGbcHLU8BLK4dXW1oONq7icDHbwiCyfdOz3HTzzwwTyydzTuqaqUR/q91
	qrQpW7rZc/lg0DKIWd59aG0kk0lEvlMNqRf5mWbdbL1lF68oHlzFB+XjA89kvYnyTqiJfrl8/f2
	r1lCTRUblp6hXbd2RQ3YxrCknEp6J3oPX4DENM1FUlojckPdc+B10ZhXawb8c+tUy0VB5TnIjXv
	79ULT6LULfEwz4UcTt7Go=
X-Received: by 2002:a05:6000:40dc:b0:43d:309b:9c4f with SMTP id ffacd0b85a97d-4515b056c90mr43494569f8f.6.1778571983812;
        Tue, 12 May 2026 00:46:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6a64sm32142308f8f.6.2026.05.12.00.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:46:23 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:20 +0300
From: Dan Carpenter <error27@gmail.com>
To: Shayaun Nejad <snejad123@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: media: atomisp: bound DVS 6-axis config copy
 size against allocated grid
Message-ID: <agLazHI_ulhM5eFQ@stanley.mountain>
References: <20260512014514.22856-1-snejad123@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512014514.22856-1-snejad123@gmail.com>
X-Rspamd-Queue-Id: 39FA051C23F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245411-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 06:45:14PM -0700, Shayaun Nejad wrote:
> atomisp_cp_dvs_6axis_config() copies user-provided coordinate arrays into
> a 6-axis grid allocated from ISP dimensions.
> 
> The copy sizes are computed from the user width and height fields, so
> mismatched or overflowing dimensions can copy past the allocated buffers.
> 
> Reject dimensions that do not match the allocated config and compute the
> copy sizes with array3_size() before copying.
> 
> Fixes: a49d25364dfb ("staging/atomisp: Add support for the Intel IPU v2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shayaun Nejad <snejad123@gmail.com>
> ---
>  .../staging/media/atomisp/pci/atomisp_cmd.c   | 84 ++++++++++++-------
>  1 file changed, 52 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
> index fec369575d..677037f1da 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
> @@ -14,6 +14,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kfifo.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/overflow.h>
>  #include <linux/timer.h>
>  
>  #include <asm/iosf_mbi.h>
> @@ -2570,6 +2571,29 @@ int atomisp_css_cp_dvs2_coefs(struct atomisp_sub_device *asd,
>  	return 0;
>  }
>  
> +static int atomisp_dvs_6axis_size(struct ia_css_dvs_6axis_config *config,
> +				  u32 width_y, u32 height_y,
> +				  u32 width_uv, u32 height_uv,
> +				  size_t *y_size, size_t *uv_size)
> +{
> +	if (config->width_y != width_y ||
> +	    config->height_y != height_y ||
> +	    config->width_uv != width_uv ||
> +	    config->height_uv != height_uv)
> +		return -EINVAL;
> +
> +	*y_size = array3_size(width_y, height_y, sizeof(*config->xcoords_y));
> +	if (*y_size == SIZE_MAX)
> +		return -EINVAL;
> +
> +	*uv_size = array3_size(width_uv, height_uv,
> +			       sizeof(*config->xcoords_uv));
> +	if (*uv_size == SIZE_MAX)
> +		return -EINVAL;
> +
> +	return 0;
> +}

This commit doesn't make sense.  Any time people end up checking
size_mul() type calculations for SIZE_MAX it's probably a sign things
have gone wrong.  You're supposed to just pass it along and let
regular bounds checking handle it.  It's not like ULONG_MAX is a special
sort of "extra bad" invalid number.

So we have some math here and if it equals >= ULONG_MAX then it's
invalid.

> +
>  int atomisp_cp_dvs_6axis_config(struct atomisp_sub_device *asd,
>  				struct atomisp_dvs_6axis_config *source_6axis_config,
>  				struct atomisp_css_params *css_param,
> @@ -2582,6 +2606,8 @@ int atomisp_cp_dvs_6axis_config(struct atomisp_sub_device *asd,
>  	struct ia_css_dvs_grid_info *dvs_grid_info =
>  	    atomisp_css_get_dvs_grid_info(&asd->params.curr_grid_info);
>  	int ret = -EFAULT;
> +	size_t y_size;
> +	size_t uv_size;
>  
>  	if (!stream) {
>  		dev_err(asd->isp->dev, "%s: internal error!", __func__);
> @@ -2628,35 +2654,32 @@ int atomisp_cp_dvs_6axis_config(struct atomisp_sub_device *asd,
>  				return -ENOMEM;
>  		}
>  
> +		ret = atomisp_dvs_6axis_size(dvs_6axis_config,
> +					     t_6axis_config.width_y,
> +					     t_6axis_config.height_y,
> +					     t_6axis_config.width_uv,
> +					     t_6axis_config.height_uv,
> +					     &y_size, &uv_size);
> +		if (ret)
> +			goto error;
> +
>  		dvs_6axis_config->exp_id = t_6axis_config.exp_id;
>  
>  		if (copy_from_compatible(dvs_6axis_config->xcoords_y,
>  					t_6axis_config.xcoords_y,
> -					t_6axis_config.width_y *
> -					t_6axis_config.height_y *
> -					sizeof(*dvs_6axis_config->xcoords_y),
> -					from_user))
> +					y_size, from_user))

But it the result stored in y_size is ULONG_MAX - 1 then we copy that
number of bytes from the user.

regards,
dan carpenter




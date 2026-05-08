Return-Path: <stable+bounces-244670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L62Iw2C/WnSfAAAu9opvQ
	(envelope-from <stable+bounces-244670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 08:26:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9774F271C
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 08:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25D56303133E
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 06:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF6377EC1;
	Fri,  8 May 2026 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkiq76oJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E26378D82
	for <stable@vger.kernel.org>; Fri,  8 May 2026 06:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221564; cv=none; b=FIOvkHFZq0r6PV+2PlVSMhfGEgo2U5Boj7xAfcIDqdKifbYxAm5zqlD6e+JyorWW+ZuBntnL39+SihH51Ldiv6StGJnirMdXmKQfUldo/qDtKzqXVZmlzVJr1XXkM5vpenn3gOsSzOKWKMLzXyMra2tTNTUVqdcstemRDlCs8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221564; c=relaxed/simple;
	bh=cv5ZQ7RDUoTrqLqP4/sBLtA2dmTug073X/Xz8LbRrwI=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTBI430MQb7sED6XSDii4YTMYppMIlMjp9tcbyyrjMjwQxL0PdPZJb6uGJqR0MhNEkXA/BHe3cHtHfZvyYEribJDUNI9AcgQ+qzFdWHAgIV94j6Lr1CLDB+cOCP0bkG/53it6/TXf/NGb+akY96m0RphljcNiLp5E80j+Unou+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkiq76oJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so14162425e9.2
        for <stable@vger.kernel.org>; Thu, 07 May 2026 23:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778221552; x=1778826352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q0B0EAR1P+R7f8BwrSFh3If6GSNF4WFFP1Xr/m/6H0Q=;
        b=hkiq76oJztIKKHP2vyTjA7A3tBvPKI5flwnsmFPr/a23dvqBfOMwXF6DZ+D2vD3ZNJ
         kSSi/w437REiHDFq1pc8nqEG9rB+r3BtpZXVBJD2KAUG2W4zrbsk6+XLN8mVm4wK1kmJ
         C2h+fS71dwDBIJL/3UQu1jY08esc7H5QNeGNG6SbVeZC+bM3RAXZH3/JIzaOdOgG6adf
         axgu6haPu0sIpgA69HLDdEN3WmmSQlKMNuISie/mkOKk8t18wntVicAyS8eQFh5Q3Qtb
         XN1kQVajkpVGHpgRlM3zZdGHhy4n2895PnVTkrh6MY7itygfwsJtRixTYC88VQmwvSXO
         4pTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221552; x=1778826352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0B0EAR1P+R7f8BwrSFh3If6GSNF4WFFP1Xr/m/6H0Q=;
        b=d0xE+taRymQBYeh8uy7JYGWR4wtQ+EasgB5rypLSOdaMEJlDw3s3Tu96XS7rXwf+x6
         XrLh2ESN9rtshOaLPKQD7GxmBgZa0cmnWjVd4wvgatmtUKIK1yA9wDmYGOlqKRicwTMR
         x1KpIfJkkrHzHpDG/o7oNIFu+obfuYGEk2Ro4tI/Cp3aEzn/lFVWSu7bq3vazn0QkQk0
         afK9JgSmXBlT5qLwp9GLIppQKveRqM6fh+cnKIeuzVZ5o123xfHQq7YkSKA12iwgtUkV
         OAfgj+df3o/9FAv7hdE6fqz8OO0MjDui5GfchLGK6VhzbnxI+ybX8SeZXLAd+fng2K9+
         b3SA==
X-Forwarded-Encrypted: i=1; AFNElJ+6l1JBBqC8zuKRexuEgN7gQLrLGlX4KXiHodwEMxFoC8C/616wB2pXrv6tc5ZrzjOQGQjf8bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoX5UcqZliFzzy4mq/r42O4Eqq7Ni4vAtla330MWLCXgVsecjl
	uvUUzFfuSy6gtqa3nm6X+g/hgfEF3CUwVghnrC65AQCjWxqFNAAlR4Fm
X-Gm-Gg: AeBDieuPBlhw1b1FB1UaUgyy0VZDn9vMdDRyZCIXW0XJxn0y2EawgB1fzL2OEIsEtbW
	8EekmDBRRF3jjVEGVti+kuh1GEP7MzL97UpUD7UzsRwhTzeCEBtg7xshdfrEtdSKxbrljW0F2Ft
	cT+e25TEfkJd7hsrOybzT6fihrvqYZmW5pa5K920+vJZCAINJXAwyP1Lf4sspE5Et9OzN0mus9P
	Gc8PZ1y75jY6fWY8hZzv44PTosFHBpkrAyyOCtidFzMYF0krhuZ4eEUoXepgBbPi++FMn8HYJgs
	M4UKVcwIkl92UUSWBRuJwuwP4Nfw3y0lcfaSAEn+zuXHZlnRCD3d+5NH2n2qbOk3O+4hhug3Gej
	G/uNNf3FtbmAgJkpW8ESZyEj9R8F+4gLamA8B8zXeGiMpuV1oYxzsMKVaYgB2yJXMRCUO4xmOvi
	TRr76MFFsbzPWL3Lp/Mp7B6KcMBhthucOuEuiXDmWIW3HEwzkwuBsNBUGOsATtkRHQcs7cxToV
X-Received: by 2002:a05:600c:6290:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-48e51f3fd58mr196699875e9.20.1778221551502;
        Thu, 07 May 2026 23:25:51 -0700 (PDT)
Received: from ?IPV6:2a02:8109:8617:d700:d9bb:cdec:69e5:2f8e? ([2a02:8109:8617:d700:d9bb:cdec:69e5:2f8e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e642d1e5csm12599585e9.3.2026.05.07.23.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 23:25:50 -0700 (PDT)
Message-ID: <a69dc374-8275-4899-89df-942c6f3137e4@gmail.com>
Date: Fri, 8 May 2026 08:25:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: i2c: alvium: fix critical pointer access in
 alvium_ctrl_init
Cc: sakari.ailus@linux.intel.com, martin.hecht@avnet.eu,
 michael.roeder@avnet.eu, stable@vger.kernel.org,
 Tommaso Merciai <tomm.merciai@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260508045332.360004-1-mhecht73@gmail.com>
Content-Language: en-US
From: Martin Hecht <mhecht73@gmail.com>
In-Reply-To: <20260508045332.360004-1-mhecht73@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EA9774F271C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,avnet.eu,vger.kernel.org,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244670-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhecht73@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi all,

please ignore that misleading patch. I send the wrong file. I set the 
status on patchwork on obsolete. I'm preparing v3 after cleanup.

Kindly regards,
Martin




On 5/8/26 06:53, Martin Hecht wrote:
> The current implementation of alvium_ctrl_init creates several controls
> in function alvium_ctrl_init and uses the returned pointer without
> check. That can cause write access over NULL-pointer for several
> controls.
> The reworked code checks the pointers before adding flags and also it
> creates controls for V4L2_CID_BLUE_BALANCE and V4L2_CID_RED_BALANCE only
> if supported by the particular camera model.
> 
> Fixes: 0a7af872915e ("media: i2c: Add support for alvium camera")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Hecht <mhecht73@gmail.com>
> ---
>   drivers/media/i2c/alvium-csi2.c | 72 +++++++++++++++++++--------------
>   1 file changed, 42 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> index b62b45a4f2fc..43535ba7a264 100644
> --- a/drivers/media/i2c/alvium-csi2.c
> +++ b/drivers/media/i2c/alvium-csi2.c
> @@ -2100,34 +2100,41 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
>   					      V4L2_CID_PIXEL_RATE, 0,
>   					      ALVIUM_DEFAULT_PIXEL_RATE_MHZ, 1,
>   					      ALVIUM_DEFAULT_PIXEL_RATE_MHZ);
> -	ctrls->pixel_rate->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> +	if (ctrls->pixel_rate)
> +		ctrls->pixel_rate->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>   
>   	/* Link freq is fixed */
>   	ctrls->link_freq = v4l2_ctrl_new_int_menu(hdl, ops,
>   						  V4L2_CID_LINK_FREQ,
>   						  0, 0, &alvium->link_freq);
> -	ctrls->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> -
> -	/* Auto/manual white balance */
> +	if (ctrls->link_freq)
> +		ctrls->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> +
> +	/* manual white balance */
> +	if (alvium->avail_ft.whiteb) {
> +		ctrls->blue_balance = v4l2_ctrl_new_std(hdl, ops,
> +							V4L2_CID_BLUE_BALANCE,
> +							alvium->min_bbalance,
> +							alvium->max_bbalance,
> +							alvium->inc_bbalance,
> +							alvium->dft_bbalance);
> +
> +		ctrls->red_balance = v4l2_ctrl_new_std(hdl, ops,
> +						       V4L2_CID_RED_BALANCE,
> +						       alvium->min_rbalance,
> +						       alvium->max_rbalance,
> +						       alvium->inc_rbalance,
> +						       alvium->dft_rbalance);
> +	}
> +
> +	/* Auto white balance */
>   	if (alvium->avail_ft.auto_whiteb) {
>   		ctrls->auto_wb = v4l2_ctrl_new_std(hdl, ops,
>   						   V4L2_CID_AUTO_WHITE_BALANCE,
>   						   0, 1, 1, 1);
> -		v4l2_ctrl_auto_cluster(3, &ctrls->auto_wb, 0, false);
> -	}
> -
> -	ctrls->blue_balance = v4l2_ctrl_new_std(hdl, ops,
> -						V4L2_CID_BLUE_BALANCE,
> -						alvium->min_bbalance,
> -						alvium->max_bbalance,
> -						alvium->inc_bbalance,
> -						alvium->dft_bbalance);
> -	ctrls->red_balance = v4l2_ctrl_new_std(hdl, ops,
> -					       V4L2_CID_RED_BALANCE,
> -					       alvium->min_rbalance,
> -					       alvium->max_rbalance,
> -					       alvium->inc_rbalance,
> -					       alvium->dft_rbalance);
> +		if (ctrls->auto_wb)
> +			v4l2_ctrl_auto_cluster(3, &ctrls->auto_wb, 0, false);
> +	}
>   
>   	/* Auto/manual exposure */
>   	if (alvium->avail_ft.auto_exp) {
> @@ -2136,7 +2143,9 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
>   					       V4L2_CID_EXPOSURE_AUTO,
>   					       V4L2_EXPOSURE_MANUAL, 0,
>   					       V4L2_EXPOSURE_AUTO);
> -		v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp, 1, true);
> +		if (ctrls->auto_exp)
> +			v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp,
> +					       V4L2_EXPOSURE_MANUAL, true);
>   	}
>   
>   	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops,
> @@ -2145,15 +2154,8 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
>   					    alvium->max_exp,
>   					    alvium->inc_exp,
>   					    alvium->dft_exp);
> -	ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
> -
> -	/* Auto/manual gain */
> -	if (alvium->avail_ft.auto_gain) {
> -		ctrls->auto_gain = v4l2_ctrl_new_std(hdl, ops,
> -						     V4L2_CID_AUTOGAIN,
> -						     0, 1, 1, 1);
> -		v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
> -	}
> +	if (ctrls->exposure)
> +		ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
>   
>   	if (alvium->avail_ft.gain) {
>   		ctrls->gain = v4l2_ctrl_new_std(hdl, ops,
> @@ -2162,7 +2164,17 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
>   						alvium->max_gain,
>   						alvium->inc_gain,
>   						alvium->dft_gain);
> -		ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
> +		if (ctrls->gain)
> +			ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
> +	}
> +
> +	/* Auto/manual gain */
> +	if (alvium->avail_ft.auto_gain) {
> +		ctrls->auto_gain = v4l2_ctrl_new_std(hdl, ops,
> +						     V4L2_CID_AUTOGAIN,
> +						     0, 1, 1, 1);
> +		if (ctrls->auto_gain)
> +			v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
>   	}
>   
>   	if (alvium->avail_ft.sat)



Return-Path: <stable+bounces-119691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3228A46342
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D121896EB2
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 14:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0918221738;
	Wed, 26 Feb 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UA0T92Yi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5EE19CD0B
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580922; cv=none; b=GEUyHOlngQ+R3erU2eyIJ0ZRkq2knqRyHQl0Zdh/Q3UlEJllooaX7U+Ll/uy+FU+cO91p06a5jW0NZ5Ukk9A7tt9aryF/+T7XgNVYsuo8mnkrbe6eDBo9K4HfN+jSM523JpSOFOOaXjMwq1IT4luQd09K0v8EzcXdIeByQItnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580922; c=relaxed/simple;
	bh=4FWXayBvVhNTS0E6OWpQiCVezWoKUfgMUUoPmP8gePk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bmc2XZK3lYS+3kf5PEShF6ZiU6cu1/4PVATFd1eNmvF8suwogBm8X5puGPg/n6Jf0ZGlRSC+ljDCSpiULbLGSZOsDf+8ostYcdr/UZVEKveWojYWLH2RXLW9OOZnYFlR51RX9U21PJmh3CbvqOuM/Xu5dJoW9lpwfLIBtDTDShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UA0T92Yi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso1203686066b.1
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 06:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740580919; x=1741185719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yd4Q4hVeUYOM1ue+qUfzWNg9Q9i3oT/9A9AYIFfGkUc=;
        b=UA0T92YiBtus8ppEPCDg10F757C1qob4i4FvX+s7vjhN06JNq09tElmthayuZTKbKR
         RzBb38v/U1Tzi19jDCCKfJ53nBVMHlTo4YRBTAT+fa36GR1daqknAVGi9+MjMMyGwuYA
         rOmuWLd2B4Pm7oDF7avN9M6Le7mDbT/Ur4DX0LIzc+0kCLKShWuMR7lyzkU9yirIXxsA
         SHikx/C4FcLi+M3Uu8T8uTvLjeMOiachCQHWNAcZlLpyXRW/exId+fnmOo6+wm54cA+Y
         5KlcZvwLo+17WtT5kNkzT6tI7l+preG+EKVTlgCpuLnooIW80GCVX1kZYEmVFa+eTgri
         kjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580919; x=1741185719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd4Q4hVeUYOM1ue+qUfzWNg9Q9i3oT/9A9AYIFfGkUc=;
        b=N/l8wP79a7O7x98V8pY8SnILpG3BuCvPqxogluQCy75Rhbi4GhFBjF5mbL3k+twPIa
         9Z56I9Tqx/ELZgHJroOqhO8y9wrotrF+rd6XSrq+E/4i2B/dRB7d+rVTM8+W5gbnfnQ1
         O2gYhvztCiE2kB0mpA/WaiM0LgPphaPD3tOHJDDrCoyOCw/gwnVVvNODNq60a4hvZ45R
         +AVx+a5RnJjmZl1Z/qneEB4Spb1QIKLkna3Yrdtomk7QhITrGkBNFLNTkBuBlVkEC8cn
         aLrepBIJ45gA+MFsvUPhFOVsK28jy7g+ZeC/ocRnru1hEgdR8QnNmDFgJ8zSG9HeKyVr
         0L7A==
X-Forwarded-Encrypted: i=1; AJvYcCV3PYvSnW/54mPDKRy6FG1RnutWU5iZMtc6QedggStZY1qh19BMILHhYHDBxNXySkYWlKVV9co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxnNjGPFJY1wdb48Pg9hqVdzQTjZ9nITzy7UjTORgwLh8wO80
	VYC61J1miPvvHRvccJj72bYQLTO03Z2uNtLCWBS9pDvb6GZ6jdHAuaeKTHlRJmk=
X-Gm-Gg: ASbGnct5BYV+zDwMlWDoeST4S2nvpGQT/ENMbvLPEVyr7j3RS6nNgIAhRQHILAxJrHf
	SU4CaThaatte3dzSa/i6rP8ImhVonxtEdzaujFaK3TrEgJS8yf5XBjfnOFk9b9tbvS2bW0ov+Al
	ELQgZ2FcTj14eVEf2HKgRWFyXNtX9Dip8DIRlSDw8Ty8/mfZAVAcL9ko3MstEUmXmppqDDBONx0
	ZLGwyUVJVIr1T/AZME8WNEkKpWXKYYsdLwlNjF3ClVQ7mxmovtrpxJr23qrHUSPy6rTsk172+lF
	LhYJClnGnv5HnzoKXornWaJ+ZSaHpEI=
X-Google-Smtp-Source: AGHT+IEqq+wCIO+7KpV9xqIa2Ubw1hCVyP4Ga6WxVj5wemOObN4UBSusPlhMuI5n8yBIpYErWlyqpg==
X-Received: by 2002:a17:906:314d:b0:ab7:9df1:e562 with SMTP id a640c23a62f3a-abc0de55dbcmr1974440866b.48.1740580919225;
        Wed, 26 Feb 2025 06:41:59 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abed2012142sm333883966b.117.2025.02.26.06.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:41:58 -0800 (PST)
Date: Wed, 26 Feb 2025 17:41:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
	gregkh@linuxfoundation.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	hverkuil@xs4all.nl, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: imx: fix a potential memory leak in
 imx_media_csc_scaler_device_init()
Message-ID: <450cdcc9-ccb8-4ebd-847c-b106fae2d709@stanley.mountain>
References: <20250226142126.3620482-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226142126.3620482-1-haoxiang_li2024@163.com>

On Wed, Feb 26, 2025 at 10:21:26PM +0800, Haoxiang Li wrote:
> Add video_device_release() in label 'err_m2m' to release the memory
> allocated by video_device_alloc() and prevent potential memory leaks.
> 
> Fixes: a8ef0488cc59 ("media: imx: add csc/scaler mem2mem device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/staging/media/imx/imx-media-csc-scaler.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/media/imx/imx-media-csc-scaler.c b/drivers/staging/media/imx/imx-media-csc-scaler.c
> index e5e08c6f79f2..f99c88e87a94 100644
> --- a/drivers/staging/media/imx/imx-media-csc-scaler.c
> +++ b/drivers/staging/media/imx/imx-media-csc-scaler.c
> @@ -913,6 +913,7 @@ imx_media_csc_scaler_device_init(struct imx_media_dev *md)
>  
>  err_m2m:
>  	video_set_drvdata(vfd, NULL);
> +	video_device_release(vfd);

The video_set_drvdata() call is pointless.  It just does:

	vfd.dev->driver_data = NULL;

but that's not necessary if we're just going to free "vfd" on the next
line.

regards,
dan carpenter

>  err_vfd:
>  	kfree(priv);
>  	return ERR_PTR(ret);



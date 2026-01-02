Return-Path: <stable+bounces-204491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB15CEEEEF
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 16:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1BD0302858D
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDA6298987;
	Fri,  2 Jan 2026 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhJ3LPHB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D724A049
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767369490; cv=none; b=A6GEcUSrRy7m9G3UkxXa784eTTOHIqjirRY/Jhv55ZuIglGjgvF+kGlRdRiNPdXBEBpK4DDJ7OJathW9ULTePkkeLUkCiu0vUb0Vgqm8JIq4gO5p6o79cX6TJ/EXubuFG/TyZOlNcG/Cwc/+TdBszQzI6WSO/8KqSQQenAuxf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767369490; c=relaxed/simple;
	bh=0GPnhNFc0YWpsBTS4CUTOCT6To4nN87v0lhpU9nZzy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StcSl1MtlimlCwzV6hUQwK5+GPj9jLGNbaDsq9x7GkdNSj3pBSTFhvrQkj4weP629cWGO8V5n6Kr/GYExmJsSP+9PkLE3J5BD9k/pr3JvOVjJgLoFMvFAa1rzDjapK/5TajO+OlCWTinNjs7V6s3ZbHs8v3MNw9L4Tp4ZWu1t/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhJ3LPHB; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b83b72508f3so253541266b.2
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 07:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767369487; x=1767974287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inEjkYpZZFKseUFbKo7AFRhLn8xe1tV4AKOq/ebShUM=;
        b=LhJ3LPHBV0czB4kIzT6lR4+gGLAxsGS9DtBriuZ6DB/zp3IU5wCKKWfbTKCH51VblH
         iUu6RoKafMoE8MGv+42sFQlZAr4LTvAvgyjPPkNziWe70Aq8Si0SfxiO8oasTp47WvMz
         X76DEo3ed/21CRZtGztNZDMBXmrujRx08fa6H6eGEXFaxLsxb5chQAzhs+zGRlNd/6Zv
         MkOkAYk/vCm31y0Jeoa4KHmyJE2b6T1s66V8KUhHEs1FJpqe1K7cAV4S6UpWj46V1y73
         z4RHb8Ug8DEpqpa3feamWjA9/sDKNcfuznvq3VM6SL3SK/H9ScAZO/K75yafy0hJg62C
         OI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767369487; x=1767974287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inEjkYpZZFKseUFbKo7AFRhLn8xe1tV4AKOq/ebShUM=;
        b=j79865IcpowwworS+WR4K/4mpt89vQ+cND5G+iJ1H5UVMR9QFw48qgHuMh+Eg4eCXJ
         Rt37njmD7QXa0JMDy7x+Ls6hqL6wTHABZ6h+ck3wK8noCcC9t1iyq38vbVbY+aFp9aEh
         JVcHO0OFHJ0+/6CMuApS3gZnqUbeA0U0SuO1OG76qu2tLPKU41iJOIJoI63RmLgk5Xwm
         fS2HFT86EbuVut9Nar3ukOsdFGvZfMvx8HJ9LuCb/SVyFyly1ZHZ7XVuwYYafuEgJzP/
         ZntcP4ZdKGFXxrdm8Q7Hhk2kNHviZO1m5axqhwIPKuLf6uSXslLSkIMIFwDyDfXwffBL
         Tw/g==
X-Forwarded-Encrypted: i=1; AJvYcCVS33J9vmMjRZSKhn/cWLzuQ3aC1iQ8nWz3ok6CeI1Vkj9G1CG8eRHs85eGwNfGLT92PKf1ugk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0bxLR+48Yss6eCPdPVqc/JtnlO3rYX/lA2wA3cxJogohZaIW
	w8/3k/faor+/v/A+v3x2tbLpLKR621+SxrOZJnswIphV0F295DTHqi5c
X-Gm-Gg: AY/fxX42gMuWV5bkIGJC7uOUmzsrai960GBqdfvm/n1/wlDl4EdPO0gV9gX400Re2m0
	Mdkh9eQ286WkLAwDJnP49slX86ejAqJd2DuDUbcJsbnLQ8B5X3SHmx4y/Yhxzg1eE+1skKXy0bE
	z/PI/U93gBSRz1XoGd6HQnv/S2y6AQqY5dX7fRkuD4bVrPnxZ+eiT807DDrHJ10f9soj1VUksDy
	cBfC3fkyxS2rmV+VSUcCHSCuKvX14pwmAhTXTs/ako1ak+SG/IEefDRMPir+gcAKS4QveBR6RgV
	+fY/XskbwapdjSelIMWtT8y7IVVorwtX9emObbaAOSZEYpL50/0ZT7g0PWkfOCgERsZZhkE9SF9
	/dzxaNL7qEwAue2IAGIIj/MH/O42VRiH8B+x/ANHcrBTptEOLLW6QGXUzek12cNtjo9TDGNwIs7
	6maNEBUHw0lvgl
X-Google-Smtp-Source: AGHT+IHiO3O4EGawpFCvkJsZU4HHFVkQUvnh0vx9UvoieKlX+GabYma9+cfOIH50Ic7AgiFfru4A+w==
X-Received: by 2002:a17:907:3fa5:b0:b75:7b39:90c9 with SMTP id a640c23a62f3a-b803718390fmr4882816666b.51.1767369486868;
        Fri, 02 Jan 2026 07:58:06 -0800 (PST)
Received: from osama ([2a02:908:1b4:dac0:ac54:a680:a017:734f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8056ff4925sm4098474566b.31.2026.01.02.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:58:06 -0800 (PST)
Date: Fri, 2 Jan 2026 16:58:04 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, stable@vger.kernel.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: synopsys: dw-dp: return when attach
 bridge fail
Message-ID: <aVfrDJojCylccwYJ@osama>
References: <20251231144115.65968-1-osama.abdelkader@gmail.com>
 <DFE1K6AD151E.23NWWMYDV2ZDI@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFE1K6AD151E.23NWWMYDV2ZDI@bootlin.com>

On Fri, Jan 02, 2026 at 11:46:08AM +0100, Luca Ceresoli wrote:
> Hello Osama, Andy Yan,
> 
> Andy, a question for you below.
> 
> On Wed Dec 31, 2025 at 3:41 PM CET, Osama Abdelkader wrote:
> > When drm_bridge_attach() fails, the function should return an error
> > instead of continuing execution.
> >
> > Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
> > Cc: stable@vger.kernel.org
> >
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> > v2:
> > use concise error message
> > add Fixes and Cc tags
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> > index 82aaf74e1bc0..bc311a596dff 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> > @@ -2063,7 +2063,7 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
> >
> >  	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> >  	if (ret)
> > -		dev_err_probe(dev, ret, "Failed to attach bridge\n");
> > +		return ERR_PTR(dev_err_probe(dev, ret, "Failed to attach bridge\n"));
> 
> Your change looks good now. However there is aanother issue, sorry for not
> having noticed before.
> 
> While reading the dw_dp_bind() code in its entirety I have noticed that on
> any error after drm_bridge_attach() (and also a drm_bridge_attach() error,
> with this patch) it returns without undoing the previous actions. This is
> fine for devm actions, but a problem for non-devm actions, which start at
> drm_dp_aux_register().
> 
> For example, if phy_init() fails, dw_dp_bind() returns without calling
> drm_dp_aux_unregister(), thus leaking the resources previously allocated by
> drm_dp_aux_register().
> 
> Andy, can you tell whether my analysis is correct?
> 
> If it is, this should be fixed before applying this patch. Osama, do you
> think you can add such a patch in your next iteration?

Thanks Luca for the review, I just sent v3.

Best regards,
Osama

> 
> Best regards,
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


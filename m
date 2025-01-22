Return-Path: <stable+bounces-110151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C47A190B2
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E963A3F83
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A8211A35;
	Wed, 22 Jan 2025 11:35:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA465211A10;
	Wed, 22 Jan 2025 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.229.23.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545714; cv=none; b=eeUPEScQG2qcG1znQjtBhTnCPIk+taIKzo5hISC7rBsbHZAbU56ZochTRwZVfzjSFj3XhdZVX2fuAcjf/RDZgkIDqbIqcbf5E820vUX9gc+oLkEgZfhd3krsZu7lHf+Ud1YeNig4W6s5kxxnvd3DvSW5he+b6W0/G5oIJI6h2qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545714; c=relaxed/simple;
	bh=CnC7z5Kpglvyyle50BM+ZVtwf3HM7YRhkbt43/1MYY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxJEcxtxM1FbgpsaEKzcCt3Pop/fViZO4eTxGAaFx+1ZN9MYlFl804tX/BAifshJK0lsP3e07AOIqv2GSlcU5no8J5XtluA9qYZ14eQHF/h+0JT5Ta8JrqKopv3ebHX/RuYRc8cHALXSzSoEPcMfG+tuOjpYF4i2Oz3//XxBTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk; spf=pass smtp.mailfrom=dudau.co.uk; arc=none smtp.client-ip=80.229.23.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dudau.co.uk
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
	by smtp.dudau.co.uk (Postfix) with SMTP id B87A241E2245;
	Wed, 22 Jan 2025 11:28:54 +0000 (GMT)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Wed, 22 Jan 2025 11:28:54 +0000
Date: Wed, 22 Jan 2025 11:28:54 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, james.qian.wang@arm.com, ayan.halder@arm.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/komeda: Add check for
 komeda_get_layer_fourcc_list()
Message-ID: <Z5DWdtxrYjfIt+/F@bart.dudau.co.uk>
References: <20241219090256.146424-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241219090256.146424-1-haoxiang_li2024@163.com>

Hi Haoxiang,

For reasons that I have not uncovered yet, the work email servers never
delivered your message, I have discovered it today accidentally while
looking in a backup I have at home.

On Thu, Dec 19, 2024 at 05:02:56PM +0800, Haoxiang Li wrote:
> Add check for the return value of komeda_get_layer_fourcc_list()
> to catch the potential exception.
> 
> Fixes: 5d51f6c0da1b ("drm/komeda: Add writeback support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index ebccb74306a7..f30b3d5eeca5 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -160,6 +160,10 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>  	formats = komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
>  					       kwb_conn->wb_layer->layer_type,
>  					       &n_formats);
> +	if (!formats) {
> +		kfree(kwb_conn);
> +		return -ENOMEM;
> +	}
>  
>  	err = drm_writeback_connector_init(&kms->base, wb_conn,
>  					   &komeda_wb_connector_funcs,
> -- 
> 2.25.1
> 

-- 
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!


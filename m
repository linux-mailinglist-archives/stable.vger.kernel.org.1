Return-Path: <stable+bounces-86852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499B9A42BE
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36021C223CA
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026542022FF;
	Fri, 18 Oct 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxFFjm9I"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AEE2022C2
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266197; cv=none; b=W1OdrxIW6/DPLLbNTwfdTsbOfPNfiNAiiRZzPrCRRCarszo0SPe1Rn9ZMXkqMZggVdnyLqRA+ebZnMQA6oArcG1VlV7B0a7ZlN1MQyj5QleIXAlQ/Tkz5Js53h8zWJndI/jhmhiE5nYhnNW4Yr7hwZ7uMCROWDSPVBwY4v9GaSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266197; c=relaxed/simple;
	bh=yrAJt130zhNnFNLgz1MFQ6eVo/8vhXTxPNhNHqInfis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFCExuW67oeS4J5HR9aJXipbnZa7nhaEPvZ4nLms1tniMlvFskTOjeSsME6ivAb94bgpjDz8juDFUMugnkR9GAAb8DhWeKMxZyHeNNF6g1ZB7FRZRCPommLn+1qE7JLw388VdnUpcXnp40L6Cxoyn0WJ+27BIEC9VvXcQNZSsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rxFFjm9I; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb51f39394so25965361fa.2
        for <stable@vger.kernel.org>; Fri, 18 Oct 2024 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729266192; x=1729870992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/v9F36+wCfWTJvKnnFi5Fi92/EQ/UbzdjUVtyo+GVs=;
        b=rxFFjm9IBPOL8gYxlMWDFcanXjgR/FgmouEseT0Q7VfqaJp6rNQu8V8m4FD5OoWA89
         ZoXYK2fgvp6b1j+nNZEDvqAF4u3n6YHR10DlfkoND7+YxC+vBxiGeUwssBK1Y1IWZOgo
         lh5SbEBcxR2fNIqeqhoz5ncYwRbo/E5yYbY7pgcnEwrb3Qrybkqp5rLvOeo+8W9nAUDp
         e55AAGhlJ2CxCuKwnSEtUmGAuz5wbVZl4Y2BLuV34gI4IDuD7gvHFqE5Jnj3lpt+FJA8
         Q1wrZSlx8NbJEtGvfScPdnkIC1c+B3HI5HcuUr2m3ObcTmo8IJ5qxTw3bh6kYRcGI94Q
         J0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729266192; x=1729870992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/v9F36+wCfWTJvKnnFi5Fi92/EQ/UbzdjUVtyo+GVs=;
        b=CS1MuFBngQ2k9ThXSc1b86hRhZHJmFcwsa7WV8cq1kKXaDVttfCOyWCHTYWOHN1FsX
         9OSmmHEJkpP8Kes9lkC/eReH4OQiWiEuMVzEOg22IGAHZsq3cNw2axfnv4of1CGJLuyO
         yKwTxpaCOeKxOhNTK7hGQxFlFG2gSUFQ6E5UJCwDc/pNBGhfi0AM16hb9hRA9lw5fu2v
         NlOdqhxF24HApzy9U9i9a9SujtWvXupU8IDSeMqpyxCf+3OgrrMZrKjSqJm0ANiu3JPZ
         ZNmwb7GxSH2LOhtlFBhyxG8ahpkJhRaI/wV33izyUP+mpXd7ZBNv6M4tmRV56dZq6KsK
         mSnA==
X-Forwarded-Encrypted: i=1; AJvYcCWYD0MKwOaJ45jijss8bg6EDJSaavvWhFjylEunv0ahKD0m/buxtshN7oPyHaiXz2a9FxBvLtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywi7UWEqxeQrox5LA+N2VRpb5HyZ1992LWT1G54EXcyTjTHk8v
	ZghOpbqpi0q72PIaYBqTlEGMkJWaUB1a0jWvvMhuiU9Y7wyF4tmvNf0aTZlqLAe/CmWOy0RGmQy
	6G9E=
X-Google-Smtp-Source: AGHT+IGPiDRkwHnl+SqRQmTMCADDN4QAteA+dBcwkasQ1KTbWV4DVUcPcCzqNj5AV25OW6qHaXwpQA==
X-Received: by 2002:a2e:b8d0:0:b0:2f9:cc40:6afe with SMTP id 38308e7fff4ca-2fb82ea23f4mr18378251fa.14.1729266192256;
        Fri, 18 Oct 2024 08:43:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809bb125sm2247151fa.69.2024.10.18.08.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 08:43:10 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:43:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
Message-ID: <ux2lfkaeoyakulhllitxraduqjldtxrcmpgsis3us7msixiguq@ff5gfhtkakh2>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>

On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
> The assignment of the of_node to the aux bridge needs to mark the
> of_node as reused as well, otherwise resource providers like pinctrl will
> report a gpio as already requested by a different device when both pinconf
> and gpios property are present.
> Fix that by using the device_set_of_node_from_dev() helper instead.
> 
> Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
> Cc: stable@vger.kernel.org      # 6.8
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v2:
> - Re-worded commit to be more explicit of what it fixes, as Johan suggested
> - Used device_set_of_node_from_dev() helper, as per Johan's suggestion
> - Added Fixes tag and cc'ed stable
> - Link to v1: https://lore.kernel.org/r/20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org
> ---
>  drivers/gpu/drm/bridge/aux-bridge.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


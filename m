Return-Path: <stable+bounces-89425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228229B7FB9
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 17:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F491F2191A
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D101A726D;
	Thu, 31 Oct 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6VHh3kS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5D1A4F0C
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391231; cv=none; b=QYcea+NxGNHVXDoDAVNkdS3PQJBDdHm+Ul6c2ZyEvZ3i9l+LPJF7FpucyKOrSIFAc891aPxODs+fr8yS1wF0HLYz8YTCxaozQm9I4NOf5ZhORHZxmN1l2jVwDYs28Mtnb2B3u6I36ermpGHNEqZbsLwGmM1osEe4lBrgig0EYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391231; c=relaxed/simple;
	bh=VvHPgknTQfkkPRYxQDkWVhBjIcD9nECdjixWNWNz9Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osYL5VZOmIYPZ+ZUu/krRsJ3dcWwEXoVc6jTIgjJjhUBQLdrtrPZw0/Gh4OQK0cWerhqy0/uxuhbjJDEE4dxo3/g7BHLjMp5LELf7iaPGCeiHIq5zqy24PE8ePo/qfDMHP/lhNYUEIfUyFGo+7c7VgtI+4flemHdTiyWrhiP+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T6VHh3kS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so9021385e9.2
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730391228; x=1730996028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CakDXS6c1DhzA9TEtNxJdDyagqdPs+BWOzw82gUl7A=;
        b=T6VHh3kSDIeLX3z+/Y5FEvnArpPXyc9rZr8sFFYNiFMhwNi9VelXgEHU2L21BvnCzx
         tBq1Fl6g1ORkjvkCt91gr/qsEwcUfp5LFrXOCz8uEMPtLwmbKt/ObLLk/QTq9HTNys++
         51al8Y5aNalXGxFiyS5/ygYB8KQ78BPpYifdvkTIB361rK6K3EyxO744LIuQE/e9otCp
         U+KepFKqabzRwTsmX4icFIJ5oHijaxKyDXyR8x0UneSxU9wslgyeT7Row8D0u43+TbHn
         KHn9DPfWr1MSrP8iRMQPhewlJjpQYGeg0odkQ9mca/D+Qmb+XAvXWdyZe84HIfVgzNd+
         2fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391228; x=1730996028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CakDXS6c1DhzA9TEtNxJdDyagqdPs+BWOzw82gUl7A=;
        b=aRQm1GgdeghZLAJzIpHEDTCMudfzx0sCGULghEo3/vV0oxaP2RHMQltA8Oanm04zw7
         WtvS+qe34AEuAeGwoJSuEDnlnwgA/bRbLw9iiHuuhm3H3DS2lXk1zSgt6DvPaCs5iLg/
         5eOm7KuIBj/0Cct8suwk0xeBYFvTQnQbJ3WibdsLcxgC3T5UfSgqd2+HVijLN4aTJWPJ
         RPA345x8LE9/2YCVYKkp7OdoXTFdvlnYa4CPwmWiMXjnNrBzrsshedO8Jxf3wMWNexoG
         Zy0ikE/w9vhq9NPLsfSR05EvoSwNVoETyiofxby8xfx0jT3dKdby4DGotI76C0/y68sr
         Vg5A==
X-Forwarded-Encrypted: i=1; AJvYcCUfWPSDS/uq1qECYA9NxBg7pYC1cwQZHG+b4Ctltv8X7InVfAHAyTnAIuB8UJXqvYTK6tTon38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jUNWnXSgaJBPECop/uVVvFLOF/kFX6bLf8lnNN/iyUGOkcwA
	aSmlUCGEeWjgsolnym2o7bP3e5g3D7ZMkwqCcWXttoFkBW39iqIjYs6WN9/zc8s=
X-Google-Smtp-Source: AGHT+IHCYxSGmVXNdG6HbEGSCE6KOxPf10odxndDOKvnEQsVM7GhMv1g4/6VDhU24xOmBDFWwJuNug==
X-Received: by 2002:a05:600c:a04:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-431bb8a01dfmr66125375e9.0.1730391227625;
        Thu, 31 Oct 2024 09:13:47 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852fdsm31030365e9.34.2024.10.31.09.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:13:47 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:13:45 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
Message-ID: <ZyOsuTr4XBU3ogRx@linaro.org>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <ZxYBa11Ig_HHQngV@hovoldconsulting.com>
 <ZyOOwEPB9NLNtL4N@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyOOwEPB9NLNtL4N@hovoldconsulting.com>

On 24-10-31 15:05:52, Johan Hovold wrote:
> On Mon, Oct 21, 2024 at 09:23:24AM +0200, Johan Hovold wrote:
> > On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
> > > The assignment of the of_node to the aux bridge needs to mark the
> > > of_node as reused as well, otherwise resource providers like pinctrl will
> > > report a gpio as already requested by a different device when both pinconf
> > > and gpios property are present.
> > 
> > I don't think you need a gpio property for that to happen, right? And
> > this causes probe to fail IIRC?

Yes, I think this is actually because of the pinctrl property in the node,
so no gpio needed.

Yes, probe fails.

> > 
> > > Fix that by using the device_set_of_node_from_dev() helper instead.
> > > 
> > > Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
> > 
> > This is not the commit that introduced the issue.

The proper fixes tag here is actually:

Fixes: 2a04739139b2 ("drm/bridge: add transparent bridge helper")

> > 
> > > Cc: stable@vger.kernel.org      # 6.8

> > 
> > I assume there are no existing devicetrees that need this since then we
> > would have heard about it sooner. Do we still need to backport it?

None of the DTs I managed to scan seem to have this problem.

Maybe backporting it is not worth it then.

> > 
> > When exactly are you hitting this?

Here is one of the examples.

[    5.768283] x1e80100-tlmm f100000.pinctrl: error -EINVAL: pin-185 (aux_bridge.aux_bridge.3)
[    5.768289] x1e80100-tlmm f100000.pinctrl: error -EINVAL: could not request pin 185 (GPIO_185) from group gpio185 on device f100000.pinctrl
[    5.768293] aux_bridge.aux_bridge aux_bridge.aux_bridge.3: Error applying setting, reverse things back

> 
> Abel, even if Neil decided to give me the finger here, please answer the
> above so that it's recorded in the archives at least.
> 
> Johan
> 

Sorry for not replying in time before the patch was merge.

Abel.


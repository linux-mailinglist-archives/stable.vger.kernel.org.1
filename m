Return-Path: <stable+bounces-89482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAB69B8E23
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 10:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F896281B5B
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 09:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D57158870;
	Fri,  1 Nov 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KuZgXPJl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E00157487
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454548; cv=none; b=cb1M2zLAOAGG3oglOPEfM9oD9l9VsWnHuUYaiqSMD7euTh6Y+sH2WMGXZx7/Ur320Yv4n2Ve1uHhS7BVRTYX0hYuwmez4RxP5q0gkJ7OYnKQ+uIevt/jSqW9PuA2aONtA6Q1rCw9xQoTC1fwSbIyXGUX4s8Sjmfsf0OjZ3dG4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454548; c=relaxed/simple;
	bh=I06E8a/JZI8ea7op3bUNVazLDBLCFDZCsUn3qnxWA3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEWqLbqcBtRk9mSwGqTK8pebS4lZmZHJwzLXRlZz3F+U0be03O4wXWXyHhnWKoRkD3oIX1i8T+TqUpMGbvJ8YMGTi8HIEhuRM4XL5L25z7Dd4J6YEPLmXQ1frKGDNcjhv5ORHdjgzWclPWdx2dPxEXKYF3ECjZjKWMGr4tSfWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KuZgXPJl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso1683409e87.1
        for <stable@vger.kernel.org>; Fri, 01 Nov 2024 02:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730454544; x=1731059344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxb5qd1QDIPM/jSC0SzZPLDKW9qNuQz8ACVJ5xEQ9Og=;
        b=KuZgXPJluAGl8TnHLzcf6KvwvpPFeGAJQi5JEgDmThtFJEqrAgZCxUnQcUY8r6Yo0w
         u7YnmaWQxJkZLZBnFS9KmncY4Ef1xfMvEE0UKiR7UwUaeIPZMTxsNK6P+X4bIK28Whdu
         hN/6odbfaxTCAwqpdKnvjuscJu/nS3FJKIuKVzqgbC6zIL2ml/UHfPK2jBdTtgtU8+pX
         YnGjPDLRGf6g7TRNIFsDGo4ohTv1dN8QLwxCaheylDFrTSm2TDpz6K+7AJRDRgTzsx2K
         3QurqrERjVTweH9yJNU6MXaILAKS8KFKjqWVb8l87A7+NQN+146UoIZTtXoTppa0bGNv
         m2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730454544; x=1731059344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uxb5qd1QDIPM/jSC0SzZPLDKW9qNuQz8ACVJ5xEQ9Og=;
        b=fQOFHIRJG5Pl4ttVGtxX+DMgZPNJ5phHjTbGoVGHv2T+a4cHcXtvwTO3yVesCUf5Q/
         Gt4EV3pydxCUS3GdslkLR0TkGveuSPi2vZXiZiYhgvnjWGlf8bdN+BuR3QbmP2BHWXm/
         mdpnUNUBlNx7KCwXeJs1h8MoyvEdxvKDbIvolcU4tLVlz0Rp081QoCChXZfrkG/P4e0S
         rkqoCG6LdoWP0wLLDCl22XkA9w1eDF/Dam9VRAZhr9xSvML+WlSYJqF8d8ippUB7W9nz
         c9ohY4tEnj8leoG98xLn277mEhMdBqfMLDGLZeDqW/q1KiIV2T7HZVzHJ1O7frRR/3E3
         wLdw==
X-Forwarded-Encrypted: i=1; AJvYcCX+1sDlZo8eOaQm1soyq406KVqTRiF65SRSKOqu61b0zR0me0da+a9+7VdeVFRJCW8qWFnQ6EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYs5KMqpGyrH9UJIJM8CKWfKkgaoNCYqm9Qsdpg/RFWrJuc2Mc
	THPxB4+XqVOktbqxSIH49QzD6JHMxAqnJhVtZGkjg2ZeBeNfWZ0MQa+GtIQa9fo=
X-Google-Smtp-Source: AGHT+IFGmepb6pA/PhrFcsbK2sdy+T0CJMGpY3jWydPFArJbEEtCdrMr7FwLdSZhf8F/ntpQCdyxSQ==
X-Received: by 2002:a05:6512:3195:b0:539:e023:8fce with SMTP id 2adb3069b0e04-53c79e15984mr3059817e87.12.1730454544173;
        Fri, 01 Nov 2024 02:49:04 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf447sm53365025e9.13.2024.11.01.02.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 02:49:03 -0700 (PDT)
Date: Fri, 1 Nov 2024 11:49:02 +0200
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
Message-ID: <ZySkDgijDebz+6BA@linaro.org>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <ZxYBa11Ig_HHQngV@hovoldconsulting.com>
 <ZyOOwEPB9NLNtL4N@hovoldconsulting.com>
 <ZyOsuTr4XBU3ogRx@linaro.org>
 <ZyOxX31QV2GA8Ef8@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyOxX31QV2GA8Ef8@hovoldconsulting.com>

On 24-10-31 17:33:35, Johan Hovold wrote:
> On Thu, Oct 31, 2024 at 06:13:45PM +0200, Abel Vesa wrote:
> > On 24-10-31 15:05:52, Johan Hovold wrote:
> > > On Mon, Oct 21, 2024 at 09:23:24AM +0200, Johan Hovold wrote:
> > > > On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
> 
> > > > > Cc: stable@vger.kernel.org      # 6.8
> > 
> > > > I assume there are no existing devicetrees that need this since then we
> > > > would have heard about it sooner. Do we still need to backport it?
> > 
> > None of the DTs I managed to scan seem to have this problem.
> > 
> > Maybe backporting it is not worth it then.
> 
> Thanks for confirming. Which (new) driver and DT are you seeing this
> with?

The Parade PS8830 retimer and its DT node. The v3 of that patchset
will not trigger it unless the pinctrl properties are being added to the
retimer node.

> 
> > > > When exactly are you hitting this?
> > 
> > Here is one of the examples.
> > 
> > [    5.768283] x1e80100-tlmm f100000.pinctrl: error -EINVAL: pin-185 (aux_bridge.aux_bridge.3)
> > [    5.768289] x1e80100-tlmm f100000.pinctrl: error -EINVAL: could not request pin 185 (GPIO_185) from group gpio185 on device f100000.pinctrl
> > [    5.768293] aux_bridge.aux_bridge aux_bridge.aux_bridge.3: Error applying setting, reverse things back
> 
> I meant with which driver and DT you hit this with.
> 
> > > Abel, even if Neil decided to give me the finger here, please answer the
> > > above so that it's recorded in the archives at least.
> 
> > Sorry for not replying in time before the patch was merge.
> 
> That's not your fault.
> 
> Johan
> 


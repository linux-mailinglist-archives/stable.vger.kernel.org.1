Return-Path: <stable+bounces-110824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0277A1CEE3
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 22:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591717A2CE5
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 21:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52580136988;
	Sun, 26 Jan 2025 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5JFQhIy"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC7B25A64F
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737928372; cv=none; b=oE/P/sPO768ZYcymdb9Tut+zv/8IES0K+md3JxBQR/aWbqlp8xUnTXsQPTjiNvyGL80fqRjafC2MyR088aH99tYMWJ132WA9NzSMpH2KtAZbfxnb2fqTXDGwKiImjGdO48brxgedv/WsuKYb9S7fXm1z4CubUbLyodntFE35zjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737928372; c=relaxed/simple;
	bh=lL+mK2nzf1kFiAmPlVak1saGvlS/bKsQFcb34ZQIGV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii3bYEXzGshm9STeprWtlb4uPII6ewIGfy/TjQ/xWFA4/Ef8PqnicegGhfzNpBoAelOaxYBGM30CIIpSl2hINqosudjSldHldjFXKZx8FWS2M5cTDUXpmP8dVn+eNfhFm/QFipyC4ZeCwFmMTpyEkc7GKC/Zd1+ks1aqwH40aMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G5JFQhIy; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54024aa9febso4131632e87.1
        for <stable@vger.kernel.org>; Sun, 26 Jan 2025 13:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737928369; x=1738533169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qXWEy4m/+SedvQxipCy0/WvNRoS9HJTYyRPS0PLi6FE=;
        b=G5JFQhIy3qPfRj2ChHNTCvhYbFtwo4j26JRgeG05HGM1l9j/WREHewt5ZGVW/a25ou
         p0IKDTasVI6RcJHxk2e9LdqCDiPtfM/TRK6WsXaopzJuzDVejUIJEKUa9tjpJVqQ8Bju
         PiIL/JDUcXU9/hptHTzPifO6vOXr/JVwW2rbofuQDOXVU6psq1zdypK8Rhhnig1J2Po5
         PvVcQfpRA0c23HPjkhcZaikIuhzgHTcqNYQRizvpspADnC0bhX2r50/nILCi5c84QULA
         /wnrJtq34/t/VRzev18AGqZq8dQy8o6ruCkg1RO10XVlCw31Q0ajCW4vaxeUbrLYPIKV
         6o0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737928369; x=1738533169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXWEy4m/+SedvQxipCy0/WvNRoS9HJTYyRPS0PLi6FE=;
        b=qISrtlWJhJIHm4YTWJKZOrKHJZLrT6kk1sE8gET8rqPTXfwb++gr68A+igMfS3dlKP
         cD8L5ewgk5cnZlx36uthx9gNvjm0h6Ze58XWyqSTGPP7m2+QuSZRTuUckBiRrVPMFxSR
         HSqdsJRs0ufS/cd1P7soNCIpSI8IpzG/rWnMdsrk4EKMhouxXvKSu/fgS7So+oQ3HPNV
         4f+MKA8BsTYISTgxIfnVAQZyDPiYbf4Q2m4RgFNjW7LKw76vfvIRtzXYbuSwYoAd0OcL
         L+Qza4auM3Q+wTQVFJ0WCGjou10qR/+xwiqS2NysRS507xf6EAMwVHzJVFZdR6/RuTr2
         0thQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz+Ab/XtDgGVZm2JWytiFs9TPIVQiNgS5yaaycUR7sIRFQ6bt+tTL+zB/tmIIsbtOTlFy1BGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/G1OMckAjXgEHRK2/1pfccr1yKa6952AKTSl+ACm6rncdsNw
	3uRkBEF+R/4eLkx8sqelAJUHVy8E+LLlYvkV1u/bTM2gUE14ejARd65pt3zzVTQ=
X-Gm-Gg: ASbGncvqFfExcoaiak3eOFx1KpGOiut4Fv4tdqBXOjlU16xYrnJ0PlvJ2xSnULaIa27
	PQhYBsdUW8lKrXztIBdmJLr6fVFzlYe7ivwNz8C+8PRlp5EFJfq4epKE66TYZpO6dgfaTm2AjWX
	WUDOqPBu54JKb1jmwtiz7ljUjMZJ2LmxF3l1KXIU/gmTrLVCTgzMNucZg1O/zKcKIkGbGFTZoVP
	XeZQNijYsI5s4Qr5Gz2EzilnIJCYSYbrNqRexiG3YqLeuDpgwue7juAT+ERYOqD0qORDzAsZ4YB
	DAN2xox2BKKyE0vpV0hiS5I5zUzaqw5ZqjZjOoSRnFFhSNZEb5QsCdFDwTK8mnMuo/PVq6w=
X-Google-Smtp-Source: AGHT+IGm0KQb0Vij9k3D8pZVpr5BC9rc0eUVUGgKeQWn4WWcS07Ek9mP0rUYBloUQD6i7NVcVlTQ1A==
X-Received: by 2002:a05:6512:1183:b0:543:c3c7:b3ad with SMTP id 2adb3069b0e04-543c3c7b449mr4225553e87.50.1737928368581;
        Sun, 26 Jan 2025 13:52:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c83682d1sm1039176e87.155.2025.01.26.13.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 13:52:47 -0800 (PST)
Date: Sun, 26 Jan 2025 23:52:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Devarsh Thakkar <devarsht@ti.com>, 
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
	Jayesh Choudhary <j-choudhary@ti.com>, DRI Development List <dri-devel@lists.freedesktop.org>, 
	Linux Kernel List <linux-kernel@vger.kernel.org>, Stable List <stable@vger.kernel.org>
Subject: Re: [PATCH v8 02/13] drm/bridge: cdns-dsi: Fix phy de-init and flag
 it so
Message-ID: <mzz2zkxcd3z3jinxoty4unqxtm5jdynnlkzggwejtz6nzo7afq@bmspzevjb2lj>
References: <20250126191551.741957-1-aradhya.bhatia@linux.dev>
 <20250126191551.741957-3-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126191551.741957-3-aradhya.bhatia@linux.dev>

On Mon, Jan 27, 2025 at 12:45:40AM +0530, Aradhya Bhatia wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> The driver code doesn't have a Phy de-initialization path as yet, and so
> it does not clear the phy_initialized flag while suspending. This is a
> problem because after resume the driver looks at this flag to determine
> if a Phy re-initialization is required or not. It is in fact required
> because the hardware is resuming from a suspend, but the driver does not
> carry out any re-initialization causing the D-Phy to not work at all.
> 
> Call the counterparts of phy_init() and phy_power_on(), that are
> phy_exit() and phy_power_off(), from _bridge_post_disable(), and clear
> the flags so that the Phy can be initialized again when required.
> 
> Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
> Cc: Stable List <stable@vger.kernel.org>
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


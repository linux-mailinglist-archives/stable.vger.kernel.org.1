Return-Path: <stable+bounces-110823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A04FA1CEDA
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 22:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65ECE166888
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 21:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA198145A03;
	Sun, 26 Jan 2025 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6mJh8wb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86EE25A64F
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 21:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737928090; cv=none; b=O2exOiASdrobW5p/9IzjiSbHzNz6VL/ooIn+V+RESJkake9XFmlTaHc5gfNukPUZZaJiqZwv15ylsAwLGiVXI2VCOR2fsGTI+hN4bWTK6LQcA7BgWvC3N6OqhviAdL3mv68zwq7T8lpdnt8OsWr5AJQb7bpC46+f9zLQscY/m9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737928090; c=relaxed/simple;
	bh=scmZGk4pImxO4Pl0Kowmb8AcH+wD3PTUS8BgTpxnfyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4zxXrgJQKuW8Oc9+v/cRKA/AZdSd++pq2kfNfxh28NcDc2g1c/mQFj8IuFwPEwd1MneorhHozFdZIaWjr7SW3/1FidBZCkMF9CwY1sQNX5UuDn7UokN3IbCLbT70nvUme6ScUMFirOSdmnPI3ox6HvhfkxvuGTG5bR+2SL3Edg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K6mJh8wb; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5401d3ea5a1so3591261e87.3
        for <stable@vger.kernel.org>; Sun, 26 Jan 2025 13:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737928087; x=1738532887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/S7PSfTdIyOWCqzxjO8cVsApM/4duiuiYRufIuKZQo=;
        b=K6mJh8wbLMiif/wkRuqWaWNNoBbvjsJH93vyNAEUslLqpx+eB9HhlWdJwr9t1QZ6uX
         iWNs2Q2dxW0jtE6nZRHlhz2V/hlQYoPdUNxJ+E0RvjEjGi/0Sd8aAhohfUnNKa83MElo
         8X9Wa3NVCEKYLzxmY1f+ij0tkLg36QDV6TS/ZrTEztBbWZgPvQpThfsbVcCAdkf6f54m
         Y3jN6pBHCpM05GDtHjDEP65TqX16+Kr6KsQ7iPC4b/6QtPl4R8K/3xtQHpBWFVNuy9SM
         gDna0SbaMQSJbzJqrk6sNIIu715YDoYmiYy2X3ZGtjDRIiWrPUfJA2QCFtYs0a8YbkBp
         hptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737928087; x=1738532887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/S7PSfTdIyOWCqzxjO8cVsApM/4duiuiYRufIuKZQo=;
        b=TbLKgM1yFTes9/VINeNiipH2qBnHuuzKBZLulT305lforYqrMA5tmG816lFv9o0g9S
         irk1fw3SRXGXOfmFNlcSD6dBkb6qEkzna0dfeWADylMfrZzYxz5/k3ElCYgwTbtR3MYB
         chAcgcDqheayacnZmxx31ngJtS+QwTCSwqEYN1cdIiokHJm98HL06A4CKuA94ee2xJa0
         j7vlEq3fC4LHCTwW3Ia7RFcUTGtW50GY+b73vjpspqUVZTfQ2+eNS1BPFnyck007bHZ3
         5VlOKtbrTYCZJPLcy4h0rluMa91Y0dBhRWykwsaGFx6NW2OBNCxKrgvG0U1XwedQXLf4
         TUaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3GBxDyW1ZbNmHh7WhiO4voWAAwzbaMgp1MBZpOIBL77Zt7eXxUsY4WNIHdF5W7yKg1GyOLGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+oZ86rhd7MKr0n/Ov9eiR6niEwrUoJuTETPGbJDnU/PnHQJb
	BVIeeDqJo4xZDPxkjLWB4ft6+Ai6lYu8qgRm28aj8Sh1g2rVmelm9+1ELyNZamo=
X-Gm-Gg: ASbGncsov9wzAW9m7XS4F/Rn+D07eChAn5/GzRBZ1MV9rvVCte03TevFclY3GY8zy/G
	0kI+37ZHxj3lOCoTNiv2MgorNH0/B+1RcZtt/uVR5kXkATmhERtYkkM6UmI9HEyIJ4NGoxZdYnX
	ripmU1MaJJTX7v9iCvhnvVCV0sCzEiyITRbknnGJvBDIfnZNNw5MnxiQYA5iavClsNIgoEXWRO3
	9jrruBtNwwt/rdxuSISJiHsE8wHd9JcqPW1za58knPAOq6kQxxdMP2MlSP4+TjCEd88MBpjYSUA
	JvLqGjIAjLe7pJnNXnjaqs7G8ib6H7N/y+4LtDrWpbIBjkwa4MqyQMnGUbWG
X-Google-Smtp-Source: AGHT+IEcjYpIgRwjVoLjppNzEES8a1xJOYuIEKUeDh9gpiG0iLZgQtNHK6tYiX6ef1gXdDms1RT4TQ==
X-Received: by 2002:a05:6512:3e03:b0:53d:e5c0:b9bc with SMTP id 2adb3069b0e04-5439c28743bmr13744798e87.50.1737928086874;
        Sun, 26 Jan 2025 13:48:06 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8368521sm1027430e87.133.2025.01.26.13.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 13:48:05 -0800 (PST)
Date: Sun, 26 Jan 2025 23:48:03 +0200
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
Subject: Re: [PATCH v8 01/13] drm/bridge: cdns-dsi: Fix connecting to next
 bridge
Message-ID: <6ie36b5hcrgteo2gh2ievnyw2lsnfr3nhsbxu6ymthmc7lzfvs@3zbaf6flye2t>
References: <20250126191551.741957-1-aradhya.bhatia@linux.dev>
 <20250126191551.741957-2-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126191551.741957-2-aradhya.bhatia@linux.dev>

On Mon, Jan 27, 2025 at 12:45:39AM +0530, Aradhya Bhatia wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> Fix the OF node pointer passed to the of_drm_find_bridge() call to find
> the next bridge in the display chain.
> 
> The code to find the next panel (and create its panel-bridge) works
> fine, but to find the next (non-panel) bridge does not.
> 
> To find the next bridge in the pipeline, we need to pass "np" - the OF
> node pointer of the next entity in the devicetree chain. Passing
> "of_node" to of_drm_find_bridge (which is what the code does currently)
> will fetch the bridge for the cdns-dsi which is not what's required.
> 
> Fix that.
> 
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Cc: Stable List <stable@vger.kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


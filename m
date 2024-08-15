Return-Path: <stable+bounces-67740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8C99528B0
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 06:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2095F1F232BD
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 04:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9998041C85;
	Thu, 15 Aug 2024 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nSb+lgdN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D43F8F7
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 04:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723697665; cv=none; b=OD7rP+OpVE1Zok3fh19Z++GCVXjmstpRx80QOktGZ2JbyV3NYO7fIfNGU4qjCU9J7TqrW1IvfyF7BJH8S2Hi9xU1lJXjLER6O4j9UwGWTHWMnFrPQ3tFKSyMvQalLfSb1dIowO4kLNYE2d0J209oRm6b91nIeqgZVzPbL6VKAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723697665; c=relaxed/simple;
	bh=UYyZKOxaHpe4EpB6Hayk4JedhlFajE7Z6yEQXgkKasU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5Jm4kwljA1EruqRIDTA8Xt5oVki8730ja+pCbZtL4d084N575XtvZck1vajSc/Tj3j+BW1L/lh+Jqrbp5KCrVSXb68XW6D1wVCXIShRwzy+Jq8XU2B6fyCG5dhx+T9k6L92+s6Z9pLq9Aq8BkHKBibvUWOW2/uINyY1FYBp7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nSb+lgdN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc52394c92so5477475ad.1
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 21:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723697663; x=1724302463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6emxKKtm6uUnETS1KteMYur8SCaMlXe5vmg1oepA5b4=;
        b=nSb+lgdNkvHCu6tt7L4iMCds4yo2loa/h1LZjV5IgISQz7A5DtT6wL7mFXZJxOfBx3
         402Ogen81VxaFKAMqw+DtBL8jcBizIFP9Q1193dh8paxjPIJu9IlNJMFUgsatQ23CsZX
         dw89RaomAHd33kfUjC2DuIclk57fLpv6ZXCEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723697663; x=1724302463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6emxKKtm6uUnETS1KteMYur8SCaMlXe5vmg1oepA5b4=;
        b=ulRl66mILZ0cpl8dwK6XTMTqSKjCQQ5Ddu6jCtqF4dDH4+x5XQanP8n44lE098WhCV
         MCCqS7QBCwxeAMxTnBWFYizppDMmZGkLXtkbeoN0FqLWdD+a3naCs18vxmIiR1bv6SyZ
         6M6yRCVXz3fow36ZghHiSH9qk/a5bcekXXTIk5bWyKR/4lIJfeaooFu+rY+j/78kRyOE
         XP1fdvum9tbxkia7tq7SAmAO267rwRirO23uRIwys2YoSxA+BEqxL4ft0e0ZVydKCsnw
         nRTlgBbn5mCB7TRsY2V0JGn2x5UxLnVEim73f1vY2tAPw26IIY8nFFHCXz4xg+FiDe6A
         2/0A==
X-Forwarded-Encrypted: i=1; AJvYcCX/tah8l8O6Q5YXZATWoiQMPG0WKqiaM89CdXAK0omOXumFGXHtbCPp7i4wWVerWKqbExk18iUoQkt4MZUykREZOgCMXheu
X-Gm-Message-State: AOJu0Yz9g2SvncS6zYixy/pbQ3FJUrWsnfKzZhFDyCpAmePk4JIKYG65
	c0l31M1u58LCv1MFdCwoYotMfYTY7tYqGhJVGJJa9f9zd+wLZGpz9yFeU+IMyA==
X-Google-Smtp-Source: AGHT+IEzYcBX0Rh/SnY38vbMuYJA+fxWetzUM40fw40DypiXm9dq5bKbJUg7z3M3f4YKGO2I4wky9A==
X-Received: by 2002:a17:903:1104:b0:1fb:415d:81ab with SMTP id d9443c01a7336-201d63ac08dmr66910325ad.20.1723697663300;
        Wed, 14 Aug 2024 21:54:23 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:745d:58f7:b3cd:901f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0300844sm4133125ad.47.2024.08.14.21.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 21:54:22 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:54:19 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] thermal: of: Fix OF node leak in
 of_thermal_zone_find() error paths
Message-ID: <20240815045419.GC255011@google.com>
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
 <20240814195823.437597-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814195823.437597-3-krzysztof.kozlowski@linaro.org>

On Wed, Aug 14, 2024 at 09:58:23PM +0200, Krzysztof Kozlowski wrote:
> Terminating for_each_available_child_of_node() loop requires dropping OF
> node reference, so bailing out on errors misses this.  Solve the OF node
> reference leak with scoped for_each_available_child_of_node_scoped().
> 
> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/thermal/thermal_of.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index b08a9b64718d..1f252692815a 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -184,14 +184,14 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
>  	 * Search for each thermal zone, a defined sensor
>  	 * corresponding to the one passed as parameter
>  	 */
> -	for_each_available_child_of_node(np, tz) {
> +	for_each_available_child_of_node_scoped(np, child) {
>  
>  		int count, i;
>  
> -		count = of_count_phandle_with_args(tz, "thermal-sensors",
> +		count = of_count_phandle_with_args(child, "thermal-sensors",
>  						   "#thermal-sensor-cells");
>  		if (count <= 0) {
> -			pr_err("%pOFn: missing thermal sensor\n", tz);
> +			pr_err("%pOFn: missing thermal sensor\n", child);
>  			tz = ERR_PTR(-EINVAL);
>  			goto out;
>  		}
> @@ -200,18 +200,19 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
>  
>  			int ret;
>  
> -			ret = of_parse_phandle_with_args(tz, "thermal-sensors",
> +			ret = of_parse_phandle_with_args(child, "thermal-sensors",
>  							 "#thermal-sensor-cells",
>  							 i, &sensor_specs);
>  			if (ret < 0) {
> -				pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", tz, ret);
> +				pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", child, ret);
>  				tz = ERR_PTR(ret);
>  				goto out;
>  			}
>  
>  			if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
>  								  sensor_specs.args[0] : 0)) {
> -				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, tz);
> +				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, child);
> +				tz = no_free_ptr(child);
>  				goto out;
>  			}
>  		}
> -- 
> 2.43.0
> 


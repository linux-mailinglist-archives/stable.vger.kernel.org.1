Return-Path: <stable+bounces-67737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6454E9528A7
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 06:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F92C28593D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 04:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0FB3BBD8;
	Thu, 15 Aug 2024 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Llh/s1xx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9D38382
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723697301; cv=none; b=U3XZ+8icYla5bmSSL6i+CbpsueznQTmmoxSfJgAscdG0qy5pHmFH7LhzIJseLO/HmOTCAGxLOkVaUBtz2i9RvobLrxHTq6agTD9iEDzE0wr4M+Ij4TpGPbFYsYaH1YXZDk98KwzJVgbnBUTKooagwkPBpgdjNfFs6vEIORgdS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723697301; c=relaxed/simple;
	bh=1H8OSJlJ5N02+gXkYla/orQDMo/rMWVcoHt8snd/BFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBbN5V10Goh5+nQ2xNNFll7IDDvC/JbHKj/Ofe9OWhdJO+Rrs96gJr9cimYWtgfRm4Z3qRpKPAbtcUNMP364vLZnlVp4PWb3j8IgmL/vMYEkuer0++P9yHi8740BXLFLvDtw4BDMo0P5DDsxsxGaSsoGs2F8p/VaIkIQY03cqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Llh/s1xx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so452960b3a.1
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 21:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723697299; x=1724302099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hmiS/G0zKAC5tA9OzOxytrtCGZMWxkCbcEk10y8Ir0=;
        b=Llh/s1xxcFTDiSx+c+Y2xt/dW1sHZniqBxcFg7DkO9kc06Vc5NG7p/Yh0zFzbctfRL
         Mrw/n4SoRlKArZmDhJw9q2N+6oxkR6k+UdxfsD76kNaBe5Bq/DTUJ2A+MRZlKKtoS5B/
         lTQ2865e5zzXSJP/Oy2hvdK0Ha/Aw+QoSZmXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723697299; x=1724302099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hmiS/G0zKAC5tA9OzOxytrtCGZMWxkCbcEk10y8Ir0=;
        b=nwo4xK5wOixvf3bMKoQRoLX1CQ4AyeVp2mHUtSI41snUEQOWdg9aKKq03ciHIRmJaI
         3ihwhX2LjirocPzpKii8s40ljJ5qo1OcMUzu16bbCFbBOuGj8MsOSleVM/QJ+S1uMvYG
         E7TwYNqqWzJAv7sDXDIqE0rIz6M3I1M42HNN1Fq+oDkkYV/OucHz2vBiZ9kPhqY0zJfQ
         F41wBfVnaH+pflOJGcfL2+gKlU7lyHwRExm2PlPm6XVhH+CkCCJgbbYoo4s5u7jvUrXc
         KILRLcx/YT3zPiGoIoFChbBWlRGwSsBxznRC1lBa6hp/Jis9ur5HdHrgCwEp9xKhWFCB
         RiXg==
X-Forwarded-Encrypted: i=1; AJvYcCUixBd3whd3HqlwIQj4I3Rvock/4KcPhuza4PRaVD7eicCD2URIOrU1gzWbFV0iDHo/XyKsbd4dD4qK9aEYuQ43tLLFXbml
X-Gm-Message-State: AOJu0YxAcUWwnFD/KzpyvPRo/yNDmI3ExdskgfvqNSh8KoGHYT3XpMtX
	49mioEdVJCKDaiajoRq65WNCBpHdYGE+tie7LzrCX1XcIGDXMsgC2GiypNjM6w==
X-Google-Smtp-Source: AGHT+IGx1lP4TlGrHuh23iB/99xzj8kXmWkUac5JJk27ttUx5Ghve1MQJhTg2y2w5CMBWQpQv4QJXQ==
X-Received: by 2002:a05:6a00:198e:b0:70d:2892:402b with SMTP id d2e1a72fcca58-71267101635mr5313447b3a.7.1723697299019;
        Wed, 14 Aug 2024 21:48:19 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:745d:58f7:b3cd:901f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae6c0bdsm383551b3a.90.2024.08.14.21.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 21:48:18 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:48:15 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] thermal: of: Fix OF node leak in
 thermal_of_trips_init() error path
Message-ID: <20240815044815.GA255011@google.com>
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>

On Wed, Aug 14, 2024 at 09:58:21PM +0200, Krzysztof Kozlowski wrote:
> Terminating for_each_child_of_node() loop requires dropping OF node
> reference, so bailing out after thermal_of_populate_trip() error misses
> this.  Solve the OF node reference leak with scoped
> for_each_child_of_node_scoped().
> 
> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/thermal/thermal_of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index aa34b6e82e26..30f8d6e70484 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -125,7 +125,7 @@ static int thermal_of_populate_trip(struct device_node *np,
>  static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
>  {
>  	struct thermal_trip *tt;
> -	struct device_node *trips, *trip;
> +	struct device_node *trips;
>  	int ret, count;
>  
>  	trips = of_get_child_by_name(np, "trips");
> @@ -150,7 +150,7 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
>  	*ntrips = count;
>  
>  	count = 0;
> -	for_each_child_of_node(trips, trip) {
> +	for_each_child_of_node_scoped(trips, trip) {
>  		ret = thermal_of_populate_trip(trip, &tt[count++]);
>  		if (ret)
>  			goto out_kfree;
> -- 
> 2.43.0
> 


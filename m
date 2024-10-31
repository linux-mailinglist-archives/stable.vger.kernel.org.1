Return-Path: <stable+bounces-89444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C59B838C
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 20:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBB1281DB2
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB0D1CB33D;
	Thu, 31 Oct 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9FvG7U4"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF811CB50B
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403476; cv=none; b=LNiqbg9pXa8rmUI9gMHopYUOYJtK1ZQ9XZ03wo3HlqkPJwbnkXG20/cZkW/h2nLA1H6ZAx08Z+lv7r1VkcjvGJjkUACfoi5137DAddJSs4QovWgBFdHWj8ggjQGnzybQpkkROPdlBJoKtwvcFyPAgErbef4OmlTnoAH0FFh0RZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403476; c=relaxed/simple;
	bh=vphe9batM7Bljg4r3WddxRhNeTXwXS8zELGRYaO51kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+qCm4NyIqtdc7UmJlB0VNUhzRgYQ+qVGsdm72USH5zEJWyH3Ovk1o0xkVC4IKckn0QDlV6AOle8pdo35rYNydgXkzWHYMDekI2kq0La6yi6/LgT2DHiHQ02mSUIEzbN30pw1h701BlSJwYlfy55K4d7vb8gz4KQAYP0mChn+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l9FvG7U4; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so13075281fa.3
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730403472; x=1731008272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xY8BKpUlX8dbSzUZiaXQFiaPQ0R16ABPPrXeZ4QjIzY=;
        b=l9FvG7U4GF2WR+gAdMknzzTwja92I2L4cmYJ+heuyoY6j8/LhtfxJDnsyo0xpemhKw
         4VUeqykQ00M1FEVmCAU8Lu3jqX5zI/zTiuU4jzQ6WOE1G/Skg0UPiNjcIOEg6VTps4SD
         DzL46hHuCsHx3ETk5nDeOiWOGmUjRVOuNHL3PWQJ2RLat8G3Xwwh0WAF9Ray6mRZVNyx
         ui8oROuRwVy6YGUVXHRC61e7p+Nzm0iM07STHlxJHtNM9CEYUfGzA6ZLO/8NjLVweSBI
         W0ko8Oto4I2/UuepxaviSx8YGigp4awZZ0f1o8u5j/NdEKZaUKvCSWcFj7U8U+UugRU9
         m7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730403472; x=1731008272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY8BKpUlX8dbSzUZiaXQFiaPQ0R16ABPPrXeZ4QjIzY=;
        b=rP643hxUgD2wX9OEj9JH7IjD8je2EiOXO9TC7tj63OI0OPI+1+6QpiPO0RbmtG1+6G
         U1AHb2Yqp/Li6z+vxerXgrNzEpHGQa+0XG1pe+A7lOLo68JwTBnU0HkGyJ8+DYHP2pml
         HnwGcZc+1qhHJWBMC5CCPhVE0k6MKQX3KarGp6fGR9ByJzWwTL3kvtRW6GTvBGcfvjN+
         rESOhA9hAtcwrNB9PtOD4Jno4gfsWsh2FGXYt6/srmcr+E34akt8pwhSCQ6rUtxGFEX2
         kLpq2NXrHLeYkIZl9NSUymxDtTkEhjURu6rHMVXP5Rj1frB079AyO/YuBsjeNUDjCUG1
         D2jA==
X-Forwarded-Encrypted: i=1; AJvYcCU6/JE+U58vaSmOJaTAhgiJ7o2PLL4UTUCgmiVH6roJVJ9iu4CYY50mUX1PB9oGCA2ZzlYff0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2TFolQu0lRJkshhgBPTLHwBQqhpM5HzawzDMO4uwk59OYfy7
	1THiLzdJmpDa7DRvhaZCKVexYHpS48QxWbocO7rUXTd7FLdpsycy6jS8kxPMWCo=
X-Google-Smtp-Source: AGHT+IEEfUmTLPeg9xVuEZGEbyZoSx7BjCxMcZYz1YD+L+1zvJUGzjkwJa62fHfBLyTlAdyjmcsXwg==
X-Received: by 2002:a05:651c:2229:b0:2fb:6027:7c0a with SMTP id 38308e7fff4ca-2fdec4ca559mr25802861fa.8.1730403471954;
        Thu, 31 Oct 2024 12:37:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8c390csm3099771fa.112.2024.10.31.12.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 12:37:50 -0700 (PDT)
Date: Thu, 31 Oct 2024 21:37:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: it6505: Fix inverted reset polarity
Message-ID: <5eic3qpeocp54my5clu3umigog6fe5zs5drpbyzpholmalcmcw@mh25vgvxd5tx>
References: <20241029095411.657616-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029095411.657616-1-wenst@chromium.org>

On Tue, Oct 29, 2024 at 05:54:10PM +0800, Chen-Yu Tsai wrote:
> The IT6505 bridge chip has a active low reset line. Since it is a
> "reset" and not an "enable" line, the GPIO should be asserted to
> put it in reset and deasserted to bring it out of reset during
> the power on sequence.
> 
> The polarity was inverted when the driver was first introduced, likely
> because the device family that was targeted had an inverting level
> shifter on the reset line.
> 
> The MT8186 Corsola devices already have the IT6505 in their device tree,
> but the whole display pipeline is actually disabled and won't be enabled
> until some remaining issues are sorted out. The other known user is
> the MT8183 Kukui / Jacuzzi family; their device trees currently do not
> have the IT6505 included.
> 
> Fix the polarity in the driver while there are no actual users.
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

The datasheet describes the pin as Active LOW, so the change seems to be
correct.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


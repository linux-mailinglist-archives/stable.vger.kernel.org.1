Return-Path: <stable+bounces-41452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AE18B276B
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 19:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315FC2812B7
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5220114E2CD;
	Thu, 25 Apr 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KknbITIv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0914E2C9
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065327; cv=none; b=b2TMq29BNoC3Y2U8vSsMj963QMOmghNdpfE4TX1nhKqWXga823SDcO0cWDn3hRcb5lBqKhY/CYw4GnGrdnrxViv/iy9L/KKZlID9BrWz/lejXcuVWpe6yKaI9ls+pS7m6hAsZiPPibvoeoStnsHVgFZfYYSOarXFTYprC0gmEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065327; c=relaxed/simple;
	bh=keQGh11L4ASmhAbfLJCprZcvvRwnGddM3OJi+dbRQ/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvBs5/Ufq/EYKxLoyykg7Yh0PR79z4DhLaQtBU/gP6XUslegIAw4npGwU7q4Lk9XAW4SezIAazM951FLCSYiuYDpXSLomfeTvTdH/a8Hi46k+HuZijds9KAgue5CgjORIETuu/qOkrnNptEiHeM7/VWuyKp2Vzwzf6SibtAUN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KknbITIv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso1140561b3a.2
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714065323; x=1714670123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1JLCe9OgKQpwj7dtaGJUIZ9L7mQbrj8lQtYz3ctHGE=;
        b=KknbITIvBuVa4J9uv5RbfuoaHwuFvKKM6zIvQO2qP7DSLbzuuaF0nj0ncvdbKlTXBr
         HKPnTxdWzG7u4pjvaCs6a2lHgz3vw9jm4npLq9MMEd8HO1nzbOeYDUhrpZExy9vNWpYr
         QgMebaw3bE3FcuRW2hdO4Nae9B2CICNzxFlGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714065323; x=1714670123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1JLCe9OgKQpwj7dtaGJUIZ9L7mQbrj8lQtYz3ctHGE=;
        b=uRv9J5eXVSysMI9nUtGeKsye0kYc+uzFGhNyVX5IdMSXarlmGIE1SghElNkFlnw68r
         XKdShkpg5GTzJfsiFOAVjZ4bUYfDeMZRKdikk8oEiS3oiAWsU8Q3tznB89fhfiOnjr9h
         uu5nesSf6xEYYJJusCsdFHtaB7d9kNl6/sLRRJk2tdtsBQhZkbME/P6FAd/kz5/vHpxP
         OYNu50o0kttMXox+JVUvnGP6rwKUtZf4F0MpfY0P1BDcOUj/qPdukm9fsvPKZMhxKTKl
         8kSjFgtxd9xDN5bu42imUQ1eMWwML7ICKICRYzz6lG1bU+pwb9pOxQDgOckIMWPB3e+R
         W84Q==
X-Forwarded-Encrypted: i=1; AJvYcCWM0vgeBg6FcFRYbORlr+z8UrMh6XYDI4c23/rR5nmZRDi7XxjjMuOC9CEslIZ3OYhp24gJXRE0rWr7lVaqV6v91vt7jrsg
X-Gm-Message-State: AOJu0YxCanKsFOr4c4gZqfPxE95y4XZ0SN8RY9FFhJOeTGIWzQ6QDVWU
	nD/wx6EhmvQweBymr0Qemk1UBB/GU2hVJHbqp014wTUuOeBT0KC09jluzufV6Q==
X-Google-Smtp-Source: AGHT+IHdAL2pUCcpe/Rwp2MmAw3VaSPub4F1WVpc3ytbvH+LpXMd2WcDJZqLoubA0TgHiGRSKS322g==
X-Received: by 2002:a05:6a20:5b12:b0:1a7:aecd:9902 with SMTP id kl18-20020a056a205b1200b001a7aecd9902mr294646pzb.49.1714065323492;
        Thu, 25 Apr 2024 10:15:23 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a7-20020a654187000000b0060013d7c463sm6433305pgq.72.2024.04.25.10.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 10:15:22 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:15:22 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, patches@lists.linux.dev,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: bcm: dvp: Assign ->num before accessing ->hws
Message-ID: <202404251015.23D4949BCF@keescook>
References: <20240425-cbl-bcm-assign-counted-by-val-before-access-v1-0-e2db3b82d5ef@kernel.org>
 <20240425-cbl-bcm-assign-counted-by-val-before-access-v1-1-e2db3b82d5ef@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425-cbl-bcm-assign-counted-by-val-before-access-v1-1-e2db3b82d5ef@kernel.org>

On Thu, Apr 25, 2024 at 09:55:51AM -0700, Nathan Chancellor wrote:
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer about the number
> of elements in hws, so that it can warn when hws is accessed out of
> bounds. As noted in that change, the __counted_by member must be
> initialized with the number of elements before the first array access
> happens, otherwise there will be a warning from each access prior to the
> initialization because the number of elements is zero. This occurs in
> clk_dvp_probe() due to ->num being assigned after ->hws has been
> accessed:
> 
>   UBSAN: array-index-out-of-bounds in drivers/clk/bcm/clk-bcm2711-dvp.c:59:2
>   index 0 is out of range for type 'struct clk_hw *[] __counted_by(num)' (aka 'struct clk_hw *[]')
> 
> Move the ->num initialization to before the first access of ->hws, which
> clears up the warning.
> 
> Cc: stable@vger.kernel.org
> Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __counted_by")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for finding this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook


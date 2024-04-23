Return-Path: <stable+bounces-40565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B18AE1F2
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D1D2829F8
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B4360BB6;
	Tue, 23 Apr 2024 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crq1AuMC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A05FDB5
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867459; cv=none; b=ra/3r3nv+0FWm/wVTEIrgbfiWs9xHKl48WKFSCucAKu7JESIYzCiACnYs5YixeAdjfAhJpL4faGQdGpFD6lshTUxMlNUqzK991Pm5Bu8/2mM55tFk28nvo/s1O40KVBlRdJyBq5sKirDLLAFdW9nHzRIVtn88j66iJsFOKg3CNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867459; c=relaxed/simple;
	bh=q4VWRz/40QiECpb4Mc718+dcBLauo45GEnaZwLcwvDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLQzuY8cwoF2btgbjUPItNGLCLEcDSlHqANaegZy9eXvluZdFDjF18oU6CxsrFNnPsI5qyymrGl0RXKewAmtx2sV8r6zTdepLE4yY2Hty1AKRDgcIKkjQD306+1sF4xssPbAHMYNpbBnPIjSKYHFMqUzDSwzbtkF/wdJC1jtGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=crq1AuMC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41ac2d9bdddso2560035e9.2
        for <stable@vger.kernel.org>; Tue, 23 Apr 2024 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713867456; x=1714472256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WSIhEkyuGlAKLZqnsx6pwNHAFthAMdp875SAIfIKU9Y=;
        b=crq1AuMCn0QTY/DMPLUJ6UahTbupEMnlZtjK6ru0mhNRpQjZkSyIH8vacgO3G/WxZ9
         84D/bFS8nymisGiJ+TVpXMKn/TmNg3Vu4LWYpJNz2encXBuvLUQNaXwWM2XxNi/LCvaQ
         mflJgJdIQOXFbwq7A/KVWMLzhn7XJhcLGkLzFXYhIaviAfRz9rmH7l5Z42gqyjtWjk3j
         v8cnHU/EPLgnkgD1c3QnnBNXddUDpcjxdX7ZSBHQP7x0kXQWVUijqEbLjPJ+Ck5xDJnm
         p0b6W9Az6gN57R2x++Hgyt8gf2x33/Wg5va0X2BfvA34GkCy10tSEyeOj230lU8RQ+2F
         9w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713867456; x=1714472256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSIhEkyuGlAKLZqnsx6pwNHAFthAMdp875SAIfIKU9Y=;
        b=PzdKE4m0UlOPl2FPTxmjX/lxjIeGJnpBYIcPw9BuU37yCKp6krezI5ybogLnjnpAsY
         NHt533Y/zUosD95Y6X5x7IpTVA2D9bVlqldoVKwtq1D1a9Qg7JJK/qfgrwlhQdYVkGnL
         vPEwkwsMw6LWANxDiw69C2A773RQRdCKTm3mHSIQe3RmXsZGaM8uxypjg/iNlp316LBb
         vjfkn61ojUbvk0pEOP9aYrVobFiaAMeCTVjcE/DdGJHI83GnbyUDxnUu4JlRic+Nl0KO
         cTxxV6/LgoisWFvlhnrPd6TsMD30N8rIMivviEQkk5MxBQ+RzaY6kfFpqrBSaZ8P83zc
         7qRA==
X-Forwarded-Encrypted: i=1; AJvYcCVqauT/QM1eL0ksPcn5D+z0XaG0vBYHeo4UYD6CkM6JrUX2OjpDmvMCbDRNjtmHJNlXXrXrOCNESst/O3OSOW2YJRsoqEFt
X-Gm-Message-State: AOJu0Yy1t/OfBRjT8alhRuVdt6mGTd9q0hM2NsuxrZru62IlgioanwqP
	GG/5k/w6KrxhWGOzMy8ZdkoP6JRBYOsb1MGhiRmgWFxrO5kTnzp+1zRylDXHkaA=
X-Google-Smtp-Source: AGHT+IG1QPul9ff/agjnfVb1zx0R1tS4WbYQ6DGw9mfuJGNwEgeOG9LlcF2fpwcDxX4nEz6RCXCQZw==
X-Received: by 2002:a05:600c:5008:b0:41a:81be:3e5e with SMTP id n8-20020a05600c500800b0041a81be3e5emr2823760wmr.22.1713867456447;
        Tue, 23 Apr 2024 03:17:36 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b00418d5b16f85sm19577127wmn.21.2024.04.23.03.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:17:35 -0700 (PDT)
Date: Tue, 23 Apr 2024 11:17:34 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] kdb: Fix buffer overflow during tab-complete
Message-ID: <20240423101734.GA1567803@aspen.lan>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
 <20240422-kgdb_read_refactor-v2-1-ed51f7d145fe@linaro.org>
 <CAD=FV=VrOSN8VFaRwH-k4wCLm6Xb=zJyozJac+ijzhDvH8BYxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VrOSN8VFaRwH-k4wCLm6Xb=zJyozJac+ijzhDvH8BYxA@mail.gmail.com>

On Mon, Apr 22, 2024 at 04:51:49PM -0700, Doug Anderson wrote:
> Hi,
>
> On Mon, Apr 22, 2024 at 9:37 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Currently, when the user attempts symbol completion with the Tab key, kdb
> > will use strncpy() to insert the completed symbol into the command buffer.
> > Unfortunately it passes the size of the source buffer rather than the
> > destination to strncpy() with predictably horrible results. Most obviously
> > if the command buffer is already full but cp, the cursor position, is in
> > the middle of the buffer, then we will write past the end of the supplied
> > buffer.
> >
> > Fix this by replacing the dubious strncpy() calls with memmove()/memcpy()
> > calls plus explicit boundary checks to make sure we have enough space
> > before we start moving characters around.
> >
> > Reported-by: Justin Stitt <justinstitt@google.com>
> > Closes: https://lore.kernel.org/all/CAFhGd8qESuuifuHsNjFPR-Va3P80bxrw+LqvC8deA8GziUJLpw@mail.gmail.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_io.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
>
> Boy, this function (and especially the tab handling) is hard to read.

Too right. I even rewrote it using offsets rather than pointers at one
point (it didn't really make it much clearer so I dropped that for now).


> I spent a bit of time trying to grok it and, as far as I can tell,
> your patch makes things better and I don't see any bugs.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!

Daniel.


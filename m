Return-Path: <stable+bounces-74115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1025972A87
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2FA1C24163
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1917CA1A;
	Tue, 10 Sep 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="LvOXJ2qr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B9817C7BD
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952964; cv=none; b=Z1vN7pOn8VyaftPsgqoDuMxXnqwHj82GJXvjL5GWhlaf1nRR735/MK4VW2UL11ojIXHqq5PrPkGWLs0LQ7NvVrVPEWR0Qyj8PRBeMaxMD1rw+dLmixdrFuldQVONsFwGey+YIfAqYj49I2DRqB3kM1XNxMo4VmYX9ptsvp5ksoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952964; c=relaxed/simple;
	bh=SpCPdaf+rqMdpwxcYuM94rsX5LB7bRciqtjUhbHrjD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0Iacuo8d9oFu9FSaE1Pu+PdJFRJaviNbbIk5Ep0cdakEQA1B0DYQEn4UNvHvyQ1BCmar75abZxkC1uU4vOOfmfe9Fi0on0gEUT3GKyvfzoTgmnzoqDe5+a5nEsERzaKr2H9zzeb82id1M8GMTMBvutcbnOxV0paIB1XWalws8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=LvOXJ2qr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d60e23b33so223154066b.0
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 00:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1725952961; x=1726557761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t2XzcGJ9CHpUVmI2Qjvu0h7RfZYDHRIyC3QcUD62zzQ=;
        b=LvOXJ2qr5ODsTpwKsXlIRZU7PeIiZwaWcry5ekJS+bAAOYKW5lmGZ9gYKZhx863r28
         WKMnifGvNErZ5E++Jv3RpBKJhFsc3t2jr2wwK1pSGzMQ1Aw7HHJaP/g1Rb8FuvFEYvwi
         h5Czfg61LE8Ey4yXTmPMmakcESDpiocl7TECM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725952961; x=1726557761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2XzcGJ9CHpUVmI2Qjvu0h7RfZYDHRIyC3QcUD62zzQ=;
        b=SUk+Qv1+kadQSvRBeejx+J5q6Vrp5WwQVVjlTKpQtaZkFmCbBEnBvn1Wkqe6xMPe6k
         gg2bV+2HjM+q/GT+L15uJNvnsj/Sdpnes7q0P/qcObNzof7GRBD7B7jgSfgIQB5ZYkZU
         wLdDNW1eNDPsV/fbBYQsu4BTygw1SHO4VikgslIcy87v02wfF4dzp9bvjBb2AbYyQcvm
         yxg0oQsNyGyH1VbN/JQxtfsOZLMYcVfXOO+sCYlCxhbgCEU9RLxt0F6GAf3mgxTU6jt0
         9E0ePrCjLR4OYjuPTUAErOD+biz56Z1N/sRnAJBC+3CrhpwR97m62YVAHbQBD77gCw64
         WLHw==
X-Forwarded-Encrypted: i=1; AJvYcCUkRCfLt3vqDii2xDSy339Nz9De5cSQn+vA/xx+5peCv8et8mcZoYWz4qZPMfhrxE1blYkUoys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9t8gTwTQwGN4W58ozPdFwxiOMQzKbtPTiMU2JodMQ8h3doifD
	PlE5QieryKaWJLc5jWag7suo16YBO+GlX80zPjcAr5OFXerYWsm0sqK783nAsBs=
X-Google-Smtp-Source: AGHT+IEguAdmxCBaR1QB8kCKr4wvM2lfEhrwmL0iuSI4thRN/LxomXCTbP9/stpoAL4vqJLfL4K0dw==
X-Received: by 2002:a17:907:3a96:b0:a8b:154b:7649 with SMTP id a640c23a62f3a-a8b154b790dmr817815766b.15.1725952959944;
        Tue, 10 Sep 2024 00:22:39 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ce9277sm447915066b.149.2024.09.10.00.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:22:39 -0700 (PDT)
Date: Tue, 10 Sep 2024 09:22:38 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
	xen-devel@lists.xenproject.org,
	Jason Andryuk <jason.andryuk@amd.com>,
	Arthur Borsboom <arthurborsboom@gmail.com>, stable@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev/xen-fbfront: Assign fb_info->device
Message-ID: <Zt_zvt3VXwim_DwS@macbook.local>
References: <20240910020919.5757-1-jandryuk@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910020919.5757-1-jandryuk@gmail.com>

On Mon, Sep 09, 2024 at 10:09:16PM -0400, Jason Andryuk wrote:
> From: Jason Andryuk <jason.andryuk@amd.com>
> 
> Probing xen-fbfront faults in video_is_primary_device().  The passed-in
> struct device is NULL since xen-fbfront doesn't assign it and the
> memory is kzalloc()-ed.  Assign fb_info->device to avoid this.
> 
> This was exposed by the conversion of fb_is_primary_device() to
> video_is_primary_device() which dropped a NULL check for struct device.
> 
> Fixes: f178e96de7f0 ("arch: Remove struct fb_info from video helpers")
> Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> Closes: https://lore.kernel.org/xen-devel/CALUcmUncX=LkXWeiSiTKsDY-cOe8QksWhFvcCneOKfrKd0ZajA@mail.gmail.com/
> Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> CC: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

> ---
> The other option would be to re-instate the NULL check in
> video_is_primary_device()

I do think this is needed, or at least an explanation.  The commit
message in f178e96de7f0 doesn't mention anything about
video_is_primary_device() not allowing being passed a NULL device
(like it was possible with fb_is_primary_device()).

Otherwise callers of video_is_primary_device() would need to be
adjusted to check for device != NULL.

Thanks, Roger.


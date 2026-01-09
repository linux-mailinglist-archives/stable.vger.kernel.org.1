Return-Path: <stable+bounces-206443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F52D088FF
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 11:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CB0C3023D66
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5823BF9F;
	Fri,  9 Jan 2026 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STg+EjJh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s2THF+O7"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAC223DDF
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954667; cv=none; b=EfZogR6nC3XOFyLSt9tZ2NdTdTlXVyrpy4bDOSIODClQfYqUr5N3VzrNVYdB3zE9+8QGy6cxC4QqrVN83ce75MHxFnzkRp6vaUazjWALpMToi4JfSurih1q2kvI7IOb/Pld/IHnMzcEA2B4tORxk2hrXQPFQ+T/EOyLCOXdhOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954667; c=relaxed/simple;
	bh=zDDwfQtnF1HziZxtkmsmfscNv0331XpYoakhHrBniDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AcJNAnwYw2rOTE8kknW2qWjzZEtpdnWzGdX+xdFYNrn4ag22i7ZoGiOJzXBrLlzwKkTTkT7Y/bc0/O43dW7a/eb+DA79X0/srpsoCRxta3lsjvOGC0Q9KjrgWKvaXIaKrEa6FgmTffZ2oDaWqV6NNlF2aYV+v9HJTscM70Pu46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STg+EjJh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s2THF+O7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767954665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fmV/NKJSbEeFZm+j3DpikZoea+NQWkrQbLuu4uv5h2A=;
	b=STg+EjJhrSnfeBTLsm5e7qP08aGLuZDi1YIWrOjtacN9tVc5TtaZwyMkKIvBsSKZvYrYlQ
	P7uXU4/FBFew7bysO8NGMoNaj5h3nFmUay1aS7ePP4GCqXuVU1PVXsL6tcASW2Ma0sUzX9
	T8yV+QK5JqqKY9Il/N64cxhlf4atNdE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-T2GZrz4aOJuzd7LezWZtgg-1; Fri, 09 Jan 2026 05:31:04 -0500
X-MC-Unique: T2GZrz4aOJuzd7LezWZtgg-1
X-Mimecast-MFC-AGG-ID: T2GZrz4aOJuzd7LezWZtgg_1767954663
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42fd46385c0so2367347f8f.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 02:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767954663; x=1768559463; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmV/NKJSbEeFZm+j3DpikZoea+NQWkrQbLuu4uv5h2A=;
        b=s2THF+O7oJdxJGMZ8mUblMKcGH23TVQn/D3UjOUuYprEMawuI7tzTezJxN4l0AbSor
         MPBCPKRgQYGnpQ8GfYRwZWM8ODUEaavzhuGiffMQuc4L1YYs5iDFXDD5qgJbpenv1JUY
         zs1yE+Y4V+drUGhm16u0+zhbBHHiqJRdkbjdh3eWmW3R4H3mIl6u6w5zEji+96bBqIg+
         DV+vchCt190gN28LzD3HaaOWpwqbdIqqpbflYngBTsaRHSNSgd3l3ySsTjehVoszuzBQ
         Xq0SzRJ+t4NTJceHyizO6lECZwlKNTeH/qZU6AcpW7A9BS1xNjBKOHGhUWPICd7H562w
         tBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767954663; x=1768559463;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmV/NKJSbEeFZm+j3DpikZoea+NQWkrQbLuu4uv5h2A=;
        b=eVpsnsjNT3J1QzE/tngvpeVelHoKUQDFsptYUSHgUsJtBWd1wArQdL0ySYPp/9tgkb
         8yKHHfGu44pb039Af/KTYjIvQdQWJw03wJu9/Z88rZCaI1ImJ9a9lescSHn2umAyeCkH
         PcQNhyA9iLe7zgxjRJrmjPnmdhUjcWE2CDkvdRmdSc2T2chuELJbEGf+uryAkZfmKex3
         6w9YUjTJJ6KKJnvR5N4WYOMpNkFnpjAHt9xGb3y8I3Vfgk67vAu87T2Wf3eUxTUjTNCP
         16Qw3hDBT2iQH4QRHfk23/84CyPZV/e1Aro0zqiNEjQtbnkqRGlHvAPmmN5yFJZjRKNO
         2ILQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVfJyKERoHYHirfRczshs1tpTi9GqNX1aoj1RK7uNgLmZkL2jpw5LxtbQwcbVZRFhm+FZnojs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9P0bpDWTHe3xp70/QsiiYxroDKKFXdDcSS5GkTlTZZ5jZV/H0
	Rt42aGKKGJFmbL7UQJ07sjEHgIWpF4LOHf10MLqsQ7CACQMI6ExZbIrh8O73nRqRJf7TFZIl8jZ
	zAJp0dVa2czPkD9YtNjelU6d2sKzn6M6o8Zbk6cKgYDFEYXLtJctJzJ+5Lw==
X-Gm-Gg: AY/fxX6KrJkcmxk1KuGdQ9H3yz2j+MqlOIe8plcHCuqJKSHg+ElK296I4PY7ItMlzFb
	spA6fuYRRO+c1XS2GcwcFamljAUQrgaQih9evC7HzeGBI2nKIbmqZToccGB0x7hpY4QdQhiKGli
	Ja2QPgO7xtfmyhtbmuk4ViUYVTVIScwfyc00ODugRTvFlYhmxa/fO9G+9L0nMBshI3u+Jd6yS04
	zI/6UjXIcgaF+qIYujW4TQbbUNcZcOVYYqHpFt0adffcbJGFz/QHYrirlH5x/jPhVRe9CvVQZEC
	Tz8p5A3KptvTqeibo3sbN5CHceIEYwNQM8mG8tu+gxYYDsXexS+BS/2xYtQUwj995Z7Wth1gGkC
	HRgBlm9S2vTpiuzDMowy472Enbx2AmuIchZ0okOiEHxl+D2OthpvIH5EpE+1uagrTkERc
X-Received: by 2002:a5d:5c89:0:b0:431:5ca:c1a9 with SMTP id ffacd0b85a97d-432c3632a04mr10938592f8f.23.1767954662772;
        Fri, 09 Jan 2026 02:31:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4nrg8QB5rJOCXc0Rpx794/pjF2RLlPnnPcBH896+5wFAzWM1R8nKWuTEsys28GWir314rrg==
X-Received: by 2002:a5d:5c89:0:b0:431:5ca:c1a9 with SMTP id ffacd0b85a97d-432c3632a04mr10938556f8f.23.1767954662306;
        Fri, 09 Jan 2026 02:31:02 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacdcsm21659038f8f.1.2026.01.09.02.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 02:31:01 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, tzungbi@kernel.org,
 briannorris@chromium.org, jwerner@chromium.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: chrome-platform@lists.linux.dev, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH 6/8] drm/sysfb: Remove duplicate declarations
In-Reply-To: <20260108145058.56943-7-tzimmermann@suse.de>
References: <20260108145058.56943-1-tzimmermann@suse.de>
 <20260108145058.56943-7-tzimmermann@suse.de>
Date: Fri, 09 Jan 2026 11:31:00 +0100
Message-ID: <87ecnzf57f.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Commit 6046b49bafff ("drm/sysfb: Share helpers for integer validation")
> and commit e8c086880b2b ("drm/sysfb: Share helpers for screen_info
> validation") added duplicate function declarations. Remove the latter
> ones.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: e8c086880b2b ("drm/sysfb: Share helpers for screen_info validation")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+
> ---
>  drivers/gpu/drm/sysfb/drm_sysfb_helper.h | 9 ---------
>  1 file changed, 9 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



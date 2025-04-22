Return-Path: <stable+bounces-135199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C854BA979C0
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 23:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FDA179B8F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF55327055F;
	Tue, 22 Apr 2025 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfMYrW3t"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417F29C330
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358807; cv=none; b=bkr+FlHPcYf8bMqHpK42VHykx0sOFtYDm52g8zdhNu+d8BxUpAfTOrlc7R/lt7xQRqrbjiW9pf1YEh6BPL3ESe6TyQPU9gc7UQ08KPjcoHb7OnTLTYnRwhdcM97rOWSrkF9TyGUvZJTC424ZnYTTpxlf73mXx+oBXEQAEScgWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358807; c=relaxed/simple;
	bh=S59TmCgOdMo/lpLbM0L1SiyeKE3vGFulCSYC4PmPHFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DoFsS4WFT3eP9JLRDttqHKQqQ2d5N0/vbxbLNc1SPNfFs7732By7n/JzDYmWeCvbW/IAEwcDcyswZzaia/5k/sQ/KIUerX8R8v9YOyofm+h+EH/rF5JFfeAzkmRK4e2NW/806FnwpMB+evsX348B8OXtY2tHSb1YhmDZ6u49CbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfMYrW3t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745358804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HKxVbFAIC1yknAhgK3/yzjYTFKqGKsqga8pDfwFWc/Y=;
	b=JfMYrW3tbMTc5XeNkBN11Kh3GBS9udp824JZos5EFcFTHJje3FYGWvXScQj3WnkVArONop
	Eck63vPOOozUotmKgT2ZQyEAlB12NCCCt9Rg+M/MQDLYsILs6TTGVTlyyGm7/oqa/nVWoK
	TxRfsQ9oTtjsuRReJrkHW32QuiQjDOs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-Y9VJ0IsrOKKug2eGmWTcSg-1; Tue, 22 Apr 2025 17:53:22 -0400
X-MC-Unique: Y9VJ0IsrOKKug2eGmWTcSg-1
X-Mimecast-MFC-AGG-ID: Y9VJ0IsrOKKug2eGmWTcSg_1745358802
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so34094105e9.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 14:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745358801; x=1745963601;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKxVbFAIC1yknAhgK3/yzjYTFKqGKsqga8pDfwFWc/Y=;
        b=FNGWjgnuE27k2wvbiwBFhZjYh2tuRcSctEmbbUXG0BIHNN5GqSSR5ysFD4IBaY+j6C
         oQCfLHxvnyS0hOboDotVJQJZqAyGK+Y0tcDBXa8L4qr5LeYml+Ll8p5sOcX4a3eB/TpP
         gvJ+RFlkfGYIe2cn2otUoKq1UjIp42mnjD0i8jnG6OvvPGcW+fea6KaVzagDNBbIsBnT
         Lxuxq3PYXYH2ptvp/gitVVbgVXDagS4D2Uta0SnkynL1QgtCupigllX+0BIVOZ3FyqRw
         TTjpTbmzALEl8lXK6mg1J8QmIx1yiA+AtlqhvBd25slN/lrx9R2Uh6AKTsc6fNgmUU3S
         IGCg==
X-Forwarded-Encrypted: i=1; AJvYcCV8RbYfDfdSEFgiN4ggXJ8FCa4mkV5x5FRrV54zcEeERZyN3h/J04yfyZl4BuvGR0hav5KMkF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJOl44mEz64xRyoJ7NCGg0dAOYsUb+Zh6NY8pV2rxJwy7lqvE
	h4T41cbEo2/WZDlHJhhz4Rx0JbuqfKLo9BjqdUPbRQINzdPUaTosdBMJphSHPVuUSfBWIuZCubG
	6zGetO+Riu6crEgoYARJ/9MunzmKSrZDhEPcMLmn14/6xnNYpLM8xmA==
X-Gm-Gg: ASbGncuCvJQp2iFCQNvoOGzizkehhj64jebpsb7UE0Rj8qq22kb5nLC4CJ6riO+1OSr
	LRoeibqBrl3lJMU1kyBgODT/6EbhGuTvekybpysY1nKbS37OLF8k+YbgNMPQYKWHUIoMlRoIyRZ
	8igpdu1ZP9Oj3v3IgwaK4prhcrRWQIF5o0TBnskPOR5x0g27y+5t5kVK3DMR9IChAuA54CcXkMB
	I1zyGWpfRE42gE2Q62DF1D5gQ9LUvIvjEoJ1D9ct5Zhg3zPqVhuZ4faoCHrowDho3HzQZR5NNPU
	FAIGjLS2dV/q1HPGmjpYI8P9UcUUYCuForsC0v7LKaXJGxCqhiPl9uI5FiJ8w/CyeE9rVQ==
X-Received: by 2002:a05:600c:1990:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-4406ab6ce61mr150642975e9.3.1745358801537;
        Tue, 22 Apr 2025 14:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6/idgdqte5+5OvTZ+lLVQQaqX56tOylPaDJQn0XXifg71bVlGLn6SvNsLKI5H+jbjTtpPIA==
X-Received: by 2002:a05:600c:1990:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-4406ab6ce61mr150642815e9.3.1745358801185;
        Tue, 22 Apr 2025 14:53:21 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d23099sm2637005e9.13.2025.04.22.14.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 14:53:20 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Fabio Estevam <festevam@gmail.com>, simona@ffwll.ch
Cc: airlied@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, noralf@tronnes.org, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, Fabio Estevam <festevam@denx.de>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/tiny: panel-mipi-dbi: Use
 drm_client_setup_with_fourcc()
In-Reply-To: <20250417103458.2496790-1-festevam@gmail.com>
References: <20250417103458.2496790-1-festevam@gmail.com>
Date: Tue, 22 Apr 2025 23:53:19 +0200
Message-ID: <87cyd3c180.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Fabio Estevam <festevam@gmail.com> writes:

Hello Fabio,

> From: Fabio Estevam <festevam@denx.de>
>
> Since commit 559358282e5b ("drm/fb-helper: Don't use the preferred depth
> for the BPP default"), RGB565 displays such as the CFAF240320X no longer
> render correctly: colors are distorted and the content is shown twice
> horizontally.
>
> This regression is due to the fbdev emulation layer defaulting to 32 bits
> per pixel, whereas the display expects 16 bpp (RGB565). As a result, the
> framebuffer data is incorrectly interpreted by the panel.
>
> Fix the issue by calling drm_client_setup_with_fourcc() with a format
> explicitly selected based on the display's bits-per-pixel value. For 16
> bpp, use DRM_FORMAT_RGB565; for other values, fall back to the previous
> behavior. This ensures that the allocated framebuffer format matches the
> hardware expectations, avoiding color and layout corruption.
>
> Tested on a CFAF240320X display with an RGB565 configuration, confirming
> correct colors and layout after applying this patch.
>
> Cc: stable@vger.kernel.org
> Fixes: 559358282e5b ("drm/fb-helper: Don't use the preferred depth for the BPP default")
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



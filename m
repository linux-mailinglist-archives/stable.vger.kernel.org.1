Return-Path: <stable+bounces-185583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF73BD7EF3
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D89E18A32A1
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62D30E848;
	Tue, 14 Oct 2025 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAhSY8m2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1530E835
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427140; cv=none; b=gt2ovQ9bMp+8Xuu6cjCWmtdgstaRilnzCk+dyUKHmb8mxeO8Yik4vsBxT1EwzKjPBjptrqvzLm8sDosjqVc3FDzi6V8CUUMdfVkJ1P+fndHUU8I3/rPFIyKGFX8zdURas49r9IHTosfK7h/KgNr0+cOwdafDQTzN8qjVE9gzfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427140; c=relaxed/simple;
	bh=tIefyQwY7kzYvRvjxqhE/Rg+bXOUCtYqGqMTPTNbhIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lxJzOG2cObLS3zkQX6dmYHt9axotRR+i35qhDQ/Gn8cpgaBdvuPSs8uyKtWbSKNPyPbHHV7epIUoxEuQBor5aj/RGlqgyHED8z7PbfjMpv7s6qzelxXA6+IWpa59fF0yOJSKCaLS6japbjQdVQwSRp8NExSZ9fjakL5+NT/vvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAhSY8m2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTEvqfVMwIkz4DW8+ZLEnZjvY2H6k8QKs9GKfPXMt8s=;
	b=LAhSY8m2ukMvZO5uqLG7eYhIB3xaFp5b5yv8Z0ihyV0YwDloSQid2VPWsJZOvOvL4udeac
	9xfbPz5PEjh1sjOOG5+1nOKTC5D8rMk8kS9Vp7ZDhYim690XGODrWdxD7vV76m0jSIQZBr
	NAyKGPU8S7ROtTSpZQiCAIfN9zybd9c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-1lAzB4TLNPC7cSU486-lhg-1; Tue, 14 Oct 2025 03:32:16 -0400
X-MC-Unique: 1lAzB4TLNPC7cSU486-lhg-1
X-Mimecast-MFC-AGG-ID: 1lAzB4TLNPC7cSU486-lhg_1760427135
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ed9557f976so5251282f8f.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427135; x=1761031935;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTEvqfVMwIkz4DW8+ZLEnZjvY2H6k8QKs9GKfPXMt8s=;
        b=OFHGVj10+oFR1w1IIrQ4K1SeF9l6F21C0WHuBBqHyAj2Sq0B+muRZyFOClmNHlxskt
         MhqmwWYL2r3+QbST49cFzioCm/upKHVfbhDeo9Ce1W2wvS6flIHyHvdrENO6NSNNjfC9
         be4gbGRv4pgTgCxEZ+i9SAvmdlwjKW0l4vS6vssf0diUxYjKu0R39eQn3GWLeEdqi3c5
         /J3fsKi5co6t1DX/I3YKdQyndCwAbVaYwTc3hKDNczNYGDMOC5/05ZNCedyXHsD2SPqV
         VlXH4oofdQgX9piLd89FMNRGv2SKWu4GaqdaOb3/CoNgirvqCP0RY3+cJPj+kMAyeKxC
         RyNQ==
X-Gm-Message-State: AOJu0YzPZzUxckx25YSqZJD5FxLS+IfekUH5Dtp6/hwWnkRZRWgG+WcN
	IrG7OSwhdezmS7UzfX4jA13GUhdWKjzVn+FXmbBKLcldy6DCQixo7JhgzDcVVkOaD577xCmv2hs
	S9lHgWTz1940O06suHRjO77FScRUNu8nwkMDVPSFLRh5FvhNYhikIXDj6qw==
X-Gm-Gg: ASbGncvIsZKmGfQgakjvnajHU2uD5obGkXCYwIbobOEpdN2f2Quvrf7utyYHrn8OlxK
	pVEfVvTg+CevhwyrpEc0o7jTvdya0b3C6KVCBzvpBrk0lG2vzFqPSWBHUa4j23aDiSwUPC2X6fT
	cCjZ5pabymEOErvjfiUCoYGPECaVxYnY8nvn5lJXoinvFrOjf9WETP8XnCWt6c7JxjLw9nkcoJj
	NxeUCj524Fi5cSgqryPQwXFXTvMPTrN2Xkn66bb6vEWc2ur8mlTJaJ2RQ8RFauKWBjByQT62uw0
	hYx55I/f0ruYBe9TS6O1MSA/SdP/JlNDkX3KVmX0d0uQ0kxqf2ZKW6QSD9SvsihgxhoUvPkxgS7
	aJ1cDAD3C9RJLGK0LK4egW8c=
X-Received: by 2002:a05:6000:1a87:b0:425:742e:7823 with SMTP id ffacd0b85a97d-42666ac432bmr14939919f8f.12.1760427134870;
        Tue, 14 Oct 2025 00:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi0EuQ//2MOCgb87kcf43mwyCqeAgLwogfvvpgOqhiAT4wu5KaE/+LX7onRuci9KVtSJ0glQ==
X-Received: by 2002:a05:6000:1a87:b0:425:742e:7823 with SMTP id ffacd0b85a97d-42666ac432bmr14939897f8f.12.1760427134470;
        Tue, 14 Oct 2025 00:32:14 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f2f72e18sm717892f8f.0.2025.10.14.00.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:32:13 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jocelyn Falempe <jfalempe@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/panic: Fix drawing the logo on a small narrow
 screen
In-Reply-To: <20251009122955.562888-2-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <20251009122955.562888-2-jfalempe@redhat.com>
Date: Tue, 14 Oct 2025 09:32:12 +0200
Message-ID: <87ikgiq6pv.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

Hello Jocelyn,

> If the logo width is bigger than the framebuffer width, and the
> height is big enough to hold the logo and the message, it will draw
> at x coordinate that are higher than the width, and ends up in a
> corrupted image.
>
> Fixes: 4b570ac2eb54 ("drm/rect: Add drm_rect_overlap()")
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



Return-Path: <stable+bounces-189223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B63CC0549A
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 11:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D38B64E2ADE
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F51309EEA;
	Fri, 24 Oct 2025 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpXi2Dkb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A9308F39
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297431; cv=none; b=ViDGdM2QWdfUWt8giC1esajAM1yDcV38t9lemmnhOExW2SbEEhai/BEMFf2ZH8+7qN/sANWd/CVnCRKULRSwHLbqLpiPe43MZ4GuGE1/+UoFOK5T9Y75KHUt6GkyqHpMU3jKwM6CXDmP+ntKeuJoal9Oz006cYljQhFJFx+v27Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297431; c=relaxed/simple;
	bh=xwC80kxgGjCA6aiKnh+Q15rnDabTdd9HOg02jhbKQmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c1vDKetogeNzJCQ6Bo0AEZmJhgjW2rc3UiSTaL2fi2/wWb7EpRBIf6QJ0rQofi6iAFZz1JMk9nDdDZfRILq19W9cumrDGDejTxrNe/WSbOhmlQa8THStGN4m2/HN53jCcWJpf4JSWZh3cSa5zsLyeBU+/fp6K9MuPmSzCxJt1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SpXi2Dkb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761297425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TSq+81cUiZb8O293RwSjZvZpm0NekppDqE5YvfNwlF8=;
	b=SpXi2DkbK8zgBP/FUXMRi3HJL7xTKr3jsTmrtHnqWnDPkggH+IdloHmK2JAmG67jGWvlBB
	e9Ea8oLtohdkjxdNC+n+6mFObloI9DkWAj5c83pohpx15KIzd1Vnsn5hqtdjZGvYodbgWI
	DbCoCHoQdHI27stpnylr4JJQCXckF20=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-6Nj1OIUMPB2girt-hQAedA-1; Fri, 24 Oct 2025 05:17:00 -0400
X-MC-Unique: 6Nj1OIUMPB2girt-hQAedA-1
X-Mimecast-MFC-AGG-ID: 6Nj1OIUMPB2girt-hQAedA_1761297419
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471125c8bc1so21723105e9.3
        for <stable@vger.kernel.org>; Fri, 24 Oct 2025 02:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297419; x=1761902219;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSq+81cUiZb8O293RwSjZvZpm0NekppDqE5YvfNwlF8=;
        b=nIeCysvoVTKWmeo3vOCK6mz3JWlu2jbgiLPunQQiRNHFVUb9NY/jgmOejiMVp7jXY+
         Byirkx+/xnPXfF1bH22jYvvXEsiFD01N7H44+8cGec/5N0lnzDs3ob+GbfRGLmoKNXpP
         aM7OCJMmUnOUqN6B5OMTJ4pCuksAfrbVT954sZeN3F/ULX2XcD/iE3PZmPDd37+5+xGR
         h/JjaVkXP4wBOkpguRshCMNeNdWl6nC/7gHio2fngQ/Azj8rGSRN3PVV1whLEoCLW4l7
         hzQOB29GZPZcGvsCBAHiKIIMszVeZ6PcgMvZ/WVifZu+KpDMFPbsTZ5lZ0HADbigLklv
         oXTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTeg65EeBPYZQWOHlNnUirLXTeKSqXDQVzFeqP56x7wOvL1oULZJ1nvckhG+05lREbMna3VJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWbbB1LI3M/q3bnTSv8GMCMpgUTNqmsIB8NloXi/pSVcDlHSo
	j1HHgTM/iX2tNSFKlfa/pYpImWZufYS8FKcxCbfOt90fVVLpvgTXBeZae5fVqmiqCRJQ7ZSr6Vv
	q6mXfuf6pdDhZNJUnTv/grK+pH5e5xne2tNHnzH4h8DG7a9uBXUIDwQgXMA==
X-Gm-Gg: ASbGncvZTa2O9r0I+nXUaCU94IIGTEKIL8m4nAEtm94bIuzGylyCSp6LcdpMr6Ud6On
	p8GpwVtZcL65R95Cp81TehofwTK/8ZP69UEub8KXjdfJ/hjekHC95CcC/MXueyYcBcrbnGaNru1
	smwuuqJOzeFx7sye3NrcfIFPRxbZH/khv4MvIzXf+dNGJMPYOgZM9As/aNfyvEAmK1izZux0RBh
	zkqOcUyHUhIypSB7MaB8/aJ9GaTI8Ozz6aWpNXGuO892RuJ/k6XhcXsq7v55EoQKpYWE/HB/vlN
	XW4HVMD50HmrgJNxddTxQ61+zOM6XXZUe762RbeieZrx/GOJBSCKb5GMskQ6psJu5H4JP6SlBV/
	9g5nwhNXYunDfcBJiTSq4PYrcLuUpJqZisIj4+RWUZgcG5Oa3qR/QUDCSmw==
X-Received: by 2002:a05:600c:64cf:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-471178a80f7mr195431065e9.17.1761297419457;
        Fri, 24 Oct 2025 02:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk/qqQN3PPoawELhMs1hXkX34drDe5aOw5h6yQ+0rtvBQM8acSA/lOqGGSqNXzCUZEDfaiuw==
X-Received: by 2002:a05:600c:64cf:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-471178a80f7mr195430815e9.17.1761297419046;
        Fri, 24 Oct 2025 02:16:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949f0312sm81594105e9.0.2025.10.24.02.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:16:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dan.carpenter@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann
 <tzimmermann@suse.de>, Melissa Wen <melissa.srw@gmail.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/sysfb: Do not dereference NULL pointer in plane reset
In-Reply-To: <20251017091407.58488-1-tzimmermann@suse.de>
References: <20251017091407.58488-1-tzimmermann@suse.de>
Date: Fri, 24 Oct 2025 11:16:57 +0200
Message-ID: <875xc4acc6.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> The plane state in __drm_gem_reset_shadow_plane) can be NULL. Do not

That ) is off. I guess you meant either () or just the function name.

> deref that pointer, but forward NULL to the other plane-reset helpers.
> Clears plane->state to NULL.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: b71565022031 ("drm/gem: Export implementation of shadow-plane helpers")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/dri-devel/aPIDAsHIUHp_qSW4@stanley.mountain/
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Melissa Wen <melissa.srw@gmail.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.15+
> ---
>  drivers/gpu/drm/drm_gem_atomic_helper.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



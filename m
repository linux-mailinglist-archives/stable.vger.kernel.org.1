Return-Path: <stable+bounces-185587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BECBD7F74
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6759E4E19A8
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 07:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A9730DECA;
	Tue, 14 Oct 2025 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4aTsl2F"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BD2D8DAF
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427484; cv=none; b=aPi/HOnsNYtw7ZDWYf9VuycUxoRRPGbyTJAL1b2zZD2LvKWAoQyktBmoDRgWuhH/NA7q3J1EBP4v1ZKlXu1HXT2aDrargXkkG1MF5S+DsUWZ6Jwgc8MnFScw2cEf5iGmyAAt06snZxZLHOcTM6BcekNZtBKHIy0kJUwsC1RKSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427484; c=relaxed/simple;
	bh=9hS2W03OaaDBRq488L5ZeXOwSJoUvpd0BYVLf4iTHzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PLgwBKt3gxLrcGEnj6lBhraJqKpmCUjnrWuheY4O8i9r1bQCwLwUVZIub6kQA3y526N+bpM7NZWPGg8yqoDQZI81UnjhahLZhdYeF4Kw1E45MRye2NWen9KqLgaMuYb32D4jhHbNc/WHzdr34BR/Q8owX2McGyIm8OR4f0oZfwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4aTsl2F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ajVLHYVNTc11NQnF9+qMXQzNmIez+Zi5q8MUvX7v/NA=;
	b=h4aTsl2FABHsAPBWYRnnaTdFmytzq79IkTfCi9WP2R2ayHSLcYoZBkd82Gg1MLHKe54bvK
	HAxmn7pd8UNg7ka5hRawDJB5Y7ZjJuxdlEDc7cCiRE5Gm34iJeGxeNrI/KgRjDl0XGbOtF
	ljvXBvoicPafNkADlundXZNFcfyrIRY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-2-gJ2SRTOaCk8vQsrmC2lA-1; Tue, 14 Oct 2025 03:37:57 -0400
X-MC-Unique: 2-gJ2SRTOaCk8vQsrmC2lA-1
X-Mimecast-MFC-AGG-ID: 2-gJ2SRTOaCk8vQsrmC2lA_1760427476
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee12ab7f33so3192578f8f.2
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427476; x=1761032276;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajVLHYVNTc11NQnF9+qMXQzNmIez+Zi5q8MUvX7v/NA=;
        b=kZRzIDC+vEnmiAmxKHmVWR82ewp0wjP4AnhxdBK/NFbme09jA+aBXOwmNPW66lhS6N
         eBJXyiUnm2D6ciLm5o3nKaqLv4t6GA32+a9GRcYh6HZRJzEO8oeXCMJl1QAFNpYdoKGl
         cYz3Z0dal6hBvXxi0k3McjswXlLkWW0TgSYqFvu3tu6Bt0BS0dQwLAmJcazVLv5zxJre
         0X5BgvnivPIXInhg7w74mi900tYT5TPnDui4gwG3XCpE6eRSvwfPk4hNxpCbYxFYtdeg
         JZVrTuktYR+CPdXIunWz4lYSH6nISaD3WzUIHOGp5Iwe/653SNiTvWAUEURpjQdlp/RT
         pqlg==
X-Gm-Message-State: AOJu0Yxf2ds0Rk5kPJCk073cbCwsAoBTMr63iUCUu1RFpPEbz/vaBK+q
	bJeCM+5BjSFvO2qVaf2bjB10INYZJ4mIKyZeAPBg/yUYWUHFCWdHqqjPDF6KsKQBYbnnnSwBjT2
	MKPOJ94KZhCeruXQ58S4NvMSNY2q4ap2jPmfiLhWH77f+kjh0DWsvsS7LLg==
X-Gm-Gg: ASbGncsqkQqPez5p88kabfrXZXiY7ML+wDuNG9zfFOxEmWz7h6G4meXH+tvGHhgWPJa
	H8q/ZJx7YlTJsDUowQnasfuD2mwVNHM0rQ02YlFrBSbUob17ZVW1k0noZrXpxu5jikPguY3DWVf
	0aVqbQ/Hynj3/bi8qRcmH93xlYJwUszAkhN5p/VgfLkTFkZz09yA+ZmWhCp3GZT+Pk/qabN9W4A
	2P9r+h8VMGCdjRQB4BcXj+NbJTlYrHHeEjLXg+hkKHiaoKtSkXa3bsXUL17IDLmmjpIKYzVb1GN
	Cgw4AeFqCsVrMUAX/gE8aq8jfoeFjhdEhnSIlGdDoIhJKh+XYy0+StsaXcbvAC2KGc8w7L1eH1W
	BqaHEZvX3tqRCzbtjCj8rc9M=
X-Received: by 2002:a05:6000:603:b0:425:8bff:69fe with SMTP id ffacd0b85a97d-4266e8e6c55mr14958364f8f.57.1760427476423;
        Tue, 14 Oct 2025 00:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFakWFpLVIjohFo3FxWGxf+m3faCZnqyMx0D0r3L4Uyua5kzQh9UCZhYel6YlToPfvo+XXFPw==
X-Received: by 2002:a05:6000:603:b0:425:8bff:69fe with SMTP id ffacd0b85a97d-4266e8e6c55mr14958352f8f.57.1760427476002;
        Tue, 14 Oct 2025 00:37:56 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589a21sm22711021f8f.23.2025.10.14.00.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:37:55 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jocelyn Falempe <jfalempe@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6/6] drm/panic: Fix 24bit pixel crossing page boundaries
In-Reply-To: <20251009122955.562888-7-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <20251009122955.562888-7-jfalempe@redhat.com>
Date: Tue, 14 Oct 2025 09:37:54 +0200
Message-ID: <874is2q6gd.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> When using page list framebuffer, and using RGB888 format, some
> pixels can cross the page boundaries, and this case was not handled,
> leading to writing 1 or 2 bytes on the next virtual address.
>
> Add a check and a specific function to handle this case.
>
> Fixes: c9ff2808790f0 ("drm/panic: Add support to scanout buffer as array of pages")
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



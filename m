Return-Path: <stable+bounces-188316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CF2BF587A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 11:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A06E4FF3F8
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752AA2E3373;
	Tue, 21 Oct 2025 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHgfaIFm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0A284686
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039309; cv=none; b=sPv41ulVnTxBaRgFAOYtIGomwKI/yDwPCsJI+0/moNwj9zIaqVbwvspOS8Fl9GyH3E68ZdBmGRtKACC+Ndj4xE5S9l1RWx/3Q6vpla6Y7+jQUVPXWMxImXYs+qhxpjazFUSv2LLOt0hkalECKZmlq55MChICadj+F4NS5+f0IcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039309; c=relaxed/simple;
	bh=l/h5cb+0/LUyVGEvr+WGHekbJqC8VotYimlfk9vdV8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaR5nHNkVlJhpa5NQeowxB8tDRjrsc05ezdSN5XZUhtXDVfCuBRKDVgu+/oaaCoWZAU8S1Z8zfy6ayLUgIJml+5o1fi5Pj8Vpg+KGzwzSOEiGWrhvLhwEUfP2QBAUvMHcDOjIkFcKHqr2gLFWZlyIacBxEbiFTVCO6RnEaSxOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHgfaIFm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761039306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsfpJjNAphnWLSpR/9hQ9zHV9rrWcLBcQx4ViQ+mRJk=;
	b=YHgfaIFmnInkFFk37eeVcwSax2i/hH8ByqU0GV8mYYDSUkUanqNQjHJbT/Oj2C7d2e2t04
	CswuLVjg6rPyvMjPW1KF7N1LcREIIRmOAqaeHkM329/DjhcwIFNjpDuurmXHwirWd8+9cL
	GufjEF/56w5gcZPBwpAPDpbfriOREOk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-r9RevEPXPQ-2SbOcvASMsg-1; Tue, 21 Oct 2025 05:35:03 -0400
X-MC-Unique: r9RevEPXPQ-2SbOcvASMsg-1
X-Mimecast-MFC-AGG-ID: r9RevEPXPQ-2SbOcvASMsg_1761039303
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47113dcc15dso37507265e9.1
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 02:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039302; x=1761644102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DsfpJjNAphnWLSpR/9hQ9zHV9rrWcLBcQx4ViQ+mRJk=;
        b=gHampZ/u2lrI04H2o6zOBOn+hhOgVditB60MIWW7PQlZSFWKt0j1iUXaUUWlfNvHIc
         WdnV6xnkmx6CzqZMrQyHN5mUwJKMvWk5+8PjUVIEAWYLRp8tEytOKVrnNmuAKPaA7788
         Y3R0nWnVBD9DoZiFR4ewjCrEEgiKtyX7l8zAD1DtsFnhCHhCzLPJj0t7/4NysaW4Udkq
         EbcqRpvcZEeISxxCSKScBwmgk0/RehCEaTXKFfl8NgXME+ALil+g95VleBj/cWSSs0qV
         krEvtTSDLL/51eGH1lh+0Mc0iQkMsuAWtz96A3+imWN+DDI2IAsKjJtif7gHVnEcZbFQ
         b2Vw==
X-Gm-Message-State: AOJu0Ywm/hkYvt3KmqB1CpquxrpBfwLOorCBv1ZelGfyAi6BaGaScvJ2
	L9c3VM2aCGIMZncHTW7+LmCNAWwKXC/JG2dahLVVpF5eaEcct3Dk825qIKIeyVK+mDLvAcL2Ezb
	CaZdYMDe17g0BGODNg7e+iJrUyQOdQ73R4y2qjVE/qgVVIN1gqLMRdSeXBw==
X-Gm-Gg: ASbGncvoGkcEzJOSnGjuGEJqPY255Ao2Jk5owTmUWgYcmTDMWDCV8SjDR0Qz3jWchqb
	WxTcIUD3JqYGg0wS0aQw52CcXxRCDL5f7UK9pSlyGSQDnYsen53JqJECYhvbzmC1vEXHiDqOPal
	cpWxyc6rpyJK8ctSAQRUWWcjnZSY+SKTJmOX+E8vQ0SZcY8nRA9+EnQIPmKXV+ICvn1UX9Ec3RL
	nKw2KVl9Ef4bmGZoZP4Fx7KIbuyGU4UrJlFBKumFb31cmh5JCErFZxzBSIJqCa2KaWhp75mGH5/
	yJ+MnwOG25r7+cwe41xmfzXW9aAUdjpx1Y4YsTkxAdr/8wPfZZiYI5jhRuuCzUEX9hZrG+NO/g6
	ZYgbnj/Bn2a2USgU4fBEr948xz4WzwlP0LZTuJ7A=
X-Received: by 2002:a05:600c:4448:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47117912b0dmr121009815e9.31.1761039302607;
        Tue, 21 Oct 2025 02:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt5KLfPmw83SPRT8OisjsvH92UuGC/3O3ChwZqMD9Wd7ly0YlXsAEqC/1kFgopwE5vclnf0g==
X-Received: by 2002:a05:600c:4448:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47117912b0dmr121009555e9.31.1761039302202;
        Tue, 21 Oct 2025 02:35:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce678sm19776843f8f.51.2025.10.21.02.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:35:01 -0700 (PDT)
Message-ID: <f8f1e0ec-46fe-4d71-94aa-bdd081ec35fb@redhat.com>
Date: Tue, 21 Oct 2025 11:35:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] drm/panic: Fixes found with kunit.
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20251009122955.562888-1-jfalempe@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251009122955.562888-1-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/10/2025 14:24, Jocelyn Falempe wrote:
> A few fixes for drm panic, that I found when writing unit tests with kunit.

Pushed to drm-misc-fixes.

Thanks Javier for your reviews.

> 
> Jocelyn Falempe (6):
>    drm/panic: Fix drawing the logo on a small narrow screen
>    drm/panic: Fix overlap between qr code and logo
>    drm/panic: Fix qr_code, ensure vmargin is positive
>    drm/panic: Fix kmsg text drawing rectangle
>    drm/panic: Fix divide by 0 if the screen width < font width
>    drm/panic: Fix 24bit pixel crossing page boundaries
> 
>   drivers/gpu/drm/drm_panic.c | 60 +++++++++++++++++++++++++++++++++----
>   1 file changed, 54 insertions(+), 6 deletions(-)
> 
> 
> base-commit: e4bea919584ff292c9156cf7d641a2ab3cbe27b0



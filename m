Return-Path: <stable+bounces-100890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF39EE4B1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5977E1885F15
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A86210F47;
	Thu, 12 Dec 2024 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9zC0RT+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710C1EC4D2
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001557; cv=none; b=RheXqzeRyC/k/nDhjvk5SmX2pyNxK6VyqKaIB9b5MdJZhFDt5AVpGf2NID6ise5CS0GHPFvMkk9lxe4fnhxnqgh2uQQHSkR+DweIdayja/5e4UvDXU+SQYGVq9Uszc6cNGBQHJ75bcXhnlCuZnzUA9f94SDDLnAVJJm0frvMU8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001557; c=relaxed/simple;
	bh=b17I4wVwDx/N+KOJByIynEV4MjVriLu3Q4f+Xu760Go=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rGW9yLHhhOLIimi6kcu26wy+ENFEdekAS3ubmqZubaIvRsRxjUCzUBt9NJ79unU4tTpsUVPQn4nXjnQOJZOu8MhnIgvTpnll0GP2PY2jPqrDDehOxGBFDo6Ajnk+WJabfk9WtT4Es0IF7C84Hr5lSFHd+7W1abo7Mh4tcsH6+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z9zC0RT+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734001555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b17I4wVwDx/N+KOJByIynEV4MjVriLu3Q4f+Xu760Go=;
	b=Z9zC0RT+nINwz8Owy0jFFCTjB4kE9CBW6iFvzwli1IG0uzvclYYloAcM6uGUuDY99KFQE4
	a9kyQ0QND4mdSEtp5vHH7HKJSdR8GqjhPnxD/odwNeQGMxSbGCSQf69ys666rq7bpXBjM0
	bGHg6zCV8WVLM8ZL4vv9nHUHryuZTvM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-mkS3o0RMO7WhR0zDArXr4A-1; Thu, 12 Dec 2024 06:05:53 -0500
X-MC-Unique: mkS3o0RMO7WhR0zDArXr4A-1
X-Mimecast-MFC-AGG-ID: mkS3o0RMO7WhR0zDArXr4A
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3860bc1d4f1so267957f8f.2
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 03:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001552; x=1734606352;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b17I4wVwDx/N+KOJByIynEV4MjVriLu3Q4f+Xu760Go=;
        b=uQdISCuvarRKpnHACpdq1y1buPnRxRSjYTNq2rqVxrenp42Pw0Ulusn4ocQw86LfC8
         Ql0dUGyioOhYGPF6tkzRlC0x62CmQkd78x2zPcfrEsQ6JukI01EA/hIUySMhmNnaop1B
         H500jPxcWbXUWiuQmCKtW2G3FEfcDtS3WUSSmUUEcN41f/Rfouc6omZlTYtL7ex3rWKU
         sppLS+XF3vrTVFetSAUySKRWydp/BdfDtj8ovTPm+Zv9PStC9d+E5gXOb6mNXc3MpHEf
         xlOqu08oWeEqHqW28O2G3pMOEWAIIVTtV/Zr2FNjhXtYc5JCdyVfaeQsv3MemXntPczo
         5/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXrSotlLe8Lr+0mjeOkd3E2BEvqyH0bnV/ES62j8/Ks9fUbbPybKkjkRxylm0Oynq90EWklBAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeKeW55jnGLeDrPVAw9yXGh2DYdHWtgF+ZxhktJRwPj8BhdN6f
	30PMiewNB06F9txx0fken0jQkBIT87lHnhGl3OFKyHB8U0ucaKI1Sdg9ydPqBYqkZttiGcgczij
	/GdcwhNgHqXrwCBBde6jn00BdFkIEkaA+xU6jaLN0XiCFBxQaV6O1lQ==
X-Gm-Gg: ASbGncsvhyyoj8rQWQhp4i3sNtUkXMcHpaO9XvOHT5wQR65AT4clq87PkafiGA24Mtn
	oqOD9m/LMjbTKf1SfZ3eoulb3zZKgDQNxv7uYCIDyxRwk9aMc3hEn+gmv0E1Oa8bxoXc6w5I67v
	SSUA9vk8uaO0n3hbyn363WLXKXXxkN3AskevH6yuQvGGnAPhEw6G0MYEiNCmhP8Z4MXe0s7B4R3
	D5l7bm+Zbluq8IRcwv7xv6sT0vyH9hlACxZy3jZyJf/57cKs57bXtTLlVF3euazjlz/FFJJ3SY1
	cnpLEocgMFbWDClpeR+EB0YKHpW4YU9YfpUvh0c=
X-Received: by 2002:a05:6000:1545:b0:385:eb85:f111 with SMTP id ffacd0b85a97d-3864ce901bfmr5282480f8f.14.1734001552647;
        Thu, 12 Dec 2024 03:05:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsjNFpuayrSgHHBa1FRUQVFGwVe0rOy1eihWuPgSfYokpYEiwBVfBti8HIe9PDLwRPTSbepg==
X-Received: by 2002:a05:6000:1545:b0:385:eb85:f111 with SMTP id ffacd0b85a97d-3864ce901bfmr5282454f8f.14.1734001552308;
        Thu, 12 Dec 2024 03:05:52 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436255a0d5dsm13244985e9.27.2024.12.12.03.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 03:05:51 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Simona Vetter <simona.vetter@ffwll.ch>, Thomas Zimmermann
 <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, regressions@leemhuis.info,
 nunojpg@gmail.com, dri-devel@lists.freedesktop.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] drm/fbdev-dma: Add shadow buffering for deferred I/O
In-Reply-To: <Z1rBTcM4xbi_jrXb@phenom.ffwll.local>
References: <20241211090643.74250-1-tzimmermann@suse.de>
 <Z1rBTcM4xbi_jrXb@phenom.ffwll.local>
Date: Thu, 12 Dec 2024 12:05:50 +0100
Message-ID: <87jzc5nott.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Simona Vetter <simona.vetter@ffwll.ch> writes:

> On Wed, Dec 11, 2024 at 10:06:28AM +0100, Thomas Zimmermann wrote:
>> DMA areas are not necessarily backed by struct page, so we cannot
>> rely on it for deferred I/O. Allocate a shadow buffer for drivers
>> that require deferred I/O and use it as framebuffer memory.
>>=20
>> Fixes driver errors about being "Unable to handle kernel NULL pointer
>> dereference at virtual address" or "Unable to handle kernel paging
>> request at virtual address".
>>=20
>> The patch splits drm_fbdev_dma_driver_fbdev_probe() in an initial
>> allocation, which creates the DMA-backed buffer object, and a tail
>> that sets up the fbdev data structures. There is a tail function for
>> direct memory mappings and a tail function for deferred I/O with
>> the shadow buffer.
>>=20
>> It is no longer possible to use deferred I/O without shadow buffer.
>> It can be re-added if there exists a reliably test for usable struct
>> page in the allocated DMA-backed buffer object.
>>=20
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Reported-by: Nuno Gon=C3=A7alves <nunojpg@gmail.com>
>> CLoses: https://lore.kernel.org/dri-devel/CAEXMXLR55DziAMbv_+2hmLeH-jP96=
pmit6nhs6siB22cpQFr9w@mail.gmail.com/
>> Tested-by: Nuno Gon=C3=A7alves <nunojpg@gmail.com>
>> Fixes: 5ab91447aa13 ("drm/tiny/ili9225: Use fbdev-dma")
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: <stable@vger.kernel.org> # v6.11+
>
> fbdev code scares me, but I at least tried to check a few things and looks
> all good.
>
> Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
>

Same here, is always scary to review fbdev code but the patch looks good to=
 me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



Return-Path: <stable+bounces-28346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C66387E636
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 10:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC81D2811B1
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F42C6B0;
	Mon, 18 Mar 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcfWPrlt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12FD2C6AF
	for <stable@vger.kernel.org>; Mon, 18 Mar 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755306; cv=none; b=ITgKT12TyjFg6PHtb6ZD2yj8uX71MowOUpsCICPJHheJ0mGdrmeI5l+2c+eZhiG3KF76QtaocpF8gw8ZUMyv6T24Mf8ymtmTCWPgeLJ1z5zzVMspBAdcBEQr44xtfGyO6GYd/3QKQmXIXwpAFCMp24t5mcXuqdN5uaVExb5tB74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755306; c=relaxed/simple;
	bh=a2e19NIrLL15aA4XDReCYJO+B4YHXQsIHrzq0K0DE5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mrKRYpcgF6rOi7XPKaSKRqDA4MwIa60/eCmxuqprjDsFfgzsuRcYo2HnVdHTuFlrmAsWb10OlGUGQKxePkmu8577o+ZCqbxfdDhOVf4jRt4hGsP8GYw5G9i6210VNps4jqX2BuEgB+zBjTFsvKfY8hoW0fCElvjHiEngakerwxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hcfWPrlt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710755303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4y4SgSMn0xhvmoHXkMRxARRoLMhg77gR29I4xBsDe8=;
	b=hcfWPrltXT0MBTCu+JZYE97qEk/6S7yyN5OMLEBsQRrqIbXfDxEEVp26Oo81EYt232PzTM
	y6BSigj7YqlLBJWEp0EwZL4JspcsB8hnjxuesiJs2rAXPeYQyN7u23jz55COgt/GXg0Wvk
	mxVxObivrl5FtAFuetSa++QkrZB4o6k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-QfcCduMgP5S5uPU7257Uug-1; Mon, 18 Mar 2024 05:48:19 -0400
X-MC-Unique: QfcCduMgP5S5uPU7257Uug-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ed22e92c2so1699075f8f.0
        for <stable@vger.kernel.org>; Mon, 18 Mar 2024 02:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710755298; x=1711360098;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4y4SgSMn0xhvmoHXkMRxARRoLMhg77gR29I4xBsDe8=;
        b=uN0GGJcfVQWuMxhuYjIxoPhDS5ZHtCd6xL4rFeg/FQs+EHjwDD1BDDpEC9Fpm7CKTq
         f/6IHvwtOl7z3k/Rq6vghDREkXpTmOuDmr4wHm6V0eJ5AbjndNtdd9eb/b2WIFFNTYfw
         FabuXFESKoyJ+IBvOKSJO0iz6Q7W0tSchWTYyZZCdaKqeBpA16lUQsUvp0ah1JzJgGzR
         KctilVnjVtiAs8IdIfYFRX5bmjKfDgPSDpGt44KDpASa8A32NwS31bnaEhpzXq3CW97O
         mURY+pstZgLpswRPxI67AtyC1lKEluk+HTAgG2q/bv0SVw14hnvXMPSEeeoNTBHObZy4
         6qHw==
X-Forwarded-Encrypted: i=1; AJvYcCUSPSqiSGoJWarfiVrCFW0Swe2vYDj8pMKzTS3y7L5qNrIUCfLxlcG9KeV+nvbsKDpP5HAUEo+mMBuxkT1SOwJ2LZ1jNoPG
X-Gm-Message-State: AOJu0YwPPaxII2fHpMiAZWafQSWv6oM04bReJ1uN7P2wD3KZwJbWS59z
	DQN/uatftBuFrEJpVGwC73sgZIrarGBtrR3b+VZZwN+ApQOZLlAwSRaupEUWXqGYRL2L1itwbBZ
	PffbRyT81oaB34xIcH/KkpHvjtJNSXEx2z1/VKmk8OE/w6trNfdsKXA==
X-Received: by 2002:adf:f3d2:0:b0:33e:8ba7:e53d with SMTP id g18-20020adff3d2000000b0033e8ba7e53dmr8843525wrp.7.1710755298493;
        Mon, 18 Mar 2024 02:48:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWQR49MtOFntHhQbEWdf58/z7aANwNdxsBw8JKFRo6fJ8CfctzQV4HlXJ4mhfSmdeTYWfwNQ==
X-Received: by 2002:adf:f3d2:0:b0:33e:8ba7:e53d with SMTP id g18-20020adff3d2000000b0033e8ba7e53dmr8843502wrp.7.1710755298029;
        Mon, 18 Mar 2024 02:48:18 -0700 (PDT)
Received: from localhost ([90.167.94.24])
        by smtp.gmail.com with ESMTPSA id m10-20020adffe4a000000b0033de10c9efcsm9324992wrs.114.2024.03.18.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:48:17 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zack Rusin <zack.rusin@broadcom.com>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/43] drm/fbdev-generic: Do not set physical
 framebuffer address
In-Reply-To: <20240318-dark-mongoose-of-camouflage-7ac6ed@houat>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-2-tzimmermann@suse.de>
 <CABQX2QPJJFrARdteFFZ8f33hvDx-HSyOQJQ7AMFK4C8C=BquTQ@mail.gmail.com>
 <e684558e-8308-4d73-b920-547f9012a2cb@suse.de>
 <20240318-dark-mongoose-of-camouflage-7ac6ed@houat>
Date: Mon, 18 Mar 2024 10:48:16 +0100
Message-ID: <87y1afg9b3.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maxime Ripard <mripard@kernel.org> writes:

> On Mon, Mar 18, 2024 at 08:59:01AM +0100, Thomas Zimmermann wrote:
>> Hi
>>=20
>> Am 18.03.24 um 03:35 schrieb Zack Rusin:
>> > On Tue, Mar 12, 2024 at 11:48=E2=80=AFAM Thomas Zimmermann <tzimmerman=
n@suse.de> wrote:
>> > > Framebuffer memory is allocated via vmalloc() from non-contiguous
>> > > physical pages. The physical framebuffer start address is therefore
>> > > meaningless. Do not set it.
>> > >=20
>> > > The value is not used within the kernel and only exported to userspa=
ce
>> > > on dedicated ARM configs. No functional change is expected.
>> > >=20
>> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> > > Fixes: a5b44c4adb16 ("drm/fbdev-generic: Always use shadow buffering=
")
>> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> > > Cc: Javier Martinez Canillas <javierm@redhat.com>
>> > > Cc: Zack Rusin <zackr@vmware.com>
>> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> > > Cc: Maxime Ripard <mripard@kernel.org>
>> > > Cc: <stable@vger.kernel.org> # v6.4+
>> > > ---
>> > >   drivers/gpu/drm/drm_fbdev_generic.c | 1 -
>> > >   1 file changed, 1 deletion(-)
>> > >=20
>> > > diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/d=
rm_fbdev_generic.c
>> > > index d647d89764cb9..b4659cd6285ab 100644
>> > > --- a/drivers/gpu/drm/drm_fbdev_generic.c
>> > > +++ b/drivers/gpu/drm/drm_fbdev_generic.c
>> > > @@ -113,7 +113,6 @@ static int drm_fbdev_generic_helper_fb_probe(str=
uct drm_fb_helper *fb_helper,
>> > >          /* screen */
>> > >          info->flags |=3D FBINFO_VIRTFB | FBINFO_READS_FAST;
>> > >          info->screen_buffer =3D screen_buffer;
>> > > -       info->fix.smem_start =3D page_to_phys(vmalloc_to_page(info->=
screen_buffer));
>> > >          info->fix.smem_len =3D screen_size;
>> > >=20
>> > >          /* deferred I/O */
>> > > --
>> > > 2.44.0
>> > >=20
>> > Good idea. I think given that drm_leak_fbdev_smem is off by default we
>> > could remove the setting of smem_start by all of the in-tree drm
>> > drivers (they all have open source userspace that won't mess around
>> > with fbdev fb) - it will be reset to 0 anyway. Actually, I wonder if
>> > we still need drm_leak_fbdev_smem at all...
>>=20
>> All I know is that there's an embedded userspace driver that requires th=
at
>> setting. I don't even know which hardware.
>
> The original Mali driver (ie, lima) used to require it, that's why we
> introduced it in the past.
>
> I'm not sure if the newer versions of that driver, or if newer Mali
> generations (ie, panfrost and panthor) closed source driver would
> require it, so it might be worth removing if it's easy enough to revert.
>

Agreed. The DRM_FBDEV_LEAK_PHYS_SMEM symbol already depends on EXPERT and
defaults to 'n', which implies that isn't enabled by most kernels AFAICT.

So dropping it and see if anyone complains sounds like a good idea to me.

> Maxime

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



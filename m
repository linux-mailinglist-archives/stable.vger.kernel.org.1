Return-Path: <stable+bounces-244193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OPsLw8J+mlsIgMAu9opvQ
	(envelope-from <stable+bounces-244193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:13:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DC94D00B9
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80183302F59A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2432356C6;
	Tue,  5 May 2026 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="lQPtOWAG"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E378480975
	for <stable@vger.kernel.org>; Tue,  5 May 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993509; cv=pass; b=ivyBH/JPL+J2VQ7omhXtQPK5bE+fZSj3yr+6nwTVHUJ/Ec2inXC+A3leUm+Wtw485ipKVsBNfrzjriCZk5o++JYAi6v/i2Uwg/vowIbi1ttM7xiAou/llYNYG61RN5Qs6PAxuB1eTEoAkz6GqlOb/Qf/VMUCGJWqjUjM7iEKrP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993509; c=relaxed/simple;
	bh=Edpx5aYTep6geWq3scP45mLCkRPuC1XVKOLbF/4F/BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCUNjxbUX2R6zRKtf2iDEuWcjqewINbbo9mu1zqjMTSBTO6arHgzow4ubqrfWqeCzGZezlQdkeR7qk6iN70NMzyphSWppxGch3iQHV6Px5+XwPtWpl9GbhQT0vvM38xqNM327wTc4q6WGNtBHqvYHE6szQ0HMhiZTZw4rQbgIJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=lQPtOWAG; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7982c3b7da9so49782257b3.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 08:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777993506; cv=none;
        d=google.com; s=arc-20240605;
        b=VR6H+B60Cp3x4VOTf/Gx3RgVwa637gFw1hN/cjAurwzSNqsfHXMkBMRXLVXAzGaaLJ
         qNBzFF9ndJ4ivz4BiOyaIb70FnWfYRgik4ZxuypAsAR4Kn2MdgVF6//NUZD9QxVV4u5a
         cRD3RfZev7GkwZhXqPjOBwaEgyzE/FvvM7snGOct/GSIE3MMJXeiSQTb/NXDqGVkixIO
         A8z7H5ffzN/J3idJLl6RRc55FaRH2wFBWzZuKMZkh23giMrD2ZAXDl2cTCR/IbojN3oE
         dfAuFpqv+Mxa/34TVTjWb8W7l8LI7frNO/0PmaqOsrKSSKbznrkz5eBtC0MmxDDTa0AU
         PprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nxZ89rUvP7Lz3tEU7M6JOWMTYI1Uv/IEguOM4PesleE=;
        fh=70+JE6sU9657dyh6GbbHvQ7a8yuAOVjQPHfHtDUir0A=;
        b=dtFvSA1dynwfFKI9Srq5iWcL/wTYLho7WgS8XLEOBcsW9b+F0OOSROLa3nuuiuKnxo
         0A9zwfumPM4wdN4WMUfKtfNUIZadbfXI2yFG+hUUKh2XwoPHpQOoPkFZSwJSnPa1WC1u
         m2bjM3LmKrrSaSGW8eIZsyggQAx3f4PU+3u6ReCCWwNdqYC+fHaO52e/caRAamo3rD+m
         G3cFGqRIZd3U7rX6tfAMhz5IkJwQGybqgr0CSDqPIWhoR080KdMZ9lChVnTkmOcueVwA
         GWuWL7ZMKHBU3RyN12dPvPx8LMfjM+lAq11rS4bFKUKcUVNLds9Z3vO5fuF5iiHPAloN
         m4lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1777993506; x=1778598306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nxZ89rUvP7Lz3tEU7M6JOWMTYI1Uv/IEguOM4PesleE=;
        b=lQPtOWAGUVRwONFPkRew3tp/ZCt5KJS/RBEoSQlgvLQ9Sns7k+XKZ+5GIiKN52yP2X
         hdgmNk3DNueMCJU/xQqWGLrb4OI7AQEpDVU0735/Mgcj2hZ02MtalTI2ICpV4osV6Wro
         XRUsUfCey0odup56NIVvDj5sNSGpHAawbB6p0fep85HVJANvjaiwgB0stLkqQj5aH23r
         I3JGMPmbQZTZc71J2ZeFbtRC2pTWIt+8uSNX7KyVQqJqQbxoiQmxqD/KheDXE9Z5ILTM
         uyl4xwauJDp2c6RMH16zJsEZoTgKuc65ccJYGuwW1zJmRK2AtGbOsPnZvEC0cvlKYBue
         k+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777993506; x=1778598306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxZ89rUvP7Lz3tEU7M6JOWMTYI1Uv/IEguOM4PesleE=;
        b=POP2+8a2bnMQWWfTz6fmuipqdwCQlzJmGVP4CnO0nje5oQdWTUvCpOYKWhkEb8Pff4
         zO+pcWNlGuh6XbO9MdewaPBW244n7UzMjqs2j5LRnmovopL0VzCeXjFJL/ZJ5KPEzC7B
         ERFZdOWOTUKJ7O5mK6yyU9gQOjFwDj/Dxx8ogwS9bjQfdFeRgVS86hjqwxyFgIJnszo5
         BRNcvDLE353+NFoyyPqPmi53dZF+MKcCrn5gBXbur+snTmxgYEZeeP/3CgV4xFmatt1n
         XkYs3VL+/FWnack7hEtADZVV18Tnpaw/MsIFkbdcMeEgBPxB0aVZ9OZFGLAm3+7cX542
         UZtw==
X-Forwarded-Encrypted: i=1; AFNElJ934AVJNzSEK7jOZ1o6AS7tA94OyqxIztYLNHO37402+irP5Zr3Ze2vw1iSsgZ4jowryBI8le8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA75/kl0q05O5/+ACWo765xBRusQlXR27F339A4xFGXt+vRAs+
	puDSElTQrYZj8rqmqjC6t3cVMWwt49G+db+ms+aukTOUEfz1ebn5fUmfleoiAyPe3QcZH4pN2YE
	2Ci/tuG5mcfxlr+OFL0mqsHUc/NqnKykWv13KdoRrGydB9JCxwQYW
X-Gm-Gg: AeBDiev0oj2Uj/roTLMX82xD9jqWQUNXU76ZN8J4PTc+Y9cOaQMMGJ3z6FeO6ATEnop
	Nw7jAxOa++F5EUaschVG0n7QIZjm8NRSHxi9ZpAwIvTtwn/6b5tJkMlDwQCDcEQiGkBGfEs//WL
	i09/U2Ehz1PIxxadR3jqm2jZSIlZac37XOfueZvVXLBppNOu77d9SJptgDHfValGuuivqSR1lRq
	NXvYCJJZEzwOoNS9QQPozhzyYIKCOA6KiSSiGBo6tpqDr246W+PbPSHIm2eKh9bMZOOvosWpkv2
	lGF4b6AMCL2FH6HQvTO6HqFY4hzEpEZGRwzp+Gdj2T7X6K7KHiml01+d+Q==
X-Received: by 2002:a05:690c:6d84:b0:7bd:d145:3af9 with SMTP id
 00721157ae682-7bdd1453b57mr17435087b3.47.1777993506337; Tue, 05 May 2026
 08:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502121251.39206-3-thorsten.blum@linux.dev>
 <CAPY8ntDOEjAHFF_HxFoVEmrgQ8okm=8cHQEfm2QUU=MuB77d_A@mail.gmail.com> <afm5rE1i3D-Uk3S7@linux.dev>
In-Reply-To: <afm5rE1i3D-Uk3S7@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 5 May 2026 16:04:50 +0100
X-Gm-Features: AVHnY4JZgHkJgGCzic2hZC9UU4JXCcW0xdjYdX9AKr5gfvwyZOmmOxNQ7b9qX4s
Message-ID: <CAPY8ntCgeP-0k=b1KCzKb5K4zExGD5g2=VOtjVaiSPWj=2b2kA@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: fix NULL dereference in vc4_hvs_unbind
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Eric Anholt <eric@anholt.net>, 
	stable@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B3DC94D00B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[raspberrypi.com,reject];
	R_DKIM_ALLOW(-0.20)[raspberrypi.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244193-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,igalia.com,raspberrypi.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,anholt.net,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.stevenson@raspberrypi.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[raspberrypi.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email,raspberrypi.com:dkim]

Hi Thorsten

On Tue, 5 May 2026 at 10:34, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> Hi Dave,
>
> On Tue, May 05, 2026 at 09:54:53AM +0100, Dave Stevenson wrote:
> > Hi Thorsten
> >
> > On Sat, 2 May 2026 at 13:13, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > >
> > > With 'dtoverlay=vc4-kms-v3d,noaudio' and 'hdmi=off' on Raspberry Pi,
> >
> > Mainline doesn't use overlays, so this description isn't valid.
> >
> > Which generation of Pi are you using? Whilst they all share the vc4
> > driver, the functionality associated differs. If you're disabling HDMI
> > (and HDMI audio), which display outputs are you using?
>
> It's a Pi 500 currently running headless, which is why I turned audio
> and HDMI off. I ended up using:
>
>   dtparam=audio=off
>   #dtoverlay=vc4-kms-v3d
>   hdmi=off

You're still working from our vendor kernel[1] rather than mainline.
The mainline kernel doesn't support the Pi500 yet, and doesn't use
overlays.
The bug is present in both, but descriptions reported to mainline
should correspond to mainline. Otherwise report it to our vendor
kernel repo.

There's also no such config.txt parameter as "hdmi=off".

[1] https://github.com/raspberrypi/linux

> This prevents the vc4 and snd modules from loading and works for me.
>
> > > unloading the vc4 module calls vc4_hvs_unbind() with
> > > dev_get_drvdata(master) returning NULL.
> > >
> > > Return early when 'drm' is NULL before converting it to 'vc4' and before
> > > dereferencing 'vc4->hvs', preventing a kernel oops.
> >
> > That leaves things allocated and clocks running, so bailing out isn't a fix.
> > I'll have a look to see why dev_get_drvdata is returning NULL.
>
> Yes, I realized there are probably other things that need to be fixed.
> However, the defensive NULL check avoided the kernel oops for me.

A quick check says that vc4_drm_unbind gets called first and sets
drvdata to NULL.
The devm action then triggers and calls vc4_component_unbind_all,
which in turn calls vc4_hvs_unbind. The relevant pointer is passed to
the unbind as "void *data", but not used.

In vc4_hvs_unbind, changing
struct drm_device *drm = dev_get_drvdata(master);
to
struct drm_device *drm = (struct drm_device *)data;
fixes it for me.

It looks like vc4_v3d (used on Pi 0-3) has the same issue.
vc4_crtc and vc4_txp both store drvdata against their own device, not
against the master. I'll have a bit of a think as to whether that is
better than using the "data" pointer.

AIUI unbinding DRM drivers is an unusual operation anyway.
If audio is enabled then I can't "rmmod vc4" as the module is in use,
but I can if audio isn't enabled. I can't immediately see a way around
that one.

  Dave


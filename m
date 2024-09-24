Return-Path: <stable+bounces-76994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178209846AE
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 15:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA641284B45
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD801A76CF;
	Tue, 24 Sep 2024 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJqn7Y5Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCE1A76B4
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184278; cv=none; b=lSn2bCkf46nrlrvOOrSW3D7GjGf5UJ1UJV2ZJtFzZdOt2bmcqD5wK481N/inCLJnujClwXhsEx8QH62EaN2GWdU9q0uJCZAIZ0q8Pn0qpXhGFL84JSQv4bMjYIIcdvDVB4weSGp06w/AaA/Y5oz2eii8o/fEeZiQCD3amjNYc5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184278; c=relaxed/simple;
	bh=OfZi7qiXjHGFzBZSneYE2F9f418pMdcFM5Y3uQzGxbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJw4I4tzdlaoOF5QkkMsiuNxwmYjvny9iopJdEtorA8GOyp8epjzxo3fp86vFFXEj202EAW3BFZm6+zYYkWY11m8kz9MR1Qb8gQPbngC9Hfz7bSXImCn0/1P2tImLBQet2A4VK7K8sMjXTPPdrIUYyDhrCsdfk1blKHFVbmN+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJqn7Y5Q; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718e0421143so1101984b3a.0
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727184276; x=1727789076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvnaZJqFfXFaafjuo2tTI/OT9A98V7mgCkYmS2wx5+4=;
        b=nJqn7Y5QhnDNIJIuUD4NccmUnIS7tfViRqJiNl67SpootYuQZng0tYQoWskmataXSQ
         iY63VFzGhZ81ARbCTpygvnkFDv7aNt9mr3b+5Z8HC8bs8tung5sfFjMLG27DAgBuQYph
         dyNgHrN7ORkvEKvSM+SJ9ID7W4AMYtFV73krff/So4k4GqVPUc0NLwWAJ7fl3xp9u8Ax
         /5Xavhq9XtQKPtVdhjuEpqttCdexLjHTP8Udrep2xoMgrk9sfykuJvlw+c6yOPpbYWVm
         MAkysfhz6di5gIhq8OKtUKEc6wwW/5Y6mBjQiF3GmBYQSxe2rYbFvX4IXHQboO+5LPxx
         3HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727184276; x=1727789076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvnaZJqFfXFaafjuo2tTI/OT9A98V7mgCkYmS2wx5+4=;
        b=Wosgj2/mH7u08Cuvuh/cXSvcWKFGe04fU7t6p93ZfBXGdICmWpilLZl5V+N9+Rbvbb
         5F9bcvWVTl8MZc4aI03+zQUEBJEWYi6bGuFlsO5CbCUzVjwu9SafRGykZtSY+nVsfZ5k
         jv8v90q6OCM+Q4F65WAx2VAuvK2GdVTRYW9YUNov5jhFsxt8LIEOZneIgzUifNFIgE6i
         Fym/yOoNkslkPNweXBYBvRPNI5OVNHlhlKdrD6s7AY13+0yWS36DUcYY+0gx1sWOr1GJ
         ooMKbeOZTdsTfyn550NNs6PESuJs99QV10nGDiVxAGwZlN4QUX99f6zh3sJMNTH2AWkj
         A6GA==
X-Forwarded-Encrypted: i=1; AJvYcCWxY8wq5DA4n3J8j9/5GxNd+bEvFqf9NvjWpsXQq8ElKprUwAzpsWo3AiUDJZjs8I2l7u3d4TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7sXOGbzdsoTwY+woEkx06HivGsBjkgh4iEmYtN1l7QmBz4u9
	1XtIb/xfORa89VbvWOarewI9F8YKXPWNAT1zhTLvkicUjXLF9uoNR+WOIQACUDhuCfzNIw9OjRy
	WNsTcotzSOhh8Sd89QLKqIZoqfa4=
X-Google-Smtp-Source: AGHT+IFuZIUC3y21iSVZyR2o5dKIJPPbtSxgaCOWhFfp4Hu9OWkaFu33ak//uRyXzS840sm5f+bSYekO0V5yaVv15Ng=
X-Received: by 2002:a05:6a20:2449:b0:1cf:4c3a:162a with SMTP id
 adf61e73a8af0-1d344eb8a2cmr2105535637.5.1727184276111; Tue, 24 Sep 2024
 06:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924084227.262271-1-tzimmermann@suse.de>
In-Reply-To: <20240924084227.262271-1-tzimmermann@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Sep 2024 09:24:23 -0400
Message-ID: <CADnq5_Prj5Ldi4v2md1bxZsA4_hXDk6q679Sqd43rMx7d-LgCA@mail.gmail.com>
Subject: Re: [PATCH] firmware/sysfb: Disable sysfb for firmware buffers with
 unknown parent
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, alexander.deucher@amd.com, 
	chaitanya.kumar.borah@intel.com, dri-devel@lists.freedesktop.org, 
	Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 4:58=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> The sysfb framebuffer handling only operates on graphics devices
> that provide the system's firmware framebuffer. If that device is
> not known, assume that any graphics device has been initialized by
> firmware.
>
> Fixes a problem on i915 where sysfb does not release the firmware
> framebuffer after the native graphics driver loaded.
>
> Reported-by: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> Closes: https://lore.kernel.org/dri-devel/SJ1PR11MB6129EFB8CE63D1EF6D932F=
94B96F2@SJ1PR11MB6129.namprd11.prod.outlook.com/
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12160
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: b49420d6a1ae ("video/aperture: optionally match the device in sysf=
b_disable()")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.i=
nfo>
> Cc: <stable@vger.kernel.org> # v6.11+

Thanks for fixing this.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/firmware/sysfb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 02a07d3d0d40..a3df782fa687 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -67,9 +67,11 @@ static bool sysfb_unregister(void)
>  void sysfb_disable(struct device *dev)
>  {
>         struct screen_info *si =3D &screen_info;
> +       struct device *parent;
>
>         mutex_lock(&disable_lock);
> -       if (!dev || dev =3D=3D sysfb_parent_dev(si)) {
> +       parent =3D sysfb_parent_dev(si);
> +       if (!dev || !parent || dev =3D=3D parent) {
>                 sysfb_unregister();
>                 disabled =3D true;
>         }
> --
> 2.46.0
>


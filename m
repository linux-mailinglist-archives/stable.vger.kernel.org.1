Return-Path: <stable+bounces-197971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C97EDC98A9E
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E157342C0A
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 18:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9CC33891F;
	Mon,  1 Dec 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IarYOuhr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF94338591
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764612625; cv=none; b=L08XZXrUqZczJokjYTsI1LhWaxU54SzkO9QsSkia6xbGzsmDSY26b51gnJY9Oj1+7HRcTnFMme56txJxH0pavjXvtF+PebtaArq/NH0nDFP/n3uH1EmFXDMpVt86WPY7eKuWP5KLeDuD3JVDcBknhjZAGy44WDLpqnn+i1yjR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764612625; c=relaxed/simple;
	bh=AycfQBJMYvnXm6bz5lQXY+UVp2sfanzYbZi4UEz2ocM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9ZXfNVu7lXcD9oIxlTauHGzwCM4IInTcbQR1itOZnvsw1YE5QPWo98O2xKdZufhr9kV8pOI0KdXSCUXLaqTUYbA2b/+ea9e+up10iXYveH2H2GSpv3rZloYv3QbaqjA0erksAy6Nn7Hp0duU4um/AVU2KLlAm63lUzg0aA7jOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IarYOuhr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b713c7096f9so735076266b.3
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 10:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764612615; x=1765217415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSAcsh/jLvy3jVAdeyxQi+guKPEheOPvD2BWq9t337E=;
        b=IarYOuhrzh1UV39katXKth2Rsha4e+0xSEFp0P3FMSaQxBK5G0hh5z3yy0mS+BUUA2
         9xIS/q5UBY8vunQpCQcgd7FFYKoatVLu+H7Kc2D7+aC3WaFNplvsvgytFqYnF6Z9dYI8
         RErUvUUTCh6nQdCCknqVuGGBLfRQexejJeE1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764612615; x=1765217415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSAcsh/jLvy3jVAdeyxQi+guKPEheOPvD2BWq9t337E=;
        b=OYCNXUjEF3pkWMvsIL1aXNuNpqSHiqDN1AFYj/QFnhPQ4fVzfbQ2NE1PfWbqUuyPKX
         IUUxUeD4EEluVPFbzmuqHXvwfVN8hl683MPXp8BbiYrGMx3JGj10Us3BT7AM4scboP+z
         PmZuaETbkSfJl1CU/QS0eL5qlsmgEQyQKNcV1gLGH3VgKQXJMk0Upy1iSMP9J4K1/g/m
         JNqY49q1E5cGn3/Fmw9+wx6iRQKd+Dv1OLbFVCbAEm9Hoyxe6pJYHLE9Yjy41tdbkRvO
         16PMhIdtHhqELIR78ShrddJM74aDgc/0j+jY0jPXpx5PivyaDD+I6epI40gSoQMFggI0
         OaWg==
X-Forwarded-Encrypted: i=1; AJvYcCUfUs1E0LFcE4Gv7xymGt+7UUnIwY5peS2lBehtgCkKxuBVGgRWEWf5EYGpV8vHRKbnG6+XJIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc54ibzWNZLN8vcwlvtzeZUfse7Cl1ug026xvuIlNJy/3MKcLF
	1ksNoSwVF/jvUlAc6mh5h6lG2guIDl2oyuJmfi9CyRJrwgLmyAkhYd1RMYgATP/p9HUIlKNpFzd
	3Nc2yirW9
X-Gm-Gg: ASbGncsZr7alIfCjszzKQeJbzsy8cFRB4dK6kEmy3ATMY1QMQVA3jczS1t8VV9duJ+O
	0DdIdB2xxMHsb57lyxNkx/4pYNUuRlUbzxyBUVp0d9URYcOEa3iDxedA0mj7O4LmRp4mDMdqgyd
	cqzJJzsA3Tz2d6mLjwRVq9cVTNL0RcwTy788QtAuXQF4SmY/o7qnPVkLYMolteRtn18e49QqpQ9
	d4JfIpfKn5g8OKnzeR15x+EB0lpjI5nkc3qz33aviIFFIxrQhhWmq+K7eZDB5vnGIhZoDynmNrm
	1Qwx+XQPqnANDow3qpYNq/IsPWeTUmTBqpWBGNh7B4/M0N6Fb575AJ3X/+WfFw3EPaT+13Cnr88
	y47gc5MicLSoBF2072k+Li7KnHCJcj5SFiapMrXK4F4W6gBoMFWBAS5xQabQ2o4uGIhXUEB2UW6
	16Ns6fE9jIj8tdygFbe6nHK8WSn825mnNL+ki1TbgqsyqAJlDAVA==
X-Google-Smtp-Source: AGHT+IECzm32FaeZ1pB5ceKpuwuFDbuh9jOgOhQ3b7oDyTUplGfe04h7Ro0ByYbbNBV5Wc9HyNZssw==
X-Received: by 2002:a17:907:7205:b0:b40:8deb:9cbe with SMTP id a640c23a62f3a-b7671549ca8mr4469431066b.2.1764612615168;
        Mon, 01 Dec 2025 10:10:15 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a1d750sm1252749666b.56.2025.12.01.10.10.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 10:10:14 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso50730795e9.3
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 10:10:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJBV5fZGJ3KQTQp5lBRTkgThRx5962/0ecH/cf3/DpsskyxPdguB9lg+FdEfOTrdRbQ5C9708=@vger.kernel.org
X-Received: by 2002:a05:600c:3ba1:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-477c11160cdmr415396085e9.22.1764612612856; Mon, 01 Dec 2025
 10:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125090546.137193-1-kory.maincent@bootlin.com>
In-Reply-To: <20251125090546.137193-1-kory.maincent@bootlin.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 1 Dec 2025 10:10:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WikKrpLKvaxD22H0s3XHeG=WUiRrLJ0eQMM2pqvXJhuw@mail.gmail.com>
X-Gm-Features: AWmQ_bmsv9J5UlggLGP1aiEVtrV6kayziPzbKKyqQbq8EQwvWpJS3SIXk8v0J68
Message-ID: <CAD=FV=WikKrpLKvaxD22H0s3XHeG=WUiRrLJ0eQMM2pqvXJhuw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/tilcdc: Fix removal actions in case of failed probe
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maxime Ripard <mripard@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Bajjuri Praneeth <praneeth@ti.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Louis Chauvet <louis.chauvet@bootlin.com>, stable@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 25, 2025 at 1:06=E2=80=AFAM Kory Maincent <kory.maincent@bootli=
n.com> wrote:
>
> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
>
> The drm_kms_helper_poll_fini() and drm_atomic_helper_shutdown() helpers
> should only be called when the device has been successfully registered.
> Currently, these functions are called unconditionally in tilcdc_fini(),
> which causes warnings during probe deferral scenarios.
>
> [    7.972317] WARNING: CPU: 0 PID: 23 at drivers/gpu/drm/drm_atomic_stat=
e_helper.c:175 drm_atomic_helper_crtc_duplicate_state+0x60/0x68
> ...
> [    8.005820]  drm_atomic_helper_crtc_duplicate_state from drm_atomic_ge=
t_crtc_state+0x68/0x108
> [    8.005858]  drm_atomic_get_crtc_state from drm_atomic_helper_disable_=
all+0x90/0x1c8
> [    8.005885]  drm_atomic_helper_disable_all from drm_atomic_helper_shut=
down+0x90/0x144
> [    8.005911]  drm_atomic_helper_shutdown from tilcdc_fini+0x68/0xf8 [ti=
lcdc]
> [    8.005957]  tilcdc_fini [tilcdc] from tilcdc_pdev_probe+0xb0/0x6d4 [t=
ilcdc]
>
> Fix this by rewriting the failed probe cleanup path using the standard
> goto error handling pattern, which ensures that cleanup functions are
> only called on successfully initialized resources. Additionally, remove
> the now-unnecessary is_registered flag.
>
> Cc: stable@vger.kernel.org
> Fixes: 3c4babae3c4a ("drm: Call drm_atomic_helper_shutdown() at shutdown/=
remove time for misc drivers")
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>
> I'm working on removing the usage of deprecated functions as well as
> general improvements to this driver, but it will take some time so for
> now this is a simple fix to a functional bug.
>
> Change in v4:
> - Fix an unused label warning reported by the kernel test robot.
>
> Change in v3:
> - Rewrite the failed probe clean up path using goto
> - Remove the is_registered flag
>
> Change in v2:
> - Add missing cc: stable tag
> - Add Swamil reviewed-by
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c |  2 +-
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c  | 53 ++++++++++++++++++----------
>  drivers/gpu/drm/tilcdc/tilcdc_drv.h  |  2 +-
>  3 files changed, 37 insertions(+), 20 deletions(-)

Seems reasonable to me. I did a once-over and based on code inspection
it looks like things are being reversed properly. I agree this should
probably land to fix the regression while waiting for a bigger
cleanup.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

This fixup has been sitting out there for a while. Who is the right
person to apply it? If nobody else does and there are no objections, I
can apply it to "fixes" next week...

-Doug


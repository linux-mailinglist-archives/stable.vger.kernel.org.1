Return-Path: <stable+bounces-200375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871ACAE525
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 23:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBCFC30AE9B7
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 22:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6DB2F2605;
	Mon,  8 Dec 2025 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lZ2RQJiD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81B2EDD6C
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765232490; cv=none; b=rjBjgUbRKa8ORBCl9zalM4LC5eH9Z8cOD5wiFbhKgdcy1RgBLJHzpagZxVGCcaNZMzK6FudqWLeVyV+CtUxg/OO9iOrKttmxw66+GZl/7/COi8TpYnPEEdTjZ+d5/27oqIy6Blfa3wyn3Yab4yxgbup3gMkBPmUK34AZ+6vj600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765232490; c=relaxed/simple;
	bh=WRmoQ6pWMEvMOTnAjHDA37jWJJOombCuEyG1Z9F2hec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5hQ74kp8jzZbx8uwPxyLXlckmHkvGzyW89CP+1kaDVLJepoC9ADt1lzgFzIEU6Jd9dH9G8sMlbFOPeEW5barApKXaTQycgvIb+7gKK1zN89VpexB5GEL9mqKKnAOYJQvOSSp9o/5OGJANmqe7j80Svwx+rlM3n1Z72LXT7wkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lZ2RQJiD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso8309636a12.1
        for <stable@vger.kernel.org>; Mon, 08 Dec 2025 14:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1765232482; x=1765837282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJAf24FuHQe95NZr/O9DtfATOUEp5YWLsl/0nDh2TTA=;
        b=lZ2RQJiDYMSgg/0uc1ACT+AMuSwkKu/eYfJ09DlY4wD1vueN/5R66PVrmUMwWBmbNz
         pBWcLCSQJf54fMrrFgf7v5ELu0MgfV/HCYZQGlkcAD1FM1pcczEhG6EIqkacSX5SqWSy
         2j+qghjJ2N7814uNcPIKBRmK3Z6WJDlKUi/1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765232482; x=1765837282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJAf24FuHQe95NZr/O9DtfATOUEp5YWLsl/0nDh2TTA=;
        b=R0NzjdRSqXczCfjYsuq8i3dgkmD0RD/j+RdoA6miO2hvE8Xrad9eI3wbLXeR7ZgVfF
         ixkgZevipaDLTCzW2FHw1E2BNj+UUKe8BgZ9UK946B+x7kVjXGRPV3CPQlo22b2S9l/N
         hSqdkU9bB4KKm+nRyN8+IUR73PhICYR5KxSgUsmyk5dM13bB5/i/OzS61NV1X7IWmetJ
         sKpIlEB8j/JMBLpnlnGBoDdqDQ6tBrq6A5LN0DS60fHIPxICqsjvigdldNV6jVi2cnSX
         8dDYmFMQDB+ETIvRjm4WN6ietLy/32FyFSojjW/TLTktq3yEcr94jdba+ptpZQN90U6n
         LkSA==
X-Forwarded-Encrypted: i=1; AJvYcCU+hlu8eHUHD8QEHHRvZTgKWUdQyX5XWFgw50/E0mO8ecZEL9BzIFdwtfUAKiIjM2sua3LkWlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxM1BuOZf98oz+8IfK2buIIFUbjxeT8m3dt0vZdzqjTYxA3wLx
	gzy8uLl4DzfbfbyAYGd7rfsqK4McI6HKCHuTWVgBuIYXaav9xpUcyWSM5a+Np2fCi6SRnVNFC6i
	CSGnTEg==
X-Gm-Gg: ASbGncv4dwvH6dDFpcPwbWUuy4lRc0EGn58Ey1l4vIXbdFO/iBOQSLzVLeJmBwT0kmb
	dlPCb0l3kz3pYXx00+vV6i3OSo0AtsLNJz2RpGXnra0of2GqgRH6jjL98GwbDiRf/zlZfXngs8w
	vbs7VLkBWWuyVDtMhvlk+T/9Kq9zDvcQNg1+1oquKKVPW2FCQ3ZnNM4bzMDj5zGSOH7Qfg8FEeA
	mG5+60cbIIJhXcTIkiSMRxyq8sC4OPkN6yOAx0vYw1i4B/W//ZitXF7rAr4Z8qspDypdxm0IWiC
	9E2UfLYGTr6jSxuWWto+iscKan/epfXJa+TDGM5qtNBO8gBlW1OlfkGKNQuO5rZtLYVUD3l5cAe
	Urds13iRVBRfPH7x0hhr223DlTX1l9Ed0Ym7ciEe8FLX7ok4t4COqlfeNze0LKgYcydTLeKKD2x
	w49HKUEQVfe/0cioUakzy4mW9ovw76NOt5GhGmDOxXQn8CTurAZQ==
X-Google-Smtp-Source: AGHT+IF8HVGscmjbYavb5C711Be4y4cV8GtzcgEewMAh8Rg7/U/HubrCHtA3IGhTbOvFxAjfgB6vfg==
X-Received: by 2002:a05:6402:1475:b0:640:f1ea:8d1b with SMTP id 4fb4d7f45d1cf-6491a432967mr7789343a12.16.1765232482343;
        Mon, 08 Dec 2025 14:21:22 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b412146bsm11875947a12.23.2025.12.08.14.21.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 14:21:22 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so2998825f8f.3
        for <stable@vger.kernel.org>; Mon, 08 Dec 2025 14:21:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXr8tU07dNFibInimLj6H3e7dJ7UmvXrAe/I33TQTvrNotUD8KtXds3Y4gJBokQOPK2FwQpyFM=@vger.kernel.org
X-Received: by 2002:a05:6000:184e:b0:42f:8816:6e53 with SMTP id
 ffacd0b85a97d-42f89f5b7a9mr9262105f8f.61.1765232480155; Mon, 08 Dec 2025
 14:21:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125090546.137193-1-kory.maincent@bootlin.com> <CAD=FV=WikKrpLKvaxD22H0s3XHeG=WUiRrLJ0eQMM2pqvXJhuw@mail.gmail.com>
In-Reply-To: <CAD=FV=WikKrpLKvaxD22H0s3XHeG=WUiRrLJ0eQMM2pqvXJhuw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Dec 2025 14:21:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WrQpa3G0ggSMiJG8RnT45zCLug2YKTTgPfNrzAoQU98Q@mail.gmail.com>
X-Gm-Features: AQt7F2qfhZ_9C3ny6GB_ztDzwr2hF0lEcdFjQq7wCKYlX1JiOVwhYtW82bJNjiA
Message-ID: <CAD=FV=WrQpa3G0ggSMiJG8RnT45zCLug2YKTTgPfNrzAoQU98Q@mail.gmail.com>
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

On Mon, Dec 1, 2025 at 10:10=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Nov 25, 2025 at 1:06=E2=80=AFAM Kory Maincent <kory.maincent@boot=
lin.com> wrote:
> >
> > From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> >
> > The drm_kms_helper_poll_fini() and drm_atomic_helper_shutdown() helpers
> > should only be called when the device has been successfully registered.
> > Currently, these functions are called unconditionally in tilcdc_fini(),
> > which causes warnings during probe deferral scenarios.
> >
> > [    7.972317] WARNING: CPU: 0 PID: 23 at drivers/gpu/drm/drm_atomic_st=
ate_helper.c:175 drm_atomic_helper_crtc_duplicate_state+0x60/0x68
> > ...
> > [    8.005820]  drm_atomic_helper_crtc_duplicate_state from drm_atomic_=
get_crtc_state+0x68/0x108
> > [    8.005858]  drm_atomic_get_crtc_state from drm_atomic_helper_disabl=
e_all+0x90/0x1c8
> > [    8.005885]  drm_atomic_helper_disable_all from drm_atomic_helper_sh=
utdown+0x90/0x144
> > [    8.005911]  drm_atomic_helper_shutdown from tilcdc_fini+0x68/0xf8 [=
tilcdc]
> > [    8.005957]  tilcdc_fini [tilcdc] from tilcdc_pdev_probe+0xb0/0x6d4 =
[tilcdc]
> >
> > Fix this by rewriting the failed probe cleanup path using the standard
> > goto error handling pattern, which ensures that cleanup functions are
> > only called on successfully initialized resources. Additionally, remove
> > the now-unnecessary is_registered flag.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 3c4babae3c4a ("drm: Call drm_atomic_helper_shutdown() at shutdow=
n/remove time for misc drivers")
> > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> > ---
> >
> > I'm working on removing the usage of deprecated functions as well as
> > general improvements to this driver, but it will take some time so for
> > now this is a simple fix to a functional bug.
> >
> > Change in v4:
> > - Fix an unused label warning reported by the kernel test robot.
> >
> > Change in v3:
> > - Rewrite the failed probe clean up path using goto
> > - Remove the is_registered flag
> >
> > Change in v2:
> > - Add missing cc: stable tag
> > - Add Swamil reviewed-by
> > ---
> >  drivers/gpu/drm/tilcdc/tilcdc_crtc.c |  2 +-
> >  drivers/gpu/drm/tilcdc/tilcdc_drv.c  | 53 ++++++++++++++++++----------
> >  drivers/gpu/drm/tilcdc/tilcdc_drv.h  |  2 +-
> >  3 files changed, 37 insertions(+), 20 deletions(-)
>
> Seems reasonable to me. I did a once-over and based on code inspection
> it looks like things are being reversed properly. I agree this should
> probably land to fix the regression while waiting for a bigger
> cleanup.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> This fixup has been sitting out there for a while. Who is the right
> person to apply it? If nobody else does and there are no objections, I
> can apply it to "fixes" next week...

Pushed to drm-misc-fixes:

[1/1] drm/tilcdc: Fix removal actions in case of failed probe
      commit: a585c7ef9cabda58088916baedc6573e9a5cd2a7


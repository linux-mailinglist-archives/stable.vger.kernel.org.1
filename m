Return-Path: <stable+bounces-69616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842C4957183
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 19:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85611C22ACF
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9FA17C204;
	Mon, 19 Aug 2024 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAjVczeH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229918A932
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087034; cv=none; b=LqxXIk6HdAlR+s8Or3sECQkF28iUZdb7tQ3NmF7XAjuVCPJXU4dfJCvYeTkowaTXHdaXxogHFAoA7kODi4QbDJqlD0Eq7TV3ZSyc5BZFGnHj/Z4hYzrjk81eT9/Zxbn1Z38saLjnTV91C9Ny9SsQx9/ph8dYicaKolucKG227lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087034; c=relaxed/simple;
	bh=cd9uMXXjwIg3LipodXGtIPYrqQicCXUGwYBCYfrGU5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHJ3hzfyjBHjiREatvtVOW7IMxa7Yhakl48Hq9P0xBq7fdFGWPs4BQB4bLBJob5eZ0tGwg+DX01cE5QtcftEAfwkSeN1ag9eRPzKeHf+/3csYHDKlxJmgSuK6fGrgbB4EjpeF+N1eegjlg8r0yboxX/K4pfIdT9TJ4C+jYmLIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAjVczeH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-202376301e6so8902915ad.0
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724087032; x=1724691832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmNdRfQwBhxaT1HwilI10sPKkC7lH+s3BpK82jwzrS8=;
        b=cAjVczeHJexmwro/mKW1gQN/ovy0VKxUJMum1O4hVpLlnYgZHVV1mikwfIptR3tKks
         8TmEI//oQAXPo3+2HE2DMgZIxV8UIMpOtPHZlXe/1cWhWMSNEoP2U91M8owMyeSoaIRG
         szQvJ5bspGyF6PzZxAQan1wXOphpEOgnK/R0z5oOLNGvkoTl6gMO6EpkebN801kEalGP
         7iwV5QcZxBj34CsMpGHDctjd9WmR7SAfKujw0QTz8VBZglLpch3VQyP30FdT1e8bNJcV
         YoNfvLjRbDD5X8sWV193tjJDPsAUVyKIi2I/Omzjxlf0kBAF6irxR1AMGTnENg5gKqZ6
         P09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724087032; x=1724691832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmNdRfQwBhxaT1HwilI10sPKkC7lH+s3BpK82jwzrS8=;
        b=XIXnBOA4vUcII/XzjZqjLvQSM88M0T0kQokF+svaXOotsdtbO3c1iILBVErtF6MCpS
         0gBQSaw7k8P6T4mBsLBa49wu+Xi4qOoXfsASCgtuGJWlFQyNkcz4DyTjJeV/tk1Gi1e4
         MIK0wQxuUEPSrZOb6ImGfGc8eBc8P7W2Khf2wzdy+HkTVBXjLzpXTEhbYiw7F8Cbvnsd
         GII3aDAeE207DLcNyDhN2GbpWh87MzffzK2KuBDfAZX79kX/kKG7PJscF3AH6wQMQ+eT
         mJJBLQAuVg3tT3szbb9SMVE/ZRoDRxkMZfFMkgk96V5TM4xKnQVVtGPvtoFm9kwxwH1t
         3blg==
X-Forwarded-Encrypted: i=1; AJvYcCV/sDLN3YsPWIWwNaqeLR+SIzAGaXxP51efmKnG/c+5yXChpE9Xeiqo0j7HvWTkPGQmkkZXUWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqpknmOxm1GFPTMOOhgtQkW8gOCkLB4jO+x4Q4mgi5lsKbajBO
	i1kpVq8ShpdKQjK5+O/AO+Uij30th9KKrTFgWL+QLASAZvtxwORE1BCYtj0acArpS6abCLZd8Qn
	GgWah/YAtrPziIDlCm+vcs9BuOojPnVHw
X-Google-Smtp-Source: AGHT+IFrRCmM5UI/i4vWXN89LDnPdv0s59wDFaKy0zznINVO0gSqZ6AVSs5aHioOicfupSSEZfWlnPph7E8/q+jTABQ=
X-Received: by 2002:a17:903:10c:b0:202:2f0:3bb2 with SMTP id
 d9443c01a7336-20204067d8fmr93491475ad.60.1724087032002; Mon, 19 Aug 2024
 10:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819165341.799848-1-alexander.deucher@amd.com>
In-Reply-To: <20240819165341.799848-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Aug 2024 13:03:37 -0400
Message-ID: <CADnq5_M5GnsS5dcfrQU7c-B7j3yp=Gq70eZ4XB5Ri1b4M4yO-w@mail.gmail.com>
Subject: Re: [PATCH V2] video/aperture: match the pci device when calling sysfb_disable()
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, 
	Javier Martinez Canillas <javierm@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, 
	Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I forgot to update the patch title but it should probably be something like=
:

video/aperture: optionally match the device in sysfb_disable()

Alex

On Mon, Aug 19, 2024 at 1:00=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> In aperture_remove_conflicting_pci_devices(), we currently only
> call sysfb_disable() on vga class devices.  This leads to the
> following problem when the pimary device is not VGA compatible:
>
> 1. A PCI device with a non-VGA class is the boot display
> 2. That device is probed first and it is not a VGA device so
>    sysfb_disable() is not called, but the device resources
>    are freed by aperture_detach_platform_device()
> 3. Non-primary GPU has a VGA class and it ends up calling sysfb_disable()
> 4. NULL pointer dereference via sysfb_disable() since the resources
>    have already been freed by aperture_detach_platform_device() when
>    it was called by the other device.
>
> Fix this by passing a device pointer to sysfb_disable() and checking
> the device to determine if we should execute it or not.
>
> v2: Fix build when CONFIG_SCREEN_INFO is not set
>
> Fixes: 5ae3716cfdcd ("video/aperture: Only remove sysfb on the default vg=
a pci device")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/firmware/sysfb.c | 11 +++++++++--
>  drivers/of/platform.c    |  2 +-
>  drivers/video/aperture.c |  5 ++---
>  include/linux/sysfb.h    |  4 ++--
>  4 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 880ffcb500887..033a044af2646 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -39,6 +39,8 @@ static struct platform_device *pd;
>  static DEFINE_MUTEX(disable_lock);
>  static bool disabled;
>
> +static struct device *sysfb_parent_dev(const struct screen_info *si);
> +
>  static bool sysfb_unregister(void)
>  {
>         if (IS_ERR_OR_NULL(pd))
> @@ -52,6 +54,7 @@ static bool sysfb_unregister(void)
>
>  /**
>   * sysfb_disable() - disable the Generic System Framebuffers support
> + * @dev:       the device to check if non-NULL
>   *
>   * This disables the registration of system framebuffer devices that mat=
ch the
>   * generic drivers that make use of the system framebuffer set up by fir=
mware.
> @@ -61,8 +64,12 @@ static bool sysfb_unregister(void)
>   * Context: The function can sleep. A @disable_lock mutex is acquired to=
 serialize
>   *          against sysfb_init(), that registers a system framebuffer de=
vice.
>   */
> -void sysfb_disable(void)
> +void sysfb_disable(struct device *dev)
>  {
> +       struct screen_info *si =3D &screen_info;
> +
> +       if (dev && dev !=3D sysfb_parent_dev(si))
> +               return;
>         mutex_lock(&disable_lock);
>         sysfb_unregister();
>         disabled =3D true;
> @@ -93,7 +100,7 @@ static __init bool sysfb_pci_dev_is_enabled(struct pci=
_dev *pdev)
>  }
>  #endif
>
> -static __init struct device *sysfb_parent_dev(const struct screen_info *=
si)
> +static struct device *sysfb_parent_dev(const struct screen_info *si)
>  {
>         struct pci_dev *pdev;
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 389d4ea6bfc15..ef622d41eb5b2 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -592,7 +592,7 @@ static int __init of_platform_default_populate_init(v=
oid)
>                          * This can happen for example on DT systems that=
 do EFI
>                          * booting and may provide a GOP handle to the EF=
I stub.
>                          */
> -                       sysfb_disable();
> +                       sysfb_disable(NULL);
>                         of_platform_device_create(node, NULL, NULL);
>                         of_node_put(node);
>                 }
> diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
> index 561be8feca96c..b23d85ceea104 100644
> --- a/drivers/video/aperture.c
> +++ b/drivers/video/aperture.c
> @@ -293,7 +293,7 @@ int aperture_remove_conflicting_devices(resource_size=
_t base, resource_size_t si
>          * ask for this, so let's assume that a real driver for the displ=
ay
>          * was already probed and prevent sysfb to register devices later=
.
>          */
> -       sysfb_disable();
> +       sysfb_disable(NULL);
>
>         aperture_detach_devices(base, size);
>
> @@ -353,8 +353,7 @@ int aperture_remove_conflicting_pci_devices(struct pc=
i_dev *pdev, const char *na
>         if (pdev =3D=3D vga_default_device())
>                 primary =3D true;
>
> -       if (primary)
> -               sysfb_disable();
> +       sysfb_disable(&pdev->dev);
>
>         for (bar =3D 0; bar < PCI_STD_NUM_BARS; ++bar) {
>                 if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index c9cb657dad08a..bef5f06a91de6 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -58,11 +58,11 @@ struct efifb_dmi_info {
>
>  #ifdef CONFIG_SYSFB
>
> -void sysfb_disable(void);
> +void sysfb_disable(struct device *dev);
>
>  #else /* CONFIG_SYSFB */
>
> -static inline void sysfb_disable(void)
> +static inline void sysfb_disable(struct device *dev)
>  {
>  }
>
> --
> 2.46.0
>


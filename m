Return-Path: <stable+bounces-69619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED2495720F
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 19:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C05283628
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A8113BAD5;
	Mon, 19 Aug 2024 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJPEMbLM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589043AB7
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088222; cv=none; b=pKd4dcSoxv4peQl7ka0o4jiBcPOLTh4RbRxSfCBiZowVZIOvqgFj/GXkgfkxDIO6M43vO1gHpcZAirjs4Befci/P0yg0LEnIO+ervkb8HCa3UuxHX8NwBcCJKPloCFo6hCToGRZ1UmDyQ67avFzcjoJ/Idnxxm1izLiKCRhiprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088222; c=relaxed/simple;
	bh=7iEg3CdZeN9kFjhiR8sNyMJcLc/me+SQj9Gqcloyy1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dPv+DGPU3Aq4LdONldSjInNnPXk53UyTuKMZ1b369RY3ZYT926P6NRxdvSyyO6or+D1yWCpKHBWiBoAJq69JD7alcJjSm5Ap7grxsM101d0bNnbfBGax8JYR2GhV6sh1ikQ0AByDChHggsmD7XRim0S0L0+igw2vJk6SqiNounA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJPEMbLM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724088219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fSh+AKHfROTY2o6Hz6Tk9lBXTICcXCJ9yq1Q239cTB8=;
	b=EJPEMbLMDI7QT5/fvJDZEI96fhtWPzoKOXzVu5+l8pS6/SNP0cu5rRMLvo4UHbmrNKDM+b
	JDosMeIdtCM8DTU0oJkOt4ndjMtwfOVL6/lYFJb6KZolk9YVOzhzh2Wa9v9mMDGEFSfflS
	roN4FRiGTrNXPhYfHdkMFqqo2RWCXi0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-ZlFf_dazNneH08mdL1weuw-1; Mon, 19 Aug 2024 13:23:38 -0400
X-MC-Unique: ZlFf_dazNneH08mdL1weuw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70d392d311cso4022765b3a.0
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724088217; x=1724693017;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSh+AKHfROTY2o6Hz6Tk9lBXTICcXCJ9yq1Q239cTB8=;
        b=Ex+1F+t9EdPX6rZOUiJcOfu1H97pvlTMDwquORRiDJo8mAn9h3aEaqYmxVhYF2fN0C
         8BuDH+4jONnk8snrAU9XY4cECGm4U04PzWDlaZ92t4i51S082rrqXKhlG5WEh6BG7jw/
         navSIWpKJDVh7l637HiVFG+SknYsCVAFbgs2eAsz4Ya1gMu7Yppkw9IvIqYYxlbg1eIq
         PJ8zqPXuJ0XhjINQAWAJ/fr34arh22RAcK4AupkVrpYRrZzyrPou9Sl31DWwCzhaBX0d
         XCVqE+hPzDQViANC1tIOf7jpXQ56fGs5dyxvy+EBDY+tfBDQRdjnO4nCgOQMpIWFFFC3
         uuFw==
X-Forwarded-Encrypted: i=1; AJvYcCXNcH1db8YpTql2UeaHeKroiBm4zKrOV8GNcMZAj/2lV0AFSTSoG1SCxd9fqMqCw7ne2ieQzu920T9FYXn0OvssPyId0GSX
X-Gm-Message-State: AOJu0Yy3Uodv98d/YGj1JfKKOO1eq/8uJDLR5LBXluBAcqq3Y6knHnqa
	Hj+qY+6l/wgHGL7H7hR7+0/gsnhcE26YFfcmMXrEddQJpnaJPEnn9WOKlY6vtuwHzsjzItIyOZw
	ZptpXL3Gu5MT/bG2MhzGGNQ92YxK5Iy733DEa3uGNx96dD1YdxINHZb+MzCCx4WkH
X-Received: by 2002:a05:6a20:9d8f:b0:1c4:b843:fa25 with SMTP id adf61e73a8af0-1c904fb656bmr11943410637.26.1724088216820;
        Mon, 19 Aug 2024 10:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSDHyDrjBuGFu+b/kmVXsnPxa87OiRQHTdxkMfzpoHRCn+Sotx/RfRkFNZUyRweZND934hmQ==
X-Received: by 2002:a05:6a20:9d8f:b0:1c4:b843:fa25 with SMTP id adf61e73a8af0-1c904fb656bmr11943383637.26.1724088216373;
        Mon, 19 Aug 2024 10:23:36 -0700 (PDT)
Received: from localhost ([2803:2a00:8:776f:e199:77:1ec5:b560])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef8996sm6790756b3a.122.2024.08.19.10.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:23:35 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, Alex Deucher
 <alexander.deucher@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Helge Deller <deller@gmx.de>, Sam
 Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 stable@vger.kernel.org
Subject: Re: [PATCH V2] video/aperture: match the pci device when calling
 sysfb_disable()
In-Reply-To: <20240819165341.799848-1-alexander.deucher@amd.com>
References: <20240819165341.799848-1-alexander.deucher@amd.com>
Date: Mon, 19 Aug 2024 19:23:33 +0200
Message-ID: <87frr0a0kq.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alex Deucher <alexander.deucher@amd.com> writes:

Hello Alex,

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
> Fixes: 5ae3716cfdcd ("video/aperture: Only remove sysfb on the default vga pci device")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> ---

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

I just have to minor comments below:

...

>  /**
>   * sysfb_disable() - disable the Generic System Framebuffers support
> + * @dev:	the device to check if non-NULL
>   *
>   * This disables the registration of system framebuffer devices that match the
>   * generic drivers that make use of the system framebuffer set up by firmware.
> @@ -61,8 +64,12 @@ static bool sysfb_unregister(void)
>   * Context: The function can sleep. A @disable_lock mutex is acquired to serialize
>   *          against sysfb_init(), that registers a system framebuffer device.
>   */
> -void sysfb_disable(void)
> +void sysfb_disable(struct device *dev)
>  {
> +	struct screen_info *si = &screen_info;
> +
> +	if (dev && dev != sysfb_parent_dev(si))
> +		return;

Does this need to be protected by the disable_lock mutex? i.e:

        mutex_lock(&disable_lock);
        if (!dev || dev == sysfb_parent_dev(si) {
                sysfb_unregister();
                disabled = true;
        }
        mutex_unlock(&disable_lock);

...

> @@ -353,8 +353,7 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
>  	if (pdev == vga_default_device())
>  		primary = true;
>
> -	if (primary)
> -		sysfb_disable();
> +	sysfb_disable(&pdev->dev);
>

After this change the primary variable is only used to determine whether 
__aperture_remove_legacy_vga_devices(pdev) should be called or not. So I
wonder if could just be dropped and instead have:

	/*
	 * If this is the primary adapter, there could be a VGA device
	 * that consumes the VGA framebuffer I/O range. Remove this
	 * device as well.
	 */
	if (pdev == vga_default_device())
		ret = __aperture_remove_legacy_vga_devices(pdev);



-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



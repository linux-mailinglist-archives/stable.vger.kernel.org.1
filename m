Return-Path: <stable+bounces-19376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91084F405
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 12:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0051F2490A
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E53E2577B;
	Fri,  9 Feb 2024 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eD5Qn1Je"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999220332
	for <stable@vger.kernel.org>; Fri,  9 Feb 2024 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476418; cv=none; b=Rt7cBw4HuSP16dy/1GQnbM1GcXf96xjmUxML/m4uZM6Q5OQtKC2ZtJkbZPUS7Nie9YAlmjWxcIua/wXPWgwEeab9bmSErHj/4fjlYUbbS9foQYSxC6MitrKMKYblDYlftCZfj16lobyWYAflyuaqyIWa5+DDv23IOppmaEQVCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476418; c=relaxed/simple;
	bh=pwBkLYkQSQRMvnuL/v4/cC2vr8Anp13gRP0ObxcX4Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2KmZe+ynFTUJd/Kr4XgRVRzaQhHBefUWnXLxoPCxp4enX9LJqqomhVNmpQlfHPsj9KsjVOOPs7/E25LeC23tktXaAndpu0m3pAoeT1u8kFpTLGJ3QyjbMKd96/gNzbvwIXNGEDQrS1ohwYLAW5vFopHtOkCUyUXYkZOCq2KDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=eD5Qn1Je; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b4bca2418so31224f8f.0
        for <stable@vger.kernel.org>; Fri, 09 Feb 2024 03:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707476415; x=1708081215; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ErqXxs7zcmxaorvJLxeIL8QoDb90GRIEAGPObd8dqj0=;
        b=eD5Qn1Jec+9Qqe660r3AWRgMFg6HfwTbHUYltaAJKhJriZ0uBTxqs5l/hzZ5RPl/2+
         2N+/TYvmhNPfP2SDtt2dBCLJtZtZGUTb3dbYAo4/GH5mgLsPs4x1p2OGIlfITLeSIoKl
         LiBVKTZxAcP6BS8iM8f26y0qgxI8MVjnQASmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476415; x=1708081215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErqXxs7zcmxaorvJLxeIL8QoDb90GRIEAGPObd8dqj0=;
        b=N8qp9cbNRLx/n1omKa+3zlH6S6cnk9Hw9qTz+5ea/yleMyg3+5/XsAXl7nL4jCVguI
         Xijw/ZIi8BTMNLOk+GPWQs1+S4PeDWZ/1Vz4+7NZvubxp4B6Au3jkae8Qz0N25B8vkEh
         9ivw6w3F9Y8MJVyeBZPvfISgvu2wJpy3Wb+wnG8zCsrfmvGpMbMlHVDX2k/oS2LKBkWO
         uG/52/6dMlDZK5QMkDKRY9VVct/G78rMPZj9Zgpt31eSlnXOzGlFhYClwhPT6Vy96WNo
         0nL1BxRdRPAeZiQ+YLQ5JxKU8wTyemRI//CkmxHnvIwK8+aSAWJSjABkYS2bf8NQZbHl
         p7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZKvG7LVJ3U/kAIgBS/K5Tfq4AT9GDg7UYnDhAbyLGSSXsSs1PowIiD5BvHIpE1nySQPwotiZV48//lXOr4IUfQ5rFZ3ss
X-Gm-Message-State: AOJu0YxFWj21hVcY76U4cxEJyzUQdgXXTcB/6GsDzbft0Z18qvRt4zX/
	NUsSvhbi4aCOiiPADmzEjpja+XFl091fAkqXswwor70YlhG/7cKudbDAIW/ypaU=
X-Google-Smtp-Source: AGHT+IEuXfaY9KBR9zsA3duPazyDD+I8pvQvlxqK/2eTeHa8KAeZqhfP1yN0TAPaRflSJwHnbU0Iwg==
X-Received: by 2002:a05:6000:38c:b0:33b:5197:7136 with SMTP id u12-20020a056000038c00b0033b51977136mr1111009wrf.2.1707476414599;
        Fri, 09 Feb 2024 03:00:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHGQW0GPUdhcR5AQwoTXl3BpkEMSBlqTfxVZFRu6MUe/O4/U+wRxF2qh19k0ClVYO9HHv3DcGLj95tj+GEy1wl+GQYzYSDdQdrlmUJYsMGa9GCyEiDTVoR3IIdBCrNnwRPjjX4g5WNs/vjIl8rAwct71x9ljvYkwzDBeAPDUMXoB1WV9f6JdwiVCnAltzf4i5NRW0DFKIgEHGeGrIylNiJfLeAtFQ1xHxdWuu8NkpGcbvvBm+mJU7Jcw5ifIJzxPdUnREub1HyASwUYtHwh2XgdvkmOod4PYpaExV3YgSrOnEWp5FwrfXoguzfqq8tu+A3mIguzsNS5t1an91pbE+xBjHtFIhj/7pT0CasiePDGV90FU3siIuK19VW0l6vi+A7WNmsARlda2Yhimcb9Ms2zTnCeHXULMJR3cZVGntLwt/lDg7urP5JL2woihym04otl25pjKTW+fLEr0m6vdtl0rhGGK6VqPdFHY3nQtaZt07+oGqdqzwgxCZtDaaKkfLgowpYUvwsC+InwyJ5fzaoyM94w5MLAyVr+d4W0gjGFlHL2iKrw68m+uuIQm0L3Y5v0wJ+K0rayxexGUr10RqQll0skTdOdXz/aXgfF3lBQhZuZ5mOUd0UkNkLedTaCSFLAE7KqyULbLNvacc53qateKluJnQsnxccYcjIWx0rp2paiFWYJMLhk8Wi0L/8NTnox6cztAm2oTG4bF2vGhT3N59mo7afNf16OXpVURJ0KtVGm584unuadqm22xLec9oP6oAlHkZMwPlXWns=
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j18-20020adff012000000b0033b44b4da56sm1494073wro.111.2024.02.09.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 03:00:14 -0800 (PST)
Date: Fri, 9 Feb 2024 12:00:11 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Le Ma <le.ma@amd.com>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	James Zhu <James.Zhu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Shi <alexs@kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>,
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/amdgpu: wire up the can_remove() callback
Message-ID: <ZcYFu65EOaiZsSnC@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Le Ma <le.ma@amd.com>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	James Zhu <James.Zhu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Shi <alexs@kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>,
	Wei Liu <wei.liu@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
References: <20240202222603.141240-1-hamza.mahfooz@amd.com>
 <20240202222603.141240-3-hamza.mahfooz@amd.com>
 <2024020225-faceless-even-e3f8@gregkh>
 <ZcJCLkNoV-pVU8oy@phenom.ffwll.local>
 <051a3088-048e-4613-9f22-8ea17f1b9736@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <051a3088-048e-4613-9f22-8ea17f1b9736@gmail.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Tue, Feb 06, 2024 at 07:42:49PM +0100, Christian K�nig wrote:
> Am 06.02.24 um 15:29 schrieb Daniel Vetter:
> > On Fri, Feb 02, 2024 at 03:40:03PM -0800, Greg Kroah-Hartman wrote:
> > > On Fri, Feb 02, 2024 at 05:25:56PM -0500, Hamza Mahfooz wrote:
> > > > Removing an amdgpu device that still has user space references allocated
> > > > to it causes undefined behaviour.
> > > Then fix that please.  There should not be anything special about your
> > > hardware that all of the tens of thousands of other devices can't handle
> > > today.
> > > 
> > > What happens when I yank your device out of a system with a pci hotplug
> > > bus?  You can't prevent that either, so this should not be any different
> > > at all.
> > > 
> > > sorry, but please, just fix your driver.
> > fwiw Christian K�nig from amd already rejected this too, I have no idea
> > why this was submitted
> 
> Well that was my fault.
> 
> I commented on an internal bug tracker that when sysfs bind/undbind is a
> different code path from PCI remove/re-scan we could try to reject it.
> 
> Turned out it isn't a different code path.

Yeah it's exactly the same code, and removing the sysfs stuff means we
cant test hotunplug without physical hotunplugging stuff anymore. So
really not great - if one is buggy so is the other, and sysfs allows us to
control the timing a lot better to hit specific issues.
-Sima

> >   since the very elaborate plan I developed with a
> > bunch of amd folks was to fix the various lifetime lolz we still have in
> > drm. We unfortunately export the world of internal objects to userspace as
> > uabi objects with dma_buf, dma_fence and everything else, but it's all
> > fixable and we have the plan even documented:
> > 
> > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#device-hot-unplug
> > 
> > So yeah anything that isn't that plan of record is very much no-go for drm
> > drivers. Unless we change that plan of course, but that needs a
> > documentation patch first and a big discussion.
> > 
> > Aside from an absolute massive pile of kernel-internal refcounting bugs
> > the really big one we agreed on after a lot of discussion is that SIGBUS
> > on dma-buf mmaps is no-go for drm drivers, because it would break way too
> > much userspace in ways which are simply not fixable (since sig handlers
> > are shared in a process, which means the gl/vk driver cannot use it).
> > 
> > Otherwise it's bog standard "fix the kernel bugs" work, just a lot of it.
> 
> Ignoring a few memory leaks because of messed up refcounting we actually got
> that working quite nicely.
> 
> At least hot unplug / hot add seems to be working rather reliable in our
> internal testing.
> 
> So it can't be that messed up.
> 
> Regards,
> Christian.
> 
> > 
> > Cheers, Sima
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


Return-Path: <stable+bounces-78377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E7898B8E5
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FFD282E1D
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67121A0723;
	Tue,  1 Oct 2024 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jSyOPxct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FAF19F49F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777088; cv=none; b=s2rGzoOq9HpR0xGejSDS7quVOaOcaqRwR+8K/AE3Csd4s0K44Fs7DxGXKT9nor+hU3jj2EiBWb4OXVVagPqbk7PXIaRV9ukIfDviOOqV6TRQalGW4Cpr/BF0al9+bUWoKmkrZIqKE6ON/mQu1HuXhbtSi3itXl3NxXpDmpLEda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777088; c=relaxed/simple;
	bh=i2tcObmlpvsS8NgZbupkXXpot1pmlYredro7AtO+pyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwF3WwSCj79bikCzzYA8Qdh4zuQzS8N7O6O9UhxI/1nUlXsWMx9WfkDZ1xCwckytauXw8XLn0WCQ7mvHeCI+RQ8fRYfdzrv2hbQx5qb3hOQtmMgiMAlaR7ji3CVOzPU6BSv+Y2sjxvDjFIbbJ3PfNxp0L1zDkgXqULHfaYRBJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jSyOPxct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF41BC4CEC6;
	Tue,  1 Oct 2024 10:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727777088;
	bh=i2tcObmlpvsS8NgZbupkXXpot1pmlYredro7AtO+pyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSyOPxctnMyGOgWtdIydISdY0Kz4VE1SFalG+VytV1zSTtUSKbWZ2c9MBkuCoCGlP
	 vOfjWU6Shc16DwWtFns3jhWGkXGmC9G6cKek60BTY861vz547Oitogvl8Ecgi6tzNl
	 ZMA3PwnZSqaU32ROxQVpRZqn6jA5slHhGStcz6Uo=
Date: Tue, 1 Oct 2024 12:04:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: AMD drm patch workflow is broken for stable trees
Message-ID: <2024100112-flounder-paralysis-eb25@gregkh>
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
 <2024081558-filtrate-stuffed-db5b@gregkh>
 <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
 <2024082439-extending-dramatize-09ca@gregkh>
 <CADnq5_OeJ7LD0DvXjXmr-dV2ciEhfiEEEZsZn3w1MKnOvL=KUA@mail.gmail.com>
 <2024090447-boozy-judiciary-849b@gregkh>
 <CADnq5_MZ8s=jcCt_-=D2huPA=X3f5PWNjMhr88xoiKc_JFwQtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_MZ8s=jcCt_-=D2huPA=X3f5PWNjMhr88xoiKc_JFwQtw@mail.gmail.com>

On Mon, Sep 30, 2024 at 10:10:25AM -0400, Alex Deucher wrote:
> Resending now that rc1 is out.  These should be ignored for stable.
> 
> 8151a6c13111 drm/amd/display: Skip Recompute DSC Params if no Stream on Link
> fbfb5f034225 drm/amdgpu: fix contiguous handling for IB parsing v2
> ec0d7abbb0d4 drm/amd/display: Fix Potential Null Dereference
> 332315885d3c drm/amd/display: Remove ASSERT if significance is zero in
> math_ceil2
> 295d91cbc700 drm/amd/display: Check for NULL pointer
> 6472de66c0aa drm/amd/amdgpu: Fix uninitialized variable warnings
> 93381e6b6180 drm/amdgpu: fix a possible null pointer dereference
> 7a38efeee6b5 drm/radeon: fix null pointer dereference in radeon_add_common_modes

Thanks, that helped a lot.

However the following two commits did not apply, is that because they
are already in the tree or do they need someone to properly backport them?

c2ed7002c061 ("drm/amd/display: Use SDR white level to calculate matrix coefficients")
b74571a83fd3 ("drm/amd/display: Use full update for swizzle mode change")

thanks,

greg k-h


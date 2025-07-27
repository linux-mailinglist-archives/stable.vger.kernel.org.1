Return-Path: <stable+bounces-164851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDE5B12DC9
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 07:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D2A166EEF
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 05:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E166F198E8C;
	Sun, 27 Jul 2025 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tXz6EQdB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A8E1114;
	Sun, 27 Jul 2025 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753594101; cv=none; b=pIu/U4lGvE7k61hl06lyPdeG7mjrTofPVp2ND0RplvHnH/qB0n+htNPtcFDZRHQHWFRDfJu5EsZooPyf2WSMr/F0hxYnFF+ix6QJFI28fhb1OjBbo+kDJhLxNW1LamWwzh2v/AVVs7vTuRzPxA1oDgFOJs+2CzsD7PsUGU29kkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753594101; c=relaxed/simple;
	bh=F0QM02Ui4yMHpMGEue/MbddjFcHQ2e4EXDJlxhgCpL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAMZfj/JgvEKKIKW2UhGWGZevtl1RJdVFlPekgUHorRRM8TyvqeDb35arLrN56J9lXqC7P6TPLQHxIndGzxYEAwjswHhFo5s9jF7gI9a6r+3/cocHN/cMKV/WUGfrLmOoKuGFFAPs5oRGfGGHE+MeuHs9VLjDO6gpQzxHeg9mDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tXz6EQdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860A2C4CEEB;
	Sun, 27 Jul 2025 05:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753594100;
	bh=F0QM02Ui4yMHpMGEue/MbddjFcHQ2e4EXDJlxhgCpL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tXz6EQdBOuardgqn/IxtHuiBMu3qSYyCkcaVAhgEzScpXvf4cXEkYK+0TtVExQI04
	 J7lbrkec3ORam5xrJWQD98T7fWUEM2WedhcxijxYQVCsE5xD7B1M2hMYPt01rXG8F6
	 LFR2QxKawvlJi0bamK7OqM9lzJzKoJ0lERmUSP3Y=
Date: Sun, 27 Jul 2025 07:28:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	1109776@bugs.debian.org, jeffbai@aosc.io
Subject: Re: [PATCH 1/1] Mark xe driver as BROKEN if kernel page size is not
 4kB
Message-ID: <2025072708-saxophone-watch-3020@gregkh>
References: <20250727042825.8560-1-Simon.Richter@hogyros.de>
 <20250727042825.8560-2-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727042825.8560-2-Simon.Richter@hogyros.de>

On Sun, Jul 27, 2025 at 01:27:36PM +0900, Simon Richter wrote:
> This driver, for the time being, assumes that the kernel page size is 4kB,
> so it fails on loong64 and aarch64 with 16kB pages, and ppc64el with 64kB
> pages.
> ---
>  drivers/gpu/drm/xe/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 2bb2bc052120..7c9f1de7b35f 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config DRM_XE
>  	tristate "Intel Xe2 Graphics"
> -	depends on DRM && PCI
> +	depends on DRM && PCI && (PAGE_SIZE_4KB || BROKEN)
>  	depends on KUNIT || !KUNIT
>  	depends on INTEL_VSEC || !INTEL_VSEC
>  	depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
> -- 
> 2.47.2
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>


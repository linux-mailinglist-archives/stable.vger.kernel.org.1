Return-Path: <stable+bounces-165084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0576B14F8B
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473381890586
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA241CD215;
	Tue, 29 Jul 2025 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="afn96V7A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1E1A83ED
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800665; cv=none; b=K7z5mEPLqxMvNg1qZULI5gffIcjL4nA+hyzWAMWKKumqtz0hHlv/IJkz0sUWk9OYwibckenJVwUgblP9SGG0DFUzwcTG+vMOj4JjeKQWkQ3gHdB4LaDDC0IySSNYO/Ix7gIAu7T90E0l6yH5IX4xWlKhuLxWgtNKYPRnHUgXmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800665; c=relaxed/simple;
	bh=GqM4igQz/uC68HfPXSecgeMtUMC4mBIEFFLq2+WOY6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfI4R8XeUnO+Ltk5/4LyOaGiyoZ+jRzS3s1Rnu35jtchr/KqDIpjiYdlSXCpmw5HX7fFUm6jipvH21kDv9S16snlZxR8q01/43z4PUORvKAOfRyC3PFGNfUF1F9/eCwmsRzTxB7IKCZnakHDasdbX9+d7vg7NBhQLGqdR0s6xis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=afn96V7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCBAC4CEEF;
	Tue, 29 Jul 2025 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753800664;
	bh=GqM4igQz/uC68HfPXSecgeMtUMC4mBIEFFLq2+WOY6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afn96V7A8ikwZqL3ADzYggNvIEMIaPM8VfAacWZ5fIflFLKQ9/KgQeTWv1aVb+D7d
	 FwsYSc079CUJjy9J1kkK4u5gM6GgmcE3eIJOU8VpDE44EO8Ca3Gg1pYTMyMr9aS749
	 VtkCwhZxEheEodnLEZFi/xkUz5CuN4jmMrXlQ/js=
Date: Tue, 29 Jul 2025 16:51:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-xe@lists.freedesktop.org, stable@vger.kernel.org,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH 6.12 4/4] Revert "drm/xe/forcewake: Add a helper
 xe_force_wake_ref_has_domain()"
Message-ID: <2025072932-unjustly-thirty-b125@gregkh>
References: <20250729110525.49838-1-tomitamoeko@gmail.com>
 <20250729110525.49838-5-tomitamoeko@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729110525.49838-5-tomitamoeko@gmail.com>

On Tue, Jul 29, 2025 at 07:05:25PM +0800, Tomita Moeko wrote:
> This reverts commit deb05f8431f31e08fd6ab99a56069fc98014dbec.
> 
> The helper function introduced in the reverted commit is for handling
> the "refcounted domain mask" introduced in commit a7ddcea1f5ac
> ("drm/xe: Error handling in xe_force_wake_get()"). Since that API change
> only exists in 6.13 and later, this helper is unnecessary in 6.12 stable
> kernel.
> 
> Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  drivers/gpu/drm/xe/xe_force_wake.h | 16 ----------------
>  1 file changed, 16 deletions(-)

We need acks from the maintainers/developers for all of these before we
can take the series.  Please work on getting that.

thanks,

greg k-h


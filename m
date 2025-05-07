Return-Path: <stable+bounces-142070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA1AAE314
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67289C25F9
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8EC14B08A;
	Wed,  7 May 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uzyQ2Mam"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100FF1DE4F1
	for <stable@vger.kernel.org>; Wed,  7 May 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628029; cv=none; b=MlZjsKZ2iaruMWoxJMwofeSPw+ZXlMPWM+VrUxtY+CMeVLYUyL6yUGBxXNOfCVjxVdPhpcmmYMrcfPMN4533d/GjccG6VlAEDRLhTdSOJ1f8SFB/HMvP6qdhFA3lfv4qKdtmp92V+WbJF0EONP/faWMn7pBDzLR+CmCpruO7hrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628029; c=relaxed/simple;
	bh=6KJt6AEHdPjfiYl5lCKe+VkbfYZ04vqceJMrSVsW31w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRkYYFNN4ypyRTq5c8zE/PrEp8Ao+ERPdvlLJWb9LjAtebOc6G2flZO1M759W0vmWFybIFMu7ifi9gz/XTcoQxAb1riBMmx3A7V2pr7LwDc7F7KL2T+t+QevQO/jZCaOIgSxM4lcQR6Ro/fiibkG3EQscX8MHds/EBuCc1b9xZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uzyQ2Mam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CACC4CEE2;
	Wed,  7 May 2025 14:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746628028;
	bh=6KJt6AEHdPjfiYl5lCKe+VkbfYZ04vqceJMrSVsW31w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzyQ2MamCDSS1GND4jjIU5z5IRjOZwagAUrza9poOelwN+za6AVmgCT/saIepZcJK
	 kyzSvCpoB9ZRt6Aoy4vQ7LzasTwY1cpcwA2ZfFGrxfmNU34AlMM6jFqeYjU99K4rp6
	 bl+5RRgB+j7z2AHavuzgIWhxdT2J8aoLebbGPQTA=
Date: Wed, 7 May 2025 16:27:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: stable@vger.kernel.org,
	Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Subject: Re: [PATCH 6.12.y] drm/xe: Ensure fixed_slice_mode gets set after
 ccs_mode change
Message-ID: <2025050704-partition-bulginess-17fc@gregkh>
References: <2025042256-unshackle-unwashed-bd50@gregkh>
 <20250505161316.3451888-2-lucas.demarchi@intel.com>
 <2025050745-fifteen-shaky-2bca@gregkh>
 <pynmef4t3qofsx7tw6b4iymhaikb3kwt7svbha4wz3rd5ev4hj@5ta6hogd2i2a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pynmef4t3qofsx7tw6b4iymhaikb3kwt7svbha4wz3rd5ev4hj@5ta6hogd2i2a>

On Wed, May 07, 2025 at 08:58:27AM -0500, Lucas De Marchi wrote:
> On Wed, May 07, 2025 at 11:25:20AM +0200, Greg KH wrote:
> > On Mon, May 05, 2025 at 09:13:17AM -0700, Lucas De Marchi wrote:
> > > From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> > > 
> > > The RCU_MODE_FIXED_SLICE_CCS_MODE setting is not getting invoked
> > > in the gt reset path after the ccs_mode setting by the user.
> > > Add it to engine register update list (in hw_engine_setup_default_state())
> > > which ensures it gets set in the gt reset and engine reset paths.
> > > 
> > > v2: Add register update to engine list to ensure it gets updated
> > > after engine reset also.
> > > 
> > > Fixes: 0d97ecce16bd ("drm/xe: Enable Fixed CCS mode setting")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> > > Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > Link: https://lore.kernel.org/r/20250327185604.18230-1-niranjana.vishwanathapura@intel.com
> > > (cherry picked from commit 12468e519f98e4d93370712e3607fab61df9dae9)
> > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > > (cherry picked from commit 262de94a3a7ef23c326534b3d9483602b7af841e)
> > 
> > Wrong git id, please use the git id that the original commit is in
> > Linus's tree, NOT the stable branch only.  Please fix and resend a v2.
> 
> It's the same old issue "it's a cherry-pick of a cherry-pick".
> 262de94a3a7ef23c326534b3d9483602b7af841e is exactly what reached Linus's
> tree:
> 
> 	$ git tag --contains 262de94a3a7ef23c326534b3d9483602b7af841e 'v6.*'
> 	v6.15-rc2
> 	v6.15-rc3
> 	v6.15-rc4
> 	v6.15-rc5
> 
> and what was in your instructions in
> 2025042256-unshackle-unwashed-bd50@gregkh :
> 
> 	git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> 	git checkout FETCH_HEAD
> 	git cherry-pick -x 262de94a3a7ef23c326534b3d9483602b7af841e
> 	# <resolve conflicts, build, test, etc.>
> 	git commit -s
> 	git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042256-unshackle-unwashed-bd50@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> Looking at linux-6.12.y for other cases:
> a43e53e310a4bba252a3f8d1500f123a23e9a009 for example. I thought about
> going ahead and doing the "commit XXXXX upstream.", but then it could
> break on your side because the last "cherry picked from"  doesn't match.

Argh, this is my fault, sorry.  I hadn't updated my local database of
commits for -rc2 or -rc3 and so this showed up as not being in anything
but a stable release.

I'll go take this now, sorry.  And yes, this "cherry pick" double stuff
is crazy, and really is a pain for everyone on our end, hopefully one
day it stops...

greg k-h


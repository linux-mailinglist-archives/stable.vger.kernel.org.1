Return-Path: <stable+bounces-108323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACADA0A8B5
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 12:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45953A91E7
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 11:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F6214A0B3;
	Sun, 12 Jan 2025 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QHvQyr2n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC9A1B0424
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681987; cv=none; b=TZk9s1Q+IxJhDv7WQyZiihmxsjh9UJaZX4IVRQB7nqZINfxJI8k9g9e2KbaMGMOKdROi6LUu1DJEdmNa+re4oJUoofREjrlcr7OJIT9pwZKf8BbnY2DQ/skl3aPfrzx889U/lOeQX8aS5HNilid/fNWe7tyWOXVblQXeFx5NOW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681987; c=relaxed/simple;
	bh=8IypaYh4K3zDyThWiWzbqnXIzxzIHhRJYQ+yKKDwBMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjdpzonKkshdF2bUjHA3aF2Htnv7/MxgtiHWDaClGGQKHN0sh66Dt2E0YI3wX1s+LCOAQq7wQFDh62gKNCZNfzmYHcH1MGFCS0n4RlaXEXPP5chAHEhR5u2YZ7r6422jpIG+9j8/j1Rz8axzBY92p1ZxvhnEuQh0Xk3M6b2NM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QHvQyr2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF090C4CEDF;
	Sun, 12 Jan 2025 11:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736681987;
	bh=8IypaYh4K3zDyThWiWzbqnXIzxzIHhRJYQ+yKKDwBMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QHvQyr2nQuZB7Y+XV1BgTLNwnI02J26Y5Z6ucPbNg47uEQc4YTHrCHnH8r9Qw9Q6K
	 FtaO66hbdg31keJvideJ5NrIgC4rfcO4qc9E7un+sKedYKeiCjxex4AWd2ffcmDXi9
	 Tut/N5xgMjkt93WL5hgzHP69jzVu+f/jt3OJ8moo=
Date: Sun, 12 Jan 2025 12:39:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: stable@vger.kernel.org, ashutosh.dixit@intel.com,
	dri-devel@lists.freedesktop.org
Subject: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode of
 operation for OAR/OAC)
Message-ID: <2025011215-agreeing-bonfire-97ae@gregkh>
References: <2025010650-tuesday-motivate-5cbb@gregkh>
 <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>

On Fri, Jan 10, 2025 at 12:53:41PM -0800, Umesh Nerlige Ramappa wrote:
> commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream

<snip>

> Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA stream close")
> Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> Reviewed-by: Matthew Brost <matthew.brost@intel.com> # commit 1
> Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: stable@vger.kernel.org # 6.12+
> Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20241220171919.571528-2-umesh.nerlige.ramappa@intel.com
> (cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> (cherry picked from commit f0ed39830e6064d62f9c5393505677a26569bb56)

Oh I see what you all did here.

I give up.  You all need to stop it with the duplicated git commit ids
all over the place.  It's a major pain and hassle all the time and is
something that NO OTHER subsystem does.

Yes, I know that DRM is special and unique and running at a zillion
times faster with more maintainers than any other subsystem and really,
it's bigger than the rest of the kernel combined, but hey, we ALL are a
common project here.  If each different subsystem decided to have their
own crazy workflows like this, we'd be in a world of hurt.  Right now
it's just you all that is causing this world of hurt, no one else, so
I'll complain to you.

We have commits that end up looking like they go back in time that are
backported to stable releases BEFORE they end up in Linus's tree and
future releases.  This causes major havoc and I get complaints from
external people when they see this as obviously, it makes no sense at
all.

And it easily breaks tools that tries to track where backports went and
if they are needed elsewhere, which ends up missing things because of
this crazy workflow.  So in the end, it's really only hurting YOUR
subsystem because of this.

And yes, there is a simple way to fix this, DO NOT TAG COMMITS THAT ARE
DUPLICATES AS FOR STABLE.  Don't know why you all don't do that, would
save a world of hurt.

I'm tired of it, please, just stop.  I am _this_ close to just ignoring
ALL DRM patches for stable trees...

greg k-h


Return-Path: <stable+bounces-73095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7B96C55E
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 19:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FF2B2672D
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218014778C;
	Wed,  4 Sep 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fqR2QsG/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F93D0AD
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470587; cv=none; b=iLu/wtLzjdUGa7kXoRUrUILLBlQjMXERgCXXLkbsLwMvLbpCFL0xSv4nkn/Yc7HZnsdwEmQqYovPgx29YEKXYu137id9Vf9JfbIXTK5desXs+JhsOErQXVO4DSWAvvPxwZtgIdpx0C0TCzzzqIIx2qlq4pk9c2abl1IRR5EhlSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470587; c=relaxed/simple;
	bh=MKVWiXAJ+7Pq+eolEHDrok3t8EEZ6mlOOGqnV70ub0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAZJXa2ypigkTU0NDjPjGe9wnkqaAQrO0EPA2Rcmo8s/7HoIefCRJbUcQSrDFlncZNqDL5zbnCu+jvR5AXjEkwcKVp7X3yprXran4udEOQh+ti/K2zZ3TelYkDRrDtqXHZihKc3HoeuuH8Cp0YF6nmIVS92x9I7AHh0KaTd1R5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fqR2QsG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C0DC4CEC2;
	Wed,  4 Sep 2024 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725470587;
	bh=MKVWiXAJ+7Pq+eolEHDrok3t8EEZ6mlOOGqnV70ub0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqR2QsG/5A2d7tJRY3kzsPBXJIdIWhE8IMlbxaF6CK0DGsTCsuVHVVX9FM/jtWTEZ
	 iIJvDdnnKhemLvI0O0a824vfqnrJUvg6LzfvODA2LMx2nKa4IG90XKTXPe4ymppHvX
	 GOAyL73b/IdXjPzRqZgCcb7FODGsKwmHTIzV2Mpw=
Date: Wed, 4 Sep 2024 19:23:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: AMD drm patch workflow is broken for stable trees
Message-ID: <2024090447-boozy-judiciary-849b@gregkh>
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
 <2024081558-filtrate-stuffed-db5b@gregkh>
 <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
 <2024082439-extending-dramatize-09ca@gregkh>
 <CADnq5_OeJ7LD0DvXjXmr-dV2ciEhfiEEEZsZn3w1MKnOvL=KUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_OeJ7LD0DvXjXmr-dV2ciEhfiEEEZsZn3w1MKnOvL=KUA@mail.gmail.com>

On Tue, Aug 27, 2024 at 10:18:27AM -0400, Alex Deucher wrote:
> On Sat, Aug 24, 2024 at 1:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Aug 23, 2024 at 05:23:46PM -0400, Alex Deucher wrote:
> > > On Thu, Aug 15, 2024 at 1:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Aug 14, 2024 at 05:30:08PM -0400, Alex Deucher wrote:
> > > > > On Wed, Aug 14, 2024 at 4:55 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
> > > > > >
> > > > > > On 2024-08-12 11:00, Greg KH wrote:
> > > > > > > Hi all,
> > > > > > >
> > > > > > > As some of you have noticed, there's a TON of failure messages being
> > > > > > > sent out for AMD gpu driver commits that are tagged for stable
> > > > > > > backports.  In short, you all are doing something really wrong with how
> > > > > > > you are tagging these.
> > > > > > Hi Greg,
> > > > > >
> > > > > > I got notifications about one KFD patch failing to apply on six branches
> > > > > > (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that you
> > > > > > already applied this patch on two branches back in May. The emails had a
> > > > > > suspicious looking date in the header (Sep 17, 2001). I wonder if there
> > > > > > was some date glitch that caused a whole bunch of patches to be re-sent
> > > > > > to stable somehow:
> > > > >
> > > > > I think the crux of the problem is that sometimes patches go into
> > > > > -next with stable tags and they end getting taken into -fixes as well
> > > > > so after the merge window they end up getting picked up for stable
> > > > > again.  Going forward, if they land in -next, I'll cherry-pick -x the
> > > > > changes into -fixes so there is better traceability.
> > > >
> > > > Please do so, and also work to not have duplicate commits like this in
> > > > different branches.  Git can handle merges quite well, please use it.
> > > >
> > > > If this shows up again in the next -rc1 merge window without any
> > > > changes, I'll have to just blackhole all amd drm patches going forward
> > > > until you all tell me you have fixed your development process.
> > >
> > > Just a heads up, you will see some of these when the 6.12 merge window
> > > due to what is currently in -next and the fixes that went into 6.11,
> > > but going forward we have updated our process and it should be better.
> >
> > Can you give me a list of the git ids that I should be ignoring for
> > 6.12-rc1?  Otherwise again, it's a huge waste of time on my side trying
> > to sift through them and figure out if the rejection is real or not...
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

Please resend this after -rc1 is out, so we don't have to hunt for it
again.

thanks,

greg k-h


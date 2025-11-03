Return-Path: <stable+bounces-192107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E294C29B30
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DA5188C368
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CDB148850;
	Mon,  3 Nov 2025 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lNryT9Ap"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB612C187
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762129362; cv=none; b=f81/cuUe7COjjKfLPR/5ehxTJzrQYxF/qXy+4ggSW+rdwwqgaWu1KpbnK4HnaesK/iOVFSR7ue9y09hOP3XaelJ68nP8WUsgz3oOHoNaDXQJUYc6G3kiLwGY4JxGyXNdvkS9NcmbZpQyAJuaQpy7W1u8ckSoF7rc8+OtRou3Upw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762129362; c=relaxed/simple;
	bh=der6DsO5luNtDoqe0A1QV3xbWy/+AcsE3rQNQJvcPAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1ZECzZYwXRGGOReW+DkWYTeb+DpaWQYOkz5FAq1bT4bJ1SpzzGHLL1ZL9Iow0nPFIZMf4WESb/LlGsVWDTuoBfBU3KudkQAzDok86IoHa5sRiwAScnPzuZ7tEUPEvzKXy9xlt+42Qp+lnYGunMJztQy5T6ziHbOms/O3YiYSEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lNryT9Ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C30C4CEFB;
	Mon,  3 Nov 2025 00:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762129362;
	bh=der6DsO5luNtDoqe0A1QV3xbWy/+AcsE3rQNQJvcPAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNryT9ApIAMPWqFLgeolT2CXF3/kdrKomx54YI9+8JASodzvQ2uScOhQ0baRySrzr
	 hrrai8U8fyAAMAE6xnqZZpTMBUzoA/qxAQcoh3OHFq3gMyxWmrdB6sHTplYElLo7/k
	 2lu3MKNkmTCy9MKo5idT1yJgEmrntmpH4WudK9Ys=
Date: Mon, 3 Nov 2025 09:22:38 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: Missing backport of 3c591faadd8a ("Reapply "Revert
 drm/amd/display: Enable Freesync Video Mode by default"") in 6.1.y stable
 series?
Message-ID: <2025110326-recollect-tassel-59ed@gregkh>
References: <aQEW4d5rPTGgSFFR@eldamar.lan>
 <BL1PR12MB5144C73B441AAC82055D9A6EF7FAA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <aQexyJCsE1Mx5Z05@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQexyJCsE1Mx5Z05@eldamar.lan>

On Sun, Nov 02, 2025 at 08:32:24PM +0100, Salvatore Bonaccorso wrote:
> Hi Alex
> 
> On Wed, Oct 29, 2025 at 09:47:35PM +0000, Deucher, Alexander wrote:
> > [Public]
> > 
> > > -----Original Message-----
> > > From: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com> On Behalf Of
> > > Salvatore Bonaccorso
> > > Sent: Tuesday, October 28, 2025 3:18 PM
> > > To: stable <stable@vger.kernel.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Sasha Levin
> > > <sashal@kernel.org>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> > > Hamza Mahfooz <hamza.mahfooz@amd.com>
> > > Subject: Missing backport of 3c591faadd8a ("Reapply "Revert drm/amd/display:
> > > Enable Freesync Video Mode by default"") in 6.1.y stable series?
> > >
> > > Hi
> > >
> > > We got in Debian a request to backport 3c591faadd8a ("Reapply "Revert
> > > drm/amd/display: Enable Freesync Video Mode by default"") for the kernel in Debian
> > > bookworm, based on 6.1.y stable series.
> > >
> > > https://bugs.debian.org/1119232
> > >
> > > While looking at he request, I noticed that the series of commits had a bit of a
> > > convuluted history.  AFAICT the story began with:
> > >
> > > de05abe6b9d0 ("drm/amd/display: Enable Freesync Video Mode by default"), this
> > > landed in 5.18-rc1 (and backported to v6.1.5, v6.0.19).
> > >
> > > This was then reverted with 4243c84aa082 ("Revert "drm/amd/display:
> > > Enable Freesync Video Mode by default""), which landed in v6.3-rc1 (and in turn
> > > was backported to v6.1.53).
> > >
> > > So far we are in sync.
> > >
> > > The above was then reverted again, via 11b92df8a2f7 ("Revert "Revert
> > > drm/amd/display: Enable Freesync Video Mode by default"") applied in
> > > v6.5-rc1 and as well backported to v6.1.53 (so still in sync).
> > >
> > > Now comes were we are diverging: 3c591faadd8a ("Reapply "Revert
> > > drm/amd/display: Enable Freesync Video Mode by default"") got applied later on,
> > > landing in v6.9-rc1 but *not* in 6.1.y anymore.
> > >
> > > I suspect this one was not applied to 6.1.y because in meanwhile there was a
> > > conflict to cherry-pick it cleanly due to context changes due to
> > > 3e094a287526 ("drm/amd/display: Use drm_connector in create_stream_for_sink").
> > >
> > > If this is correct, then the 6.1.y series can be brough in sync with cherry-picking the
> > > commit and adjust the context around the change.
> > > I'm attaching the proposed change.
> > >
> > > Alex in particular, does that make sense?
> > 
> > Yes, that makes sense to me.
> 
> Thanks for the confirmation. Greg, Sasha so can this be picked up as
> well for 6.1.y? The patch was attached in previous message, but I can
> resubmit it if needed.

can you resubmit please?

thanks,

greg k-h


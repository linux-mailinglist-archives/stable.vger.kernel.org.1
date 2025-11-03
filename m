Return-Path: <stable+bounces-192133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB65C29C85
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 02:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421163ACC78
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 01:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6A2273D8A;
	Mon,  3 Nov 2025 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gy0Kefmx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949A1C75E2
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762133338; cv=none; b=U4TNMKxkLc5FrjG4BxExbqYCgOQdtQ23DS7Y6qvWSKcmnpWfvHje1XQQWwwjmhQfjBIs2G0QICqcs8CKo6RUq6nrAusnKaQnznWR07TGbIliAXmah6kyTKfss9Hw2ZVkc0YBqdwMiox02G4xNQKhvE1WaONV3ciUD6MQ++ZVQag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762133338; c=relaxed/simple;
	bh=aJ4ZIzTKjn1a2VJJtiDVDcakyXytjX1grNNFgkjdc9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJwGceQG1utGccgOy/uUY/m6FkzlsFakBnB9Am0rMRqXb8OJ1bIqXFoogZFgXkBq/dYl3B9aqpzF7CIFhq4AqUYFz7TIALMmnrJqMt+iV4xs0QvylbxLX4vcFXtolLI+j5NNwhLP7sy8psb030tnlz7F0R1nEv4IGDqDOgdifL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gy0Kefmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9232C4CEF7;
	Mon,  3 Nov 2025 01:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762133338;
	bh=aJ4ZIzTKjn1a2VJJtiDVDcakyXytjX1grNNFgkjdc9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gy0KefmxYlBq9f7sbsVhQGECWK18p1un980DwKAxxHO20l/s0b2pTLoPjkIOJ5V4y
	 WchwXDaSyiA5ymQtLoWCdYj6gsO40iqGWhIV2Br2TsHEtJJOFPOeNfVB6RbrJ8faYZ
	 0+4etAylOoQKa6ywpD6a8xevdpzva71DshMXTLpE=
Date: Mon, 3 Nov 2025 10:28:56 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: Missing backport of 3c591faadd8a ("Reapply "Revert
 drm/amd/display: Enable Freesync Video Mode by default"") in 6.1.y stable
 series?
Message-ID: <2025110347-unknotted-salad-52f4@gregkh>
References: <aQEW4d5rPTGgSFFR@eldamar.lan>
 <BL1PR12MB5144C73B441AAC82055D9A6EF7FAA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <aQexyJCsE1Mx5Z05@eldamar.lan>
 <2025110326-recollect-tassel-59ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025110326-recollect-tassel-59ed@gregkh>

On Mon, Nov 03, 2025 at 09:22:38AM +0900, Greg Kroah-Hartman wrote:
> On Sun, Nov 02, 2025 at 08:32:24PM +0100, Salvatore Bonaccorso wrote:
> > Hi Alex
> > 
> > On Wed, Oct 29, 2025 at 09:47:35PM +0000, Deucher, Alexander wrote:
> > > [Public]
> > > 
> > > > -----Original Message-----
> > > > From: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com> On Behalf Of
> > > > Salvatore Bonaccorso
> > > > Sent: Tuesday, October 28, 2025 3:18 PM
> > > > To: stable <stable@vger.kernel.org>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Sasha Levin
> > > > <sashal@kernel.org>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> > > > Hamza Mahfooz <hamza.mahfooz@amd.com>
> > > > Subject: Missing backport of 3c591faadd8a ("Reapply "Revert drm/amd/display:
> > > > Enable Freesync Video Mode by default"") in 6.1.y stable series?
> > > >
> > > > Hi
> > > >
> > > > We got in Debian a request to backport 3c591faadd8a ("Reapply "Revert
> > > > drm/amd/display: Enable Freesync Video Mode by default"") for the kernel in Debian
> > > > bookworm, based on 6.1.y stable series.
> > > >
> > > > https://bugs.debian.org/1119232
> > > >
> > > > While looking at he request, I noticed that the series of commits had a bit of a
> > > > convuluted history.  AFAICT the story began with:
> > > >
> > > > de05abe6b9d0 ("drm/amd/display: Enable Freesync Video Mode by default"), this
> > > > landed in 5.18-rc1 (and backported to v6.1.5, v6.0.19).
> > > >
> > > > This was then reverted with 4243c84aa082 ("Revert "drm/amd/display:
> > > > Enable Freesync Video Mode by default""), which landed in v6.3-rc1 (and in turn
> > > > was backported to v6.1.53).
> > > >
> > > > So far we are in sync.
> > > >
> > > > The above was then reverted again, via 11b92df8a2f7 ("Revert "Revert
> > > > drm/amd/display: Enable Freesync Video Mode by default"") applied in
> > > > v6.5-rc1 and as well backported to v6.1.53 (so still in sync).
> > > >
> > > > Now comes were we are diverging: 3c591faadd8a ("Reapply "Revert
> > > > drm/amd/display: Enable Freesync Video Mode by default"") got applied later on,
> > > > landing in v6.9-rc1 but *not* in 6.1.y anymore.
> > > >
> > > > I suspect this one was not applied to 6.1.y because in meanwhile there was a
> > > > conflict to cherry-pick it cleanly due to context changes due to
> > > > 3e094a287526 ("drm/amd/display: Use drm_connector in create_stream_for_sink").
> > > >
> > > > If this is correct, then the 6.1.y series can be brough in sync with cherry-picking the
> > > > commit and adjust the context around the change.
> > > > I'm attaching the proposed change.
> > > >
> > > > Alex in particular, does that make sense?
> > > 
> > > Yes, that makes sense to me.
> > 
> > Thanks for the confirmation. Greg, Sasha so can this be picked up as
> > well for 6.1.y? The patch was attached in previous message, but I can
> > resubmit it if needed.
> 
> can you resubmit please?
> 

Nevermind, I found it, I'll go queue it up now, thanks.

greg k-h


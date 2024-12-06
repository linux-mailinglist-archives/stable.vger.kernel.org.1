Return-Path: <stable+bounces-98933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FC99E6728
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 07:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF428466E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 06:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232BB1DA628;
	Fri,  6 Dec 2024 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OEiy2X4J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42521DA612
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465219; cv=none; b=g8EJtFExhGw1oAQhA5hQUwHF4c9SnzSh+PmbhP7oy9R3lm6x070EVZqZ3fvV8QoqVFeXC95D2QjKA9GzItqRhZbHxEQT2RIXUNIbTZ99HMTgtjTFvgHd8ARxx/l9+xB2ZTJ+Ht3Pptv+zdS/0dtfbb99b63HiS6RzQ0p04U0YZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465219; c=relaxed/simple;
	bh=C+jw2yGg294zrXd8aKEw37YLofeFqLaOOqAxjGkVqdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgJxAxBj2PJQ5I5lEzXbdUhlXKg5wGhdywdUrAGPqhdm/C+iu0R9txytAJzZ+ZB6vD+/cZJ/Vv3NfAI5NWkvnYFbjRKAl5Lq+oStbnhIbwa1i8+Pm5wrRkHoLyOrGasvqTm0IflcbsAs4EjjmcjGn5SGMukG45KsnicjgSjNJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OEiy2X4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E141AC4CEDE;
	Fri,  6 Dec 2024 06:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733465219;
	bh=C+jw2yGg294zrXd8aKEw37YLofeFqLaOOqAxjGkVqdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEiy2X4J197KybiFWTX4PZGPxV/vc/8RRimoIRcUQz9NnuvRc353757d3FsOSqYf+
	 LCZvN2J4vV0nhBbQv/eiPfWhK+Hp2p4ULGdclCRiW0PS9mRPNWerLcJG1h/8OUf9nJ
	 ReOuTmOru22HHMxLPEgKsJYO5msc3W90PDfAets4=
Date: Fri, 6 Dec 2024 07:06:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Beno=EEt?= Sevens <bsevens@google.com>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v2 5.10.y] ALSA: usb-audio: Fix out of bounds reads when
 finding clock sources
Message-ID: <2024120635-myspace-aside-1d9c@gregkh>
References: <20241205130758.981732-1-bsevens@google.com>
 <2024120523-sash-ravioli-e697@gregkh>
 <CAGCho0UWR3zt6hcvfhy63Y_Oskb0e8UNOvrUyU=jkguCPBFTkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGCho0UWR3zt6hcvfhy63Y_Oskb0e8UNOvrUyU=jkguCPBFTkw@mail.gmail.com>

On Thu, Dec 05, 2024 at 03:14:46PM +0100, Benoît Sevens wrote:
> On Thu, 5 Dec 2024 at 15:12, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Dec 05, 2024 at 01:07:58PM +0000, Benoît Sevens wrote:
> > > From: Takashi Iwai <tiwai@suse.de>
> > >
> > > Upstream commit a3dd4d63eeb452cfb064a13862fb376ab108f6a6
> > >
> > > The current USB-audio driver code doesn't check bLength of each
> > > descriptor at traversing for clock descriptors.  That is, when a
> > > device provides a bogus descriptor with a shorter bLength, the driver
> > > might hit out-of-bounds reads.
> > >
> > > For addressing it, this patch adds sanity checks to the validator
> > > functions for the clock descriptor traversal.  When the descriptor
> > > length is shorter than expected, it's skipped in the loop.
> > >
> > > For the clock source and clock multiplier descriptors, we can just
> > > check bLength against the sizeof() of each descriptor type.
> > > OTOH, the clock selector descriptor of UAC2 and UAC3 has an array
> > > of bNrInPins elements and two more fields at its tail, hence those
> > > have to be checked in addition to the sizeof() check.
> > >
> > > This patch ports the upstream commit a3dd4d63eeb4 to trees that do not
> > > include the refactoring commit 9ec730052fa2 ("ALSA: usb-audio:
> > > Refactoring UAC2/3 clock setup code"). That commit provides union
> > > objects for pointing both UAC2 and UAC3 objects and unifies the clock
> > > source, selector and multiplier helper functions. This means we need to
> > > perform the check in each version specific helper function, but on the
> > > other hand do not need to do version specific union dereferencing in the
> > > macros and helper functions.
> > >
> > > Reported-by: Benoît Sevens <bsevens@google.com>
> > > Cc: <stable@vger.kernel.org>
> > > Link: https://lore.kernel.org/20241121140613.3651-1-bsevens@google.com
> > > Link: https://patch.msgid.link/20241125144629.20757-1-tiwai@suse.de
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > (cherry picked from commit a3dd4d63eeb452cfb064a13862fb376ab108f6a6)
> > > Signed-off-by: Benoît Sevens <bsevens@google.com>
> > > ---
> > >  sound/usb/clock.c | 32 ++++++++++++++++++++++++++++++--
> > >  1 file changed, 30 insertions(+), 2 deletions(-)
> >
> > What changed in v2?
> 
> Only the commit description. Should I resend it in that case in reply
> to the previous thread?

change information always goes below the --- line, please fix that up
and send a v3.

thanks,

greg k-h


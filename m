Return-Path: <stable+bounces-98769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D10E09E51AF
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B087A16481F
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C941D5171;
	Thu,  5 Dec 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fp8PhcmI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734918FC70
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392134; cv=none; b=ElPJtVx0S9lc8kGaeSfYh89Sql3rPK+/lc5BRl7/pCmZO1CjNEhawdQ7s+BWWnO/sfFFEn6YHIl1sBS0ruSlY9I4EnJ4WBQmFvy0/pPeRMC9s/UC+s8Gfp1BTXf/RMbcBXj9rO1UE7OSxPGktBw5y543xd1DygtPf4+Y1ILcUu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392134; c=relaxed/simple;
	bh=UqVoW8hk9+grtqvAi1vI8R33uxmL8eKMwR5CCUhshbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Isq+iIWGSF4N/PUO61OjnDaVNNso0AZ26HdguuYvBw+NXBgNO3yQIil/mJ89HOPes0HnEfpJMKuG0KXlfk1ehE+mgBBaflqcA+3jooZNqz634bZogUb1eWN7T674Fr5BMF15OqQ6/pqQhGcg7F2VcgEcAlfN+iMs0hbYPar+RNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fp8PhcmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8919C4CED1;
	Thu,  5 Dec 2024 09:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733392134;
	bh=UqVoW8hk9+grtqvAi1vI8R33uxmL8eKMwR5CCUhshbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fp8PhcmIWDuDJ4OB8IPDW/ueIGusHB8jmdsSWxN2guhpNH9oggcdFAEzpKDQTHp9a
	 uwK5mNk+J1ZEIwxPamCYiP+Dq5RMb9z8FEMpPoMRyEDN7LiW+wFLiUXoTIPoh/bptt
	 AZs9GELKMJGVx+1P049O9IE8tnkY+a9GBAXdAPXk=
Date: Thu, 5 Dec 2024 10:48:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Beno=EEt?= Sevens <bsevens@google.com>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5.10.y] ALSA: usb-audio: Fix out of bounds reads when
 finding clock sources
Message-ID: <2024120526-jawless-robust-ea3f@gregkh>
References: <20241205092925.922510-1-bsevens@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205092925.922510-1-bsevens@google.com>

On Thu, Dec 05, 2024 at 09:29:25AM +0000, Benoît Sevens wrote:
> From: Takashi Iwai <tiwai@suse.de>
> 
> The current USB-audio driver code doesn't check bLength of each
> descriptor at traversing for clock descriptors.  That is, when a
> device provides a bogus descriptor with a shorter bLength, the driver
> might hit out-of-bounds reads.
> 
> For addressing it, this patch adds sanity checks to the validator
> functions for the clock descriptor traversal.  When the descriptor
> length is shorter than expected, it's skipped in the loop.
> 
> For the clock source and clock multiplier descriptors, we can just
> check bLength against the sizeof() of each descriptor type.
> OTOH, the clock selector descriptor of UAC2 and UAC3 has an array
> of bNrInPins elements and two more fields at its tail, hence those
> have to be checked in addition to the sizeof() check.
> 
> Reported-by: Benoît Sevens <bsevens@google.com>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/20241121140613.3651-1-bsevens@google.com
> Link: https://patch.msgid.link/20241125144629.20757-1-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> (cherry picked from commit a3dd4d63eeb452cfb064a13862fb376ab108f6a6)

You did _MUCH_ more than just cherry picking this.  Please document your
changes somehow, this is much different from the original commit.

thanks,

greg k-h


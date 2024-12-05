Return-Path: <stable+bounces-98818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB01C9E5829
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636E8285754
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB6E218E9D;
	Thu,  5 Dec 2024 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Po48hTtH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D11A28D
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407959; cv=none; b=L98E9g8X8Hlpl/oMZCA2Dm3ta/0b+HPQ8L+B7hJT1U1jRRffjATqmH1PgDC3exNx91ARMASeFABQSIPbOJ9X4O/3NNk8ckUN8aQ/0fNlLDCNWKPOesd+Hy+0l5/CXuE7UKKZ4LHU+BfZoot88ztkYGA/dwe+Zy/NW58TDGMhBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407959; c=relaxed/simple;
	bh=WmT5Qv1y3/fynwQ5/NTYJWvn4Ov0Cbv9FySZQvSLP5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvUaIk4fnRISJQe+zoAKR5nhYbhlR4eNo6+vQ/ggPuM0lPVUHw/soFP87XZ9HeyYQbrIAbS29Dj/SrCCROAvErqo/Fr5JwcG0Ili9mFfxrBKauFEp1VRIqo+EugDAdCuksoK8xx/AV4qsP5tpXCucktvCe59ENoE0JUPjqMTc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Po48hTtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131B4C4CED1;
	Thu,  5 Dec 2024 14:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733407958;
	bh=WmT5Qv1y3/fynwQ5/NTYJWvn4Ov0Cbv9FySZQvSLP5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Po48hTtH4+SQUY6OClG9C2+SxlfBfGt06gQ4tNjIUGgo11Jx/pcVItDd8HbW1DfV5
	 aUanFuyWA1K7Elxv+6ZimNUfjbR6yx0xuu13vkRr0au5lLt6Mb3lhZhHK0kBdLacT2
	 gE3HfdJrgZ2z6fQLjYYJYjXMhcsjfKzaFPdUm1s4=
Date: Thu, 5 Dec 2024 15:12:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Beno=EEt?= Sevens <bsevens@google.com>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v2 5.10.y] ALSA: usb-audio: Fix out of bounds reads when
 finding clock sources
Message-ID: <2024120523-sash-ravioli-e697@gregkh>
References: <20241205130758.981732-1-bsevens@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205130758.981732-1-bsevens@google.com>

On Thu, Dec 05, 2024 at 01:07:58PM +0000, Benoît Sevens wrote:
> From: Takashi Iwai <tiwai@suse.de>
> 
> Upstream commit a3dd4d63eeb452cfb064a13862fb376ab108f6a6
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
> This patch ports the upstream commit a3dd4d63eeb4 to trees that do not
> include the refactoring commit 9ec730052fa2 ("ALSA: usb-audio:
> Refactoring UAC2/3 clock setup code"). That commit provides union
> objects for pointing both UAC2 and UAC3 objects and unifies the clock
> source, selector and multiplier helper functions. This means we need to
> perform the check in each version specific helper function, but on the
> other hand do not need to do version specific union dereferencing in the
> macros and helper functions.
> 
> Reported-by: Benoît Sevens <bsevens@google.com>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/20241121140613.3651-1-bsevens@google.com
> Link: https://patch.msgid.link/20241125144629.20757-1-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> (cherry picked from commit a3dd4d63eeb452cfb064a13862fb376ab108f6a6)
> Signed-off-by: Benoît Sevens <bsevens@google.com>
> ---
>  sound/usb/clock.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)

What changed in v2?


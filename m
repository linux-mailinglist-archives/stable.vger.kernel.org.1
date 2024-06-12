Return-Path: <stable+bounces-50253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C759052FC
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B8C1C242BD
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF6F17B4F1;
	Wed, 12 Jun 2024 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hl6SvsaN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248B173331;
	Wed, 12 Jun 2024 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196764; cv=none; b=bgg47hUyu2Jghir8FB2SwaupAulBD/DNPtY3KOWIz5IHypWJSnMsvbUQnFBkCDwmwtiP8J06md30/bWOtI9XWDtRl/CrwmtpWUK0v3EBKsJzS6kL4/MsnknTVCUtR+QFC6NZdfcugbvxVqbAS0aWOLQfZT1yjtgexvrmRsruhUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196764; c=relaxed/simple;
	bh=PktZaXz5s4fvZyc9Sq5NIIfPxTn3kdxOWAzFL3DtRKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAOb/oEeRiVZyIZBcoAP4fP5j9D3PoLvyTjmf/K/xsXZBSyaEXXMvuRj/gWS5y7/QHkVeWGf/Xtiwknk1dWTJPOTI8vkcsxlZ7wgTLF+LuZ8qAulJfHM+BQgfM3Ko44+5NrCHHe8zgceH1Gkt6m9Gj3SdnUm1UXqeFk/E2202GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hl6SvsaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F86C4AF1A;
	Wed, 12 Jun 2024 12:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196763;
	bh=PktZaXz5s4fvZyc9Sq5NIIfPxTn3kdxOWAzFL3DtRKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hl6SvsaNxSzY9Ne/1e328WMFTSjQImgBukl2vf8L+aQe3gSUYb7XNtt+LQmKAAdv5
	 Bm3giSaOXJhoSPN0JkirYOVVqDSbJua31nZsW5ouU7Hl3fnm7ajvPX8Ryz/93LAL2e
	 HfFi4rnfsuk777EJ66iZMZCwQzuVM2DPrvf4KxE0=
Date: Wed, 12 Jun 2024 14:52:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.6.y 0/3] Backport of "mptcp: fix full TCP keep-alive
 support"
Message-ID: <2024061232-slinging-facsimile-d487@gregkh>
References: <20240529095817.3370953-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095817.3370953-5-matttbe@kernel.org>

On Wed, May 29, 2024 at 11:58:18AM +0200, Matthieu Baerts (NGI0) wrote:
> It looks like the patch "mptcp: fix full TCP keep-alive support" has
> been backported up to v6.8 recently (thanks!), but not before due to
> conflicts.
> 
> I had to adapt a bit the code not to backport new features, but the 
> modifications were simple, and isolated from the rest. MPTCP sockopt 
> tests have been executed, and no issues have been reported.
> 
> Matthieu Baerts (NGI0) (1):
>   mptcp: fix full TCP keep-alive support
> 
> Paolo Abeni (2):
>   mptcp: avoid some duplicate code in socket option handling
>   mptcp: cleanup SOL_TCP handling
> 
>  net/mptcp/protocol.h |   3 ++
>  net/mptcp/sockopt.c  | 123 +++++++++++++++++++++++++++++--------------
>  2 files changed, 87 insertions(+), 39 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

All backports now queued up, thanks so much for them!

greg k-h


Return-Path: <stable+bounces-171658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3DCB2B26E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 22:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416FF3A7DB1
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E068D21D599;
	Mon, 18 Aug 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d96A/LwW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AECB39FCE;
	Mon, 18 Aug 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549090; cv=none; b=DNDB9fBu2uDBhS6fylUKLr1JktODpURo/O679fmDNWAr1FTJ6l/1SrFjbxkLMIZ20Kvv/1MtsNTk/8B/Vatt5XWdhi/++Mkqoupe1wKZpRUK6Tix4uNOYv3Y47mNqSavl4tbg1hFJeSjCbgViKeXd62xfiJljx2c1eePEUD33bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549090; c=relaxed/simple;
	bh=BUJZdQ7C+69rv0nBZ4rKBl6Ylu+hVmsNi/cuUe8LTfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV/P8Jiu44HgwfH+IkLXSBfOtETD9r1PrliAdz7ZxRKFI9Oj9eqWe6qhryBMZQ8sa0mENus9VZKRpFLBN/TeZkGQnyMbnWWWiRjpVVBbyeCJuNIANGPYiZKgYbm+Xlxja5SwqiutRfYb/ZpJCAPHt/xBvnNubccisMC+Bixuo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d96A/LwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9584C4CEEB;
	Mon, 18 Aug 2025 20:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755549090;
	bh=BUJZdQ7C+69rv0nBZ4rKBl6Ylu+hVmsNi/cuUe8LTfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d96A/LwWIX6IjgNAZGVCv18SUFdPvzdbO/Ej0PPo7INLhe9gzb4VXBGI/88MczFYB
	 CI1EPX/kmkoesULuChT3E5GiDEG9shZfIUfBcYaKIqz9hScdl13/M1y3kH5kuYkVyy
	 Pbs94DYgYgNeHOz1vS0zsXNyI+kwQjvWAjGt5lkVDRg0kDvu/1KtiNO1mS7blqlHu2
	 KE6qExYnbwGEUMAge6uxr/vNOu06UjBv0O+3mONssymH2L5P4KcyB683eqnhTS8d2E
	 2kizcr4rqG5orzxczqjU/HTuAEZvThBQoVBj4Cqun0uip/nDa7FY4664WksvhZ0QNz
	 Y56T2DodF3ujw==
Date: Mon, 18 Aug 2025 13:30:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, David Lebrun <dlebrun@google.com>,
	stable@vger.kernel.org, stefano.salsano@uniroma2.it,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
Subject: Re: [PATCH net-next 1/3] ipv6: sr: Fix MAC comparison to be
 constant-time
Message-ID: <20250818203022.GA1305@sol>
References: <20250816031136.482400-1-ebiggers@kernel.org>
 <20250816031136.482400-2-ebiggers@kernel.org>
 <20250818211607.c8eb87fbac2f81774022b54b@uniroma2.it>
 <20250818193849.GB12939@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818193849.GB12939@google.com>

On Mon, Aug 18, 2025 at 07:38:52PM +0000, Eric Biggers wrote:
> On Mon, Aug 18, 2025 at 09:16:07PM +0200, Andrea Mayer wrote:
> > On Fri, 15 Aug 2025 20:11:34 -0700
> > Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > > To prevent timing attacks, MACs need to be compared in constant time.
> > > Use the appropriate helper function for this.
> > > 
> > > Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > ---
> > >  net/ipv6/seg6_hmac.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > 
> > Hi Eric,
> > 
> > Thanks for the fix!
> > 
> > I believe it would be best to submit this fix separately from the current patch
> > set. Since this addresses a bug rather than an enhancement or cleanup, sending
> > it individually with the 'net' tag will help facilitate applying this patch to
> > the net tree.
> > 
> > Ciao,
> > Andrea
> 
> Then there would be a merge conflict between the two patchsets.
> 
> I can do that if you want, but then I'd probably have to wait for this
> patch to reach net-next before the rest can proceed.

I guess patches 2 and 3 have to wait for "ipv6: sr: validate HMAC
algorithm ID in seg6_hmac_info_add" anyway, as they conflict with that
too.  Okay, I resent patch 1 as a standalone patch targeting "net":
https://lore.kernel.org/netdev/20250818202724.15713-1-ebiggers@kernel.org/

- Eric


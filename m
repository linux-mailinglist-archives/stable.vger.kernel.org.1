Return-Path: <stable+bounces-208438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36547D2437B
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 12:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CEC2300E3CF
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 11:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C4736D513;
	Thu, 15 Jan 2026 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HcHQYcO5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D9369220;
	Thu, 15 Jan 2026 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477177; cv=none; b=ZPPMXHtWqKNfKvQgeb2ybaN4QDb/KCfxyeJEgJVEoqaiOY7UfBKUCv6mCy6G+7EaKjFaT0m6eR83CrVfIBT97zx09ymPEI2uBUAKWHiqyZfPG78DosE4XaBRdVuUIGtcUVLlV3YTCyt4LRllpsoKM7wExhU1rE9w9+gzqPzD+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477177; c=relaxed/simple;
	bh=yMxxGnag31BcYeCKNU+iektj42PNC+GXO4mnOgn37QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAMbm/yj0Rz6yW6YFWLouSzvHjhC3K2g3Cx8QGyghVvZk7z5NWxlflBvZ3NZhW5xS+uBn1agNYEFfv6yGmEQqeBanxETAsONuElg7zBqPT+JcSxK5mo3ZVLJsJ+C7Cemn+bEkTr248RvT4L1TTlHpQhr/Fga47iu+9SfYC85tcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HcHQYcO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952E9C16AAE;
	Thu, 15 Jan 2026 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768477177;
	bh=yMxxGnag31BcYeCKNU+iektj42PNC+GXO4mnOgn37QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HcHQYcO55M5rTioAZb4KzjEdXYezhOICgAwH5RoxvYJ2aUEG2Ewhg+dOGAbgHAKXb
	 pLkIs5yVy7HIe7My6y7W0qc2Nkr+bVlxp9q1tiOjoZJsduNVKwjiLxtTa1Dv/fVyRz
	 +65WoBTMho82jazU115x6CfvFjQWSFmBmgAE2aaY=
Date: Thu, 15 Jan 2026 12:39:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	zhangshida@kylinos.cn, Coly Li <colyli@fnnas.com>
Subject: Re: Patch "bcache: fix improper use of bi_end_io" has been added to
 the 6.6-stable tree
Message-ID: <2026011517-apricot-supply-051c@gregkh>
References: <20260112172345.800703-1-sashal@kernel.org>
 <aWipoJjgc2cQpcl5@moria.home.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWipoJjgc2cQpcl5@moria.home.lan>

On Thu, Jan 15, 2026 at 03:47:39AM -0500, Kent Overstreet wrote:
> On Mon, Jan 12, 2026 at 12:23:45PM -0500, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     bcache: fix improper use of bi_end_io
> > 
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      bcache-fix-improper-use-of-bi_end_io.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Sasha, has this been dropped?

Why just drop it from 6.6?  What about all other branches?  What about
Linus's tree?

thanks,

greg k-h


Return-Path: <stable+bounces-67695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F0F9521D3
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 20:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576731F21D25
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 18:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753291BD033;
	Wed, 14 Aug 2024 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FPoFUD7C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D71B32A6
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658920; cv=none; b=KEFbhJNAWqq7onYzE2qe7x2+J5aXVySaJBx9wma4oQtH114tId7qIOHlzm4RxogUQvskgbyQdebmUmLKuLpOsIMCAss/mIG8uB96+JqL9jSrGs8mVJzdilbmoJiuwAr0ZMsZSBjOScaZTHbMzkKuX9cotQYJgXJpVeADHRI/2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658920; c=relaxed/simple;
	bh=1Mr0U4pA/mD2Wwyc9nXouBcA9LVCjEfkVVn+W34Fjjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPZWCewaZum5W1GBuIwpdBDErHIPNMwGL0RE97/qfJ/wC7CBA5l8TaZmWRBpY9ebHBfoN0YB57rgA9Lo9/KrTe0Ovkk1UF/ils97536QbeybGtph9YZcuX8DkO5H8dOM64E9uo/Mkum/fTxiRZ+HoGLIxYRXhDdKwCyOLj6gvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FPoFUD7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9381DC116B1;
	Wed, 14 Aug 2024 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723658920;
	bh=1Mr0U4pA/mD2Wwyc9nXouBcA9LVCjEfkVVn+W34Fjjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPoFUD7CUn9qou5PJRgWdsh0STEk7tqBtG1D28Djd5bXa227cuPreRZNCPF+6LQ4h
	 20ypw6EnBDWXB8zmlK/9ExX2z8ZrDumwfceDe+R0O5M+IHnRjAU+Kd8mT8qqxvWkKo
	 W2kbxDg0iLMpETiqDD90m6KvS61HpnPIc6WkoggE=
Date: Wed, 14 Aug 2024 20:08:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kees@kernel.org, brauner@kernel.org, ebiederm@xmission.com,
	mvanotti@google.com, viro@zeniv.linux.org.uk,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] exec: Fix ToCToU between perm check and
 set-uid/gid usage" failed to apply to 6.1-stable tree
Message-ID: <2024081456-cozy-shorten-f91e@gregkh>
References: <2024081450-exploring-lego-5070@gregkh>
 <CAHk-=wgQiPDmf+mofasoQVW1zU7AKh5_J3xK7rCJtzWzXiC6NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQiPDmf+mofasoQVW1zU7AKh5_J3xK7rCJtzWzXiC6NQ@mail.gmail.com>

On Wed, Aug 14, 2024 at 11:00:14AM -0700, Linus Torvalds wrote:
> On Wed, 14 Aug 2024 at 10:39, <gregkh@linuxfoundation.org> wrote:
> >
> > The patch below does not apply to the 6.1-stable tree.
> 
> I think this is the right backport for 6.1.
> 
> Entirely untested, though.

Thanks, that looks sane.  I've adapted it for the older kernels as well.

greg k-h


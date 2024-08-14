Return-Path: <stable+bounces-67699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C24952211
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 20:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9FA2861B1
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6011B14F8;
	Wed, 14 Aug 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVEQDvAI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC273BBCB
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660215; cv=none; b=Zlzdep+D2NAAj5HtO5btvtdRZJc4eT+ZGbkwfPMLw2VHpTVmOve4lR9McFyubSp7O9s59kQafpE2rkzVmoGGBiR0JTBTyf+XlKOYEloKbmXkISfPBiF7C4WuuC3C+loWzOMu1JyZ2LiX4Rfe+rh6hm0kQFK+26cMhviVFNYTvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660215; c=relaxed/simple;
	bh=RFN9TKye+vjegm5v/RpT/JM5+TBda6ELMIBG7sxOI+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umN95PqZuUJI6eJAJEqnn4/xA/AK20tl01UGOkplZR0ScsPbYKOWtXIG2lhr2r8PV8MG+z3z/p0Gj0LNmmmYv3vsQo9UbmozTGAUjwGolReV2ENXqLkkfP1Y7zbuTMuXeKrgVAzmBX0GCZYagILkfOhSM/8Kf8NVi1ZBVtS2Q3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVEQDvAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F10C116B1;
	Wed, 14 Aug 2024 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723660214;
	bh=RFN9TKye+vjegm5v/RpT/JM5+TBda6ELMIBG7sxOI+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVEQDvAIVnb51xCr1uITMxZc5u4TnehANKkwG8WNFTHbKOdtjJiGNJNXThMBW0KWg
	 DhEhMB0TUfYcX+BdKp/n0JcKCPGFyrJP5b5OpDYzzJvRkrhk/azVjIhyFd2s5AboTb
	 zgQFAzPp1hpwoWZDCyZ/oSpjycg8/AFaWQGq3G3Pw7SVa9EHiyLWvX7qmfkzLOzqwG
	 trlAeMc4mqO6dF/yiwkKJHpLsyViHzzgVDm2xr9WwhM+076SqCYnGZhCOJ2r/QS6rX
	 lzVJ3MhGbGH9uuPSCy3E62msxGN1rNawEV4S/Nb+z/Mg9nUYzvQDV8wOzqzZlcS6Sn
	 Pr34HbNPlCP2Q==
Date: Wed, 14 Aug 2024 11:30:13 -0700
From: Kees Cook <kees@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, brauner@kernel.org,
	ebiederm@xmission.com, mvanotti@google.com, viro@zeniv.linux.org.uk,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] exec: Fix ToCToU between perm check and
 set-uid/gid usage" failed to apply to 6.1-stable tree
Message-ID: <202408141130.C3A28EB712@keescook>
References: <2024081450-exploring-lego-5070@gregkh>
 <CAHk-=wgQiPDmf+mofasoQVW1zU7AKh5_J3xK7rCJtzWzXiC6NQ@mail.gmail.com>
 <2024081456-cozy-shorten-f91e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081456-cozy-shorten-f91e@gregkh>

On Wed, Aug 14, 2024 at 08:08:12PM +0200, Greg KH wrote:
> On Wed, Aug 14, 2024 at 11:00:14AM -0700, Linus Torvalds wrote:
> > On Wed, 14 Aug 2024 at 10:39, <gregkh@linuxfoundation.org> wrote:
> > >
> > > The patch below does not apply to the 6.1-stable tree.
> > 
> > I think this is the right backport for 6.1.
> > 
> > Entirely untested, though.
> 
> Thanks, that looks sane.  I've adapted it for the older kernels as well.

Yup, I agree. Thanks for that!

-- 
Kees Cook


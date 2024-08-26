Return-Path: <stable+bounces-70223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E4C95F237
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834B91F2302D
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7088188A12;
	Mon, 26 Aug 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afXTR4MS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212918757A;
	Mon, 26 Aug 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676894; cv=none; b=lCVdZeIiZKHnisIeBqQEtC2R8mIh4safhjHUuDi8OZ+DQ3o7+i20CUHixtaWyo+Kw1cuKC4EELsEAe5lo0wPLaXYU3dMamBkKdwbUpWuEfWGnoPGgeeTpU+Nu2AIKYocgfiGd4G6eug96qLLeOsC4xoUArUUqq8w1ltb3dlATWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676894; c=relaxed/simple;
	bh=RxYPZXlQWNrOsrO9+L3fSu/+RgANh56oaxO72vf754I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbPoIvfojkq9ebO5UK7+d0Kpkh29gn1eFxd4/ttzCPNEvKJ+OdwlVhcRQ08J68siBEdbfFFUCouCCxDoZ17/FvsKsQhfHkoS7rBiqb2U/L8MZx3sHGZPDSKkaC1eupYRMoC2ffSy7VJCCg4mzKQYHc6UqT/12nn3GUo7dmu5vQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afXTR4MS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A58C51439;
	Mon, 26 Aug 2024 12:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676894;
	bh=RxYPZXlQWNrOsrO9+L3fSu/+RgANh56oaxO72vf754I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afXTR4MSTvhX5BKUEYhJWprAk7RC66nHR4uRAjP2Fbl4tfxKK9CVn4p+kgLuhTrsr
	 3NM8hHmvvc0fG8wuB+TPuQ5kSbLIf4UrWwyQXs6hJTrGnFhRbObexBJ/Gsb90p0DFV
	 DcxRS4mV2hHTJEt/eh6BdY5uLjMCGel+jQMHLfEhANLe2HdL6+XtnqraVnEyhReLoK
	 Yj9NfuWJLivs9kdL/W/fZayfRmRwF7jgNzSxGGbYdLZmmYmikvWY8t+I2mUNdF8pFp
	 os/Gf2Z3+0nMnqBUxEhxeXtKMbDD0ObxeEbhWjJ8SAiIomfu8usbb+HeO1ZfgoSP3/
	 mz23mgHMpwwHQ==
Date: Mon, 26 Aug 2024 14:54:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Jann Horn <jannh@google.com>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] firmware_loader: Block path traversal
Message-ID: <20240826-indikatoren-fernverkehr-2208f3c38ddd@brauner>
References: <20240823-firmware-traversal-v2-1-880082882709@google.com>
 <Zsj7afivXqOL1FXG@bombadil.infradead.org>
 <CAADWXX_zpqzYdCpmQGF3JgsN4+wk3AsuQLCKREkDC1ScxSfDjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADWXX_zpqzYdCpmQGF3JgsN4+wk3AsuQLCKREkDC1ScxSfDjQ@mail.gmail.com>

On Sat, Aug 24, 2024 at 09:14:30AM GMT, Linus Torvalds wrote:
> On Sat, Aug 24, 2024 at 5:13 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > I'm all for this, however a strong rejection outright for the first
> > kernel release is bound to end up with some angry user with some oddball
> > driver that had this for whatever stupid reason.
> 
> I can't actually see a reason why a firmware file would have a ".."
> component in it, so I think the immediate rejection is fine -
> particularly since it has a warning printout, so you see what happened
> and why.
> 
> I do wonder if we should just have a LOOKUP_NO_DOTDOT flag, and just use that.
> 
> [ Christian - the issue is the firmware loading path not wanting to
> have ".." in the pathname so that you can't load outside the normal
> firmware tree. We could also use LOOKUP_BENEATH, except
> kernel_read_file_from_path_initns() just takes one long path rather
> than "here's the base, and here's the path". ]
> 
> There might be other people who want LOOKUP_NO_DOTDOT for similar
> reasons. In fact, some people might want an even stronger "normalized
> path" validation, where empty components or just "." is invalid, just
> because that makes pathnames ambiguous.

I think LOOKUP_NO_DOTDOT is potentially interesting for userspace as
RESOLVE_NO_DOTDOT. Though Jann's reply made me wonder: If some userspace
project wants to make sure that there are no ".." in the path while
allowing symlinks and ".." in symlinks then wouldn't it be easier and
cheaper for userspace to just manually check for ".." in the path
themselves? I mean RESOLVE_NO_SYMLINKS and RESOLVE_NO_MAGICLINKS
alleviate some proper pain. Not just because an appropariate userspace
algorithm is very costly but also because it's hard to get right. But
with RESOLVE_NO_DOTOT it feels like a pretty mundane string-parsing
excercise that could be done in userspace. Although I may just lack
imagination.

As long as we only have this very limited in-kernel user I think just
using Jann's helper in this patch is probably good enough.


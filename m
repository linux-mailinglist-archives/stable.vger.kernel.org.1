Return-Path: <stable+bounces-60765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161DB93A064
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 14:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91B32826AB
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 12:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61AF1514F3;
	Tue, 23 Jul 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1cHMv7Ka"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BD17BD5;
	Tue, 23 Jul 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721736636; cv=none; b=O48U+8ztqjU/waamdDB22CMExoLbU+e9jA8Kg94+WvzG5fb4HWmJJ1eY+IveQS9RIr1ujIiHD2kC2r1rd0VwpleeUSNd84mG05belipm5b33sGtzEpf1SVd/5wrEANGsPQpFISyRFnlcmeVv45TapE4VwQZjXXUKkC7XiZ4WbsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721736636; c=relaxed/simple;
	bh=PuQc9lcf0aB8Vfet/ule0plF49MnSff2OsM5B1P4slE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou9g0zry9555bGeTJfmHATGfkqkdoidN99L/W8YA6QXk0SLCQFL2/usp3j6TQpifiTYjMKjLYIPeP5TW+ZbkCXV9yk13nozDvzgqyGIqqIneJbjxjtunj47QVGHdtTGW75PgbnXAFVQtWyl41plNsunfpD0MEfR0ot3IjqftT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1cHMv7Ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85307C4AF09;
	Tue, 23 Jul 2024 12:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721736635;
	bh=PuQc9lcf0aB8Vfet/ule0plF49MnSff2OsM5B1P4slE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1cHMv7Kav3L5WP1X4gBSdXaH7350qAOJjqJMBlxcqDfj2CAT7XLxKp9p4yqQvndau
	 VqfoOVeyJn9YJI+OxXi6bvxEehwOu4QM0Ps6ahLmWXcOTG9B3pGTwYE7HIjc216/Mu
	 e10XAizrFJqrZFrx/E1EWUSUJz9W5w60ytO9Tcto=
Date: Tue, 23 Jul 2024 14:10:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y 0/7] Backport patches for DAMON merge regions fix
Message-ID: <2024072352-override-creasing-a0aa@gregkh>
References: <20240716175205.51280-1-sj@kernel.org>
 <2024071624-mustiness-quarterly-f34e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024071624-mustiness-quarterly-f34e@gregkh>

On Tue, Jul 16, 2024 at 08:23:46PM +0200, Greg KH wrote:
> On Tue, Jul 16, 2024 at 10:51:58AM -0700, SeongJae Park wrote:
> > Commit 310d6c15e910 ("mm/damon/core: merge regions aggressively when
> > max_nr_regions") causes a build warning [1] on 6.1.y.  That was due to
> > unnecessarily strict type check from max().
> > 
> > Fix the warning by backporting a minmax.h upstream commit that made the
> > type check less strict for unnecessary case, and upstream commits that
> > it depends on.
> > 
> > Note that all patches except the third one ("minmax: fix header
> > inclusions") are clean cherry-picks of upstream commit.  For the third
> > one, a minor conflict fix was needed.
> > 
> > [1] https://lore.kernel.org/2024071519-janitor-robe-779f@gregkh
> 
> Thanks for these, I'll queue them up after this round of -rc releases go
> out in a few days.

All now queued up, MANY thanks for this, it fixed a different build
error that just got added to the 6.1 queue yesterday, as this problem
kept happening over and over due to backports breaking in different
ways.

greg k-h


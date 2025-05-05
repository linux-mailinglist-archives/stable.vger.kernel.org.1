Return-Path: <stable+bounces-139636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79197AA8E84
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77821734C1
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 08:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5451C8619;
	Mon,  5 May 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q4RIatuH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5408170A0B
	for <stable@vger.kernel.org>; Mon,  5 May 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435000; cv=none; b=FsREvSxWmtOSOmXKxCcrqYdQ/wPxpR0YvoMrbKvVgM9Vb5RPaHz7xZLTjc8z4KAKEtfoYAjtJG31piiNCyk6IZ9jZpJSJVw4PDwOVf8V+yIqwd8VWNqSUApMAL8d9SejSy2OnFQTq+GuhqYc8UvhJ4mJDnp9ULOJs09bNSYI3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435000; c=relaxed/simple;
	bh=5IUWU1pb9P+FExdnIuuDkTdV5urjSHIN+vM/ITUUq98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvLtF2uAX8Hh+vXdA10R4bq8TK3KZONbt6up1WYn41adyZVYdJjuWnCJxruOC/rZOLQsNac8zehYdlvXJ8KWt5Rx/hpVryTBobvaxhQLaky1vpowjWESCnkZk3wATo4APPuh8lh2SoZ910kCh0xXmNf7focyUPwxgVIx+ah1OiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q4RIatuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E567C4CEE4;
	Mon,  5 May 2025 08:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746435000;
	bh=5IUWU1pb9P+FExdnIuuDkTdV5urjSHIN+vM/ITUUq98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4RIatuHgH52BtsUQ+Y9NLux2RWZ7dZLRnEmxr1ykY4LoSU/5WAoaD7MDKyC3zpFW
	 U7NAV+d3zYuhzXvVU206BEbX6uOqvj2v9DVpz2VxjI6Kuni7p0JfpLEFItIkLCW5Ie
	 bR4UIWpeDmCAHQ9WjWFaaubQEGl58Ucs+jkMgVLg=
Date: Mon, 5 May 2025 10:49:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Janne Grunau <j@jannau.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] drm: Select DRM_KMS_HELPER from" failed
 to apply to 6.6-stable tree
Message-ID: <2025050530-monotype-eligibly-e5b1@gregkh>
References: <2025050504-placate-iodize-9693@gregkh>
 <7cb8c3e1-52c3-498f-92af-b8b61a2ce8e8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cb8c3e1-52c3-498f-92af-b8b61a2ce8e8@app.fastmail.com>

On Mon, May 05, 2025 at 10:33:49AM +0200, Janne Grunau wrote:
> Hej,
> 
> On Mon, May 5, 2025, at 09:53, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 6.6-stable tree. If someone
> > wants it applied there, or to any other stable or longterm tree, then
> > please email the backport, including the original git commit id to
> > <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following
> > commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 32dce6b1949a696dc7abddc04de8cbe35c260217
> 
> This works for me without conflicts. Are there git configs which might
> influence this? The only noticeable thing is that the position of the
> DRM_DEBUG_DP_MST_TOPOLOGY_REFS entry shifted 82 lines down. I looked
> at the history of drivers/gpu/drm/Kconfig and the config
> DRM_DEBUG_DP_MST_TOPOLOGY_REFS block hasn't changed since v5.10. So I
> would expect the cherry-pick to work.

It applies cleanly, but breaks the build badly.  Try it and see :)

> Having said all that I don't know how important it is to have this in
> older stable releases when nobody noticed it before. The issue presents
> itself only with out-of-tree rust DRM drivers. I don't expect that
> anyone will try to backport those to old stable releases.
> 
> I'm fine with skipping this commit for stable releases for 6.6 and older
> and won't post backports.

Ok, thanks!

greg k-h


Return-Path: <stable+bounces-53836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F8590EA15
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C651B2823A9
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F1C13DB92;
	Wed, 19 Jun 2024 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CJzQ5QGe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EF13D532;
	Wed, 19 Jun 2024 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798019; cv=none; b=fDy0YPQEcxlMks/7cYrfeVb+a/all0jMyWMACd/hH4uo5E3N19nS5NWDdf0+knlq0KP3TpbRWm4dW/eXfgWER/3jVlAh2s77eZ/qsAqwC598xTJo4CpwkRaAGje/MdyohGqSUJTkKMqt1Zb1bOjy324hAxwkTY3BvLaCrQo+Dzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798019; c=relaxed/simple;
	bh=hY6ypmm2sD64MkbyDXkJRvW1lXbCZQdqWslU87osbQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e31VkTfeMxZk+oU4DDdrrvKpe20YaUkoBXkNsZFW6WU5rijYBqqg6AX+P1fMU0V7vIf8u6v7mr63g0DMgfI9kkIYzO7CQ0YmWaqDrzz7szxW+20WtHRCnmYayCVvKoyjuvuW9sfCmug25RwwhvUi3BT4BI4XR8tfrviKS5+bkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CJzQ5QGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C26C2BBFC;
	Wed, 19 Jun 2024 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718798018;
	bh=hY6ypmm2sD64MkbyDXkJRvW1lXbCZQdqWslU87osbQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJzQ5QGeRDe6qcHE4F2H0FMPEZGYomJDja29UHhj5v7bh4j8vFpxOKogP6C2eVYRJ
	 QPMWIEJ+i0OyLAahgPGU0ndk/xkDIuFfmtT5BZZEH8azJD8Ca8wS1Lk/LeQPxhC5ou
	 pdE/rwKmEk2L8XGCoacK3eqv/GAoSSHFLeu3lt6w=
Date: Wed, 19 Jun 2024 13:53:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Patch "driver core: platform: Emit a warning if a remove
 callback returned non-zero" has been added to the 5.10-stable tree
Message-ID: <2024061920-backlash-grinning-ad53@gregkh>
References: <20240616021857.1688223-1-sashal@kernel.org>
 <5aaa6ea3-b8f8-4e72-91a1-01de8bbcdc3d@kleine-koenig.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5aaa6ea3-b8f8-4e72-91a1-01de8bbcdc3d@kleine-koenig.org>

On Sun, Jun 16, 2024 at 09:32:45AM +0200, Uwe Kleine-König wrote:
> Hello Sasha,
> 
> On 6/16/24 04:18, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      driver core: platform: Emit a warning if a remove callback returned non-zero
> > 
> > to the 5.10-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       driver-core-platform-emit-a-warning-if-a-remove-call.patch
> > and it can be found in the queue-5.10 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit 2f1ac60bc9668567f021c314312563951039f77b
> > Author: Uwe Kleine-König <uwe@kleine-koenig.org>
> > Date:   Sun Feb 7 22:15:37 2021 +0100
> > 
> >      driver core: platform: Emit a warning if a remove callback returned non-zero
> >      [ Upstream commit e5e1c209788138f33ca6558bf9f572f6904f486d ]
> >      The driver core ignores the return value of a bus' remove callback. However
> >      a driver returning an error code is a hint that there is a problem,
> >      probably a driver author who expects that returning e.g. -EBUSY has any
> >      effect.
> >      The right thing to do would be to make struct platform_driver::remove()
> >      return void. With the immense number of platform drivers this is however a
> >      big quest and I hope to prevent at least a few new drivers that return an
> >      error code here.
> >      Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> >      Link: https://lore.kernel.org/r/20210207211537.19992-1-uwe@kleine-koenig.org
> >      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >      Stable-dep-of: 55c421b36448 ("mmc: davinci: Don't strip remove function when driver is builtin")
> >      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> That looks wrong. If this patch should be included in stable, it shouldn't
> be because it's a dependency. 55c421b36448 works without this patch for
> sure.
> 
> Either backport e5e1c2097881 because you think that warning should be in
> 5.10.x, or don't backport it.

I've fixed this up by hand and dropped all of the platform patches now,
thanks for the review!

greg k-h


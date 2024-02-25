Return-Path: <stable+bounces-23591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A910C862C8C
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 20:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C621F21122
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4F748D;
	Sun, 25 Feb 2024 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU0aA9/K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8512E47;
	Sun, 25 Feb 2024 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708887784; cv=none; b=G9N110w1opugjO+wD2T8inVBA92WcWcOueAeALwk99hz7/9YxjGqrPC4VGg7Q9eAokYwjrGDgvw27TimkasMv/YKG151Saj+LptwWKBqM6gxDAsl31Ok37NvLgnlGFiujQstUyu99nxYMxCMb+hcMbtDRyiRYumT/uISHqRiZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708887784; c=relaxed/simple;
	bh=YMWzmRSDR5/7KrJEuHBsdbpOlJ8+aKpRaPXXeAxlbBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDGhfCRlt42gtP/xGEjqbqigz27CS5Fo4gG3N7V2wn4Qr21zQh5/gBDwt3T5ZExipTyAlCAnYyzRxgL/roN+HmYxI6qAelEJd6T3H87k56iKr3bwtpON31mfI7LF/4y1IrPhUBnkrpxiyWNms46Mue7TR3F7auGVmAoIU3VRrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU0aA9/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5272CC433F1;
	Sun, 25 Feb 2024 19:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708887784;
	bh=YMWzmRSDR5/7KrJEuHBsdbpOlJ8+aKpRaPXXeAxlbBc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fU0aA9/KrpSIYqtSJCGjhvhw4ND7OuSGA6h+l3rCM8g9Hdgyd3rIruLiMg2pfkRO8
	 Uzn56WSWjkB6imBhREv6qtUGHv96nLDDcVizipy8uh1cSc8Xf2SRI0ZxxRygQ6TRth
	 3FdZXseN7aZlawrXi+vGNOrgjY317/pT9J1qeNm99cDqGv3sVBcXI1CT3FTkvwtAls
	 +8F5zkVX9Ytj0nqx7WVF0FYJOcG13A7sWvDcpC2xqs7afRlMk1ZRdBReu4DXGXFuBL
	 QdjsRzjmWjQoTBkugVIDrEBWeAeJ5v8zrDv7cducETJUJSPGPPlZInxoKZpsPFK+xn
	 rfiJ+iMC2d3Fw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E38A3CE0CC1; Sun, 25 Feb 2024 11:03:03 -0800 (PST)
Date: Sun, 25 Feb 2024 11:03:03 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>, joel@joelfernandes.org,
	chenzhongjin@huawei.com, rcu@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] linux-4.19/rcu-tasks: Eliminate deadlocks involving
 do_exit() and RCU tasks
Message-ID: <59861bc8-a651-4199-a60d-2cb39b3568a9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240207110846.25168-1-qiang.zhang1211@gmail.com>
 <2024022323-profile-dreaded-3ac7@gregkh>
 <ec2482a6-a19b-4152-b51d-13c812eacf64@paulmck-laptop>
 <2024022430-uninsured-zoom-f78c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022430-uninsured-zoom-f78c@gregkh>

On Sat, Feb 24, 2024 at 06:16:24AM +0100, Greg KH wrote:
> On Fri, Feb 23, 2024 at 11:48:49AM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 23, 2024 at 02:15:30PM +0100, Greg KH wrote:
> > > On Wed, Feb 07, 2024 at 07:08:46PM +0800, Zqiang wrote:
> > > > From: Paul E. McKenney <paulmck@kernel.org>
> > > > 
> > > > commit bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c upstream.
> > > 
> > > Again, not a valid commit id :(
> > 
> > Apologies!  With luck, there will be a valid ID next merge window.
> > This one does not backport cleanly, so we were trying to get ahead of
> > the game.  Also, some of the people testing needed the backport due
> > to the usual issues.  :-/
> > 
> > Any advice to handle this better next time around?  (Aside from us
> > avoiding CCing stable too soon...)
> 
> You can just wait until it hits Linus's tree, otherwise we do get
> confused :)
> 
> Or if you don't want to wait, put it in the notes section below the ---
> line and say "this isn't in Linus's tree yet, the git id mentioned is a
> lie!" or something like that.  Give us a chance to figure it out
> please...

Thank you, and should this situation arise in the future, we will put
the disclaimer after the "---", avoid CCing -stable, or similar.

Again, apologies for the hassle!

							Thanx, Paul


Return-Path: <stable+bounces-23529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D30861CDA
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 20:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09851287090
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 19:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05A31448F7;
	Fri, 23 Feb 2024 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwYVGWQG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE50133991;
	Fri, 23 Feb 2024 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717730; cv=none; b=kPeZDOJ9CggRR8khqKqi+MCyXeWSfVfSq9Krts6GduQkMepPXDYcI36dsQeiVnNgpaCG9Ms4Hel0ySSKZ4vfokfg34x8xogRWm3OHsBRxBpDk3JWmCcIZzZUN1ebT9eyzXhu/ysZloe/4X0/QUEazCq9e5iDJjBCw6/ue3/be+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717730; c=relaxed/simple;
	bh=A6w3xuNJFLsFIFI/9rM7Zp+251GfuI3iocwEhlHUEI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9K7C2hz2gjfPE2hZ4+uDhZd5jWAnPcGAMhJY8GpkREHJvdLW1HVsgAHfvKzgTLWaEMTpBQtMfBpgUt6TveWrOWOb3fpGcddN3PY4J0o4J/KT72KGMukWNCkH80/7pjwwDKRdVkLAiqJWtf4s/cSQ4nLmTNO8yVcrQjTHW9VUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwYVGWQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87DEC433C7;
	Fri, 23 Feb 2024 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708717729;
	bh=A6w3xuNJFLsFIFI/9rM7Zp+251GfuI3iocwEhlHUEI0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OwYVGWQGU4az7bx9OlM66QZ06P5VZWliIwTepGbl6TVo204lz8YeD5uuE4YmRe0nB
	 /ImCEwtFg+S062sD7BkeahZAuI6U3XEqXJcuoZUEXGRwyG9Aw2wBlciAu92kgkZ2xd
	 dtYUAV8Vew9osyhUWd6aYx9lO1wShtLYmxo10n73ruzCX8TtCubvJMtYo8zcp1YDyP
	 RVpmq5rIGSy6wqw8PHDeBke6AsL0bsWn2XThfbAdTkonovITcc2veaAgtONpNbBQzi
	 1sx8Waz1WqFXXK/2Te2SxCrHs3av28dGAm/fFuxVfYrtwzwt6o00IDSXjM79m6GCv+
	 hvqbQEDVm74CQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 74727CE1113; Fri, 23 Feb 2024 11:48:49 -0800 (PST)
Date: Fri, 23 Feb 2024 11:48:49 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>, joel@joelfernandes.org,
	chenzhongjin@huawei.com, rcu@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] linux-4.19/rcu-tasks: Eliminate deadlocks involving
 do_exit() and RCU tasks
Message-ID: <ec2482a6-a19b-4152-b51d-13c812eacf64@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240207110846.25168-1-qiang.zhang1211@gmail.com>
 <2024022323-profile-dreaded-3ac7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022323-profile-dreaded-3ac7@gregkh>

On Fri, Feb 23, 2024 at 02:15:30PM +0100, Greg KH wrote:
> On Wed, Feb 07, 2024 at 07:08:46PM +0800, Zqiang wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> > 
> > commit bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c upstream.
> 
> Again, not a valid commit id :(

Apologies!  With luck, there will be a valid ID next merge window.
This one does not backport cleanly, so we were trying to get ahead of
the game.  Also, some of the people testing needed the backport due
to the usual issues.  :-/

Any advice to handle this better next time around?  (Aside from us
avoiding CCing stable too soon...)

							Thanx, Paul


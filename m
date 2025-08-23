Return-Path: <stable+bounces-172600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C0B328F7
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9771B6391B
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ECF1C700C;
	Sat, 23 Aug 2025 14:00:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B801C3C08
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755957601; cv=none; b=u/oZPpyYtittV2S47VSN16pTZ5blcTV7sSR8indJP++53tBYsNTK7TVS764V2MT53vPt+Hsr3fiwl5kmEYRuG0SPr7rfWwO9oThFzlj1cKbPsF3AK2MgKlGv0PS+l5whRRqNzg3Ev1Fq7hE98PEl3nxg4finOi3w/pOMVSE1kOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755957601; c=relaxed/simple;
	bh=97I+DQOaL6uOug3mpsSAXsQpGUefzLWk+4vhU28mdjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tri7c5rGJxCtOpcpIrc7mQSrILKmYxCsSfEwJIBvXvB5j+SGTecvQiYi5ah3wUqS81iryogJ8MPKALbkGYyJSN2r5zucTENih072ZZeh5F6vc0ZAW9a9or58i/yqVSl4V6Am7zFkB993PjoPCPHQkL11YdD+9aCrHO5YAECqWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Sat, 23 Aug 2025 13:59:54 +0000
From: Brett A C Sheffield <bacs@librecast.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: Re: Backporting Selftests to Stable Kernels?
Message-ID: <aKnJWk82WwZwM-Ar@auntie>
References: <aKm8qmts_2Cp4j2p@karahi.gladserv.com>
 <2025082352-hefty-humorous-700d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025082352-hefty-humorous-700d@gregkh>

On 2025-08-23 15:51, Greg KH wrote:
> On Sat, Aug 23, 2025 at 03:05:46PM +0200, Brett Sheffield wrote:
> > Dear Stable Maintainers,
> > 
> > When a bugfix is backported to stable kernels, should we be backporting the
> > associated selftest(s)?
> 
> If you want to, sure!
> 
> > eg.
> > 
> > 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
> > was backported to stable, but the selftest was not:
> > 5777d1871bf6 ("selftests: net: add test for variable PMTU in broadcast routes")
> > 
> > Does stable policy say whether it should be?
> 
> It's up to the subsystem/maintainer/developer/whomever if they wish to
> do that or not.  Some subsystems want to do this, others don't, others
> don't care.
> 
> > It does not fix a bug, per se, but it does enable those of us running stable
> > kernel tests to more thoroughly test stable RCs.
> 
> Note that you should always be running the latest selftests for older
> kernels, and I think that's what many of the CI systems are already
> doing, so maybe that's why you don't notice stuff like this?
> 
> That's the only "rule" we have, all new selftests need to work properly
> for older kernels.
> 
> > Should mainline authors be encouraged to mark related tests for backporting?
> 
> Again, it's up to them if they want to or not.  I will point out mptcp
> as one subsystem that does mark selftests to backport, and provides
> backports for when they do not apply correctly.
> 
> hope this helps,

Thanks Greg. It does.


Brett


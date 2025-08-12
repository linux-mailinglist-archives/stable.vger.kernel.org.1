Return-Path: <stable+bounces-167135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97436B224FF
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B389C1884E4D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859BD2EBDD4;
	Tue, 12 Aug 2025 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q4UEVKfO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF9278E63;
	Tue, 12 Aug 2025 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996032; cv=none; b=OfuCSZ86kwLuu2IzomXdfCRESHHXB5woNx52YIaPZA3V1K9JYvU8MouGfcl2SS3vQspMNfCMYkwPDk6Uh3/vAkfWo4kO/6m3s6q7eY7eoTZdo+5kLbZwWXZm7GwZgqQ5GhdJzOW/kapesze0MpWg5WKQaJxOrAbomPanMJFYiOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996032; c=relaxed/simple;
	bh=GQ9ik5dESW9PcRCrAb6yPIRPQeomQdS9+zFaj7jIhkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMe6mQyGD786VSEej0ldfPI9BBCGgE4fLZdgOTDfHWm37X17kNrfffziyo6zoW+oIotqVJyCv0o94nTG3hxgby4IE3sNFt8tUSyc8SGKnGVvlvFD+o2LvM0yxqO3JRnWvH5rnPj2sUbwPV9qndNFH+dlGgDSM8OQ/vCAb4VCzzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q4UEVKfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3FAC4CEF0;
	Tue, 12 Aug 2025 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754996032;
	bh=GQ9ik5dESW9PcRCrAb6yPIRPQeomQdS9+zFaj7jIhkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4UEVKfOf8TdbELhB1zQZ5shPID4F9nI4swN8U9oVvRZPi+Mu4FSkYsTq/imieoFY
	 bD6BtnuvHZ5o8FFE38/AuHw50qHCo7kSmoew7Oy3LfHRIe6lk2HuLAqRK6DnPAX/w2
	 Lc6G/4o4ZCOzMfaH6Mz4KMC0P3wCcPYRvlCKQqj8=
Date: Tue, 12 Aug 2025 12:53:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	nicolas.frattaroli@collabora.com, Heiko Stuebner <heiko@sntech.de>
Subject: Re: Patch "pwm: rockchip: Round period/duty down on apply, up on
 get" has been added to the 6.16-stable tree
Message-ID: <2025081209-vista-preorder-bd6f@gregkh>
References: <20250808223033.1417018-1-sashal@kernel.org>
 <c5s7efnva5gluplw65g6qqxjqpmcgprgtm6tsajkbdqibe73lb@lw5afb6b725i>
 <2025081236-moneyless-enigmatic-891b@gregkh>
 <tjogt2ovj4afxo3lz7ydwsqtk4b52gjvga47es6x3ogdbfopyb@weiw3effavjh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tjogt2ovj4afxo3lz7ydwsqtk4b52gjvga47es6x3ogdbfopyb@weiw3effavjh>

On Tue, Aug 12, 2025 at 12:36:48PM +0200, Uwe Kleine-König wrote:
> Hello Greg,
> 
> On Tue, Aug 12, 2025 at 10:53:11AM +0200, Greg KH wrote:
> > On Sat, Aug 09, 2025 at 11:45:23AM +0200, Uwe Kleine-König wrote:
> > > while the new code makes the driver match the PWM rules now, I'd be
> > > conservative and not backport that patch because while I consider it a
> > > (very minor) fix that's a change in behaviour and maybe people depend on
> > > that old behaviour. So let's not break our user's workflows and reserve
> > > that for a major release. Please drop this patch from your queue.
> > 
> > Now dropped, but note, any behavior change is ok for ANY kernel version
> > as we guarantee they all work the same :)
> 
> Your statement makes no sense, I guess you missed to add a "don't".
> Otherwise I'd like to know who "we" is :-)

{sigh} yes, I mean "any behavior change is NOT ok..."

sorry,

greg k-h


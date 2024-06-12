Return-Path: <stable+bounces-50227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493989051FD
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D38281ECF
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1AB16F286;
	Wed, 12 Jun 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wjf2cfxV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8EA374D3;
	Wed, 12 Jun 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193883; cv=none; b=LlET33QSOzTncyRWdeRPSzpzYNpxE3epN1o4h5rv/l+GKmXfI+VJCGKlP9nUSvwSLi4pdevDHcehWNOrLW0/ARu8LodYFAl5Pa7cDFUAbafISC4HUq0caxxB2Vij3U5zAaz+vYmU1/K8skX4i7J6zbLIUvPh5ZMdZP93KqdB7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193883; c=relaxed/simple;
	bh=2B9cF8w213BqeGDWK69iJPR4rJyOwb3Wh0NtbWC8BSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VctAa6V1xUja74sWK7XJag17hm57+701RR6fNVNckCv7glIwsFNiuUSU2YdF442qoLfa8Hv/O2P2zkkaHvKaKe21KzdsMoTDbNvjKZb2aBsDWYc1d/d+pBPkQwIocvusbuN4HOMoevfaIIoXio/YaDXpxOd/JKPKwTuGS0/LDug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjf2cfxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61689C3277B;
	Wed, 12 Jun 2024 12:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718193882;
	bh=2B9cF8w213BqeGDWK69iJPR4rJyOwb3Wh0NtbWC8BSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wjf2cfxVvoniGDsb1tz6Ftg/fWlITXjuLZfBhXwqHfHGPLmBcceqsBI4WaffaHixq
	 hFwzr7Ti81rAXJSxdVvisD5qw9J38qmKXw8meK5ebUk5Fkyg9a9SOP4i27EnF1OpiS
	 YtXhGSBaTpEopKZAbwIkr2i3roa9zOpBbTG9YFVY=
Date: Wed, 12 Jun 2024 14:04:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Levin <sashal@kernel.org>,
	Jeremy =?iso-8859-1?Q?Lain=E9?= <jeremy.laine@m4x.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Mike <user.service2016@gmail.com>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
Message-ID: <2024061258-boxy-plaster-7219@gregkh>
References: <30f4b18f-4b96-403c-a0ab-d81809d9888a@gmail.com>
 <c09d4f5b-0c4b-4f57-8955-28a963cc7e16@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c09d4f5b-0c4b-4f57-8955-28a963cc7e16@leemhuis.info>

On Thu, Jun 06, 2024 at 12:18:18PM +0200, Thorsten Leemhuis wrote:
> On 03.06.24 22:03, Mike wrote:
> > On 29.05.24 11:06, Thorsten Leemhuis wrote:
> >> Might be a good idea to share it, the developers might want to confirm
> >> it's really the same bug.
> > I'm attaching the stacktrace [1] and decodecode [2] at the end, generated
> > on 6.1.92 vanilla+patch (1.).
> > [...]
> > I understand that 6.9-rc5[1] worked fine, but I guess it will take some
> > time to be
> > included in Debian stable, so having a patch for 6.1.x will be much
> > appreciated.
> > I do not have the time to follow the vanilla (latest) release as is
> > likely the case for
> > many other Linux users.
> > 
> > Let me know if there's anything else useful I can do for you.
> > Thank you,
> 
> Still no reaction from the bluetooth developers. Guess they are busy
> and/or do not care about 6.1.y. In that case:
> 
> @Greg: do you might have an idea how the 6.1.y commit a13f316e90fdb1
> ("Bluetooth: hci_conn: Consolidate code for aborting connections") might
> cause this or if it's missing some per-requisite? If not I wonder if
> reverting that patch from 6.1.y might be the best move to resolve this
> regression. Mike earlier in
> https://lore.kernel.org/all/c947e600-e126-43ea-9530-0389206bef5e@gmail.com/
> confirmed that this fixed the problem in tests. Jeremy (who started the
> thread and afaics has the same problem) did not reply.

How was this reverted?  I get a bunch of conflicts as this commit was
added as a dependency of a patch later in the series.

So if this wants to be reverted from 6.1.y, can someone send me the
revert that has been tested to work?

thanks,

greg k-h


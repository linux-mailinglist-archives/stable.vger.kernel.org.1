Return-Path: <stable+bounces-105175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8EF9F6A49
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 16:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B14816DF50
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6421F0E32;
	Wed, 18 Dec 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRY4Bh/7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387421EC4C6;
	Wed, 18 Dec 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536589; cv=none; b=PFfd2zqZ0CbOwInWWfNGbfyWY6Hgc559+zGOfgLKHJEEFPRiXIm9Xe6yVkqBzqBpRLLJ3yhR1OkXaNtAQWYqLfLuOhDNxd5kS4syJqt4zBfv9nQKeor/vQv0PuoVES/711U+/IAP+UyD/2oGJi+wxCCEarto9yYR3qKSQPRLsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536589; c=relaxed/simple;
	bh=udnVj/lt5nJ91WxU5I/qaFBD8xOAmlTEPMoqoSTXwGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjSmSPt77cjpQ+lNiixNQKiLTTifx24Sojzfzr8rl81uf4Pg+pTwU/jTrVJWj6DNncAsBykoOZcWVb/caVuSQ4YwGarmNgS7WjJ68+6ZIZfZZnN3Qjabd9Bjs841XezPkpo8AC5P5qlrprbd4FZJCwstQoWGsqtG5zljK3xKhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRY4Bh/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9FBC4CECE;
	Wed, 18 Dec 2024 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734536587;
	bh=udnVj/lt5nJ91WxU5I/qaFBD8xOAmlTEPMoqoSTXwGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRY4Bh/7pEY20xzzTgbSHM6oNCkewXvl01IqeOnFYixBsxXgHrXQu3+QmS4330ZRD
	 nr6u9pS3zLpseDchvho9kKTHuKcXrqbGw3JMzod/Eik+NhQC0m6NdJjJFZRR2/GDf3
	 ozj7Jxuv16c/fLpR1xl4D/d37ZCn9A8XV4n+dC0i2sTC4M05ywhfoAogDYdyCrzBI4
	 ttKHlhtWthBXZcep+n3QpTIhkAytsh90KN0vVZpwjiaF3Li4Wr0kpsvJ/fIzKbuKhJ
	 nmrRC6Au7oQ87+gLgcoTRHMlU8fEtOwx1hCq/lGpEXo3H+U703/WiJSygScLeOSahA
	 CURL6RBTSEiFg==
Date: Wed, 18 Dec 2024 10:43:06 -0500
From: Sasha Levin <sashal@kernel.org>
To: Gustavo Padovan <gus@collabora.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"kernelci lists.linux.dev" <kernelci@lists.linux.dev>,
	stable <stable@vger.kernel.org>,
	Engineering - Kernel <kernel@collabora.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: add 'X-KernelTest-Commit' in the stable-rc mail header
Message-ID: <Z2LtivhNCqY3WiJU@lappy>
References: <193d4f2b9cc.10a73fabb1534367.6460832658918619961@collabora.com>
 <2024121731-famine-vacate-c548@gregkh>
 <193d506e75f.b285743e1543989.3693511477622845098@collabora.com>
 <2024121700-spotless-alike-5455@gregkh>
 <Z2GWCli0JpaRyTsp@lappy>
 <193d562463b.1195519191587461.735892529383555996@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <193d562463b.1195519191587461.735892529383555996@collabora.com>

On Tue, Dec 17, 2024 at 01:10:07PM -0300, Gustavo Padovan wrote:
>
>
>---- On Tue, 17 Dec 2024 12:17:30 -0300 Sasha Levin  wrote ---
>
> > On Tue, Dec 17, 2024 at 03:49:53PM +0100, Greg KH wrote:
> > >On Tue, Dec 17, 2024 at 11:30:19AM -0300, Gustavo Padovan wrote:
> > >>
> > >>
> > >> ---- On Tue, 17 Dec 2024 11:15:58 -0300 Greg KH  wrote ---
> > >>
> > >>  > On Tue, Dec 17, 2024 at 11:08:17AM -0300, Gustavo Padovan wrote:
> > >>  > > Hey Greg, Sasha,
> > >>  > >
> > >>  > >
> > >>  > > We are doing some work to further automate stable-rc testing, triage, validation and reporting of stable-rc branches in the new KernelCI system. As part of that, we want to start relying on the X-KernelTest-* mail header parameters, however there is no parameter with the git commit hash of the brach head.
> > >>  > >
> > >>  > > Today, there is only information about the tree and branch, but no tags or commits. Essentially, we want to parse the email headers and immediately be able to request results from the KernelCI Dashboard API passing the head commit being tested.
> > >>  > >
> > >>  > > Is it possible to add 'X-KernelTest-Commit'?
> > >>  >
> > >>  > Not really, no.  When I create the -rc branches, I apply them from
> > >>  > quilt, push out the -rc branch, and then delete the branch locally,
> > >>  > never to be seen again.
> > >>  >
> > >>  > That branch is ONLY for systems that can not handle a quilt series, as
> > >>  > it gets rebased constantly and nothing there should ever be treated as
> > >>  > stable at all.
> > >>  >
> > >>  > So my systems don't even have that git id around in order to reference
> > >>  > it in an email, sorry.  Can't you all handle a quilt series?
> > >>
> > >> We have no support at all for quilt in KernelCI. The system pulls kernel
> > >> branches frequently from all the configured trees and build and test them,
> > >> so it does the same for stable-rc.
> > >>
> > >> Let me understand how quilt works before adding a more elaborated
> > >> answer here as I never used it before.
> > >
> > >Ok, in digging, I think I can save off the git id, as I do have it right
> > >_before_ I create the email.  If you don't do anything with quilt, I
> > >can try to add it, but for some reason I thought kernelci was handling
> > >quilt trees in the past.  Did this change?
> >
> > What if we provide the SHA1 of the stable-queue commit instead? This
> > will allow us to rebuild the exact tree in question at any point in the
> > future.
>
>Yeah, future-compatibility sounds better. As long as we have a git tree, a SHA1
>and can match that to the test execution in KernelCI it works.
>
>Is that SHA1 different from the one in the stable-rc release?

Yeah - it's a different repo that hosts the quilt series.

We won't find that SHA1 in any of the kernel/stable repos we use, but we
know how to recreate the exact kernel tree with the stable-queue SHA1.

-- 
Thanks,
Sasha


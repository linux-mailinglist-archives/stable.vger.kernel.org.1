Return-Path: <stable+bounces-128460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7643AA7D650
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 09:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57C9421299
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17098224259;
	Mon,  7 Apr 2025 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1IO+/FDH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3015188A0E
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011159; cv=none; b=C56UOfL1ejgp3QTVqfIq6kcHk+q+iH+8WQv5L8Bagp491f9p/WKuQsgtZMGtOYBMVOx2/IIEhFqZ/BwSeSUxPCVFFXa3J5yc4F41o7Z4q+wtaYXrb0MMVslQ4BSlWKMMvA4jE9B3RqxBkWpJwWz23HbjmSEe8gXDtjKrQEkarhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011159; c=relaxed/simple;
	bh=evCJXI7JH8kVZA5XEzVPJkLoNVM+1trLE3NyUEntO6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNj0oWcP1KoBeLNZgdxdWSz5K3fiDT1q15b/cfGZx6JfnJFEnd/UxXA8s9YeqvCp83K6qcqJM8weR7kw1l/uBsJ7SwjExgo10J78Kxf6sFtP8+EQArWBl1lIRtKErMsKXux9SrqV0U3AcO1nErFZG4I4fhzqG8Dg3VJP2JMyx3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1IO+/FDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B475DC4CEDD;
	Mon,  7 Apr 2025 07:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744011159;
	bh=evCJXI7JH8kVZA5XEzVPJkLoNVM+1trLE3NyUEntO6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1IO+/FDHl3DJmWbNEKelg1+u8p1pCwhCG7N4O/JBenJM+pmrwR1C7Fh9U8fwFZFK2
	 m7pRqid/u7k5BgOLdphIHQeIkDpD3bmxh2VW+evxgd9aR2Jvh5JSbI7NMw7yJLrnZM
	 HMSchh+LD37IEzF+04Mx3h/ihbwjFkNKDCZPN1WY=
Date: Mon, 7 Apr 2025 09:31:08 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Manthey, Norbert" <nmanthey@amazon.de>
Cc: "sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Improving Linux Commit Backporting
Message-ID: <2025040728-shabby-laborer-4891@gregkh>
References: <f7ceac1ce5b3b42b36c7557feceadbb111e4850d.camel@amazon.de>
 <2025040348-living-blurred-eb56@gregkh>
 <2025040348-grant-unstylish-a78b@gregkh>
 <2025040311-overstate-satin-1a8f@gregkh>
 <94605fedd3f066efbe09f21fd1e0533cc6a1c5b9.camel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94605fedd3f066efbe09f21fd1e0533cc6a1c5b9.camel@amazon.de>

On Mon, Apr 07, 2025 at 07:26:59AM +0000, Manthey, Norbert wrote:
> On Thu, 2025-04-03 at 15:51 +0100, gregkh@linuxfoundation.org wrote:
> ...snip ...
> > On Thu, Apr 03, 2025 at 02:57:34PM +0100, gregkh@linuxfoundation.org wrote:
> > > On Thu, Apr 03, 2025 at 02:45:35PM +0100, gregkh@linuxfoundation.org wrote:
> > > > On Thu, Apr 03, 2025 at 01:15:28PM +0000, Manthey, Norbert wrote:
> ...snip...
> > > > > We would like to discuss whether you can integrate this improved tool
> > > > > into into your daily workflows. We already found the stable-tools
> > > > > repository [1] with some scripts that help automate backporting. To
> > > > > contribute git-fuzzy-pick there, we would need you to declare a license
> > > > > for the current state of this repository.
> > > > 
> > > > There's no need for us to declare the license for the whole repo, you
> > > > just need to pick a license for your script to be under.  Anything
> > > > that's under a valid open source license is fine with me.
> > > > 
> > > > That being said, I did just go and add SPDX license lines to all of the
> > > > scripts that I wrote, or that was already defined in the comments of the
> > > > files, to make it more obvious what they are under.
> Thanks!
> > > 
> > > Wait, you should be looking at the scripts in the stable-queue.git tree
> > > in the scripts/ directory.  You pointed at a private repo of some things
> > > that Sasha uses for his work, which is specific to his workflow.
> I had a look at those scripts too. Looks like you use git am, and abort in case this operation
> fails.

We only use 'git am' to apply the quilt series to the tree when doing
a release (the final one or the -rc ones).  We use quilt to manage
everything in the stable-queue.git tree as that provides us with the
needed flexibility.

> > Also, one final things.  Doing backports to older kernels is a harder
> > task than doing it for newer kernels.  This means you need to do more
> > work, and have a more experienced developer do that work, as the nuances
> > are tricky and slight and they must understand the code base really
> > well.
> > 
> > Attempting to automate this, and make it a "junior developer" task
> > assignment is ripe for errors and problems and tears (on my side and
> > yours.)  We have loads of examples of this in the past, please don't
> > duplicate the errors of others and think that "somehow, this time it
> > will be different!", but rather "learn from our past mistakes and only
> > make new ones."
> We understand. We might make the tool available to help simplify the human effort of backporting. To
> make this more successful, is there a way to identify the errors and learnings you mention from the
> past? Avoiding them automatically early in the process helps keeping the errors away.

Don't ignore fuzz, manually check, and verify, everything.

good luck!

greg k-h


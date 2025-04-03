Return-Path: <stable+bounces-127528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA104A7A476
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CB918905EA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC524EAA8;
	Thu,  3 Apr 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LBsNjDBR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A677424EAA4
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688742; cv=none; b=op1epj8e0kT9t+PkNIzRqRtZzt7UvdHMe+JVFFvoK8lFJJJLKhtZH5k44CFMHtW22DkKFchgNL+LBZAA4e7Sdor2Gt2lXcIMsHQ8ne27b9RjaUV8y+vAtABEBXB9TUxTxmobvBWE26zFuLXPMSpKZiEvMDETb6zPvPRPiggQ0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688742; c=relaxed/simple;
	bh=2wkjBXkBQWZsUSLI+tDFA5nKmzRxZKJUp0TaBjyLQX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLAHGMekYokwGpcdzFqQfFEvVDOowSPCnpPbyW8BNMV6kg2GFlx4sR9ZaL18PeFOyYo9B/B7gkXgO3Psp69L1JF/7SM7my92GcdO5mEVN3TSnjO4CroEzWXIcJb0i9c460du73Y/HstUPelD7F9xWdeyNBJwUGqFfAAtBMzSgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LBsNjDBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E77C4CEE3;
	Thu,  3 Apr 2025 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743688742;
	bh=2wkjBXkBQWZsUSLI+tDFA5nKmzRxZKJUp0TaBjyLQX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBsNjDBRNcwbqJp7bJL7Qw6HDkzxY58oZzFX9qFRAWs9Q7QBv+vwiDnvo1xWJAGOV
	 SkDRBvtdZqsDVanBNy8ko6MLyXSzw2mxIER45vHK7WfagbccEBpjMjcRr9EJmZzh/L
	 LTk/voGb3x+Xtl0nWtc4eZYa2qYxNWF6E3DNPr/4=
Date: Thu, 3 Apr 2025 14:57:34 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Manthey, Norbert" <nmanthey@amazon.de>
Cc: "sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Improving Linux Commit Backporting
Message-ID: <2025040348-grant-unstylish-a78b@gregkh>
References: <f7ceac1ce5b3b42b36c7557feceadbb111e4850d.camel@amazon.de>
 <2025040348-living-blurred-eb56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025040348-living-blurred-eb56@gregkh>

On Thu, Apr 03, 2025 at 02:45:35PM +0100, gregkh@linuxfoundation.org wrote:
> On Thu, Apr 03, 2025 at 01:15:28PM +0000, Manthey, Norbert wrote:
> > Dear Linux Stable Maintainers,
> > 
> > while maintaining downstream Linux releases, we noticed that we have to
> > backport some patches manually, because they are not picked up by your
> > automated backporting. Some of these backports can be done with
> > improved cherry-pick tooling. We have implemented a script/tool "git-
> > fuzzy-pick" which we would like to share. Besides picking more commits,
> > the tool also supports executing a validation script right after
> > picking, e.g. compiling the modified source file. Picking stats and
> > details are presented below.
> > 
> > We would like to discuss whether you can integrate this improved tool
> > into into your daily workflows. We already found the stable-tools
> > repository [1] with some scripts that help automate backporting. To
> > contribute git-fuzzy-pick there, we would need you to declare a license
> > for the current state of this repository.
> 
> There's no need for us to declare the license for the whole repo, you
> just need to pick a license for your script to be under.  Anything
> that's under a valid open source license is fine with me.
> 
> That being said, I did just go and add SPDX license lines to all of the
> scripts that I wrote, or that was already defined in the comments of the
> files, to make it more obvious what they are under.

Wait, you should be looking at the scripts in the stable-queue.git tree
in the scripts/ directory.  You pointed at a private repo of some things
that Sasha uses for his work, which is specific to his workflow.

thanks,

greg k-h


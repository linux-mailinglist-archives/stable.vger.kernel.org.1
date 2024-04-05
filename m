Return-Path: <stable+bounces-36049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D200899971
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3D6B2153D
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E9D15FD0D;
	Fri,  5 Apr 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n1eGaDI1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BCB15FD03
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309368; cv=none; b=iBWdKcXs4/0Pt4B/wS6KNRj5OTnfYwM2fPMVLyvVN71F3vJvvRGcAAAGYOqZhej6E6v4UIDUHs8KaVQ0lWs8tNMC2wsboC/pvwCWQUh8qGaBkcbucvr/GQ+RiQTG3VTQealCd04cx178proj66FFs7qndo6xpjM0UpwRVa+3F+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309368; c=relaxed/simple;
	bh=F76mPf7Ro+XFIB7wgNfHyCReSxuegjJV/Vg8KTSc+qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am5XeQwLYA0LtDZQxk9LQIo3bJHPxLhkcU+IOrSn+u2ako4okAA17fEus97GOfOSImROfYEWjhSEIivdqONUmiv6JTLWMpHVcLL2dZCTLF23m1yGHgxd50KYt04rWCq9NlY3/yPH52g7fD3bZdXHg49w23LUKu7DLET4UZvqm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n1eGaDI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51DCC433C7;
	Fri,  5 Apr 2024 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712309368;
	bh=F76mPf7Ro+XFIB7wgNfHyCReSxuegjJV/Vg8KTSc+qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1eGaDI1C8kMgiT6CIYQAikFuPPqerhVLveZi+3GJ+Z8FYjjsE+Y+8cq3k+dtO1dV
	 5NCrdHvCq7fcEPC7QTlXGa7sy9NgOblooxD0R6TDvKi3An1Sx5GKkYC94wsv/xYRUR
	 2MJgQxaNfOMs8Tou2YENZcgcxpGufgW5Ivb4erqg=
Date: Fri, 5 Apr 2024 11:29:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/bugs: Fix the SRSO mitigation on
 Zen3/4" failed to apply to 6.6-stable tree
Message-ID: <2024040512-tag-retying-3afa@gregkh>
References: <2024033029-roast-pajamas-3c55@gregkh>
 <20240403105631.GBZg0130wgJdljfjzE@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403105631.GBZg0130wgJdljfjzE@fat_crate.local>

On Wed, Apr 03, 2024 at 12:56:31PM +0200, Borislav Petkov wrote:
> On Sat, Mar 30, 2024 at 10:46:29AM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> A bit more involved, took a couple of Josh's cleanup patches too. See
> attached.

All now queued up, thanks!

greg k-h


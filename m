Return-Path: <stable+bounces-25818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DF186FA35
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42C41F2160E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 06:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C7E11739;
	Mon,  4 Mar 2024 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O3goXUZG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061391171E
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709534680; cv=none; b=gu0eTnGgAvqJB0dnE/efFtEMIif35SgIL3XPKbBWCpwJfiuNNcUAABb21nawQ4V7Uoc3NNgzZKHfh2UNRt05UakKqtpH9GQ4rTZ65ATER5sAVJOOB1N6P337qI2h+VvFjK+uoU9tPLT25wgyJrDB82lxSUJK196NlEMmaL78jxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709534680; c=relaxed/simple;
	bh=te2CdMLbspEHgIJRIodcYMDbT3o/bQ+qKV2i8Ie96dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiF/bn6BR5bEP5MBjEgVOPRaObfPFQo4NggGd7JmhxqIY4kUr7vcrpCK6E7a4aQZxSG+p5sCNaXqmCkBgc6JZOIdvZzlUaSBChoPt/MyN2zdmt8XEHO0GlN+1Lqc/9JlkyS20shjk+UIh4arqxfUM7n0z4YUyaYjnC5BticwrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O3goXUZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091CDC433C7;
	Mon,  4 Mar 2024 06:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709534679;
	bh=te2CdMLbspEHgIJRIodcYMDbT3o/bQ+qKV2i8Ie96dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3goXUZG9tsrdWIhLXBdZguMyP6Es7wJWWUjCCZ48Y9/j0ydqXqwiFFectzEGVVK2
	 tOYDyLWzsOGwBvzzSSlSYQR9ZFlpWAa8G/Bvqw2RDSgl1uOIynsw0ZX0WU9ArLTCoC
	 NTBzsyvKzYxVe1MIY3hHObZotIXWK4Y2s6cFYatk=
Date: Mon, 4 Mar 2024 07:44:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	stable@vger.kernel.org, phaddad@nvidia.com, shiraz.saleem@intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>
Subject: Re: Backport fix for CVE-2023-2176 (8d037973 and 0e158630) to v6.1
Message-ID: <2024030407-unshaven-proud-6ac4@gregkh>
References: <2024022817-remedial-agonize-2e34@gregkh>
 <20240228184123.24643-1-brennan.lamoreaux@broadcom.com>
 <CAD2QZ9YZM=5jDtqA-Ruw9ZcztRPp6W6mZj9tA=UvA5515uYKrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD2QZ9YZM=5jDtqA-Ruw9ZcztRPp6W6mZj9tA=UvA5515uYKrQ@mail.gmail.com>

On Thu, Feb 29, 2024 at 02:05:39PM +0530, Ajay Kaher wrote:
> On Thu, Feb 29, 2024 at 12:13 AM Brennan Lamoreaux
> <brennan.lamoreaux@broadcom.com> wrote:
> >
> > > If you provide a working backport of that commit, we will be glad to
> > > apply it.  As-is, it does not apply at all, which is why it was never
> > > added to the 6.1.y tree.
> >
> > Oh, apologies for requesting if they don't apply. I'd be happy to submit
> > working backports for these patches, but I am not seeing any issues applying/building
> > the patches on my machine... Both patches in sequence applied directly and my
> > local build was successful.
> >
> > This is the workflow I tested:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 8d037973d48c026224ab285e6a06985ccac6f7bf
> > git cherry-pick -x 0e15863015d97c1ee2cc29d599abcc7fa2dc3e95
> > make allyesconfig
> > make
> >
> > Please let me know if I've made a mistake with the above commands, or if these patches aren't applicable
> > for some other reason.
> >
> 
> I guess the reason is:
> 
> 8d037973d48c026224ab285e6a06985ccac6f7bf doesn't have "Fixes:" and is
> not sent to stable@vger.kernel.org.
> And 0e15863015d97c1ee2cc29d599abcc7fa2dc3e95 is to Fix
> 8d037973d48c026224ab285e6a06985ccac6f7bf,
> so no need of 0e158 if 8d03 not backported to that particular branch.

Ok, so there's nothing to do here, great!  If there is, please let us
know.

greg k-h


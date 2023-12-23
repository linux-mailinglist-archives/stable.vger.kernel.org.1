Return-Path: <stable+bounces-8373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A97F381D337
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 09:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E60F2846D5
	for <lists+stable@lfdr.de>; Sat, 23 Dec 2023 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB06B8BF7;
	Sat, 23 Dec 2023 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pad4AWLP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781DF8BEA
	for <stable@vger.kernel.org>; Sat, 23 Dec 2023 08:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD79C433C8;
	Sat, 23 Dec 2023 08:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703321073;
	bh=IW6hUE2kf9AsFhSJIYsGmxwCwsMC2dD+WVqbdvTct2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pad4AWLPAMgdUs9ExUUTAx7VTAxcfAvHZs3r4phRMXHIqOEisxLQZbiabNX55Un2U
	 CF0zRdLJgTZMU0c3BoW1ttZKXxf7dGe2lv3zLmfdC3VRSYbO1GQOlT5YvY44hvt/Wr
	 arENfJ02hM3MvCDCCkPWcvwOl4YpPnNkDv8GOtuc=
Date: Sat, 23 Dec 2023 09:44:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Anthony Brennan <a2brenna@hatguy.io>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2] netfs: Fix missing xas_retry() calls in xarray
 iteration
Message-ID: <2023122338-cape-deplored-05a8@gregkh>
References: <20231222013229.GA1202@hatguy.io>
 <2023122200-outsell-renewal-525d@gregkh>
 <20231222195152.GB8982@hatguy.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222195152.GB8982@hatguy.io>

On Fri, Dec 22, 2023 at 02:51:52PM -0500, Anthony Brennan wrote:
> On Fri, Dec 22, 2023 at 07:26:23AM +0100, Greg KH wrote:
> > On Thu, Dec 21, 2023 at 08:32:29PM -0500, Anthony Brennan wrote:
> > > To be applied to linux-5.15.y.
> > > 
> > > commit 59d0d52c30d4991ac4b329f049cc37118e00f5b0 upstream
> > 
> > That is not this commit at all :(
> > 
> 
> Thank you for your time.
> 
> >From what I can tell, the upstream commit merged by Linus includes two
> unrelated sets of changes: handling xas_retry, and fixes to "dodgy
> maths".  I discarded the fixes to dodgy maths for two reasons, first the
> commit log says they solve a theoretical potential problem and the
> guidelines for submissions to the stable kernel say to avoid such
> patches, and second, I lack the expertise to be confident those fixes
> are correct when working with pages and not folios.
> 
> Unsure what I should have done here.

Submit a real patch for the normal tree and then we can backport the
same commit id to a stable tree.  You can't backport a merge commit as
obviously that doesn't make sense in an older tree.

thanks,

greg k-h


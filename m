Return-Path: <stable+bounces-124331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE3A5FA53
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D02118943C4
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E345E268C43;
	Thu, 13 Mar 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DrlAmA81"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593942077
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880546; cv=none; b=jTaZiPv9viBW+TWFstAF758VFBPAQIdoh6gTCHIOtIfTSl7TE8eVhlRX+w+72cSycTdRUscVKpa7ICypl+vo6PxHF8RWb3zY+75RS265KX4tMkryzzmMVrzSxyb2veD7rT5B8kuaiTqWQUUPyvxN6RoGHjHMiK0ZtoohtnJVoo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880546; c=relaxed/simple;
	bh=HyVn3ps6P12SJ76rcBeSyHq0Q2VtFtAq8FUrS8vWvoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWUJiz+4TbBOOSeUBzkBwvDHhXrO5Zd8wBg+5lwyn7QNiur/XD7wFX/omdp1JxvCKWN/uqiCDonU5sGi/bGI63kXN3+dq9Khcj7rPbb8ESPVkaKVRvY2OzB/QziQ4zrJyGgbl3zmJ+8wp0hCaMkOfnfK6tgqLFBOhLaC6FaY7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DrlAmA81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E87C4CEDD;
	Thu, 13 Mar 2025 15:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741880545;
	bh=HyVn3ps6P12SJ76rcBeSyHq0Q2VtFtAq8FUrS8vWvoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrlAmA819IzalvtEEGhS0cEwPCTBwffCaEmyW1qVdt6hQQk0Gx+fTQESghBhncAhe
	 orUa1mLbGWU/daw/Pv8ESolnRjn97R/2iUgpzmE2nDUKjzaJWCD+rKyOOtcrffsyRP
	 HJZjkDCIOB4oFKOrQAwnHJZNgH8xJ1JY/mD792lo=
Date: Thu, 13 Mar 2025 16:42:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ben Hutchings <benh@debian.org>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 5.4,5.10 2/2] udf: Fix use of check_add_overflow() with
 mixed type arguments
Message-ID: <2025031307-corrosive-overlaid-22ea@gregkh>
References: <Z7yXm_Vo1Y0Gjx_X@decadent.org.uk>
 <29f96d04ceac67563df0b4b17fb8a887dff3eb04.camel@debian.org>
 <2025031054-kiwi-snowdrift-678b@gregkh>
 <3a8557b9237ab9fc31f8d10e9a7912560af68dbb.camel@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a8557b9237ab9fc31f8d10e9a7912560af68dbb.camel@debian.org>

On Tue, Mar 11, 2025 at 06:00:58PM +0100, Ben Hutchings wrote:
> On Mon, 2025-03-10 at 17:29 +0100, Greg KH wrote:
> > On Mon, Feb 24, 2025 at 11:28:22PM +0100, Ben Hutchings wrote:
> > > On Mon, 2025-02-24 at 17:00 +0100, Ben Hutchings wrote:
> > > > Commit ebbe26fd54a9 "udf: Avoid excessive partition lengths"
> > > > introduced a use of check_add_overflow() with argument types u32,
> > > > size_t, and u32 *.
> > > > 
> > > > This was backported to the 5.x stable branches, where in 64-bit
> > > > configurations it results in a build error (with older compilers) or a
> > > > warning.  Before commit d219d2a9a92e "overflow: Allow mixed type
> > > > arguments", which went into Linux 6.1, mixed type arguments are not
> > > > supported.  That cannot be backported to 5.4 or 5.10 as it would raise
> > > > the minimum compiler version for these kernel versions.
> > > [....]
> > > 
> > > And for 5.15, I think it should be safe to backport commit
> > > d219d2a9a92e.  Otherwise this patch should be applied to fix the
> > > warning there.
> > 
> > I'll take either, whch do you want us to do?
> 
> Please apply commit d219d2a9a92e to 5.15.

It showed up in the 5.15.149 release.  Is there a portion of it missing
there?

confused,

greg k-h


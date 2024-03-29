Return-Path: <stable+bounces-33558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09244891D72
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98FB1F211B9
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB45321EB60;
	Fri, 29 Mar 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M7LtC1+x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993220FABB
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716369; cv=none; b=ROT6+3b35qHvDZhQzCzOd6niBYEOXsKSUrn6RZDnUK25jInNLmFDAEj83BhDw7YtCmTimF09zCQraAH3ic8R2EdRvTSey1GdjV6kcutFMuTDvFIPdr/188PNrltxW2l3zAkTWV6sBLiMayaG3SR1VfdRYk9Cn2OwGhzUnU5gZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716369; c=relaxed/simple;
	bh=LsMWezJhXK4R/5UjMBklU2vSbWpP6YaWSCOHbztr9GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2zWsKhVH1Wpsc9oJuVRskTcLB2ed7rvytpnEr4wFN0MUPvG5jsZ7VDkoYeC+NX7KuwZ5dZLKl8wSVsAcyEzY/CxHFz0rlL7su7bjVhZ09E7iW6AFBU3zEAX1Rk4hZLrenmGP8ZT3rMIgQtBj2hTIDl9AOPVn8J44PRqvT8mRQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M7LtC1+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD584C433C7;
	Fri, 29 Mar 2024 12:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711716369;
	bh=LsMWezJhXK4R/5UjMBklU2vSbWpP6YaWSCOHbztr9GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7LtC1+xw2Md9BGF6Ef1ADllAM0JfX2ZLgnZYzFTcU7ArE+owVpQRiL68tbH3T62c
	 fKOrQhDizLAGZlYmXgSXMoLYqmLC1t3IodRy0M4KMAVRzfOhn4tdkUyWOBU/fxMBvK
	 aoMWdA3DAhJx6q889H+G4Zdd42ksHOyYLJ9H6Smo=
Date: Fri, 29 Mar 2024 13:46:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, stable@vger.kernel.org,
	"H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/7] x86/asm: Add _ASM_RIP() macro for x86-64 (%rip)
 suffix
Message-ID: <2024032958-nearness-strut-181f@gregkh>
References: <20240226122237.198921-1-nik.borisov@suse.com>
 <20240226122237.198921-2-nik.borisov@suse.com>
 <20240312013317.7k6vlhs6iqgxbbru@desk>
 <9055ecec-e5d5-4f12-928e-7c58d5a25de1@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9055ecec-e5d5-4f12-928e-7c58d5a25de1@suse.com>

On Tue, Mar 12, 2024 at 07:57:19AM +0200, Nikolay Borisov wrote:
> 
> 
> On 12.03.24 г. 3:33 ч., Pawan Gupta wrote:
> > On Mon, Feb 26, 2024 at 02:22:31PM +0200, Nikolay Borisov wrote:
> > > From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> > > 
> > > [ Upstream commit 0576d1ed1e153bf34b54097e0561ede382ba88b0 ]
> > 
> > Looks like the correct sha is f87bc8dc7a7c438c70f97b4e51c76a183313272e
> 
> Indeed, 0576d1ed1e153bf34b54097e0561ede382ba88b0 is my local shaid of the
> backported commit. Thanks for catching it!

Can you fix this up and verify the other commit ids and resend so I
don't have to manually change them by hand?

Also, why is this series so much smaller than the 5.10 and 5.15
backports?  What is missing here that is in the 5.10 and newer kernels?
KVM stuff?

thanks,

greg k-h


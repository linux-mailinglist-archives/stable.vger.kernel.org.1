Return-Path: <stable+bounces-67516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C669509DC
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 18:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D31FB28A8C
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA521A0715;
	Tue, 13 Aug 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="L3MhIT8f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MEtDz2O/"
X-Original-To: stable@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24D91A08B1
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565350; cv=none; b=AywOTJQp2e+IhDS+eu+Yi3RzI4PsaZHPikfi2pt11sSkDPXcJoI1wLuQ+VmwtakKl1ismkfmATGEE1rF4YFoYgridYHM8DfTxYJlUeaszd2+d8VkivIuQxZIb7sdJZ18fq9bHawcxt4GILgHKxQknbxZd5jmx8iezSgeqWKbW60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565350; c=relaxed/simple;
	bh=TRPOkyKTSLUjnj2ODFD3qzWODwOdF7bMQREryKOeJmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3fVRDNk2JT98e3DPlHyyVQHCJzx4zGfjjGo+516LjbJgJr7Dd+aftQVmwwA7VbUhuN+0Ef5ZqbjIltFYzRFpRKwNNO1//R7o7rAaIBmrLWOG+6J1hKp04ICBvXi+1kG6ILTlW000hosd/njWleBRhpeBXYoRCOFDSWd8F0b6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=L3MhIT8f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MEtDz2O/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B0BBE1147F84;
	Tue, 13 Aug 2024 12:09:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 12:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723565347;
	 x=1723651747; bh=7QhfKOsAc2RqBWQH/nA6BButSzfA2NR4xsYNa5PB1Sk=; b=
	L3MhIT8finr3je4VjUVe2kZYPXSQFl+tlnJUKsF1H22Rbvg8DFT7wV0n+UaXZxY1
	Z/bf3iPTMSft9if0ubtRXZNzAXw6LI3gJi0CgYrSoLqAaqc4l5+IqbJKmUnQAa5P
	RGHjq8GdJmpF4xf181y8ku0sKE/i/k+9eBnbBrvkI2erpORjFkc6uukFeAG4BKeh
	qYYgPzTndzX4Cx0mV/yjD+OW05ckPPbDodWK8vMf3aa65zWe7K+MMKtkOhAa9MWf
	c2F9GrFkxn7R1joMfghcR3ZS5qQGSXt78vPtJvQZrr1dbbGWiuZeaBvc3JLT5IWU
	T/FEbn7qe+Xur6nItHttOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723565347; x=
	1723651747; bh=7QhfKOsAc2RqBWQH/nA6BButSzfA2NR4xsYNa5PB1Sk=; b=M
	EtDz2O/GdXz/11zPrTxIuQMiVPBNCdlbHoRFH1PEtU3WxJmvrK4y8NOIKO3377JN
	wuTwryyZcZvY/LzeP/novdmRvvrFdvXU0N4pPtT4tF2WFfrhcYygeGjAErGgVEKp
	Fbcl8RXk9SUT9zV4Nc/A99C0JZcvV6korHB+ZPg4iVA7Ec2lF5MgtOmNypirwFeJ
	DxLOXch7guaOrUtOzLfd6KOZxsJUqvVxbCu5rjz/aBaS6xT5KhnIQDTJq+SFThn6
	GfECjF2N1XjlhsvtlHK7M+2h9cUIivMo1yqQQr7/2jmllQ2Vu9QhHGBVAPydhpK1
	Xza6L2h/K8HvcQhp+bYOg==
X-ME-Sender: <xms:I4W7ZtBxWCIxcQeAhPAd_Af4TmDyVxeLVl0jG5gSPhPN9lLkXqEcUw>
    <xme:I4W7Zrhxn6mb18uadFKLv0UT3_98p-yQIuyukni6A8aQlsdzrzg0LVcq0Zcnfa_mf
    sua0CIK_RJAzQ>
X-ME-Received: <xmr:I4W7ZokTD9ZUsAjxvVo--KSphZvC_POkQ7ZyxLttOQpGVIqy1JY4Qpb8uTkFrkHGJdHX8QucGEhs0bGF2BkAJz4i5muQS6PsAXyUHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevteeggeeuhfeufedvvdfhieeilefhleeguddvfefgvddugeethefg
    heevtdfgleenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgr
    hhdrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrnhguihdrshhhhihtiheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphht
    thhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrg
    hnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhsrdhprdifihhlshho
    nheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehjohhonhgrshdrlhgrhh
    htihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrthhthhgv
    fidrrghulhgusehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhoughrihhgohdrvhhivh
    hisehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghvihhtthes
    ihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:I4W7ZnzTJ8VAbrDwmOF7h_2WM0Q4QVaXbyKqyFR6jBrb3IPHpWk8mw>
    <xmx:I4W7ZiQ4inTmfrAize-oua38G6GGNmv1zEmGKSbGmPa-COn_s5nMMg>
    <xmx:I4W7ZqbbYEey8qpKL1mZ9zd_bnafWoNAgFxZhz0GD0t0AKCKyvzXpA>
    <xmx:I4W7ZjQ7Ok3b4csjbIBlMQK81wTOSsImszYa6Kx3X5wFGKHEEya6JA>
    <xmx:I4W7ZrCzGYYNA8lKk8M0HRLdQvAZWa7ZkKPGPUb7el0BTJ4sfJ3M_yrM>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 12:09:06 -0400 (EDT)
Date: Tue, 13 Aug 2024 18:09:04 +0200
From: Greg KH <greg@kroah.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: stable@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <Jonathan.cavitt@intel.com>
Subject: Re: [PATCH 4.19.y] drm/i915/gem: Fix Virtual Memory mapping
 boundaries calculation
Message-ID: <2024081308-olive-fondness-db98@gregkh>
References: <2024081222-process-suspect-d983@gregkh>
 <20240813141436.25278-1-andi.shyti@linux.intel.com>
 <2024081306-tasty-spoof-62c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024081306-tasty-spoof-62c6@gregkh>

On Tue, Aug 13, 2024 at 05:28:15PM +0200, Greg KH wrote:
> On Tue, Aug 13, 2024 at 04:14:36PM +0200, Andi Shyti wrote:
> > Commit 8bdd9ef7e9b1b2a73e394712b72b22055e0e26c3 upstream.
> > 
> > Calculating the size of the mapped area as the lesser value
> > between the requested size and the actual size does not consider
> > the partial mapping offset. This can cause page fault access.
> > 
> > Fix the calculation of the starting and ending addresses, the
> > total size is now deduced from the difference between the end and
> > start addresses.
> > 
> > Additionally, the calculations have been rewritten in a clearer
> > and more understandable form.
> > 
> > Fixes: c58305af1835 ("drm/i915: Use remap_io_mapping() to prefault all PTE in a single pass")
> > Reported-by: Jann Horn <jannh@google.com>
> > Co-developed-by: Chris Wilson <chris.p.wilson@linux.intel.com>
> > Signed-off-by: Chris Wilson <chris.p.wilson@linux.intel.com>
> > Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: <stable@vger.kernel.org> # v4.9+
> > Reviewed-by: Jann Horn <jannh@google.com>
> > Reviewed-by: Jonathan Cavitt <Jonathan.cavitt@intel.com>
> > [Joonas: Add Requires: tag]
> > Requires: 60a2066c5005 ("drm/i915/gem: Adjust vma offset for framebuffer mmap offset")
> > Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20240802083850.103694-3-andi.shyti@linux.intel.com
> > (cherry picked from commit 97b6784753da06d9d40232328efc5c5367e53417)
> > Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/i915_gem.c | 48 +++++++++++++++++++++++++++++----
> >  1 file changed, 43 insertions(+), 5 deletions(-)
> 
> Both now applied, thanks.

Wait, did you build this?  I get the following error:

  CC [M]  drivers/gpu/drm/i915/i915_gem.o
drivers/gpu/drm/i915/i915_gem.c: In function ‘set_address_limits’:
drivers/gpu/drm/i915/i915_gem.c:2034:18: error: ‘obj_offset’ undeclared (first use in this function); did you mean ‘iova_offset’?
 2034 |         start -= obj_offset;
      |                  ^~~~~~~~~~
      |                  iova_offset


I'll drop this now.

Can you fix this up and provide a working version?

thanks,

greg k-h


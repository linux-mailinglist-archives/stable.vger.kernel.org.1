Return-Path: <stable+bounces-208433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08119D23E91
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 11:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06B9430161EE
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 10:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AF93570BA;
	Thu, 15 Jan 2026 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="UQSQnWLC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mf/xfsCK"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10954246788;
	Thu, 15 Jan 2026 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472489; cv=none; b=Pyd8eP/siRWtMYdQbLceVHWXXSfC360/kHwQEbH69DSZUjH1UQIJHDLYbfJbAUWSjY2FTtbPmY5vV6NkSygC5bMg8Pzj7jcu0uLVxf03QyNg1rsKJLAhGfchRXD+lbYPNcB39gK1EbUWQsFBSJGldDYn3jktIz38r8BkPpQgkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472489; c=relaxed/simple;
	bh=QS26TeEXxi6+SJXN4ksebl2L9kpIO8redC9IIBrpJfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlV1zDSzfAEqjnbM9EsUvTxdF5jdKrVMlY/KsCkPxGlf9iu2FlGrR1zkx5jv0YVhOT1yE7qviwSxSp8BFhG/NccEaFBIIoa+8NNCDBkh/tiJetZ6raf4TsdQ9cmesUxenNTRiEGQlxOpnm8Y347zifUy+6hNbX7c93MmYrVmdxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=UQSQnWLC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mf/xfsCK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26E101400165;
	Thu, 15 Jan 2026 05:21:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 15 Jan 2026 05:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768472487;
	 x=1768558887; bh=3BtAhF8oR2HeqWgnWeP8h6uM02p7oALqL8dH/2HnLzk=; b=
	UQSQnWLCFCQr7PBr43wLP+ssfOErS2NA2ZmtHcjlI6fELET7HISEnpHc4wjyT8Yx
	3aSaDkZrHte3nP+ARVMM89ZLJAEE1tQb6/pR7CwyvLD/5emwhgOOn3+IVpIsxT3F
	8Eb4AFwxYYYFklQkJzx/TKrksvokKgbIAwzdZOxfKG3Z2ptI6mhDshdVN1wwYtUP
	ly+C4iMHkn0FDi5IH2MabFIOtYfBxzdrw8o/Y9NuAeqzW2QPTy+vbZglTqTWLzaw
	kP7pgKYXFT7cp1mEKp/P69S6MmikGBii+M9loT3hFmw65AbdUHtBh0LAKPZ4bL1g
	rmGsSMB/5Gf/F2qoR2TNlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768472487; x=
	1768558887; bh=3BtAhF8oR2HeqWgnWeP8h6uM02p7oALqL8dH/2HnLzk=; b=m
	f/xfsCKk5qc65PF3YUdBH8PYtHngG69XoZEnmPJ/ReP2lUNh9WfW7nJpDK7ykjjb
	zaOBmGhJ5vRS5HoDMsLitVUDmupT9ShUzvnEdGAMOoiN0p3mzyeMj7WenBBBUux2
	ND0oXRd5q57MvjXhyJyHWsZM45xkYhppqzDEppytSOPygSM3Ni2hHsL0TfWXD8V+
	hwhqHySEPsPclUtikYnB41N+Pp55L9Zkz4j3sQ8F/pmg4OXkDAeRe1Wu1mK/9VD2
	q1hYoU1Z5ZQJkGb2ikSa8ZtM4ahEKOpJElcnRQRgaLOfPG6OipURsKhin+PLwpME
	qtJ4Qp6zxWq44bCljsAdg==
X-ME-Sender: <xms:p79oaZPi4Vohs7OPr875e-731BDQNtk5CW2RzNCYN9RMrmrrXeJTmA>
    <xme:p79oaUKbs79ZxcFuiNVEC57ECX9_z3NZI3j39xwCcrKSVFO1jCz1gIvm3w-l7wgSy
    uSkDawzwVbtr4RbVxLeY9W1mh-MTQXLoiGi45YNy55vmpOBKQ>
X-ME-Received: <xmr:p79oaT0pSeNxESOWJhjWebAUwGB4K8TRHBZrqlvXJO5RR7UZH-Oe_mP_ynhIWCyFihwTdwMGASfl9h1uVBDS0UyYw32d0hEu2cuK3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehje
    ejieehjedvteehjeevkedugeeuiefgfedufefgfffhfeetueeikedufeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghrghhlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsthgrsghlvgdqtghomhhmihhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopeifrghrthhhohhgiedukeesghhmrghilhdrtghomhdprhgtphhtthho
    pehlihhnuhhsfieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:p79oaQXj582d3Oc085_mwu4l-J71ymK4GPTN18ge3hcKDxymFMNsWw>
    <xmx:p79oadNqnJeLwrKhMA9hJhLcLTlMM8q6zKUWVksEg-DEDZkz0al8rA>
    <xmx:p79oab3g-4Dt5XBD9uNKCPjsMNomE-LJBgYCml7cElbv9StksskJpg>
    <xmx:p79oaZSZLxsjQf4X-gpWh4yKw0jrShEH3ieFL3NmcQAO7ukoN10CgA>
    <xmx:p79oacZD4GvxXfpsqw2ACd7yG3tUG8FdnRlrTZXyUdSWNdGrIoa9D7BB>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 05:21:26 -0500 (EST)
Date: Thu, 15 Jan 2026 11:21:25 +0100
From: Greg KH <greg@kroah.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linusw@kernel.org>
Subject: Re: Patch "gpiolib: rename GPIO chip printk macros" has been added
 to the 6.18-stable tree
Message-ID: <2026011530-owl-savage-9b8e@gregkh>
References: <20260113164229.1548396-1-sashal@kernel.org>
 <CAMRc=McT++3cx-bu8Gws9abX_uHiYZ1sZ_O7XPebv084jXO8CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McT++3cx-bu8Gws9abX_uHiYZ1sZ_O7XPebv084jXO8CQ@mail.gmail.com>

On Tue, Jan 13, 2026 at 05:47:09PM +0100, Bartosz Golaszewski wrote:
> On Tue, Jan 13, 2026 at 5:42 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     gpiolib: rename GPIO chip printk macros
> >
> > to the 6.18-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      gpiolib-rename-gpio-chip-printk-macros.patch
> > and it can be found in the queue-6.18 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> >
> 
> This is not a fix. I'd drop it from stable.

It is needed for the next patch to apply cleanly as the "dep-of" tag
said.  And it's probably best to just backport this now to keep patches
applying cleanly for longer over time.

thanks,

greg k-h


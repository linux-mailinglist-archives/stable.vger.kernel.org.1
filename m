Return-Path: <stable+bounces-69857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B99BC95A89C
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 02:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39F5281D7B
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 00:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114E423CB;
	Thu, 22 Aug 2024 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="1AHcfJ+T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s6WJlEQ6"
X-Original-To: stable@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E7EC5
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285614; cv=none; b=iVZfaItVvFmxL0FWCcFbMczVzWdjrOr+8k9C9fFFzm+DUUBcmaASMvwRruxdzF2/74bz7bdLk0DKEhnVETStjvtQNmiaUNoOOUbL/R2crFDah3SCxbt1qtuvbdu2i17tUsvRRDKtWANA83h6VJhQur12lhKf9XAh72G8HbjH1WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285614; c=relaxed/simple;
	bh=XZBMRBMeMjRqe36jkCtz4dOa7SkGSph/sB7Jq/AIoZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDo/+3AAvkOE++tacUcoDw35JYSLqEYouPnhwx8BtiJtZwrd/xqt3nIobadYkGQyBhWi/HJ3YProSj829YMxFuLuS0+4oU8dFeWO++S1VDk1oqgFb4QgGkycT4f1bCvE7xlXujrtU4P9PtrVAKj5nF2Un95zHzpQFN45Og0eMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=1AHcfJ+T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s6WJlEQ6; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 68D731390030;
	Wed, 21 Aug 2024 20:13:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 21 Aug 2024 20:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724285611; x=1724372011; bh=DUFBUzLdap
	IYCy6WK9qUHnyfBxRst/2LYDAotoRcdPc=; b=1AHcfJ+TBNDi5iBJAaGyoytywY
	paOEKh3a7VgMpfM+jrnIQ0Wa3XODtjiwRi0LLt1/sy3LJt3NZfhblCPykpk4jT0T
	FOs9F4EI7BEE62baz6HYG/ZFosmOcBNdtDrepoGLKsYu2chsXmHvsb9f6ghc4B9K
	V/QzWUkmDygMxJCZOiZOqz072Pis5lNC5wCpMMSw8D/zqMyr9X7GK+xwY56yfw3g
	6f6ealOIop/GrPAabTcSLq29cQ7iimhdBMy5l4k6AoLBgkOkLH+j0eYD2KniCssU
	bvyh0jRgLqJeYEaG6U1RSMnfuuUjirtRsY+oHe0d7V/vVzRghtqoUbq/afQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724285611; x=1724372011; bh=DUFBUzLdapIYCy6WK9qUHnyfBxRs
	t/2LYDAotoRcdPc=; b=s6WJlEQ6FfA0enDcmfpm371GocVpkOv1svYXCTtvqFeG
	IfT47vbByl55iamdaSKLIsYqKmepgUx8x3hmGrk9LVIA7uFPNJnmkh3in7I7rGh6
	RrNlTWkhdjpYyGtGXke5ZIKq08XqlTRnlZFQIoQtJSkSADF/7PvUXkI+YSPn5KlC
	1aBWf1RjXmJDfrOscflq5ok/QEdlbbI2pI2hYyx1v2Gh9mQ8314/cKvAbJIe53On
	YHrnJlCVpb/gfr7LecgqwqmIijJOAA2YaooJEgX6KB9vUO24x6j8mb1HEbzxbwH1
	8ZmERUU2DTjawF6Hg5VmLSk3s+mjHykeLylvx/w6og==
X-ME-Sender: <xms:q4LGZoy6Be9i9Gx0aHxQjyz8DKMxp8xEKBdokdmL25rbeEwu8FSdWA>
    <xme:q4LGZsRREJT7H74dIv54V2aY_oxLfmQfGJKFakrlALrmgJJ_rhGtt6SERBonbkM4y
    -9WTyy3DzXR0Q>
X-ME-Received: <xmr:q4LGZqVAeQSRiuV3AqVM_s3BjC927dUhv-8eVVkGEyGvohV3bLUtLmM5rSNT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghg
    sehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduud
    fhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhohigvrhes
    ihhrlhdrhhhupdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:q4LGZmgwtMrpcjzl4n-IIuTFJ_F4tYABUEFswRDGOfadFFceLLABsQ>
    <xmx:q4LGZqDQWT5gVBB1EVcWhNm8ml2csH8efYvK9I1-EyTRgKB2eoO6cw>
    <xmx:q4LGZnIwFNITpg1kPSIytZp3RW2RUv60JrAwoQWK7qLHaLXXaTiFrw>
    <xmx:q4LGZhCe1I2WPSlFXbJwytEUbW_sPr-jTErido0PNMyMNPLaDzPGcw>
    <xmx:q4LGZt_e1XNPSQoldY95nclUYXlEbIrUSUimAfAJWGi_xO2FOhxvPkzR>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 20:13:30 -0400 (EDT)
Date: Thu, 22 Aug 2024 08:12:14 +0800
From: Greg KH <greg@kroah.com>
To: Gergo Koteles <soyer@irl.hu>
Cc: stable@vger.kernel.org
Subject: Re: Patch "drm/amd/display: Don't register panel_power_savings on
 OLED panels"
Message-ID: <2024082207-enquirer-subtract-ab3c@gregkh>
References: <c8c0cae77c2f9c0a4c103b30dcda34e5ac10f820.camel@irl.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8c0cae77c2f9c0a4c103b30dcda34e5ac10f820.camel@irl.hu>

On Wed, Aug 21, 2024 at 07:01:54AM +0200, Gergo Koteles wrote:
> Hi Greg,
> 
> I think commit 76cb763e6ea62e838ccc8f7a1ea4246d690fccc9 should be
> applied to 6.10 kernel to disable Adaptive Backlight Management for
> OLED displays.

Now queued up, thanks.

greg k-h


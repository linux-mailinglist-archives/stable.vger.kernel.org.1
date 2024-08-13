Return-Path: <stable+bounces-67513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F8195091A
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FD328723F
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4281A01DB;
	Tue, 13 Aug 2024 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="DxR74xw6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FefB+oWc"
X-Original-To: stable@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB11A01B3
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562901; cv=none; b=UKzYiFo9HpAz2NqD6oEHCXaChD2XkOvmREBwqFHGKdSgSo/4VE6JgZYeFLkV9+8Mp5bHExEGkl8PPSxTW1IiAo5aruq/9fnHPsimgnLV41UXIn2x+WlVOAweyxaGl5bfVRg/P7ID/hhlYceAKC1dyEi+QFB4xUsojB0MujruMsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562901; c=relaxed/simple;
	bh=o5rKS1JZCXCwex4bZU2m6KylqOPHR/tQInOEs7DNVhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hErVuTgOpuNpoBn2jAUQTFu5rcsAWIvP8B36lwecPEZYT6bqNdYozLFuYauyLyIqC5QQN/u6C3ZRj4NA2Vn/jVNaN85PaoUEgKvw+iBlu0gcl+iUh/KJ0/rKJB38MXgXB4Jpqv5qbYcZxe8zYBQus7iqaDQpPqAr40phZMii30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=DxR74xw6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FefB+oWc; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EBFB11151AA6;
	Tue, 13 Aug 2024 11:28:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 11:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723562897; x=1723649297; bh=1KJ/VPWMEZ
	RV0HlBd/G9KbUrArDOLhZr5VCLoCYC9/U=; b=DxR74xw65W37WVfWfnQfpNuysO
	vHVc1STZixtkLoD2A2Ac+Dzp+gDgfqI5eG2HOXv3p8lQTPEArNqpK4/ASZ9+/0iq
	GvXRBO6YomCjJFOmw+hGs/yxrc/kFeZ9Nu7orx/EuG8wGmoS97xsejLgwhmFRNEx
	j2Ncj5f1Xr4bqmKt8NsscM/Am1r8l/A05+dim+lVInJhuPAOP9d2l2OrBMkf5/R2
	4xAqVvTe/eaDpVG+F74WqjX7SZex3sN/DNnCJYJUyspKggu3cWIae61LIT6pRr4b
	Tm3fYbwbT+mqaIcpaPyK9Z+lOZz/kPsWYMfvtau9jCj8hDtt8e+s4KNRcXng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723562897; x=1723649297; bh=1KJ/VPWMEZRV0HlBd/G9KbUrArDO
	LhZr5VCLoCYC9/U=; b=FefB+oWcuP9yISQGX2sBPHVn8f+reYk3yrVQ85Nm9vl7
	91SDiX4QUDGkzdUSfSkWckQ5814ev7tJ/uJVOkxmzkz9EF3fmwYMxiX1p2gBC9X9
	VU0w7L0mHOKjz+OapGsqkQRBgzp73DCc5PxCI6ZO4qguVV94cx3exBMw7YuN9XaS
	XPViZNiTrCVkufjoEaOvwRv1PyUH2x65tgb5U6gl1ZFHgYoAgJsI/OhHBJL1Amm9
	4OafLCbLhE4pKGUY7kubAYV9loh+Exav4KoX+CkGQyMBE/2x4m4tqNvCtxBIcjrH
	8jZO7M+nVccfPo2J4J4h+gCOLLd4SrF9DYGee/h3mg==
X-ME-Sender: <xms:kXu7ZhQJlVPHjXWH3RC6BovA4mLi09pxdUJexADuOd9eJ-AXQaJk5g>
    <xme:kXu7ZqzxAnuz0lVJYPAtwm-quK6XGGPf_jq2BRFH8EMHkXnxzR6tE6c1Jn5b-ddN-
    brKUEUaPGt-VA>
X-ME-Received: <xmr:kXu7Zm3GUe_eMojF1Mi7xVBOjn1T-uZ4RIwhrVj1C4CEuvbYpwTwSkSg5bvAXqQxw7QlEtcpSSNR0QHx2niPrNYDkOtgeRYXAYzBIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepleeiteevieefteelfeehveegvdetveehgffhvdejffdvleevhfffgeff
    ffejlefgnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghh
    rdgtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprghnughirdhshhihthhisehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthht
    ohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrnh
    hnhhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghhrhhishdrphdrfihilhhsohhn
    sehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepjhhoohhnrghsrdhlrghhth
    hinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrghtthhhvgif
    rdgruhhlugesihhnthgvlhdrtghomhdprhgtphhtthhopehrohgurhhighhordhvihhvih
    esihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrvhhithhtsehi
    nhhtvghlrdgtohhm
X-ME-Proxy: <xmx:kXu7ZpDWdhXEaVJ1ebyhc9_KtE99ikGhRMJVVIUiittIBYwRITWHlw>
    <xmx:kXu7Zqh_YtGhPtJzkXQyTnOnwbzX8xx90ir-T6SrjEA4ms2WBlCXJg>
    <xmx:kXu7ZtrmZ4Uu10raMJyJzAmDgztfyqUtpTUrBtRoRb9kWLZ4nwCNNg>
    <xmx:kXu7Zli4Ona27Blz1H96BUN7TwQUGmivBpBHakGIh2AqdAlBc76tVw>
    <xmx:kXu7ZhQAlJDxIEcXZ3CZMMEGUDQvTW_U_NJQ5L5Oe1QQrmlhKoEhXgOh>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 11:28:17 -0400 (EDT)
Date: Tue, 13 Aug 2024 17:28:15 +0200
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
Message-ID: <2024081306-tasty-spoof-62c6@gregkh>
References: <2024081222-process-suspect-d983@gregkh>
 <20240813141436.25278-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813141436.25278-1-andi.shyti@linux.intel.com>

On Tue, Aug 13, 2024 at 04:14:36PM +0200, Andi Shyti wrote:
> Commit 8bdd9ef7e9b1b2a73e394712b72b22055e0e26c3 upstream.
> 
> Calculating the size of the mapped area as the lesser value
> between the requested size and the actual size does not consider
> the partial mapping offset. This can cause page fault access.
> 
> Fix the calculation of the starting and ending addresses, the
> total size is now deduced from the difference between the end and
> start addresses.
> 
> Additionally, the calculations have been rewritten in a clearer
> and more understandable form.
> 
> Fixes: c58305af1835 ("drm/i915: Use remap_io_mapping() to prefault all PTE in a single pass")
> Reported-by: Jann Horn <jannh@google.com>
> Co-developed-by: Chris Wilson <chris.p.wilson@linux.intel.com>
> Signed-off-by: Chris Wilson <chris.p.wilson@linux.intel.com>
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: <stable@vger.kernel.org> # v4.9+
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Jonathan Cavitt <Jonathan.cavitt@intel.com>
> [Joonas: Add Requires: tag]
> Requires: 60a2066c5005 ("drm/i915/gem: Adjust vma offset for framebuffer mmap offset")
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20240802083850.103694-3-andi.shyti@linux.intel.com
> (cherry picked from commit 97b6784753da06d9d40232328efc5c5367e53417)
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/i915_gem.c | 48 +++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 5 deletions(-)

Both now applied, thanks.

greg k-h


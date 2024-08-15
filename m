Return-Path: <stable+bounces-67763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77844952D3D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28859282F31
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0AA38FA1;
	Thu, 15 Aug 2024 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RRCj+Tkk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hcKddZCm"
X-Original-To: stable@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7CA1AC89A
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720277; cv=none; b=ewPivF2yR8sKeylLfTiJBtpeaN1eqiR1939EtzO3pK34n0l6IrLevecwF1cXhhGFVGlziDh/e6mITKW136kmZC5KB/PfENMY2ge2dWysl/GcQ6we1Wz6b4C78UivYZQVWwBcXtri7GZEYS+vl1H+lif9k+QhhCR2HIvUzkvrcU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720277; c=relaxed/simple;
	bh=BlzwvOSZZsSlOOUxYiQOGoSiFpi4Lyab8vU8QRIyA+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZpaPAxr6wi1bboz1yu1fALWvmlXdu7syBr5UH5I8ehfiO2dPLnA1+eoOWK6Nf4BA7/wLp+JOZyTmfbbvGgajBsrY4S1jyAWMIVo5JHY0g01db6Wi+UplUJ3PjieVUoAZD9Adck8qt3NI55lSyPYTmeGKXiRMueAr/Fgpgj0uxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=RRCj+Tkk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hcKddZCm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6B3AF1389466;
	Thu, 15 Aug 2024 04:35:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 15 Aug 2024 04:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723710933; x=1723797333; bh=7dwDBbqayQ
	u+NrewDKQ8tdQi+ATz1CzQcBR/n1fqoK8=; b=RRCj+Tkkar6vdEZeBWx7lJI6qw
	RvdfRioPgrSZ+xIY3uGpAe6cp4hRxlokB4JicrnKKQ9+YcTe+oz4rtzId32ONIkt
	tdPsEUXJHHPhIv5mc2RqdqBAzfGqoeD8aXEakikrKWoNBfY56uNvoGzdEPQWGyku
	d8DIxM5nVgwb5e6urljhmL/BkOJOEx/0FqD1eGDoUpmP2ivWPfPZBmv3/wmo9RlT
	AEz5LCmsnDbCfLSwk9MQ7OYRvojRNqRgsWtdiYYYP1OR1LjsWH+8kOSXqnZtisOB
	XlbuKCpMJNdFPf/HCWykfijvfMxCqaNPFwHZzVebER3VC9UMprX1Uzh+9Vxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723710933; x=1723797333; bh=7dwDBbqayQu+NrewDKQ8tdQi+ATz
	1CzQcBR/n1fqoK8=; b=hcKddZCmzxqopPbx1hBRAOmirfVSxKlKX/7LFSx1rTr9
	63I/ZyDu/+ZUwjET8HmvVWFC5/klPU9d/ooNEtRYyYIXiFNzF0PBBVRKS4ExHuTb
	7j8zLz6+KOLAOs78cJAM1bMr+NFRTRSThxLQCGikV9Q1xNnrx+WZq6UjzO3QuH/2
	/0AMwrLsAIcEVa1Z05cxrpWI3DO2aKdtv5pTaftAKLGvf69WDFC3c9PfLM0R//ap
	mU000Jxjp5Bo05/ZQRNMBZJ9ufcEasXdYoBACTmVpNt7Bjzaoli3sMIXHC/HaOIf
	s++FZofRegRuQA6EhUgz3lrJ9aO9IrqWvm5MEKuuFQ==
X-ME-Sender: <xms:1b29ZhmDNyP-tluih_cupoFlhmQzw_mwuMAZo7JnQcFjGuH1oikLkw>
    <xme:1b29Zs1jba_9dS7_2irQzBXb67r1_Ca_2xAbAbMsslNoLh7StUMM-KKdpSWPHSRNT
    joXksjR6mE3sQ>
X-ME-Received: <xmr:1b29ZnoEmrc_jvpqwfE2eXtb7P1tjGkX6j_Bi3-nTmw96uy6AgBLAHCC9i4P5Qhieq27Iwv1hI2jwnYn1dM7_4Sl23Y5KvFVqyoYcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgtdegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:1b29Zhnw9L1bsLslGhhV860mE3VtzJEtCdNxMeyUAxiNUgbz-6SogA>
    <xmx:1b29Zv10UDLBIT7ZYnSnmaW5gdGiLBgb0PrIfUzQyPJXTIb6fd36KA>
    <xmx:1b29Zgu6f3WcfEugdPuK93WVb0NRBQ7sI-xVm28tbO0lPYfFfPey1A>
    <xmx:1b29ZjWqSUdY6e3w0F7vuw-qOfC5URuIy2vzyLyoaRFO2CdofFcthA>
    <xmx:1b29ZgEYncYQqaiIAF2cT2fnrTCsEwwqNoz0gzSSV7CYLxN1ivDOJy9K>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 04:35:32 -0400 (EDT)
Date: Thu, 15 Aug 2024 10:35:25 +0200
From: Greg KH <greg@kroah.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: stable@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <Jonathan.cavitt@intel.com>
Subject: Re: [PATCH 6.1.y] drm/i915/gem: Fix Virtual Memory mapping
 boundaries calculation
Message-ID: <2024081519-hungry-shuffle-3b9e@gregkh>
References: <2024081218-quotation-thud-f8b0@gregkh>
 <20240813110829.17820-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813110829.17820-1-andi.shyti@linux.intel.com>

On Tue, Aug 13, 2024 at 01:08:29PM +0200, Andi Shyti wrote:
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
>  drivers/gpu/drm/i915/gem/i915_gem_mman.c | 53 +++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 6 deletions(-)

Now queued up, thanks.

greg k-h


Return-Path: <stable+bounces-233338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFWLKGan0mnXZQcAu9opvQ
	(envelope-from <stable+bounces-233338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 20:18:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CCC39F462
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 20:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 684F5300252B
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 18:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B479F2BEFFD;
	Sun,  5 Apr 2026 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="paN7pvhA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oWU7C/po"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330451EFF8D;
	Sun,  5 Apr 2026 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775413086; cv=none; b=a7yC6aAvVT/FdFTKY/HyPcqO/PH8dFDoSdjWIPYRJdLAiWWHw6Zh0I7KgBavrEJzN+mVKSoLEwgvIq6kughsV1Ae33Zia+nUzIZU/gSJ3HxSjP5Rzn0w7+CPZO1BvcK/it4u0CNXKg+i3fVuOsL5w/Hwn9fH5CiEWafxkBkMDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775413086; c=relaxed/simple;
	bh=baSEn/tH018JduF5lZ8JVDyQzWnDpMI1dwiJtO5j3NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVrD8e+u0o7N4gz9DjVyhvdmpsplA0XgM5soXq73Z/TAc4Gzjf2IHKf5SBfMoL2k8ul2dXW76larZKeOuov43c0B2sJ7h7F7ih+bLnbD0ij+q/clK/OOn8VQ/W6lqL3gvhbFT6IJBDzwj4zn8OCv++YjMHTs+WHfSWvuYnoeF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=paN7pvhA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oWU7C/po; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CCDF7A011B;
	Sun,  5 Apr 2026 14:18:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 05 Apr 2026 14:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775413082; x=1775499482; bh=VKse5fqVEv
	fxMtlvTxKZmnEXUMDQAUXudTmIffgzBDs=; b=paN7pvhApZuM2yGdbHLnbf7hym
	V4fhQ1UomSfUNCv0i1IWrC/4LRyIwl2KPM0+TATTmTns0H3mzn7ZSo6VtlW8LMmx
	Jsa+FU4lYaq4vXIXLATkA5niQCkZDkXgliifJa3AhuNGKulaf+lNDZZK+Mqy9All
	KFF0nsg2poloF69radlSGiogVxp1MjB8+2AVtrRKEJcD0IAmus9mmgQAe4R0gaed
	EKMKeFFG3Dkw2K5mbwYCwBc7TnWzRnAQZd3EJIivL+AoqnWzCDHojNbumlnus6Nt
	gpSFHjA1+zPjWhxd/8DIJUr1hdbZC96CQqZARKtRtNIcL9KT5UJCASvuYbIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775413082; x=1775499482; bh=VKse5fqVEvfxMtlvTxKZmnEXUMDQAUXudTm
	IffgzBDs=; b=oWU7C/ponrYCFU+INHjzFjKsTiNXYEoMMWG01zjtLmcWC4sM4UH
	XkZEhHMNRQDa33S1nRYcL8N9mLo8djg6bLDAsfYEi3Nf0JvuuFeK9gg2CzBNa77b
	MOufvrCGLithUtfX46noqRdIFwjeHsg6vsHJfU7WCqnntJsN/OrCIF0BxIpC28b9
	KEEumTCOr+bbstLQ1hqQdPivrxOblaXvhQJlGApXAqOHQ6F7fb+IINZuCmz5ISv5
	gPivxtAlj/y9aQapJvLLfdg9Qw78NSFtXxhDmqacSdgfZJ5XAeijO98TjGGL2lXV
	VkfvE3KuzYw0VZjVzSdO5cD5zNpDnaiXEHQ==
X-ME-Sender: <xms:WafSaboJ0TMUQ-MF2r9N0t1Godsady_VoOpPZzams71pTmGj7k_jBg>
    <xme:WafSadn2LCbdOVSejzgKCyQl3AD4J0RCgKCf1lwSZanVO0ahG_L613Gw-WZOORh-c
    nE0Ecn4n-RW65KSwuXQzmmazTtBRqZS2EGqtsyRd9pKCeNR>
X-ME-Received: <xmr:WafSafYZnnqtjEck3HlFaZHrImvbIG5l1s0Ym57bxOn7Ysh1VMi1tZDCbnMgx8oEZpJpAlHNh-v0oYNDkpT4NZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhefgtd
    eluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedukedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrmhhirhgusehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpmhhlrgguvghksehsuhhsvgdrtghomhdprhgtphhtthhopehr
    ohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshh
    gvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhn
    uhigsehrrghsmhhushhvihhllhgvmhhovghsrdgukhdprhgtphhtthhopehsvghnohiihh
    grthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:WafSaVVvT5j98NEpHOY3t0rRAx3e57t1TCUKGn-kVp0K16MjhfnIcQ>
    <xmx:WafSaXAXJEJr6ZFvIZTYo5vA8Ae7HaNrMIspxopBpC6hkak5ts7AKQ>
    <xmx:WafSaczSYnafTXSA8AaXU9LPcyG1dayEyLP02EdMbuWxjmbE6FwpoA>
    <xmx:WafSaVb95YfVwQonoxq7YYt-nF7u8BasjeQ86AHIJtCYSabC35Gx7g>
    <xmx:WqfSaW4l5DvKQV9llx0wu45qUPj6Lp3xxfWNWY4Wt1Zs2o7vGEeUwijF>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Apr 2026 14:18:00 -0400 (EDT)
Date: Sun, 5 Apr 2026 20:17:34 +0200
From: Greg KH <greg@kroah.com>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
Message-ID: <2026040530-sullen-overheat-a648@gregkh>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233338-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 96CCC39F462
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 01:31:50PM -0400, Tamir Duberstein wrote:
> Old GCC can miscompile printf_kunit's errptr() test when branch
> profiling is enabled. BUILD_BUG_ON(IS_ERR(PTR)) is a constant false
> expression, but CONFIG_TRACE_BRANCH_PROFILING and
> CONFIG_PROFILE_ALL_BRANCHES make the IS_ERR() path side-effectful.
> GCC's IPA splitter can then outline the cold assert arm into
> errptr.part.* and leave that clone with an unconditional
> __compiletime_assert_*() call, causing a false build failure.
> 
> This started showing up after test_hashed() became a macro and moved its
> local buffer into errptr(), which changed GCC's inlining and splitting
> decisions enough to expose the compiler bug.
> 
> Mark errptr() noinline to keep it out of that buggy IPA path while
> preserving the BUILD_BUG_ON(IS_ERR(PTR)) check and the macro-based
> printf argument checking.
> 
> Fixes: 9bfa52dac27a ("printf: convert test_hashed into macro")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604030636.NqjaJvYp-lkp@intel.com/
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
>  lib/tests/printf_kunit.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tests/printf_kunit.c b/lib/tests/printf_kunit.c
> index f6f21b445ece..a8087e8ac826 100644
> --- a/lib/tests/printf_kunit.c
> +++ b/lib/tests/printf_kunit.c
> @@ -749,7 +749,23 @@ static void fourcc_pointer(struct kunit *kunittest)
>  	fourcc_pointer_test(kunittest, try_cb, ARRAY_SIZE(try_cb), "%p4cb");
>  }
>  
> -static void
> +/*
> + * GCC < 12.1 can miscompile this test when branch profiling is enabled.
> + *
> + * BUILD_BUG_ON(IS_ERR(PTR)) is a constant false expression, but old GCC can
> + * still trip over it after CONFIG_TRACE_BRANCH_PROFILING and
> + * CONFIG_PROFILE_ALL_BRANCHES rewrite the IS_ERR() unlikely() path into
> + * side-effectful branch counter updates. IPA splitting then outlines the cold
> + * assert arm into errptr.part.* and leaves that clone with an unconditional
> + * __compiletime_assert_*() call, so the build fails even though PTR is not an
> + * ERR_PTR.
> + *
> + * Keep this test out of that buggy IPA path so the BUILD_BUG_ON() can stay in
> + * place without open-coding IS_ERR(). This can be removed once the minimum GCC
> + * includes commit 76fe49423047 ("Fix tree-optimization/101941: IPA splitting
> + * out function with error attribute"), which first shipped in GCC 12.1.
> + */
> +static noinline void
>  errptr(struct kunit *kunittest)
>  {
>  	test("-1234", "%pe", ERR_PTR(-1234));
> 
> ---
> base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
> change-id: 20260405-printf-test-old-gcc-f13fecda6524
> 
> Best regards,
> --  
> Tamir Duberstein <tamird@kernel.org>
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>


Return-Path: <stable+bounces-21822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C942785D64A
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 12:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829BC281061
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDCF3DBBA;
	Wed, 21 Feb 2024 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Wxqckkba";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NKJBIUH6"
X-Original-To: stable@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06BE3E49B
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513190; cv=none; b=Km1kbfQb1Qun/lZDhOWUq8wp8lyGjXQjWK66kzbo1Fnh54EE7UTJpThAI/y4iFusk5UHdiDpQP6RnJ0+6CYBZS0TZ6j0WPVE4YMQLPJ/FzoCNXCUiP4p4W+Wipw2D1HrjyQxvZnXBDZl5Db4CQzO+XIC/W8ihvUBZls5VkhVHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513190; c=relaxed/simple;
	bh=mHn0xDE5FxTshGeIvJEpVbDrsB/TkwvNuAMFmGAcQKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkJn3HVepCHulCinvEOqsYnfS4eOnj5eX4nMcUz1N9WcC/tv3RkA8DUV3appvKE/Cxf+D/y1Ng/Da1eCHDER6672stuyR1b2ZbKjBBTiIxaJUVmKOHnIYHdnWzJOb8iWMTeKRznbktURuL5iVT2ISiDXRYl6SaJFDdJixGvgMTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Wxqckkba; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NKJBIUH6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id A08B513800C4;
	Wed, 21 Feb 2024 05:59:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 21 Feb 2024 05:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708513187; x=1708599587; bh=J9+JWJbx0q
	Fr0WU8xndFlBYkVvFvxSrOfsplDVcwojE=; b=WxqckkbasqYqQS9jVg/XVEW2el
	GE3VaIP7quht4gB2yC3GCBjypUT6YTty4qer5r70KUawzflav3Qr5jLUQYAlI6zh
	c/s/nDqSj53geSMccJlPnUo5jBxxrh1z5lkU+vTwXmjVnVPm9XWzmo+tpUkXU6+g
	JEsXOwoEIK/43MpR8s0Hi0XhQG5dCSibemMGx2yDsH4iBgzarFGUez0U2P2YVaD7
	jQZbv1lPoTYc4UvRvhoYMe/ojpnm4YiQ1BwoHIrGfb2k5gLPuu7K4p2AQYYRk3/V
	ilMDJNhoAmYSeRQijVcjbg8PfZZTtz/hX+rHdSzGJ8EdQnveTBLKeLxzypGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708513187; x=1708599587; bh=J9+JWJbx0qFr0WU8xndFlBYkVvFv
	xSrOfsplDVcwojE=; b=NKJBIUH6ycr0wdBn6YDHO8/6bIzmGylEFPdhIRCBX9WO
	joj4nWjPM9r2p4+QXWPf1YT4HQfQPeTLd1pcSP0rpXOrz3RM6kQ0AYHv/InmKvna
	qWieHMdRjwt2+DVvKdyYzVYd3iFYz2y+IKkqg8sBbaC1g8IJly7gEOl0nx7EuGWq
	Lpl2+/bc4yedi1EZtNsI7tRptVGrYEamCkTBCJsPX20UukWemtB8UOHF2XcNJuEr
	D+kgMYC6FCbMoc61rESoWN9Tbw/Pz9VCbhnPQv7Su1JUU0JqNJQIH7LnFoma2BOh
	6wpbtvDwkgnHGn3QyEyyNM2n+wPX2GNbvr+D76yaJQ==
X-ME-Sender: <xms:o9fVZZeAU9z-LcYBth8QHbDj3IHtrQCauuBxzLGlxTvTfxFEHLyH_Q>
    <xme:o9fVZXOGP5oyJmsOIH4DzyI4ULqgysqxSOHxJpUSU_JJq8uujTvEmD-mWiy0SSxlp
    ar-l17hLD8bkg>
X-ME-Received: <xmr:o9fVZSjpO2NTIWRwyBAecqBpexWzTi2ABvdWrApdEeYoQhcjlRR_t_ApLeuy7rQaxkETdNr-2cG4wDLaTJ2B-yytPUXcKWlX4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:o9fVZS-iv_kgBMTxbFEmMSvqeMwLFeAYXLNDuAYXWE2s5vYZc8muqw>
    <xmx:o9fVZVsM5gN5wUIpBefhXcmYZdvYFSxSYTDIrTVEr86ZNnyZn_Es5w>
    <xmx:o9fVZRGh1yZ3OdMCjL1w4SFFvS_IRZHIovVtJMQiPFOMACEL6ZH1uw>
    <xmx:o9fVZWlrJBPjbFZ0U7A4yEOJK9xEjMs9T_NDqPZjTh3B5oRdbDbfzg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 05:59:46 -0500 (EST)
Date: Wed, 21 Feb 2024 11:59:39 +0100
From: Greg KH <greg@kroah.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: stable@vger.kernel.org, jakub@cloudflare.com, daniel@iogearbox.net,
	alan.maguire@oracle.com
Subject: Re: [PATCH 5.15.y] Revert "selftests/bpf: Test tail call counting
 with bpf2bpf and data on stack"
Message-ID: <2024022130-verify-finlike-8331@gregkh>
References: <20240203011229.3326803-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203011229.3326803-1-samasth.norway.ananda@oracle.com>

On Fri, Feb 02, 2024 at 05:12:28PM -0800, Samasth Norway Ananda wrote:
> This reverts commit 3eefb2fbf4ec1c1ff239b8b65e6e78aae335e4a6.
> 
> libbpf support for "tc" progs doesn't exist for the linux-5.15.y tree.
> This commit was backported too far back in upstream, to a kernel where
> the libbpf support was not there for the test.
> 
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> 
> Conflicts:
>         tools/testing/selftests/bpf/prog_tests/tailcalls.c
>         conflict was caused due to code overlap with the commit
>         b06bde1c5ed6 ("selftests/bpf: Correct map_fd to data_fd in tailcalls")
>         in the function test_tailcall_bpf2bpf_6(). As this function is
>         removed by the revert conflict is resolved.

Now qeued up, thanks.

greg k-h


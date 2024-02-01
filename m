Return-Path: <stable+bounces-17635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CE1846306
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 22:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CD51C22CF9
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 21:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586973FB0C;
	Thu,  1 Feb 2024 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="j+yqI43r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BELNTgpy"
X-Original-To: stable@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103BE3CF74;
	Thu,  1 Feb 2024 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824495; cv=none; b=MDsUID5zvw8ZH6fwyoxIjz40BXTZ7oab+BhwhVVSbZkwfXyhY5uI1g2Ia3i+aDX2iVuJhEED7vxL6lm3R+zqRftnWIxsmSds8GOn9O9vuPEOA/hqMtIqn7ulNTAr755zCZTRp0qLG+MwJVZYzoLUY0mjFS51UdKlcb/a++cAlxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824495; c=relaxed/simple;
	bh=nR0kvkFqR0qbwxWTQP7MB/kO+EF1dlzW3jyB6/fky9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLNil65DIIO/15IE/4CHS4iVaeE+1k5+nbEdUufJVMPomQ9M7rPaswvxtbbCKNVPss6UNwHb/VVkRSrAdHIceJ3s0RWjJzW+l4rIGk19MeN3bhyKy0jte/LrNKkl/Ihm6uBJCqxYTLqdN7P/8yZJS+J2uM2H1YsJJLxYNFIRdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=j+yqI43r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BELNTgpy; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id E99265C01B2;
	Thu,  1 Feb 2024 16:54:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Feb 2024 16:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1706824490;
	 x=1706910890; bh=L659rkaLJB2l0+7/FICW12+eVImq9YdyKj1CjdO5OCw=; b=
	j+yqI43rbprYiP33ZzwrEwnNMFKGaVZs3yu6+D1W+jXB8Zwga39s9hsez0bZYUQj
	xyKcsRU3WpPCuKOS33D1ZiVysSo61pd6GdRtHt7PrH1sHNYXdBqqWV05H9BYnbFz
	sZNdl3ipjgaeQHGaG6OVpH1TqTlTuP5FHX0hO6xv/q3Tn1uTRPfmvU3HKLW/TCG4
	LOR4JNZqGOkr687jqbmhoCZT8/Xic/UdO7FJ1Rvd1bvdEMq6DkD+4/lmwqRJgUga
	x3aw71qVuc2FRqmmoM0ubQKsUVsPVJ+TrbprcIcywAiXf6Vjoqf7DFA41IjPEirw
	3YMr4kr1LHYn00CO80maDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706824490; x=
	1706910890; bh=L659rkaLJB2l0+7/FICW12+eVImq9YdyKj1CjdO5OCw=; b=B
	ELNTgpyE/Cf/x8WV+MZ2HY3fPsKydkmWx/OAQsNZ0gtQYDApUl0MAJENf+PwuWK3
	y0AuMPZANIiAeLtKuNrlbTBYIlAR2rPdvmUh7+CRPKiHNAKJ4QnwZBhB4wFzQM94
	HcslVyLxEf5R/6wHLJTjdjcSN7x8Yh6E7pU3HGkNeq5zezNInDJneWnfOA2Kmchu
	YQQTp+rXYTuylTNUCezUcnYnd6lQdgMRuNICYaD3gFaYv+kWb9kIOkxeo+4LYrxi
	s88MXgxmcNXkjmVgOipC+b17zA/bhRrmswVqrZlE6CtoPj8Hhrk3qXS9vGcHYYm0
	3kP4c/qj9YQwOohMiA43w==
X-ME-Sender: <xms:KhO8ZaVmzHSoptlImrBPpRXH6p2TyKeHzuV6iHgyQtzO8a8HWhcbCw>
    <xme:KhO8ZWkOUl1dunn0fMkXknZKYF1k8hV1VkfB_vh-MYeHMI0UkGEQlNzNqq-THUyzk
    _4PNnfnUyx4qg>
X-ME-Received: <xmr:KhO8ZebQDsOuv-eluAupd0oybTM7O9V6BBkwlSTwFynNMxQ32j8hYMAmR12Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnheple
    ekheejjeeiheejvdetheejveekudegueeigfefudefgfffhfefteeuieekudefnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:KhO8ZRUC6alMyDDfpF3-LDeiGsNWlcg_PfbA1KPocVAXQ0B8UiQWNA>
    <xmx:KhO8ZUmFtA3zA7wAX1glL2cf8HxZrCVzoWlnKHCwv1JHu10G7t0sfw>
    <xmx:KhO8ZWfyzrOa-FKQdisLE_E-08RM-TYh0ywspcPup5L6NWmocQQlQg>
    <xmx:KhO8ZRjSxuSxluXFVnE9wPs4FF_gA0LRc8OFs5jZUey5mGZJhZjrCQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 16:54:50 -0500 (EST)
Date: Thu, 1 Feb 2024 13:54:48 -0800
From: Greg KH <greg@kroah.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
	stable-commits@vger.kernel.org, Brian Cain <bcain@quicinc.com>
Subject: Re: Patch "Hexagon: Make pfn accessors statics inlines" has been
 added to the 6.1-stable tree
Message-ID: <2024020139-atonable-subatomic-4bef@gregkh>
References: <20240201172135.88466-1-sashal@kernel.org>
 <CACRpkdbKVcYeC+oGMk-+wfs78GNes3fMMPR8hRQ3A_jX4-vhqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbKVcYeC+oGMk-+wfs78GNes3fMMPR8hRQ3A_jX4-vhqQ@mail.gmail.com>

On Thu, Feb 01, 2024 at 10:41:12PM +0100, Linus Walleij wrote:
> On Thu, Feb 1, 2024 at 6:21 PM Sasha Levin <sashal@kernel.org> wrote:
> 
> > This is a note to let you know that I've just added the patch titled
> >
> >     Hexagon: Make pfn accessors statics inlines
> >
> > to the 6.1-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      hexagon-make-pfn-accessors-statics-inlines.patch
> > and it can be found in the queue-6.1 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please drop this patch from the stable trees, it is not a regression
> and there are bugs in the patch.

Already dropped from all branches, thanks!

greg k-h


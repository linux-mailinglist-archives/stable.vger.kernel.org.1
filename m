Return-Path: <stable+bounces-40276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEDE8AAD0D
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 12:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848BB28295B
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC5E7FBC2;
	Fri, 19 Apr 2024 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="1QFeAigs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c/YGdiMe"
X-Original-To: stable@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D727FBB9
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523713; cv=none; b=Ca+SWFpOcTu9QIHdTjQSJ9E+EZFOD6pQCU+qq2yfV8ZCQe5Pa9c9US3lnPJG8g8exMujxOxEeHT9tUWMI0YDCFF3+yKpgMs/d4IbtIT4K3lc+ZCRk502gT/j0S6aRqVJ/hSXg2S9LPKnGFoKFZerTvF48DLdUMhCYADId9Cbm0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523713; c=relaxed/simple;
	bh=ZTj84nqUGN/RRgNteFMzML3WGxj7VbEzdcL2eOvaWxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0mLDfABUFrl3IvAw19iXS4P4Sre+V97RI7HKO89CvgF/3NB+fbrQH2TAZLHqWXphNpTRefTX3MJca4nCBkdB/AWFPA7zaLUWiUZrpqgoBszYrUewJkDC3iGy0Z1Vax7v/ldaAyWaqqlB7gl5WJqw8CEMY2ISj6/NR9ctaB7+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=1QFeAigs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c/YGdiMe; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id D9EC313800AB;
	Fri, 19 Apr 2024 06:48:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 19 Apr 2024 06:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713523710; x=1713610110; bh=auGszGP0r8
	nQpqbnbzXY9NYVss7iVgda7LQm7turTIw=; b=1QFeAigswhZ/pbhCjZLmbps77n
	CaJJJJpCHjgQ8xRUnPFuX1lpSPX4YXfEWH44zA01jp5w2Zd/kIK2coFULnfuNN93
	U5vs4jI2RMHDN50zJoYKM+MXCfY5Yg3J1tr+HP5gFsDc/DUWO8Xx2gc/8OH+Djpn
	2c9ly8EBfQ/j/RogIED4U/nhCU3HJZHMdMzrwWz8rQ26quy8gCu7oy6kg3UDIE9S
	j4BD0nZaiiJUCPI5IqTSO8ehO20uAoZL2Sp5o8B7Mupcu6ByO0HdYNwA1d1/piSG
	KhoGkmUkjwY+zrWYH+o5datT76/q2k6iHLe4p4Xbdaqlah91hUY9qvKBnZfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713523710; x=1713610110; bh=auGszGP0r8nQpqbnbzXY9NYVss7i
	Vgda7LQm7turTIw=; b=c/YGdiMeS5tcAjo6k/R/UaDkeGON4drDQ5W0/2O29Hb5
	7q+jjelr5+XSrITVtgdmwZSjx2xfScL6DUgpTeAgXobxDOX6WzEc28JRvsc6K5mD
	+XICzKivkFXhBGbEd4fMJHyQAz9/5XAWQ87MjOaK2lkJDvLn+OQIjTQ/341vpGF/
	eBR15DIyXhQ8W90kiWLT77l5CGsRxEJlprNUE0KJBqi856lNRkajIAyxY2gdJzAh
	kshZMDdesuZoz5KKemegP3J3kqsHrMaSirNfK/2iD8+qi+uHX+jvtwq21561Wsut
	CvUUpUD9Jl+E0wa3UpRr8/Qu1iO4baWnpm3rRlnV6A==
X-ME-Sender: <xms:_ksiZsKZoC7JWTJDItMsTxFnbVJSjlYGKJmNe8JE8UCcPb92MsxC9g>
    <xme:_ksiZsLfU2fZ1M-ZOQ5Y35u1RYwZsu3uM5YLb6JtghhaaUIKnwHJyaXTZss7D4NuH
    hL8QZNDTjkxgg>
X-ME-Received: <xmr:_ksiZsvp9tNmncTvU8ntiW6LBdW7FHtxHlxD55JIandfi3-foQGi0oxtyTkECu0nCL-TgyGPkUb36mFH5fr9LpQWbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:_ksiZpZZNeyeVJBLpf63-5gt-I4zFG9DKHV9nXjhLen97HKe4U3usw>
    <xmx:_ksiZjatv2cTX03wN5QcKf393fUcLK2YNToyLWpeIy0KhHU5M6r9uw>
    <xmx:_ksiZlDg6WQw6YPRTQp584lk-s90jpe13o8HkK7690yu35bZfkEo-g>
    <xmx:_ksiZpbzebNwGZRUSeFLW03QXFVUqnKTOH2Tpw42vi5-hr75Ff-6BQ>
    <xmx:_ksiZiUfopQoP8uB5sGMhE7iuCntHx_G8n11zckdF1fa1Xx6CrkKcvW2>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 06:48:30 -0400 (EDT)
Date: Fri, 19 Apr 2024 12:47:23 +0200
From: Greg KH <greg@kroah.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH for-stable-6.1 00/23] x86/efistub backports
Message-ID: <2024041911-whisking-nutshell-6605@gregkh>
References: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>

On Fri, Apr 19, 2024 at 10:11:06AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> This is the final batch of changes to bring linux-6.1.y in sync with
> 6.6 and later in terms of compatibility with tightened boot security
> requirements imposed by MicroSoft, compliance with which is a
> prerequisite for them to be willing to resume signing distro shim images
> with the MS 3rd party secure boot certificate.
> 
> Without this, distros can only boot on off-the-shelf x86 PCs after
> disabling secure boot explicitly.
> 
> Most of these changes appeared in v6.8 and have been backported to v6.6
> already.

All now queued up, thanks.

greg k-h


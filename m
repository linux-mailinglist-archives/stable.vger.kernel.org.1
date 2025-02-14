Return-Path: <stable+bounces-116420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9ADA35F61
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 14:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534E416B5E5
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 13:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E2B227BB9;
	Fri, 14 Feb 2025 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="toB4xdJW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IHM9zIQO"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D8188713
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739540143; cv=none; b=Jj7n6731Y63VbXpb1JpiGcSWIB2enWvOrFbKBT3hTaEWp1Cgk4H1H6fiOgtGviU0bbtR5xMOE/DQ3QmnyQERs5dzPZwNZYljq+U+68/dut7eCulaOGWrG8AEQ0oNMZrK73gFpNksDMeQ7jCT2RrW5bpS/jTd4IpVMcLJXIj73Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739540143; c=relaxed/simple;
	bh=seafV6A56qlMSGQtjIs6w47drKZVA9DocIsWsH0zMjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFESU1HysSAIRmgREcFSEVPn9k5OkOnDATZOgLsEQuIBBR+juVjIGFpqYrWiDubMxdSZ5Hf7F71bLI/RpSuC3834G1u4BoZZJ4c47qHCXCbJM21Ddz5WPzOT3Wf1l0c8GIWS7zP+f5Vn1PFuYiCVzLuDz0NjGbYRdOCGWtqOz60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=toB4xdJW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IHM9zIQO; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 29195138098F;
	Fri, 14 Feb 2025 08:35:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 14 Feb 2025 08:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739540140; x=1739626540; bh=CBEd3AoyYN
	/n2kajvvGA9WHOiLlc0DfRq6RA3igCfg4=; b=toB4xdJWUAKpcxIr66wvsE1ztR
	qFJdZADEKk/6REJLyYqjtUGJ550oOc809ce0BALkHw8cAKaFFrsoIX9KXP8UpnY4
	51jb+g5pS9WZmxF8HZxMyY34W/w3N0FMCa1iR/jrfl3EnnkKphybNqAurrL67tVo
	8VjvRE1SpepJZDCAEnDdqusD0uzLhQg3lzeeN+UnsADimY5gt/jrfMAsssc44bVo
	fnBc+Q2bPjGrMJ1JR8Q2kM2mD3SEZpiiw08N0jczwHPKNfj1eAoa0lj6sgsWRMH8
	8Mp4upMDR7kqAuOCiQg1s0kzd4TpiAVBRATTgyaCUsUgiV8qnvPoPg59C1QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739540140; x=1739626540; bh=CBEd3AoyYN/n2kajvvGA9WHOiLlc0DfRq6R
	A3igCfg4=; b=IHM9zIQOCrVHLfnE7A7n+nf6zSBPRE00Xe5UWqcCGVfCFbBKOiF
	g9lFeqmZZTdV/rgSZWoN/CJ6bFIocIUR6L9fwpACVzQIaEzq/rpav3rdPMdS2MA8
	fv95hBm92fCm+9fVtch9SML6MER0yKR9YFuGkZQo97WKKCQZ5NBQk20G5DI+Zev7
	ArEuLuJDj5RH/MYHa7B8sJrFFascTLypY17Hdb75WXOjoTSOzs1rAwP2bpJ/3xT+
	FCjvb6oTS4yrwVVaVgFL6+HfoNyQQiUjdVZHMm51k34PZFYOHwrOnt3pSbhpHjg9
	DLK/TlutRPH6PXc9bbvpOrnx/+s2ca1y2+Q==
X-ME-Sender: <xms:q0avZ7zfg8tqiMoGeNT-Fb4cyRXg5a7WXJHDKimczEdynqRsSUmKDw>
    <xme:q0avZzRHb7O8jmUVJgXYth4KZdfVO3XI_3fDPv7xUvV5jcWw87djKE6GkSPm-82rk
    wM-759XOFzxcA>
X-ME-Received: <xmr:q0avZ1VhqhPsE85mSda3UjrCbnLNuq782uylW1cJ9bpiNre5suwW5JUDy4RHxRWpQP1tmnjfFgGTdcBTOW4lZEnTc2-ovpjBuiJnDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueef
    hffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeigfhhsqdhsthgrsghlvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphht
    thhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:q0avZ1g7PShgmK_VsSxiLIN3Ip0nhV0SGW_CDM6xZedpgCwItgBfkg>
    <xmx:q0avZ9AYx2a_GtruW0efBrBj7WWPolxn9UNSjp3dd9kocgSQ_tCD8A>
    <xmx:q0avZ-IMt2OLsODfzCNaQzepXSkCDz5birDdKFRzugz5NkOYCQxTlw>
    <xmx:q0avZ8AZeTkKzGExohN3cHmDOGo3WEqqix42Lqz4OVQNurEfqd2yMw>
    <xmx:rEavZx1JOIWmAus2WT-ZKoCLXROb3pqQpMj7LtY_5c0eSCsPCuZn15ls>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 08:35:38 -0500 (EST)
Date: Fri, 14 Feb 2025 14:35:34 +0100
From: Greg KH <greg@kroah.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: xfs-stable@lists.linux.dev, hch@lst.de, stable@vger.kernel.org
Subject: Re: [PATCH 03/11] xfs: don't lose solo dquot update transactions
Message-ID: <2025021409-royal-swoosh-04d3@gregkh>
References: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
 <173895601451.3373740.13218256058657142856.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173895601451.3373740.13218256058657142856.stgit@frogsfrogsfrogs>

On Fri, Feb 07, 2025 at 11:27:04AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> commit d00ffba4adacd0d4d905f6e64bd8cd87011f5711 upstream

There is no such commit upstream :(

And maybe because of this, it turns out this commit breaks the build, so
I'll be dropping it now.

thanks,

greg k-h


Return-Path: <stable+bounces-152435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4E9AD5771
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54543A24B2
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1699E28314A;
	Wed, 11 Jun 2025 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="ObkTsdIP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HIv6bNXT"
X-Original-To: stable@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A01EE033
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649448; cv=none; b=kEj6fYOM3kobJKn6HDWbCRCigI9UvsvYA0V65NmhjYe6V46jQioVbyPiC2tw//hwuXviFMUOjH8tlg9GjE8ZWDQHkqiqQ5/+naHRdGdLYJb5bwpewGApyY1N5pIDApp4LPITHnAEXfN8wdYm2RE8uevD56aECCUkLaIH0zaD7rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649448; c=relaxed/simple;
	bh=tRPnHbTaJp5buuGuenpj0aR2gEqSBUKq/lwCG9OVtnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jojTwZRKADmHnIWpAILJKvxOxsvLe8Ssp6t+V5U7YjxUSueXJdH1mfBZiBYIWHuUWw38Q7nLP+uKmUKjwEj1xbF8IHhrXZotNxw+yGjaNWmrG/3ZSf8cjH+9l0UAgKWfn6i2FdX8l4nwP93MttT038qgPHYjUFWuZ7IusMsKhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=ObkTsdIP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HIv6bNXT; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 054EC114020B;
	Wed, 11 Jun 2025 09:44:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 11 Jun 2025 09:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749649444;
	 x=1749735844; bh=AoHuy+PPAI7s4KgapqYPKF9IeslQPaIqBSDo9lRfrCo=; b=
	ObkTsdIPWe3S/3OoXpyT/oZs1C3bcymBRHpHFw2gttHP9tSztnQAp4NLpC3yxv97
	tNojWquIMI5BQUZLKYy4+eYyuYNkWf3OlA4+ZtfU1pfINfZSYO66nG4mmH44JMr0
	uSQlLw5HQd5MSgCTA30PnBILxjmXDd0zFVh0ywFmhg6321I7GaVU/A4sl4b4zWts
	WfXW887KIdVjvOd6kJtagnekUpxIiqViLkf/OCoNn8PF9hjSmu/V2FXVXEWKV8Y6
	p+IBRzHhoBbvl7wYqljSYot32rf8wsxP/HO2fEfxrZTMsclWHeuJXYnLg1kZ/9tr
	kIaRLVGm1pftLvK8JlYVYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749649444; x=
	1749735844; bh=AoHuy+PPAI7s4KgapqYPKF9IeslQPaIqBSDo9lRfrCo=; b=H
	Iv6bNXT+5AeGkMkqGGQRjk82D+TwbodsqNZrENG0D6sYS8XvkC9DUQfrjlQD5vGl
	N+OIdIBU3pr/00GKZtz79Ma1UH0XVl8bYIar4BpppE8oOzCuX3S/qOHWZzEtQH24
	ULniUyu8bF2ZkLYk4l9V4fKUZh+oCpRrDBD7e75E99gK+nCKKKodrK1ZqI9ZxMHI
	qWitUAfrtb+FD/jWYU5v7np/HJmuZoCcI/zi8lLATucpONhjU5WrHPXW7JCCAkCZ
	fOsVpGorZRTNveTjzcBUHATB4txcHhsjS7IFjARERFlq7oaNVkhyNLS0qri4Uzm1
	0FvSVMpE6dq2Tb5Y30xaw==
X-ME-Sender: <xms:JIhJaNMgogllZwaQB4OonqvlB6zsX3cklMY9v4bpI4oVwFWGbPM4yg>
    <xme:JIhJaP-n_0cWMYzsk1_D3FAaH92UfaNUNdQGqS5sR7cLkVlKb59YukNQZbxPekN1V
    wu9Pk0TkfTe0kRrkGs>
X-ME-Received: <xmr:JIhJaMT5PVHkZ6Eiz-xOtV-pnCiN-RQMtYpzhD3Fnn60WFdho7l0FA4VXy9BEjo6lL69TybfxxjcQ3xCrczlY9T_24ZC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdeftddmnecujfgurhepfffhvfevuffk
    fhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrg
    hrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeffvddu
    leetjeeitdeutedvudeghfdufedvkeevleetlefhfeekvefgtedvkeevffenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhf
    rghrrhdrtggtpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JIhJaJvcXMOVX-QvnyVI85_a3VqbkvTOfKtX2MU4Jn-PnQPEcy_x0A>
    <xmx:JIhJaFf05KFqmVcVtCFeXc11RAxVcrsOpA2c7GMNHL9NRxtahFWEBw>
    <xmx:JIhJaF3PHNX3ZRJ4EeA_UOnXhw8cn3HjW7t193ENcvumIgH24On92w>
    <xmx:JIhJaB9q6-FT1agEEFMzUCRtkIIYnEcxIIwjTFXL2VTaKJ5xTdezTQ>
    <xmx:JIhJaMpOq41Ypi8jmFAuy75P17yyyv6CvR5wPqrKQs5SnGeLz5jgrYQ6>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 09:44:04 -0400 (EDT)
Date: Wed, 11 Jun 2025 15:44:02 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 1/1] Compiler Attributes: disable __counted_by for clang
 < 19.1.3
Message-ID: <aEmIIqfXc0ml65U_@archlinux>
References: <20241029140036.577804-2-kernel@jfarr.cc>
 <20250610163544-efd1151d43dd472a@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610163544-efd1151d43dd472a@stable.kernel.org>

On 11 09:16:01, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ⚠️ Found matching upstream commit but patch is missing proper reference to it
> 
> Found matching upstream commit: f06e108a3dc53c0f5234d18de0bd224753db5019
> 
> Note: The patch differs from the upstream commit:
> ---
> 1:  f06e108a3dc53 < -:  ------------- Compiler Attributes: disable __counted_by for clang < 19.1.3
> -:  ------------- > 1:  fc85704c3dae5 Linux 6.15.2
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-5.4.y        |  Success    |  Success   |


I guess this patch has been erroneously picked up by the backport
helper. This was the patch for upstream that already got into 6.13 and
has already been applied to 6.12, 6.11 and backported to 6.6 back in
December.

Best Regards
Jan



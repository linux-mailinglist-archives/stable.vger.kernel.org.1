Return-Path: <stable+bounces-161979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B75F6B05AC8
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2171AA6341
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9552E0410;
	Tue, 15 Jul 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="CTLIsoKD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B9e4GcnF"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF91C860A;
	Tue, 15 Jul 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584807; cv=none; b=tHvwmwzgG66xVAtawXiWz7Rmxrgds9gcPZ9JkcVAwrJYAK+TUpc2/DrBNKqwa38BeMNzklsjkWEskjyrHArOUXquMxRfyNescwBnhzro1QS2aaNR8KOy6r45/MmYeDARsdVyoY5Y/TTuYf5OwTMoWDkgota4oA0DSVADPe0ARC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584807; c=relaxed/simple;
	bh=YYU9Nk/kU2fq6MsmdudsVJc6RLty5J5tmPiB6zDg980=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucorZG/rM+88d447CHL0CppjBnk/3INpYDB3ydlZp6syk1kih7KIb1bChOGVi12W6PCMGxilb9YySu3BpySSo+uDE4sZe0/Hw+TJz4RS7xpnaKESssAsTbjCYUJNOTPt26s9QFVpc1moHrVF4a9Km3GlQDSeXOt92oGbxI2gJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=CTLIsoKD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B9e4GcnF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 30061EC0DB1;
	Tue, 15 Jul 2025 09:06:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 15 Jul 2025 09:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752584803; x=1752671203; bh=CftjyjJduW
	MdmlidiqFXIPvup6Qz4bYRSzSv1UpRW/4=; b=CTLIsoKDs+AAcNGwt+v6mr0SJY
	xWvc+WKJK9r8mQuqjRxzO4M34aLWMJTbFOdWUMJY6L0Sd52kvYOeLD1C7FlyEZex
	qlLMqTlIXlMjB4yncl3qfY6c8eU7xkjCh4k4tVobi2YCYvi/MSpv7adKGrikBt5i
	Ju5xG8MtGXc/QE1LLZD+O1dXtwm7ubXZsFFKtnMy0EqS79c+qtT2SaQWVjVxki8k
	9jo68/A0ep1+XdZbA4Et+LE66NkKvSLG8Yt8e2SkCx8cirsSRy1bTsLH8JyhXfn3
	ZBN0dN692X7sxH2oQ/3tdUA4uAiIm2CPnYi1suLkqAKOVPkoUz+VYljMQQDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752584803; x=1752671203; bh=CftjyjJduWMdmlidiqFXIPvup6Qz4bYRSzS
	v1UpRW/4=; b=B9e4GcnFexx8b72tNto8IVC1CXGB/qm59j9Oq0uQdRp+6VafIfL
	LgGL8Ij2sjcwfLRpx1VN5cYJaneVJ6ZwWYQPbDtTx3x0Y9/tpMdWpS7aNhDyc1kt
	vXizlT0bGavVqHYBf1qOd0Extti9P2/1QNqp4+LVOC949uG4zm16nZh9JKh2uem6
	HUauNkcHqgYZs4xfbVXkp4U0szdOqgY2u6Otus8rlV1zeVeaASfnMEYTKanmx5bx
	PkdCKwspflNdCOvjHELa8VAFVzoyf/p+qR7AmCWw5nXfK3arQYDiUiePFhen2A2y
	GlBIuxzedme2a8lFSauYGAVGWNzIL++ngMg==
X-ME-Sender: <xms:YlJ2aN6BBlbE0iacXOHFHzreSa5b8pVwWfrlVbuSaeNoh8hO-VCpHg>
    <xme:YlJ2aJ3ERUq7FQQWFGHyK6AcSY67S29KZFkrYJzA3cWD7F2quijlQzHbxi3Kb3vox
    OHhC1BAO4s5NQ>
X-ME-Received: <xmr:YlJ2aAg4wOiB49r8Xy1uQXeBYEhIxLnlNays0F9uspyGCyJiiGv4QN__nIrY4lvsMwLhFtkdiJmHkMASWgPM2-2tilV4qzY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhefgtd
    eluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedugedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdq
    khgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hihurhihrdhkhhhruhhsthgrlhgvvhesrghrmhdrtghomh
X-ME-Proxy: <xmx:YlJ2aJp7csQT0g_yv6xtcMJj2EDFX55R1OwjTHIdFt9Jtbj8JZ-EHQ>
    <xmx:YlJ2aDPMVFRG3LgRL_In43BGgiW7ZzbCXbpibsh7TYx7L2Lh_dngFA>
    <xmx:YlJ2aF3OP6upFexbcEBSnxyZ5MT-rDQ-1TW-oSaw_mYMvkepzPwyDw>
    <xmx:YlJ2aBrLAdUS59nrSAOOvdCr1Rft4aCzln6YMvJmrY2v5WlYgAoDLg>
    <xmx:Y1J2aNPymyR4oO4LxkEczI08VZKHDzO3o6knKqXXHlWOJkhuCKEIpslo>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 09:06:42 -0400 (EDT)
Date: Tue, 15 Jul 2025 15:06:40 +0200
From: Greg KH <greg@kroah.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Yury Khrustalev <yury.khrustalev@arm.com>
Subject: Re: [PATCH 6.12.y] arm64: Filter out SME hwcaps when FEAT_SME isn't
 implemented
Message-ID: <2025071526-overblown-portion-5f5d@gregkh>
References: <20250715-stable-6-12-sme-feat-filt-v1-1-4c1d9c0336f6@kernel.org>
 <c586f05c-a077-4865-8529-08aaf16b8bd6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c586f05c-a077-4865-8529-08aaf16b8bd6@sirena.org.uk>

On Tue, Jul 15, 2025 at 02:02:08PM +0100, Mark Brown wrote:
> On Tue, Jul 15, 2025 at 01:49:23PM +0100, Mark Brown wrote:
> 
> > Fixes: 5e64b862c482 ("arm64/sme: Basic enumeration support")
> > Reported-by: Yury Khrustalev <yury.khrustalev@arm.com>
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/r/20250620-arm64-sme-filter-hwcaps-v1-1-02b9d3c2d8ef@kernel.org
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> 
> This needs an additional signoff from me, sorry - I didn't register due
> there being a signoff from me further up the chain.

That's ok, being the original author of the change makes this "ok" :)


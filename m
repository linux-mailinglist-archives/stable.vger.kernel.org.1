Return-Path: <stable+bounces-144632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549A8ABA316
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 20:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40782A2688E
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8427A450;
	Fri, 16 May 2025 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KD3OUQCg"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C366279338
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421017; cv=none; b=eN9oxfdGRjwwojDfMoywFYx7VOC2eV6U2m4xvF4yuZWT490Xs2TDf5g+Lfz+7sgE92pBhngXNfh5iaW69SncPGc08viVZl6JoBskbUOqmLFPhlJS1Td3blFMPkAM/eVXMd3SLozdXRAlmStYinPtBQg1plkqzDhIdiNjf8d8qK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421017; c=relaxed/simple;
	bh=HIxJ0ueyYfWjJgtAcIrFGQeYeeGWd3EVRx0fijc5ifM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGK1UbS28cr+XHhqkWvXTUUyMHLfOALiT/TSWIct0T+P1IevkNybG4i4nUADFnlVl5a6hht7c+kxYZ2rqpDd7AVZcg5xOjgOniB+IRf6RE7uM6hlrfmLV5jFQUux7ZoxKt3unVyRqwhCpagDYOtbYsbSmAZTMGP6MerIy7m6aUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KD3OUQCg; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3798442E79;
	Fri, 16 May 2025 18:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747421013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIxJ0ueyYfWjJgtAcIrFGQeYeeGWd3EVRx0fijc5ifM=;
	b=KD3OUQCg4y6ffyVAwSTG8OxDtIjAKtDkzBX5EayAq6DGLTMkLoOOGx8RbRLaY1SdVYyVcC
	vY4duhVBCm4Zh2kN9PKVJy1VHw/MxOhfp/aA/DYkWAbNGA/xpKciIk0/++CSjrpNjvhuYZ
	ppLII1Vpr84rpt78u9IXUeJqaC/APDbks4Zrg24jSM4CQCULCEv1ah32c4ajESd9YO9koo
	7loMPTFflve9hkn9X4NCZQxKFZc9pDmfJicpjvVcKkrnB6BNTTwYLhTFJGitSe3YGZ+x1q
	TXjBloDzxtz3PSlChEWylNx1jWfin3M+iaZPS1IVg5odjXSF0vDYjwHWWfatjA==
Date: Fri, 16 May 2025 20:43:31 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] iio: light: opt3001: fix deadlock due to
 concurrent flag access
Message-ID: <20250516204331.15c72a9b@booty>
In-Reply-To: <20250516112545-f4b2ef15e27e8b30@stable.kernel.org>
References: <20250515202145.46813-1-luca.ceresoli@bootlin.com>
	<20250516112545-f4b2ef15e27e8b30@stable.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfetudeugfehheeliefhjeejuddvledtuddttdevledthfehgeeugfetheekgfffnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemrgegiedvmedusgguugemledutddumedvleegfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemrgegiedvmedusgguugemledutddumedvleegfhdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: luca.ceresoli@bootlin.com

On Fri, 16 May 2025 14:26:41 -0400
Sasha Levin <sashal@kernel.org> wrote:

> [ Sasha's backport helper bot ]
>=20
> Hi,
>=20
> Summary of potential issues:
> =E2=9A=A0=EF=B8=8F Found matching upstream commit but patch is missing pr=
oper reference to it

Apologies, I had missed the [ Upstream commit <sha> ].

Sent v2.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


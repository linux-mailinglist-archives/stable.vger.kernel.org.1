Return-Path: <stable+bounces-161448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7DFAFEA56
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 15:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0968D5A81DC
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702272C2ABF;
	Wed,  9 Jul 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IQFGHuKb"
X-Original-To: stable@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDDD2C187
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068146; cv=none; b=s0Y5dEajCMGGmXzE3w80rIMykJCB2qAhwKDvEDfPQO3yfwAhCm2KzwivdnqMSRJvhepYx+f7JC7JX+oSzy5u4CigJl7+QKMgL/Eorj8r7p/KB2BZ4vwZpTZOsSWij/Grg8viOfzS8lGdx1fqYdYyDNH3nrW7U3+4x4p1PltoxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068146; c=relaxed/simple;
	bh=pYPOA3K6+y15YDA8PVGEJsSDekmojO0F2BmF5BCBS3k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=PGiqZfR7RWw2ubeWhRqtCgsWqezrj4jYRo3AjboADeHqwMNmGnKOo20cUJHXAD0XLmkJvaVmgAeKFUmaOoOvtn1AIMyI8HJhHmKUzlSbmvL0xja41kL+qV1uSuep+lpyEeWACNxfpbfw+0aksRD9WlzwCCVR4fYh7HFGj+HLLbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IQFGHuKb; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A09E43976;
	Wed,  9 Jul 2025 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752068135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYwSRaGJcUR7ESBmbADm+suDxApGywQdB7aXKvpSJrw=;
	b=IQFGHuKb87gWIjZTriX/8HjCSWvajkVDnGKiqbJGB+LHjtV0wmcbuX0XiZQgYmcF3Q/7mT
	H9DzNA942/RKoMhbD1vLlr5H5/jGcsQoExZsYqcXqJgrEv9Qk939MHtoKqydB7422k9Ccl
	Mrr00mnFwSQfM5jygBk1XY7ZjykPDxbgiCUYGC7YqBjyode6vjsOsIdDJu8WghMllibIEa
	Mwqty52MJl8pUIo5bxsKatHMhjLdPPjI7cGirEvhX9XyJhXr0F63fYYyqkF+3dcEsmqJfF
	GPNzH6yzx1vt8gHvfCF24pG9Pv15NBzKueyCA8VCG4wzuYP8ld6Zv85YADm5bA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 15:35:34 +0200
Message-Id: <DB7KBHKKHY3R.OG18BA9316QV@bootlin.com>
Cc: <stable@vger.kernel.org>, <luca.ceresoli@bootlin.com>,
 <olivier.benjamin@bootlin.com>, <thomas.petazzoni@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Subject: Re: Backport perf makefile fix to linux-6.6.y
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <DB7G4ZS920XB.1I7M44B53YY6Y@bootlin.com>
 <2025070906-john-uncouple-3760@gregkh>
In-Reply-To: <2025070906-john-uncouple-3760@gregkh>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkfevhffvuffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepteelkefhhfetgfevffefheefgedvjedtgfettedtjefghfdvveegheegtdfgudevnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmeehvggsieemuddvtddumegrfhguieemfehfsggsmegrugdtkeemkehfleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemhegvsgeimeduvddtudemrghfugeimeeffhgssgemrggutdekmeekfheliedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrr
 dgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

On Wed Jul 9, 2025 at 12:39 PM CEST, Greg KH wrote:
> On Wed, Jul 09, 2025 at 12:19:01PM +0200, Alexis Lothor=C3=A9 wrote:
>> Hello stable team,
>>=20
>> could you please backport commit 440cf77625e3 ("perf: build: Setup
>> PKG_CONFIG_LIBDIR for cross compilation") to linux-6.6.y ?
>>=20
>> Its absence prevents some people from building the perf tool in cross-co=
mpile
>> environment with this kernel. The patch applies cleanly on linux-6.6.y
>
> Is this a regression from older kernels that was broken in 6.6.y, or is
> this a new feature?  If a new feature, why not just use perf from a
> newer kernel version instead?

I manage to build perf with a 5.15.x kernel, while I can't in 6.6 (with the
same parameters), so yes, I would call it a regression.
To clarify my wording, when I say that missing this patch prevents from
building perf, it actually _breaks_ perf build, when trying to build it
with libtraceevent support:
=20
In file included from /home/alexis/src/buildroot/output/build/linux-6.6.94/=
tools/perf//util/session.h:5,
                 from builtin-c2c.c:29:
/home/alexis/src/buildroot/output/build/linux-6.6.94/tools/perf//util/trace=
-event.h:149:62: error: operator '&&' has no right operand
  149 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >=3D M=
AKE_LIBTRACEEVENT_VERSION(1, 5, 0)

Alexis

> thanks,
>
> greg k-h




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



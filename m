Return-Path: <stable+bounces-180493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F2EB83688
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 10:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE58B584135
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02CB2EDD6C;
	Thu, 18 Sep 2025 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="022T7HKt"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D329BD8C
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182420; cv=none; b=EAeUlBY2fctq2Q9acSHYycql7jsAqxIWeLPaQhoIHfg8j6FBEZZwTFMQCgQNLetK4Nbl6nI7gdK4md81XpWH8cs/ZSNjEHh9y6QkRYTuV6h+WfnBlG5qLXJfcg/0JK7Zx+pOTT3zLU0Oybab+hRaQGjQQLE/JGyLHPOGQL0FdRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182420; c=relaxed/simple;
	bh=VkyROtAgVUYH3KanLa39WTjo54reUG8ZyF3Euth/GYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bbmPXXSy5MLPtaki9jX3cvBr0wrj37+0kIKIRdef8nDQdn38zwqMa916uNIlIexjoHHVt67x3EY47ZOvj9KldQifm/TzvdLZt50oXk187fydsr6VZQtXvkBsRho3rdhViaQ7miQbZXVeOzSWwj5UicQ+lZjwt/fk+n0lYeyOMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=022T7HKt; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C3A2CC007BB;
	Thu, 18 Sep 2025 07:59:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 554926062C;
	Thu, 18 Sep 2025 08:00:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52B24102F1C69;
	Thu, 18 Sep 2025 10:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758182412; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1TpZIpxewTEGvwbOL91PnSmINUioshGqWbVPDnf+U40=;
	b=022T7HKt+2qinqYOaDizow480shpHp8OL18cq9qyR7MgSpxOBSDg3EIk+Id/u/9DXSS4kn
	2fg/vksY5L7hJKVR5tmfzOkJnm3eNgc0Zy3c3pdNv7ySIbOylLRREOGSsl/ULQv//Ru6TF
	aslk8nZmSvOxu91ZQVOCi4ocLS9v1FABYPVmmOZ1aLBJAWvGdCg8y4kFARKyU5Fb2O0YUP
	w3OqVPV7C3zt62ronXWPsBf5XU4Ojzfh7XqTNwPd+yk7A2dUN4iEqfsjPng1ZtbeI2zG+j
	W/uYQECNWl5J7jSJafA43Serq0HMt1uL24u4epRR4zqRsdA604F+cHbWQp2heQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: fsmc: Default to autodetect buswidth
In-Reply-To: <CACRpkdb-BxHb_xiyLf8Gx8PNTQ5nZEd8geJwb+PH+pd+SKpubQ@mail.gmail.com>
	(Linus Walleij's message of "Tue, 16 Sep 2025 20:49:25 +0200")
References: <20250914-fsmc-v1-1-6d86d8b48552@linaro.org>
	<87h5x27ned.fsf@bootlin.com>
	<CACRpkdb-BxHb_xiyLf8Gx8PNTQ5nZEd8geJwb+PH+pd+SKpubQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 18 Sep 2025 10:00:06 +0200
Message-ID: <874it02nsp.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 16/09/2025 at 20:49:25 +02, Linus Walleij <linus.walleij@linaro.org> wro=
te:

> On Tue, Sep 16, 2025 at 11:33=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
>> On 14/09/2025 at 00:35:37 +02, Linus Walleij <linus.walleij@linaro.org> =
wrote:
>
>> > I don't know where or how this happened, I think some change
>> > in the nand core.
>>
>> I had a look and honnestly could not find where we broke this. Could it
>> be possible that it never worked with DT probing and only with platform
>> data? Any idea of what was the previously working base?
>
> I tested old kernels back to 4.20 and it didn't work.
> Probably it never worked?

Ah :-) Might make sense!

> I tried to recompile something further back but I don't
> have the required old toolchains around :P

Yeah, no pb. As you said, we probably never faced the issue even though
it was latent.

>> Anyhow, this is just curiosity, patch is relevant (just a little nit
>> below?).
>> > +             };
>>
>>                  ^
>> There is a spurious ';' here, no?
>
> Fixed in v2, also made a more elaborate handling if someone
> would explicitly set the width to 2.
>
> I think the SPEAr that is the primary user always sets the width
> to 2 so they never saw this bug.

Certainly.

Thanks!
Miqu=C3=A8l


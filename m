Return-Path: <stable+bounces-194579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FEDC51767
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1C7D4FE216
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CCD2FDC5C;
	Wed, 12 Nov 2025 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A78suv9J"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580127FD78
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940013; cv=none; b=JUKiuBM61wHn/NDZo3tP+gmEcLjIuYQC7WiBd8WB24xkTlIxyDbqROJOO1RXfOwVsQD/mAzXKrKMZ5CQyrs6QDS6PXF6DLIJxJzOcN0fr3Tpq+BEz1HVnrj3GB5/3FzE+HTa93IiGNFPgjuJn88XqmE0/jEV3tfDdzZ7atFsXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940013; c=relaxed/simple;
	bh=V7VJas4OcRnxXubUexQa+LfGKvk8QPDPWv3vK3C+96g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tJ3iNXe3EHUbhtZIzCd5Q5xHCDAH3JHXz1hKQFBcqcUoRWXiX3rpk0/Y5rNSqigdRzq52U79kteajuKvzKwXVKgfnIRQBrhhCxvZGwqDyraMg+f8bpjp+2gBIpZ1673PoK7w9m26iu6Et2xoqgYUVYBl78oHTzi6vZSzpBafe4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A78suv9J; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 13A1B1A1A0F;
	Wed, 12 Nov 2025 09:33:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D86756070B;
	Wed, 12 Nov 2025 09:33:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E0121037191E;
	Wed, 12 Nov 2025 10:33:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762940008; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=V7VJas4OcRnxXubUexQa+LfGKvk8QPDPWv3vK3C+96g=;
	b=A78suv9J6JZ2r7gjwmylN4gjA0BmFOfU+51v5jfOn3/pHKb6bGvgozBKvXYxJwyBMvhesw
	iqqUSC0xYLcaSeq8QmCG9u7wSdEPPU35SsjWFABMa8oNC6XAoqv243/UfHySk4B5jMQY0g
	RlIQd77VF4riaFsjY3a25QOJnReog+RJLqwJQcKJqRkN31IJOqWDswDcbgaPfPn54M3KpA
	8skPYy+FU1FWRbUGM9gHY7uaiUWqQPBVpvszzEvSOk2FUKfSy2yJh6hELtksRRbNzIWAva
	97HqEj3bJhuo74Iq7KSUhEQo6T8KD8Jy49+ehUARosCu7N+cAfeW9xRNhHXq4w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: mtdpart: ignore error -ENOENT from parsers on
 subpartitions
In-Reply-To: <20251109115247.15448-1-ansuelsmth@gmail.com> (Christian
	Marangi's message of "Sun, 9 Nov 2025 12:52:44 +0100")
References: <20251109115247.15448-1-ansuelsmth@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 12 Nov 2025 10:33:25 +0100
Message-ID: <87y0ob7fyy.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Christian,

On 09/11/2025 at 12:52:44 +01, Christian Marangi <ansuelsmth@gmail.com> wro=
te:

> Commit 5c2f7727d437 ("mtd: mtdpart: check for subpartitions parsing
> result") introduced some kind of regression with parser on subpartitions
> where if a parser emits an error then the entire parsing process from the
> upper parser fails and partitions are deleted.
>
> Not checking for error in subpartitions was originally intended as
> special parser can emit error also in the case of the partition not
> correctly init (for example a wiped partition) or special case where the
> partition should be skipped due to some ENV variables externally
> provided (from bootloader for example)
>
> One example case is the TRX partition where, in the context of a wiped
> partition, returns a -ENOENT as the trx_magic is not found in the
> expected TRX header (as the partition is wiped)

I didn't had in mind this was a valid case. I am a bit puzzled because
it opens the breach to other special cases, but at the same time I have
no strong arguments to refuse this situation so let's go for it.

Thanks,
Miqu=C3=A8l


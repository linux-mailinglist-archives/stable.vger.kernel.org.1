Return-Path: <stable+bounces-179282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6DAB537DF
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F191BC2569
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D03A33EB01;
	Thu, 11 Sep 2025 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jYTRQGMd"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDCA20FAB2
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604817; cv=none; b=nfGffYTFj7cldOKPzEr9F10uSFtVtmbbnYxAlkdXUE3MeiFjX5fTdA3HhknlU3pBPJShMlufl8dd9sWQTpZ/v4rXfPdruNG56zKHYlXMQk4CQTgllo91MYB0gYQJs0TfcwnrfFO8kVu7jiM4RDJkz4RAUz301BuJWOOdqG9eWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604817; c=relaxed/simple;
	bh=VuW3XwSlPhCFR38vA2Wai2iQU+azk9EheDFfxT2iJJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GkzutgYQ9pHM4GdaCwYEDlSVZfYAM/cV7VNrXNFjVvPPJMIY0nNyhEaLsUq0SGKUDjLxpczG5AFZatVg8IIZqNrm6cs6eyLCQ/KV9CsWcBPk1uSewfrm9KhCQmSOCcRtnk2oiL0Q/5n0BMUnMc8HFrGKdTgWBIYP3Pn1wgBU/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jYTRQGMd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4ECDE1A0E06;
	Thu, 11 Sep 2025 15:33:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 18D0760630;
	Thu, 11 Sep 2025 15:33:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B96F1102F28ED;
	Thu, 11 Sep 2025 17:33:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757604812; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VuW3XwSlPhCFR38vA2Wai2iQU+azk9EheDFfxT2iJJU=;
	b=jYTRQGMdHcw4facgqioSpwSA42N5i/5gCbX8jxKS5OEO9GYWATCE5MeIlurb91eOJZ5Cfy
	zgZLsoRTJgNo0eCG9AlNoxpV1TW50LbX4I6O7+rVvX2NVZKcQGfDB/+nzaAI99GZWbiUcv
	Cts56LsycQDd/Tqr77V9Q2zMbPiBvxOpUPr+UZ/5xYcjzKLmxtetibTo33BNvuLXNT5n8K
	oI0BwGUrl1vgvgHyqkcSh7nb+wYi+M4HQr6G913hDCKUlIZQjHY/Xd3jUbGL0e7c1J23Bh
	1jHaQY/0nUIjQe6TADLSCzDFeIdCANVb/zIt+VGo02uRM/OJTqLLFutAJ5gkdg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Gabor Juhos <j4g8y7@gmail.com>,  Santhosh Kumar K <s-k6@ti.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org,  Daniel Golle
 <daniel@makrotopia.org>
Subject: Re: [PATCH v2] mtd: core: always verify OOB offset in
 mtd_check_oob_ops()
In-Reply-To: <87a5319j9w.fsf@bootlin.com> (Miquel Raynal's message of "Thu, 11
	Sep 2025 16:05:31 +0200")
References: <20250901-mtd-validate-ooboffs-v2-1-c1df86a16743@gmail.com>
	<175708415877.334139.11409801733118104229.b4-ty@bootlin.com>
	<454e092d-5b75-4758-a0e9-dfbb7bf271d7@ti.com>
	<87348tbeqg.fsf@bootlin.com>
	<a208824c-acf6-4a48-8fde-f9926a6e4db5@gmail.com>
	<mafs0v7lpi1j5.fsf@kernel.org> <87a5319j9w.fsf@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 11 Sep 2025 17:33:11 +0200
Message-ID: <87y0ql80nc.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 11/09/2025 at 16:05:31 +02, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

>>> Sorry for the inconvenience.
>>>
>>>> Gabor, can you check what happens with mtdblock?
>>
>> My guess from a quick look at the code is that NOR devices have
>> mtd->oobsize =3D=3D 0 and mtd_read() sets ops->ooboffs and ops->ooblen t=
o 0.
>> So now that this check is not guarded by if (ops->ooblen), it gets
>> triggered for NOR devices on the mtd_read() path and essentially turns
>> into an if (0 >=3D 0), returning -EINVAL.
>>
>> Maybe a better check is if ((ops->ooboffs + ops->ooblen) >
>> mtd_oobavail())?
>
> Interesting, might make sense to do it this way.
>
> Thanks Pratyush for the suggestion, it is worth the try.

I actually have another patch series to remove and I don't have more
time to dedicate to these issues at the moment, so I will force push and
drop all the problematic patches. More testing is needed.

Thanks,
Miqu=C3=A8l


Return-Path: <stable+bounces-98778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C09E52D6
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9444B1882D4E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6589E1DF74F;
	Thu,  5 Dec 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RCxcp1Tf"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F211DB95F;
	Thu,  5 Dec 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395421; cv=none; b=nD0glgjB4rIrP2Yop18cmns2yfSm/NeeBsAL3IZjP/DGxggu8o6ih7BovTbH7vjcMz+YnlfImFjM4wDgRlXj9sOGQrvvenTsn8f4oCwYY/BkLJFe7zUzRdZzo0xf2mEZsMwqDVdxKxxbyzy+38yXjdIXcMCDDcm3Kzip7nZSY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395421; c=relaxed/simple;
	bh=yiSEkudAAF5su0mQVGp/JKSZWSS72mWR1ykV5g3Fc5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O37dfwYMed+sbLxXj65xmhrRRkemlfw9yGbJsejGcHCKc6v97l3f8cYKsGxAjpdbLPSSjSQm6s4YwxkfdlBuVkWWsdtkAy62PxTeMYAYojCiuReJS4BMYaOSXz9pDvEddAjtqPEDrMozOe5TI+aIKoZdtCP8apiMFDkbBG8p3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RCxcp1Tf; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0FC42FF80E;
	Thu,  5 Dec 2024 10:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733395417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5t6joJtJZPuUfxufETdMhnHZDm4ow5zVt3Kp6DZ8Ic=;
	b=RCxcp1TfXULYe34tuytL3/VKwqfchUB/p2vbViNliQvadrrrUpIu/DfnjCvjhuevScl7LC
	Y6h+jUBUpXZV/1bLmaKHNHI5pMeyJXnruwLijYOY+NZDcJo86IXmwSuOZ4eKSHC0AJbgjl
	rDVUS+sfi0OABXjOYkHyK+2e5CC7yXrMGQZg5ooymjgQAy6exmeeB6UE/Qakvw/fLPG5/H
	6jK1Wulzz9ZSTHgJcvYB/bTDB3gWvaqmbBY9ISMKsTUzY2ualwQhaIEOL/UJ/rsMZJYwOP
	g/D2SkjzNLUzaOVUAf+yqBGzFCv+1BHBemrwMfPRdkQj9vZlwKlcfQUHudRUyw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kyungmin Park <kyungmin.park@samsung.com>,
	Ivan Stepchenko <sid@itb.spb.ru>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mtd: onenand: Fix uninitialized retlen in do_otp_read()
Date: Thu,  5 Dec 2024 11:43:29 +0100
Message-ID: <173339519116.766262.7666020579808375858.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114132951.12810-1-sid@itb.spb.ru>
References: <20241114132951.12810-1-sid@itb.spb.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 14 Nov 2024 16:29:51 +0300, Ivan Stepchenko wrote:
> The function do_otp_read() does not set the output parameter *retlen,
> which is expected to contain the number of bytes actually read.
> As a result, in onenand_otp_walk(), the tmp_retlen variable remains
> uninitialized after calling do_otp_walk() and used to change
> the values of the buf, len and retlen variables.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: onenand: Fix uninitialized retlen in do_otp_read()

Patche(s) will be available within hours on:
mtd/linux.git

Kind regards,
Miquèl


Return-Path: <stable+bounces-119385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA9DA42699
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8AB1893331
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B53B2192EB;
	Mon, 24 Feb 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lmgCafSl"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B498924EF7C;
	Mon, 24 Feb 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411402; cv=none; b=U/oGZXt7kEq6nMb0+7OloVOSnf4yt8toA2xy7FtE+PgTyIPXeDiZBhvzxhgyn7GV0xfR0dInHQX/vWlt0NDshAybvXBFDGJI1yTuIcCWv8oEJvHA7mN73kQFc1S/roeYN/eJMqsCbXxHZtAnqhtgCaRwOvoYztD68etSvlFrlew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411402; c=relaxed/simple;
	bh=8e+QUEACEMP9vSayM7dLVeCNo0bcfzKj1qkl0cfnorU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RtnXzj9A7HWQptMATfTiCS0A7Jg4Q00/pXSS8i/o1kCq0aQZsQHW4CKRzj3k+wer8+Cfxxr60he+lLUi5WMiMsFkyAcSC+FfDMY6v/9KbsuxS7zWofO5uljhb33xCzX/vRXIFRRthET5ffivnSprCeGfjnCkMENeP4H++n5XTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lmgCafSl; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0475444281;
	Mon, 24 Feb 2025 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740411397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8e+QUEACEMP9vSayM7dLVeCNo0bcfzKj1qkl0cfnorU=;
	b=lmgCafSlaWX4FJWfhbRr3/uGb3GKmpOjg+NFrXJ3TbBCjaRJsqeYCRiGP/NbQNyQNbfq/G
	ZCxnWXScG4vU/fFl6+AVipSym7D8L0BQCnmnMShCKmqQsuIySZoU5c/DvxvuPSvbh9MZIs
	I+a12r8ylTg4MZQHt0YMc3APuWtqfrKhEZrzPwg5o6AkSpdaTgqgIewpPQ8ISNfbdXMtGA
	0t+hNpfijn+NJ7TsV4EmWUiPAsXaBJkKxFKFYlbRvebgDOZGfCRBZ0+o7GxzhbUIiCpXPn
	T7Iwh0CldgCkZMz1EzAnpIfhj4WD40xwlTPcsELFHK8pn+CV8xNG6fD2+/TjPQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: richard@nod.at,  vigneshr@ti.com,  David.Woodhouse@intel.com,
  jarkko.lavinen@nokia.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: Fix potential UAF for mtdswap_dev pointers
In-Reply-To: <20250224133007.3037357-1-make24@iscas.ac.cn> (Ma Ke's message of
	"Mon, 24 Feb 2025 21:30:07 +0800")
References: <20250224133007.3037357-1-make24@iscas.ac.cn>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 24 Feb 2025 16:36:30 +0100
Message-ID: <875xkzfj7l.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppedvudejrdduuddvrddukeelrddukedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrudduvddrudekledrudekuddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehmrghkvgdvgeesihhstggrshdrrggtrdgtnhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepffgrvhhiugdrhghoohguhhhouhhsvgesihhnthgvlhdrtghomhdprhgtphhtthhopehjrghrkhhkohdrlhgrvhhinhgvnhesnhhokhhirgdrtghomhdprhgtphhtthhopehlihhnu
 higqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Ma,

On 24/02/2025 at 21:30:07 +08, Ma Ke <make24@iscas.ac.cn> wrote:

> In the mtdswap_init(), if the allocations fail, the error handling
> path frees d->page_buf, d->eb_data, d->revmap and d->page_data without
> setting these pointers to NULL. This could lead to UAF if subsequent
> error handling or device reset operations attempt to release these
> pointers again.
>
> Set d->page_buf, d->eb_data, d->revmap and d->page_data to NULL
> immediately after freeing them to prevent misuse. Release immediately
> and set to NULL, adhering to the 'release implies invalid' defensive
> programming principle.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: a32159024620 ("mtd: Add mtdswap block driver")

I am sorry but are you really fixing something? There are thousand of
drivers doing nothing with their freed pointers in the error path,
because they just cannot be used anymore.

Thanks,
Miqu=C3=A8l


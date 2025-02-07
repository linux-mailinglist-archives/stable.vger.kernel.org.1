Return-Path: <stable+bounces-114258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196FFA2C628
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 15:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA5D3AE2BF
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD381EB18E;
	Fri,  7 Feb 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ncyk4/qs"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F71EB182;
	Fri,  7 Feb 2025 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939590; cv=none; b=VDGqKZ1dPu3dewSRdenbS0fHvHmEYKLryi2B7LmJ9X3xy3Q3mHVn0FsLXGhXdUnqsgfJHaCqzii7ZcesTP0vgPyFn53dm64KSu/iJVb/VedHd+a8U10BRz9l79T0BjwS8HmAEhkbbKo8c8Xp1BnvtGOIXRD9QuVOwqQGvcPkpNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939590; c=relaxed/simple;
	bh=Jd0Myh4Hq/YZptZzZUeJTMRR8LJQioyYWVOaWsicxnM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u5MZDh+ni+HfDN5pQLJzZCygQC4EGA5YXXY86dnbTJuzeKXbi5g1n8Tp7gepaZcSxK4CUaNt43nDOsi6hXSo4+TCe9ObR6E8Vsr1f1JWIXC7WmpC9R4VwXlk0xhuYedwnFWOAfALImEYXBaVD03kKvWUeA2broOA9vuPuvbqJ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ncyk4/qs; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 093984441E;
	Fri,  7 Feb 2025 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738939586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHLzY1AHhlbCSw+8jJ6rJyHUwTuNIdzGBdHorOCOS/I=;
	b=Ncyk4/qs6dFs/8W9ZZUSPH1mNYkDQx0nprk9epMEojro1jiNB/iWXo6+AyqoKDSz9f0+CD
	3ibn9an9GYAHz9MFJlr8mWzg7DUNXH6zbQ4ryeIdbqNcbVDIK6zYBVe2NBLGdE1W9s5oex
	3ViHeQo3zENdPO9yVNvcDowsy8+QNdUyUi4iGiO+QQ53uMQ5CjQZepl+qLUzEuk/4+KuON
	P9TslGgTnfpqSmrjDTXWaRjcsspxZO6tZ+0NiDaS2q7YC6sLNTqKjGVdbNFqYRpclRS+WZ
	luobTXIkK9PUewEKjipe/7IGzWY6bvfyHK1hFyaH5fZHVoHiir+3B7By3smyGQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: christophe.jaillet@wanadoo.fr, 
 Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: gmpy.liaowx@gmail.com, jirislaby@kernel.org, kees@kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at, 
 stable@vger.kernel.org, vigneshr@ti.com
In-Reply-To: <20250205023141.26195-1-jiashengjiangcool@gmail.com>
References: <f9a35a4f-b774-4480-910a-cdcf926df41b@wanadoo.fr>
 <20250205023141.26195-1-jiashengjiangcool@gmail.com>
Subject: Re: [PATCH v3 1/2] mtd: Replace kcalloc() with devm_kcalloc()
Message-Id: <173893958598.2918383.9120476205146418740.b4-ty@bootlin.com>
Date: Fri, 07 Feb 2025 15:46:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevjghfuffkffggtgfgofesthekredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieffhfeulefgtdeltefgleevgffgheduledvheduudelgfehlefgheeivedvgeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepjhhirghshhgvnhhgjhhirghnghgtohholhesghhmrghilhdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopehgmhhphidrlhhirghofiigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 05 Feb 2025 02:31:40 +0000, Jiasheng Jiang wrote:
> Replace kcalloc() with devm_kcalloc() to prevent memory leaks in case of
> errors.
> 
> 

Applied to mtd/next, thanks!

[1/2] mtd: Replace kcalloc() with devm_kcalloc()
      commit: c76f83f2e834101660090406ba925526d5f27c07
[2/2] mtd: Add check for devm_kcalloc()
      commit: d132814fd6fd2ecb3618577f266611ca10d67611

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl



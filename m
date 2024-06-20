Return-Path: <stable+bounces-54785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF29116B4
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 01:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE745B215C3
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 23:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFDA7CF39;
	Thu, 20 Jun 2024 23:28:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 6.mo575.mail-out.ovh.net (6.mo575.mail-out.ovh.net [46.105.63.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2443ABC
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.63.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926094; cv=none; b=lBEO5Gze0dxXT3/T4MCH9aHieJAeDpPo1Qav2AFnyhuQ+Y9+d85dOkJe4aWNaNR1SZYu2VL0a2Qkv/5kv686fl/wNkODeu2dc3zelKZmQwnfNdBTW/BbPytlfePgWyPb55x+A8b/XVuM15UEytKg4xW3NLeapGsLV7MpGElgT/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926094; c=relaxed/simple;
	bh=20Bno1n30DsBD2LYX6UR5S9jh4So2fbTQRi6hmhPU14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rPutvjQtvpWmyduuQQJTZfXA6ikcGJlX8+aRgIrXQtiAYlIyHSlwbUj0dq3wiTdjK2Y0nnQzaNNZiG495Gym39y1+zOMbax2Brmb+ECKPBQqS+y49kkPtxn6wzao2IHy+rXULz4Sz7AUaRFkMfRqdzwNcwgbuvb3ccZfIWqswiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=46.105.63.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director1.ghost.mail-out.ovh.net (unknown [10.109.140.28])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4W4xKJ156Fz1VLD
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 23:19:48 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-bvkjt (unknown [10.110.96.185])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 541F31FD4C;
	Thu, 20 Jun 2024 23:19:47 +0000 (UTC)
Received: from etezian.org ([37.59.142.110])
	by ghost-submission-6684bf9d7b-bvkjt with ESMTPSA
	id O1+2EhO5dGb3AgAA/KbBAQ
	(envelope-from <andi@etezian.org>); Thu, 20 Jun 2024 23:19:47 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S0040f310b2f-be15-42b6-bcff-984cf221b99d,
                    C57D3D2E0A03F635C8A27B63C027BBD507C09C29) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>, 
 Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Grygorii Tertychnyi <grembeter@gmail.com>
Cc: Grygorii Tertychnyi <grygorii.tertychnyi@leica-geosystems.com>, 
 bsp-development.geo@leica-geosystems.com, stable@vger.kernel.org
In-Reply-To: <20240520153932.116731-1-grygorii.tertychnyi@leica-geosystems.com>
References: <20240520153932.116731-1-grygorii.tertychnyi@leica-geosystems.com>
Subject: Re: [PATCH v2] i2c: ocores: set IACK bit after core is enabled
Message-Id: <171892558671.2178094.6404949110171049934.b4-ty@kernel.org>
Date: Fri, 21 Jun 2024 01:19:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Ovh-Tracer-Id: 13336284400655993449
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeeffedgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffteehudffvdfhudfgffdugfejjeduheehgeefgeeuhfeiuefghffgueffvdfgfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekledrvddujedruddtledrudeiledpfeejrdehledrudegvddruddutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth

Hi

On Mon, 20 May 2024 17:39:32 +0200, Grygorii Tertychnyi wrote:
> Setting IACK bit when core is disabled does not clear the "Interrupt Flag"
> bit in the status register, and the interrupt remains pending.
> 
> Sometimes it causes failure for the very first message transfer, that is
> usually a device probe.
> 
> Hence, set IACK bit after core is enabled to clear pending interrupt.
> 
> [...]

Applied to i2c/i2c-host-next on

git://git.kernel.org/pub/scm/linux/kernel/git/local tree

Thank you,
Andi

Patches applied
===============
[1/1] i2c: ocores: set IACK bit after core is enabled
      commit: 5a72477273066b5b357801ab2d315ef14949d402



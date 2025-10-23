Return-Path: <stable+bounces-189068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09400BFF736
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 09:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1623A4F7A
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 07:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813B3298987;
	Thu, 23 Oct 2025 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nlr6XBmJ"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D986C26ED5D
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203069; cv=none; b=FsIJ9EOyvA7ZsoTUA7/ccsBmiLymfhLeBP1O5H8e2P6hEyLQjfZwX8Wcg1vzIb0y6IKe+wZtfHqmtRZwBGBL8R6Vy3/l/UeSe0+FYHH8WPsGO6xfISbm5A0ZBrDGthHp3JJTiEJDkl4Iq+1Ly0nR8zb8pc8VzcumIMBqdW1gjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203069; c=relaxed/simple;
	bh=44kSWjXhylp0VcoDGtJsPwzuZs4JwGw1Dq5stSGOOJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QevC3gQdBk4oboP6LqL/0ep7NUOFCGlegPyjSiVQ/G4bv5sXA8Oh8Oz8eZkS3sMEQjEghaqmJxE8ykoyLBhfYWFgHie3qz2p9sgLIPvB/Tor00LwQg2Ex51d5oGJZOguujNyA+Ag++711Vs2q7RWJigHY7FAxSLY27tA4je8JQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nlr6XBmJ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 246544E41298
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 07:04:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6D596062C;
	Thu, 23 Oct 2025 07:04:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C558102F2408;
	Thu, 23 Oct 2025 09:04:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761203064; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=A6EIv7MbbGBRMKtax/govJMi5UBAxZZaOhBy6c7KAOM=;
	b=nlr6XBmJgAKd4tnoGws3RG7ArQpPQ538EUt70eafCV+kpVf43I+E/6P21S2CibNHQ7YGoU
	a5wpzmVfYbGna1syZEzT3TYL2nS0vvlePMFg2xb3QKYws3bIb8B5RrYt4kQcTgoxuhEhf4
	jBh+ZxDvfD3i3i36Ty58EsHgA9tCQj3kleq1tUkfik54orKniD3NnR87Bp5NPnezs8dcdZ
	6XxWEwSb6NSfe+5uGZ8YiN9d8vsj/mFpr3wGyE2vgjRenB1SB9X5QceQhByTdxMweUJEDC
	W8SWJ3tVo1tMrawUQanAHrn+H9xDxlLjQKzO1CSzlayqMixXg864BZyYvHPN/Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, niravkumarlaxmidas.rabara@altera.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20251023033201.2182-1-niravkumarlaxmidas.rabara@altera.com>
References: <20251023033201.2182-1-niravkumarlaxmidas.rabara@altera.com>
Subject: Re: [PATCH] mtd: rawnand: cadence: fix DMA device NULL pointer
 dereference
Message-Id: <176120306155.174442.12328338821059704795.b4-ty@bootlin.com>
Date: Thu, 23 Oct 2025 09:04:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 23 Oct 2025 11:32:01 +0800, niravkumarlaxmidas.rabara@altera.com wrote:
> The DMA device pointer `dma_dev` was being dereferenced before ensuring
> that `cdns_ctrl->dmac` is properly initialized.
> 
> Move the assignment of `dma_dev` after successfully acquiring the DMA
> channel to ensure the pointer is valid before use.
> 
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: cadence: fix DMA device NULL pointer dereference
      commit: 5c56bf214af85ca042bf97f8584aab2151035840

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl



Return-Path: <stable+bounces-8326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5050481C946
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 12:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46BD1F270C0
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7491B156D3;
	Fri, 22 Dec 2023 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JHq6XV8j"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41FB18026
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7175CC0004;
	Fri, 22 Dec 2023 11:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703245055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fb0u/bXGwPiKuXrPW+QNxIq15/gSrDeXu28or0EZgU8=;
	b=JHq6XV8jvL4omyconfG2XKfpVjjNjWihSu3ZxdAsZbeM79/uBZRqYV9zqDyzcZE0NXflIN
	WhY9lUA6eohjpJlIP1NyUWv3g5iWBzKqFSihUw8xdPRqPAm55nLqkPIVTS+eRExyOFRINz
	1rpl4N9UVjM3DMZVg/y/plXGl92QuiRaBgA59Joolu7FpGfQlOthxga0fzcfuvMW+Jm892
	HtbzYQ6kEC1rC8/oZzhUwvihXc97w8SZhQWgA+/2DRO4wMtRT7JhVqlaNupDDeLPkOdg7b
	Ly2Lipoh5cjoWd5uYNdEJds1ZBd/5vVQLWL2HvK++k5cymDjUrILtGr5eMhokQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Julien Su <juliensu@mxic.com.tw>,
	Jaime Liao <jaimeliao@mxic.com.tw>,
	Jaime Liao <jaimeliao.tw@gmail.com>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	eagle.alexander923@gmail.com,
	mans@mansr.com,
	martin@geanix.com,
	=?utf-8?q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: rawnand: Clarify conditions to enable continuous reads
Date: Fri, 22 Dec 2023 12:37:30 +0100
Message-Id: <20231222113730.786693-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215123208.516590-5-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9ce693232813db39ac0e4badbe8dfec09e7e4ac2'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2023-12-15 at 12:32:08 UTC, Miquel Raynal wrote:
> The current logic is probably fine but is a bit convoluted. Plus, we
> don't want partial pages to be part of the sequential operation just in
> case the core would optimize the page read with a subpage read (which
> would break the sequence). This may happen on the first and last page
> only, so if the start offset or the end offset is not aligned with a
> page boundary, better avoid them to prevent any risk.
> 
> Cc: stable@vger.kernel.org
> Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel


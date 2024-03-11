Return-Path: <stable+bounces-27232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76941877BAA
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 09:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163221F2105E
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466BA111AC;
	Mon, 11 Mar 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bm0tUKlh"
X-Original-To: stable@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A6F519
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145508; cv=none; b=TQzEriVZmmM9fuBNXd53Z2zfUnuLgHcvMLdG/FaPempBitpx8Guh+cZoGW6Yse0wu2BkyKxRFWKCiGWfQRSKSIolR6L+0eUQt/isOnNk5oMN4KzTfX2m5vjnO12h2/GMwYC0SUpAJOAMjusgHOY7SdciriYjj7pRynnxhwWbd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145508; c=relaxed/simple;
	bh=Ja4+d5hYZ1J/GTTxla0JnUKg+/OJjUeJl5kxGxwqXHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kplijJvsg7FlvPLySDsF3QMt/kNVUCyKDsgwSd6+m3depOXvELRVjQmo5sVAoceQg5oja/eTyzF1pu3zNrsvfP1xrpl9oXMBr6y4DiWo87c0//exY7xFCQcEWrI8V7XmbNlB+/wiuQNP2C9lU/MgR1qUtZz4rmaqT+pRID6n/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bm0tUKlh; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F190120004;
	Mon, 11 Mar 2024 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710145497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLjA14wnYsJnSoHGoJfzY/KdBjvo43UoNn4NETMONSQ=;
	b=bm0tUKlhxxd+6ItRceW9ceUHPdDMneQi4vgivtfcBtWNg0NjTNFYdwFtFCEg/eafGu0BBa
	oV/7MeV4XKcAfKXGVeRNnLiuRwaKt7+1l1uQaQfhM7Uak21QBgLNYYu60600JVdQTS1A0P
	5aJkqc9fSoodAZhxvv4unkhCzRHBt1CT8qBwdPvzsr/u3HzyoLhFSgCDG7Q+HcnKYF3107
	7yw0ezcnhvMnaCVm4UBNEjUwGmzET6g5hK63cORtu3kFuR7S0ccRPthO1wveNmicLP4VM4
	nqGISpr1ICeQHt2W9hBFWRdp6QwP+8MiGXjyo8I5DIYCFIrPlmsUPw4iz/3CRA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org
Cc: Julien Su <juliensu@mxic.com.tw>,
	Jaime Liao <jaimeliao@mxic.com.tw>,
	Jaime Liao <jaimeliao.tw@gmail.com>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	eagle.alexander923@gmail.com,
	mans@mansr.com,
	martin@geanix.com,
	=?utf-8?q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: rawnand: Constrain even more when continuous reads are enabled
Date: Mon, 11 Mar 2024 09:24:50 +0100
Message-Id: <20240311082450.4191310-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240307115315.1942678-1-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'64b35c8a3acaa1236e642f4ccfc401d394f85fe8'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-03-07 at 11:53:14 UTC, Miquel Raynal wrote:
> As a matter of fact, continuous reads require additional handling at the
> operation level in order for them to work properly. The core helpers do
> have this additional logic now, but any time a controller implements its
> own page helper, this extra logic is "lost". This means we need another
> level of per-controller driver checks to ensure they can leverage
> continuous reads. This is for now unsupported, so in order to ensure
> continuous reads are enabled only when fully using the core page
> helpers, we need to add more initial checks.
> 
> Also, as performance is not relevant during raw accesses, we also
> prevent these from enabling the feature.
> 
> This should solve the issue seen with controllers such as the STM32 FMC2
> when in sequencer mode. In this case, the continuous read feature would
> be enabled but not leveraged, and most importantly not disabled, leading
> to further operations to fail.
> 
> Reported-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Tested-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next.

Miquel


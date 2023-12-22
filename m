Return-Path: <stable+bounces-8328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA9781C948
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 12:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF97B24548
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA428171C5;
	Fri, 22 Dec 2023 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jxrIlGbG"
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676DD156D3
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E05C24000E;
	Fri, 22 Dec 2023 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703245070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R01f3eF8gHCc+LoT7UClRI30ZMja+F3GQI6BRyQW3Ls=;
	b=jxrIlGbGTjp3Ch+a5Ur88yZMX6EBC+5Il34mJCCpHjHWn7Bjsjp/JCs+3ATRdiJ9apbbB4
	rRa9kpUx6rWeyKlMb55NDrMkjXDF61BbXjV2c+F05u57F83KJwhkT2xxsCg/xDPMeOeQ86
	Xmhru/gAg/5oJx4Z8pukrRoecCM/qvEEZxiMTUhgZGNAwEHZH/mNzlFVaY5M1S397r6K9n
	kToiR+NPGy+HAcR8J6H7be2qay3RG5dXAUFRfAo3nSRu3rpghUQRfE9enJhGBbUuzpQOTi
	tP4906qHt+nhjxOeGYyaJWLlbze0Yp471LmSafSjf1+THk5nhVfzrj04cLpxpQ==
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
Subject: Re: [PATCH 2/4] mtd: rawnand: Fix core interference with sequential reads
Date: Fri, 22 Dec 2023 12:37:45 +0100
Message-Id: <20231222113745.786779-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215123208.516590-3-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e576b41164bed85aa249ddfd3632c2efd42340b6'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2023-12-15 at 12:32:06 UTC, Miquel Raynal wrote:
> A couple of reports pointed at some strange failures happening a bit
> randomly since the introduction of sequential page reads support. After
> investigation it turned out the most likely reason for these issues was
> the fact that sometimes a (longer) read might happen, starting at the
> same page that was read previously. This is optimized by the raw NAND
> core, by not sending the READ_PAGE command to the NAND device and just
> reading out the data in a local cache. When this page is also flagged as
> being the starting point for a sequential read, it means the page right
> next will be accessed without the right instructions. The NAND chip will
> be confused and will not output correct data. In order to avoid such
> situation from happening anymore, we can however handle this case with a
> bit of additional logic, to postpone the initialization of the read
> sequence by one page.
> 
> Reported-by: Alexander Shiyan <eagle.alexander923@gmail.com>
> Closes: https://lore.kernel.org/linux-mtd/CAP1tNvS=NVAm-vfvYWbc3k9Cx9YxMc2uZZkmXk8h1NhGX877Zg@mail.gmail.com/
> Reported-by: Måns Rullgård <mans@mansr.com>
> Closes: https://lore.kernel.org/linux-mtd/yw1xfs6j4k6q.fsf@mansr.com/
> Reported-by: Martin Hundebøll <martin@geanix.com>
> Closes: https://lore.kernel.org/linux-mtd/9d0c42fcde79bfedfe5b05d6a4e9fdef71d3dd52.camel@geanix.com/
> Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel


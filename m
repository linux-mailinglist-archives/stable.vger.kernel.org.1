Return-Path: <stable+bounces-180494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F3EB83899
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 10:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 234317BA861
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3FB2FB96A;
	Thu, 18 Sep 2025 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oOH0Mox5"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAE2FAC0B
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184454; cv=none; b=YL/d81B7Ypx1m3U3LhK/dXChVHw9zMjm05cjPafCvZobxzVzG0dQzbk0z9mgVrDtqNx1Iu2RGV3QTy9ntON61YKUhHwjqY9c9bttk5zXxZyadOpFLqyN8MuTJ43Aka0iQzQJPWJzPYmuYBzdE9K/T/tKlybcf6SzSVQ+UCTnNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184454; c=relaxed/simple;
	bh=+PS1WfMrrRAcofcGEF4PxjdEYG/ojO5yp1cKPgccsFk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=np7yw82hWCmE0uFRlh9mCD1Mfk/zp8mjLkUB94EsJ6zhjrTGXqYGLDUigkYIsyGlGKKGiwLfMmbNAdenB6/jX9cugEpYQ5OmVihwpNCDEpQ3pswlnbS5KDVHXdwJMH4dElOlDEZnS+vIiN0jISSx3yqKOqdh2miSZxjy9Ny8/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oOH0Mox5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 081601A0ECF;
	Thu, 18 Sep 2025 08:34:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D347F6062C;
	Thu, 18 Sep 2025 08:34:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8996102F1CC5;
	Thu, 18 Sep 2025 10:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758184450; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QFKgE34XisIGkXrGzZ7Zyz7rn8aIA52XcS41XeXSSy8=;
	b=oOH0Mox5asHMPFZkgx2XdT8fdlhx+GpQjb3RhszgDnMCsGknmurYsqujTaLK5mwyoV/Kvh
	gGKPJH8ShHZ9pCVSTMdZVQ56P1SmYS1PN6Z0DtycR0P09mzCltMnKOULH4gDKX+2E+iIKy
	xja0PwOxdRVV7hMWrUbkQyc8164E48iD9oB4K2abBF33ckhFogZwoIWFQkTYQ/r4h14t9U
	1VVCIadRYj64fyFSTZH5P2ipuociGS0sUieEGIuQ2e17M99jVDcttzXfOhbbFCa6VkeV0l
	qAG2zQK3kkyZ0n6nurbqvqG+92O1t6HCi6ImChFTxniXXsDVeFnTxFeM+J6HbA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mtd@lists.infradead.org, stable@vger.kernel.org
In-Reply-To: <20250916-fsmc-v2-1-fd6c86c919ee@linaro.org>
References: <20250916-fsmc-v2-1-fd6c86c919ee@linaro.org>
Subject: Re: [PATCH v2] mtd: rawnand: fsmc: Default to autodetect buswidth
Message-Id: <175818444989.1151539.14951494454855559061.b4-ty@bootlin.com>
Date: Thu, 18 Sep 2025 10:34:09 +0200
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

On Tue, 16 Sep 2025 18:07:37 +0200, Linus Walleij wrote:
> If you don't specify buswidth 2 (16 bits) in the device
> tree, FSMC doesn't even probe anymore:
> 
> fsmc-nand 10100000.flash: FSMC device partno 090,
>   manufacturer 80, revision 00, config 00
> nand: device found, Manufacturer ID: 0x20, Chip ID: 0xb1
> nand: ST Micro 10100000.flash
> nand: bus width 8 instead of 16 bits
> nand: No NAND device found
> fsmc-nand 10100000.flash: probe with driver fsmc-nand failed
>   with error -22
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: fsmc: Default to autodetect buswidth
      commit: b8df622cf7f6808c85764e681847150ed6d85f3d

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl



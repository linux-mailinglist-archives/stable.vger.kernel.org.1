Return-Path: <stable+bounces-87046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341CE9A6108
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB141C22171
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B936E1E47D3;
	Mon, 21 Oct 2024 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AOOtaEze"
X-Original-To: stable@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E391E47A9
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504957; cv=none; b=knZ3YEc7WvbDbGxY5EDMWC8CG4iQiywximIu/aVgJj6hJ1Q/vSEn32sbNPcOOOLsRIMXNtXUS3nX6bhsduywMUJLjI8qSULX+x2aqwnprNVN2VMtV3LOrov43aTkkCy67J2hC94Xj1mFVChk/V1aH2o3QnH16X7GZIZd7SQqvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504957; c=relaxed/simple;
	bh=1jpirb51L86e0PNqoe8bQNi1lEZwSmojz+sOjHvkV2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bic2LUovJCMVnO/sLFBteZeNcC/IExJApIU0A4/bPZoi6qcia1WTquNsVgi7roHYeMYSd/EZPV0hXaGdedHPw4n69iLULPPWVOIiG94BILspFaj0sYe++n3UVEqldOEHIzClAypSPrhUdnj4J5+u++8cUaxCQ6xK1RpUXyJdG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AOOtaEze; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4FDDC20003;
	Mon, 21 Oct 2024 10:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729504953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7O7CUR52oli7h54t1OZFWTBl6V00t65INe4Y4XJcl2A=;
	b=AOOtaEzeo3bBDeUXJGr7jpPhsIywq9YjN4+swbqszhOu9CxMYYs6xEKGVELN1Wr2OmF1Bj
	NY8WJpjVFJ9zNc2bNaiWHj5CaPtyUu7vjSmgwJS2luCtpltHyFVeZAiTBnd0sSljlC+jpG
	pcD9LLEpy9V/QR1PQwbC368L/oSV1Vy1KmhC9WNrsXiU6mfE4aqJSbTGMMb8zJb7eIMhZ1
	efIrJnmOD+sPsVTNvXJUvMRTrOmgbfDl3t8ZowBcWLcJuL061u351Q1Lge2BRbaipqxt6g
	sXI49aIjGYJy/23MRdh6ee2Gh6CKMyyphMQX+pWreQavdbc0Hvb4MO8ZcpXP6A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org
Cc: Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sridharan S N <quic_sridsn@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] mtd: spi-nand: winbond: Fix 512GW and 02JW OOB layout
Date: Mon, 21 Oct 2024 12:02:31 +0200
Message-ID: <20241021100231.173335-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009125002.191109-2-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c1247de51cab53fc357a73804c11fb4fba55b2d9'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-10-09 at 12:49:59 UTC, Miquel Raynal wrote:
> Both W25N512GW and W25N02JW chips have 64 bytes of OOB and thus cannot
> use the layout for 128 bytes OOB. Reference the correct layout instead.
> 
> Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAND flash")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next.

Miquel


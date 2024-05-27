Return-Path: <stable+bounces-46298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1288CFFC1
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E921F21DA7
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C57F15E5AB;
	Mon, 27 May 2024 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="REiI4qdl"
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A415EFCE
	for <stable@vger.kernel.org>; Mon, 27 May 2024 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812110; cv=none; b=dBvvYAsQ7dpr8UUD3pUcOo9OlnTySbTeFpZ+aht/oNIcTAI3c38V1BCwFMHVAQSgBNcwpCsoL1O/wiIGuBbz+tjoKGdPTU4b+eGLdITVBEjoSSFI5esz9Gz9VQZhBFdU7gO+l4oGwivT42PSItVYLtrn/4O8UlCiTJgclD7yoTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812110; c=relaxed/simple;
	bh=+avf/N5SgZO4/ArRiQfrlVn+9Fvtdu3FHjhoTcNyha4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PdTTcfaSskkTf4s6xpI6250600wNQ7SyJQ9Y79PxKSWED2KR+UMRMfpbx6iHX+IItqf+GanP0FB1F0FPN6YB8+MEVdMiPxjTsQLDB/ypeGehHvAW4zN7+zQ+L0St1x32CmboB9ZjeIHzS1Pgm482P4AIRWMF+6td/mdQ+7RC3Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=REiI4qdl; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0F0560004;
	Mon, 27 May 2024 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xzi/CRJAcaEIeW06Kq8bs5FFCMW8/bBofcZu7yIzBzU=;
	b=REiI4qdlViC7FaLGKKWsmzxe3zs8YdIgz0DPEgKJv2vFCvyBnN6dIwo+Tz8SLNfX3tKGPx
	IDIVzhl964q0lBJvpMwHJo7s3AU8V97MF16Ka2BOAsnefHBvJCg9PqN3xv+hiITErvHeQI
	/8ETWVUfUdXABYEQLbOrPQufxtumosoxkBJAmTq4yIaNF36pGyg/zCpehgkKBcfC9H98Zc
	OPAV3NmsKuRqcHGg68Ti5sVKEArzhnBJxTUDQ4rK+cH0MsCFr4chhhfXAPhDhRpKKEpyxl
	SvA1ebZjzcwTOSz+DYAPcywt1eEDHXLGZBVJ2GumFCXbiJ1rafhD6j4tKoJKxw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org
Cc: Alexander Dahl <ada@thorsis.com>,
	Steven Seeger <steven.seeger@flightsystems.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mtd: rawnand: Fix the nand_read_data_op() early check
Date: Mon, 27 May 2024 14:15:00 +0200
Message-Id: <20240527121500.29766-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516131320.579822-2-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'5da39530d19946f6241de84d1db69da2f5c61da7'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-05-16 at 13:13:19 UTC, Miquel Raynal wrote:
> The nand_read_data_op() operation, which only consists in DATA_IN
> cycles, is sadly not supported by all controllers despite being very
> basic. The core, for some time, supposed all drivers would support
> it. An improvement to this situation for supporting more constrained
> controller added a check to verify if the operation was supported before
> attempting it by running the function with the check_only boolean set
> first, and then possibly falling back to another (possibly slightly less
> optimized) alternative.
> 
> An even newer addition moved that check very early and probe time, in
> order to perform the check only once. The content of the operation was
> not so important, as long as the controller driver would tell whether
> such operation on the NAND bus would be possible or not. In practice, no
> buffer was provided (no fake buffer or whatever) as it is anyway not
> relevant for the "check_only" condition. Unfortunately, early in the
> function, there is an if statement verifying that the input parameters
> are right for normal use, making the early check always unsuccessful.
> 
> Fixes: 9f820fc0651c ("mtd: rawnand: Check the data only read pattern only once")
> Cc: stable@vger.kernel.org
> Reported-by: Alexander Dahl <ada@thorsis.com>
> Closes: https://lore.kernel.org/linux-mtd/20240306-shaky-bunion-d28b65ea97d7@thorsis.com/
> Reported-by: Steven Seeger <steven.seeger@flightsystems.net>
> Closes: https://lore.kernel.org/linux-mtd/DM6PR05MB4506554457CF95191A670BDEF7062@DM6PR05MB4506.namprd05.prod.outlook.com/
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Alexander Dahl <ada@thorsis.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes.

Miquel


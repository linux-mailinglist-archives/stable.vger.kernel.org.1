Return-Path: <stable+bounces-27102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CC5875527
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 18:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307581C22307
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D00130E24;
	Thu,  7 Mar 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l4aZ7vsp"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FC91DA27
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832547; cv=none; b=e8Gzoo0+25FahqzpB4MFRufiMHvuruLWKuLDR909uhnR4tjw0VAb1Z2L0I6r/TH2wzE3GnxzrbZlAmZMpME66B43aG17/esz2dDxs+8wPwxqhpULPfqLetIsLWFDJ0BlGNQN20C7NGfdBABacWa31dch8PF58vcztygZFdvTjys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832547; c=relaxed/simple;
	bh=xOMMYbF15BondH6qr629Je6j3+zMtGDijvWyeZQEVGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hHuaDfhf2xEoZC58yQjJ8w2QEN3lMKDgtY3JdPBMkZQg+DWsVYhfmo36GJpNHy3C0aeCfGKon4hbY856VTI9vs4hw5rvsS+VNfE9WY0Eat2I51eJ64xF5kUI92T66tY0SSK3ZSPppDyI00QyhdtMvcm1+ZigR80+VfHIVIjur8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l4aZ7vsp; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5EACEC0007;
	Thu,  7 Mar 2024 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709832543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INBnBefA/N55FIuu5yy0zef6mNSIr7WS39BueUt6jTw=;
	b=l4aZ7vspb5AUynnn+1oVbm72gNtIkNXJ7I0YQInRWYUZIsLjy0fNPAZx6zgX21fyPVkMj1
	jGlHKmtFHY7Q19x2qGjRy7jsekY7hvmeiBUWn1+jUtvKzlt4orQzErMiMPqEpI2iNKmQhc
	KOBPHljlrHMsepM++ZM62YSdxmOes0SaYvw05N9JIIBwfM6p3aJBRou/iIZWv1kvRHZ+gB
	/c57m3xHlOnCIedk6LIBjMYzCzwUCXylVQ7nipo+dpBXfKBN0aJxwo5XUWs19WTqdSKDuP
	ckVygwgKhhLIirD7uEfRcYJeMtcKrjuE8pYMZQOvo6fmlMUvAKcHv89tHZwSuw==
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
	Christophe Kerello <christophe.kerello@foss.st.com>,
	eagle.alexander923@gmail.com,
	mans@mansr.com,
	martin@geanix.com,
	=?utf-8?q?Sean_Nyekj=C3=A6r?= <sean@geanix.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mtd: rawnand: Fix and simplify again the continuous read derivations
Date: Thu,  7 Mar 2024 18:28:58 +0100
Message-Id: <20240307172859.3455856-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240223115545.354541-2-miquel.raynal@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b7da181307b928aa44349cf8eecd82a590ffbfac'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 11:55:43 UTC, Miquel Raynal wrote:
> We need to avoid the first page if we don't read it entirely.
> We need to avoid the last page if we don't read it entirely.
> While rather simple, this logic has been failed in the previous
> fix. This time I wrote about 30 unit tests locally to check each
> possible condition, hopefully I covered them all.
> 
> Reported-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Closes: https://lore.kernel.org/linux-mtd/20240221175327.42f7076d@xps-13/T/#m399bacb10db8f58f6b1f0149a1df867ec086bb0a
> Suggested-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Fixes: 828f6df1bcba ("mtd: rawnand: Clarify conditions to enable continuous reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Tested-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next.

Miquel


Return-Path: <stable+bounces-176844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A77EDB3E2DA
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 14:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F67F3BD3B1
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A033EB1F;
	Mon,  1 Sep 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bFhzcgjy"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BE322C97
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729581; cv=none; b=nJTvyMSfakLGPgTYA3DR+r8QMgr4qfsRTJkYGfGtcxL+OSEXqriztLjaRChDZzP+osl/DuEhTrg0KhFZqS6HafmIxE56Puv6rrJZ2xyiYPEKm0k1gcE9PDRvg+oKFHomCHmwzO7L9BHO7poRkBBaosSF1CzdRDEJ5tTTLN12WS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729581; c=relaxed/simple;
	bh=db8Pz8o8SabtY36Ay8X4a6pVUBM5KdqCKCYYeKmX6oo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LsVsXepemTLVHosOXFshY99TOJTFXmIfpdYl8GFnOM5dEVFgUnnevhePS2af+U4bogX/8UHXIHuy6XLwUeqG1NZwDTT7GSpjJ9ScsyCmwi3P144zGGVzfVlVL3w9yi6QnOEGwBPKFQToSsm5T4ModlrfTHgVM2Htl4VMoEoEyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bFhzcgjy; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 64F67C8F1DC;
	Mon,  1 Sep 2025 12:26:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3E86060699;
	Mon,  1 Sep 2025 12:26:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 533BE1C22D935;
	Mon,  1 Sep 2025 14:26:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729576; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SFNATNLdkkhOB5Wp70sKdHDjY39hB6qXWiRzlnD4aTQ=;
	b=bFhzcgjyq8a1r+ZKtRxUtY4dg0rai4FuY7GOmJcUuWg6W3UMSRflyHOmvhZi4nyF9sV40q
	CHwCU7T5UCZAtb3g0f1aeq+gNSERRaebP/u2QlruxkarvrEt+ZMX4ciwccjhsAlBt0XtIO
	valKroBjETgrkxYAuOqZeipXma1Fww4vmArdEwJUx+SPh/o3LPd9qHyaPFv/pzGlHxt/SI
	6ZDBWED6Sm73oezo8vcc7U+2gOFmLESBSpyFbafu4ab1f4sFoWV2i9JOlO+AP5DYBWFSym
	tuBQm967OYg0BNnmTRuX8wIIm+pcp67E7KpWUCaknN2n4C3Kiowqxa9WH8tF9A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christophe Kerello <christophe.kerello@st.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Christophe Kerello <christophe.kerello@foss.st.com>
Cc: linux-mtd@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250812-fix-ecc-overwrite-v1-1-6585c55c88b0@foss.st.com>
References: <20250812-fix-ecc-overwrite-v1-1-6585c55c88b0@foss.st.com>
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: fix ECC overwrite
Message-Id: <175672957522.48300.12612690456292698217.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:26:15 +0200
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

On Tue, 12 Aug 2025 09:30:08 +0200, Christophe Kerello wrote:
> In case OOB write is requested during a data write, ECC is currently
> lost. Avoid this issue by only writing in the free spare area.
> This issue has been seen with a YAFFS2 file system.
> 
> 

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: stm32_fmc2: fix ECC overwrite
      commit: 811c0da4542df3c065f6cb843ced68780e27bb44

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl



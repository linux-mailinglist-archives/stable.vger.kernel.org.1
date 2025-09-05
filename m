Return-Path: <stable+bounces-177826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F54B45B3F
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 16:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54985A612A5
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5862F7AAB;
	Fri,  5 Sep 2025 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UDS5yjWZ"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A82F7AA1;
	Fri,  5 Sep 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084172; cv=none; b=FkPNViBGge7Nenhha6UJNySE6Z4/ZbVhB43Sci+f7UdHqQ0gz7iHOJYiVhaDr2GBioC/q+7EsvrQEHQOm/TXg9hdY0UJpXiIaJ+6b/QtZDjVApWEq52ZvN2Vi5CTTbdIxVA019xGKmQp70DH8Jrbl8aJAhOh1c9klAyl5rsHB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084172; c=relaxed/simple;
	bh=OGJMUnmyC6iqFY2qrj42DSi1C8e1nL0azLM24KekIpQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UqSA6Nd/HtesH5/xhwVJ/KgKDuZijwG4EdEOuin5++1QfV4ofbAGk5Y+l0/cM34bogHEN3bxiPqcbi2p14FvTUuYXDABkbu0c3AsrGDer2PdGuElUsju+iOKRaGv6pgWaMK0O9sOaAC+MkiyTWar2YYLE4zMxfoFVvAWLXFAEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UDS5yjWZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F223D4E40C8C;
	Fri,  5 Sep 2025 14:56:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CACAF6060B;
	Fri,  5 Sep 2025 14:56:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4EA3102F011C;
	Fri,  5 Sep 2025 16:55:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757084161; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d8upgf5hUFHcVx1DQewRFxtyp0Z6M9gguxH2I+ftLSU=;
	b=UDS5yjWZDJ/sceACvO7gs7nFQm2k53K5xf3vdU8j2ZweZuXbszOPIskUz715rBCeSZ8Tcl
	RIfv+rjU7Rg+etCOrrnJc7WbvTlTJLF18qbRLD/Jg6OAzB/JO85kS+4YRR6oGODrKwFxIY
	HNOLTpFtMiP+SuSLwke01pg0utyR5vcjdSuXtzzsyVB5fJb12B2GgyZDa6syR+jEWe0m0h
	3xpANEorxDfTwEpNtV5NF+ne6SmnLeMZcTR52tbzWEl90SEUkOj+Dqc5g70AZXe8eqQVmc
	/NfcoWES0v+kblnCB6QL1IIxX2tl0rOfsw+ApC0wOIv0U3w39D8gUzxkKEEBFw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <20250901-mtd-validate-ooboffs-v2-1-c1df86a16743@gmail.com>
References: <20250901-mtd-validate-ooboffs-v2-1-c1df86a16743@gmail.com>
Subject: Re: [PATCH v2] mtd: core: always verify OOB offset in
 mtd_check_oob_ops()
Message-Id: <175708415877.334139.11409801733118104229.b4-ty@bootlin.com>
Date: Fri, 05 Sep 2025 16:55:58 +0200
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

On Mon, 01 Sep 2025 16:24:35 +0200, Gabor Juhos wrote:
> Using an OOB offset past end of the available OOB data is invalid,
> irregardless of whether the 'ooblen' is set in the ops or not. Move
> the relevant check out from the if statement to always verify that.
> 
> The 'oobtest' module executes four tests to verify how reading/writing
> OOB data past end of the devices is handled. It expects errors in case
> of these tests, but this expectation fails in the last two tests on
> MTD devices, which have no OOB bytes available.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: core: always verify OOB offset in mtd_check_oob_ops()
      commit: bf7d0543b2602be5cb450d8ec5a8710787806f88

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl



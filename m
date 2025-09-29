Return-Path: <stable+bounces-181952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B64FBA9E8E
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 17:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62F91922719
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 15:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBA130C349;
	Mon, 29 Sep 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jq60p4QS"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC330C0F2
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161549; cv=none; b=HN7oAJuwFRhvtbGUQVxWqKqvZ4a+L2PbXvzy0Do9WpFLCdog+Zh4Bw2sb0vbhhve9Z89RwB4okEn1JKYAmJ4hL9kcajEWaz/Q3jM/EqwIoe8/OANvCGXmWQ2T+phPkeDXyXlDspDzM0dLkMpGJevAgddmsMYSzTPhRizxUoDTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161549; c=relaxed/simple;
	bh=c8KWPy6+pmXzVrOWS3lcjZfFoUe/xJxUKmYJ0o5io1k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DQeQXOE0bHa1upe2+gSVvNjq+AChnnyA/Js02TJjiiAX/Wglzj+yMeFejtqaF4gcT1RtZ3GpsE+UncTf7Vpz4EHvT1BhlLStm8GySnTMFPdwYewLKffIZLN5KJDiMiHeEBSCavcLJSiOJ+44BXZRXX7SbnokbED/JdyW/tNo4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jq60p4QS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2DD7B1A101F;
	Mon, 29 Sep 2025 15:59:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 002E9606AE;
	Mon, 29 Sep 2025 15:59:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23CE1102F198F;
	Mon, 29 Sep 2025 17:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759161545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=q8LxUw+cVLeQ5xywYnpNFanq/5LXypulW6pCsXQ2bqk=;
	b=jq60p4QSEe6b1BZJhlLFia+CaZ+sQHuYjT0oBPgRcNTwJ7Aot4LSO4L+EP0l2wRVZK0HSu
	lz1FS9xwaTOI+5rThI6+Is6h1aMsLMtzfhdDeLTJJzaWyKEujoeLPhYDaKztVo8MNtfVAR
	BjXpqdXQhNYgJ6S0bHsFtikBgbqi4IfbxnoN5GriGatTXPziGUiVeaZeI1popACEPF4r2Q
	MEsCWSx0NOtfHdZRBb/mAFPVSgtrYI7fs3SND6X8szNtzw3OEu8nJxMGoph/CYjH/iE2lH
	2plmtHJGwyU5CfQXH0yyxvlhmzGdpSJEowLK9gweygd/jRMcpsZi2V4hwKwH0w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Han Xu <han.xu@nxp.com>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Maarten Zanders <maarten@zanders.be>
Cc: stable@vger.kernel.org, imx@lists.linux.dev, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250922153938.743640-2-maarten@zanders.be>
References: <20250922153938.743640-2-maarten@zanders.be>
Subject: Re: [PATCH] mtd: nand: raw: gpmi: fix clocks when CONFIG_PM=N
Message-Id: <175916154390.50974.9196112568745134014.b4-ty@bootlin.com>
Date: Mon, 29 Sep 2025 17:59:03 +0200
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

On Mon, 22 Sep 2025 17:39:38 +0200, Maarten Zanders wrote:
> Commit f04ced6d545e ("mtd: nand: raw: gpmi: improve power management
> handling") moved all clock handling into PM callbacks. With CONFIG_PM
> disabled, those callbacks are missing, leaving the driver unusable.
> 
> Add clock init/teardown for !CONFIG_PM builds to restore basic operation.
> Keeping the driver working without requiring CONFIG_PM is preferred over
> adding a Kconfig dependency.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: nand: raw: gpmi: fix clocks when CONFIG_PM=N
      commit: 1001cc1171248ebb21d371fbe086b5d3f11b410b

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl



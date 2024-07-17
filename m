Return-Path: <stable+bounces-60473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7971F934226
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 20:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C1B1C214FE
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B042183074;
	Wed, 17 Jul 2024 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcCHaCAm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E085C1DDD1;
	Wed, 17 Jul 2024 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240270; cv=none; b=R18uF7AGiuiWTfe7woJ/ojnAfIzgPt7iTS56cl0OFAsMGaAejL3v6kCnWF/iuuzOVvVJ3/TtGhxUjTFRyLfGd1zy00+gaF7aZybh8C5i3HiJD0Hp7064h/01MfYwhsxhx/4pFH2B6EB4wyJXaUfZGGD+UothSjhKvEABWKyv7tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240270; c=relaxed/simple;
	bh=xG/9M2YavZom5kIlcTESdu1TdLcTU+btfbM14zlJ3cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORv0UEmJwetdtrLqzddFJ2PKkIsIrNOrVJLXBDw4lM+uutvdBnVIdcHq/Ia/nJNyOVtM3xmgBlfbjdrXZ5zYFofH5eHrW+F9rAkDwGQiJ3VMtun8uMMoUHIYxPv78aryyS5aGgGmfezF1lvBGVc/8DnMiX2oDnY1b88RgtKDiC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcCHaCAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6391AC2BD10;
	Wed, 17 Jul 2024 18:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721240269;
	bh=xG/9M2YavZom5kIlcTESdu1TdLcTU+btfbM14zlJ3cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcCHaCAm0qXDRw3bZnE+AcN0w4CbecimO0KOgpmTadpfOKW/+U12xVwtQ79GvM9JA
	 zoBqq/u3x6lIqimguB/eT6Izw1prPdRb6/dQePwdAegtA0TME84ZTz2v/bUAMcBAD4
	 MzXR94ap8DM4UGs3fVudDQmfzMC0ZJcezPNER+B666vVST6eChXqMnGOgfQIr/6+NH
	 hig88ED1aJP3EJQU4X9EOS/BqSz+S15tOeOQTma99y9UEuMy7PN+SGWlSY2i63nYQl
	 RW+OGJMA4UIgY3XY5I/VG9TeKgFTX1OYv+nh09iyS8B9BgNC+tXXH4zO6XTnFydlbP
	 M6i+aXsX0+dNw==
Date: Wed, 17 Jul 2024 20:17:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: tj@kernel.org, dlemoal@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	festevam@gmail.com, linux-ide@vger.kernel.org,
	stable@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM
 SATA
Message-ID: <ZpgKxwziGXqNYLfc@ryzen.lan>
References: <1721099895-26098-1-git-send-email-hongxing.zhu@nxp.com>
 <1721099895-26098-4-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721099895-26098-4-git-send-email-hongxing.zhu@nxp.com>

Hello Richard,

On Tue, Jul 16, 2024 at 11:18:14AM +0800, Richard Zhu wrote:
> The RXWM(RxWaterMark) sets the minimum number of free location within
> the RX FIFO before the watermark is exceeded which in turn will cause
> the Transport Layer to instruct the Link Layer to transmit HOLDS to
> the transmitting end.
> 
> Based on the default RXWM value 0x20, RX FIFO overflow might be
> observed on i.MX8QM MEK board, when some Gen3 SATA disks are used.
> 
> The FIFO overflow will result in CRC error, internal error and protocol
> error, then the SATA link is not stable anymore.
> 
> To fix this issue, enlarge RX water mark setting from 0x20 to 0x29.
> 
> Fixes: 027fa4dee935 ("ahci: imx: add the imx8qm ahci sata support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Looking at the title of this patch:
"ahci_imx: Enlarge RX water mark for i.MX8QM SATA"

This suggests that this fix is only needed for i.MX8QM.

Support for i.MX8QM was added to the device tree binding in patch 1/4 in
this series.

Doing a git grep in linux-next gives the following result:

$ git grep fsl,imx8qm-ahci linux-next/master
linux-next/master:drivers/ata/ahci_imx.c:       { .compatible = "fsl,imx8qm-ahci", .data = (void *)AHCI_IMX8QM },


This is interesting for two reasons:
1) drivers/ata/ahci_imx.c already has support for this compatible string,
even though this compatible string does not exist in any DT binding
(in linux-next).

2) There is not a single in-tree device tree (DTS) that uses this compatible
string ....and we do not care about out of tree device trees.


Considering 2) I do NOT think that we should have
Cc: stable@vger.kernel.org on this... we shouldn't just backport random driver
fixes is there are no in-tree users of this compatible string.

So I suggest that:
-Drop the CC: stable.
-I actually think that it is better that you drop the Fixes tag too, because if
you keep it, the stable bots will automatically select this for backporting,
and then we will need to reply and say that this should not be backported, so
better to avoid adding the Fixes tag in the first place.
(Since there are no users of this compatible string, there is nothing that is
broken, so there is nothing to fix.)


Damien, when applying this patch, I suggest that we apply it to for-6.12
together with the rest of the series (instead of applying it to
for-6.11-fixes).


Kind regards,
Niklas


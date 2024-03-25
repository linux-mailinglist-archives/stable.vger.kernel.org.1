Return-Path: <stable+bounces-32156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776BE88A34E
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 14:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135C21F3C84A
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E860D173D9C;
	Mon, 25 Mar 2024 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="rz5eN1ha"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3816E863;
	Mon, 25 Mar 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359026; cv=none; b=QALBlCqHfXfbdx5KqhhljniNsv+dIyHvVu/RNmeI9ez1PM3dVDxOOF67EDLsh3W/QZUW0jdFIkYOIzbi1E7yBABk+tdunGnk0s9VIcGqXyrvOxAl38BTRQEQrx5a7I0Kkf9q+lyuVsyDGHAqZkC0gQpVB3/nqfQcVtq/UQZr2Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359026; c=relaxed/simple;
	bh=xg+9BLZdwaNe//uo+C91Hux0ZcTIiFTG6f5oMnS4IJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMMd7RyGYZUpUXpBo8iHNVRSaBSIheDj2jKYBCNtC8NlgK11Y/zJV3XlFICFWdQ9sJlGWx+r+QuytY9b1yLpb7Wh25GQocuCHo2qhxZfd6w5tSQV/MgAKhONuA5YyckvCQ0jg84Lu/YF98TC96J7nj/c0vDmZFH2J1etRrNL4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=rz5eN1ha; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 43B8620313;
	Mon, 25 Mar 2024 10:30:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1711359021;
	bh=QGhGl1/3Ag/mV82QM/dpx7LSnhALgRUEDerDOgAK8ss=; h=From:To:Subject;
	b=rz5eN1ha37fKM3RujkxWRhNN+E3dTdVeVnIqWr4kDbuPu59+0qFzqsFh0MXKCzhPj
	 Oc0h1uCp22AU5UdSXJmZ9hXBd4cIG88y6vKDOnRpNhe1/LLFCNhy6hGkpIIbK7Vb9O
	 tpa2rnR74Mus0ni/Q8+DN8JihoD7LUEjYL3sND3U2d6f6dBz7xqGAywFJSIdnWz8l6
	 rznCAlLwO6nwyeO5rnHD2i9TSXdwW3+jZwHg8v9BILBkYniVjIGFOVQOqOp1oBtTHb
	 P3UIM0XQEbhj6r/OcZ2C578Mf3joUURz6OUsJ1mvxWreyusYGSjeHVBmL9RUutlcz2
	 HkD8t/2+8nx9w==
Date: Mon, 25 Mar 2024 10:30:17 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: mikko.rapeli@linaro.org, linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc core block.c: initialize mmc_blk_ioc_data
Message-ID: <20240325093017.GA136833@francesco-nb>
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
 <c95ad3cf-bcc7-4174-aaf8-2307981568b5@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95ad3cf-bcc7-4174-aaf8-2307981568b5@intel.com>

On Wed, Mar 13, 2024 at 04:23:04PM +0200, Adrian Hunter wrote:
> On 13/03/24 15:37, mikko.rapeli@linaro.org wrote:
> > From: Mikko Rapeli <mikko.rapeli@linaro.org>
> > 
> > Commit "mmc: core: Use mrq.sbc in close-ended ffu" adds flags uint to
> > struct mmc_blk_ioc_data but it does not get initialized for RPMB ioctls
> > which now fail.
> > 
> > Fix this by always initializing the struct and flags to zero.
> > 
> > Fixes access to RPMB storage.
> > 
> > Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")
> > 
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218587
> > 
> > Link: https://lore.kernel.org/all/20231129092535.3278-1-avri.altman@wdc.com/
> > 
> > Cc: Avri Altman <avri.altman@wdc.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: linux-mmc@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> 
> Not used to seeing blank lines after Fixes:, Closes, Link: tags,
> nevertheless:

From what I know no spaces in between the tags at the end of the commit
message is just required. Having empty line there might break some tooling and
automation.

> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Ulf, Adrian: the bug these 2 patches are fixing is now in LTS kernel, it
would be beneficial to have the fix in mainline ASAP.

Francesco



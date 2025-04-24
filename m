Return-Path: <stable+bounces-136537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9432A9A5FE
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 10:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97A41B84D59
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0C7213E76;
	Thu, 24 Apr 2025 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ZDht9GLo"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D520E30F;
	Thu, 24 Apr 2025 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483693; cv=none; b=Cf+fjYmwbuAJ3W/aEQl/abGPZ5dDEqESbGkjysAVJGAprvbX1LWWrfiu5aAVGnyqTj6o0AGYZRiubkIObnUvjl//Cok6IBpCcwFTN03YrHypelaIbAdMBaxUDP1ZhBrB9mkuCmxyPDA2YfQfLTPZuH7EqqwZeMIc/qxZFqmx5no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483693; c=relaxed/simple;
	bh=J1WkLMZmRWMpuOCAOo61lR8IF0jbTrxGrhrssMvxiB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfN/Uyas0sC5ymT62/V1qHzpSqxfnsk0bu2VQKLJq8o2cMT16yoCtmAGGBhnQI3koAvPI5SSeDvRZubOMs1+7uwckXLx/fKVaisz8NH1Mi94fhzTVd3GGQT5qxpMlbcMuBrUgNot5bXaRqHTfKXZTSbOdvzNtgbMjWH0QlUwQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ZDht9GLo; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id D879C1F843;
	Thu, 24 Apr 2025 10:34:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1745483689;
	bh=bvslIDPnB9HfRlx4AQWiUW7XrU6A9m1Gg6T9aG8DNh8=;
	h=Received:From:To:Subject;
	b=ZDht9GLoCePMU+ZHvIY/kGiH6nNKaXmnvOOu97DuLln6/irwnb+JLNI90rdVl7XT+
	 YV8Q9qL8XD4KZ9qTn4bxRWnueYXNXcvclg+ANWDObBka3Xgg4aT/u2PjehARf8AcjT
	 CHCknnBGhpmyj8fp1x+v3EcHzKcPCR+lmjMNCKu6wAriyMitrxmY5UJvo0dhJ+bj2w
	 AHfmaWlW5tkGeSqWWHHfg+26xe6cKTX9Gb/+653y5RJyct4smtESPDLPmDBQa4xWtD
	 rI/pbB7/V3LYsO+9dkTen7ZXTvzDau5LxkSjp+BiZ1jkGd3BRVttEHF5dGdTPH+q1n
	 +hfMGLQWy3ekg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 8B3D57F820; Thu, 24 Apr 2025 10:34:48 +0200 (CEST)
Date: Thu, 24 Apr 2025 10:34:48 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Philippe Schenker <philippe.schenker@impulsing.ch>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: EXTERNAL - [PATCH v3] arm64: dts: imx8mm-verdin: Link
 reg_usdhc2_vqmmc to usdhc2
Message-ID: <aAn3qBG0ckInWvs1@gaggiata.pivistrello.it>
References: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
 <20250423095309.GA93156@francesco-nb>
 <222ce25ee0bb1545583ad7a04f621bac2617893c.camel@impulsing.ch>
 <aAi_PPaZRF26pv_d@gaggiata.pivistrello.it>
 <9eb7b15068eb8a4337ad0ea2512d02141afd491c.camel@impulsing.ch>
 <aAnXK0sAXqfTNaXg@mt.com>
 <aAnmZkpuaMOU0n2J@gaggiata.pivistrello.it>
 <ec0f5da5a4da6b2649373530d0103d65ea990c0e.camel@impulsing.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec0f5da5a4da6b2649373530d0103d65ea990c0e.camel@impulsing.ch>

On Thu, Apr 24, 2025 at 08:20:32AM +0000, Philippe Schenker wrote:
> 
> 
> On Thu, 2025-04-24 at 09:21 +0200, Francesco Dolcini wrote:
> > On Thu, Apr 24, 2025 at 08:16:11AM +0200, Wojciech Dubowik wrote:
> > > On Wed, Apr 23, 2025 at 11:23:09AM +0000, Philippe Schenker wrote:
> > > > On Wed, 2025-04-23 at 12:21 +0200, Francesco Dolcini wrote:
> > > > > > > 
> > > > > > > I would backport this to also older kernel, so to me
> > > > > > > 
> > > > > > > Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial
> > > > > > > support
> > > > > > > for
> > > > > > > verdin imx8m mini")
> > > > > > 
> > > > > > NACK for the proposed Fixes, this introduces a new Kconfig
> > > > > > which
> > > > > > could
> > > > > > have side-effects in users of current stable kernels.
> > > > > 
> > > > > The driver for "regulator-gpio" compatible? I do not agree with
> > > > > your
> > > > > argument,
> > > > > sorry. 
> > > > > 
> > > > > The previous description was not correct. There was an unused
> > > > > regulator in the DT that was not switched off just by chance.
> > > > > 
> > > > > Francesco
> > > > > 
> > > > My previous reasoning about the driver is one point. The other is
> > > > that
> > > > the initial implementation in 6a57f224f734 ("arm64: dts:
> > > > freescale: add
> > > > initial support for verdin imx8m mini") was not wrong at all it
> > > > was
> > > > just different.
> > > > 
> > > > My concern is for existing users of stable kernels that you
> > > > change the
> > > > underlying implementation of how the SD voltage gets switched.
> > > > And
> > > > adding the tag
> > > > 
> > > > 
> > > > Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support
> > > > for
> > > > verdin imx8m mini")
> > > > 
> > > > to this patch would get this new implementation also to stable
> > > > kernels
> > > > not affected by the issue introduced in f5aab0438ef1 ("regulator:
> > > > pca9450: Fix enable register for LDO5")
> > > 
> > > I will wait a day and send V4 with what I beleive was result of
> > > this
> > > discussion.
> > 
> > My opinion is that we should backport this fix. The DT description
> > was
> > wrong, that change on the PMIC driver just made the issue visible,
> > the DT is about the HW description.
> 
> From what I understand it was not wrong but it became wrong with the
> PMIC driver changes.

It was wrong. You had a regulator described as not used, and therefore the OS
was free to switch it off. For a bug in the driver this regulator was not
switched off by the old kernels.

The DT description was never correct.

With that said, hopefully it makes no difference in pratice,
f5aab0438ef17f01c5ecd25e61ae6a03f82a4586 will be backported, and therefore also
any fix to it should.

If for some unfortunate reason we do not backport also this one, you'll get a
non-working SD card on your LTS kernel.

Francesco



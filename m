Return-Path: <stable+bounces-136526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C7A9A392
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 09:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A332A1947E4B
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 07:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1FF21E094;
	Thu, 24 Apr 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="K39LRWIn"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F8421C9EB;
	Thu, 24 Apr 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479276; cv=none; b=WNqdANUpscMQf+KyFimcfj01O8FhHYrJ1ZUlcn4Gri+xQ2FfJXZ1hEDBplbjXhz8uhxAIclHWzSyQ5tFw3bFNvB5g4i1eGvbZUGAh1QRp3JKBrTcJissnlIwezaETN660CSXtxdQ/X0XfT4zyPFXxFsRQ8awjHs3Wqal70wOywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479276; c=relaxed/simple;
	bh=N6d/N+hjTfsePwXq3boSoe8scFZQvlt5EyUhlzLPEag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKecMmHAzbrDrlhD2R5DnIMBYS2UEOShok4OYG2ttey6EPCfAqvdp0KpQwwaAXlxDtUlkKGEf64iwhC9tFi28m0xPzGJ1s8Ut5dOrw3iXXQEQiHiLQq/A3SuyIqxCuBpF83Rkpti9A7FKu/SlQV+GMz8i4/Rth6iaWsuxtV0QCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=K39LRWIn; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 796CA1F90C;
	Thu, 24 Apr 2025 09:21:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1745479270;
	bh=HqGy6AGDXmPuhmrNaiPoFm++SOCSCkQPmn450Ps2+rs=;
	h=Received:From:To:Subject;
	b=K39LRWInL/zLuHS7xqUi2Z4R893ZAMsKsXwhk/xaRss5Vvks9u4dJeQcaLYBzQvcO
	 3T0sORXKADxL0FBKCj8djdaGm1E7TQCG5mUFdGwnstblB+mUKfXQWf2zN/8md06x0u
	 CAtWUE0SAXjzxl4ltaa+slMv9xQD5fpH8B8MrjjCWtPMW2uldiE2EUoIa65PI7pp6U
	 zSOyGTV3csQxE2HVOui1Yggs/wudjvVGToz+tFVLlIPYEXHcGKxoxalZ4PPEG9xLU8
	 fPUYRiY+FqHmya/Tq3Z8DWZMsaoNXQ+1ucMBjGPWFpw6ta37dJ5DEgzzEYGkXweCrR
	 LG2OlWVZCoG3A==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 25D517F934; Thu, 24 Apr 2025 09:21:10 +0200 (CEST)
Date: Thu, 24 Apr 2025 09:21:10 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: Philippe Schenker <philippe.schenker@impulsing.ch>,
	Francesco Dolcini <francesco@dolcini.it>,
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
Message-ID: <aAnmZkpuaMOU0n2J@gaggiata.pivistrello.it>
References: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
 <20250423095309.GA93156@francesco-nb>
 <222ce25ee0bb1545583ad7a04f621bac2617893c.camel@impulsing.ch>
 <aAi_PPaZRF26pv_d@gaggiata.pivistrello.it>
 <9eb7b15068eb8a4337ad0ea2512d02141afd491c.camel@impulsing.ch>
 <aAnXK0sAXqfTNaXg@mt.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAnXK0sAXqfTNaXg@mt.com>

On Thu, Apr 24, 2025 at 08:16:11AM +0200, Wojciech Dubowik wrote:
> On Wed, Apr 23, 2025 at 11:23:09AM +0000, Philippe Schenker wrote:
> > On Wed, 2025-04-23 at 12:21 +0200, Francesco Dolcini wrote:
> > > > > 
> > > > > I would backport this to also older kernel, so to me
> > > > > 
> > > > > Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support
> > > > > for
> > > > > verdin imx8m mini")
> > > > 
> > > > NACK for the proposed Fixes, this introduces a new Kconfig which
> > > > could
> > > > have side-effects in users of current stable kernels.
> > > 
> > > The driver for "regulator-gpio" compatible? I do not agree with your
> > > argument,
> > > sorry. 
> > > 
> > > The previous description was not correct. There was an unused
> > > regulator in the DT that was not switched off just by chance.
> > > 
> > > Francesco
> > > 
> > My previous reasoning about the driver is one point. The other is that
> > the initial implementation in 6a57f224f734 ("arm64: dts: freescale: add
> > initial support for verdin imx8m mini") was not wrong at all it was
> > just different.
> > 
> > My concern is for existing users of stable kernels that you change the
> > underlying implementation of how the SD voltage gets switched. And
> > adding the tag
> > 
> > 
> > Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for
> > verdin imx8m mini")
> > 
> > to this patch would get this new implementation also to stable kernels
> > not affected by the issue introduced in f5aab0438ef1 ("regulator:
> > pca9450: Fix enable register for LDO5")
> 
> I will wait a day and send V4 with what I beleive was result of this
> discussion.

My opinion is that we should backport this fix. The DT description was
wrong, that change on the PMIC driver just made the issue visible,
the DT is about the HW description.

FWIW, I tested this change with both v6.1 and v6.6 and it works correctly, as
expected.

Francesco



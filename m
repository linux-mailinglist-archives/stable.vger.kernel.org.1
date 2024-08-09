Return-Path: <stable+bounces-66271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B25AA94D18D
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D425B21AA5
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548AA196D9E;
	Fri,  9 Aug 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2ibozpP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027271957F8;
	Fri,  9 Aug 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211278; cv=none; b=e1Q+djm4R3lBOxKmeTUy+RacWt1TnHbJLUntxdRGt3stIlBWH46x+TJvQlBEPlX3uePysrwK98vNZV6vuznMaqP8/un8FqoDXjE8bOKEHbIi+npTph3OpZQM+U3yivzrX1hOwvyXf8mfBJCwKB+9Giax+OQW+mb0MU8lp4l6iLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211278; c=relaxed/simple;
	bh=ykV/BPKnxnB9F4W7qwUdOquNZhcldJvw6Mpyn+nVucQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsV9BzbSSYZDmpD/29bT/0y+MlA9xej44f/oQSSsBS7tu4RegznA2V1hyFJMjmoWTevWkKmrEKq8gm8POPsT/YpFKb+alCJlOUu356smcZlhCXD8FiG6jk5qAGnS0x3uaqqgY1kc1Ehoyh6lTICkUCqSSRrnHmKbQbM5VgqIhEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2ibozpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE1EC4AF0B;
	Fri,  9 Aug 2024 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723211277;
	bh=ykV/BPKnxnB9F4W7qwUdOquNZhcldJvw6Mpyn+nVucQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2ibozpPi4HXzK4sENGDQrEbyogfZPSvK1KbpM3uIIRAIs9enhfhE713rf8TgIkkV
	 a/w4sViYCrvzvL421B2fmNf7cTQG7R8hDDo4/bd36XU6jhxg/aaVdQviL61bAyLUp0
	 HyCNmSxVBTJkwgvBPj5Vnjgb0ZIyWHayeXdA9naHWiB3NYs2G2ZaYBmr9G9Xw+TShM
	 0sMGeOPtbu8rU/i149hksL+mXOEeBqCjhL7cWD56xDFb95J3XQOKCa0BY+nolx08MD
	 MkSyKR+O3SNcO14btmmglzR817vUosT9c+m6SxLmdmSDAaJoC5LuyjQ6foFw5ZGpB3
	 kZf6KtE+ecs7g==
Date: Fri, 9 Aug 2024 15:47:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, "tj@kernel.org" <tj@kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM
 AHCI SATA
Message-ID: <ZrYeBu7XbqmOc0ef@x1-carbon.lan>
References: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
 <1721367736-30156-5-git-send-email-hongxing.zhu@nxp.com>
 <Zp/Uh/mavwo+755Q@x1-carbon.lan>
 <AS8PR04MB867612E75A6C08983F7031528CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZrP2lUjTAazBlUVO@x1-carbon.lan>
 <ZrTQJSjxaQglSgmX@lizhi-Precision-Tower-5810>
 <ZrTxJzmWJyH2P0Ba@x1-carbon.lan>
 <AS8PR04MB86765DB41F64B3FBF3DAFCAA8CBA2@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB86765DB41F64B3FBF3DAFCAA8CBA2@AS8PR04MB8676.eurprd04.prod.outlook.com>

On Fri, Aug 09, 2024 at 08:45:12AM +0000, Hongxing Zhu wrote:
> Hi Niklas:
> Thank you very much.
> I had already sent out the v5 series patch-set a few days ago.
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com/

Well, your V5 was not sent to libata (linux-ide) mailing list,
and libata maintainers were not in "To:" or "Cc:".


> BTW, I'm a little confused about " without the patch in $subject,".
> Do you mean to remove the "PATCH" from Subject of each patch?
> v5:
> Subject: [PATCH v5 1/5] dt-bindings: ata: Add i.MX8QM AHCI compatible string
> v6 without patch in $subject:
> Subject: [ v6 1/5] dt-bindings: ata: Add i.MX8QM AHCI compatible string
> If yes, I can do that and add Frank's reviewed-by tag in the v6 series.

I simply meant drop patch:
[PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM AHCI SATA
and send the series as a V5.

But considering that you sent a V5 already (to the wrong list),
please send a V6 to the correct list, with Reviewed-by tags from
V5 picked up.


Kind regards,
Niklas


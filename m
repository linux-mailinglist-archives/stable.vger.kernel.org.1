Return-Path: <stable+bounces-66075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E351694C2A5
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 18:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2083C1C222AA
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586D4190481;
	Thu,  8 Aug 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5biSwfs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691F18E752;
	Thu,  8 Aug 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134258; cv=none; b=KwdlOU4OmpGYATK7iWQGRhfW6/CW5Decad+33bzY3qDqIEg7OHsl4KwvrLiCfO2Qdavbam0Y2lyYVwV6WqNqfdI4jVGFKb5vnCpRav7Vlnlp574iG7vEyMu/YdyCLlzv5fvPA8vC3vQOAWZAaRGeRyCnakXJx8UCuA6ZFEA6WmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134258; c=relaxed/simple;
	bh=LbWQSf2pCqgQzt6P1kYq5tJgjgYEyq/E5jxvh5xYMUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKkFfF1oj287AZOQn5V04tag7nFoFlpoNLR6oAiQdp/xPyNf+TPS2bMooGrkNCek9B8tvolBg4k7if7xAgmz1wX0mETk+zBiOv/qaTKQCn+ZlQKx9tlemMmC0GD7FUo5XMzPOvfl2wD8m7imni4EARCIdnGuPwzun0ifzd1eMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5biSwfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110CDC32782;
	Thu,  8 Aug 2024 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723134257;
	bh=LbWQSf2pCqgQzt6P1kYq5tJgjgYEyq/E5jxvh5xYMUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5biSwfsv1UsPpfRXmOPczwEe60uQvDeFR5QlpcCRqx0bGPO/3GVP7Ya9zh18RWb3
	 v1KDbkAxaGCTUBpbmknrEENObrTtn0ICTamJcd19NnIMl9mHLP/kIlbOG5ynxCFPzn
	 iennuszdwVpygz2v6EESemjsqM0+1agEX10SNtIjUIn0dIH9yHOge/oYzjDS1BQRst
	 oviixmWkD786bhGSrRfmOsdBBgkER6xZ9xd0ye2TPi4kxIZMg8psyFEpZAkfI61zw9
	 SZYvAqp5hfDx+wYvzFo+2hsG33RYJFoD4LfVQjM84CtsLlSEPpV5arXHR+uof7U3cg
	 paFjyroAbmtIA==
Date: Thu, 8 Aug 2024 18:24:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, "tj@kernel.org" <tj@kernel.org>,
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
Message-ID: <ZrTxJzmWJyH2P0Ba@x1-carbon.lan>
References: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
 <1721367736-30156-5-git-send-email-hongxing.zhu@nxp.com>
 <Zp/Uh/mavwo+755Q@x1-carbon.lan>
 <AS8PR04MB867612E75A6C08983F7031528CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZrP2lUjTAazBlUVO@x1-carbon.lan>
 <ZrTQJSjxaQglSgmX@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrTQJSjxaQglSgmX@lizhi-Precision-Tower-5810>

On Thu, Aug 08, 2024 at 10:03:17AM -0400, Frank Li wrote:
> On Thu, Aug 08, 2024 at 12:35:01AM +0200, Niklas Cassel wrote:
> > On Fri, Aug 02, 2024 at 02:30:45AM +0000, Hongxing Zhu wrote:
> > > >
> > > Hi Niklas:
> > > I'm so sorry to reply late.
> > > About the 32bit DMA limitation of i.MX8QM AHCI SATA.
> > > It's seems that one "dma-ranges" property in the DT can let i.MX8QM SATA
> > >  works fine in my past days tests without this commit.
> > > How about drop these driver changes, and add "dma-ranges" for i.MX8QM SATA?
> > > Thanks a lot for your kindly help.
> >
> > Hello Richard,
> >
> > did you try my suggested patch above?
> >
> >
> > If you look at dma-ranges:
> > https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#dma-ranges
> >
> > "dma-ranges" property should be used on a bus device node
> > (such as PCI host bridges).
> 
> Yes, 32bit is limited by internal bus farbic, not AHCI controller.

If the limit is by the interconnect/bus, then the limit will affect all
devices connected to that bus, i.e. both the PCIe controller and the AHCI
controller, and using "dma-ranges" in that case is of course correct.

I guess I'm mostly surprised that i.MX8QM doesn't already have this
property defined in its device tree.

Anyway, please send a v5 of this series without the patch in $subject,
and we should be able to queue it up for 6.12.


Kind regards,
Niklas


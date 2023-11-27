Return-Path: <stable+bounces-2741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CE97F9D39
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 11:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8446328130A
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 10:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349E182A9;
	Mon, 27 Nov 2023 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F70188;
	Mon, 27 Nov 2023 02:13:45 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id C0FDC206D2;
	Mon, 27 Nov 2023 11:13:39 +0100 (CET)
Date: Mon, 27 Nov 2023 11:13:34 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ARM: dts: imx6q-apalis: add can power-up delay on
 ixora board
Message-ID: <ZWRrznJiUyXlzzW1@francesco-nb.int.toradex.com>
References: <20231020153022.57858-1-andrejs.cainikovs@gmail.com>
 <20231020153022.57858-3-andrejs.cainikovs@gmail.com>
 <20231127025218.GR87953@dragon>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127025218.GR87953@dragon>

On Mon, Nov 27, 2023 at 10:52:18AM +0800, Shawn Guo wrote:
> On Fri, Oct 20, 2023 at 05:30:22PM +0200, Andrejs Cainikovs wrote:
> > From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> > 
> > Newer variants of Ixora boards require a power-up delay when powering up
> > the CAN transceiver of up to 1ms.
> > 
> > Cc: stable@vger.kernel.org
> 
> Why is only the iMX6 change required for stable?

From what I know currently apalis-imx8 is not yet used in products
with a mainline kernel therefore the assumption that the backporting
would add very small value, however maybe is better to just backport
both to stable.

Francesco



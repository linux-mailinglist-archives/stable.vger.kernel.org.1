Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E8D7F1DFD
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 21:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjKTU20 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 15:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjKTU2Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 15:28:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E10C3;
        Mon, 20 Nov 2023 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700512102; x=1732048102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oo4zZrX8HJrqzY+GRvPtQrfPS1iRnnIHV9pkoscRBwA=;
  b=TTrLDJF7SMcsbu09wC5Y0692Bzrx3GElBC116yf4R4vZse0mFZXTmUrr
   EppzLxnLbiETSmmznwLYBOKZJHGtTvXlkt1kGgWVxYOmcLmYegkusESc7
   owjZkoiUCTiu7lEKOwmSWdz1NKu5hOB7L4VjhL1rUAQqr/+g8LwlLyMAv
   HqoFq3RHMVUJI9R+c7OoCmiKp4vlxJ20tuvqzNCw4bePZgvi5zTNO9pUS
   SbwEYFkq4adIHHVgZQygCf3o7RBn6gkodB9eayBWh3th3W/Ks39gUkBjs
   eHCaiC5e51X6JpTTw27yfnNL5t2egtRYYo0aAJ7g5gp21Aenhy4Wd+za4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371874401"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="371874401"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:28:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="910226533"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="910226533"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:27:03 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 82B7511FAC4;
        Mon, 20 Nov 2023 22:27:00 +0200 (EET)
Date:   Mon, 20 Nov 2023 20:27:00 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        stable-commits@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michal Simek <michal.simek@amd.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: Patch "media: v4l: async: Rename async nf functions, clean up
 long lines" has been added to the 5.15-stable tree
Message-ID: <ZVvBFI31BpIz23Ov@kekkonen.localdomain>
References: <20231120152238.707760-1-sashal@kernel.org>
 <ZVuJyREX0ETQWBgR@kekkonen.localdomain>
 <2023112000-palatable-spokesman-d5da@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112000-palatable-spokesman-d5da@gregkh>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Nov 20, 2023 at 06:19:28PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 20, 2023 at 04:31:05PM +0000, Sakari Ailus wrote:
> > Hi folks,
> > 
> > On Mon, Nov 20, 2023 at 10:22:33AM -0500, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     media: v4l: async: Rename async nf functions, clean up long lines
> > 
> > This patch doesn't fix anything, it just renames a number of long function
> > names in a number of places. Why should it be backported to 5.15?
> 
> Because, in the patch itself we added:
> 
> > >     Stable-dep-of: b2701715301a ("media: cadence: csi2rx: Unregister v4l2 async notifier")
> 
> Which shows the requirement here.

Ah, ok. Seems reasonable.

-- 
Sakari Ailus

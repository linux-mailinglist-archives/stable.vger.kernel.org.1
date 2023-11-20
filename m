Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E827F19AE
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 18:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjKTRTs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 12:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjKTRTj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 12:19:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C20310E2;
        Mon, 20 Nov 2023 09:19:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D57C433A9;
        Mon, 20 Nov 2023 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700500771;
        bh=RAeKfOq3hx5ITvrVyZaR6+ShwwWgbpoasmEVuSlet1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSf4mGEWdyIczk7ywiS4bsaE3anD0mCUqUyLz4F+U9qcVEKDC6bv2NyJXmJ9851Vj
         YMHMxPPMUebuOBu+wnSBbOVXqmVH0SKf7NwF3n3vk3QMLa+5SRZ7jtQsWgD8Zpbe5N
         M7e3T1B1cmvBymat7CskxNAwe+i8L4w5V9A8tLO0=
Date:   Mon, 20 Nov 2023 18:19:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
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
Message-ID: <2023112000-palatable-spokesman-d5da@gregkh>
References: <20231120152238.707760-1-sashal@kernel.org>
 <ZVuJyREX0ETQWBgR@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVuJyREX0ETQWBgR@kekkonen.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Nov 20, 2023 at 04:31:05PM +0000, Sakari Ailus wrote:
> Hi folks,
> 
> On Mon, Nov 20, 2023 at 10:22:33AM -0500, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     media: v4l: async: Rename async nf functions, clean up long lines
> 
> This patch doesn't fix anything, it just renames a number of long function
> names in a number of places. Why should it be backported to 5.15?

Because, in the patch itself we added:

> >     Stable-dep-of: b2701715301a ("media: cadence: csi2rx: Unregister v4l2 async notifier")

Which shows the requirement here.

thanks,

greg k-h

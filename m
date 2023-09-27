Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDEF7AFB32
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 08:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjI0Giw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 02:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0Giv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 02:38:51 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFBCA3
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 23:38:49 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 0AF442065C;
        Wed, 27 Sep 2023 08:38:46 +0200 (CEST)
Date:   Wed, 27 Sep 2023 08:38:42 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: Do not generate HFP/HBP/HSA
 and EOT packet
Message-ID: <ZRPN8ii6jqQqZi6r@francesco-nb.int.toradex.com>
References: <20230403190242.224490-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403190242.224490-1-marex@denx.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Apr 03, 2023 at 09:02:42PM +0200, Marek Vasut wrote:
> Do not generate the HS front and back porch gaps, the HSA gap and
> EOT packet, as per "SN65DSI83 datasheet SLLSEC1I - SEPTEMBER 2012
> - REVISED OCTOBER 2020", page 22, these packets are not required.
> This makes the TI SN65DSI83 bridge work with Samsung DSIM on i.MX8MN.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Hello,
can you please queue up this to kernel v6.1-stable ?

commit ca161b259cc84fe1f4a2ce4c73c3832cf6f713f1
Author: Marek Vasut <marex@denx.de>
Commit: Robert Foss <rfoss@kernel.org>

    drm/bridge: ti-sn65dsi83: Do not generate HFP/HBP/HSA and EOT packet
    
    Do not generate the HS front and back porch gaps, the HSA gap and
    EOT packet, as per "SN65DSI83 datasheet SLLSEC1I - SEPTEMBER 2012
    - REVISED OCTOBER 2020", page 22, these packets are not required.
    This makes the TI SN65DSI83 bridge work with Samsung DSIM on i.MX8MN.
    
    Signed-off-by: Marek Vasut <marex@denx.de>
    Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    Signed-off-by: Robert Foss <rfoss@kernel.org>
    Link: https://patchwork.freedesktop.org/patch/msgid/20230403190242.224490-1-marex@denx.de


It solves a real issue with some displays not working without it.

Thanks,
Francesco


Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF8C6FE097
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 16:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbjEJOlQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 10:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbjEJOlG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 10:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030AAD21
        for <stable@vger.kernel.org>; Wed, 10 May 2023 07:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 431B4649B8
        for <stable@vger.kernel.org>; Wed, 10 May 2023 14:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0AEC433EF;
        Wed, 10 May 2023 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683729647;
        bh=l0swc7JlU+7f4U4KKRw7MUsJgF6zUJmkTgBPzNMU+Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOYpzRBgv2y1ULEluQn0ilTpwc/OAJb6Nj/l5UqvOQxb70CGdeF87O3fRRQ8thyWK
         R9QLbECwTkWN0tpw1maWliuGcEceQEG8JpyVeMUCKng4Fbwe/Q2jRakWmzfZr4vU4t
         70JS1PP5TGkwhNUA56YzEIuIsS4c6n4kHc3N9wsA=
Date:   Wed, 10 May 2023 23:40:41 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     linux-amlogic@lists.infradead.org, stable@vger.kernel.org,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] pinctrl: meson-axg: add missing GPIOA_18 gpio group
Message-ID: <2023051035-oink-wasp-c894@gregkh>
References: <20230510141934.112994-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510141934.112994-1-martin@geanix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 10, 2023 at 04:19:34PM +0200, Martin Hundebøll wrote:
> Without this, the gpio cannot be explicitly mux'ed to its gpio function.
> 
> Fixes: 83c566806a68a ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
>  drivers/pinctrl/meson/pinctrl-meson-axg.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> index 7bfecdfba177..d249a035c2b9 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> @@ -400,6 +400,7 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
>  	GPIO_GROUP(GPIOA_15),
>  	GPIO_GROUP(GPIOA_16),
>  	GPIO_GROUP(GPIOA_17),
> +	GPIO_GROUP(GPIOA_18),
>  	GPIO_GROUP(GPIOA_19),
>  	GPIO_GROUP(GPIOA_20),
>  
> -- 
> 2.34.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

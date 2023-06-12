Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1C72BD1B
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjFLJw7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 05:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjFLJwT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 05:52:19 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8439678
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 02:36:41 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7F35984682;
        Mon, 12 Jun 2023 11:36:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1686562599;
        bh=AlUcBHOL8pXtm34yWd6JErCfh8dio8BjWUZzaXOwb8Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F473lQhZhpnayMegTy/n654vnFkcLq1C8ao/C9nlzpvqwTNUZkKqh2Wl8p8DZgluu
         wH4aELs0GCbiWImEgmNthizAg34yGqbzkvuuUsLJKlyjyadaxrxe4jL1qAHKbJN21o
         ww5DQZsrdoAjdIRwmT5ZG2m6W+5NKPNeQL8cTJh0pPYVKTG6DMNn/gPs9+FmbjCK1O
         9vBwlayY86Opxie2uGSc5gg1x4yMb4psK7wApigJOZvre/D3L4PR5zB6/7A9bLBjOk
         Sff/MDFPqmH2NzfgzXePthuOXJAIpXofgpWEZZcjpQ/IU9VMl2L8GSUnDXmmqw1hLI
         XBDKqnSshZ4bg==
Message-ID: <111df1a8-2945-3868-6ce3-98dcaa4912df@denx.de>
Date:   Mon, 12 Jun 2023 11:36:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] drm/mxsfb: Disable overlay plane in
 mxsfb_plane_overlay_atomic_disable()
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, sam@ravnborg.org,
        stable@vger.kernel.org
References: <20230612092359.784115-1-victor.liu@nxp.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230612092359.784115-1-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 6/12/23 11:23, Liu Ying wrote:
> When disabling overlay plane in mxsfb_plane_overlay_atomic_update(),
> overlay plane's framebuffer pointer is NULL.  So, dereferencing it would
> cause a kernel Oops(NULL pointer dereferencing).  Fix the issue by
> disabling overlay plane in mxsfb_plane_overlay_atomic_disable() instead.
> 
> Fixes: cb285a5348e7 ("drm: mxsfb: Replace mxsfb_get_fb_paddr() with drm_fb_cma_get_gem_addr()")
> Cc: stable@vger.kernel.org # 5.19+
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Marek Vasut <marex@denx.de>

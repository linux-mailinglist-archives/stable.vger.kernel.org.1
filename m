Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D108877BC88
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 17:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjHNPLF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjHNPKj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 11:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886C119A7
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 08:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8863463CD6
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 15:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A397C433C7;
        Mon, 14 Aug 2023 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692025798;
        bh=2pIcd+vraC08fPmK0svzLUErZfAjsZBM/MoIFGtqCL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1GBawaKVxrT6GKKft3mi/V0IM51slmKFDlNrRGQhkkgWPpCdQigABuKxOwawnCjE4
         kaAa/gv9LDfuCSUVhcdKmahEXqgmnYhmT4YHI6RJpPA+5UY7N0Tl+VEBDgqpCDmVAW
         LV5IQ/re4oD7yHsDCmb1GLsJPjE8HX6c6gQd5wH4=
Date:   Mon, 14 Aug 2023 17:09:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCe0YTQuNGG0LXRgNC+0LI=?= 
        <oficerovas@basealt.ru>
Cc:     stable@vger.kernel.org
Subject: Re: Fwd: [PATCH 3/3] pinctrl: tigerlake: Add Alder Lake-P ACPI ID
Message-ID: <2023081451-idealness-gathering-6e69@gregkh>
References: <20230810115938.3741058-5-oficerovas@altlinux.org>
 <4c4f1531-55ff-90dd-9b8c-af0ab7559e80@basealt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c4f1531-55ff-90dd-9b8c-af0ab7559e80@basealt.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 14, 2023 at 05:35:37PM +0300, Александр Офицеров wrote:
> 
> 
> 
> -------- Перенаправленное сообщение --------
> Тема: 	[PATCH 3/3] pinctrl: tigerlake: Add Alder Lake-P ACPI ID
> Дата: 	Thu, 10 Aug 2023 14:59:38 +0300
> От: 	Alexander Ofitserov <oficerovas@altlinux.org>
> Кому: 	oficerovas@altlinux.org, Mika Westerberg
> <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, Linus
> Walleij <linus.walleij@linaro.org>
> Копия: 	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
> 
> 
> 
> Intel Alder Lake-P has the same pin layout as the Tiget Lake-LP
> so add support for this to the existing Tiger Lake driver.
> 
> Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
> ---
> drivers/pinctrl/intel/pinctrl-tigerlake.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-tigerlake.c
> b/drivers/pinctrl/intel/pinctrl-tigerlake.c
> index bed769d99b8be0..3ddaeffc04150a 100644
> --- a/drivers/pinctrl/intel/pinctrl-tigerlake.c
> +++ b/drivers/pinctrl/intel/pinctrl-tigerlake.c
> @@ -748,6 +748,7 @@ static const struct intel_pinctrl_soc_data tglh_soc_data
> = {
> static const struct acpi_device_id tgl_pinctrl_acpi_match[] = {
> { "INT34C5", (kernel_ulong_t)&tgllp_soc_data },
> { "INT34C6", (kernel_ulong_t)&tglh_soc_data },
> + { "INTC1055", (kernel_ulong_t)&tgllp_soc_data },
> { }
> };
> MODULE_DEVICE_TABLE(acpi, tgl_pinctrl_acpi_match);
> 
> -- 
> 2.33.8
<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4BF7DC9BD
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 10:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbjJaJg7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 05:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343953AbjJaJg6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 05:36:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76617BB
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 02:36:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233AFC433C8;
        Tue, 31 Oct 2023 09:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698745016;
        bh=ExEwPBFjttjkX3yVE95u1YJXg9bciAyc5NLPg4FQMNg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=QxyFcQ2MLoYZw42cNPPUCOBJqOjFYavK494kePHIduCNBprg+DhoIZPB6fPHdXPLQ
         mvPqPc8r5/7zBAP+hjAfmhPl4us1Nuvfav9aeOR4++gtiY3ITZz4e9FtmCSkyP6ZZi
         IhHfJbdxyrCLUt7QuGQhX9PK+4qe8OTM3eyLGFmqyndkvFKSZiMaH0NKNn3Bkd5+1b
         K/8c9Y+QrJu3EPTBtZrX9zjZqUmwH148DHumygduPDY+9GhrwH2zF4DoUXaL58uwev
         SInqwTvNri/2kX/LyIGLa1h0UXclBjqAnJ4oT+TAddUUz4QUepKNBXM0iCe35TPBZX
         Et0RfQYAtfi6Q==
Date:   Tue, 31 Oct 2023 09:36:52 +0000
From:   Lee Jones <lee@kernel.org>
To:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5.4.y 1/6] driver: platform: Add helper for safer
 setting of driver_override
Message-ID: <20231031093652.GU8909@google.com>
References: <20231031092645.2230861-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231031092645.2230861-1-lee@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 31 Oct 2023, Lee Jones wrote:

> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> commit 6c2f421174273de8f83cde4286d1c076d43a2d35 upstream.
> 
> Several core drivers and buses expect that driver_override is a
> dynamically allocated memory thus later they can kfree() it.
> 
> However such assumption is not documented, there were in the past and
> there are already users setting it to a string literal. This leads to
> kfree() of static memory during device release (e.g. in error paths or
> during unbind):
> 
>     kernel BUG at ../mm/slub.c:3960!
>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>     ...
>     (kfree) from [<c058da50>] (platform_device_release+0x88/0xb4)
>     (platform_device_release) from [<c0585be0>] (device_release+0x2c/0x90)
>     (device_release) from [<c0a69050>] (kobject_put+0xec/0x20c)
>     (kobject_put) from [<c0f2f120>] (exynos5_clk_probe+0x154/0x18c)
>     (exynos5_clk_probe) from [<c058de70>] (platform_drv_probe+0x6c/0xa4)
>     (platform_drv_probe) from [<c058b7ac>] (really_probe+0x280/0x414)
>     (really_probe) from [<c058baf4>] (driver_probe_device+0x78/0x1c4)
>     (driver_probe_device) from [<c0589854>] (bus_for_each_drv+0x74/0xb8)
>     (bus_for_each_drv) from [<c058b48c>] (__device_attach+0xd4/0x16c)
>     (__device_attach) from [<c058a638>] (bus_probe_device+0x88/0x90)
>     (bus_probe_device) from [<c05871fc>] (device_add+0x3dc/0x62c)
>     (device_add) from [<c075ff10>] (of_platform_device_create_pdata+0x94/0xbc)
>     (of_platform_device_create_pdata) from [<c07600ec>] (of_platform_bus_create+0x1a8/0x4fc)
>     (of_platform_bus_create) from [<c0760150>] (of_platform_bus_create+0x20c/0x4fc)
>     (of_platform_bus_create) from [<c07605f0>] (of_platform_populate+0x84/0x118)
>     (of_platform_populate) from [<c0f3c964>] (of_platform_default_populate_init+0xa0/0xb8)
>     (of_platform_default_populate_init) from [<c01031f8>] (do_one_initcall+0x8c/0x404)
> 
> Provide a helper which clearly documents the usage of driver_override.
> This will allow later to reuse the helper and reduce the amount of
> duplicated code.
> 
> Convert the platform driver to use a new helper and make the
> driver_override field const char (it is not modified by the core).
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Link: https://lore.kernel.org/r/20220419113435.246203-2-krzysztof.kozlowski@linaro.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Change-Id: Ib0c76960fce44b52a71e53aa6e30f39e7e8e5175

Disregard this set please!

I'm pre-coffee and operated in the wrong kernel directory with
the incorrect `commit-msg` enabled.

-- 
Lee Jones [李琼斯]

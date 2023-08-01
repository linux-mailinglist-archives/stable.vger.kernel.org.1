Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7784A76AA7D
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 10:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjHAIDe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 04:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjHAIDd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 04:03:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464E51729
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 01:03:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C25AE614A8
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 08:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2461C433C9;
        Tue,  1 Aug 2023 08:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690877009;
        bh=Ph+zgrD6UHkQdjxsMaKLiyT4SgFYEc/fXPUP07/FJ+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqea87M5WqSK+j2wDnX/TzoCwb0to5SNmIAOeOGZ8jLcvYWZnZ4agwAmXj5R1FDsi
         O8fYzr0uz6Y4mxCGFZq1FMji0lOAe9PX1+IDIwlmrHY/Tau1xRB9qgOwP2N7BXKSY9
         Th0MzXwzFtNSD9u022+840mNUJm1ZWRmqhPV9UwU=
Date:   Tue, 1 Aug 2023 10:03:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] ASoC: cs42l51: fix driver to properly autoload
 with automatic module loading
Message-ID: <2023080157-twitch-embargo-953b@gregkh>
References: <2023072301-online-accent-4365@gregkh>
 <20230727123339.675734-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727123339.675734-1-thomas.petazzoni@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 27, 2023 at 02:33:39PM +0200, Thomas Petazzoni wrote:
> In commit 2cb1e0259f50 ("ASoC: cs42l51: re-hook of_match_table
> pointer"), 9 years ago, some random guy fixed the cs42l51 after it was
> split into a core part and an I2C part to properly match based on a
> Device Tree compatible string.
> 
> However, the fix in this commit is wrong: the MODULE_DEVICE_TABLE(of,
> ....) is in the core part of the driver, not the I2C part. Therefore,
> automatic module loading based on module.alias, based on matching with
> the DT compatible string, loads the core part of the driver, but not
> the I2C part. And threfore, the i2c_driver is not registered, and the
> codec is not known to the system, nor matched with a DT node with the
> corresponding compatible string.
> 
> In order to fix that, we move the MODULE_DEVICE_TABLE(of, ...) into
> the I2C part of the driver. The cs42l51_of_match[] array is also moved
> as well, as it is not possible to have this definition in one file,
> and the MODULE_DEVICE_TABLE(of, ...) invocation in another file, due
> to how MODULE_DEVICE_TABLE works.
> 
> Thanks to this commit, the I2C part of the driver now properly
> autoloads, and thanks to its dependency on the core part, the core
> part gets autoloaded as well, resulting in a functional sound card
> without having to manually load kernel modules.
> 
> Fixes: 2cb1e0259f50 ("ASoC: cs42l51: re-hook of_match_table pointer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  sound/soc/codecs/cs42l51-i2c.c | 6 ++++++
>  sound/soc/codecs/cs42l51.c     | 7 -------
>  sound/soc/codecs/cs42l51.h     | 1 -
>  3 files changed, 6 insertions(+), 8 deletions(-)

What is the git commit id of this change in Linus's tree?

thanks,

greg k-h

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B220275FDC8
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 19:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGXRcM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGXRcM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 13:32:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7071B1700
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 10:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFD42612D7
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 17:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0398C433C8;
        Mon, 24 Jul 2023 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690219923;
        bh=O8UKD+6ITcGwv9zFiepxosq7IBRkwarkUTJUE8wNJJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4yFkEQKy8A4w6oe1o6NKvMASon0jVPTyJRzIcXMo9VsQSxeP7QqHDTi+3KE2n/T6
         E04i/Gk/n4BIIOjGSTwvgjoMmxvVseX6KGB3Dwu51XmAfNBp89IsULvXbmgOxZ4vc0
         hcXpMgNlXyIsloUYq63QPw9Fd4LbDBwfyreZkkR8=
Date:   Mon, 24 Jul 2023 19:32:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     stable@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH] r8169: revert 2ab19de62d67 ("r8169: remove ASPM
 restrictions now that ASPM is disabled during NAPI poll")
Message-ID: <2023072453-saturate-atlas-2572@gregkh>
References: <2023072337-dreamlike-rewrite-a12e@gregkh>
 <38cddf6d-f894-55a1-6275-87945b265e8b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38cddf6d-f894-55a1-6275-87945b265e8b@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 24, 2023 at 05:59:07PM +0200, Heiner Kallweit wrote:
> There have been reports that on a number of systems this change breaks
> network connectivity. Therefore effectively revert it. Mainly affected
> seem to be systems where BIOS denies ASPM access to OS.
> Due to later changes we can't do a direct revert.
> 
> Fixes: 2ab19de62d67 ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI poll")
> Cc: stable@vger.kernel.org # v6.4.y
> Link: https://lore.kernel.org/netdev/e47bac0d-e802-65e1-b311-6acb26d5cf10@freenet.de/T/
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217596
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Link: https://lore.kernel.org/r/57f13ec0-b216-d5d8-363d-5b05528ec5fb@gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 27 ++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD74768394
	for <lists+stable@lfdr.de>; Sun, 30 Jul 2023 05:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjG3DNK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 29 Jul 2023 23:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3DNI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 29 Jul 2023 23:13:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6676FE0;
        Sat, 29 Jul 2023 20:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4A6460766;
        Sun, 30 Jul 2023 03:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E9FC433C8;
        Sun, 30 Jul 2023 03:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690686786;
        bh=PbT4TVcWbZX47F+OnfA/lc80SFPdh68174zz4cnom9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HkXaFyEu7x1Lm3AURbJ5G1Sq1tNlDDKCKR0daBDN8eYDoeX617iEbG5WJs1nhcy7H
         /kuHgVyp9MN7OgVixxTn9oiw8oBnz9bpj26OtRYc8fPOBuxOXR+0ysLHrTLgxwN7Fn
         cAfnrWumy2pTFAnQgxD0IWQkAX24tAX8Opd6mKsZtMKI6payG4DRFFEfdahTR61hMF
         8WrJMp/ENQynOPjHfn9NP1t1bUOO+UyHIHxCZEmdN0aF/kc++7k2XEU7pFbkqdbjKe
         smlpNLa27FYhPXOafMb+Q9JIlRchZ9UR6c2GCOSWcclDnIAy4HpUmRmXkKiH59K/27
         +3no7HU4y5C9g==
Date:   Sun, 30 Jul 2023 11:12:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     hs@denx.de, linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
        abelvesa@kernel.org, linux-clk@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ARM: dts: imx6sx: Remove LDB endpoint
Message-ID: <20230730031255.GU151430@dragon>
References: <20230712115301.690714-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712115301.690714-1-festevam@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 12, 2023 at 08:52:59AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Remove the LDB endpoint description from the common imx6sx.dtsi
> as it causes regression for boards that has the LCDIF connected
> directly to a parallel display.
> 
> Let the LDB endpoint be described in the board devicetree file
> instead.
> 
> Cc: stable@vger.kernel.org
> Fixes: b74edf626c4f ("ARM: dts: imx6sx: Add LDB support")
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks!

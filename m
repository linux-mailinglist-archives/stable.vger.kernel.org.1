Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A229476AA59
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 09:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjHAH4n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 03:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHAH4l (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 03:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2364F1BF0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 00:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4CF3614A3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 07:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A59C433C8;
        Tue,  1 Aug 2023 07:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690876600;
        bh=7gjSrUuQxFNcsdhsQeZ8UtDoWJ6myG5dubeaOVmjERs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hv2H0bnadHeChf84Tcdgv18G2T1lVFC6s/oMKzJmDUjsiR7OQIwQRzkpj7jTbBuHr
         0pF+vQNvy/8Bwyv984PxiKNtrqUJSkavblQ1s5zdmgzAIC8vTprs+k4Oyi/eoKHsle
         ZU/SW/85QmjddrqZfqwnXugeWPTyLoT+6LLl2mLI=
Date:   Tue, 1 Aug 2023 09:56:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jindong Yue <jindong.yue@nxp.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Subject: Re: Kernel 6.1.y backports for "dma-buf: keep the signaling time of
 merged fences v3"
Message-ID: <2023080130-perplexed-unbend-e3a6@gregkh>
References: <GV1PR04MB91833432B91E4ED2F16E63F3FB01A@GV1PR04MB9183.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV1PR04MB91833432B91E4ED2F16E63F3FB01A@GV1PR04MB9183.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 27, 2023 at 03:19:23AM +0000, Jindong Yue wrote:
> Hi,
> 
> Please help backport following two commits to 6.1.y
> 
> f781f661e8c9 dma-buf: keep the signaling time of merged fences v3
> 00ae1491f970 dma-buf: fix an error pointer vs NULL bug
> 
> The first one is to fix some Android CTS failures founded with android14-6.1 GKI kernel.
> 	run cts -m CtsDeqpTestCases -t dEQP-EGL.functional.get_frame_timestamps*
> The second patch is to fix the error introduced by the first one.

All now queued up, thanks.

greg k-h

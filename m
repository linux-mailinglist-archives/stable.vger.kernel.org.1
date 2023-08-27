Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5915578A0F2
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 20:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjH0S0B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 14:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjH0SZs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 14:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BCB128
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 11:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD4C261194
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 18:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC371C433C8;
        Sun, 27 Aug 2023 18:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693160744;
        bh=Kio/PhpcDRGIHs+Xfp7sdA/o592CmqAIPInJFhzbtIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2RCCUQIPoaPLexCsf8Z4llyDxEj/evS9AuAO+miImGolwmp6GvDFCTUzx6OKVjMPD
         YLKfvyen10YGcP8jKd+ZtR2Vy5qHYg3y1Ob8pCYJeEwJ92pRtOU2cpPbaizV5LVtJp
         egGFF/WTB3Cw07S52Hw6Qthem2HAtYNsTPxKGHw4=
Date:   Sun, 27 Aug 2023 20:25:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     edumazet@google.com, kuba@kernel.org,
        william.xuanziyang@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH stable < v6.0] can: raw: add missing refcount for memory
 leak fix
Message-ID: <2023082735-joyous-peso-f0a9@gregkh>
References: <20230827110945.3458-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827110945.3458-1-socketcan@hartkopp.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 27, 2023 at 01:09:45PM +0200, Oliver Hartkopp wrote:
> Commit ee8b94c8510c ("can: raw: fix receiver memory leak") introduced
> a new reference to the CAN netdevice that has assigned CAN filters.
> But this new ro->dev reference did not maintain its own refcount which
> lead to another KASAN use-after-free splat found by Eric Dumazet.
> 
> This patch ensures a proper refcount for the CAN nedevice.
> 
> Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  net/can/raw.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)

Now queued up, thanks.

greg k-h

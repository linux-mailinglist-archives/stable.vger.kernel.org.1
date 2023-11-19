Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8C77F0875
	for <lists+stable@lfdr.de>; Sun, 19 Nov 2023 20:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjKST1K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 19 Nov 2023 14:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKST1K (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 19 Nov 2023 14:27:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D1126
        for <stable@vger.kernel.org>; Sun, 19 Nov 2023 11:27:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE2DC433C7;
        Sun, 19 Nov 2023 19:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700422026;
        bh=9xe3Q3fs3OKxEKDYqaXsNGqQGIRylSjf7JwSJSD1XhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+jKYt8kLE1vW4dlyqIGqAMYv1O//lNcmpHouYzZdzsSauq26AinhL9u1kKAfeRZj
         fM2wNaNBBuAHA6Jaq3bSyNs4LUYhOW2z4GHOLWe6f2b2SL7GU8diP1ehY1AHdzk1Ji
         rNSPmTaHO5jIqLwiesnNo9xYipxaz/xTwpIpxNlwnpSXyZxToEjI/2SsQBNnBlUzgt
         joxvMFd8FJsag7KLkEBCv5oEF30q45yoNOERqDMy1OLaImjq+q106uE0cGamysfb3U
         HcJpFJi7tWTsPCOQpAuoaYue06bPck5pQXYua/ppk7vO/74hAZYnIMXBtbyoxUZF2e
         x34ujdmVkKsVw==
Date:   Sun, 19 Nov 2023 19:27:02 +0000
From:   Simon Horman <horms@kernel.org>
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        mengyuanlou@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH net] net: wangxun: fix kernel panic due to null pointer
Message-ID: <20231119192702.GF186930@vergenet.net>
References: <20231117101108.893335-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117101108.893335-1-jiawenwu@trustnetic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 17, 2023 at 06:11:08PM +0800, Jiawen Wu wrote:
> When the device uses a custom subsystem vendor ID, the function
> wx_sw_init() returns before the memory of 'wx->mac_table' is allocated.
> The null pointer will causes the kernel panic.
> 
> Fixes: 79625f45ca73 ("net: wangxun: Move MAC address handling to libwx")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Thanks Jiawen Wu,

I agree with your analysis and that the problem was introduced by the cited
commit. The fix also looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

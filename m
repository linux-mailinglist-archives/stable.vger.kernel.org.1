Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6DF7BC742
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 13:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343869AbjJGLoS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 07:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343837AbjJGLoR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 07:44:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B4FB6
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 04:44:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99F4C433C7;
        Sat,  7 Oct 2023 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696679056;
        bh=s8a5HRpv6ncDmOAZ3OoS2FcU/Djzd1Ioyod870SGjyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wj506HPS30JldB+Ipk7YGi/iQZxQfxbxnQCbnVtEL+YNRMZOfIswOgq4AGas4W6uM
         NQJAFUEnghhKu2PoaDhl2HMjEfdUcKh6oI12Ea/7zPuhR6Its02RTJ2GQ9LJYLWily
         h9Ut1LPPcCntC79yhUqEBWe6qxi+Tw+gFIWqJacI=
Date:   Sat, 7 Oct 2023 13:44:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-stable <stable@vger.kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: Drop from 5.15 and older -- clk: imx: pll14xx: dynamically
 configure PLL for 393216000/361267200Hz
Message-ID: <2023100738-shell-scant-cfb6@gregkh>
References: <4e5fa5b2-66b8-8f0b-ccb9-c2b774054e4e@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e5fa5b2-66b8-8f0b-ccb9-c2b774054e4e@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 03, 2023 at 10:52:25PM +0200, Marek Vasut wrote:
> Please drop the following commits from stable 5.10.y and 5.15.y respectively
> 
> 972acd701b19 ("clk: imx: pll14xx: dynamically configure PLL for
> 393216000/361267200Hz")
> a8474506c912 ("clk: imx: pll14xx: dynamically configure PLL for
> 393216000/361267200Hz")
> 
> The commit message states 'Cc: stable@vger.kernel.org # v5.18+'
> and the commit should only be applied to Linux 5.18.y and newer,
> on anything older it breaks PLL configuration due to missing
> prerequisite patches.

Ok, I'll go revert them, but the Fixes: tag in this commit is very wrong
as that's what we used to determine how far back to take these changes.

thanks,

greg k-h

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251D17BE8CE
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 20:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377305AbjJISAm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 14:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377093AbjJISAl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 14:00:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C100CA3
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 11:00:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6E3C433C8;
        Mon,  9 Oct 2023 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696874437;
        bh=qkciU2AF1OjdAnwP0ZPa0nfFoifDhozqKfgZmthegUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7Cw9YRO0A+ttdewQ8KaeNE99ui1mQ4DawCtmvBABMZ1afAH0gJmVTtyXT2fkb319
         FkVAQqYFEzbjUhfHYL2BcCPJoi1grAlHLByAM17IpVrQUDhU/PgA4axUwLhWxerEMY
         8H3rfujmXrg1u7SqhV5SduFaDubxJ1ua8S6MZO8k=
Date:   Mon, 9 Oct 2023 20:00:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Marek Vasut <marex@denx.de>, linux-stable <stable@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: Drop from 5.15 and older -- clk: imx: pll14xx: dynamically
 configure PLL for 393216000/361267200Hz
Message-ID: <2023100917-undivided-drone-30b0@gregkh>
References: <4e5fa5b2-66b8-8f0b-ccb9-c2b774054e4e@denx.de>
 <2023100738-shell-scant-cfb6@gregkh>
 <6092d57f-4688-aaf2-120d-0e10c40f89c6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6092d57f-4688-aaf2-120d-0e10c40f89c6@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 09, 2023 at 04:17:53PM +0200, Ahmad Fatoum wrote:
> Hello Greg,
> 
> On 07.10.23 13:44, Greg KH wrote:
> > On Tue, Oct 03, 2023 at 10:52:25PM +0200, Marek Vasut wrote:
> >> Please drop the following commits from stable 5.10.y and 5.15.y respectively
> >>
> >> 972acd701b19 ("clk: imx: pll14xx: dynamically configure PLL for
> >> 393216000/361267200Hz")
> >> a8474506c912 ("clk: imx: pll14xx: dynamically configure PLL for
> >> 393216000/361267200Hz")
> >>
> >> The commit message states 'Cc: stable@vger.kernel.org # v5.18+'
> >> and the commit should only be applied to Linux 5.18.y and newer,
> >> on anything older it breaks PLL configuration due to missing
> >> prerequisite patches.
> > 
> > Ok, I'll go revert them, but the Fixes: tag in this commit is very wrong
> > as that's what we used to determine how far back to take these changes.
> 
> The Fixes tag is correct. The PLL parameters added in that commit were
> deemed suboptimal. Kernels >= v5.18 can compute better parameters on the fly,
> so that's why the patch says
> 
>   Cc: stable@vger.kernel.org # v5.18+
> 
> Which is the syntax described in Documentation/admin-guide/reporting-issues.rst.
> I see now though that Documentation/process/stable-kernel-rules.rst has a slightly
> different syntax:
> 
>   Cc: <stable@vger.kernel.org> # 3.3.x
> 
> Perhaps your maintainer scripts can't handle both cases?

That's not what happened here, sorry.

We went off of the Fixes: tag, and ignored the # VERSION marking as
sometimes that is wrong (like when we backport changes to older
kernels.)

> FWIW, I've reached out multiple times about that the patches aren't suitable for
> backports:
> 
>   - https://lore.kernel.org/all/6e3ad25c-1042-f786-6f0e-f71ae85aed6b@pengutronix.de/
>   - <a76406b2-4154-2de4-b1f5-43e86312d487@pengutronix.de> (reply to linux-stable-commits)
>   - https://lore.kernel.org/all/7df69de2-1b3a-5226-7dc2-d1489e48f6a2@pengutronix.de/
>   - https://lore.kernel.org/all/e85da95c-5451-31ea-cae9-76d697fb548f@pengutronix.de/
> 
> Yet, today I got an email[1] telling me that it's being added to v5.4.258-rc1, although
> it had been dropped from v5.4.257-rc1 after I objected to it.
> 
> So that looks like another potential avenue for improving the maintainer scripts.

I'll go drop it from 5.4 again, Sasha's and my scripts don't always sync
up well at times, thanks for pointing this out.

greg k-h

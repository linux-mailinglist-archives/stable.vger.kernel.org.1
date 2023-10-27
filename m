Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F927D9790
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 14:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjJ0MQu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 08:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjJ0MQt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 08:16:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30AEC0
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 05:16:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6D0C43391;
        Fri, 27 Oct 2023 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698409007;
        bh=4NRUlTmk1LuMcKNw3A1i1UU6nGDzxkPn/7MnfP+vx0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7YUwcJFEbmTMB2amn0vCRT5AIo9J+oPZ8RpvrzxMixPxDTxyQgtqTzhp+HR8ftbC
         xql6Y6+Zh9+nxy5JeI/7ORnJ1UzPsJN25lMN0cAKamgY7h4fjpOdGFxzd7m1Z08Yue
         m3qGUe1jzzloMzUPmzxzlUYg1IJuRODAiIOoIQIc=
Date:   Fri, 27 Oct 2023 14:16:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Lukas Magel <lukas.magel@posteo.net>, patches@lists.linux.dev,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        Michal Sojka <michal.sojka@cvut.cz>
Subject: Re: [PATCH 6.1 043/131] can: isotp: isotp_sendmsg(): fix TX state
 detection and wait behavior
Message-ID: <2023102721-voltage-thyself-e881@gregkh>
References: <20231016084000.050926073@linuxfoundation.org>
 <20231016084001.142952122@linuxfoundation.org>
 <b4a1bdc2-54f8-428a-a82a-0308a4bc7f92@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a1bdc2-54f8-428a-a82a-0308a4bc7f92@hartkopp.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 24, 2023 at 08:34:30PM +0200, Oliver Hartkopp wrote:
> Hello Lukas, hello Greg,
> 
> this patch fixed the issue introduced with
> 
> 79e19fa79cb5 ("can: isotp: isotp_ops: fix poll() to not report false
> EPOLLOUT events")
> 
> for Linux 6.1 and Linux 6.5 which is fine.
> 
> Unfortunately the problematic patch has also been applied to 5.15 and 5.10
> (referencing another upstream commit as it needed a backport).
> 
> @Lukas: The 5.x code is much more similar to the latest code, so would it
> probably fix the issue to remove the "wq_has_sleeper(&so->wait)" condition?
> 
> @Greg: I double checked the changes and fixes from the latest 6.6 kernel
> compared to the 5.10 when isotp.c was introduced in the mainline kernel.
> Would it be ok, to "backport" the latest 6.6 code to the 5.x LTS trees?
> It really is the same isotp code but only some kernel API functions and
> names have been changed.

Sure, if you think it is ok, please send the backported and tested patch
series and we will be glad to review them.

thanks,

greg k-h

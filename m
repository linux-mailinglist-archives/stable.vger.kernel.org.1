Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63ED788202
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 10:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbjHYI0e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 25 Aug 2023 04:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243175AbjHYI02 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 25 Aug 2023 04:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FC919A1
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 01:26:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C07563DF3
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 08:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C617C433C8;
        Fri, 25 Aug 2023 08:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692951985;
        bh=UDdXWIG4Ey7G8G8OuJoqFLpkSA46y0SNdMz1cXScs/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIAw+XZQzfAAsgS+49jFjKf0hiqF9guPrx1UaSOI47tSa+6LzwZhfSXW+VVOCHT4f
         RKk3REtMs6rLRYRvkls+QwoXcFeI6aa6+52fRIX1llalD1P3cSnKc7hcGEI4nosMI+
         hbgsljBf4+mZSW7PVZp1ba2KNlaIYrTCVx+dfu40=
Date:   Fri, 25 Aug 2023 08:13:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Patrick Rohr <prohr@google.com>
Cc:     stable@vger.kernel.org,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH 6.1] net: add sysctl accept_ra_min_lft
Message-ID: <2023082503-humorous-thieving-b162@gregkh>
References: <20230824223225.863719-1-prohr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824223225.863719-1-prohr@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 24, 2023 at 03:32:25PM -0700, Patrick Rohr wrote:
> This change adds a new sysctl accept_ra_min_lft which enforces a minimum
> lifetime value for individual RA sections; in particular, router
> lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
> lifetimes are lower than the configured value, the specific RA section
> is ignored.
> 
> This fixes a potential denial of service attack vector where rogue WiFi
> routers (or devices) can send RAs with low lifetimes to actively drain a
> mobile device's battery (by preventing sleep).
> 
> In addition to this change, Android uses hardware offloads to drop RAs
> for a fraction of the minimum of all lifetimes present in the RA (some
> networks have very frequent RAs (5s) with high lifetimes (2h)). Despite
> this, we have encountered networks that set the router lifetime to 30s
> which results in very frequent CPU wakeups. Instead of disabling IPv6
> (and dropping IPv6 ethertype in the WiFi firmware) entirely on such
> networks, misconfigured routers must be ignored while still processing
> RAs from other IPv6 routers on the same network (i.e. to support IoT
> applications).
> 
> This change squashes the following patches into a single commit:
> - net-next 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
> - net-next 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lifetimes")
> - net-next 5cb249686e67 ("net: release reference to inet6_dev pointer")

Please don't do this.  We want the original commits into the stable
tree, after they have landed in Linus's tree.

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

thanks,

greg k-h

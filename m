Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D0E7A29C2
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjIOVui (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 17:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbjIOVu1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 17:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F61F106
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 14:50:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EEAC433C8;
        Fri, 15 Sep 2023 21:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694814622;
        bh=h4tQScTvZ4DuiW3BfzRqqFRi9CTF7m53FDoxLYk3Q9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AKpYa8LV1Tz+qI4FLo2ta+zBWQUPRxdK6q5ZkvcMGm6G+PZpU5cbc0ROqqTFESOeQ
         GDNWwukzcITWiBjdGFfRuaQIO2/rJncVhK+M0EomAS5k9+Ld3diTKbgHihB3A5+8g7
         rGmmXYhA/v8Uo9V1Vgkyd2HsKWXkGnl7pekbkjh/uGF25zmCTlL7AYN6pCyNQbpMyr
         EIPlyVSOwh3BY9+g5T8unwSKzXQ3xLPiv8//idlNQqAWIqp4MXs6qoLnLfFs/TUrna
         SxRzHXAAaL1smTdPnze9QNQ8PWBA0oOkRHWoeQiZC0qxMcv3RVRnfaY4dr4yjyqsJs
         W7SWnYwziNE3A==
Date:   Fri, 15 Sep 2023 14:50:20 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@meta.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        =?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Message-ID: <ZQTRnJm0z3ZE3x4I@kbusch-mbp>
References: <20230912214733.3178956-1-kbusch@meta.com>
 <ZQGqNZD9QweQQRmF@x1-carbon>
 <ZQHTKQLKFE9Iupp0@kbusch-mbp.dhcp.thefacebook.com>
 <ZQHf8Yyw+UC9ysDR@x1-carbon>
 <ZQHnUMlm80Xzxn6n@kbusch-mbp.dhcp.thefacebook.com>
 <ZQTNP5lnFFn8ThkZ@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQTNP5lnFFn8ThkZ@x1-carbon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 15, 2023 at 09:31:44PM +0000, Niklas Cassel wrote:
> I'm not saying that these controllers shouldn't work with Linux.
> However, these controller used to work with CC.CRIME == 0, so perhaps
> we should continue to use them that way?

Perhaps I missed something, but I didn't get any indication that these
controllers were reporting CRIMS capability. They're just reporting
CRWMS as far as I know, so CRIME doesn't apply. I only included that
case in the patch for completeness.
 
> So having both fields defined to zero, or rather, to have both fields
> defined to a value smaller than CAP.TO, regardless of CC.CRIME value,
> is quite bad.
> 
> So perhaps it is better to keep CC.CRIME == 0 for such controllers.
> 
> 
> > If we have a way to sanity check for spec non-compliance, I would prefer
> > doing that generically rather than quirk specific devices.
> 
> It's not going to be beautiful, but one way could be to:
> -check CAP.CRMS.CRIMS, if it is set to 1:
> -write CC.CRIME == 1,
> -re-read CAP register, since it can change depending on CC.CRIME (urgh)
> -check if CRTO.CRIMT is less than CAP.TO, if so:
> -write CC.CRIME == 0 (disable the feature since it is obviously broken)
> -re-read CAP register, since it can change depending on CC.CRIME (urgh)

There is a corner case that I am somewhat purposefully ignoring: CAP.TO
is worst case for both CC.EN 0->1 and 1->0, whereas both CRTO values are
only for the 0->1 transition. It's entirely possible some implementation
needs a longer 1->0 transition, so CAP.TO *could* validly be greater
than the either CRTO value. I just don't see that happening in practice,
and even if we do encounter such a device, waiting a little longer on
init for a broken controller doesn't make any situation worse.

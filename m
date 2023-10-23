Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3847D2B90
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjJWHmB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjJWHmA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 03:42:00 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846EAA6
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 00:41:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 65B8E3200929;
        Mon, 23 Oct 2023 03:41:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 23 Oct 2023 03:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1698046916; x=1698133316; bh=r6
        dYmGnIkaDG9wqKIpDC+jrkfxlx7iU7ZFhSNZ/JBWU=; b=irELNnV4nOpID68TMo
        tmV6XVwuPeKd9GJdMum3ojSSS578yAluzCTSIYFqDLfFjlUpmTTBavSVhJqzJxRz
        OcULqgg4YjYvbbHkbsmZGbGzE2LIGBN+6XUHUlhVlcyBZ9WuhqqMxtnXVEIGCjAo
        kpY7DvIhNiBk4XNk8w85Ko/InfvTzNgozTqX38E9StqsDudMwaJZ4C0Br5hQ/a3g
        TgKrhhKKsBX234GBhTPeQhFrQFF8msOjAW9JEIBfGzFUeWLXS54U5rMNwIuxGXU8
        IfHHjK1cOz9txLRMx9ME2R403mZRPcWFtwyySHJQ8YZG+iljYqGpAdTyJkSQnfOE
        /ejQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698046916; x=1698133316; bh=r6dYmGnIkaDG9
        wqKIpDC+jrkfxlx7iU7ZFhSNZ/JBWU=; b=dv+nT7uuq5TKmAxlx033dxX4fmwHh
        f8vi6DOpjGELmTT1wI/Q2j4gsNaNoq9CVtKrgb21Gf3YVYBdFJYglPVsNeGalNLc
        ecQG4JpN7KJbb+eGzFRgkEMjUPHHUbhtsDIUm/f6P8dnPM9ley5cgByUNemreSZB
        PX61sKj/ZtGfjxVonIVqAEWDlxz3XkeXUgCLkrzi1QvIkIAtSCguFmpC1PgK66Cu
        QFNhn7OH6N1GaozuDiks9rl4EbT53+d+dx8cnPSlTKWXK9iD1duZG9kGp2xldKKy
        1sSEDajZuGUxEz/Mpr+v2bP/dLWU9Ko/s6C6/N0PEF/moNApXauyADeiA==
X-ME-Sender: <xms:xCM2Zb7z0bNk6s4XyYURw_fU9apYmNtxrC4A_7TnsiIATym2nYLs0Q>
    <xme:xCM2ZQ6Yf_DzkrPwDT_DKWZATA1ymX4OK38SZFVjZvHf0Klb2WVhZ-6XaqbmyHtjH
    mJW1bPc6m9DUw>
X-ME-Received: <xmr:xCM2ZSeqOFF4PcUB8a_WU5CblMgKGG1MSftd6sqiwWr6B9wtTK0IZrbyteZjPKCph6KOGlO98gZc0YMsSXxUVCvhqER2ehflXa-tL4YfIjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeehgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:xCM2ZcLo1nDAAUw0rSTBMBquo5JePulIE9yWKPsHnFxJYqfpPGDlGQ>
    <xmx:xCM2ZfIquytiHWb8hsvGW7GWm3mXyQOgRjaCawraXryKEsqeHQ9jWA>
    <xmx:xCM2ZVxRRbtDo0qQhRMb-xUCGV8NzTh8l4y4ZtgZTD36XV1E77pHsw>
    <xmx:xCM2ZX_Eu6k8-rzq5aaw9iKeGk1X5KF_7qUHWJv_Hx5g6eRUUYR8SA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 03:41:55 -0400 (EDT)
Date:   Mon, 23 Oct 2023 09:41:53 +0200
From:   Greg KH <greg@kroah.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     stable@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y] net: move altnames together with the netdevice
Message-ID: <2023102304-mortally-safely-9e86@gregkh>
References: <2023102010-implicit-rectify-fa06@gregkh>
 <20231020222401.3438686-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020222401.3438686-1-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 20, 2023 at 03:24:00PM -0700, Jakub Kicinski wrote:
> [ Upstream commit 8e15aee621618a3ee3abecaf1fd8c1428098b7ef ]
> 
> The altname nodes are currently not moved to the new netns
> when netdevice itself moves:

Thanks for the backports, I took both of these instead of the more
complex patch chain that Sasha backported, as there were fixups for
those dependancies that didn't apply to the older kernels, and it was
just going to get to be too big of a mess to make sure everything was
correct over time.

greg k-h

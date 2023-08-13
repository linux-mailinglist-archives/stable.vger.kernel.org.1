Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27CA77A9EC
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 18:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjHMQYk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjHMQY0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 12:24:26 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5257735B5
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 09:23:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 03E9F3200805;
        Sun, 13 Aug 2023 12:22:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 13 Aug 2023 12:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691943742; x=1692030142; bh=3P
        pmVW8yD4WauoBd2TH4PHSeTQfMge2Qk4VqJ7Zp92Y=; b=sTVnjPQ/gDZUvEyv+p
        ZglthFzb1Rk5T5EfIKgeANVFQupcXgAI52KvRdxiYIS2qnq4BYvaHsTLlu2VM4H1
        4aSOfdUpEiJFkm30YLpwX+cVONWYQ2x5uhBlWbnO0wWfEC8Qfjq2GU4/YBxYOaBm
        OKc3x2bbxiU5GWeGLx9TbFRnAocOVr0Vxl4wX+xhN5IIY3rpHmgSzHeVYvPKv3Bc
        0yOYNFatg+m12zA6e+/CAoG1EAtf/HhPotfINk81Q5e49Bx9QJfF8SHan2XIScNT
        XeT7fXOdaKbYcRdy6ut1cBT29MFjMLlOiPGnsck79HpPqhd63r5NeulFkUllE/iT
        MVVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1691943742; x=1692030142; bh=3PpmVW8yD4Wau
        oBd2TH4PHSeTQfMge2Qk4VqJ7Zp92Y=; b=bL3P7GjHvTK6up8CBFG243xLf6lWh
        g2h1kNBcQ8ZgKI0/BVTgZhqVKqOp3Ku+bEXM2mIByudlSTLJzCaTNbVWHj6874sc
        mJioFVj7y2hzoL9Rw3cNoDMA6t99c6lXUT3KU1KfVvQlKMyKffw714K5I/hFAfpy
        oO8GZYr1VmAvd049yZRwTf9CJTvyO4nqspqCktwgXsTB/yV3eLH9Dt/035fv2a0p
        2yfQ2G3cZ7V1kiEoUAVWE2MvPG8ptsYYoFIWKfDQXefpcnfliUQDX2Ass4jIB1YN
        9tsBT7ZbGWXfRVKacN/nKDT4sgMEFlx/S0Jb/bzsDUh7l7IZdyAYUOHig==
X-ME-Sender: <xms:PgPZZLVyKMkjB6r_4Gn_oeWfLL7ku4PSf11JLiY3ZpifIxUJ_9loLg>
    <xme:PgPZZDmRGfqSquV42_iT8zdmPi8xRonja8y28RHeLHAlcyQ6ZReQ56CBWMJ2QSVoM
    uUiVsGU2ojVxg>
X-ME-Received: <xmr:PgPZZHZjSLuQ6ofAa98pEfb4aiwOeOBWKrkuEoAnu7D1XkeFr_n5aRDORZ8atTbv6jZP2r30KS93ka5fNE1FSPe1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:PgPZZGXJ2RCiMuXEEyGgBzQgrH4b4XaYtXLFmFKlP3SYJW4VakDfvg>
    <xmx:PgPZZFlCC1PNxGVsrudGnRFVIyt3D7HwfRYd1snM8nLICnWayhM4pg>
    <xmx:PgPZZDfSWVLoNbsebm2_jQPwhcZcU-CXlWd8J2i_D9YxOowOFDfF_Q>
    <xmx:PgPZZOBYfRPY04z8MwvPUlhWRcFkqszgUpSvEuX5eJKVE9tHJfYatg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Aug 2023 12:22:21 -0400 (EDT)
Date:   Sun, 13 Aug 2023 18:22:19 +0200
From:   Greg KH <greg@kroah.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     stable@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6.1.y 1/2] nvme-tcp: fix potential unbalanced freeze &
 unfreeze
Message-ID: <2023081344-scorebook-crib-d330@gregkh>
References: <20230813144500.15339-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813144500.15339-1-sagi@grimberg.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 13, 2023 at 05:44:59PM +0300, Sagi Grimberg wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Move start_freeze into nvme_tcp_configure_io_queues(), and there is
> at least two benefits:
> 
> 1) fix unbalanced freeze and unfreeze, since re-connection work may
> fail or be broken by removal
> 
> 2) IO during error recovery can be failfast quickly because nvme fabrics
> unquiesces queues after teardown.
> 
> One side-effect is that !mpath request may timeout during connecting
> because of queue topo change, but that looks not one big deal:
> 
> 1) same problem exists with current code base
> 
> 2) compared with !mpath, mpath use case is dominant
> 
> Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Next time, can you give us a hint as to what the upstream commit is for
this and the other patches you sent?  I'll dig it out for now, but it
makes it much easier if I don't have to do that :)

thanks,

greg k-h

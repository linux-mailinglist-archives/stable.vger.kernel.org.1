Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137357BC6B5
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 12:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbjJGKUD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 06:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343749AbjJGKUC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 06:20:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B119E
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 03:20:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5493E32009EC;
        Sat,  7 Oct 2023 06:19:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 07 Oct 2023 06:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696673998; x=1696760398; bh=dA
        g/gcmhD2iPOVm4EvtLvM4Hq7QxTvOYAKM7S7Q6zNI=; b=zk/6UF0esIi3qQrnTv
        ikIcWy5sCdG4ym/gOwUkov5uGAJOMJ90xXBMainkV7vdqg8+Y5EYFWI/EqNrFGRz
        F9jFmaT7Y72xMC+hn/NgaKNlfzpsvqJib2aIXsgCv1tZgIGBVhIbdBT7vTM4wK83
        N6eyd6xk0WE9A2geIX5wKE3yfp7GXsggjA+KoPSzE38cr6lQEvxINCL0As4I0Ffn
        fpzKydUdH6GHlBH7z/Pykj7X9U5SLNVe6rxSXN4ftdB6F1I+oEBFEz9fq2mUdTrP
        079T1vK+wBDqzuWnxHHTOgUcq4BwX+eps6CCinUUK244LREg/51h/n1XRpvddgEL
        kpLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696673998; x=1696760398; bh=dAg/gcmhD2iPO
        Vm4EvtLvM4Hq7QxTvOYAKM7S7Q6zNI=; b=YEZFE3zSTrL51gWWf2dhqcddTLDMw
        OTOtuXfmqTu0heiBOmjtyh+Qg8pnrNWPXCf8wYEnlqbgEF7wJOW+TmwoljMUiP3c
        h7c0BtgO/sepFhEXxVHqDW355+oJS6FHYTDet31r451GcWgof3csYxCQ9MZ8qxBL
        XuLHDIWdlgn6Z914gI9uZPB1RRL4uus/x0Ixa3b2qx+2/lBamTEANo/G428n8xgJ
        KQglzTziZSUEPHSq/IiO0ncXL0ym5b6PV0a+fygnlo7ywzJ5yGqnHvNR2+G/fkSX
        QY+86Rl5zb2Iw6yu1UXILEwGWncgZGsw9RiEOrm92PwI6o2b7dasknKCw==
X-ME-Sender: <xms:zjAhZRKO5hVdVue7QAUvsP3-NvN7lvCZKUggxMWxHMY1Eu4LMTDy6w>
    <xme:zjAhZdLFXFOyiW6o9v9r5l77xOg6GcTcTw-LcUhFpb9oQXC4dCG6IFwV2rkTyUMRq
    JYoQ_joClt-ZA>
X-ME-Received: <xmr:zjAhZZs-M0mN1W5ebEgR5H0qC4K_QiJfZjeYMckRbTKtq_C0Ah2he8XJQ92XK1-k3wgJg_8Ogw8WdJS9bENYeKPVeiaqW6ojoGGN-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeelgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:zjAhZSZW2JrxLswvGtjoVb66Fli_iJ-4RJMVFdyhW1qLyqm0CmPzEQ>
    <xmx:zjAhZYaWzuZUBIZmR49GOmzUQr9LBDC-AR6Qesf6YhU8MWOdePAVPQ>
    <xmx:zjAhZWAXoVmaEEMFJTWTlLck22N8wWLVuya4W-tJDEAAzlXEx3HXrw>
    <xmx:zjAhZUTrVNPJuVlmwZyNa9ZF7SHz5dYm5n_o8pitOshIYTPyLov-ag>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Oct 2023 06:19:57 -0400 (EDT)
Date:   Sat, 7 Oct 2023 12:19:55 +0200
From:   Greg KH <greg@kroah.com>
To:     zhangshida <starzhangzsd@gmail.com>
Cc:     stable@vger.kernel.org, Shida Zhang <zhangshida@kylinos.cn>,
        stable@kernel.org, Andreas Dilger <adilger@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 4.14.y] ext4: fix rec_len verify error
Message-ID: <2023100748-hesitancy-conical-8060@gregkh>
References: <2023092057-company-unworried-210b@gregkh>
 <20230924021955.2256033-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924021955.2256033-1-zhangshida@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Sep 24, 2023 at 10:19:55AM +0800, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> [ Upstream commit 7fda67e8c3ab6069f75888f67958a6d30454a9f6 ]

Both now queued up, thanks.

greg k-h

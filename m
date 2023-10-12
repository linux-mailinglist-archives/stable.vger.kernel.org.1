Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FC57C74F4
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 19:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347461AbjJLRjG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 13:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379609AbjJLRiz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 13:38:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132B4B8
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 10:38:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 555945C01B9;
        Thu, 12 Oct 2023 13:38:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 12 Oct 2023 13:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697132292; x=1697218692; bh=Bc
        dythh3keQ7hZuGmFeIG1+TLRQ3bXLbxxwfcjhIVB0=; b=puiODgwWBtHFms6Q5B
        I5gPcpVLh6iV+BUB4fmbazIr65FWgSGvH8TyFMzd3PnnrbDDDxD3hYL2RecUJ5E9
        njKQxcp8iq/EiK4CfxTvDgvwSr9RSpgo/kXBCDFtCfNulYdJkWtkBQVTWhdsFf4/
        68JYq0+22GuiDC+gwxQx4b4dQetx7DPNhviPCfOWhsPIr1+C+flS8T93YMKo0aEH
        2u7jtGCKl0c+60uA60j65jRd6ZFwCfvV8MgtB9m4eyQjvMJIt9cyIkREA190SXT2
        kvMraSTIoM0BXySMomUTFm8O3XTDneXUhJ6iWYuBc5ZRGwE+N+qjSnTlU2jlcz+A
        r9jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697132292; x=1697218692; bh=Bcdythh3keQ7h
        ZuGmFeIG1+TLRQ3bXLbxxwfcjhIVB0=; b=Wryj+KDR9aPWEXxa/T3WXYnsqdi6e
        7WIS+iSLB9SQT99aG+XPgrDCUllp1+SqiG+G6CFv/YeE2x+VlNEsuC9VuugRJC8T
        SbTeD1P9mIBibh/mYLrorbs6e7Uo/020vBt9X7p1bscHGsvmuU6YUNr6oN6qQ2YP
        XYkX7iH/8hvQHfiu3D9w++xmiRBRmcmCs++ItcZuZ+ZfxpcrRxb9Yt62WyKSxpEM
        ISohw+wER/Cvya+8MUIHipp92DNZpNLyC5ziw8iYxI3+rzThTzVQzN37tCiE7GAY
        zOf5WUbYzgDav+VJhGgAQyV0HxsBYMnR8X5Ew3lDJMfNlINBUgV0Z6R7Q==
X-ME-Sender: <xms:BC8oZeGGvOV4Fv9Gu8TX9VDmo6TWwqs3ad4pY2QoQ7_PiVJQioyOxw>
    <xme:BC8oZfWv1e9ZsF0HQrPm16XSTDx7YJL3Gx5K_URN8rhJjyItUY6Z8cEGAIYEcbYkD
    lgQPGEZwnhpuw>
X-ME-Received: <xmr:BC8oZYJhTr2fH4za-vR76o7jgIzvSexSWBFxcdgEh29XV6jNHpkxdteimpHBJRczQlBiwer4fHBPPc9uhFeDmZIooZSQ3dakPkmBPl7wejE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:BC8oZYG8tepDMHR843p_40N27czTuIe060TQ80NXgbKgM2T6_zt7gA>
    <xmx:BC8oZUXt7BeiVW0fDQALU-mSp7-uOtP-bAVoAFPQxdW2i_7oE8hskA>
    <xmx:BC8oZbOgjx--pjFUU_55ZtVqNYbL1NIhkCxxxNB9MKjgwXMiGLqXbA>
    <xmx:BC8oZYquQNQk7dreRi7YK7_41-0tL3IeU0Wdt8DAFktaPgmIc7OTWw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 13:38:11 -0400 (EDT)
Date:   Thu, 12 Oct 2023 19:38:09 +0200
From:   Greg KH <greg@kroah.com>
To:     Jordan Rife <jrife@google.com>
Cc:     stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Simon Horman <horms@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net: prevent address rewrite in kernel_bind()
Message-ID: <2023101257-june-banter-e7cc@gregkh>
References: <20231011202849.3549727-2-jrife@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011202849.3549727-2-jrife@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 11, 2023 at 03:28:50PM -0500, Jordan Rife wrote:
> commit c889a99a21bf124c3db08d09df919f0eccc5ea4c upstream.
> 
> Fix merge conflicts, so this patch can be backported to 4.19+.

Now queued up, thanks.

greg k-h

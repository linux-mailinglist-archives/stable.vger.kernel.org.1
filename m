Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF4275B678
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjGTSTL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 14:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjGTSTJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 14:19:09 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28009186
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 11:19:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 65FAE5C0161;
        Thu, 20 Jul 2023 14:19:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 20 Jul 2023 14:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1689877148; x=1689963548; bh=o94EzL6PNpnrBU7dBoXNrvWh0eAbGo7gN2T
        lXhcfAkk=; b=qdrX2p/NQf3/rzZeL0xbJW+AkDP5Ahj6gJP76iTwcAhWilV4U55
        9SvHlgzRbJHO7HWhwoQqSvAUQ4shXEQyQZP9Mz5su3fXfKI5uunbuuuF242weDum
        5fR1fcIHA0HJVOInDkyADK6XRBrSbbIH7EEvKzfMJ+4V92k5tFMs1c5HbmeKxgw2
        m9jggeGmvsVRnRYUVPT9Z1hvPGE8F/amCZWQ2lURk3/vJ3JhLcOHU38bGbi30/T7
        joUfimHdy2rn72tm+b5Y8uDTcfDMIbtogMbjBxB6qckpLfw3b9JFgUE8ZiEW6LQ/
        HXossZhzMhpuOaoNFlcor2+/eyDCt9EQLsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689877148; x=1689963548; bh=o94EzL6PNpnrBU7dBoXNrvWh0eAbGo7gN2T
        lXhcfAkk=; b=Lwxh2JiuYKwmhViMz9KkPLMzrk2A1W+HCz+Rc5nlyZKcS73ktHY
        +ogWMgAUXqOl3Tn9SRxFXK55bxVEbBs0zkMq+REfW7gk4Z6buBV0eTbEBOYv2Deg
        cUPKdnjxwvzzKfOfazZGB99ijnbiXa4QQG2VfqKvOYKV7NH2f8jrckuVvMuPD+Zh
        iN1qoiY3ICf+a6Q8DzrvmhbeICLnL0sdIgU+Q9Cq0zoN8W80Z6V2DyHZmTZMlTns
        PNHJqtv9+FjpYOktori5h/QIecFjxueqP4kXYOnY5szTSchXY445dp4JKLmZOoc2
        lo2CzppRwoKe0n/Glf15Y/rWBhjCrganx9A==
X-ME-Sender: <xms:nHq5ZKeHO5PShLueurHLGHPfDkcAs4jfEx8-MAVM-4sMTqteWy0aeQ>
    <xme:nHq5ZEPoIlRUsTSfUwasVjtbKSvLo0dp5_aJvcchZ4hnDIrO71eBHAnEyuM6qitOh
    hm6EMBTaKngbg>
X-ME-Received: <xmr:nHq5ZLhurV4PZwyQpkjYP3FAEuMpxrNBVUg2jI3b-BI4LwgS1ovkgpOgpWPejhxX9m01GEl5B6VM19QSCpwalnPVoGdDE8TnJw7dHJoIbXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelhe
    ehudduueeggeejgfehueduffehveeukefgkeeufeeltdejteeiuedtkeekleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:nHq5ZH_g1Ac1N3EMA7W55vFa23l0e78tvc_D-9ffu-AjGBeOUYVFIA>
    <xmx:nHq5ZGt0rep0mSJFltAM5zaURz3WIS9XxYTTL1V3Bc4M-RLC_dmqMg>
    <xmx:nHq5ZOFP_V8hhEOnoqxKjgIWDv0rfqR15uYQ6Hqfry1YGVL7_-g1eQ>
    <xmx:nHq5ZHn31WHdEc0PyPU4bXimL0pGsnn0JuOKD1J8CW0tKGlgqeRJVw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 14:19:07 -0400 (EDT)
Date:   Thu, 20 Jul 2023 20:19:05 +0200
From:   Greg KH <greg@kroah.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Aaron Liu <aaron.liu@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 6.1] drm/amdgpu/sdma4: set align mask to 255
Message-ID: <2023072056-crouton-blabber-9e8b@gregkh>
References: <20230717012256.1374-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717012256.1374-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 16, 2023 at 08:22:56PM -0500, Mario Limonciello wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> The wptr needs to be incremented at at least 64 dword intervals,
> use 256 to align with windows.  This should fix potential hangs
> with unaligned updates.
> 
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Reviewed-by: Aaron Liu <aaron.liu@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit e5df16d9428f5c6d2d0b1eff244d6c330ba9ef3a)
> The path `drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c` doesn't exist in
> 6.1.y, only modify the file that does exist.
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Backports now queued up, thanks.

greg k-h

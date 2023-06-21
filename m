Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940F1738F10
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 20:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjFUSrp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 14:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjFUSro (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 14:47:44 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A35D185
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:47:43 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1652B5C01BB;
        Wed, 21 Jun 2023 14:47:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 21 Jun 2023 14:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687373263; x=1687459663; bh=Sp
        xeo6nrEWa9ewSNhEMaHGp3bs9J+d0TD9CYdzSwGGA=; b=01KtUehrtn4xLKWCID
        HA8xqxVl6XPoDo4k7czgVDTEeUNG4BC0YD7hIeEs86pOBHL8/JEMUc1n2QByGQvQ
        q7oZ1wWzn9fNFLaTMIPe0enI9aXrVyhdGWLMLsOYSr2kD6cu+/+vEel8/app7pLJ
        sRAKVbjTA2CU7OoaA7fxZJr38DVYbld9TIZ8AX5e5FHrUA78FpFhANL1rAizZG0b
        grYWg1J6XRX4VRYDOKmzJyFq0QIIlmsfi1x0iqAlvouTl7XkV1Zhw16Yc7D2LVBL
        5EB5PufKeSroLTSTYxuxY1TSfa3I+iGiXjzwPE0qO5LhSmD1XuWQ7lM68Ev4NiEm
        7TYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687373263; x=1687459663; bh=Spxeo6nrEWa9e
        wSNhEMaHGp3bs9J+d0TD9CYdzSwGGA=; b=gyYg06afNw2+W4M6gLTocKTPAD65L
        cP9LLKmsdZlioBSwIyFbS1D9XZNl0K2hXp2jbjPSOBMeMbBHK3A2Pz1+ZAxuBDdK
        E8PB/JUjLztWhfW4kX/GyAGjlC6qd5ctq3ZT+0vzilbFAasoWbDEg5B4SOrSHwM9
        +MExagsygJeD4T4GP9l/aI5dUNb1pBl/yjNv7e/8YFN5E9ongj7LhEBpdbBbBkfQ
        0/w6taHDk7GFhu/CQBBOGAiWd4tMn7YLdxZ89HlgG/0Wp7tCdBzJ2sa0hHd4VAyF
        0pc8NLbQTmH3S6Ufe+It1nwR+AkuEj0mXFRvngMhOzqxU2yk6jJb+yW7A==
X-ME-Sender: <xms:zkWTZJITiVVdwXXkJXHZkseqvcgW-ZN7olJrZfGAbmrCbB5GOhsq4A>
    <xme:zkWTZFKdgIErTT9ieiVIWdTUIn1hebf2_NjvrJ2dbKsgZSOywVsY1qsNQlrpWZZ7x
    TnovlDLTqXMfQ>
X-ME-Received: <xmr:zkWTZBsAE8xs3JiQQ7oMFzxWAzg6VcMsfuGkWHUM8RB_J3Dc9fMhtT2Yx44MBEHgodVqtS7pFJqWWB3lzFayN6geUDe3a6XWtevn7yMnQck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:zkWTZKa59r1ILCT4qQfwrOjf2RtdurDRviVVHUXEwtnk60VoGwMtuw>
    <xmx:zkWTZAb0I-L66_VenyyPOdnOGJR5kaGEQOvkmA52-oXGluUl5sdeLQ>
    <xmx:zkWTZODm-kDs_YD68IPwL184pY8COEkzGEJ-2LTrErSRsYcsl1-rXw>
    <xmx:z0WTZPk72zZqsQBCFnBLPldidycAdKcTysaWx9abmQRnahpJM1jG8Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jun 2023 14:47:42 -0400 (EDT)
Date:   Wed, 21 Jun 2023 20:47:41 +0200
From:   Greg KH <greg@kroah.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: [6.3.y 6.1.y 5.15.y] drm/amd/display: fix the system hang while
 disable PSR
Message-ID: <2023062126-jolt-hydrant-969c@gregkh>
References: <e2ae2999-2e39-31ad-198a-26ab3ae53ae7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ae2999-2e39-31ad-198a-26ab3ae53ae7@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 04:16:14PM -0500, Limonciello, Mario wrote:
> Hi,
> 
> ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR") was
> tagged for stable, but failed to apply to 6.3.y, 6.1.y and 5.15.y.
> 
> I've looked into the missing dependencies, and here are the dependencies
> needed for the stable backport:
> 
> 5.15.y:
> -------
> 97ca308925a5 ("drm/amd/display: Add minimal pipe split transition state")
> f7511289821f ("drm/amd/display: Use dc_update_planes_and_stream")
> 81f743a08f3b ("drm/amd/display: Add wrapper to call planes and stream
> update")
> ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR")
> 
> 6.1.y / 6.3.y
> -------------
> ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR")
> f7511289821f ("drm/amd/display: Use dc_update_planes_and_stream")
> 81f743a08f3b ("drm/amd/display: Add wrapper to call planes and stream
> update")
> ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR")

I think Sasha already got most of these, and I got the one remaining
one.

thanks,

greg k-h

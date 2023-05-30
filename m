Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1734D715912
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjE3IyT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 04:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjE3IyS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 04:54:18 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BB0CD
        for <stable@vger.kernel.org>; Tue, 30 May 2023 01:54:17 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 59C035C00DC;
        Tue, 30 May 2023 04:54:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 30 May 2023 04:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685436856; x=1685523256; bh=Pu
        1vGnbkUbzCpHzDqQJB0TnKUeJ/w+4r4naQ3zg4reE=; b=mWo+6FfcyhkwhnqoMN
        2IlgYJffre73/buPnRYn4lnXxgsDOd8hp234ShhnAiMvxHRhk9h8phvmIuhWjq12
        57vA/WeYA5i1S1Fst6qcSDyShupGqqVJL3ELtDRPt+Go7AZA4ZrB0prppgoef0yW
        feCAqhHy0e5plF1sijOZo7wJDMr9hFYaj0SRMRxSj8BexsWt/y0kPA18Cbuo0xOX
        J8lJS/T/+Y+/OMauZ8/9qb8XVA4//DuUR30GbJxSim5yj+tGlSH5+zesdqsWUG69
        m2sZqQP9wzK8rnfycVepjNPuQW5p7Vqj5yfHTNuqggk8p3P2vHIeOd05zoO5lN1D
        1ccw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685436856; x=1685523256; bh=Pu1vGnbkUbzCp
        HzDqQJB0TnKUeJ/w+4r4naQ3zg4reE=; b=sqyJkQ4DRUtXTxvh5w2VwXl18NIgU
        S2aWvHX24RVi1bjI8rN2e8LQ8mG6aJmzwSuk52Ovi0kA+g5jSR9PZT4O1+cGFY2P
        EGdypeoctCkqwYvSFRMQzVKfwy04D0EAFyrcQt06vfwSExpxFrnr9JwJ0Iks/48Y
        8zQ8zE1uVpoujIU+NesNFRm+O361xq+E/UiehhE/yMSFKs5zS43a7h+YgJLc6hkq
        NPslQwMlufeg9MVCFI5Smhs5kzN90GWcFyjzceX/m51s/NIXBjHUIqystYMeIvjb
        C6/2VvALXHcvDjxpzr0/LQRVs0toh+TQ4ZM/tWcvTE95paIWmfmPJm2xg==
X-ME-Sender: <xms:t7l1ZM9EgrkWe-ewuStuzY0H1iCCrALkCt3k-J8dm-YOLSUBqiVHHg>
    <xme:t7l1ZEtiEz81t_s0Yw4musenMBVDDDr7AAxiGMho-tiwpp4UQ2Nm9MB2SRxkyaiJ5
    xK2MrunZQD_-ecwJAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:t7l1ZCCUFORe1GCKolM8FNnRKsuhdqlqGcqbDUOWjByl-I7z-ZJtzg>
    <xmx:t7l1ZMc9OywkgfUqOFH2h8YB2MIPsf6LbQ2obe8Ckx0WBN5V3Gu04A>
    <xmx:t7l1ZBPccdB7BGxId8xH75fYPIt0iW_D6A-hd8ZDys_ek3lGXrwJxw>
    <xmx:uLl1ZCpMX7FZRMl9Hn01C2EGDhL-YNdDkdoS9j2v1kQ9Iz6lQauf1g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D4CF8B60086; Tue, 30 May 2023 04:54:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <4716f9fd-0e09-4e69-a802-09ddecff2733@app.fastmail.com>
In-Reply-To: <b59d1bfe-15b1-4318-a12f-a38143ba35bd@kili.mountain>
References: <b59d1bfe-15b1-4318-a12f-a38143ba35bd@kili.mountain>
Date:   Tue, 30 May 2023 10:53:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dan Carpenter" <dan.carpenter@linaro.org>, stable@vger.kernel.org
Cc:     "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>
Subject: Re: randconfig fixes for 5.10.y
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 30, 2023, at 10:22, Dan Carpenter wrote:
>
> I'm going to be doing regular randconfig testing on stable so let me
> know if you have any advice.

Just one thing: In my spot for random projects, I occasionally
publish my latest "randconfig-*" branch, which may help you figure
out if I have seen a particular build failure before:

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/refs/heads

This tree should build without any warnings or errors on arm, arm64
and x86, so if you run into something that you can't immediately
see if it as a fix already, you can try bisecting against the
latest branch there to see how I addressed it locally or upstream.

It's a mix of patches that I submitted already but were not picked
up yet, that might need a minor rework based on comments, or that
are not acceptable for one reason or another.

      Arnd

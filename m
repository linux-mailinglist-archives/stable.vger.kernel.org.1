Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3A2738F04
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 20:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFUSmu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 14:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjFUSmt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 14:42:49 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A0A1710
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:42:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B24A5C00D0;
        Wed, 21 Jun 2023 14:42:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 21 Jun 2023 14:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687372966; x=1687459366; bh=1D
        CFOYhVKR7Fof2fTPgYIPklmOHyFs02646E6JZ89gw=; b=zfmBs60z479h69qrb+
        b3KI1AipEPv3y4M4TKZ5ae+V6G8KStTOBmYvgv01giy91eExK3/ed5NZ6dacSqo3
        Oc3ikTpDwQOdMu4Gufp7LS6vIBNsF98zpYDtPQZMKM4PRFiI06EiqONPv6pqkrkN
        nG6V5Re9DajZLI929TI2kuYU+cxpIZk4MrhN+GmkDmhSDLSflChTwc7hu79ioaPb
        Ysrk6vX4vrQUYpY9TuI99qPfIcJelo7PIcJt0Kumcm+agYSaKAwtBqIkYtnbMQDh
        caISQChHRd+pJBCtNcSCMpFN9rmffpO7HieRC/Ca+JAALc+Ikv1c2jFo+N+MYCfD
        DdaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687372966; x=1687459366; bh=1DCFOYhVKR7Fo
        f2fTPgYIPklmOHyFs02646E6JZ89gw=; b=NCFQp5PI4VwyvyIuqG7F8Rqvh7Zk6
        dWtwox6cqfaF9zCmvOCtCBvcAHnEspMLrYGPw+AdWGvgW8HkN8uUyW7r7hBISKaP
        ob6h/v5VPt7QUX9/OJ81h8+DSSWJJFL1lkZQlpWq+WDUUzDAibmUJVKpXypiPm71
        YX2dvakCfjsFsTNFEdGQx2KtDMdFjGga4J+Plw6m90wmokWAmKkhFlVe/FTC5/Gz
        mvM+zkJ/QUJ5dzCLwkJqLMB5jbEiRFhJDcHptQeHhWUXBQbXgIN0GCMY0kdEnuq/
        pI6jFhIydKjyHDyR3IWDGy3/2x2RX1PCLqAIxGSRqsCjH/9jZBb9As0wg==
X-ME-Sender: <xms:pUSTZEOZ8xL_Ndb8xOtM8UqJqJVI67s_V0mehq-_-XP0uoOxEis7Wg>
    <xme:pUSTZK-PJJmT_iPL-jib0KdOjcXJ--OtU1d2QP-xc3rKOI1bKFa4Ah8p43akRBw8y
    hYGSSClV_nJSw>
X-ME-Received: <xmr:pUSTZLS_XDwfjR0O779J8JYmEMWQmu18a2vn0lrluAHyESkmxRwaR4eaQAGcJWrbSMj7sS_KiTHoAKkXzfSV8uO0lZbsGOJCyX33PSSwVHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:pUSTZMvDjB7A5wvxhHzlB4hf6clmd-cr37_aMn64f64CnODfuuki1g>
    <xmx:pUSTZMeDPz_RhX4SiTO1M41aa4iC2fKn98tYmof-Ue3nabV6w6I2hQ>
    <xmx:pUSTZA2CyoyO8YTznYOKsl_KtNSghgDHyoEIzM9DxqcjT1KG97B5Fw>
    <xmx:pkSTZDz9SqK5T_eNd7ZsqrxmvYEASp96Wh0Lotw1rSrymRe3O7vQlg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jun 2023 14:42:45 -0400 (EDT)
Date:   Wed, 21 Jun 2023 20:42:42 +0200
From:   Greg KH <greg@kroah.com>
To:     Javier Honduvilla Coto <javierhonduco@gmail.com>
Cc:     stable@vger.kernel.org, ast@kernel.org,
        "dev@der-flo.net" <dev@der-flo.net>, hsinweih@uci.edu
Subject: Re: [backport request] "mm: Fix copy_from_user_nofault()."
 d319f344561de23e810515d109c7278919bff7b0
Message-ID: <2023062135-wildly-dislike-7b0f@gregkh>
References: <CA+6vxF33CQucQZYwNjs4z_-dckj+Ys_xUyFvFfYrFrFgbAAqpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+6vxF33CQucQZYwNjs4z_-dckj+Ys_xUyFvFfYrFrFgbAAqpA@mail.gmail.com>
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

On Mon, Jun 19, 2023 at 05:27:46PM +0100, Javier Honduvilla Coto wrote:
> Hi,
> 
> This patch fixes a deadlock that can render a system frozen when
> reading user memory from BPF.
> Ideally, it should be applied to any supported revision equal to or
> greater than 5.19.
> 
> patch subject: mm: Fix copy_from_user_nofault().
> git revision: d319f344561de23e810515d109c7278919bff7b0

Now queued up, thanks.

greg k-h

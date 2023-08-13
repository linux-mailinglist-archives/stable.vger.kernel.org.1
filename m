Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7C77AB3C
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 22:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjHMUhu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 16:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHMUhu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 16:37:50 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95686195
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 13:37:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 49C7D5C00C2;
        Sun, 13 Aug 2023 16:37:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 13 Aug 2023 16:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691959070; x=1692045470; bh=qf
        Vbd8r+WjAaXbYqaQ6WUFAk1PlCxXFK7+Ugonz+a58=; b=YTXPP9+1wdZ1Q1FPX/
        wWYqDqADCWSZyluT6iTwwXIrul+uu1mYK1+o17lEtm/p3G1BoOpgD6ep0XCPscKY
        bX9uYWvAOUpOC3mMwHI3oGPkXsVRVzmmGyFtqrXzUeunMUQ+hYGQXy1jnce5DDhD
        lUt4WtR9dhUr0Lp3CNFRTbTCGMln3rzCXR6u5eMfJ2vR28oxPJGvB0e+gkFXHo15
        YOhmdljfiMvWMipBwVuOxt9cKZxsyMQD5F2h9maZMEPBHzYlq7VNaD/8+toolMTW
        SLbbai2X3rLwAlI7Pv//1k3duS/2TGKtrw9gUCDxTkk/44fBBjm2gmDhb2sjkOz9
        /+Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1691959070; x=1692045470; bh=qfVbd8r+WjAaX
        bYqaQ6WUFAk1PlCxXFK7+Ugonz+a58=; b=RQKYvCZSAz+XK5gqtGq9OkIUBCD6R
        bAmeZ6JoZPWN8sWRo/YSm0iEk3nXZSUP7xoPmAn50SdRxLJaMkMKwxWd6ft7rWxQ
        vEplt/GUJgf87JA/Uqp14zp8QbW0Kohi/yY6oJI3752KhOOd9F053hcJV5MOshYy
        zI8/0P6NdnMUGRbgz6knVuF5ev2gqA0FEUsIfm5gAADm4sYNWOErEAvbysQQwtsD
        4vhFkpPuiCZIR3MD64kl4WmzKTZHdNvggqqy+JvJ5wCpbfllUIVj7XPmnbzlCURx
        3EDTzTUyvgKYmZxa540Q57HEzzmOALFl1SwU1xyolCAb+vgRQrONRXz7w==
X-ME-Sender: <xms:HT_ZZPHS7t5p1kupNbA7znu-r_Y1YpEuDYxszhe8FKnDKOuoeSVw9g>
    <xme:HT_ZZMVyVjklcJO-qjFzuRSmRZGw1p3QIBq0PaLQPxvxGX096oHjEsWEDBQQR5ZX-
    05ExhwIWZ2sDA>
X-ME-Received: <xmr:HT_ZZBI06K93DOcaiw7JJXSLQ2gAntbQlRtvSxAKd0NSoO3YhDrRGAIJJhc7iwbw0Eq9doa17CxZ_ypclqZ8B0ma>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtvddgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:HT_ZZNHDIWZDDVPug_Jeo4GGZuwRuyKHMovmssByLFRx3PUqiixYNw>
    <xmx:HT_ZZFXqPdH8q7pbdUn8M_ERWTdtPRrRtS-25_fCFZSCuOMOfiPKwA>
    <xmx:HT_ZZIPAJ_XZ_eVLUtDjPmkImYAYpDV8QZg2CP5aLs_nrH8nX81P2g>
    <xmx:Hj_ZZOO7dztGhH31IecBEacEfzX9ZT3SJE5SN6ngrvKkHsvEk1ll5A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Aug 2023 16:37:49 -0400 (EDT)
Date:   Sun, 13 Aug 2023 22:37:47 +0200
From:   Greg KH <greg@kroah.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5.15 2/3] timers/nohz: Switch to ONESHOT_STOPPED in the
 low-res handler when the tick is stopped
Message-ID: <2023081327-capsule-drainer-38e4@gregkh>
References: <20230813031620.2218302-1-joel@joelfernandes.org>
 <20230813031620.2218302-2-joel@joelfernandes.org>
 <20230813202655.GB675119@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813202655.GB675119@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 13, 2023 at 08:26:55PM +0000, Joel Fernandes wrote:
> On Sun, Aug 13, 2023 at 03:16:19AM +0000, Joel Fernandes (Google) wrote:
> > From: Nicholas Piggin <npiggin@gmail.com>
> > 
> > [ Upstream commit 5417ddc1cf1f5c8cba31ab217cf57ada7ab6ea88 ]
> 
> I have the wrong SHA here, it should be: 62c1256d544747b38e77ca9b5bfe3a26f9592576
> 
> If you don't mind correcting it, please go ahead. Or I can resend the patch
> in the future.

I've fixed this one up now, and queued up this series for 5.15.y now.

thanks,

greg k-h

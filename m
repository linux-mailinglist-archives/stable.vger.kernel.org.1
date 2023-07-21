Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF975BD4C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 06:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGUEdl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 00:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGUEdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 00:33:40 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB53710E5
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 21:33:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7142E5C0129;
        Fri, 21 Jul 2023 00:33:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 21 Jul 2023 00:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1689914016; x=1690000416; bh=bv
        Sc1L16Zur9daqCBfWwPXxAbs4cC6BtrY8NEoZJxZg=; b=y37kUc2C5ggB/xuYES
        XhYAMpT8jDXtClp1Hm+PAboFIic/b+R1d+crdy9wCA8WrqF5cmfiJZBPR/jog/SU
        CFqvfc18CZSEhXKCu2xGa6VGJt4yarCVim1LudJZpoxA6zv1HGJ2hiyjw4eDKG5q
        9ygbJC6NVRYHl9B75G0Pc0rXXAn6ADOcX4YUOUyR9M1XYroHo6pzz6MwJdkgSh7Y
        axw335F7rzZRBIfPFKuHOrHR5z9R7VVMLhNhfrtusR9RFepvm70j/vdoSj7tG0PK
        xHEl9Eq4j+3OJrSSwKjr5ZaTRjha+ywDoRa/0XOEOaZtoHGBDOjyNXbtUACqaDBh
        sXaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689914016; x=1690000416; bh=bvSc1L16Zur9d
        aqCBfWwPXxAbs4cC6BtrY8NEoZJxZg=; b=ptAfyPab3LTApKhUbMRUSb4KutMw8
        +9c0E/Bz2BzYvLtWdqZG/MW1ADqPMhOdfql2PX95OWvdxBJx9a1TqbMNymYeLyGk
        TrZgUqJbUQDTFBcTLqeBesc9F/ZPuzTtt9bQkiHcZFu5ujHcuUocHp+IyQNMsbfB
        hpCZTq66ix5ObkSaJSmdAuy4UfUEQkKClLqTH1tD2dRG/52YIM/3i18GM2mJ30gX
        aRLOP1lyjZmSSInc3pgzlItKkcIpPB1+7zlaYsuNwx/ohoWiXnw0g0KLFWDpSEuA
        KxPq1pD0s079caGfTi9h+LWzwa/188wqUNSujaSUBGmeH3XgZE6hJru5A==
X-ME-Sender: <xms:oAq6ZNNPAmQWwIXEbs1ogC5kZe9GCPmnFRNjGqMOWSu7lJCEQ42lyA>
    <xme:oAq6ZP-qLYG-wm3jHU9mazAabnslY-rRauvsr3Ugwa4uSgrvt1ttxCuow6-JvnJgT
    N1GBihmEKfvjQ>
X-ME-Received: <xmr:oAq6ZMRAh8SrfBbmV8rB3A_7wn-uQia6-F_EaWx3R3jdOtmzq35xCNpHkpoUzHEvk4OzhqqhpoRsvws85KZO0o9ddSQgqKrDyLpk6ppKGC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:oAq6ZJsXWiMUd4o_9LNPCmLuesJD6ncgP_EbFBY75OIQZKfEimwp_A>
    <xmx:oAq6ZFcTuWdz1iFZ7uVrEDlyFZSK6PcdnmjZQplgYDVYy2dZyTlkdg>
    <xmx:oAq6ZF0CSDj0GOLzauA5bxPkxl_ofYcIh9qRK0KL4KXZ2ZGXLt-khA>
    <xmx:oAq6ZGqUPOOzQDu2z_FZJM2rzxzNW6StO3rT5a1gy_7WabnGKBRoHg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 00:33:35 -0400 (EDT)
Date:   Fri, 21 Jul 2023 06:33:29 +0200
From:   Greg KH <greg@kroah.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Interrupt storm on some gaming laptops
Message-ID: <2023072118-enchanted-emphases-3b55@gregkh>
References: <10fef988-8460-f96a-2d3d-cc8c6a37f3eb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10fef988-8460-f96a-2d3d-cc8c6a37f3eb@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 17, 2023 at 03:17:48PM -0500, Limonciello, Mario wrote:
> Hi,
> 
> An interrupt storm was reported on some gaming laptops [1].
> This is fixed by a series of commits that has gone into 6.5-rc2.
> This interrupt storm causes a pretty dramatic issue of unable to use the
> internal keyboard, so IMO a good idea to take the solution back to stable
> kernels as well.
> 
> Here is the series needed for 6.4.y:
> 968ab9261627 pinctrl: amd: Detect internal GPIO0 debounce handling
> a855724dc08b pinctrl: amd: Fix mistake in handling clearing pins at startup
> 0cf9e48ff22e pinctrl: amd: Detect and mask spurious interrupts
> 65f6c7c91cb2 pinctrl: amd: Revert "pinctrl: amd: disable and mask interrupts
> on probe"
> 0d5ace1a07f7 pinctrl: amd: Only use special debounce behavior for GPIO 0
> 635a750d958e pinctrl: amd: Use amd_pinconf_set() for all config options
> 3f62312d04d4 pinctrl: amd: Drop pull up select configuration
> 283c5ce7da0a pinctrl: amd: Unify debounce handling into amd_pinconf_set()
> 
> Here is the series needed for 6.1.y:
> df72b4a692b6 pinctrl: amd: Add Z-state wake control bits
> 75358cf3319d pinctrl: amd: Adjust debugfs output
> 010f493d90ee pinctrl: amd: Add fields for interrupt status and wake status
> 968ab9261627 pinctrl: amd: Detect internal GPIO0 debounce handling
> a855724dc08b pinctrl: amd: Fix mistake in handling clearing pins at startup
> 0cf9e48ff22e pinctrl: amd: Detect and mask spurious interrupts
> 65f6c7c91cb2 pinctrl: amd: Revert "pinctrl: amd: disable and mask interrupts
> on probe"
> 0d5ace1a07f7 pinctrl: amd: Only use special debounce behavior for GPIO 0
> 635a750d958e pinctrl: amd: Use amd_pinconf_set() for all config options
> 3f62312d04d4 pinctrl: amd: Drop pull up select configuration
> 283c5ce7da0a pinctrl: amd: Unify debounce handling into amd_pinconf_set()
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217336

All now queued up, thanks.

greg k-h

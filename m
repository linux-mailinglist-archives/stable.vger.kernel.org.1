Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEE47D1C0B
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 11:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjJUJZf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUJZe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Oct 2023 05:25:34 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18681A3;
        Sat, 21 Oct 2023 02:25:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E294B3200AE5;
        Sat, 21 Oct 2023 05:25:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 21 Oct 2023 05:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1697880321; x=1697966721; bh=rlh0h5qajVIoXRZWGLAfuf98MgKzQ+2olbn
        CuKR9GkM=; b=BlPHlBlDWYTGtvNThRIap56tbohJ+MD7MjipAYGXFhPdRFIOZoT
        I39Aq0OPbgZCoiDxBPX3R5YDt6BzmjbwRvOHQs1+Q0EAXKiavADnbq1xa26ggS3e
        wvvT1LA7zELa2PXEsibJ4Let6jmnyOKKzpreQ/BI7FIrzR3gP0heWO3bootSbcPX
        7j46RE8DQq9YxL4h/RXD/OtEXOM72XEI/OhSMiqyrATk1n4OYu2LJ3thpppepVGE
        VZ5ZGvZG3Jo0tdwW5lVEYr05GgoWwyKt/N+gLIVwd6iLxEUHSpfq7SOD+wUOJjYA
        skZL6PT3dawYxcM/MZBL0JF4qO2ceMTM1gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1697880321; x=1697966721; bh=rlh0h5qajVIoXRZWGLAfuf98MgKzQ+2olbn
        CuKR9GkM=; b=deR20aStqiiwGsiwksHHix6RoOASn7imQ/m76bAkj2LZt2zW+pa
        V7nbg9yhMLDEtplPL746p91j1850YleKVi00RoRLbr7fgH7NHpfF13RzQcuplvSa
        QZj3QkTgBnnJXKmL1d0Q/xB4xzHVIdir237lZCZTysu+AaN1qerlrArKSGBkeu6T
        wcx2JBLGxfaiMgKvb/GgSudEPiUtkSzg3DElX7DpgEKNTyJrlkmv9nvDZZ6ORaBq
        SNJtylxo7Fj1YkrG7OWaBHTDyguYKZQK2YBKvtiiZckWUxVDKRjx3ztVYo+cPhM0
        8jCvtk2fFoYouXpDmzfIt8kTKxBkxdDkIuA==
X-ME-Sender: <xms:AJkzZSBTJaWeJ44Hi83PdiensxP0sh-IbAFs4g3EJNOuWtOiEn3Oag>
    <xme:AJkzZchACYPMZJlYdMpSXk_dyajhmI0g1VPX4sYTBwuEtf8OCrYa19f7Irf91PlA2
    mypgnTrYPY-lg>
X-ME-Received: <xmr:AJkzZVmd5DqF58hdkRIvetwU3uNF91vCFKxd1HSQBlyhgfg06gVs9Jn9LITC_2n3Cx2zbDfPH1NXZptyalB0rmKuU-T9aPIbYIsFCqmh6w8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedtgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeevve
    etgfevjeffffevleeuhfejfeegueevfeetudejudefudetjedttdehueffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:AJkzZQxhpPlvqvK12o7FMMxHKra1Lj2cm1iW5dSyAk4n03IAj9H5SQ>
    <xmx:AJkzZXTegRUtWiNSOXRSJC9VGlVRDxd8Vyd8iudSCpxgAVQ3rUcb6Q>
    <xmx:AJkzZbaL_gG-0CEBRjTd6KeTLQ0l05C3GyoB9vLLYa577CvmfmOfBw>
    <xmx:AZkzZYIdvvz_iHlqtc3BfB6-hY7maKObbL3-MK635P028UDym_-FpA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 05:25:20 -0400 (EDT)
Date:   Sat, 21 Oct 2023 11:25:18 +0200
From:   Greg KH <greg@kroah.com>
To:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Patch "ice: Remove useless DMA-32 fallback configuration" has
 been added to the 5.15-stable tree
Message-ID: <2023102159-chitchat-goliath-af2a@gregkh>
References: <20231021002330.1609939-1-sashal@kernel.org>
 <203646d1-7dc9-436d-a556-ea2861ac3d4c@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <203646d1-7dc9-436d-a556-ea2861ac3d4c@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Oct 21, 2023 at 10:52:13AM +0200, Marion & Christophe JAILLET wrote:
> 
> Le 21/10/2023 à 02:23, Sasha Levin a écrit :
> > This is a note to let you know that I've just added the patch titled
> > 
> >      ice: Remove useless DMA-32 fallback configuration
> > 
> > to the 5.15-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       ice-remove-useless-dma-32-fallback-configuration.patch
> > and it can be found in the queue-5.15 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Why is it needed for backport, it is only dead code.
> 
> Another patch depends on it?
> 
> Looking *quickly* in other patches at [1], I've not seen anything that
> conflicts.

Agreed, it seems the dependancy bot got things backwards, I'll go drop
these now, thanks.

greg k-h

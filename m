Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8C74F9A3
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 23:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGKVS7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 17:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGKVS6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 17:18:58 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB21133;
        Tue, 11 Jul 2023 14:18:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 760143200941;
        Tue, 11 Jul 2023 17:18:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 11 Jul 2023 17:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1689110332; x=1689196732; bh=9KRcgH1FI3iCJwcfvsgArzfpcVPSohGf5Iy
        H+yund90=; b=E0wY824UWj0/hW11qDErCoyBBt6g8wDeh+pWG8PIaGYhZcIq2ki
        RIcNCWcXpEKg6bj7OL7AwxlUMrnRVfiUT3rjwddRNXq5/ytdCiOb/z1pFUHUBBok
        qdPd3Te9nOBiTX3JYXGQGBjy9IiAAlbE8CdxAHdAci/C4VKVnZ4aCXsRjU5qbgzW
        UFIS0NNGVa4lhA4E+6BvXeS+yE/7BzuvHeqAK17A5Iq1DCu7MXT0dKaSJvRhnlPK
        vPgMikduB+FpTYhLAL91hSFbmN82tIcXSXjP6aflfj1lkRbd8o3Oo3z/IOrO2LUh
        3t6x1oF44UwUnWMcRO9slRmEjtkLcycFBqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1689110332; x=1689196732; bh=9KRcgH1FI3iCJwcfvsgArzfpcVPSohGf5Iy
        H+yund90=; b=cU3+XVXxpbgdtnLDiOFKcj7ronIUqqX3JZea+7MDieXjp32jEbb
        5AzuEWXyAPZ2MH/mCUSw2akujhJfJSQbaMomVdhYITbraox8j5FYM2NusnO6aDvT
        DHH9cSytxFYt/pCivePcrAKgONDGORtvLRCHfqsbXz8FMO1Dtkq6HtJC2eBjhfDa
        C0mYGrfsWNXYvpXRhXuIeCqJE9llsTrCfM7VbJ3qeB7MvJr/qlel3ucvMeGow1/Z
        o/QbHo4uLnOTFcCUcBhespcv2hENvx38y/tpywfWsCg9kJN3OoDB7EjlfutbIObV
        ZHx7crcBCAxzXNJma1mVMcHA4CR2VzMRpxA==
X-ME-Sender: <xms:PMetZKH_aaik2Cf59I0f1m19mbWiiw3L8jfDRBR-M4F9iBLZx7UBGg>
    <xme:PMetZLWZLn_cTOLvff2m4vsTFt_85sMt-Y1kd4d1_uo49v9JDlNGK_JTmkpDG6QQ1
    gXMtDcduGmNDA>
X-ME-Received: <xmr:PMetZEJoLKXRxqTDBg5yG5TdaIdoHoCfrhJ6E42YGDpFIg3aViEZYf7X-OFb4LqeeXxl_VduxMNu848cvpLQO5RJjgOjTeESsNOwuZ-9K5k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegve
    evtefgveejffffveeluefhjeefgeeuveeftedujedufeduteejtddtheeuffenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:PMetZEEcT9f9jj_3ixoljoooaMpGDlGBjyoOl7uJO4nW4HwcVav9Mw>
    <xmx:PMetZAUyQWaLjJ406dkAM_ZdoF6Hr3KMNt_khUNYQSm_gmJYwoI2sw>
    <xmx:PMetZHNmNRBa24uuq2unYaoYBVwltasXUXLObZyd6OcCK7mi9jq-Vg>
    <xmx:PMetZErlrX7dwYxHULV8rkL9Qs5SAj2lOS0fx1ObHFpxdHVNn1fsqQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jul 2023 17:18:51 -0400 (EDT)
Date:   Tue, 11 Jul 2023 23:18:50 +0200
From:   Greg KH <greg@kroah.com>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: Patch "mmc: core: Support zeroout using TRIM for eMMC" has been
 added to the 5.15-stable tree
Message-ID: <2023071140-enlisted-crucial-9231@gregkh>
References: <20230709061209.483956-1-sashal@kernel.org>
 <9dae21814b7b73cc0db1b974a868c4ced62287fa.camel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dae21814b7b73cc0db1b974a868c4ced62287fa.camel@axis.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 10, 2023 at 05:55:54AM +0000, Vincent Whitchurch wrote:
> On Sun, 2023-07-09 at 02:12 -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     mmc: core: Support zeroout using TRIM for eMMC
> > 
> > to the 5.15-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      mmc-core-support-zeroout-using-trim-for-emmc.patch
> > and it can be found in the queue-5.15 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit e71c90bcc65727d323b9a3cb40b263db7be5ee4c
> > Author: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > Date:   Fri Apr 29 17:21:18 2022 +0200
> > 
> >     mmc: core: Support zeroout using TRIM for eMMC
> >     
> > 
> >     [ Upstream commit f7b6fc327327698924ef3afa0c3e87a5b7466af3 ]
> >     
> > 
> >     If an eMMC card supports TRIM and indicates that it erases to zeros, we can
> >     use it to support hardware offloading of REQ_OP_WRITE_ZEROES, so let's add
> >     support for this.
> >     
> > 
> >     Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> >     Reviewed-by: Avri Altman <Avri.Altman@wdc.com>
> >     Link: https://lore.kernel.org/r/20220429152118.3617303-1-vincent.whitchurch@axis.com
> >     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >     Stable-dep-of: c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019")
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> I still[0] prefer that this not be backported to stable.
> 
> [0] https://lore.kernel.org/all/Y1owQYlr+vfxEmS8@axis.com/

Ok, will go drop this, and the dependent patch.

greg k-h

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928FA712C72
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 20:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjEZSaT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 14:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbjEZSaQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 14:30:16 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDCEF3
        for <stable@vger.kernel.org>; Fri, 26 May 2023 11:30:15 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 33AD83200936;
        Fri, 26 May 2023 14:30:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 May 2023 14:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685125814; x=1685212214; bh=8o
        2EpJzuS6yovQyTJ0x1bfkjSADeRWgqYKPzlO1CFmQ=; b=pOxk2s3shd/kAIr1Xz
        9y0s5VF3WkGhBA7g6x6l2HnfSgf3j3b9MoprkR5ed1duyI4c5ISq1I1g1M+8Llq0
        lSjUuvZKQUklxURGqzhiG8J5XB//B19rhtcuYL6ZFbVpFde8Y6uE5+zp9NT5tWWm
        1L/8BfTHQYN5kFTrAvaT0i27oFUstYJDFUczSTjgpRDV2V9vBBemuMbaORCGFt2W
        fRSkrSusff6RaFnBe/HKukGz3KpXHS+aYiHff1CJZOZPrGv+ss7yqJI+EGh2O3bz
        GgcgKG2mxA8F0df8KTaCETUm3LNjPcnq7q6N0Dz0yFwlX77CsIcd5FMmm1BwIFJ6
        8wpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685125814; x=1685212214; bh=8o2EpJzuS6yov
        QyTJ0x1bfkjSADeRWgqYKPzlO1CFmQ=; b=E6K+96W8MwtU17gkhdV0P/ywXP9uC
        De9WOuKaQ54/+Xh9+ZHSogUo5lkaNnU0rd9KN2iQYkiNl0V5Ulw51IX/4WyS2GOo
        uM2VO5JRsIz9Y367uXmOsSnUVe/QZVZV/SqiaIFTHj2F15qxi9WHgFzmlX2JevsL
        N9dRCAnLYSxb0LRtAyVbqfahy8arjiJReOZzQ9V06juMPt5Hdu6Eu9h0VCWLpWxY
        67wjJfu01qdFVVS1REfhucMrPrbdmE45QHgXQXC9JyIg7L1H4o57baRfP+J4qAgD
        IHrRYO04JVl+3pc7lJgcu9Xq1vwFzGyLp2E6wLKdOBq23WCr1nDPM2nKA==
X-ME-Sender: <xms:tvpwZKxbWsLIIbaBWRd_sPUYgfltz9hDoD_0BRHq_iMXB_QPyMXAuA>
    <xme:tvpwZGSsW-EjfzWd0xz_lwoR0INLrIO5Tzs7nBascMAZiIepHTmA9LiytIYVSiJsJ
    tDDiVcHDCAvUA>
X-ME-Received: <xmr:tvpwZMWWeuwlMGDyC5eCgprsxOR6n1PtPJJuCfyQz6_x_85L5QQqIiG81Pg6oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:tvpwZAicJuzQcG7bpSYd3rc4dXgQLQEHRdmPp1en92trs4bK3vondg>
    <xmx:tvpwZMBjQ0BxusCyDLBVmnJP5enM_JIzWbndyPsuVLERn_g3dBallw>
    <xmx:tvpwZBKVNt6wZ_FigMweVj6ZQpgq0mTrwv_uXghR6bX3e29nvsTP2A>
    <xmx:tvpwZPMoL4uV15aE4uv6Iu6nSndiBrKjy0FjS_UbCVF_UuY_M1Ic9Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 May 2023 14:30:14 -0400 (EDT)
Date:   Fri, 26 May 2023 19:30:12 +0100
From:   Greg KH <greg@kroah.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: hpd rx irq not working with eDP
 interface
Message-ID: <2023052604-vocation-trimester-4f4b@gregkh>
References: <20230525002201.23804-1-mario.limonciello@amd.com>
 <MN0PR12MB610177142B98F11B8E022130E2469@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB610177142B98F11B8E022130E2469@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 25, 2023 at 12:56:48AM +0000, Limonciello, Mario wrote:
> [AMD Official Use Only - General]
> 
> > -----Original Message-----
> > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Sent: Wednesday, May 24, 2023 7:22 PM
> > To: stable@vger.kernel.org
> > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Subject: [PATCH] drm/amd/display: hpd rx irq not working with eDP interface
> >
> > From: Robin Chen <robin.chen@amd.com>
> >
> > [Why]
> > This is the fix for the defect of commit ab144f0b4ad6
> > ("drm/amd/display: Allow individual control of eDP hotplug support").
> >
> > [How]
> > To revise the default eDP hotplug setting and use the enum to git rid
> > of the magic number for different options.
> >
> > Fixes: ab144f0b4ad6 ("drm/amd/display: Allow individual control of eDP
> > hotplug support")
> > Cc: stable@vger.kernel.org
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
> > Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> > Signed-off-by: Robin Chen <robin.chen@amd.com>
> > Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > (cherry picked from commit
> > eeefe7c4820b6baa0462a8b723ea0a3b5846ccae)
> > Hand modified for missing file rename changes and symbol moves in 6.1.y.
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > This will help some unhandled interrupts that are related to MST
> > and eDP use.
> 
> Apologies; forgot to mention in the message this is ONLY for 6.1.y.
> It doesn't apply to 5.15.y, and 6.3.y already picked it up successfully.

Now queued up, thanks.

greg k-h

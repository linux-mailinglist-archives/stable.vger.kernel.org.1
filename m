Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A36E7BC695
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343767AbjJGJ6p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 05:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjJGJ6p (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 05:58:45 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2EAB9
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 02:58:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 613483200A29;
        Sat,  7 Oct 2023 05:58:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 07 Oct 2023 05:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696672717; x=1696759117; bh=/4
        Hj0fckFPtmF77SA9wcJcaRizy9bNclxagqgCCKKrQ=; b=p++lqyAfHhMBhXLpei
        9ViJYO7rZM2p0eyfA4xIPpS/fJg3O5aUhNQsj9zI3pmJYaKazL250tm8gixQdjsH
        0ak79CEo5LgHa2pOXx9T6Gzpnf2CbiBjJ00p1fLZ7Ubj3Gc0m5HHIwGuOmM6KbG7
        JQ5vx/gJzok0DeffqL+2uRKNXLeL+XACoblWzbOtUEUvDUNGhoi0IhTMNsMBUAM0
        3aw38zX9mlq7qWhzQuEvjMwLivjRB3iKjgSy0jNMKf/IrDz6ycN+E39bclFeamFx
        0gqhrxKfZ86Ncn+ISOmDeuaV0WvMdbFtd2B3TK8MZIcvckKPUaWrrGG/b4tbKPbJ
        7s6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696672717; x=1696759117; bh=/4Hj0fckFPtmF
        77SA9wcJcaRizy9bNclxagqgCCKKrQ=; b=fu4prmxkjGMQRkzmXjQ6xOXJjX8II
        UZgldZTgXo60l5XZjp4g8E50zlPt7kDjVXAwnADNTH3ol7u8gfbo6GOeUpfrwizg
        BwZUKrOZUplqTvJangIFJQ9s8jV3dWyqzGvBgaQBifpYVn2HphFsW84Bg4CbfZRT
        M1P7uRihm/GLUcjp8Jen1nM8BGKLmtBb1ENnVA2k2GkMhgHQByzIwh9PXuQdlT3M
        tofwksCoUXS8ogZoO+hNBLNIgS4tvlcjVTWSHKt1ifVt30WvVlVP06FX1VgIcHqd
        igXzI2KcUWV9p/vuzu1JEsAf8lEKnTCj7u3BUhxQeCLBg8TpM2ob21QVg==
X-ME-Sender: <xms:zSshZd8gjNf1R3_HK1FCEpAJ1EkxSAhj_gYsrC2-ilypxAoWQy10ug>
    <xme:zSshZRt1vKNAEx9OpIHhzhzNIVBK9p3StDXSkznuDK4WVuwcX7kyn6RTX9zvhxTVA
    WWzTbF6EhfUOw>
X-ME-Received: <xmr:zSshZbB2uF4KLDAR4SmdBCXbiFiWj2TBLLf7SSJZUEGPGwSIE_TZAXFFR-CJ-EbFnGPZia3kkXdLgI0WKyVXSVbZlQmgX8QMcUnq3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeelgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:zSshZRcVUF6Ip1TskmOdpLDQY4apGevCYAzLAeoN9xIQztrrjKrMzw>
    <xmx:zSshZSNpg7rT7eLMHO8CEcDXp_dpLPtvuzNID_Y_nxT_7J6StVWSUQ>
    <xmx:zSshZTnSk0FxbfclHAF30ndVEPbiQlGIj89UNpS0Va_Dc5l_SlQ-_g>
    <xmx:zSshZeB7TwNhzZmpqXe6I1QEqQNsBpzdqOUZfjCCaUxy_94seS146w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Oct 2023 05:58:36 -0400 (EDT)
Date:   Sat, 7 Oct 2023 11:58:34 +0200
From:   Greg KH <greg@kroah.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH 4.14.y] ata: libata: disallow dev-initiated LPM
 transitions to unsupported states
Message-ID: <2023100720-frightful-clean-4bb2@gregkh>
References: <2023092002-mobster-onset-2af9@gregkh>
 <20230928155357.9807-1-niklas.cassel@wdc.com>
 <TYCPR01MB9418B505FA508B884166798192C0A@TYCPR01MB9418.jpnprd01.prod.outlook.com>
 <ZRq+KUh8fwb8N7ru@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRq+KUh8fwb8N7ru@x1-carbon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 02, 2023 at 12:57:17PM +0000, Niklas Cassel wrote:
> On Fri, Sep 29, 2023 at 07:27:05AM +0000, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> > Hi!
> > 
> > You have forgotten the upstream commit ID.
> > And there is a message of cherry-pick -x. This is not necessary.
> > Could you please add commit ID and remove cherry-pick message?
> > 
> > commit 24e0e61db3cb86a66824531989f1df80e0939f26 upstream.
> > 
> > Best regards,
> >   Nobuhiro
> 
> Hello Nobuhiro,
> 
> The Linux 4.14 stable kernel maintainers are:
> Greg Kroah-Hartman & Sasha Levin
> 
> See:
> https://www.kernel.org/category/releases.html
> 
> I followed the instructions provided by Greg Kroah-Hartman in email:
> https://lore.kernel.org/stable/2023092002-mobster-onset-2af9@gregkh/
> 
> 
> """
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
> git checkout FETCH_HEAD
> git cherry-pick -x 24e0e61db3cb86a66824531989f1df80e0939f26
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092002-mobster-onset-2af9@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..
> """
> 
> 
> I do find it slightly amusing that the instructions,
> provided by none other than the stable maintainer himself,
> which mentions linux-4.14.y, should not be good enough :)
> 
> I think you should bring up your concerns with the stable
> maintainers. If this is really an issue, perhaps you can
> convince them to update their instructions.
> 
> Until then, I will assume that the provided instructions
> are satisfactory.

They are, thank you for following them, I'll go queue these up now.

greg k-h

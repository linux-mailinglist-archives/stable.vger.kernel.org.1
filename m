Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385FD712CBF
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 20:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjEZSpx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 14:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjEZSpw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 14:45:52 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4657AAD;
        Fri, 26 May 2023 11:45:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 64E25320092E;
        Fri, 26 May 2023 14:37:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 26 May 2023 14:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1685126222; x=1685212622; bh=Ntgtx7rkmatZ1dpyIZa01ZwzxgAcF6BHwET
        ZbelXN+U=; b=spzMWxuSymBYU+569azl/RmafVrW4o/nNk2YgBh0ORihAQx/f2t
        K2ZSYPQEXIMvN+dsV7l+EIrI6TTbERIn+BkPH3BDQnHdTGkyMQxrpQW6VG6tzcWY
        jiVErUu7JIvHrfc1EQf1Faya3cutnZo66mcfo+BT7yklPKIFyCZ1D9f2r8aThTqY
        rwE1m2a1cbVYwYn6q6cnbGH3xqE5mhQoKHcuoaALn9FZ7me1tP/Pn+nTXTWUovM9
        uw8kPT7BiVWq0MiRmjYYn+p4/KbKgzymYGP4tUDMNNbFpsveZz7wRxmxqws/hZus
        pUBjPmr88NGiEblJTz+YDhmsPUA4TUDBMuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685126222; x=1685212622; bh=Ntgtx7rkmatZ1dpyIZa01ZwzxgAcF6BHwET
        ZbelXN+U=; b=W8ag+NtprYnczw2QbEo3pU04wNt3+8uuiSgqBjpASoeXhIGcR4P
        cpEFnkROXSRUEBqYKz3XuA3q5Q1y+z6Au1F9dS16G8O6qwzq97XWz5T/kN6SZOXd
        P+4pQJNBkflWQxzz4GxF/C3Uf01re3vV4Riy+266Z9HhCUoJzTb7prembCKYkUj1
        +WSf20nzNONPXn/UdZ6LW3e5B02tJrDzKeaLEDIRsuZ+H9ogBT6OJIsAgrT0dCPi
        jaGh0BvZKLB458NtCzFPIFvS2Xgk2GDpexrNCp/o2TvflTBiK6CgEhTOrLtYDSIM
        ZxObwHQkK4np0pRyE5iHr7U49XjYoNw0fbw==
X-ME-Sender: <xms:TfxwZE4dbgcH6juNOW929Csztw4qeqATu9pu-IxhVj4uSBOSqhthMg>
    <xme:TfxwZF6qFAhy7U7K38SJkA-LqknyYxlBXbuRKALu_Srdnvcx_CeRiRZlXFlO8-37G
    luqDDfeXs4Opw>
X-ME-Received: <xmr:TfxwZDdW5Yt_dx9eJOwOWXC48O_InhIhqw78Ss74TAJFjk71e_ANpjLjQvhAAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnheple
    ekheejjeeiheejvdetheejveekudegueeigfefudefgfffhfefteeuieekudefnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:TfxwZJKLsg2ZViuNj_cXzDVnrK5iB8yg5w0500eJU3Z97avfnPNSJA>
    <xmx:TfxwZIJdRsFt8Nx_6_Yx1xoRu9LfZ3PuKEVxVYGX1Sfw5-tI4RVG4A>
    <xmx:TfxwZKw4t_OOmxTsZ063TNAcVgzzUEOLT48mXcb7g8Fzcb_jmir-HA>
    <xmx:TvxwZH86gjh5TRVphWKcqIF-AwFhoITfB7HwyY9UcGbZUEnm_Aj_Mg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 May 2023 14:37:00 -0400 (EDT)
Date:   Fri, 26 May 2023 19:36:59 +0100
From:   Greg KH <greg@kroah.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        linux-security-module@vger.kernel.org
Subject: Re: Stable backport of de3004c874e7 ("ocfs2: Switch to
 security_inode_init_security()")
Message-ID: <2023052629-endnote-unison-bb1c@gregkh>
References: <CAHC9VhRPvkdk6t1zkx+Y-QVP_vJRSxp+wuOO0YjyppNDLTNg7g@mail.gmail.com>
 <ZGuTVAj1AJOdTtLF@sashalap>
 <CAHC9VhQ3MmvP9Av9F6mKA03oE-Cima5LMKZbzj6FOZXxtNAYLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ3MmvP9Av9F6mKA03oE-Cima5LMKZbzj6FOZXxtNAYLw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 22, 2023 at 12:34:11PM -0400, Paul Moore wrote:
> On Mon, May 22, 2023 at 12:07 PM Sasha Levin <sashal@kernel.org> wrote:
> > On Fri, May 19, 2023 at 05:51:59PM -0400, Paul Moore wrote:
> > >Hello,
> > >
> > >I would like to request the backport of the commit below to address a
> > >kernel panic in ocfs2 that was identified by Valentin Vidić in this
> > >thread:
> > >
> > >https://lore.kernel.org/linux-security-module/20230401214151.1243189-1-vvidic@valentin-vidic.from.hr
> > >
> > >While Valentin provides his own patch in the original message, the
> > >preferred patch is one that went up to Linus during the last merge
> > >window; Valentin has tested the patch and confirmed that it resolved
> > >the reported problem.
> >
> > How far should this patch be backported?
> 
> The problem is only present when the BPF LSM is enabled, which I
> believe was merged upstream in the v5.7 release, so anything v5.7 or
> later should be affected and thus a good backport target.

Thanks, now queued up.

greg k-h

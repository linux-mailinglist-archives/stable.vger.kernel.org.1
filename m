Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F597973A5
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 17:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjIGP2w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 11:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjIGPV7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 11:21:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F305910FF
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 08:21:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8F08E320014C;
        Thu,  7 Sep 2023 07:25:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 07 Sep 2023 07:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694085951; x=1694172351; bh=W5
        vuJ08TvL1U4+rtaznt8Bmunuc83FEgxq5YkhRFO0U=; b=T2wVvVsSPQ78DfRs0N
        72P5Yi1xovUwOs44PhN7cN7ijyexxaHelbf1BZPFCTeDVgMjmRNYw3I+3Nl6W/Gh
        DZA1ofnxxeZrJmPbE1cMHtM7buw6/A5cBYTD2kqOLi+QTzh2UnHPoegZI91K5udE
        D1I340f/huzSAPiLD7yjuSFdApRZxrB0tg0n4qIOaVQ+iAvs06V3BwBUZ7vt4I7O
        z7ghvRspS3RYRMT6EvsOcdgLueLW60aSjGjYvf58K2uixLcP5Jw6vGRC1Rp9md6o
        j4taEaXMVU7a5BoJ3wFBtyRyZUkMjV04xhQa05FQgvlb7UQFXYgELuaFO2Nn4UOM
        IwKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694085951; x=1694172351; bh=W5vuJ08TvL1U4
        +rtaznt8Bmunuc83FEgxq5YkhRFO0U=; b=FgkGd7ON4oqNlxLjDcENf3++DgmWd
        aIcHEflJ7zTDSiDsFKN3JmWLfo4UtwFnu21EuB2vBwGi6MNY03c9+gE+Ct3ScUVy
        RcZmeg8R5Lry7dwyg7ZxAqIVKMMS7q0a7qSOP4WWqyVqPrWCPGsjwjX+HsLITSv7
        FrEnl+ATYL8IiIoWyimss4at6iScPFRItC+Qx3af9NqhEd9QQ+6V2/Y4GxV8+NsH
        SX+3TjS2EeWRcFup7DlajPJpp7tw/NMX9FZzZWaQuQ8nHLrb2AMqn3tijk5jKmWx
        VWWdDgKNzBahygvxX3q9hf/l4HAZv6oin84w1f+kNpD/3LBdR3vHp7EFA==
X-ME-Sender: <xms:PrP5ZLCG7EFtzWNIJ8UmNv1IOjlZWglHbJ9k_3VwRlpzV2ALEICJDw>
    <xme:PrP5ZBiV7aRXjXkAT20LDGgbLAIDUR4jsJ-STGBzsDysZPVowEBQ4roaPPIsFQs3u
    VBxStxt9u31Kg>
X-ME-Received: <xmr:PrP5ZGljnObXHpwxSJ1AsFN6PbM1Mw_mLq2-GndmpYHxCxi2L5CF9hbdPnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehhedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:PrP5ZNwVlqlPMmyzQcotDtM3nEzWOKNsU2tespNeT_HernjwTwW6qw>
    <xmx:PrP5ZAS7njcrCT53NT01uiJu3r81k4OVlpcvfqzS2vhBKFNq0uhqIQ>
    <xmx:PrP5ZAbVMavy95Znt8ugbXBymnO1CtsxQ3yX5WbeRJ4Kupfov55LnA>
    <xmx:P7P5ZDH4vmkF8Xw5znpeE783Og7ZZbXSz6IvUXxLaSNOrwwVSk0wBw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 07:25:50 -0400 (EDT)
Date:   Thu, 7 Sep 2023 12:25:46 +0100
From:   Greg KH <greg@kroah.com>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     stable@vger.kernel.org, seanjc@google.com,
        christophe.jaillet@wanadoo.fr, lcapitulino@gmail.com
Subject: Re: [PATH 6.1.y 0/2] Backport KVM's nx_huge_pages=never module
 parameter
Message-ID: <2023090738-cartridge-disown-4374@gregkh>
References: <cover.1693593288.git.luizcap@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693593288.git.luizcap@amazon.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 01, 2023 at 06:34:51PM +0000, Luiz Capitulino wrote:
> Hi,
> 
> As part of the mitigation for the iTLB multihit vulnerability, KVM creates
> a worker thread in KVM_CREATE_VM ioctl(). This thread calls
> cgroup_attach_task_all() which takes cgroup_threadgroup_rwsem for writing
> which may incur 100ms+ latency since upstream commit
> 6a010a49b63ac8465851a79185d8deff966f8e1a.
> 
> However, if the CPU is not vulnerable to iTLB multihit one could just
> disable the mitigation (and the worker thread creation) with the
> newly added KVM module parameter nx_huge_pages=never. This avoids the issue
> altogether.
> 
> While there's an alternative solution for this issue already supported
> in 6.1-stable (ie. cgroup's favordynmods), disabling the mitigation in
> KVM is probably preferable if the workload is not impacted by dynamic
> cgroup operations since one doesn't need to decide between the trade-off
> in using favordynmods, the thread creation code path is avoided at
> KVM_CREATE_VM and you avoid creating a thread which does nothing.
> 
> Tests performed:
> 
> * Measured KVM_CREATE_VM latency and confirmed it goes down to less than 1ms
> * We've been performing latency measurements internally w/ this parameter
>   for some weeks now

ALl now queued up, thanks.

greg k-h

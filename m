Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29276754F05
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 16:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjGPOaa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 10:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPOa3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 10:30:29 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C98BE5C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 07:30:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0501E5C00B2;
        Sun, 16 Jul 2023 10:30:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 16 Jul 2023 10:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1689517825; x=1689604225; bh=cs
        Ew+8kxQrH0qyN1LKAzQ6hL6fs+iCzzTII10T/Ph34=; b=pJjgZyvL9q/9ssgwcA
        /8mC3GLP4QAndt8uYEKHLJKiSx9Txm0s3+1SUlQ66vOkeUboTqsZhSR7VE2eeiRR
        g1moSE4uGXnYcqgCeDbMBbO5B/i3S0JR8/VmGUoRN2ie7qScxgg8QUgZ24mLuLc8
        fzEfg7+0C+ZS3XtAVzvy9ierD4ON6lBdDjCq8S1qjqA4HhMd5LqSylPtYtWCVo9e
        lrQ0jNVhGBXyXXLnrQU/V/itm+2xlvn12jMQqYHzgSQSuFKNkeSTD9coxeEKDpJy
        hkK8k8ByIUB1O0BISz30ZW5yar4jeh+1n2s8dm2N2CDU+Wj35Ut55tuz7oDPqu6t
        e7+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689517825; x=1689604225; bh=csEw+8kxQrH0q
        yN1LKAzQ6hL6fs+iCzzTII10T/Ph34=; b=LsePfGGc2ulU7r1Ys1Dgm1aoWbZEm
        ErjXDtXYFI45q/k4hR65HugdjcxsPsFlYgC6yTfQAkSM4/hlG10HlYYdGdNOI5J3
        x3BqVGknP/mPoSXHLubvVya9n9PvGGG5JDoVAFM+L4SgOMTr1IkCYAIZ6Ipcuc6e
        80M861WbzsYdhWAaF7NQKpytFyHiU2T2/CKtwqe9TfVov/KMJZi3NfD6b+7XfRsI
        4klhIHQXjyhRxW62doBfkoGHOuIwknOoFe0p+9o4QXIB7ZZBSFM80lhM4gspWeoO
        QLenbUV1UJodm9jaHcr5oIAuuAtIwmDvzhsYl36TugaB8614i0bDe3OHQ==
X-ME-Sender: <xms:Af-zZGvjInbtFYmyWR_d1XfK-EPQy_4QUCBiHIeArlL11O93JjtZdw>
    <xme:Af-zZLcSx11fletcCBvpahJTkptBPl_zihAtFZSGHn0unSOFIh4W2iP_XJVROPNe5
    d-ndRvcljTzwQ>
X-ME-Received: <xmr:Af-zZBy6p7LYJ9vMGUOETpmgmL1LJgT959eO0mwH8RD3Wku2GglJkh7vf2WJ3iLjb3cs9kLYTe763IrDeb27mhkbGVvcqEGkr6LZ9-9g2Kk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:Af-zZBPSUuFoXSvHSYwlJ0IReaQTSQe_U9ZsNRT5A8Rny66QKYF9dw>
    <xmx:Af-zZG9IyLiMqVuWeoABkZaHeTFiHfPJwj7mXsyAGCrnIx3_Rei18w>
    <xmx:Af-zZJUtlSd51PRLmLdPad4NukC_MQLm8s1ccYV_fKKIBzKFRXd3qg>
    <xmx:Af-zZGz5ixwzkZmRQpc5Y2L1IQUMbYUX4l59OoWcHMPpuoekQboSpA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jul 2023 10:30:24 -0400 (EDT)
Date:   Sun, 16 Jul 2023 16:30:23 +0200
From:   Greg KH <greg@kroah.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, stable <stable@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: Build failures / crashes in stable queue branches
Message-ID: <2023071613-conceded-dilute-5e31@gregkh>
References: <897ebb05-5a1f-e353-8877-49721c52d065@roeck-us.net>
 <20230715154923.GA2193946@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715154923.GA2193946@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jul 15, 2023 at 03:49:23PM +0000, Joel Fernandes wrote:
> Hi Yu,
> 
> On Fri, Jul 14, 2023 at 03:21:46AM -0700, Guenter Roeck wrote:
> [..]
> > ---------
> > 6.1.y:
> > 
> > Build reference: v6.1.38-393-gb6386e7314b4
> > Compiler version: alpha-linux-gcc (GCC) 11.4.0
> > Assembler version: GNU assembler (GNU Binutils) 2.40
> > 
> > Building alpha:allmodconfig ... failed
> > Building m68k:allmodconfig ... failed
> > --------------
> > Error log:
> > <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> > In file included from block/genhd.c:28:
> > block/genhd.c: In function 'disk_release':
> > include/linux/blktrace_api.h:88:57: error: statement with no effect [-Werror=unused-value]
> >    88 | # define blk_trace_remove(q)                            (-ENOTTY)
> >       |                                                         ^
> > block/genhd.c:1185:9: note: in expansion of macro 'blk_trace_remove'
> >  1185 |         blk_trace_remove(disk->queue);
> 
> 6.1 stable is broken and gives build warning without:
> 
> cbe7cff4a76b ("blktrace: use inline function for blk_trace_remove() while blktrace is disabled")
> 
> Could you please submit it to stable for 6.1? (I could have done that but it
> looks like you already backported related patches so its best for you to do
> it, thanks for your help!).

Now queued up, thanks.

greg k-h

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462767D118C
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377566AbjJTO0S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377541AbjJTO0R (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 10:26:17 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E655D46
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 07:26:16 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F1105C0042;
        Fri, 20 Oct 2023 10:26:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 20 Oct 2023 10:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1697811974; x=1697898374; bh=G/
        fVVtLpNYGftdgvme4fPbv7NdM7aExnw/qSXxf8Cio=; b=TVT+u+/vdyTJVsA9ge
        Q23c5tL5uXlvLg58DJv8d4h0RZhE+OkAanW/Ky1gDLlsWZiLzlsnWV67BUJaURL7
        eNMQN51asRoATxFYlbBdwYqAfs5XrGx3wLrVZFGrdd1RmU58wE9dsYC89aYUFT/f
        KAT6TT5Qf4FZI4XKIa5yqdQzJsUGqo3HACo2QvTSrfaod3+rdVp8tgXWC9TG1myX
        Fgm5xyuRc5z4I+d6dwj4cLARcrDDuyEoXKC15J2q2DWJJELS4v9dPqMQJP6vDSNN
        nFZSCj3jncQY+qqANbF5f3CuXEf2OEauMEcn+Em6LKI1sj/nkdngOVrrZyfxHYbJ
        egpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697811974; x=1697898374; bh=G/fVVtLpNYGft
        dgvme4fPbv7NdM7aExnw/qSXxf8Cio=; b=XCWk/2TcfUHc5pE27S5hegJKcinMQ
        QA+u6Y95on1pBiU4B0K7yjMYF3kmkPnhOwk48cyFChW+0Kn1+MYB8Z45Pe5OUF16
        w1dehPoAIBE/bCqWimCbPSCgK923SJQfSooh0wgltUfbPn8AoxE8bc3S/BDwbv11
        COQTnV2gPpmKIYYFjZd2K9RMwHVBjInhQfYVZxoCr8C31A6/R7POUteuV20LICb/
        k5r8BNdBg07I6TsFW7nRDdyIMFkSTbaWqcrmMN55KbuMaWdO4TTa//aC2tlZqxKW
        LQrxdhdh2FZouYc4wQf9wpcGxyl/G34wCxk8Vkt2rEO0YuZx2s3yBudtA==
X-ME-Sender: <xms:BY4yZZuV2BrUoosKY-Us_TrzA9TsbuMY2oxvXNkpTe_HUObMM00Qbw>
    <xme:BY4yZScRe6FiD-gbA0HacBLTw_w6T3zOenrUaASbfeVtu0_6HE2MgwXQq4k0dv7UP
    0cMy8Uf0NhX1g>
X-ME-Received: <xmr:BY4yZcyvI-ykzMwrJJUzFgxnID6YU9U3eKGHvxJvlzlmYysq5VLilAOKsHNsqKbhl30ppin1utXwtnr9jEzbgWYK5UO3sfhcLsVqAKfN86M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejue
    fhtdeufefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:BY4yZQOOFtjkG_NxQNdOmebwfqHzOolA9ekaXSvtv60ZZoXLFQogew>
    <xmx:BY4yZZ_tOAblyWzeMz-gB1gCCPZYMIEWs5OIsif5Sub3zGLex4qW9w>
    <xmx:BY4yZQWjND3TwpgFzY_lFIxdeV3YHjE_38t0BxbF5pALiJOqhPMwbA>
    <xmx:Bo4yZVbVTB6lUdoY5uin_Plz_P0EChgS3-tgYbFlkrno8UurftFqGw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Oct 2023 10:26:13 -0400 (EDT)
Date:   Fri, 20 Oct 2023 16:26:09 +0200
From:   Greg KH <greg@kroah.com>
To:     pjy@amazon.com
Cc:     stable@vger.kernel.org, lmark@codeaurora.org
Subject: Re: Backport commit 786dee864804 ("mm/memory_hotplug: rate limit
 page migration warnings")
Message-ID: <2023102001-vision-preorder-3853@gregkh>
References: <mb61p4jiltmty.fsf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61p4jiltmty.fsf@amazon.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 20, 2023 at 02:01:13PM +0000, pjy@amazon.com wrote:
> 
> Please backport commit 786dee864804 ("mm/memory_hotplug: ratelimit page
> migration warnings") to 5.10 stable branch.
> 
> Commit message:
> """
> When offlining memory the system can attempt to migrate a lot of pages, if
> there are problems with migration this can flood the logs.  Printing all
> the data hogs the CPU and cause some RT threads to run for a long time,
> which may have some bad consequences.
> 
> Rate limit the page migration warnings in order to avoid this.
> """
> 
> We are sometimes seeing RCU stalls while offlining memory with the 5.10
> kernel due to the printing of these messages.
> 
> Applying this patch solves the problem by ratelimiting the prints.

Now queued up, thanks.

greg k-h

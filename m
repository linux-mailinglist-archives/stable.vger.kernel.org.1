Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF9756AAD
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 19:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjGQRd3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 13:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjGQRd1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 13:33:27 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938C9BD
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 10:33:24 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 34401320095B;
        Mon, 17 Jul 2023 13:33:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 17 Jul 2023 13:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1689615200; x=1689701600; bh=H0
        FVCc7wNWZqSqf0OwGUespKLuGWz7Ur0/s0EDkSaMQ=; b=I1iMLvnE8aOyhYOxG7
        1sfRLkXgQWVatPXNbJtZHY+6zYIosruTIPQ3qnmdqnR3uhkrdgvG/OAVSxEmOgyO
        lG37DiuftdUCCU6bFC5EfCl+CiLZIRYsgWWIHqmFdji7dbd5REBuHrfOBXjifGP5
        cQyNJaSqRfqILhLUvQ4s9doBUFj89wCvIzOlEYjd/SFiV/IqtYwoMwV9RMLsWbYD
        HpOeOYNaDI4U16+Il6CmVjPZ4jIKXkvcTqrBF3PIPJXH6NdITm1slXGJyx4k4hir
        LzXNJ2StLF2W5L+broTZmffZYKgNejLOokmbpKyeO8dDHfzXgJH7T+hq6PCt9w6T
        jmZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689615200; x=1689701600; bh=H0FVCc7wNWZqS
        qf0OwGUespKLuGWz7Ur0/s0EDkSaMQ=; b=iWLVKWYBXnd7XKiUGGSK+dnQ5Rv3B
        xQWD+QGvgJiIuM3G0PvuM6l7mNGICSo0ytlsVwisXuOx8sZeyeMj4y8pViX6ZGyQ
        xBG9bwVRYFHWfjZJU1L/NWOg0ZrwBFz2BhyQOAwknLL6D+Gakbb7uJRk8kr5BCE9
        uj7Hv5cKCYj6Q6YitFH7mB7P8wfnrVOe/6JVzmrJn44xEIpa4V/WQOZ+mmMT0L0d
        MoOtObzGbh3gW2mw1VOkVg+Y4nuMVFpLXmfLlbBxdmWwAwbhlQwfbpnGobDBKixb
        oyzbvyfnMANTcN+tPQ5yiqKCSrszp2gyH+2azQnNrKgAx0t9wyIxoBdhA==
X-ME-Sender: <xms:YHu1ZGwzuOn7xt_gfimdS01qhPBFh_MJ9epW9dcP3_Wmi9clE9FsZw>
    <xme:YHu1ZCQJJ1ny1BvpjB25bl492zeg1nGSGqhd8cv3g1sik1HbT1RkE3cb_hcyCdE2Z
    C8_PL8b4GZyFaUV0Q>
X-ME-Received: <xmr:YHu1ZIWUZaQg7H5cL-VckxLzrSLGqHmjJV0QTcsXdYYohqhFQg08fIHZQxzplXmPCHw-BHUMjSBTHgn0SPTi0MK-puf1hB4mjnRrolEAOfVaSvnVHrr317veldc3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedvgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepvdfffeevhfetveffgeeiteefhfdtvdffjeevhfeuteegleduheetvedu
    ieettddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:YHu1ZMgmL8jni9_X13YdRzMpmKmBgEd0gyGee62PhdS7JQwJGW3lMw>
    <xmx:YHu1ZID3jgVJOXpjca_IQqg5dcJ9bHO77TktpgZLmTX8ZPyXyehG3w>
    <xmx:YHu1ZNL9InvMBeKVrrXEsVFxYj1TT_FZ9TTueypRTXvCjqlrcmCEMg>
    <xmx:YHu1ZLN0cYUvWA-Ds9MJco_ZQKehW0rGULj3sz8GRCzZyVj2zhSaVw>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jul 2023 13:33:20 -0400 (EDT)
Date:   Mon, 17 Jul 2023 10:33:18 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     gregkh@linuxfoundation.org, asml.silence@gmail.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: Use io_schedule* in cqring
 wait" failed to apply to 6.1-stable tree
Message-ID: <20230717173318.3ljqkezy3i3oatin@awork3.anarazel.de>
References: <2023071620-litigate-debunk-939a@gregkh>
 <0cfb74bb-c203-39a1-eab7-abeeae724b68@kernel.dk>
 <222ae139-33a6-a522-0deb-dcdf044edd19@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <222ae139-33a6-a522-0deb-dcdf044edd19@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 2023-07-17 10:39:51 -0600, Jens Axboe wrote:
> And here's a corrected one for 6.1.

Thanks! LGTM.

Greetings,

Andres Freund

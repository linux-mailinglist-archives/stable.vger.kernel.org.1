Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5473702CE9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbjEOMlP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbjEOMjc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:39:32 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6F419B6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:39:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1F9233200916;
        Mon, 15 May 2023 08:39:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 May 2023 08:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1684154345; x=1684240745; bh=FVJRjDLUKG0jCpi+tR+n7Ktrm2inpLL0hZQ
        6oGbw+ww=; b=MLauwyQ2QhVyxiGQNcJel/s0uWSxsfmiMllQFvWtXmI90d9ajto
        ID/7rsQOyGdbisDUMVCoe8DElPTnB9kQqlAEO+CktAgxgPMrqp/hM0GGX4IWdd12
        u/HeANAC4TYwrVAxKIbBYY+qs53QNcmBRezCobOGluqqIY09KbRZCFds/ukmzfeO
        QNV/38gs1AYkbAVtBV63sH5DV+5T1GxagxZ4TTb/eBIj+4y/+R6r+6OYgLJZSOw3
        ct1cbPnpb8TFiWv4SsYINzGasFRNxJiZqG5nybkXAKGw3wqhgeTiNPY8X4vrdLFO
        QjQV7jFbB2iBenFf4oxAkP+LDf5Fwdh2L2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684154345; x=1684240745; bh=FVJRjDLUKG0jCpi+tR+n7Ktrm2inpLL0hZQ
        6oGbw+ww=; b=ynqBoz9MXCZBHwMghlnaaTI6WSlW631LIXVr6qspBUmr/QKnYZN
        QwZc6yHrKJMI+TYn14RxkWMJ2rhnmB6IgNN9o/1rH95JQopL3FNIfksES31dgBG/
        0893zalkYdGWmq9PNtEtR0JHmS7ygY1hOySzp0woRyL8UcaeZJiQ91uyWuUPih+C
        FbAjvoMrjs/yN1kHgxWFNHK+qz+4MLonnCC7MJ8bbPrHMsmXCw4LLWVo/nU2pnOS
        7wrQJWsK8ii8Uc/mgZwlRAve85qzETDGZvc+ax5TJnuJAQTHQE6Gs6KqrXkqDldg
        7dRHvUkvLYPL0M2S2a6MjBizlxZB3QKLdRA==
X-ME-Sender: <xms:6SdiZDyXLuZKB_p1FSDASJuC4ZXazIhlRKRE-z6lcxlwJnEzusRyIg>
    <xme:6SdiZLRo_JiOvZHv7aCU7JzNI4V0zlRiinh-UFRHah9yaCCaKvxptT1h9wpRFkFYp
    yB9e9A5tvAZwg>
X-ME-Received: <xmr:6SdiZNWk2n61E0l0kCCETdiykHbcbBWiKZ9EgZ93F_I8STcvGX6wGN5i33hQEB0NJg1XrnqaoDdz7d8aywh_e1cn4yuS2FV6ov9Xqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegve
    evtefgveejffffveeluefhjeefgeeuveeftedujedufeduteejtddtheeuffenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:6SdiZNj4bmJnKKmD-WzEspHV4lcsI6tLd_JrSdD6SsVzrsHEIbgCOA>
    <xmx:6SdiZFDINZBnThB7Ve8_UqkiI8feoNW5RelldBQUuH1AZEmmoGa8RQ>
    <xmx:6SdiZGLGhEPjtgQzV2zwb9nHJnjXnVYAeTTG76OE5nYovW1fpCQtFA>
    <xmx:6SdiZJ4O312jNAiZsn0lRivIR3kQ1EcOvb3Cn4seA9HpCDIGtnD3lQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 08:39:04 -0400 (EDT)
Date:   Mon, 15 May 2023 14:39:01 +0200
From:   Greg KH <greg@kroah.com>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Thomas Voegtle <tv@lio96.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5.15.y] drbd: correctly submit flush bio on barrier
Message-ID: <2023051554-bundle-gravity-08ca@gregkh>
References: <2023050708-absently-subsidy-099a@gregkh>
 <20230508105547.66993-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230508105547.66993-1-christoph.boehmwalder@linbit.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 08, 2023 at 12:55:47PM +0200, Christoph Böhmwalder wrote:
> When we receive a flush command (or "barrier" in DRBD), we currently use
> a REQ_OP_FLUSH with the REQ_PREFLUSH flag set.
> 
> The correct way to submit a flush bio is by using a REQ_OP_WRITE without
> any data, and set the REQ_PREFLUSH flag.
> 
> Since commit b4a6bb3a67aa ("block: add a sanity check for non-write
> flush/fua bios"), this triggers a warning in the block layer, but this
> has been broken for quite some time before that.
> 
> So use the correct set of flags to actually make the flush happen.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: stable@vger.kernel.org
> Fixes: f9ff0da56437 ("drbd: allow parallel flushes for multi-volume resources")
> Reported-by: Thomas Voegtle <tv@lio96.de>
> Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/r/20230503121937.17232-1-christoph.boehmwalder@linbit.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> (cherry picked from commit 3899d94e3831ee07ea6821c032dc297aec80586a)
> Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
> ---
>  drivers/block/drbd/drbd_receiver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All now queued up, thanks!

greg k-h

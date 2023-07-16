Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5E17550DB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGPTLR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPTLQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:11:16 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B149F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:11:15 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BD0115C0090;
        Sun, 16 Jul 2023 15:11:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 16 Jul 2023 15:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1689534674; x=1689621074; bh=kP
        /RcOeOYT+8hoSSNd292f4CaPhvr0jncH4UwzD64Y4=; b=cv25O+T/fMEA5axs7o
        8iJhu/k6R8yyGs6VimRpky9Oy5saCMpkZIbdhUqeikoE7dtCL0Q3O7F6rcOXETUy
        G3ySHpZf4S6SV1DnG5qkKEhTxgtFcy0hUm0PCnNoiGpvtB6DJ3+IFLRmrqgBUz7M
        va+yIgXJpEAW6uhQaA9IW6Ll4mM2+rUUHCWKAkITTM7fNI249XN3YgTxw4Z0PohY
        U/gyM0YcmNnfsednXx67SbFesMGAFSSP9vYAxfxOPdyuLx6V1G1Uhys+zcGOj2KD
        Bas/po22AwtpUgVcB+kFsA0vC2rraGxLsViCrQy1xgR8w5x5l3sCFOjAvFD6/oar
        2qJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689534674; x=1689621074; bh=kP/RcOeOYT+8h
        oSSNd292f4CaPhvr0jncH4UwzD64Y4=; b=ukTYEwIc7jJ90oevQDxGKQUnPDywb
        2YWby0HWxuZdqv4fzQndqolvpE9WOWK7RfXmRTisVD7uvjoTnwHyUmC0I8HtVJ5t
        89D/nb6Hcgwu852JPPHroaqVuSElQhBdznwDaJ6afBQhDF5K0U4MZampdVpPMdHC
        q0nIGcyreRi7oQ3QsesA2fV24eQ628V719AGfUeci1NXiJMCdH/uV5vVLl6Mxl1x
        F7PtSenVDJ9Mc75N8HekqRATu9REFBUBXCZloQ3Vrn//WQQd1nNAbR1FZOCgkRic
        jLVoAO2EqqKcOPBv4xDWkwCjRUQ8Y6mulIAiDYXTKt80kgLdXbVns5E6w==
X-ME-Sender: <xms:0kC0ZMb3JoO6UUR39u7Vfkyj3gOlwhENHEsJKDu1S3zVwdz12iDouw>
    <xme:0kC0ZHZ_sUDG1WyJfGFW4oqFHl2s5V1E4omYsHLGEQf7x1tarj4Yf0FSFbpl_CTya
    3Yga2wdLp3SBK0RBQ>
X-ME-Received: <xmr:0kC0ZG-hP9AbxFkrUw9Q9enpkIZ7Kyq19TrodLsPLBPkVvIDKYfEMeSGZzt1goRHoW9cdEeVvg-NvBYkU3O2yDSo3i9OG8ZUXryA9Yg2FR-Fup-MrDB9u--yOhAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedtgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepvdfffeevhfetveffgeeiteefhfdtvdffjeevhfeuteegleduheetvedu
    ieettddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:0kC0ZGriWC-Yy2dHaCDcTkLzqo3R4xIj2tnS3N1HObl4IPGKNg4DAw>
    <xmx:0kC0ZHpnP-aIGaXs-mDChJ2gnAxaKBM2yo_9Y830b3qK8BcsT4tBfg>
    <xmx:0kC0ZERHVbFFfBqYPoDuKhRp2kfFR08LTcajoN-wd-YbJw17jM3mEw>
    <xmx:0kC0ZO0p3oaMdU87Vspy-36eifIHRzVQngcV90s5e38ccunE_Dqhdg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jul 2023 15:11:14 -0400 (EDT)
Date:   Sun, 16 Jul 2023 12:11:13 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     gregkh@linuxfoundation.org, asml.silence@gmail.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: Use io_schedule* in cqring
 wait" failed to apply to 6.1-stable tree
Message-ID: <20230716191113.waiypudo6iqwsm56@awork3.anarazel.de>
References: <2023071620-litigate-debunk-939a@gregkh>
 <0cfb74bb-c203-39a1-eab7-abeeae724b68@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cfb74bb-c203-39a1-eab7-abeeae724b68@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 2023-07-16 12:13:45 -0600, Jens Axboe wrote:
> Here's one for 6.1-stable.

Thanks for working on that!


> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index cc35aba1e495..de117d3424b2 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -2346,7 +2346,7 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
>  					  struct io_wait_queue *iowq,
>  					  ktime_t *timeout)
>  {
> -	int ret;
> +	int token, ret;
>  	unsigned long check_cq;
>  
>  	/* make sure we run task_work before checking for signals */
> @@ -2362,9 +2362,18 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
>  		if (check_cq & BIT(IO_CHECK_CQ_DROPPED_BIT))
>  			return -EBADR;
>  	}
> +
> +	/*
> +	 * Use io_schedule_prepare/finish, so cpufreq can take into account
> +	 * that the task is waiting for IO - turns out to be important for low
> +	 * QD IO.
> +	 */
> +	token = io_schedule_prepare();
> +	ret = 0;
>  	if (!schedule_hrtimeout(timeout, HRTIMER_MODE_ABS))
> -		return -ETIME;
> -	return 1;
> +		ret = -ETIME;
> +	io_schedule_finish(token);
> +	return ret;
>  }

To me it looks like this might have changed more than intended? Previously
io_cqring_wait_schedule() returned 0 in case schedule_hrtimeout() returned
non-zero, now io_cqring_wait_schedule() returns 1 in that case?  Am I missing
something?

Greetings,

Andres Freund

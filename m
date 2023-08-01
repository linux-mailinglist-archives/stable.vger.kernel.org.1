Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8476AA54
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 09:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjHAHzJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 03:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHAHzI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 03:55:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23711BF0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 00:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C043614A8
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 07:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DE8C433C8;
        Tue,  1 Aug 2023 07:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690876505;
        bh=1zVwhW5PMgK21DnNaLkUhBPQprGz49gvjOukX6X2Uqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6ZepanOKPP0l2oKnCjGn3+mjZaeO25MP1TOnTqC49MoMsAfmaNfw7TQHNNXJYv1F
         fyBh3ta0rNHxJPs/BC1OH3jEu85bBdIlJEeC1VmQQqJiITum85jfMoWBvax8t7M07S
         h6efuHZ7klQ9kK5gbBUheppbSRZ895fzlXymn0HY=
Date:   Tue, 1 Aug 2023 09:55:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: treat -EAGAIN for REQ_F_NOWAIT
 as final for io-wq" failed to apply to 5.15-stable tree
Message-ID: <2023080153-shadow-annoying-4fcc@gregkh>
References: <2023072352-cage-carnage-b38a@gregkh>
 <5d947e59-19a1-7844-c60b-d8408333c1b3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d947e59-19a1-7844-c60b-d8408333c1b3@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 24, 2023 at 12:38:50PM -0600, Jens Axboe wrote:
> On 7/23/23 6:54 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x a9be202269580ca611c6cebac90eaf1795497800
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072352-cage-carnage-b38a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Here's a tested backport for 5.10-stable and 5.15-stable. Thanks!

Now queued up, sorry for the delay.

greg k-h

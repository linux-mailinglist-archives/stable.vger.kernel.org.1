Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ADA755046
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 20:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjGPSXo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 14:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPSXn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 14:23:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C27719F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 11:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ABD660C40
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 18:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465A2C433C8;
        Sun, 16 Jul 2023 18:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689531821;
        bh=xwn/RUyb+UJmkZYI2mr5+MrEUgzoU3uQY6ikZAs1VoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zd5+YN5wJOyUd9aoz6oQ9OtUqSr4TNbYec3A9PDxx+1RvZC6Za3YvE57W+OmuVZjA
         +Hz6EIuInKHzeKXobd3LS80U84xLDKYXItxxf9FegjNNW+oTiYTAYLEiMEav53oWa1
         Gil8v292oVbDpqU/l50AgKs2nBdPPUXAvma8xxbA=
Date:   Sun, 16 Jul 2023 20:23:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     andres@anarazel.de, asml.silence@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: Use io_schedule* in cqring
 wait" failed to apply to 5.10-stable tree
Message-ID: <2023071629-series-goggles-ab8f@gregkh>
References: <2023071623-deafness-gargle-5297@gregkh>
 <e139b7d2-5105-88bf-d687-57f57813ad5b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e139b7d2-5105-88bf-d687-57f57813ad5b@kernel.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 16, 2023 at 12:08:11PM -0600, Jens Axboe wrote:
> On 7/16/23 2:41 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.10-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 8a796565cec3601071cbbd27d6304e202019d014
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071623-deafness-gargle-5297@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
> 
> Here's one for 5.10-stable and 5.15-stable.

All now queued up, thanks!

greg k-h

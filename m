Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E0B77A109
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHLQ2y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 12:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjHLQ2x (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 12:28:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B2C1BEE
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 09:28:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBC4961FED
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 16:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAFDC433C8;
        Sat, 12 Aug 2023 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691857736;
        bh=PvUCO4UNhIYwKiYWKtm9FueSWdFPZXv89XLTivdk3tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4JE5szf7NO8F2kw7zI5rvXueIZ+/HVqP6CcyXG0VlEQGvj/7S0y5W7+AqBWJxU5o
         vcrYyR/A1FW4X63AI8f9LYVe9LR2mhJSF92VxwNFRI+jZBj6maATPCqvuwsLmVUOo7
         oWHRFcpyzWSn8uuVZNfTg64Su4XxUY35RmggunAo=
Date:   Sat, 12 Aug 2023 18:28:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     cyphar@cyphar.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: correct check for O_TMPFILE"
 failed to apply to 5.15-stable tree
Message-ID: <2023081246-pledge-record-7c35@gregkh>
References: <2023081258-sturdy-retying-2572@gregkh>
 <ec4f5e8f-d1db-4278-a144-ddedca0ae5ca@kernel.dk>
 <b2efb91d-6b4b-40fa-bbc9-9511d0a70f27@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2efb91d-6b4b-40fa-bbc9-9511d0a70f27@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Aug 12, 2023 at 07:33:03AM -0600, Jens Axboe wrote:
> On 8/12/23 7:20 AM, Jens Axboe wrote:
> > On 8/12/23 12:02 AM, gregkh@linuxfoundation.org wrote:
> >>
> >> The patch below does not apply to the 5.15-stable tree.
> >> If someone wants it applied there, or to any other stable or longterm
> >> tree, then please email the backport, including the original git commit
> >> id to <stable@vger.kernel.org>.
> >>
> >> To reproduce the conflict and resubmit, you may use the following commands:
> >>
> >> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> >> git checkout FETCH_HEAD
> >> git cherry-pick -x 72dbde0f2afbe4af8e8595a89c650ae6b9d9c36f
> >> # <resolve conflicts, build, test, etc.>
> >> git commit -s
> >> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081258-sturdy-retying-2572@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> > 
> > Here's one for 5.15-stable.
> 
> Oh, and the 5.15-stable one also applies to 5.10-stable. 5.10-stable
> needs it as well, would be great if you could queue it up there as well.

All now queued up, thanks!

greg k-h

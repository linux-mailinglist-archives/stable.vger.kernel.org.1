Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8876FE64
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 12:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjHDKZZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 06:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjHDKZY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 06:25:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B9D49DA
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 03:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8D0461EF8
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 10:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF03C433C7;
        Fri,  4 Aug 2023 10:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691144718;
        bh=AdZbBOmPeP3lw5z1vCRP0Q3buyiyEPVzMXT9YFDdvro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G07woGCgjt9pCao1Wx4MP+a8f6jhDNRcrDyPQSlOXFypqg7gWb4kMqHVJ5qty9ATK
         vl5adD9CS1JHsOZP7eUbmFaB15lz1QcxJDFxboDdPayc0n/osDXyVeLg6++Alhix7H
         EVD7HMOrLottFhTzuEyx7gtCe2RconWjXP4uGuzM=
Date:   Fri, 4 Aug 2023 12:25:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     andres@anarazel.de, oleksandr@natalenko.name, phil@raspberrypi.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: gate iowait schedule on having
 pending requests" failed to apply to 6.1-stable tree
Message-ID: <2023080407-snowless-delirious-bf7f@gregkh>
References: <2023080153-turkey-reload-8fa7@gregkh>
 <c2516403-4aff-375b-a519-9fb815c7d4bb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2516403-4aff-375b-a519-9fb815c7d4bb@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 01, 2023 at 08:48:36AM -0600, Jens Axboe wrote:
> On 7/31/23 11:53 PM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 7b72d661f1f2f950ab8c12de7e2bc48bdac8ed69
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080153-turkey-reload-8fa7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Here's one that applies to 6.1-stable.

All now queued up, thanks.

greg k-h

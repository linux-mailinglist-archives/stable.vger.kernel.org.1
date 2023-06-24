Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7451473CB3D
	for <lists+stable@lfdr.de>; Sat, 24 Jun 2023 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjFXOID (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 24 Jun 2023 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjFXOIC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Jun 2023 10:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DE21BC2
        for <stable@vger.kernel.org>; Sat, 24 Jun 2023 07:08:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B19E660670
        for <stable@vger.kernel.org>; Sat, 24 Jun 2023 14:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2837C433C8;
        Sat, 24 Jun 2023 14:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687615681;
        bh=JQgxy26KNnDM/ExgwNxFUZifjFIK5EqkU4e32yGJx3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qj8KM+dcMQYqI2sfyHCmgrdkiSqlD/wqHw0odivl3MSmrSrUqxfuvvkrtkBKuaKuX
         +iLAqZfMkmemB2nCTTETBYZxnGaPvzqR8XRP9PV7CevzbdudWfOukhAzNRrLG37XyP
         H5vkFiJCxfCgGahQ1b14ALpCM1/HkR6EBqg+TF+E=
Date:   Sat, 24 Jun 2023 16:07:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     marek@cloudflare.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/net: save msghdr->msg_control
 for retries" failed to apply to 5.10-stable tree
Message-ID: <2023062450-moonlike-lark-6369@gregkh>
References: <2023061721-shaft-lion-f22c@gregkh>
 <8b2f4b74-0a5c-c2c8-de45-81ce47a4ad74@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b2f4b74-0a5c-c2c8-de45-81ce47a4ad74@kernel.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 23, 2023 at 07:47:20AM -0600, Jens Axboe wrote:
> On 6/17/23 2:11?AM, gregkh@linuxfoundation.org wrote:
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
> > git cherry-pick -x cac9e4418f4cbd548ccb065b3adcafe073f7f7d2
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061721-shaft-lion-f22c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
> 
> Greg, here's this (and the two followup patches that I just emailed
> about), for the 5.10-stable and 5.15-stable branches. Thanks!

All now queued up, thanks.

greg k-h

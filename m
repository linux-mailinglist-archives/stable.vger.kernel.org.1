Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3991738EF6
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 20:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFUSjV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 14:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFUSjV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 14:39:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694CB10A
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC85D6167F
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 18:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ABEC433CD;
        Wed, 21 Jun 2023 18:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687372759;
        bh=OqQ8gMPXXATCT1HWawcIGul+R7hst+qOHy6bIDKpCtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPdQezVLY7QgHAbDKGMlZoJZwIFXVcB9W0j7WD/4Mup8iW2QGV1LBJFdQl6NLHr8n
         YVHcu5GosNx6Q+kUH0w2xooq+V/DAALiJqfbSGL6fYB8qhIjqPr6RWW1MqIqPGH4kx
         3OqK1cILHV/dqxrsozH0J8bw0ao5f6m/u9tSWWMQ=
Date:   Wed, 21 Jun 2023 20:39:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     stable@vger.kernel.org,
        "Janne Huttunen (Nokia)" <janne.huttunen@nokia.com>
Subject: Re: Request for backport 4.19 for the IPMI driver
Message-ID: <2023062157-relic-rogue-65a2@gregkh>
References: <ZJGWHhJJeuiP1H18@mail.minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJGWHhJJeuiP1H18@mail.minyard.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 20, 2023 at 07:05:50AM -0500, Corey Minyard wrote:
> Please backport the following changes to the 4.18 stable kernel:
> 
>   e1891cffd4c4 "ipmi: Make the smi watcher be disabled immediately when not needed"
>   383035211c79 "ipmi: move message error checking to avoid deadlock"
> 
> e1891cffd4c4 doesn't apply completely cleanly because of other changes,
> but you just need to leave in the free_user_work() function and delete
> the other function in the conflict.  I can also supply a patch if
> necessary.
> 
> Change
> 
>   b4a34aa6d "ipmi: Fix how the lower layers are told to watch for messages"
> 
> was backported to fullfill a dependency for another backport, but there
> was another change:
> 
>   e1891cffd4c4 "ipmi: Make the smi watcher be disabled immediately when not needed"
> 
> That is needed to avoid calling a lower layer function with
> xmit_msgs_lock held.  In addition to that, you will also need:
> 
>   383035211c79 "ipmi: move message error checking to avoid deadlock"
> 
> to fix a bug in that change.
> 
> e1891cffd4c4 came in 5.1 and 383035211c79 came in 5.4 (and I believe was
> backported) so everything should be good for 5.4 and later.  b4a34aa6d
> was not backported to 4.14, so it is also ok.  So 4.19 is the only
> kernel that needs the change.
> 
> Thanks to Janne Huttunen for quick work on this.

Thanks for this, both now queued up.

greg k-h

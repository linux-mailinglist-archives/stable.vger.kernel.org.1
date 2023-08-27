Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D02789C67
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 10:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjH0I5G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 04:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjH0I4v (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 04:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18659D
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 01:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75D8A6125C
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 08:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A078C433C8;
        Sun, 27 Aug 2023 08:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693126607;
        bh=JIao+jkXiGSHbiXu9T5ZKWN5iAUyVj3jAeV0pgTbkAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8YvUc2KL5ZuiCB4X1oJqPtZiA0jeR9v7at8aoGLDWFjYhG806L1sEAVLJQaIKgku
         ul+X8F+FeWWCZRhvK07C/9zeOoB4uzmNJ/D6k0wuBkGclZfmgsxr4Db3mhJKhsuSEY
         9qPns7bLDXgkyTTQKFEootiCFfNLJB14QFwYcPnQ=
Date:   Sun, 27 Aug 2023 10:56:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     tytso@mit.edu, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ext4: fix off by one issue in" failed to
 apply to 6.4-stable tree
Message-ID: <2023082751-plank-panning-b103@gregkh>
References: <2023072456-starting-gauging-768c@gregkh>
 <ZOR89j3sqHdhxc31@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOR89j3sqHdhxc31@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 22, 2023 at 02:46:38PM +0530, Ojaswin Mujoo wrote:
> On Mon, Jul 24, 2023 at 08:17:57AM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.4-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 5d5460fa7932bed3a9082a6a8852cfbdb46acbe8
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072456-starting-gauging-768c@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Hi Greg, Ted,
> 
> Sorry for being late on this, I was off for a good part of this month.
> 
> So i got multiple such FAILUREs from different stable trees for this
> particular patch (linked at end), but seems like these trees don't even
> have the patch pointed by Fixes tag.
> 
> Although we can safely ignore backporting this, I just wanted to check
> why did I get these false failures so I can avoid it in the future.
> I was thinking that we would automatically check the fixes tag to see
> which trees need the backport? Is that not the case?

The fixes tag in this commit:
	> > Fixes: 33122aa930 ("ext4: Add allocation criteria 1.5 (CR1_5)")

References a commit id that is not in Linus's tree, so I have to guess.

Please use valid git ids in your Fixes: line and this will not happen in
the future.

thanks,

greg k-h

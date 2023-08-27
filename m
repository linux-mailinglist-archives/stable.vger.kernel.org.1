Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B764C789C68
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 10:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjH0I5i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 04:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjH0I50 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 04:57:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759CA9C
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 01:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B7BA612D5
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 08:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E56C433C7;
        Sun, 27 Aug 2023 08:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693126643;
        bh=NuJG7SteewjiGv9npXLFprFJzReYUnwNV8ENT1zC24k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4BXo8ygfKmvE6noRrWGnV2UiwXpC+kOEAGQs+ZAE3TiCWdCnG0wKdhj5Q1L3mta/
         9OdwLvAdoHC2dRT20to61bnErWuiziWInOr4vRbZpABAM0D9BQcnNtBCfAzWsCfNR2
         oxrRqYyEfXMypyuOa/SgYzoGlv0HqV/b2Ck/rruk=
Date:   Sun, 27 Aug 2023 10:57:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     naresh.kamboju@linaro.org, tytso@mit.edu, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ext4: fix rbtree traversal bug in
 ext4_mb_use_preallocated" failed to apply to 6.4-stable tree
Message-ID: <2023082758-basically-amiss-dba6@gregkh>
References: <2023072413-glamorous-unjustly-bb12@gregkh>
 <ZOR9iuT99TeDcrhn@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOR9iuT99TeDcrhn@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 22, 2023 at 02:49:06PM +0530, Ojaswin Mujoo wrote:
> On Mon, Jul 24, 2023 at 08:19:13AM +0200, gregkh@linuxfoundation.org wrote:
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
> > git cherry-pick -x 9d3de7ee192a6a253f475197fe4d2e2af10a731f
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072413-glamorous-unjustly-bb12@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> 
> So seems like this patch is already in the linux-6.4.y branch and seems 
> to have been applied before i got this email:
> 
>   339fee69a1da ext4: fix rbtree traversal bug in ext4_mb_use_preallocated
> 
> Any idea why do we still see this failure?

Probably because Sasha and I doing the same work?  I don't know, sorry
for the noise.

thanks,

greg k-h

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95B9789910
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 22:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjHZUiK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 16:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHZUiG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 16:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4891F2
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:38:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 632FD60E83
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 20:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425A8C433C8;
        Sat, 26 Aug 2023 20:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693082282;
        bh=3smJM03r7flm2W2M807LBBCb/6kXd50O8pGkA0nU4sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQ/X+yhvpp0U+446crkeaedsVLO6+Q7cuXoRhrm8OpBumo1DZT4akIbSlZbGEVlBq
         TJflhtku/X3nP/4Ixvufbqf1wCee+9ETkvo8sACVfzM+mUn8ZNRbkgod3SFrgiZHiQ
         BmsbQ/ltbiEiKUxs2+ypQxNSrvZisMW0pXYgeKPE=
Date:   Sat, 26 Aug 2023 22:37:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     surenb@google.com, akpm@linux-foundation.org, dave@stgolabs.net,
        david@redhat.com, hannes@cmpxchg.org, hughd@google.com,
        jannh@google.com, ldufour@linux.ibm.com, liam.howlett@oracle.com,
        mhocko@suse.com, michel@lespinasse.org, peterx@redhat.com,
        stable@vger.kernel.org, torvalds@linuxfoundation.org,
        vbabka@suse.cz
Subject: Re: FAILED: patch "[PATCH] mm: enable page walking API to lock vmas
 during the walk" failed to apply to 6.1-stable tree
Message-ID: <2023082640-sensitize-catching-fc3e@gregkh>
References: <2023082625-monotone-traps-6498@gregkh>
 <ZOphCbI4I9i4CtLS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOphCbI4I9i4CtLS@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Aug 26, 2023 at 09:31:05PM +0100, Matthew Wilcox wrote:
> On Sat, Aug 26, 2023 at 10:11:26PM +0200, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 6.1-stable tree.
> > Subject: [PATCH] mm: enable page walking API to lock vmas during the walk
> 
> VMA locking was introduced for 6.4, so I don't think this patch is
> needed for 6.1.

Thanks for confirming, I could not determine this by just reading the
patch.

greg k-h

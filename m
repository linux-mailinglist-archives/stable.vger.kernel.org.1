Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D61754F47
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 17:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGPPMn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjGPPMm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 11:12:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FA11B7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 08:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18A3460D2B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 15:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B6DC433C8;
        Sun, 16 Jul 2023 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689520360;
        bh=M9BXRF/yBNt7Xij5UeGHh3Ues/T3ZjJ/ScCBtkAh8X4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTlLNQRssZ8U1NkdLBJZx55BlgJvqBgomCxQSlpXTREpo88rtbD/rLxTsBNnaeeS9
         kM42RxO5Zlo99ept0efs7bloQxhL8gfQDyAiOzbLx3tIPmu688IYnrb03B96IL28/o
         b+wj1cuXggTxlWoQySkmBSsxJjY5u4al/Z17aKcU=
Date:   Sun, 16 Jul 2023 17:12:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     stable@vger.kernel.org
Subject: Re: one 'BUG_ON(ret < 0);' is still left in
 queue-6.1/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch
Message-ID: <2023071623-ethics-widely-7bae@gregkh>
References: <20230715070222.55BF.409509F4@e16-tech.com>
 <2023071634-cogwheel-handgun-7cdb@gregkh>
 <20230716174658.DC0B.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716174658.DC0B.409509F4@e16-tech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 16, 2023 at 05:47:03PM +0800, Wang Yugui wrote:
> Hi,
> 
> > On Sat, Jul 15, 2023 at 07:02:27AM +0800, Wang Yugui wrote:
> > > Hi,
> > > 
> > > one 'BUG_ON(ret < 0);' is still left in queue-6.1/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch 
> > > 
> > > so we need to rebase this patch.
> > 
> > Great, can you send a new version for 5.15.y and 6.1.y?
> 
> queue-5.15/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch is GOOD.
> queue-6.1/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch is GOOD.
> 
> and we can 'git am' queue-5.15/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch
> to 6.1.38 cleanly.
> 
> so it is OK to just copy queue-5.15/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch
> as queue-6.1/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch.

Thanks, that worked, now fixed up.

greg k-h

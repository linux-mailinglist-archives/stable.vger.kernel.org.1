Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B317383E4
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 14:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjFUMfx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 08:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjFUMfx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 08:35:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD877EC
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 05:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 410B66154F
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 12:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE66C433C8;
        Wed, 21 Jun 2023 12:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687350951;
        bh=oA00j8SGsLAfEE2VYW2tmV+p21e21DY6z9zt4CBGWzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plI0rSWQA3yJ724Fs/ZEMHXQBhKx71Pgr6JGwLaqP5VX85hybAGMxOUCNwCAj3zH4
         01R6RYv8ahxwPy01W59HkDebG5pu82PYPAKoSxb51846Bjpmfl67LE3UO59hZHpDET
         lkQy1Am4zYyX88NPy7gM1WNTA99RCAJXdAj3KIJ0=
Date:   Wed, 21 Jun 2023 14:35:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, juan.hao@nxp.com,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] dma-buf: keep the signaling time of merged fences
Message-ID: <2023062104-goggles-filter-b939@gregkh>
References: <20230621073204.28459-1-christian.koenig@amd.com>
 <2023062140-bartender-closable-9fa9@gregkh>
 <44be4e13-a157-35ec-6ff7-e3a0fce057e4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44be4e13-a157-35ec-6ff7-e3a0fce057e4@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 21, 2023 at 02:05:07PM +0200, Christian König wrote:
> Am 21.06.23 um 13:02 schrieb Greg KH:
> > On Wed, Jun 21, 2023 at 09:32:04AM +0200, Christian König wrote:
> > > Some Android CTS is testing for that.
> > > 
> > > Signed-off-by: Christian König <christian.koenig@amd.com>
> > > CC: stable@vger.kernel.org
> > What commit id does this fix?
> 
> Sorry Greg, totally unintentionally send this CC to the stable list because
> git wasn't correctly configured.

It's fine to cc: the stable list, we WANT to see patches that are being
sent out like this before they hit the maintainers tree as you get more
review of them.

So no need to change your git configuration, this is fine.

> The patch is still under review.

Agreed, which is why it should be fixed :)

thanks,

greg k-h

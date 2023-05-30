Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429337156A2
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 09:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjE3HZT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 03:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjE3HYc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 03:24:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4495C1B7
        for <stable@vger.kernel.org>; Tue, 30 May 2023 00:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD4C62AF9
        for <stable@vger.kernel.org>; Tue, 30 May 2023 07:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD626C433EF;
        Tue, 30 May 2023 07:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685431424;
        bh=+hsmiVBOL4YEKNBjls6n+xQgOJ9XYa2GcAD3Ga45aYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d6R37M7qmWMLROIzOX3+K5lFm1p0y9eQucXWij5xdYT27B//O38gAOYW+5gs4tApB
         l5uoDVe3ySJ0Y52OF4xG61cSmwPQNzbD/lZYnsPpVataVkoJGuD97Z2IxvabEhc3Cf
         NOZE6DkKXgEElnAhsdjwW67WkrYBHosf5Zoer4Tw=
Date:   Tue, 30 May 2023 08:23:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linyunsheng@huawei.com, brouer@redhat.com,
        ilias.apalodimas@linaro.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] page_pool: fix inconsistency for
 page_pool_ring_[un]lock()" failed to apply to 5.15-stable tree
Message-ID: <2023053021-perfected-cathouse-bb40@gregkh>
References: <2023052821-wired-primate-24c3@gregkh>
 <20230529190034.5e20c2dc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529190034.5e20c2dc@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 29, 2023 at 07:00:34PM -0700, Jakub Kicinski wrote:
> On Sun, 28 May 2023 17:55:22 +0100 gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Do you track the missing backports?

Nope, once I email this off, it goes off of my radar.  But I know Sasha
sometimes tries to fix them up, as do others as it's an easy TODO list
for people who want to help out.

> We fumbled the Fixes tag on
> this one, turns out it's not needed further back than it applies.
> In such cases is it useful to let you know or just silently ignore 
> the failure notification?

It's good to say "this isn't needed" so that others don't spend time on
it, so thanks!

greg k-h

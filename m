Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756297199B3
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjFAK2V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjFAK16 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 06:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D5CE7F
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 03:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C036435A
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 10:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BE5C433D2;
        Thu,  1 Jun 2023 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685615236;
        bh=eBE2giV/pKHFHTehq978rsdrfRniwtrzzYWeL1mZYmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVUoFJwpukETz1KVt8z63BFGpLW6TxnAI7VsjWoeIIl2VB98D9sLU2NteMUsm3SUc
         1RcqDDys+0LfoiFJv6yrIxjLN9Vi4msuokZJpTQ2nnxdrFu3qaSaKjHM5gPF4mzpTU
         6FhRXLysA5zVUMBryHLq8/RuGJKUJEe8pgVGkzA4=
Date:   Thu, 1 Jun 2023 11:27:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     stable@vger.kernel.org,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: Please cherry-pick 9b7c68b3911aef84afa4cbfc31bce20f10570d51
 ("netfilter: ctnetlink: Support offloaded conntrack entry deletion")
Message-ID: <2023060100-maroon-stylist-822c@gregkh>
References: <ZHf9bdGWnOG4+EM+@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHf9bdGWnOG4+EM+@itl-email>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 31, 2023 at 10:07:37PM -0400, Demi Marie Obenour wrote:
> Please cherry-pick 9b7c68b3911aef84afa4cbfc31bce20f10570d51
> ("netfilter: ctnetlink: Support offloaded conntrack entry deletion") to
> all supported stable trees except for 4.14.  The lack of it makes the
> flowtables feature much more difficult (if not impossible) to use in
> environments where connection tracking entries must be removed to
> terminate flows.  The diffstat is -8,+0 and the commit only removes
> code that was not necessary to begin with.

Now queued up, thanks.

greg k-h

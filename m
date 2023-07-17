Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF23E756C41
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 20:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGQSjG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 14:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGQSjF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 14:39:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB876A1
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 11:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89721611E9
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 18:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C68C433CC;
        Mon, 17 Jul 2023 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689619143;
        bh=4jIfZFZJ2kGZuxU3UBj35hoXElxQ+yT1gvkMM8kb0w0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnWr/VVPf4e4JT6YwEV9pKsrwy7HJ0EShY6t7IKey3cVkgo1gsyswTBw39MxRw1Q3
         e9rbK7eaxIX2P9qqXwezeG6eLX+v5X5mKDQ4qFOHLFJ+OXEhu4xLQ32KyVeiChhT0t
         YNhhqfhGKSCx3YmiuCFUDwK8dY7QsMLMVj6TBal8=
Date:   Mon, 17 Jul 2023 20:39:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH 6.1 588/591] netfilter: nf_tables: prevent OOB access in
 nft_byteorder_eval
Message-ID: <2023071749-scenic-viral-b9cc@gregkh>
References: <20230716194923.861634455@linuxfoundation.org>
 <20230716194939.064148756@linuxfoundation.org>
 <ZLUTNi6wJ4dkMQgl@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLUTNi6wJ4dkMQgl@calendula>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 17, 2023 at 12:08:54PM +0200, Pablo Neira Ayuso wrote:
> Hi Greg,
> 
> On Sun, Jul 16, 2023 at 09:52:07PM +0200, Greg Kroah-Hartman wrote:
> > From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > 
> > commit caf3ef7468f7534771b5c44cd8dbd6f7f87c2cbd upstream.
> 
> You can also cherry-pick this commit to:
> 
> - 5.15.y
> - 5.10.y
> - 5.4.y
> - 4.19.y
> - 4.14.y

Already queued up there, thanks!

greg k-h

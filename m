Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ABC7829B0
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 14:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjHUM7R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 08:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjHUM7R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 08:59:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279ECB1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 05:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD76C63568
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91298C433C8;
        Mon, 21 Aug 2023 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692622755;
        bh=H3sBj9tDIoWCCFP7KlnOTO3PV5tHaTCKjFCPWfzqbBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIkEDJbAI2DhGnfl6GsHADPkAG8IiPWBI9ghcm6LCLeNWnkgx/B0iqoVfgmE48+LB
         mvJjwbZwKvFZDRt3oejPEDO1JvzsZGY89SkL7Atdk16m+aOY78Lfyr/mnmf0HxxRM7
         rSeKiO/Okj+kjeDjDmuoYLpOtouZ89znTlPGZscc=
Date:   Mon, 21 Aug 2023 14:59:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     akpm@linux-foundation.org, axboe@kernel.dk, davem@davemloft.net,
        david@redhat.com, edumazet@google.com, herbert@gondor.apana.org.au,
        jlayton@kernel.org, kuba@kernel.org, nspmangalore@gmail.com,
        pabeni@redhat.com, rohiths.msft@gmail.com, stable@vger.kernel.org,
        stfrench@microsoft.com, svens@linux.ibm.com, willy@infradead.org
Subject: Re: FAILED: patch "[PATCH] crypto, cifs: fix error handling in
 extract_iter_to_sg()" failed to apply to 6.4-stable tree
Message-ID: <2023082127-monument-slot-bceb@gregkh>
References: <2023081209-reopen-fantasy-7692@gregkh>
 <3955202.1692002579@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3955202.1692002579@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 14, 2023 at 09:42:59AM +0100, David Howells wrote:
> <gregkh@linuxfoundation.org> wrote:
> 
> > The patch below does not apply to the 6.4-stable tree.
> 
> At that point it was in fs/netfs/iterator.c and called
> netfs_extract_user_to_sg().

Thanks, I'll just modify this one function instead of the 4 "dep-of"
patches that Sasha applied to fix this up, as that feels like a lot of
overkill...

thanks,

greg k-h

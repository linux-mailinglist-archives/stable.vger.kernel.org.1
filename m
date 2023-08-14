Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89D977B47D
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 10:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjHNIob (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 04:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjHNIoX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 04:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183991717
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692002587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6gEshekj4hdmAqzBfBjZQfzSDjyWOP/7DSuOeLtJv8=;
        b=eBG7LKCQcNJnc+10gyz/z066pgpPubjxGBou5qDN96WrdIWG5S3kmbDiNzedoC41/EodNq
        H0proCldO2M4DXkzb/pNpnQKpiYzHaHAZPb92E6NyVyv6jy76Un73yMvBMXcYCo/2iJsHr
        BdSx5qDvwcKs6PGQwrywx+kj3aDHA0s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-rYCRnXAaOfeyzkN9T6XtGQ-1; Mon, 14 Aug 2023 04:43:04 -0400
X-MC-Unique: rYCRnXAaOfeyzkN9T6XtGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7100F183B3C8;
        Mon, 14 Aug 2023 08:43:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DC9B40C2063;
        Mon, 14 Aug 2023 08:43:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2023081209-reopen-fantasy-7692@gregkh>
References: <2023081209-reopen-fantasy-7692@gregkh>
To:     gregkh@linuxfoundation.org
Cc:     dhowells@redhat.com, akpm@linux-foundation.org, axboe@kernel.dk,
        davem@davemloft.net, david@redhat.com, edumazet@google.com,
        herbert@gondor.apana.org.au, jlayton@kernel.org, kuba@kernel.org,
        nspmangalore@gmail.com, pabeni@redhat.com, rohiths.msft@gmail.com,
        stable@vger.kernel.org, stfrench@microsoft.com,
        svens@linux.ibm.com, willy@infradead.org
Subject: Re: FAILED: patch "[PATCH] crypto, cifs: fix error handling in extract_iter_to_sg()" failed to apply to 6.4-stable tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3955201.1692002579.1@warthog.procyon.org.uk>
Date:   Mon, 14 Aug 2023 09:42:59 +0100
Message-ID: <3955202.1692002579@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

<gregkh@linuxfoundation.org> wrote:

> The patch below does not apply to the 6.4-stable tree.

At that point it was in fs/netfs/iterator.c and called
netfs_extract_user_to_sg().

David


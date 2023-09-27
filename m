Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606757AFA66
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 07:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjI0FxU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 01:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjI0Fwh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 01:52:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E80A1AE
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 22:50:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB1FC433C7;
        Wed, 27 Sep 2023 05:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695793859;
        bh=1olEBS0dNJLFikr9MRwyw7No2z5aHgh3Ify968bqAoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3+SQPanwdUIw77Rv10PmtVst5Hh8W/COkIXsiWoBdOFDbRriP5JHe/HKEQxVo+pZ
         5Nd7hPiL1TlLVTFMqb3Bt1WqQL1Mi1i+GnXmy2aXo82+yiE1snJXr/unPP9CQy0yQp
         OCLgJebaWFAZCzBCv+ok//wrUDBbEesYZKgQ712sPkCo52hUqkdkQ4CyGTNLWoRrM/
         qb37IrV2nLegM0Mmc+NoArb2HnzLVPwVFx8OqlBb2quaVEicO9vEguQFyQk7jTTSyA
         Y3MAmo/2HyL0YEOQOi18uFDJCauaaeMxUo2+82w+vpiTxp6Z0Ye1SbFtU23meN3Ly5
         3zgyeSRrh1JSg==
Date:   Wed, 27 Sep 2023 07:50:51 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jordan Rife <jrife@google.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        netdev@vger.kernel.org, dborkman@kernel.org, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
        ast@kernel.org, rdna@fb.com, stable@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v5 2/3] net: prevent rewrite of msg_name in
 sock_sendmsg()
Message-ID: <20230927055051.GC224399@kernel.org>
References: <20230921234642.1111903-1-jrife@google.com>
 <20230921234642.1111903-2-jrife@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921234642.1111903-2-jrife@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 21, 2023 at 06:46:41PM -0500, Jordan Rife wrote:
> Callers of sock_sendmsg(), and similarly kernel_sendmsg(), in kernel
> space may observe their value of msg_name change in cases where BPF
> sendmsg hooks rewrite the send address. This has been confirmed to break
> NFS mounts running in UDP mode and has the potential to break other
> systems.
> 
> This patch:
> 
> 1) Creates a new function called __sock_sendmsg() with same logic as the
>    old sock_sendmsg() function.
> 2) Replaces calls to sock_sendmsg() made by __sys_sendto() and
>    __sys_sendmsg() with __sock_sendmsg() to avoid an unnecessary copy,
>    as these system calls are already protected.
> 3) Modifies sock_sendmsg() so that it makes a copy of msg_name if
>    present before passing it down the stack to insulate callers from
>    changes to the send address.
> 
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
> Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
> Cc: stable@vger.kernel.org
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jordan Rife <jrife@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


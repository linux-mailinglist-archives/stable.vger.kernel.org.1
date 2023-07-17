Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21B7569DE
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 19:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGQRKW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 13:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGQRKV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 13:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46230131
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 10:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC756117B
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 17:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72EDC433C8;
        Mon, 17 Jul 2023 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689613819;
        bh=z2vzLydecjU2OYGpMchMuMhs//ZntnTizbXwVeEWhc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UnD6OY3XGKvN8SlGxezgxN8zsBMbgZq4i2tvUDSWq7PDbJvWBShoxHFqDG6MezFx3
         Hkf065B3o0lbJ4D19g1FuC0dWqvAvJRV1XvyQu/5EHAFwTQVHE6DsBsr4Ub5ICEkg7
         NPdkNQRPqFSBGy7ECqG/j201s0OMv2ezqqWJVhpI=
Date:   Mon, 17 Jul 2023 19:10:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Jakub Kacinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.4 118/800] net/handshake: Unpin sock->file if a
 handshake is cancelled
Message-ID: <2023071733-eligibly-altitude-4050@gregkh>
References: <20230716194949.099592437@linuxfoundation.org>
 <20230716194951.848894569@linuxfoundation.org>
 <6B82BD28-1891-499A-8721-1567612EF553@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B82BD28-1891-499A-8721-1567612EF553@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 16, 2023 at 08:43:58PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 16, 2023, at 3:39 PM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > [ Upstream commit f921bd41001ccff2249f5f443f2917f7ef937daf ]
> > 
> > If user space never calls DONE, sock->file's reference count remains
> > elevated. Enable sock->file to be freed eventually in this case.
> > 
> > Reported-by: Jakub Kacinski <kuba@kernel.org>
> > Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> > net/handshake/handshake.h | 1 +
> > net/handshake/request.c   | 4 ++++
> > 2 files changed, 5 insertions(+)
> > 
> > diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
> > index 4dac965c99df0..8aeaadca844fd 100644
> > --- a/net/handshake/handshake.h
> > +++ b/net/handshake/handshake.h
> > @@ -31,6 +31,7 @@ struct handshake_req {
> > struct list_head hr_list;
> > struct rhash_head hr_rhash;
> > unsigned long hr_flags;
> > + struct file *hr_file;
> > const struct handshake_proto *hr_proto;
> > struct sock *hr_sk;
> > void (*hr_odestruct)(struct sock *sk);
> > diff --git a/net/handshake/request.c b/net/handshake/request.c
> > index 94d5cef3e048b..d78d41abb3d99 100644
> > --- a/net/handshake/request.c
> > +++ b/net/handshake/request.c
> > @@ -239,6 +239,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
> > }
> > req->hr_odestruct = req->hr_sk->sk_destruct;
> > req->hr_sk->sk_destruct = handshake_sk_destruct;
> > + req->hr_file = sock->file;
> > 
> > ret = -EOPNOTSUPP;
> > net = sock_net(req->hr_sk);
> > @@ -334,6 +335,9 @@ bool handshake_req_cancel(struct sock *sk)
> > return false;
> > }
> > 
> > + /* Request accepted and waiting for DONE */
> > + fput(req->hr_file);
> > +
> > out_true:
> > trace_handshake_cancel(net, req, sk);
> > 
> > -- 
> > 2.39.2
> > 
> > 
> > 
> 
> Don't take this one. It's fixed by a later commit:
> 
> 361b6889ae636926cdff517add240c3c8e24593a
> 
> that reverts it.

How?  That commit is in 6.4 already, yet this commit, is from 6.5-rc1.

confused,

greg k-h

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2263F762193
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 20:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjGYSjZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 14:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGYSjY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 14:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE01199A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11A7261877
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 18:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE996C433C7;
        Tue, 25 Jul 2023 18:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690310362;
        bh=/fLrYkomR7e++1jNKJRtYrKgRl1GFbBahIfCgp09/lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lCi+AlD89Bn50K7yO0dcmAhMhTzUp0Wtq0/0fOx5dr2wWX/GygO7lS8Tf0iVnkCJK
         9UYGSsn2OrmNj4PKYxLVSklO91voGLkZsc6mNW36nN77e5ItxIPAzTFF9nvaPz0EHs
         qyI3ng4ubUQoliW+k6qnDB36j+1dsT3UzbwjeGAo=
Date:   Tue, 25 Jul 2023 20:39:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mat Martineau <martineau@kernel.org>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Geliang Tang <geliang.tang@suse.com>, netdev@vger.kernel.org,
        mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] mptcp: more accurate NL event generation
Message-ID: <2023072513-citizen-skyward-9530@gregkh>
References: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
 <20230725-send-net-20230725-v1-2-6f60fe7137a9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725-send-net-20230725-v1-2-6f60fe7137a9@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 25, 2023 at 11:34:56AM -0700, Mat Martineau wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Currently the mptcp code generate a "new listener" event even
> if the actual listen() syscall fails. Address the issue moving
> the event generation call under the successful branch.
> 
> Fixes: f8c9dfbd875b ("mptcp: add pm listener events")
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> ---
>  net/mptcp/protocol.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3613489eb6e3..3317d1cca156 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3723,10 +3723,9 @@ static int mptcp_listen(struct socket *sock, int backlog)
>  	if (!err) {
>  		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
>  		mptcp_copy_inaddrs(sk, ssock->sk);
> +		mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
>  	}
>  
> -	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
> -
>  unlock:
>  	release_sock(sk);
>  	return err;
> 
> -- 
> 2.41.0
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

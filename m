Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12671762195
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 20:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjGYSjc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 14:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjGYSjb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 14:39:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB0EA3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BF226181E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 18:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0433C433C7;
        Tue, 25 Jul 2023 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690310370;
        bh=Uw9m574mjK/0Ei7oniQtpFxXW1q8JHO3VH8+PxQI2CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGEFUCNKwoWqycpQvYWdIGzZh32HEIaGW1D7SsOrwMl7znohLPf0anaUfTGuEL3oW
         lbmWtvgJEhkOzQzYi366/Es5uRaKMNAG5VKUayKej66M7pGLX+kJzgfVbr5i5LWxdn
         qVMrLNH6DDoKKtXEZePe8t1Hx3jHGJG9o7h0DGUE=
Date:   Tue, 25 Jul 2023 20:39:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mat Martineau <martineau@kernel.org>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Geliang Tang <geliang.tang@suse.com>, netdev@vger.kernel.org,
        mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] selftests: mptcp: join: only check for ip6tables
 if needed
Message-ID: <2023072521-surfboard-starry-fbe8@gregkh>
References: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
 <20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 25, 2023 at 11:34:55AM -0700, Mat Martineau wrote:
> From: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> If 'iptables-legacy' is available, 'ip6tables-legacy' command will be
> used instead of 'ip6tables'. So no need to look if 'ip6tables' is
> available in this case.
> 
> Fixes: 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index e6c9d5451c5b..3c2096ac97ef 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -162,9 +162,7 @@ check_tools()
>  	elif ! iptables -V &> /dev/null; then
>  		echo "SKIP: Could not run all tests without iptables tool"
>  		exit $ksft_skip
> -	fi
> -
> -	if ! ip6tables -V &> /dev/null; then
> +	elif ! ip6tables -V &> /dev/null; then
>  		echo "SKIP: Could not run all tests without ip6tables tool"
>  		exit $ksft_skip
>  	fi
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

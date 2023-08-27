Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3347F789D39
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjH0LPP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 07:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjH0LPM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 07:15:12 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944411B7
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 04:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1693134901; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HS7v7E8x1Wbbg8HOtF6HB4iO/9Q8FA7DVVrliUN8tNovA3h8eC7UF1wOrTLTw4n+7L
    Xt9Fg8k1BWeEvHEyQO/CZwwAGYvTWCKCskkXdrAbN7wEmThOT0ewh/13fr0pfBdwd63O
    nRJfR0UQtbv92M4lJwOfBpW/QvY4Tc49T1KeBA/EXYVmYCUGAF5Qvh0FCK9bxxndMK5P
    vHh5XXInI+5K2Ldswxwj+p7QMgMAox8jhD1ao0SqheYPhIfSQWUviufXcTThjkZFE9Jm
    nMzgeecPt/AJ/8GKSIRfpIF+f9DIHLuvqdjFqos6Iiv7EWzwLdGW9KCkiCdXDEss84UF
    JpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1693134901;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=c8s8C/ZP5eBq7zFUcQkM+gjOk9ZakV49dyyQ3+tWWhI=;
    b=UnF30GC0cjCvABq2ybGS14szSCb7QRDpopx8x+kgMkHnV/yp3QNO8lPUVy8JmPlhU7
    xx55qeU/s7WHvRwPGKgDeZoegyN8+etewpMndZGC3QwAHzuevRJfvFMKEI4O0ZF1YFkQ
    oPdM0EATh0dQbNGMcvBENn8oM/tR4Wyz+b1Kfw9d3lLxKE/SXyoVQlj7UyrTWaf2tbRw
    hpKE34uBbQoopRDYKRs+vFzw5f3gLOlGQZ+kV3eItrl5mi5M+fp5adkUKM+vyxJhQtyW
    Dmdhu+q27vB+OXuT36D8jq6uS84/GaH6BnPWX8ISEOboJs8QIj6r4u4ho3SuN3q6Zmtd
    ujfw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1693134901;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=c8s8C/ZP5eBq7zFUcQkM+gjOk9ZakV49dyyQ3+tWWhI=;
    b=cVF+pMetJHVlcqm7lylaWFWeyOE3j5IRLstgW9vDeV2VkprsmnuznG2twek51H4GoA
    /FPEkDSevmGwrZbPqD948L19LTqN7ovw/xTdwcp8RwFitW99iSzAbgnUzqQPAZ8mEzZv
    RZTOCM+uJHz0ILhz/elVNKVsXVt6+wCoLQ1VR7BS1xS6VSE2UNeK8ONRF+Ta5pMrJTYJ
    pU1jq1GnmECcZ2R6u4RVYD8Y/KOJsjckYrfRCFfifPNhihb9jlYTfQjYc+LFjmKaasaX
    6zC9mXH0nnMhSKGwCMBZNn7iIyqWDMfVL7FJVC76VcctHDgT5waObPyJTD4OUSxk8vSX
    x+Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1693134901;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=c8s8C/ZP5eBq7zFUcQkM+gjOk9ZakV49dyyQ3+tWWhI=;
    b=bOoOAAt2AeZGSTxFdn+EFmsmMVzRdL5+i85HiioaNU3VVxEuQhbBjreR9elKUarIeU
    XyeZLy4T2KmTUJi3xUBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq1USEbMhpqw=="
Received: from [IPV6:2a00:6020:4a8e:5004::923]
    by smtp.strato.de (RZmta 49.8.1 AUTH)
    with ESMTPSA id K723f1z7RBF1Enc
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 27 Aug 2023 13:15:01 +0200 (CEST)
Message-ID: <7f54238e-cef3-10ba-e471-03047bf13ff0@hartkopp.net>
Date:   Sun, 27 Aug 2023 13:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: FAILED: patch "[PATCH] can: raw: add missing refcount for memory
 leak fix" failed to apply to 5.15-stable tree
To:     gregkh@linuxfoundation.org, edumazet@google.com, kuba@kernel.org,
        william.xuanziyang@huawei.com, stable@vger.kernel.org
References: <2023082737-cavity-bloating-1779@gregkh>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <2023082737-cavity-bloating-1779@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello Greg,

the dev_tracker including netdev_put() and netdev_hold() has been 
introduced in Linux 6.0.

I send out a stable backport patch to this group of people for 5.15 :

"[PATCH stable < v6.0] can: raw: add missing refcount for memory leak fix"

Best regards,
Oliver

On 27.08.23 12:32, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x c275a176e4b69868576e543409927ae75e3a3288
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082737-cavity-bloating-1779@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Possible dependencies:
> 
> c275a176e4b6 ("can: raw: add missing refcount for memory leak fix")
> ee8b94c8510c ("can: raw: fix receiver memory leak")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
>  From c275a176e4b69868576e543409927ae75e3a3288 Mon Sep 17 00:00:00 2001
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> Date: Mon, 21 Aug 2023 16:45:47 +0200
> Subject: [PATCH] can: raw: add missing refcount for memory leak fix
> 
> Commit ee8b94c8510c ("can: raw: fix receiver memory leak") introduced
> a new reference to the CAN netdevice that has assigned CAN filters.
> But this new ro->dev reference did not maintain its own refcount which
> lead to another KASAN use-after-free splat found by Eric Dumazet.
> 
> This patch ensures a proper refcount for the CAN nedevice.
> 
> Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Link: https://lore.kernel.org/r/20230821144547.6658-3-socketcan@hartkopp.net
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index e10f59375659..d50c3f3d892f 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -85,6 +85,7 @@ struct raw_sock {
>   	int bound;
>   	int ifindex;
>   	struct net_device *dev;
> +	netdevice_tracker dev_tracker;
>   	struct list_head notifier;
>   	int loopback;
>   	int recv_own_msgs;
> @@ -285,8 +286,10 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>   	case NETDEV_UNREGISTER:
>   		lock_sock(sk);
>   		/* remove current filters & unregister */
> -		if (ro->bound)
> +		if (ro->bound) {
>   			raw_disable_allfilters(dev_net(dev), dev, sk);
> +			netdev_put(dev, &ro->dev_tracker);
> +		}
>   
>   		if (ro->count > 1)
>   			kfree(ro->filter);
> @@ -391,10 +394,12 @@ static int raw_release(struct socket *sock)
>   
>   	/* remove current filters & unregister */
>   	if (ro->bound) {
> -		if (ro->dev)
> +		if (ro->dev) {
>   			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
> -		else
> +			netdev_put(ro->dev, &ro->dev_tracker);
> +		} else {
>   			raw_disable_allfilters(sock_net(sk), NULL, sk);
> +		}
>   	}
>   
>   	if (ro->count > 1)
> @@ -445,10 +450,10 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>   			goto out;
>   		}
>   		if (dev->type != ARPHRD_CAN) {
> -			dev_put(dev);
>   			err = -ENODEV;
> -			goto out;
> +			goto out_put_dev;
>   		}
> +
>   		if (!(dev->flags & IFF_UP))
>   			notify_enetdown = 1;
>   
> @@ -456,7 +461,9 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>   
>   		/* filters set by default/setsockopt */
>   		err = raw_enable_allfilters(sock_net(sk), dev, sk);
> -		dev_put(dev);
> +		if (err)
> +			goto out_put_dev;
> +
>   	} else {
>   		ifindex = 0;
>   
> @@ -467,18 +474,28 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>   	if (!err) {
>   		if (ro->bound) {
>   			/* unregister old filters */
> -			if (ro->dev)
> +			if (ro->dev) {
>   				raw_disable_allfilters(dev_net(ro->dev),
>   						       ro->dev, sk);
> -			else
> +				/* drop reference to old ro->dev */
> +				netdev_put(ro->dev, &ro->dev_tracker);
> +			} else {
>   				raw_disable_allfilters(sock_net(sk), NULL, sk);
> +			}
>   		}
>   		ro->ifindex = ifindex;
>   		ro->bound = 1;
> +		/* bind() ok -> hold a reference for new ro->dev */
>   		ro->dev = dev;
> +		if (ro->dev)
> +			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
>   	}
>   
> - out:
> +out_put_dev:
> +	/* remove potential reference from dev_get_by_index() */
> +	if (dev)
> +		dev_put(dev);
> +out:
>   	release_sock(sk);
>   	rtnl_unlock();
>   
> 

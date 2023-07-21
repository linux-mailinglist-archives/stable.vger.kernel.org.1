Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD49A75BDB6
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 07:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGUFVk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 01:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjGUFVj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 01:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD9C19B2
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 22:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DEBE6106D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53779C433C7;
        Fri, 21 Jul 2023 05:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689916897;
        bh=ZBQHAQR8rd2MlIpEvwvEhmInk5AQUMRwcOZdrGpmT8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZQPT26c8zIcU3e7ThRh0kej9Yri2jyu2LozCeXICl6fDP30uZVMvisfCktRuoKH9
         BAJpusbgvMC9OvYw+JjB6jDXTvUYqETua/XNwtKY76t+KR6P/vpgQx47CG7aBg+YVY
         tCNR8yMZahmDhE9aFwtnRsbwJLaPWCDBiO/aWZMg=
Date:   Fri, 21 Jul 2023 07:21:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ding Hui <dinghui@sangfor.com.cn>
Cc:     stable@vger.kernel.org, chuck.lever@oracle.com
Subject: Re: [PATCH 5.4.y] SUNRPC: Fix UAF in svc_tcp_listen_data_ready()
Message-ID: <2023072126-share-causation-50a6@gregkh>
References: <2023071115-freeway-undefined-38ac@gregkh>
 <20230712031532.13294-1-dinghui@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712031532.13294-1-dinghui@sangfor.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 12, 2023 at 11:15:32AM +0800, Ding Hui wrote:
> After the listener svc_sock is freed, and before invoking svc_tcp_accept()
> for the established child sock, there is a window that the newsock
> retaining a freed listener svc_sock in sk_user_data which cloning from
> parent. In the race window, if data is received on the newsock, we will
> observe use-after-free report in svc_tcp_listen_data_ready().
> 
> Reproduce by two tasks:
> 
> 1. while :; do rpc.nfsd 0 ; rpc.nfsd; done
> 2. while :; do echo "" | ncat -4 127.0.0.1 2049 ; done
> 
> KASAN report:
> 
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in svc_tcp_listen_data_ready+0x1cf/0x1f0 [sunrpc]
>   Read of size 8 at addr ffff888139d96228 by task nc/102553
>   CPU: 7 PID: 102553 Comm: nc Not tainted 6.3.0+ #18
>   Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl+0x33/0x50
>    print_address_description.constprop.0+0x27/0x310
>    print_report+0x3e/0x70
>    kasan_report+0xae/0xe0
>    svc_tcp_listen_data_ready+0x1cf/0x1f0 [sunrpc]
>    tcp_data_queue+0x9f4/0x20e0
>    tcp_rcv_established+0x666/0x1f60
>    tcp_v4_do_rcv+0x51c/0x850
>    tcp_v4_rcv+0x23fc/0x2e80
>    ip_protocol_deliver_rcu+0x62/0x300
>    ip_local_deliver_finish+0x267/0x350
>    ip_local_deliver+0x18b/0x2d0
>    ip_rcv+0x2fb/0x370
>    __netif_receive_skb_one_core+0x166/0x1b0
>    process_backlog+0x24c/0x5e0
>    __napi_poll+0xa2/0x500
>    net_rx_action+0x854/0xc90
>    __do_softirq+0x1bb/0x5de
>    do_softirq+0xcb/0x100
>    </IRQ>
>    <TASK>
>    ...
>    </TASK>
> 
>   Allocated by task 102371:
>    kasan_save_stack+0x1e/0x40
>    kasan_set_track+0x21/0x30
>    __kasan_kmalloc+0x7b/0x90
>    svc_setup_socket+0x52/0x4f0 [sunrpc]
>    svc_addsock+0x20d/0x400 [sunrpc]
>    __write_ports_addfd+0x209/0x390 [nfsd]
>    write_ports+0x239/0x2c0 [nfsd]
>    nfsctl_transaction_write+0xac/0x110 [nfsd]
>    vfs_write+0x1c3/0xae0
>    ksys_write+0xed/0x1c0
>    do_syscall_64+0x38/0x90
>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
>   Freed by task 102551:
>    kasan_save_stack+0x1e/0x40
>    kasan_set_track+0x21/0x30
>    kasan_save_free_info+0x2a/0x50
>    __kasan_slab_free+0x106/0x190
>    __kmem_cache_free+0x133/0x270
>    svc_xprt_free+0x1e2/0x350 [sunrpc]
>    svc_xprt_destroy_all+0x25a/0x440 [sunrpc]
>    nfsd_put+0x125/0x240 [nfsd]
>    nfsd_svc+0x2cb/0x3c0 [nfsd]
>    write_threads+0x1ac/0x2a0 [nfsd]
>    nfsctl_transaction_write+0xac/0x110 [nfsd]
>    vfs_write+0x1c3/0xae0
>    ksys_write+0xed/0x1c0
>    do_syscall_64+0x38/0x90
>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Fix the UAF by simply doing nothing in svc_tcp_listen_data_ready()
> if state != TCP_LISTEN, that will avoid dereferencing svsk for all
> child socket.
> 
> Link: https://lore.kernel.org/lkml/20230507091131.23540-1-dinghui@sangfor.com.cn/
> Fixes: fa9251afc33c ("SUNRPC: Call the default socket callbacks instead of open coding")
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> (cherry picked from commit fc80fc2d4e39137869da3150ee169b40bf879287)
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> ---
>  net/sunrpc/svcsock.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 

All now queued up, thanks.

greg k-h

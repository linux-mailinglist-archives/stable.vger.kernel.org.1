Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844DA7844E5
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 17:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjHVPCV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 11:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHVPCV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 11:02:21 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F20F137
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 08:02:18 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 431181ABFF;
        Tue, 22 Aug 2023 18:02:15 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 27A171ABFA;
        Tue, 22 Aug 2023 18:02:15 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
        by ink.ssi.bg (Postfix) with ESMTPSA id 9DBB93C0440;
        Tue, 22 Aug 2023 18:02:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
        t=1692716535; bh=MNqlv6MVmUWGVc2QBhKbwcDl2XXwpMhMb38ji0Wc76s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=cgGBp8h/EzOgdx+XmLvyUyA/97LLMZ+hGaNtxy431SGm3xh5V8iKdPbfFXgi+gamv
         VFQ/uNl7yxBgGpSUXOo/zBMAZ0yvOfaM8N+qpDLEnl4bPBHlDY87fJ10wYT+2mV5jG
         JtAUviCvIhkdnPRLwV+D5Tg7gWS4gDb2cueZA+q8=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 37MF25Ul064698;
        Tue, 22 Aug 2023 18:02:06 +0300
Date:   Tue, 22 Aug 2023 18:02:05 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     gregkh@linuxfoundation.org
cc:     sishuai.system@gmail.com, fw@strlen.de, horms@kernel.org,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ipvs: fix racy memcpy in proc_do_sync_threshold"
 failed to apply to 4.19-stable tree
In-Reply-To: <2023082114-remix-cable-0852@gregkh>
Message-ID: <ae0ee8d4-eec4-d0b7-29a0-f3cf1ccb69f5@ssi.bg>
References: <2023082114-remix-cable-0852@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


	Hello,

On Mon, 21 Aug 2023, gregkh@linuxfoundation.org wrote:

> 
> The patch below does not apply to the 4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
> git checkout FETCH_HEAD
> git cherry-pick -x 5310760af1d4fbea1452bfc77db5f9a680f7ae47
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082114-remix-cable-0852@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..
> 
> Possible dependencies:
> 
> 5310760af1d4 ("ipvs: fix racy memcpy in proc_do_sync_threshold")
> 1b90af292e71 ("ipvs: Improve robustness to the ipvs sysctl")

	It can happen only if we backport the other mentioned
commit 1b90af292e71 which needs changing SYSCTL_ZERO/SYSCTL_ONE
to zero/one and then 5310760af1d4 will apply as-is to both 4.14 and
4.19. Should I send backport for 1b90af292e71, it is even more
useful as a fix than 5310760af1d4?

> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From 5310760af1d4fbea1452bfc77db5f9a680f7ae47 Mon Sep 17 00:00:00 2001
> From: Sishuai Gong <sishuai.system@gmail.com>
> Date: Thu, 10 Aug 2023 15:12:42 -0400
> Subject: [PATCH] ipvs: fix racy memcpy in proc_do_sync_threshold
> 
> When two threads run proc_do_sync_threshold() in parallel,
> data races could happen between the two memcpy():
> 
> Thread-1			Thread-2
> memcpy(val, valp, sizeof(val));
> 				memcpy(valp, val, sizeof(val));
> 
> This race might mess up the (struct ctl_table *) table->data,
> so we add a mutex lock to serialize them.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/netdev/B6988E90-0A1E-4B85-BF26-2DAF6D482433@gmail.com/
> Signed-off-by: Sishuai Gong <sishuai.system@gmail.com>
> Acked-by: Simon Horman <horms@kernel.org>
> Acked-by: Julian Anastasov <ja@ssi.bg>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 62606fb44d02..4bb0d90eca1c 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -1876,6 +1876,7 @@ static int
>  proc_do_sync_threshold(struct ctl_table *table, int write,
>  		       void *buffer, size_t *lenp, loff_t *ppos)
>  {
> +	struct netns_ipvs *ipvs = table->extra2;
>  	int *valp = table->data;
>  	int val[2];
>  	int rc;
> @@ -1885,6 +1886,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
>  		.mode = table->mode,
>  	};
>  
> +	mutex_lock(&ipvs->sync_mutex);
>  	memcpy(val, valp, sizeof(val));
>  	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
>  	if (write) {
> @@ -1894,6 +1896,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
>  		else
>  			memcpy(valp, val, sizeof(val));
>  	}
> +	mutex_unlock(&ipvs->sync_mutex);
>  	return rc;
>  }
>  
> @@ -4321,6 +4324,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  	ipvs->sysctl_sync_threshold[0] = DEFAULT_SYNC_THRESHOLD;
>  	ipvs->sysctl_sync_threshold[1] = DEFAULT_SYNC_PERIOD;
>  	tbl[idx].data = &ipvs->sysctl_sync_threshold;
> +	tbl[idx].extra2 = ipvs;
>  	tbl[idx++].maxlen = sizeof(ipvs->sysctl_sync_threshold);
>  	ipvs->sysctl_sync_refresh_period = DEFAULT_SYNC_REFRESH_PERIOD;
>  	tbl[idx++].data = &ipvs->sysctl_sync_refresh_period;

Regards

--
Julian Anastasov <ja@ssi.bg>


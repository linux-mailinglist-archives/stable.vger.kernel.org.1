Return-Path: <stable+bounces-230138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOQcEGR1wmnqdAQAu9opvQ
	(envelope-from <stable+bounces-230138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:28:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D47307505
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BAB73085471
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C13E3D83;
	Tue, 24 Mar 2026 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i06DupKj"
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE042D5922;
	Tue, 24 Mar 2026 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351352; cv=none; b=q9SWfp/4AgVQRwaUzDq02wPljMj4ScQiPRGT+hd/5pgVNb0m3yYYNGYJySKxWl5F5UlDq3B/89Xm58tjqVHRRxWcEI9zzBbvjVl/Lkjh6JrDTbrNOTHeZOUilWAEiaxXt7frJ8dZKXrWqBD9ia0XcuG0J4pFCVszCqeMCMle1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351352; c=relaxed/simple;
	bh=0JcRo3UHHrIr/KGaixyboJ6ouTqPUVV8YCykw/D2f8E=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=gCMUDw36fc8oRkJ2KF6sDovKnua7B4lV8xuMD9z4q6IvA5a8Gojx+tIEUdUB3lR8VLXZ9J4s9Wb8Fdm1hCSCprXrnlBBMo2ThbPnedQXslIRP06DOoJKn9t/11qCjmjiycdBhw2UdUZSPYfA45eJgWGKzWXyT1mZ0N2wK1Xrh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i06DupKj; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774351339; h=Message-ID:Subject:Date:From:To;
	bh=OVb3zYyT8YTObrbTL1yZntWexibFBnvRHX4plD2H4LA=;
	b=i06DupKjAVGbAuzwrql0YHgrJBcXjRPAK5lrYpgI0ok2OLVTrkXkDQSSK4faI8N6Tt/j0/TnZOcNHnTP06snLmbrh3PfPt/k3pwucFZxkC0yNFkH3v8e9jAoU4QxWj41okPIC5keoMql90w2I/5TfuBO5an2Yh9zRbZI1beFBhg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.eHXz9_1774351338;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.eHXz9_1774351338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 19:22:18 +0800
Message-ID: <1774351331.0326343-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
Date: Tue, 24 Mar 2026 19:22:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: xietangxin <xietangxin@yeah.net>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 xietangxin <xietangxin@yeah.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
References: <20260312025406.15641-1-xietangxin@yeah.net>
In-Reply-To: <20260312025406.15641-1-xietangxin@yeah.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-230138-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[yeah.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,yeah.net,redhat.com,davemloft.net,google.com,kernel.org,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yeah.net:email,alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: B3D47307505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 10:54:06 +0800, xietangxin <xietangxin@yeah.net> wrote:
> A UAF issue occurs when the virtio_net driver is configured with napi_tx=N
> and the device's IFF_XMIT_DST_RELEASE flag is cleared
> (e.g., during the configuration of tc route filter rules).
>
> When IFF_XMIT_DST_RELEASE is removed from the net_device, the network stack
> expects the driver to hold the reference to skb->dst until the packet
> is fully transmitted and freed. In virtio_net with napi_tx=N,
> skbs may remain in the virtio transmit ring for an extended period.
>
> If the network namespace is destroyed while these skbs are still pending,
> the corresponding dst_ops structure has freed. When a subsequent packet
> is transmitted, free_old_xmit() is triggered to clean up old skbs.
> It then calls dst_release() on the skb associated with the stale dst_entry.
> Since the dst_ops (referenced by the dst_entry) has already been freed,
> a UAF kernel paging request occurs.
>
> fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
> the dst reference before the skb is queued in virtio_net.
>
> Call Trace:
>  Unable to handle kernel paging request at virtual address ffff80007e150000
>  CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc1+ #6 PREEMPT
>   ...
>   percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
>   dst_release+0xe0/0x110  net/core/dst.c:177
>   skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
>   sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
>   dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
>   napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
>   __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_net]
>   free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
>   start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
>   ...
>
> Reproduction Steps:
> NETDEV="enp3s0"
>
> config_qdisc_route_filter() {
>     tc qdisc del dev $NETDEV root
>     tc qdisc add dev $NETDEV root handle 1: prio
>     tc filter add dev $NETDEV parent 1:0 \
> 	protocol ip prio 100 route to 100 flowid 1:1
>     ip route add 192.168.1.100/32 dev $NETDEV realm 100
> }
>
> test_ns() {
>     ip netns add testns
>     ip link set $NETDEV netns testns
>     ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
>     ip netns exec testns ping -c 1 10.0.32.1
>     ip netns del testns
> }
>
> config_qdisc_route_filter
>
> test_ns
> sleep 2
> test_ns
>
> Fixes: f2fc6a54585a ("[NETNS][IPV6] route6 - move ip6_dst_ops inside the network namespace")
> Cc: stable@vger.kernel.org
> Signed-off-by: xietangxin <xietangxin@yeah.net>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> change in v2: add cc stable and fix tag
>
> v1: https://lore.kernel.org/all/20260307035110.7121-1-xietangxin@yeah.net/
> ---
>  drivers/net/virtio_net.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a..5b13a61b3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3351,6 +3351,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	/* Don't wait up for transmitted skbs to be freed. */
>  	if (!use_napi) {
>  		skb_orphan(skb);
> +		skb_dst_drop(skb);
>  		nf_reset_ct(skb);
>  	}
>
> --
> 2.43.0
>


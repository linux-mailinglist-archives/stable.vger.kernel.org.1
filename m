Return-Path: <stable+bounces-230137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPfaJDt0wmmncwQAu9opvQ
	(envelope-from <stable+bounces-230137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:23:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 376453073AE
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 942083047C94
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2913E5590;
	Tue, 24 Mar 2026 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jZSbPSl7"
X-Original-To: stable@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46301384241;
	Tue, 24 Mar 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351335; cv=none; b=qs5urduhfAKvwim4p+rNV4FNWjNNL69TtePvJMUQNcyh9jbt2brR/65Fb8HSnUGmmdtTA2SuQYpojq21AfJ1XHsKUOzcMZy7oTIihcTPidlTH0Bne/FlYZZizQhff9zNHufdF+Exakb66wAIWvAXk4/DM5muDSqGvwq2+eKBQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351335; c=relaxed/simple;
	bh=H3irzzFXP1QUhS0MEN06n7KdYszJkAZOu85FhuOsUlE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=lijp51B/RKolgWFDOg8al65FIDXWqGnIwMAv6cf1X3OKqVBFZFG/ZhU45oXLnqBymqXLvbTS7X6nd46q8bbz3nDueuLKB0SPkkEQSfFCVGruXUF6ENmfhW1+wDX3k1hxJukLYZ6/cXV7mcUEvq1ffgYp4LagYN4jH/+7JdCiVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jZSbPSl7; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774351325; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=cE5P4JOASd3UJaIvS7LJ8jdDwbmm6PYOejELrZOvIYM=;
	b=jZSbPSl7MfzIWeYzCoyYFZSqtRCtvkcPFJdkWE74cKWOcSx+WMfyksV9rt0lRUZbwsr5XFeGSAHF/JrX0lzn6ieJ8sJ/v3IMLQMsvlDGaQ+EtfS2XkrdOUevptaMzdur1IiywfkKhitDXxHgorZzdCW+hr7R/G4/FJO+73VNls4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.eM0GG_1774351324;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.eM0GG_1774351324 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 19:22:04 +0800
Message-ID: <1774351314.2550466-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
Date: Tue, 24 Mar 2026 19:21:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>
Cc: xietangxin <xietangxin@yeah.net>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
References: <20260312025406.15641-1-xietangxin@yeah.net>
 <1774335943.3427165-1-xuanzhuo@linux.alibaba.com>
 <CANn89iJYj9Jc8-usgAYcFMoSo+Po3aOxsMkhg+F8BA_kME2e9g@mail.gmail.com>
In-Reply-To: <CANn89iJYj9Jc8-usgAYcFMoSo+Po3aOxsMkhg+F8BA_kME2e9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230137-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[yeah.net,vger.kernel.org,lists.linux.dev,redhat.com,davemloft.net,kernel.org,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,yeah.net:email,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 376453073AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 00:46:27 -0700, Eric Dumazet <edumazet@google.com> wrot=
e:
> On Tue, Mar 24, 2026 at 12:11=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > On Thu, 12 Mar 2026 10:54:06 +0800, xietangxin <xietangxin@yeah.net> wr=
ote:
> > > A UAF issue occurs when the virtio_net driver is configured with napi=
_tx=3DN
> > > and the device's IFF_XMIT_DST_RELEASE flag is cleared
> > > (e.g., during the configuration of tc route filter rules).
> > >
> > > When IFF_XMIT_DST_RELEASE is removed from the net_device, the network=
 stack
> > > expects the driver to hold the reference to skb->dst until the packet
> > > is fully transmitted and freed. In virtio_net with napi_tx=3DN,
> > > skbs may remain in the virtio transmit ring for an extended period.
> > >
> > > If the network namespace is destroyed while these skbs are still pend=
ing,
> > > the corresponding dst_ops structure has freed. When a subsequent pack=
et
> > > is transmitted, free_old_xmit() is triggered to clean up old skbs.
> > > It then calls dst_release() on the skb associated with the stale dst_=
entry.
> > > Since the dst_ops (referenced by the dst_entry) has already been free=
d,
> > > a UAF kernel paging request occurs.
> >
> > Sorry, this sounds a bit off to me. We know that napi_tx=3DN merely pro=
longs the
> > presence of the skb on the device side. However, even without napi_tx=
=3DN, there
> > is no guarantee that the skb will be freed within any specific timefram=
e.
> > Therefore, napi_tx=3DN just makes the issue more reproducible; it is no=
t the root
> > cause. Also, I'm surprised that the dst could be freed while it is still
> > referenced/held. I have a feeling that something is being overlooked he=
re.
> >
> > Thanks.
> >
> > >
> > > fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
> > > the dst reference before the skb is queued in virtio_net.
> > >
> > > Call Trace:
> > >  Unable to handle kernel paging request at virtual address ffff80007e=
150000
> > >  CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-r=
c1+ #6 PREEMPT
> > >   ...
> > >   percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
> > >   dst_release+0xe0/0x110  net/core/dst.c:177
> > >   skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
> > >   sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
> > >   dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
> > >   napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
> > >   __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_n=
et]
> > >   free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
> > >   start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
> > >   ...
> > >
> > > Reproduction Steps:
> > > NETDEV=3D"enp3s0"
> > >
> > > config_qdisc_route_filter() {
> > >     tc qdisc del dev $NETDEV root
> > >     tc qdisc add dev $NETDEV root handle 1: prio
> > >     tc filter add dev $NETDEV parent 1:0 \
> > >       protocol ip prio 100 route to 100 flowid 1:1
> > >     ip route add 192.168.1.100/32 dev $NETDEV realm 100
> > > }
> > >
> > > test_ns() {
> > >     ip netns add testns
> > >     ip link set $NETDEV netns testns
> > >     ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
> > >     ip netns exec testns ping -c 1 10.0.32.1
> > >     ip netns del testns
> > > }
> > >
> > > config_qdisc_route_filter
> > >
> > > test_ns
> > > sleep 2
> > > test_ns
>
> I took a stab at this, please look at
>
> https://lore.kernel.org/netdev/20260324073750.1500328-1-edumazet@google.c=
om/T/#u

I see.

Thanks.


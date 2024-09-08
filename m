Return-Path: <stable+bounces-73932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB6C9709A4
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 22:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11771F21E07
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 20:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3A178399;
	Sun,  8 Sep 2024 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djxeE5bW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04F2B9CD;
	Sun,  8 Sep 2024 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725826188; cv=none; b=ga64NYLp14/zK9p6k+3+vh0geL/xjKE4XLT6FQ+LzA5CIK8Oks912GB+Chzks92r6heYodJtPm9SM6k8puTYRDZWNVe3E1Xz/zb3z88+NtIi5XtgOIYTJkH64j+tOVRNEQl6zoa3soyrwyoWJixMKlqCpVbEM3YNCK7P3WY+Qjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725826188; c=relaxed/simple;
	bh=QCm+6cy/vZUyWMcoMTIrU3cvkO3zQ485/UHI6+GnQ3E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hJOFV+hb5/t8pO+pUHvncSFe9Em7yPgs/AJzIz1P6EpFXaPhiTU0S9vP6D3nxxHS0zISZCswIRYTD+DizYb6cM9asHsHaKEw1dc5GlXRv2VTJwqOnT6ZWY3UxeYji5iF1K7Akdd3V+FL6cLV7ZsPBT6O3k+6kEs/DiKxnBhsZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djxeE5bW; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6b747f2e2b7so34024867b3.3;
        Sun, 08 Sep 2024 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725826185; x=1726430985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lD7B6vCmqTfOGtkqxrywAUplE3mEEBdxs1G9FM3+T4=;
        b=djxeE5bW1zhtzpn0Hz1ROKyZeDSxZ5BMx1NFUAUWHDiY91GMYybISYxzZvEyLsq5Fn
         HRZdBWAujvG3CT2rz2akV21edbZ8pYDi1Yu2Cn9dqRBVfs/gZFCPopRVxZq5zj2R5gX4
         jusCPqEfkRHtW0M1arJQ3XJU5qrW1vjKGsChEQ6tsMDOcZxzgerY6YI8wZKo9pTBT7Rw
         NG774gYnsrGdNYbJhVayfFg8gEZPyzxYfZmr3q2VMsicXxA+v9oIE22jUF53jFXa0DTX
         //7nXjVyMHhhI/zvDC4bYi8gQfB9kEJXpy5BINxg0UeBHM13jNZSi+4BgmlOjIeMTPBP
         HUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725826185; x=1726430985;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5lD7B6vCmqTfOGtkqxrywAUplE3mEEBdxs1G9FM3+T4=;
        b=EZGRRqXbg33m6BwitjIbb4uSSpPrGfftNvb6GIwBcmdwFs28A3knhNMVVfArec548M
         ken93kC941ndSUPtxmXMsmUaXi6r6vbhyFfOlbs8cPLXNFvonZSkX9FmdshbYEqU4UCM
         YUScw8w4wepvGbBN1fVjjqAJWZ2RL5Qv9G+LynEjuHMJxy8IS/WGdwEQTbglWrcet5Ta
         y61cT0HOj1qEDFrqCaRvrg0njRHByYN3tQlwCCC+2GWgoZzZV9S85ACjIaPcqZ3/2nU9
         M8vKn68iifYgSfYW7nMQXNfiJMIUAvx1uIPwZJX8ka4pS8W+XzaUbeUseP7ZVgsYYaSC
         LkGw==
X-Forwarded-Encrypted: i=1; AJvYcCU/VtJsNIfUavDg0Gt8ssFlYu+u2uecnfq9KuyBnd9lykFNahPsuDkg8VSXynFXDgnVigSNOjxY@vger.kernel.org, AJvYcCVv21GXSMIm3RuDUv/3y4kltMvGKyQYclBRpNMEO6UH1ZSXTO+PiGEapFDstbPmJDuR2pq+Po0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFoqNFq9sIsxnhAdsy4AYs7IyVc6v3KVb3pkbwvuKmi2NMM7bW
	I+94yvcKZg4tXiEJ3p6hqnRA302zsf1JnI6F6CLKH21+ouVhGhe+
X-Google-Smtp-Source: AGHT+IGDFQiEVi1LOsQVrMe7ZEaIYv1lnB2ovnfKznzR0pSh1y42yY9Ha0RUD/f/r63gd8yicPKxRA==
X-Received: by 2002:a05:690c:9:b0:6db:4809:ed4e with SMTP id 00721157ae682-6db4809eddemr98491847b3.22.1725826184814;
        Sun, 08 Sep 2024 13:09:44 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1d647sm152416585a.105.2024.09.08.13.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 13:09:44 -0700 (PDT)
Date: Sun, 08 Sep 2024 16:09:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Szabolcs Nagy <szabolcs.nagy@arm.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 arefev@swemel.ru, 
 alexander.duyck@gmail.com, 
 Willem de Bruijn <willemb@google.com>, 
 stable@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Felix Fietkau <nbd@nbd.name>, 
 Mark Brown <broonie@kernel.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 nd@arm.com
Message-ID: <66de0487cfa91_30614529470@willemb.c.googlers.com.notmuch>
In-Reply-To: <66db2542cfeaa_29a385294b9@willemb.c.googlers.com.notmuch>
References: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
 <ZtsTGp9FounnxZaN@arm.com>
 <66db2542cfeaa_29a385294b9@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net v2] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Szabolcs Nagy wrote:
> > The 07/29/2024 16:10, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > > 
> > > Tighten csum_start and csum_offset checks in virtio_net_hdr_to_skb
> > > for GSO packets.
> > > 
> > > The function already checks that a checksum requested with
> > > VIRTIO_NET_HDR_F_NEEDS_CSUM is in skb linear. But for GSO packets
> > > this might not hold for segs after segmentation.
> > > 
> > > Syzkaller demonstrated to reach this warning in skb_checksum_help
> > > 
> > > 	offset = skb_checksum_start_offset(skb);
> > > 	ret = -EINVAL;
> > > 	if (WARN_ON_ONCE(offset >= skb_headlen(skb)))
> > > 
> > > By injecting a TSO packet:
> > > 
> > > WARNING: CPU: 1 PID: 3539 at net/core/dev.c:3284 skb_checksum_help+0x3d0/0x5b0
> > >  ip_do_fragment+0x209/0x1b20 net/ipv4/ip_output.c:774
> > >  ip_finish_output_gso net/ipv4/ip_output.c:279 [inline]
> > >  __ip_finish_output+0x2bd/0x4b0 net/ipv4/ip_output.c:301
> > >  iptunnel_xmit+0x50c/0x930 net/ipv4/ip_tunnel_core.c:82
> > >  ip_tunnel_xmit+0x2296/0x2c70 net/ipv4/ip_tunnel.c:813
> > >  __gre_xmit net/ipv4/ip_gre.c:469 [inline]
> > >  ipgre_xmit+0x759/0xa60 net/ipv4/ip_gre.c:661
> > >  __netdev_start_xmit include/linux/netdevice.h:4850 [inline]
> > >  netdev_start_xmit include/linux/netdevice.h:4864 [inline]
> > >  xmit_one net/core/dev.c:3595 [inline]
> > >  dev_hard_start_xmit+0x261/0x8c0 net/core/dev.c:3611
> > >  __dev_queue_xmit+0x1b97/0x3c90 net/core/dev.c:4261
> > >  packet_snd net/packet/af_packet.c:3073 [inline]
> > > 
> > > The geometry of the bad input packet at tcp_gso_segment:
> > > 
> > > [   52.003050][ T8403] skb len=12202 headroom=244 headlen=12093 tailroom=0
> > > [   52.003050][ T8403] mac=(168,24) mac_len=24 net=(192,52) trans=244
> > > [   52.003050][ T8403] shinfo(txflags=0 nr_frags=1 gso(size=1552 type=3 segs=0))
> > > [   52.003050][ T8403] csum(0x60000c7 start=199 offset=1536
> > > ip_summed=3 complete_sw=0 valid=0 level=0)
> > > 
> > > Mitigate with stricter input validation.
> > > 
> > > csum_offset: for GSO packets, deduce the correct value from gso_type.
> > > This is already done for USO. Extend it to TSO. Let UFO be:
> > > udp[46]_ufo_fragment ignores these fields and always computes the
> > > checksum in software.
> > > 
> > > csum_start: finding the real offset requires parsing to the transport
> > > header. Do not add a parser, use existing segmentation parsing. Thanks
> > > to SKB_GSO_DODGY, that also catches bad packets that are hw offloaded.
> > > Again test both TSO and USO. Do not test UFO for the above reason, and
> > > do not test UDP tunnel offload.
> > > 
> > > GSO packet are almost always CHECKSUM_PARTIAL. USO packets may be
> > > CHECKSUM_NONE since commit 10154dbded6d6 ("udp: Allow GSO transmit
> > > from devices with no checksum offload"), but then still these fields
> > > are initialized correctly in udp4_hwcsum/udp6_hwcsum_outgoing. So no
> > > need to test for ip_summed == CHECKSUM_PARTIAL first.
> > > 
> > > This revises an existing fix mentioned in the Fixes tag, which broke
> > > small packets with GSO offload, as detected by kselftests.
> > > 
> > > Link: https://syzkaller.appspot.com/bug?extid=e1db31216c789f552871
> > > Link: https://lore.kernel.org/netdev/20240723223109.2196886-1-kuba@kernel.org
> > > Fixes: e269d79c7d35 ("net: missing check virtio")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > 
> > > ---
> > > 
> > > v1->v2
> > >   - skb_transport_header instead of skb->transport_header (edumazet@)
> > >   - typo: migitate -> mitigate
> > > ---
> > 
> > this breaks booting from nfs root on an arm64 fvp
> > model for me.
> > 
> > i see two fixup commits
> > 
> > commit 30b03f2a0592eee1267298298eac9dd655f55ab2
> > Author:     Jakub Sitnicki <jakub@cloudflare.com>
> > AuthorDate: 2024-08-08 11:56:22 +0200
> > Commit:     Jakub Kicinski <kuba@kernel.org>
> > CommitDate: 2024-08-09 21:58:08 -0700
> > 
> >     udp: Fall back to software USO if IPv6 extension headers are present
> > 
> > and
> > 
> > commit b128ed5ab27330deeeaf51ea8bb69f1442a96f7f
> > Author:     Felix Fietkau <nbd@nbd.name>
> > AuthorDate: 2024-08-19 17:06:21 +0200
> > Commit:     Jakub Kicinski <kuba@kernel.org>
> > CommitDate: 2024-08-21 17:15:05 -0700
> > 
> >     udp: fix receiving fraglist GSO packets
> > 
> > but they don't fix the issue for me,
> > at the boot console i see
> > 
> > ...
> > [    3.686846] Sending DHCP requests ., OK
> > [    3.687302] IP-Config: Got DHCP answer from 172.20.51.254, my address is 172.20.51.1
> > [    3.687423] IP-Config: Complete:
> > [    3.687482]      device=eth0, hwaddr=ea:0d:79:71:af:cd, ipaddr=172.20.51.1, mask=255.255.255.0, gw=172.20.51.254
> > [    3.687631]      host=172.20.51.1, domain=, nis-domain=(none)
> > [    3.687719]      bootserver=172.20.51.254, rootserver=10.2.80.41, rootpath=
> > [    3.687771]      nameserver0=172.20.51.254, nameserver1=172.20.51.252, nameserver2=172.20.51.251
> > [    3.689075] clk: Disabling unused clocks
> > [    3.689167] PM: genpd: Disabling unused power domains
> > [    3.689258] ALSA device list:
> > [    3.689330]   No soundcards found.
> > [    3.716297] VFS: Mounted root (nfs4 filesystem) on device 0:24.
> > [    3.716843] devtmpfs: mounted
> > [    3.734352] Freeing unused kernel memory: 10112K
> > [    3.735178] Run /sbin/init as init process
> > [    3.743770] eth0: bad gso: type: 1, size: 1440
> > [    3.744186] eth0: bad gso: type: 1, size: 1440
> > ...
> > [  154.610991] eth0: bad gso: type: 1, size: 1440
> > [  185.330941] nfs: server 10.2.80.41 not responding, still trying
> > ...
> > 
> > the "bad gso" message keeps repeating and init
> > is not executed.
> > 
> > if i revert the 3 patches above on 6.11-rc6 then
> > init runs without "bad gso" error.
> > 
> > this affects testing the arm64-gcs patches on
> > top of 6.11-rc3 and 6.11-rc6
> > 
> > not sure if this is an fvp or kernel bug.
> 
> Thanks for the report, sorry that you're encountering this breakage.
> 
> Makes sense that this commit introduced it
> 
>         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
>                                   virtio_is_little_endian(vi->vdev))) {
>                 net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
>                                      dev->name, hdr->hdr.gso_type,
>                                      hdr->hdr.gso_size);
>                 goto frame_err;
>         }
>         
> Type 1 is VIRTIO_NET_HDR_GSO_TCPV4
> 
> Most likely this application is inserting a packet with flag
> VIRTIO_NET_HDR_F_NEEDS_CSUM and a wrong csum_start. Or is requesting
> TSO without checksum offload at all. In which case the kernel goes out
> of its way to find the right offset, but may fail.
> 
> Which nfs-client is this? I'd like to take a look at the sourcecode.
> 
> Unfortunately the kernel warning lacks a few useful pieces of data,
> such as the other virtio_net_hdr fields and the packet length.

This happens on the virtio-net receive path, so the bad data is
received from the hypervisor.

From what I gather that arm64 fvp (Fixed Virtual Platforms) hypervisor
is closed source?

Disabling GRO on this device will likely work as temporary workaround.

What we can do is instead of dropping packets to correct their offset:

                case SKB_GSO_TCPV4:
                case SKB_GSO_TCPV6:
-                        if (skb->csum_offset != offsetof(struct tcphdr, check))
-                                return -EINVAL;
+                        if (skb->csum_offset != offsetof(struct tcphdr, check)) {
+                                DEBUG_NET_WARN_ON_ONCE(1);
+                                skb->csum_offset = offsetof(struct tcphdr, check);
+                        }

If the issue is in csum_offset. If the new csum_start check fails,
that won't help.

It would be helpful to see these values at this point, e.g., with
skb_dump(KERN_INFO, skb, false);


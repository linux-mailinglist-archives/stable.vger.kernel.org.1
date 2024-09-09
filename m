Return-Path: <stable+bounces-73993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFD4971475
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3681F23826
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 09:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C401B3733;
	Mon,  9 Sep 2024 09:52:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from port70.net (port70.net [81.7.13.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFFD1B0107;
	Mon,  9 Sep 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.7.13.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875543; cv=none; b=lYXq5Kt1pNdeStaJIqW6wm2V8+ciFc+89jTly2fTIVt4BRdYhJRDoyxSZLAzos9C2/OLcjzVSKl02AGMTSXlbqlqf/wpSlgF5AFaGGxrnUUvx2Jhbu/lPLnhUqRNEw6I8KzDOJ3IcS6itzeXRy+xKLul5I4X5Q1MozF7PAKCpl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875543; c=relaxed/simple;
	bh=M8sb/PsgH6GywjheuqRbGJHO9C6dffq+g1GeO45Gbkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX7a9BKbBtZSdMKb2UHvKZ83QQYS6qpGWkyKIyG459RDZIdbbGEw8+QzOF7BMXho6aITw3PH0Texgb4yl03JrKFgbp66hKG6O30VkK/MEWS0amaHVConf8LUQ/b2r8IsNzlNwGdIMUZkhE6dCFdVwj4Bwp7aXXVBojcyuuxLDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=port70.net; spf=pass smtp.mailfrom=port70.net; arc=none smtp.client-ip=81.7.13.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=port70.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=port70.net
Received: by port70.net (Postfix, from userid 1002)
	id 9A289ABEC0C7; Mon,  9 Sep 2024 11:45:27 +0200 (CEST)
Date: Mon, 9 Sep 2024 11:45:27 +0200
From: Szabolcs Nagy <nsz@port70.net>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
	arefev@swemel.ru, alexander.duyck@gmail.com,
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, Felix Fietkau <nbd@nbd.name>,
	Mark Brown <broonie@kernel.org>,
	Yury Khrustalev <yury.khrustalev@arm.com>, nd@arm.com
Subject: Re: [PATCH net v2] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <20240909094527.GA3048202@port70.net>
References: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
 <ZtsTGp9FounnxZaN@arm.com>
 <66db2542cfeaa_29a385294b9@willemb.c.googlers.com.notmuch>
 <66de0487cfa91_30614529470@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66de0487cfa91_30614529470@willemb.c.googlers.com.notmuch>

* Willem de Bruijn <willemdebruijn.kernel@gmail.com> [2024-09-08 16:09:43 -0400]:
> Willem de Bruijn wrote:
> > Szabolcs Nagy wrote:
> > > The 07/29/2024 16:10, Willem de Bruijn wrote:
> > > > From: Willem de Bruijn <willemb@google.com>
> > > > 
> > > > Tighten csum_start and csum_offset checks in virtio_net_hdr_to_skb
> > > > for GSO packets.
> > > > 
> > > > The function already checks that a checksum requested with
> > > > VIRTIO_NET_HDR_F_NEEDS_CSUM is in skb linear. But for GSO packets
> > > > this might not hold for segs after segmentation.
> > > > 
> > > > Syzkaller demonstrated to reach this warning in skb_checksum_help
> > > > 
> > > > 	offset = skb_checksum_start_offset(skb);
> > > > 	ret = -EINVAL;
> > > > 	if (WARN_ON_ONCE(offset >= skb_headlen(skb)))
> > > > 
> > > > By injecting a TSO packet:
> > > > 
> > > > WARNING: CPU: 1 PID: 3539 at net/core/dev.c:3284 skb_checksum_help+0x3d0/0x5b0
> > > >  ip_do_fragment+0x209/0x1b20 net/ipv4/ip_output.c:774
> > > >  ip_finish_output_gso net/ipv4/ip_output.c:279 [inline]
> > > >  __ip_finish_output+0x2bd/0x4b0 net/ipv4/ip_output.c:301
> > > >  iptunnel_xmit+0x50c/0x930 net/ipv4/ip_tunnel_core.c:82
> > > >  ip_tunnel_xmit+0x2296/0x2c70 net/ipv4/ip_tunnel.c:813
> > > >  __gre_xmit net/ipv4/ip_gre.c:469 [inline]
> > > >  ipgre_xmit+0x759/0xa60 net/ipv4/ip_gre.c:661
> > > >  __netdev_start_xmit include/linux/netdevice.h:4850 [inline]
> > > >  netdev_start_xmit include/linux/netdevice.h:4864 [inline]
> > > >  xmit_one net/core/dev.c:3595 [inline]
> > > >  dev_hard_start_xmit+0x261/0x8c0 net/core/dev.c:3611
> > > >  __dev_queue_xmit+0x1b97/0x3c90 net/core/dev.c:4261
> > > >  packet_snd net/packet/af_packet.c:3073 [inline]
> > > > 
> > > > The geometry of the bad input packet at tcp_gso_segment:
> > > > 
> > > > [   52.003050][ T8403] skb len=12202 headroom=244 headlen=12093 tailroom=0
> > > > [   52.003050][ T8403] mac=(168,24) mac_len=24 net=(192,52) trans=244
> > > > [   52.003050][ T8403] shinfo(txflags=0 nr_frags=1 gso(size=1552 type=3 segs=0))
> > > > [   52.003050][ T8403] csum(0x60000c7 start=199 offset=1536
> > > > ip_summed=3 complete_sw=0 valid=0 level=0)
> > > > 
> > > > Mitigate with stricter input validation.
> > > > 
> > > > csum_offset: for GSO packets, deduce the correct value from gso_type.
> > > > This is already done for USO. Extend it to TSO. Let UFO be:
> > > > udp[46]_ufo_fragment ignores these fields and always computes the
> > > > checksum in software.
> > > > 
> > > > csum_start: finding the real offset requires parsing to the transport
> > > > header. Do not add a parser, use existing segmentation parsing. Thanks
> > > > to SKB_GSO_DODGY, that also catches bad packets that are hw offloaded.
> > > > Again test both TSO and USO. Do not test UFO for the above reason, and
> > > > do not test UDP tunnel offload.
> > > > 
> > > > GSO packet are almost always CHECKSUM_PARTIAL. USO packets may be
> > > > CHECKSUM_NONE since commit 10154dbded6d6 ("udp: Allow GSO transmit
> > > > from devices with no checksum offload"), but then still these fields
> > > > are initialized correctly in udp4_hwcsum/udp6_hwcsum_outgoing. So no
> > > > need to test for ip_summed == CHECKSUM_PARTIAL first.
> > > > 
> > > > This revises an existing fix mentioned in the Fixes tag, which broke
> > > > small packets with GSO offload, as detected by kselftests.
> > > > 
> > > > Link: https://syzkaller.appspot.com/bug?extid=e1db31216c789f552871
> > > > Link: https://lore.kernel.org/netdev/20240723223109.2196886-1-kuba@kernel.org
> > > > Fixes: e269d79c7d35 ("net: missing check virtio")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > 
> > > > ---
> > > > 
> > > > v1->v2
> > > >   - skb_transport_header instead of skb->transport_header (edumazet@)
> > > >   - typo: migitate -> mitigate
> > > > ---
> > > 
> > > this breaks booting from nfs root on an arm64 fvp
> > > model for me.
> > > 
> > > i see two fixup commits
> > > 
> > > commit 30b03f2a0592eee1267298298eac9dd655f55ab2
> > > Author:     Jakub Sitnicki <jakub@cloudflare.com>
> > > AuthorDate: 2024-08-08 11:56:22 +0200
> > > Commit:     Jakub Kicinski <kuba@kernel.org>
> > > CommitDate: 2024-08-09 21:58:08 -0700
> > > 
> > >     udp: Fall back to software USO if IPv6 extension headers are present
> > > 
> > > and
> > > 
> > > commit b128ed5ab27330deeeaf51ea8bb69f1442a96f7f
> > > Author:     Felix Fietkau <nbd@nbd.name>
> > > AuthorDate: 2024-08-19 17:06:21 +0200
> > > Commit:     Jakub Kicinski <kuba@kernel.org>
> > > CommitDate: 2024-08-21 17:15:05 -0700
> > > 
> > >     udp: fix receiving fraglist GSO packets
> > > 
> > > but they don't fix the issue for me,
> > > at the boot console i see
> > > 
> > > ...
> > > [    3.686846] Sending DHCP requests ., OK
> > > [    3.687302] IP-Config: Got DHCP answer from 172.20.51.254, my address is 172.20.51.1
> > > [    3.687423] IP-Config: Complete:
> > > [    3.687482]      device=eth0, hwaddr=ea:0d:79:71:af:cd, ipaddr=172.20.51.1, mask=255.255.255.0, gw=172.20.51.254
> > > [    3.687631]      host=172.20.51.1, domain=, nis-domain=(none)
> > > [    3.687719]      bootserver=172.20.51.254, rootserver=10.2.80.41, rootpath=
> > > [    3.687771]      nameserver0=172.20.51.254, nameserver1=172.20.51.252, nameserver2=172.20.51.251
> > > [    3.689075] clk: Disabling unused clocks
> > > [    3.689167] PM: genpd: Disabling unused power domains
> > > [    3.689258] ALSA device list:
> > > [    3.689330]   No soundcards found.
> > > [    3.716297] VFS: Mounted root (nfs4 filesystem) on device 0:24.
> > > [    3.716843] devtmpfs: mounted
> > > [    3.734352] Freeing unused kernel memory: 10112K
> > > [    3.735178] Run /sbin/init as init process
> > > [    3.743770] eth0: bad gso: type: 1, size: 1440
> > > [    3.744186] eth0: bad gso: type: 1, size: 1440
> > > ...
> > > [  154.610991] eth0: bad gso: type: 1, size: 1440
> > > [  185.330941] nfs: server 10.2.80.41 not responding, still trying
> > > ...
> > > 
> > > the "bad gso" message keeps repeating and init
> > > is not executed.
> > > 
> > > if i revert the 3 patches above on 6.11-rc6 then
> > > init runs without "bad gso" error.
> > > 
> > > this affects testing the arm64-gcs patches on
> > > top of 6.11-rc3 and 6.11-rc6
> > > 
> > > not sure if this is an fvp or kernel bug.
> > 
> > Thanks for the report, sorry that you're encountering this breakage.
> > 
> > Makes sense that this commit introduced it
> > 
> >         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> >                                   virtio_is_little_endian(vi->vdev))) {
> >                 net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> >                                      dev->name, hdr->hdr.gso_type,
> >                                      hdr->hdr.gso_size);
> >                 goto frame_err;
> >         }
> >         
> > Type 1 is VIRTIO_NET_HDR_GSO_TCPV4
> > 
> > Most likely this application is inserting a packet with flag
> > VIRTIO_NET_HDR_F_NEEDS_CSUM and a wrong csum_start. Or is requesting
> > TSO without checksum offload at all. In which case the kernel goes out
> > of its way to find the right offset, but may fail.
> > 
> > Which nfs-client is this? I'd like to take a look at the sourcecode.
> > 
> > Unfortunately the kernel warning lacks a few useful pieces of data,
> > such as the other virtio_net_hdr fields and the packet length.
> 
> This happens on the virtio-net receive path, so the bad data is
> received from the hypervisor.
> 
> >From what I gather that arm64 fvp (Fixed Virtual Platforms) hypervisor
> is closed source?
> 
> Disabling GRO on this device will likely work as temporary workaround.
> 
> What we can do is instead of dropping packets to correct their offset:
> 
>                 case SKB_GSO_TCPV4:
>                 case SKB_GSO_TCPV6:
> -                        if (skb->csum_offset != offsetof(struct tcphdr, check))
> -                                return -EINVAL;
> +                        if (skb->csum_offset != offsetof(struct tcphdr, check)) {
> +                                DEBUG_NET_WARN_ON_ONCE(1);
> +                                skb->csum_offset = offsetof(struct tcphdr, check);
> +                        }
> 
> If the issue is in csum_offset. If the new csum_start check fails,
> that won't help.
> 
> It would be helpful to see these values at this point, e.g., with
> skb_dump(KERN_INFO, skb, false);

thanks for the quick response.

i sent this issue on my last day at the company so
i won't be able to help with this any more, sorry.

fvp is closed source but has freely available binaries
for x86_64 glibc based linux systems (behind registration
and license agreements) so in principle the issue can be
reproduced outside of arm but using fvp is not obvious.

hopefully somebody at arm can pick it up or at least
report this thread to the fvp team internally.


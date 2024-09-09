Return-Path: <stable+bounces-73944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB743970C65
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 05:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8861F22438
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 03:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A2F14F135;
	Mon,  9 Sep 2024 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTkC2ZlI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F883BA42;
	Mon,  9 Sep 2024 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725853201; cv=none; b=CN7Zkf42ApVt/hG+LHOq8AePg0SL2LeIvreKR7IXwV4WY7bYq4r0UjG4mAjLRlj3JNeP3JqOTAh6+DCdLX82PXcoIlQbvC1vPKaDXctLDZUvSlmHlMcCzhkhbIkrt/pLdUSgk3WsY9QK+KgLNKs0K2tufe7OME9k86tULp2c6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725853201; c=relaxed/simple;
	bh=CQCpS7bG2nfi4SI/2yhFV7oKRSRMAjFIbcUBYvKXhc4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=V64j7rxH90bajAkrzlEAI/CVt5vO6Jv+TAwAZzQV3T2bvJ1ter5aPzzitOgkfM0PCy0rXOlpuZ/CziaiT0o+oy3Scc7ht/k1YrVI6DWB8kiH6hjqEQPj2Gay4ZwRBwK9NahTkZQsPC7eGll1BQPuA8jQiYYX6gHcEO2K6Ebmuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTkC2ZlI; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9ad15d11bso125039685a.0;
        Sun, 08 Sep 2024 20:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725853198; x=1726457998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIq0qc5j1crrvs9V2IB5CRNaB0SGz1K+V9y32siHP2I=;
        b=BTkC2ZlI5mMyypePI/gHA3F9fhsoXopUNLp2YkI5t+4gQF389tNbAGWhEyeetAVA4t
         vNAcImodhHRU30NfOjsorunH3fAzc/jOiWqZqgQ65aUskjxu4LlMZKKL9EB+F2fsPykd
         Ub61jPWHuoRvEsE/VnYHX6Np0vK0wr1w2f/aTxjEvCF3L0InQut8hC4lciiOnYSurpSg
         6ODJ/CxO2/ap2QncBy4WWQs2g0Yh2HFE7hUf9f/h2zrolUfjVakMhqpCz+0lrM6SEQzU
         ImAngKL0B9u5RHJ1pRicqZxSommXjClCFYr5EonLoJuKxFZASQQqVrpVNPqQ1maAvQLD
         5XZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725853198; x=1726457998;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sIq0qc5j1crrvs9V2IB5CRNaB0SGz1K+V9y32siHP2I=;
        b=XOxsW+hCWs/9UXuIao6oJsj5bKj4Lhguj+511qLxEkg0dXFTOjfYfuI2059+xLuGl4
         8rNpxWkyi5ZH9i/eXbh9BP2Qe4z1NqVQJ1YpPn2Czx9XYv7jpfaJOnr35qr3ELB9ZfWm
         mKSEagCXbonpT+UN5wN1HdQr7ZRnUF9u6trGWV1+qJBWBXB+65y8aDJNMR3n2OKlNplC
         idHF+FWB1oh3gdL3gwlZAilnCzTdWtbRnRK6IeTVw2GDmqF8ZxoWvDdFsgMdUHc5Da4G
         q0hvGzLRDsI/6j+sDscwQt/njw3hpYnXd2PrjD7Ujyp0xKpJB7n//SLnaY3P6Y4L09IA
         KCwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfX9KQXNZROBj7XbRCDG29UGXhl9KypnKw/CrhUG35Bnq86Pmfdnuz70QX1ODT0RbBo3i/SOVo@vger.kernel.org, AJvYcCXNA5VQSLV8q8hR6aNLj75eHJbJ8TtTj1Uw1tFZp5dk4gNKBelEnOqQc0bsOwpqSbIi3kQK/do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/V8ZmQNeN86x2I5v7lDte1rfnJCOSgbzDUG7vxpbcqyAF+Xnz
	x9k4YHNPlCihKVonKgonsDRc4a3HxUZCNPuNeSwlgXYUkdqIm1NB
X-Google-Smtp-Source: AGHT+IF2UQNswQwwe1r7ssl+Q735aVKrMsEVxI6qvr/SF7M9+2kSqElouW2o8GfW4rayrmzLvbjpzw==
X-Received: by 2002:a05:620a:1728:b0:7a9:af25:802d with SMTP id af79cd13be357-7a9af258469mr690118685a.40.1725853198019;
        Sun, 08 Sep 2024 20:39:58 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7967e7asm178874985a.38.2024.09.08.20.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 20:39:57 -0700 (PDT)
Date: Sun, 08 Sep 2024 23:39:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Szabolcs Nagy <szabolcs.nagy@arm.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 arefev@swemel.ru, 
 alexander.duyck@gmail.com, 
 Willem de Bruijn <willemb@google.com>, 
 stable@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Felix Fietkau <nbd@nbd.name>, 
 Mark Brown <broonie@kernel.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 nd@arm.com
Message-ID: <66de6e0d26a4a_ec892942@willemb.c.googlers.com.notmuch>
In-Reply-To: <CACGkMEtu3c3xVWukFnGriOk4UjKyMVKU7gNQ5v38nHy1q2=DpQ@mail.gmail.com>
References: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
 <ZtsTGp9FounnxZaN@arm.com>
 <66db2542cfeaa_29a385294b9@willemb.c.googlers.com.notmuch>
 <66de0487cfa91_30614529470@willemb.c.googlers.com.notmuch>
 <20240908164252-mutt-send-email-mst@kernel.org>
 <CACGkMEtchtLYAVgUYGFt3e-1UjNBy+h0Kv-7K3dRiiKEr7gnKw@mail.gmail.com>
 <66de653b4e0f9_cd37294c3@willemb.c.googlers.com.notmuch>
 <CACGkMEtu3c3xVWukFnGriOk4UjKyMVKU7gNQ5v38nHy1q2=DpQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

Jason Wang wrote:
> On Mon, Sep 9, 2024 at 11:02=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Wang wrote:
> > > On Mon, Sep 9, 2024 at 4:44=E2=80=AFAM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > >
> > > > On Sun, Sep 08, 2024 at 04:09:43PM -0400, Willem de Bruijn wrote:=

> > > > > Willem de Bruijn wrote:
> > > > > > Szabolcs Nagy wrote:
> > > > > > > The 07/29/2024 16:10, Willem de Bruijn wrote:
> > > > > > > > From: Willem de Bruijn <willemb@google.com>
> > > > > > > >
> > > > > > > > Tighten csum_start and csum_offset checks in virtio_net_h=
dr_to_skb
> > > > > > > > for GSO packets.
> > > > > > > >
> > > > > > > > The function already checks that a checksum requested wit=
h
> > > > > > > > VIRTIO_NET_HDR_F_NEEDS_CSUM is in skb linear. But for GSO=
 packets
> > > > > > > > this might not hold for segs after segmentation.
> > > > > > > >
> > > > > > > > Syzkaller demonstrated to reach this warning in skb_check=
sum_help
> > > > > > > >
> > > > > > > >         offset =3D skb_checksum_start_offset(skb);
> > > > > > > >         ret =3D -EINVAL;
> > > > > > > >         if (WARN_ON_ONCE(offset >=3D skb_headlen(skb)))
> > > > > > > >
> > > > > > > > By injecting a TSO packet:
> > > > > > > >
> > > > > > > > WARNING: CPU: 1 PID: 3539 at net/core/dev.c:3284 skb_chec=
ksum_help+0x3d0/0x5b0
> > > > > > > >  ip_do_fragment+0x209/0x1b20 net/ipv4/ip_output.c:774
> > > > > > > >  ip_finish_output_gso net/ipv4/ip_output.c:279 [inline]
> > > > > > > >  __ip_finish_output+0x2bd/0x4b0 net/ipv4/ip_output.c:301
> > > > > > > >  iptunnel_xmit+0x50c/0x930 net/ipv4/ip_tunnel_core.c:82
> > > > > > > >  ip_tunnel_xmit+0x2296/0x2c70 net/ipv4/ip_tunnel.c:813
> > > > > > > >  __gre_xmit net/ipv4/ip_gre.c:469 [inline]
> > > > > > > >  ipgre_xmit+0x759/0xa60 net/ipv4/ip_gre.c:661
> > > > > > > >  __netdev_start_xmit include/linux/netdevice.h:4850 [inli=
ne]
> > > > > > > >  netdev_start_xmit include/linux/netdevice.h:4864 [inline=
]
> > > > > > > >  xmit_one net/core/dev.c:3595 [inline]
> > > > > > > >  dev_hard_start_xmit+0x261/0x8c0 net/core/dev.c:3611
> > > > > > > >  __dev_queue_xmit+0x1b97/0x3c90 net/core/dev.c:4261
> > > > > > > >  packet_snd net/packet/af_packet.c:3073 [inline]
> > > > > > > >
> > > > > > > > The geometry of the bad input packet at tcp_gso_segment:
> > > > > > > >
> > > > > > > > [   52.003050][ T8403] skb len=3D12202 headroom=3D244 hea=
dlen=3D12093 tailroom=3D0
> > > > > > > > [   52.003050][ T8403] mac=3D(168,24) mac_len=3D24 net=3D=
(192,52) trans=3D244
> > > > > > > > [   52.003050][ T8403] shinfo(txflags=3D0 nr_frags=3D1 gs=
o(size=3D1552 type=3D3 segs=3D0))
> > > > > > > > [   52.003050][ T8403] csum(0x60000c7 start=3D199 offset=3D=
1536
> > > > > > > > ip_summed=3D3 complete_sw=3D0 valid=3D0 level=3D0)
> > > > > > > >
> > > > > > > > Mitigate with stricter input validation.
> > > > > > > >
> > > > > > > > csum_offset: for GSO packets, deduce the correct value fr=
om gso_type.
> > > > > > > > This is already done for USO. Extend it to TSO. Let UFO b=
e:
> > > > > > > > udp[46]_ufo_fragment ignores these fields and always comp=
utes the
> > > > > > > > checksum in software.
> > > > > > > >
> > > > > > > > csum_start: finding the real offset requires parsing to t=
he transport
> > > > > > > > header. Do not add a parser, use existing segmentation pa=
rsing. Thanks
> > > > > > > > to SKB_GSO_DODGY, that also catches bad packets that are =
hw offloaded.
> > > > > > > > Again test both TSO and USO. Do not test UFO for the abov=
e reason, and
> > > > > > > > do not test UDP tunnel offload.
> > > > > > > >
> > > > > > > > GSO packet are almost always CHECKSUM_PARTIAL. USO packet=
s may be
> > > > > > > > CHECKSUM_NONE since commit 10154dbded6d6 ("udp: Allow GSO=
 transmit
> > > > > > > > from devices with no checksum offload"), but then still t=
hese fields
> > > > > > > > are initialized correctly in udp4_hwcsum/udp6_hwcsum_outg=
oing. So no
> > > > > > > > need to test for ip_summed =3D=3D CHECKSUM_PARTIAL first.=

> > > > > > > >
> > > > > > > > This revises an existing fix mentioned in the Fixes tag, =
which broke
> > > > > > > > small packets with GSO offload, as detected by kselftests=
.
> > > > > > > >
> > > > > > > > Link: https://syzkaller.appspot.com/bug?extid=3De1db31216=
c789f552871
> > > > > > > > Link: https://lore.kernel.org/netdev/20240723223109.21968=
86-1-kuba@kernel.org
> > > > > > > > Fixes: e269d79c7d35 ("net: missing check virtio")
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > > > >
> > > > > > > > ---
> > > > > > > >
> > > > > > > > v1->v2
> > > > > > > >   - skb_transport_header instead of skb->transport_header=
 (edumazet@)
> > > > > > > >   - typo: migitate -> mitigate
> > > > > > > > ---
> > > > > > >
> > > > > > > this breaks booting from nfs root on an arm64 fvp
> > > > > > > model for me.
> > > > > > >
> > > > > > > i see two fixup commits
> > > > > > >
> > > > > > > commit 30b03f2a0592eee1267298298eac9dd655f55ab2
> > > > > > > Author:     Jakub Sitnicki <jakub@cloudflare.com>
> > > > > > > AuthorDate: 2024-08-08 11:56:22 +0200
> > > > > > > Commit:     Jakub Kicinski <kuba@kernel.org>
> > > > > > > CommitDate: 2024-08-09 21:58:08 -0700
> > > > > > >
> > > > > > >     udp: Fall back to software USO if IPv6 extension header=
s are present
> > > > > > >
> > > > > > > and
> > > > > > >
> > > > > > > commit b128ed5ab27330deeeaf51ea8bb69f1442a96f7f
> > > > > > > Author:     Felix Fietkau <nbd@nbd.name>
> > > > > > > AuthorDate: 2024-08-19 17:06:21 +0200
> > > > > > > Commit:     Jakub Kicinski <kuba@kernel.org>
> > > > > > > CommitDate: 2024-08-21 17:15:05 -0700
> > > > > > >
> > > > > > >     udp: fix receiving fraglist GSO packets
> > > > > > >
> > > > > > > but they don't fix the issue for me,
> > > > > > > at the boot console i see
> > > > > > >
> > > > > > > ...
> > > > > > > [    3.686846] Sending DHCP requests ., OK
> > > > > > > [    3.687302] IP-Config: Got DHCP answer from 172.20.51.25=
4, my address is 172.20.51.1
> > > > > > > [    3.687423] IP-Config: Complete:
> > > > > > > [    3.687482]      device=3Deth0, hwaddr=3Dea:0d:79:71:af:=
cd, ipaddr=3D172.20.51.1, mask=3D255.255.255.0, gw=3D172.20.51.254
> > > > > > > [    3.687631]      host=3D172.20.51.1, domain=3D, nis-doma=
in=3D(none)
> > > > > > > [    3.687719]      bootserver=3D172.20.51.254, rootserver=3D=
10.2.80.41, rootpath=3D
> > > > > > > [    3.687771]      nameserver0=3D172.20.51.254, nameserver=
1=3D172.20.51.252, nameserver2=3D172.20.51.251
> > > > > > > [    3.689075] clk: Disabling unused clocks
> > > > > > > [    3.689167] PM: genpd: Disabling unused power domains
> > > > > > > [    3.689258] ALSA device list:
> > > > > > > [    3.689330]   No soundcards found.
> > > > > > > [    3.716297] VFS: Mounted root (nfs4 filesystem) on devic=
e 0:24.
> > > > > > > [    3.716843] devtmpfs: mounted
> > > > > > > [    3.734352] Freeing unused kernel memory: 10112K
> > > > > > > [    3.735178] Run /sbin/init as init process
> > > > > > > [    3.743770] eth0: bad gso: type: 1, size: 1440
> > > > > > > [    3.744186] eth0: bad gso: type: 1, size: 1440
> > > > > > > ...
> > > > > > > [  154.610991] eth0: bad gso: type: 1, size: 1440
> > > > > > > [  185.330941] nfs: server 10.2.80.41 not responding, still=
 trying
> > > > > > > ...
> > > > > > >
> > > > > > > the "bad gso" message keeps repeating and init
> > > > > > > is not executed.
> > > > > > >
> > > > > > > if i revert the 3 patches above on 6.11-rc6 then
> > > > > > > init runs without "bad gso" error.
> > > > > > >
> > > > > > > this affects testing the arm64-gcs patches on
> > > > > > > top of 6.11-rc3 and 6.11-rc6
> > > > > > >
> > > > > > > not sure if this is an fvp or kernel bug.
> > > > > >
> > > > > > Thanks for the report, sorry that you're encountering this br=
eakage.
> > > > > >
> > > > > > Makes sense that this commit introduced it
> > > > > >
> > > > > >         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > > > > >                                   virtio_is_little_endian(vi-=
>vdev))) {
> > > > > >                 net_warn_ratelimited("%s: bad gso: type: %u, =
size: %u\n",
> > > > > >                                      dev->name, hdr->hdr.gso_=
type,
> > > > > >                                      hdr->hdr.gso_size);
> > > > > >                 goto frame_err;
> > > > > >         }
> > > > > >
> > > > > > Type 1 is VIRTIO_NET_HDR_GSO_TCPV4
> > > > > >
> > > > > > Most likely this application is inserting a packet with flag
> > > > > > VIRTIO_NET_HDR_F_NEEDS_CSUM and a wrong csum_start. Or is req=
uesting
> > > > > > TSO without checksum offload at all. In which case the kernel=
 goes out
> > > > > > of its way to find the right offset, but may fail.
> > > > > >
> > > > > > Which nfs-client is this? I'd like to take a look at the sour=
cecode.
> > > > > >
> > > > > > Unfortunately the kernel warning lacks a few useful pieces of=
 data,
> > > > > > such as the other virtio_net_hdr fields and the packet length=
.
> > > > >
> > > > > This happens on the virtio-net receive path, so the bad data is=

> > > > > received from the hypervisor.
> > > > >
> > > > > >From what I gather that arm64 fvp (Fixed Virtual Platforms) hy=
pervisor
> > > > > is closed source?
> > > > >
> > > > > Disabling GRO on this device will likely work as temporary work=
around.
> > > > >
> > > > > What we can do is instead of dropping packets to correct their =
offset:
> > > > >
> > > > >                 case SKB_GSO_TCPV4:
> > > > >                 case SKB_GSO_TCPV6:
> > > > > -                        if (skb->csum_offset !=3D offsetof(str=
uct tcphdr, check))
> > > > > -                                return -EINVAL;
> > > > > +                        if (skb->csum_offset !=3D offsetof(str=
uct tcphdr, check)) {
> > > > > +                                DEBUG_NET_WARN_ON_ONCE(1);
> > > > > +                                skb->csum_offset =3D offsetof(=
struct tcphdr, check);
> > > > > +                        }
> > > > >
> > > > > If the issue is in csum_offset. If the new csum_start check fai=
ls,
> > > > > that won't help.
> > > > >
> > > > > It would be helpful to see these values at this point, e.g., wi=
th
> > > > > skb_dump(KERN_INFO, skb, false);
> > > >
> > > >
> > > > It's an iteresting question whether when VIRTIO_NET_F_GUEST_HDRLE=
N
> > > > is not negotiated, csum_offset can be relied upon for GRO.
> > > >
> > > > Jason, WDYT?
> > >
> > > I don't see how it connects. GUEST_HDRLEN is about transmission but=

> > > not for receiving, current Linux driver doesn't use hdrlen at all s=
o
> > > hardened csum_offset looks like a must.
> > >
> > > And we have
> > >
> > > """
> > > If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 opti=
ons
> > > have been negotiated, the driver MAY use hdr_len only as a hint abo=
ut
> > > the transport header size. The driver MUST NOT rely on hdr_len to b=
e
> > > correct. Note: This is due to various bugs in implementations.
> > > """
> >
> > I think I made a mistake in assuming that virtio_net_hdr_to_skb is
> > only used in the tx path, and that the GSO flags thus imply GSO, whic=
h
> > requires CHECKSUM_PARTIAL.
> >
> > In virtnet_receive, this is the rx path and those flags imply GRO.
> > That can use CHECKSUM_UNNECESSARY, as virtnet does:
> >
> >        if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >                 skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >
> > So I guess VIRTIO_NET_HDR_GSO_* without VIRTIO_NET_HDR_F_DATA_VALID
> > would be wrong on rx.
> >
> > But the new check
> >
> >         if (hdr->gso_type !=3D VIRTIO_NET_HDR_GSO_NONE) {
> >
> >                 [...]
> >
> >                 case SKB_GSO_TCPV4:
> >                 case SKB_GSO_TCPV6:
> >                         if (skb->csum_offset !=3D offsetof(struct tcp=
hdr, check))
> >                                 return -EINVAL;
> >
> > should be limited to callers of virtio_net_hdr_to_skb on the tx/GSO p=
ath.
> >
> > Looking what the cleanest/minimal patch is to accomplish that.
> >
> =

> virtio_net_hdr_to_skb() translates virtio-net header to skb metadata,
> so it's RX. For TX the helper should be virtio_net_hdr_from_skb()
> which translates skb metadata to virtio hdr.

virtio_net_hdr_to_skb is used by PF_PACKET, tun and tap when injecting
a packet into the egress path.



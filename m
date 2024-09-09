Return-Path: <stable+bounces-73942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2629970C3F
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 05:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D631F2256D
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 03:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7B61AC8B3;
	Mon,  9 Sep 2024 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzwHa22K"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2243032F
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725852265; cv=none; b=Cuv5OKNzh/Bf4yYh8YsjGDdTCkVl8tGxe7K6U+U7oMcEaZ6LmPnDX7KLulEwvwTp+9Fcc8rUKzIwDPEKo8WvGQZ4V5guAo1GarrGFFc8QBT7kQ1rCCOSCwLWj1/lovZnQuDuyHndnpby/m0o0GaoALMZrMOUhkFbKx/KP/CibTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725852265; c=relaxed/simple;
	bh=iNbnS84lM4YyviFDA/3zZbS4Adz6C/CFE2JlgJ+ueP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwZ6ho62eeIuDOOGOggBl3UFSUbS+PH897KgXXOVczbSM6oXLibGflwgz8x/Wj9IffgHZIBpUvEfddKVb4fmj5hnwn8pOJyYsv042qe7OPmuiVLGNLeqOJanTp0hX6Bo1+GcEiFDzqwWnO9UbF5MQJDLedDq2FIZ/kYksmNFPsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzwHa22K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725852261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+/J6zkBh19mQd59tTjVb5rGcoDXQ+uhSx2CQaVqj5I=;
	b=dzwHa22KItxhMOTCincGXMI/lMRlCYVHhicwK5rCNo4UoTnTvMbtKYPEBEQ4x8zzFV+rbl
	zabMQ5wpQBYIV/uVDy33+Mz6Rn13JxoSI9GBK++76Qz9pIbAIAedRGDfGjBQsq804ohoQd
	9wJKxc4UQUvapK6PQZHBC7R8v8Ht6YU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-VWyRVTpFOyOqZcdnPyPRGg-1; Sun, 08 Sep 2024 23:24:20 -0400
X-MC-Unique: VWyRVTpFOyOqZcdnPyPRGg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-718e2da2e33so1783277b3a.1
        for <stable@vger.kernel.org>; Sun, 08 Sep 2024 20:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725852259; x=1726457059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+/J6zkBh19mQd59tTjVb5rGcoDXQ+uhSx2CQaVqj5I=;
        b=QvTF30JtVBe6CCqWzk8KyHU4eM5vfRtVXqMe8eIFFjkCVzRv5UVyMIlGtNS7mYPXK9
         v+doRpwuSrrpq51lxV2Nz7gmjVbTI6PxmvTPg1EAuAYhaRFuK7vUvkFdAFTSHA1frDgX
         7MPfjCjnU3KWiyMPXaJgXeyb2FOaLnLxzQEaU5NLskT/8zp2Rc8sejcod/LBQyUtFhXB
         gpXreKfsjPAwLBkIBNL9BayB7f+En8/0fs3Ba8k1ThKq8AgpBgZivlocGO3HAlblwR6K
         +81pA2pqwX5/XjPGhSESslrTI/jFyEgOyzW8p0bfDFStrEyFtNI2Lp5m545UD/1K9yFy
         VCpw==
X-Forwarded-Encrypted: i=1; AJvYcCX/ADJB32tAloi5RICk4Mz8b1sUToBEkMtYE7UYhc/iKpa55bKMNURorhrXEeeeq4kyjj2hkyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJyYPV+rH3YqJKtk8vtH2mATNDyxdUC6xX9Cn1sVo5TCY9Um9X
	JA5g9WZ6gUGczNe/PO0VTurW2KmiHqcptRKU/elA7C94gP7jvRQkz49gXGTMjNW2EFOyN0mPeaa
	NlhwdRhX14NclU44Jx442yRsmgOFqm+zO3RBdsiL8qBR662TBLsakbYttZFOKFvDsfYgzEsDqDP
	C4Cvj9O+LQx5U4EXshuQ8xsvi5Kl/E
X-Received: by 2002:a05:6a21:e85:b0:1cf:38cf:df92 with SMTP id adf61e73a8af0-1cf38cfe0femr2493143637.30.1725852259184;
        Sun, 08 Sep 2024 20:24:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAITwbBGfMyYk2xh8sJlqWtmw0anA5GHjlgm74deLLNWbkKKHD/+Vg/yiT812K8UpU7Vah3L6NbwLMu0VFdUE=
X-Received: by 2002:a05:6a21:e85:b0:1cf:38cf:df92 with SMTP id
 adf61e73a8af0-1cf38cfe0femr2493105637.30.1725852258532; Sun, 08 Sep 2024
 20:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
 <ZtsTGp9FounnxZaN@arm.com> <66db2542cfeaa_29a385294b9@willemb.c.googlers.com.notmuch>
 <66de0487cfa91_30614529470@willemb.c.googlers.com.notmuch>
 <20240908164252-mutt-send-email-mst@kernel.org> <CACGkMEtchtLYAVgUYGFt3e-1UjNBy+h0Kv-7K3dRiiKEr7gnKw@mail.gmail.com>
 <66de653b4e0f9_cd37294c3@willemb.c.googlers.com.notmuch>
In-Reply-To: <66de653b4e0f9_cd37294c3@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Sep 2024 11:24:06 +0800
Message-ID: <CACGkMEtu3c3xVWukFnGriOk4UjKyMVKU7gNQ5v38nHy1q2=DpQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: drop bad gso csum_start and offset in virtio_net_hdr
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	arefev@swemel.ru, alexander.duyck@gmail.com, 
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org, 
	Jakub Sitnicki <jakub@cloudflare.com>, Felix Fietkau <nbd@nbd.name>, Mark Brown <broonie@kernel.org>, 
	Yury Khrustalev <yury.khrustalev@arm.com>, nd@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:02=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Wang wrote:
> > On Mon, Sep 9, 2024 at 4:44=E2=80=AFAM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Sun, Sep 08, 2024 at 04:09:43PM -0400, Willem de Bruijn wrote:
> > > > Willem de Bruijn wrote:
> > > > > Szabolcs Nagy wrote:
> > > > > > The 07/29/2024 16:10, Willem de Bruijn wrote:
> > > > > > > From: Willem de Bruijn <willemb@google.com>
> > > > > > >
> > > > > > > Tighten csum_start and csum_offset checks in virtio_net_hdr_t=
o_skb
> > > > > > > for GSO packets.
> > > > > > >
> > > > > > > The function already checks that a checksum requested with
> > > > > > > VIRTIO_NET_HDR_F_NEEDS_CSUM is in skb linear. But for GSO pac=
kets
> > > > > > > this might not hold for segs after segmentation.
> > > > > > >
> > > > > > > Syzkaller demonstrated to reach this warning in skb_checksum_=
help
> > > > > > >
> > > > > > >         offset =3D skb_checksum_start_offset(skb);
> > > > > > >         ret =3D -EINVAL;
> > > > > > >         if (WARN_ON_ONCE(offset >=3D skb_headlen(skb)))
> > > > > > >
> > > > > > > By injecting a TSO packet:
> > > > > > >
> > > > > > > WARNING: CPU: 1 PID: 3539 at net/core/dev.c:3284 skb_checksum=
_help+0x3d0/0x5b0
> > > > > > >  ip_do_fragment+0x209/0x1b20 net/ipv4/ip_output.c:774
> > > > > > >  ip_finish_output_gso net/ipv4/ip_output.c:279 [inline]
> > > > > > >  __ip_finish_output+0x2bd/0x4b0 net/ipv4/ip_output.c:301
> > > > > > >  iptunnel_xmit+0x50c/0x930 net/ipv4/ip_tunnel_core.c:82
> > > > > > >  ip_tunnel_xmit+0x2296/0x2c70 net/ipv4/ip_tunnel.c:813
> > > > > > >  __gre_xmit net/ipv4/ip_gre.c:469 [inline]
> > > > > > >  ipgre_xmit+0x759/0xa60 net/ipv4/ip_gre.c:661
> > > > > > >  __netdev_start_xmit include/linux/netdevice.h:4850 [inline]
> > > > > > >  netdev_start_xmit include/linux/netdevice.h:4864 [inline]
> > > > > > >  xmit_one net/core/dev.c:3595 [inline]
> > > > > > >  dev_hard_start_xmit+0x261/0x8c0 net/core/dev.c:3611
> > > > > > >  __dev_queue_xmit+0x1b97/0x3c90 net/core/dev.c:4261
> > > > > > >  packet_snd net/packet/af_packet.c:3073 [inline]
> > > > > > >
> > > > > > > The geometry of the bad input packet at tcp_gso_segment:
> > > > > > >
> > > > > > > [   52.003050][ T8403] skb len=3D12202 headroom=3D244 headlen=
=3D12093 tailroom=3D0
> > > > > > > [   52.003050][ T8403] mac=3D(168,24) mac_len=3D24 net=3D(192=
,52) trans=3D244
> > > > > > > [   52.003050][ T8403] shinfo(txflags=3D0 nr_frags=3D1 gso(si=
ze=3D1552 type=3D3 segs=3D0))
> > > > > > > [   52.003050][ T8403] csum(0x60000c7 start=3D199 offset=3D15=
36
> > > > > > > ip_summed=3D3 complete_sw=3D0 valid=3D0 level=3D0)
> > > > > > >
> > > > > > > Mitigate with stricter input validation.
> > > > > > >
> > > > > > > csum_offset: for GSO packets, deduce the correct value from g=
so_type.
> > > > > > > This is already done for USO. Extend it to TSO. Let UFO be:
> > > > > > > udp[46]_ufo_fragment ignores these fields and always computes=
 the
> > > > > > > checksum in software.
> > > > > > >
> > > > > > > csum_start: finding the real offset requires parsing to the t=
ransport
> > > > > > > header. Do not add a parser, use existing segmentation parsin=
g. Thanks
> > > > > > > to SKB_GSO_DODGY, that also catches bad packets that are hw o=
ffloaded.
> > > > > > > Again test both TSO and USO. Do not test UFO for the above re=
ason, and
> > > > > > > do not test UDP tunnel offload.
> > > > > > >
> > > > > > > GSO packet are almost always CHECKSUM_PARTIAL. USO packets ma=
y be
> > > > > > > CHECKSUM_NONE since commit 10154dbded6d6 ("udp: Allow GSO tra=
nsmit
> > > > > > > from devices with no checksum offload"), but then still these=
 fields
> > > > > > > are initialized correctly in udp4_hwcsum/udp6_hwcsum_outgoing=
. So no
> > > > > > > need to test for ip_summed =3D=3D CHECKSUM_PARTIAL first.
> > > > > > >
> > > > > > > This revises an existing fix mentioned in the Fixes tag, whic=
h broke
> > > > > > > small packets with GSO offload, as detected by kselftests.
> > > > > > >
> > > > > > > Link: https://syzkaller.appspot.com/bug?extid=3De1db31216c789=
f552871
> > > > > > > Link: https://lore.kernel.org/netdev/20240723223109.2196886-1=
-kuba@kernel.org
> > > > > > > Fixes: e269d79c7d35 ("net: missing check virtio")
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > > >
> > > > > > > ---
> > > > > > >
> > > > > > > v1->v2
> > > > > > >   - skb_transport_header instead of skb->transport_header (ed=
umazet@)
> > > > > > >   - typo: migitate -> mitigate
> > > > > > > ---
> > > > > >
> > > > > > this breaks booting from nfs root on an arm64 fvp
> > > > > > model for me.
> > > > > >
> > > > > > i see two fixup commits
> > > > > >
> > > > > > commit 30b03f2a0592eee1267298298eac9dd655f55ab2
> > > > > > Author:     Jakub Sitnicki <jakub@cloudflare.com>
> > > > > > AuthorDate: 2024-08-08 11:56:22 +0200
> > > > > > Commit:     Jakub Kicinski <kuba@kernel.org>
> > > > > > CommitDate: 2024-08-09 21:58:08 -0700
> > > > > >
> > > > > >     udp: Fall back to software USO if IPv6 extension headers ar=
e present
> > > > > >
> > > > > > and
> > > > > >
> > > > > > commit b128ed5ab27330deeeaf51ea8bb69f1442a96f7f
> > > > > > Author:     Felix Fietkau <nbd@nbd.name>
> > > > > > AuthorDate: 2024-08-19 17:06:21 +0200
> > > > > > Commit:     Jakub Kicinski <kuba@kernel.org>
> > > > > > CommitDate: 2024-08-21 17:15:05 -0700
> > > > > >
> > > > > >     udp: fix receiving fraglist GSO packets
> > > > > >
> > > > > > but they don't fix the issue for me,
> > > > > > at the boot console i see
> > > > > >
> > > > > > ...
> > > > > > [    3.686846] Sending DHCP requests ., OK
> > > > > > [    3.687302] IP-Config: Got DHCP answer from 172.20.51.254, m=
y address is 172.20.51.1
> > > > > > [    3.687423] IP-Config: Complete:
> > > > > > [    3.687482]      device=3Deth0, hwaddr=3Dea:0d:79:71:af:cd, =
ipaddr=3D172.20.51.1, mask=3D255.255.255.0, gw=3D172.20.51.254
> > > > > > [    3.687631]      host=3D172.20.51.1, domain=3D, nis-domain=
=3D(none)
> > > > > > [    3.687719]      bootserver=3D172.20.51.254, rootserver=3D10=
.2.80.41, rootpath=3D
> > > > > > [    3.687771]      nameserver0=3D172.20.51.254, nameserver1=3D=
172.20.51.252, nameserver2=3D172.20.51.251
> > > > > > [    3.689075] clk: Disabling unused clocks
> > > > > > [    3.689167] PM: genpd: Disabling unused power domains
> > > > > > [    3.689258] ALSA device list:
> > > > > > [    3.689330]   No soundcards found.
> > > > > > [    3.716297] VFS: Mounted root (nfs4 filesystem) on device 0:=
24.
> > > > > > [    3.716843] devtmpfs: mounted
> > > > > > [    3.734352] Freeing unused kernel memory: 10112K
> > > > > > [    3.735178] Run /sbin/init as init process
> > > > > > [    3.743770] eth0: bad gso: type: 1, size: 1440
> > > > > > [    3.744186] eth0: bad gso: type: 1, size: 1440
> > > > > > ...
> > > > > > [  154.610991] eth0: bad gso: type: 1, size: 1440
> > > > > > [  185.330941] nfs: server 10.2.80.41 not responding, still try=
ing
> > > > > > ...
> > > > > >
> > > > > > the "bad gso" message keeps repeating and init
> > > > > > is not executed.
> > > > > >
> > > > > > if i revert the 3 patches above on 6.11-rc6 then
> > > > > > init runs without "bad gso" error.
> > > > > >
> > > > > > this affects testing the arm64-gcs patches on
> > > > > > top of 6.11-rc3 and 6.11-rc6
> > > > > >
> > > > > > not sure if this is an fvp or kernel bug.
> > > > >
> > > > > Thanks for the report, sorry that you're encountering this breaka=
ge.
> > > > >
> > > > > Makes sense that this commit introduced it
> > > > >
> > > > >         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > > > >                                   virtio_is_little_endian(vi->vde=
v))) {
> > > > >                 net_warn_ratelimited("%s: bad gso: type: %u, size=
: %u\n",
> > > > >                                      dev->name, hdr->hdr.gso_type=
,
> > > > >                                      hdr->hdr.gso_size);
> > > > >                 goto frame_err;
> > > > >         }
> > > > >
> > > > > Type 1 is VIRTIO_NET_HDR_GSO_TCPV4
> > > > >
> > > > > Most likely this application is inserting a packet with flag
> > > > > VIRTIO_NET_HDR_F_NEEDS_CSUM and a wrong csum_start. Or is request=
ing
> > > > > TSO without checksum offload at all. In which case the kernel goe=
s out
> > > > > of its way to find the right offset, but may fail.
> > > > >
> > > > > Which nfs-client is this? I'd like to take a look at the sourceco=
de.
> > > > >
> > > > > Unfortunately the kernel warning lacks a few useful pieces of dat=
a,
> > > > > such as the other virtio_net_hdr fields and the packet length.
> > > >
> > > > This happens on the virtio-net receive path, so the bad data is
> > > > received from the hypervisor.
> > > >
> > > > >From what I gather that arm64 fvp (Fixed Virtual Platforms) hyperv=
isor
> > > > is closed source?
> > > >
> > > > Disabling GRO on this device will likely work as temporary workarou=
nd.
> > > >
> > > > What we can do is instead of dropping packets to correct their offs=
et:
> > > >
> > > >                 case SKB_GSO_TCPV4:
> > > >                 case SKB_GSO_TCPV6:
> > > > -                        if (skb->csum_offset !=3D offsetof(struct =
tcphdr, check))
> > > > -                                return -EINVAL;
> > > > +                        if (skb->csum_offset !=3D offsetof(struct =
tcphdr, check)) {
> > > > +                                DEBUG_NET_WARN_ON_ONCE(1);
> > > > +                                skb->csum_offset =3D offsetof(stru=
ct tcphdr, check);
> > > > +                        }
> > > >
> > > > If the issue is in csum_offset. If the new csum_start check fails,
> > > > that won't help.
> > > >
> > > > It would be helpful to see these values at this point, e.g., with
> > > > skb_dump(KERN_INFO, skb, false);
> > >
> > >
> > > It's an iteresting question whether when VIRTIO_NET_F_GUEST_HDRLEN
> > > is not negotiated, csum_offset can be relied upon for GRO.
> > >
> > > Jason, WDYT?
> >
> > I don't see how it connects. GUEST_HDRLEN is about transmission but
> > not for receiving, current Linux driver doesn't use hdrlen at all so
> > hardened csum_offset looks like a must.
> >
> > And we have
> >
> > """
> > If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options
> > have been negotiated, the driver MAY use hdr_len only as a hint about
> > the transport header size. The driver MUST NOT rely on hdr_len to be
> > correct. Note: This is due to various bugs in implementations.
> > """
>
> I think I made a mistake in assuming that virtio_net_hdr_to_skb is
> only used in the tx path, and that the GSO flags thus imply GSO, which
> requires CHECKSUM_PARTIAL.
>
> In virtnet_receive, this is the rx path and those flags imply GRO.
> That can use CHECKSUM_UNNECESSARY, as virtnet does:
>
>        if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
>                 skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>
> So I guess VIRTIO_NET_HDR_GSO_* without VIRTIO_NET_HDR_F_DATA_VALID
> would be wrong on rx.
>
> But the new check
>
>         if (hdr->gso_type !=3D VIRTIO_NET_HDR_GSO_NONE) {
>
>                 [...]
>
>                 case SKB_GSO_TCPV4:
>                 case SKB_GSO_TCPV6:
>                         if (skb->csum_offset !=3D offsetof(struct tcphdr,=
 check))
>                                 return -EINVAL;
>
> should be limited to callers of virtio_net_hdr_to_skb on the tx/GSO path.
>
> Looking what the cleanest/minimal patch is to accomplish that.
>

virtio_net_hdr_to_skb() translates virtio-net header to skb metadata,
so it's RX. For TX the helper should be virtio_net_hdr_from_skb()
which translates skb metadata to virtio hdr.

Thanks



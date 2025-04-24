Return-Path: <stable+bounces-136576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339C9A9AE09
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 14:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCED33B7E31
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5FB2701AA;
	Thu, 24 Apr 2025 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="sgkcfejB"
X-Original-To: stable@vger.kernel.org
Received: from wylie.me.uk (wylie.me.uk [82.68.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16F223DEB;
	Thu, 24 Apr 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.68.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499226; cv=none; b=jyDDhj6o1ziQFK/yB8hvoPgfy037OuPTHRiOhu1qhOW8SpedWAKnbtu29gPUD9y1OCwL8jMdBTyPtJZP4suntRJ/+SAMscKIBvatIOnDtWLsqKD9QciWj1hEZ4A9FUYMHFIoVGR26KEZTC+ZxoTnq5vRj+xxYcpmDy/jh+CcjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499226; c=relaxed/simple;
	bh=P86oE7d+/laopXXLm4l/4blWBmnOYmZlRzNXI5Cbk/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bw8LBBuQy6z/GnZUUpF5XfjV0Y5O/COQUTqigTS2BGY8uN2LXevN/iZPstIp0kCSVcj7x0t+YuQrwdtizhCoe5LZv5SxKclkW4wDhTgkOZhZks70k1BzV7k8CA6jpexXGAVKJ2UuUNylH6XifnUsO76Ib+nzYwyRKXmI5IU+/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk; spf=pass smtp.mailfrom=wylie.me.uk; dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b=sgkcfejB; arc=none smtp.client-ip=82.68.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wylie.me.uk
Received: from frodo.int.wylie.me.uk (frodo.int.wylie.me.uk [192.168.21.2])
	by wylie.me.uk (Postfix) with ESMTP id D6145120897;
	Thu, 24 Apr 2025 13:53:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
	s=mydkim006; t=1745499211;
	bh=P86oE7d+/laopXXLm4l/4blWBmnOYmZlRzNXI5Cbk/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=sgkcfejB+MzMEtjvZcAhWSxSOL+ajLWRHA4hn14nvgR1mNN1EoN6YWcRYRXibv7Pz
	 cVu8aqIgBsE8zplzKI56Q43zb22vMEwjpUXsVbb/+UN1PZfHXlZvkv8lDzAXwXomwc
	 7qLiJ05u47pWLFVx48PIq+4JtNijO7VWmAitAQkNfKLUlfJWkAlRIxHYdFZQXky0a2
	 wTcfK3LdKIV+fTRHI8uXgQvAgLa1Gk//MkfPPrEczyQwTyRHfyPuv5rqhajb8tPvU7
	 jao/H58KOS2ZrM4dxEdOagEZXy3MtvnKPtEHN0EzDqQlWpNFUsm/8wrF/QLm85veaA
	 jpdqmfh6RBLRQ==
Date: Thu, 24 Apr 2025 13:53:31 +0100
From: "Alan J. Wylie" <alan@wylie.me.uk>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Holger =?UTF-8?B?SG9mZnN0w6R0dGU=?= <holger@applied-asynchrony.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev, Jiri
 Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
 stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <20250424135331.02511131@frodo.int.wylie.me.uk>
In-Reply-To: <aAlAakEUu4XSEdXF@pop-os.localdomain>
References: <20250421131000.6299a8e0@frodo.int.wylie.me.uk>
 <20250421200601.5b2e28de@frodo.int.wylie.me.uk>
 <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
 <20250421210927.50d6a355@frodo.int.wylie.me.uk>
 <20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
 <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
 <aAf/K7F9TmCJIT+N@pop-os.localdomain>
 <20250422214716.5e181523@frodo.int.wylie.me.uk>
 <aAgO59L0ccXl6kUs@pop-os.localdomain>
 <20250423105131.7ab46a47@frodo.int.wylie.me.uk>
 <aAlAakEUu4XSEdXF@pop-os.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> On Tue, Apr 22, 2025 at 07:20:24PM +0200, Holger Hoffst=C3=A4tte wrote:

> Meanwhile, if you could provide a reliable (and ideally minimum)
> reproducer, it would help me a lot to debug.

I've found a reproducer. Below is a stripped down version of the shell scri=
pt
that I posted in my initial report.

Running this in a 1 second loop is enough to cause the panic very quickly.

It seems a bit of network traffic is needed, too.


# while true; do ./tc.sh; sleep 1; done
13:33:43 7196kbit 29296kbit
13:33:44 7196kbit 29296kbit
...
13:35:38 7196kbit 29296kbit
13:35:39 7196kbit 29296kbit
[panic]

# while true; do ./tc.sh; sleep 1; done
13:44:31 7196kbit 29296kbit
13:44:32 7196kbit 29296kbit
...
13:44:52 7196kbit 29296kbit
13:44:53 7196kbit 29296kbit
[panic]

The same place as usual
 htb_dequeue+0x42f/0x610 [sch_htb]

--------8<--------8<--------8<--------8<--------8<--------8<--------8<-----=
---8<--------8<
#!/usr/bin/bash

set -o nounset
set -o errexit

export PATH=3D/usr/bin

ext=3Dppp0
ext_ingress=3Dppp0ifb0

ext_up=3D7196kbit
ext_down=3D29296kbit

printf "%(%T)T $ext_up $ext_down\n"

q=3D1486
quantum=3D300

modprobe act_mirred
modprobe ifb
modprobe sch_cake
modprobe sch_fq_codel

ethtool -K "$ext" tso off gso off gro off=20

tc qdisc del dev "$ext" root		>& /dev/null || true
tc qdisc del dev "$ext" ingress		>& /dev/null || true
tc qdisc del dev "$ext_ingress" root	>& /dev/null || true
tc qdisc del dev "$ext_ingress" ingress	>& /dev/null || true
ip link del "$ext_ingress"  		>& /dev/null || true

tc qdisc add dev "$ext" handle ffff: ingress

ip link add name "$ext_ingress"  type ifb
ip link set dev "$ext_ingress" up || true=20

tc filter add dev "$ext" parent ffff: protocol all u32 match u32 0 0 action=
 mirred egress redirect dev "$ext_ingress"
tc qdisc add dev "$ext_ingress" root handle 1: htb default 11 r2q 20
tc class add dev "$ext_ingress" parent 1: classid 1:1 htb rate $ext_down=20
tc class add dev "$ext_ingress" parent 1:1 classid 1:11 htb rate $ext_down =
prio 0 quantum $q
tc qdisc add dev "$ext_ingress" parent 1:11 fq_codel quantum $quantum ecn
tc qdisc add dev "$ext" root handle 1: htb default 11
tc class add dev "$ext" parent 1: classid 1:1 htb rate $ext_up
tc class add dev "$ext" parent 1:1 classid 1:11 htb rate $ext_up prio 0 qua=
ntum $q
tc qdisc add dev "$ext" parent 1:11 fq_codel quantum $quantum noecn
--------8<--------8<--------8<--------8<--------8<--------8<--------8<-----=
---8<--------8<

--=20
Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience


Return-Path: <stable+bounces-134884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321AEA95700
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 22:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5B0169DB4
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 20:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6831EF39E;
	Mon, 21 Apr 2025 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="MkXqf1vL"
X-Original-To: stable@vger.kernel.org
Received: from wylie.me.uk (wylie.me.uk [82.68.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF752F37;
	Mon, 21 Apr 2025 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.68.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745266180; cv=none; b=hpjVlXjhhyuV6UIQUSrXWQfUHWNpisxv3FF/zA5JLpJ1bQVYzz8Ij1mWzn2yTuVUHJlBhMTcAVhbpw3Fsv5Y+Tm+4TPa3vhkFQhvOa+ysJlCgmKkkUIj3p9uo9PK5xEQZu3HoinIS51K8Zi0F5KUGkR7qYd1Egl8k9wU7Xtp0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745266180; c=relaxed/simple;
	bh=b+VWpq3NDHwNAt8S/b7pLV0b9kapdPe8ei7JxdNhfaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQ45fr76WcrRvS/MBgV1ig6k6ZUhAZhKM2d4kVk+ZTTN7K7Jg3OEb+Ip4IsbqjvhOKgoLJIp5Cm5k38Tl/2lHMiCAEsyxELMEyHBIGmYic20cyCPt/nOSdTeq/8+zvzUFzaHMWZ/H5/uesQF/FW3QK3gsId+a306I/m4JZiwYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk; spf=pass smtp.mailfrom=wylie.me.uk; dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b=MkXqf1vL; arc=none smtp.client-ip=82.68.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wylie.me.uk
Received: from frodo.int.wylie.me.uk (frodo.int.wylie.me.uk [192.168.21.2])
	by wylie.me.uk (Postfix) with ESMTP id 109A8120872;
	Mon, 21 Apr 2025 21:09:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
	s=mydkim006; t=1745266168;
	bh=b+VWpq3NDHwNAt8S/b7pLV0b9kapdPe8ei7JxdNhfaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MkXqf1vLHKpcBOMj6MpdubBkR6uWNHWZ/SHP8expyNaK801KfQLFnnm+Bv/flwK6U
	 fNomrj2N516Zd+m623mgNyxfc+w6J6GOUIJ+1HZ29PB0R4PVqm4SLXv7Tju+XyITHk
	 I2qorgiZA6tj/QWjd41uI+PgBlvpFgCwjIz2cuDvhZQXHSa0JZls7R0v7dNWTNdUIb
	 dnBy1a4GryRVyIhxecoHR1vIO872VTYajmE0iSmj11dhKBJfK3qRoWB0OPL9ProUm3
	 XC3xZLIX1jWY+8DC1DXczJkWWY+np94fPJTEcuB/QmcRM+KR2g73U/8rv70L/d9fsu
	 Iq4adLM4UAfDQ==
Date: Mon, 21 Apr 2025 21:09:27 +0100
From: "Alan J. Wylie" <alan@wylie.me.uk>
To: Holger =?UTF-8?B?SG9mZnN0w6R0dGU=?= <holger@applied-asynchrony.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev, Cong
 Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila
 <tavip@google.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, stable@vger.kernel.org
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <20250421210927.50d6a355@frodo.int.wylie.me.uk>
In-Reply-To: <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
	<6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
	<20250421131000.6299a8e0@frodo.int.wylie.me.uk>
	<20250421200601.5b2e28de@frodo.int.wylie.me.uk>
	<89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
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

On Mon, 21 Apr 2025 21:47:44 +0200
Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com> wrote:

> > I'm afraid that didn't help. Same panic. =20
>=20
> Bummer :-(
>=20
> Might be something else missing then - so for now the only other thing
> I'd suggest is to revert the removal of the qlen check in fq_codel.

Like this?

$ git diff  sch_fq_codel.c
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 6c9029f71e88..4fdf317b82ec 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -316,7 +316,7 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *s=
ch)
        qdisc_bstats_update(sch, skb);
        flow->deficit -=3D qdisc_pkt_len(skb);
=20
-       if (q->cstats.drop_count) {
+       if (q->cstats.drop_count && sch->q.qlen) {
                qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
                                          q->cstats.drop_len);
                q->cstats.drop_count =3D 0;
$=20

I'll be off to bed soon, but I'll leave it running overnight.

I might be able to do a quick report in the morning, but I'll
have to set off early to go digging down a cave all day tomorrow.

--=20
Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience


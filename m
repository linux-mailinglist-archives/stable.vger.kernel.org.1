Return-Path: <stable+bounces-210418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E5D3BCA4
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 01:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2F7E30318FF
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 00:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB151E1A3B;
	Tue, 20 Jan 2026 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="ECnI7NcO"
X-Original-To: stable@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C891C5D5E;
	Tue, 20 Jan 2026 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768870131; cv=none; b=h8m5j1GG9j+2KGw9iGAOg2DiA7QhGBYY07x5qcYA3ECwRXaexDwflJRL20EkMkZq/YrPylca+e6A8KRQ24vafwfw40l2ICTT4N7qfsAr7OrjApZluOb0vfNtLqMWE+GQePbduPLdzCEVwcqa1zWeRb/UIIjlYDIOwH6ytf/+Sdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768870131; c=relaxed/simple;
	bh=/0chezKZEgFOMSPncW/2YTocW8NPuNPAPpLBZ0v6D4U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWmGrMWmrrpF5Gju8uy9M6p6LDdnGS3z9WGS0vqBQNZNuAwTNL7A6udUbfMC4HfS5bBF8e8U0bxvxeFnQN1eLCI4CZJ2opbQ3gmQeFhp6IbZTBH+OFE859S08d+DXZfkGfW35lA5m6iPrt81IwCSbFkfzP+SymB5cNJd9mxrfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=ECnI7NcO; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1768870119; x=1769129319;
	bh=hgZfu2gwJF+PAW+NCm5J0Z64EJ32aifzlflRodxQoAE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ECnI7NcOhdy92XAVgWGaXTfl/a197ENcuUmQYkjqb6TiMGrnOm8vCZ/PH4ra0t2BC
	 ziT56Pal2F35McA/55kAIJeIgzlHUXrdrp6GsrN5OmJFyH7vPzkXLpjwO+xIjVBSND
	 /KVpZqZtMKQJDszKoQxqTpXe5xUEmOdZO/m1RD37FQ05A+7FReJTgoQ3HdUlTj+7pH
	 fzmQlwykgp7s+em0hvA5s3OmEnesT5zSdhGk/IEivdpyesYjP+ji1PFJh+2WanpZO+
	 UJVQ/iy3xO4V2ko66yYmFhsRXIzXLXdMxrd17mlkTzT7hzoMr4XcJferCVhFMeJr16
	 XjQ0CT5/n8E4Q==
Date: Tue, 20 Jan 2026 00:48:34 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH 2/2] net/sched: act_gate: zero-initialize netlink dump struct
Message-ID: <20260120004720.1886632-3-p@1g4.org>
In-Reply-To: <20260120004720.1886632-1-p@1g4.org>
References: <20260120004720.1886632-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 9f9eb4f1232645b510937b51a01122d3023897b6
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zero-initialize the tc_gate dump struct to avoid leaking padding bytes
to userspace. Without clearing the struct, uninitialized stack padding
can be copied into the netlink reply during action dumps.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 net/sched/act_gate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 3ee07c3deaf97..ff963c165de90 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -656,17 +656,16 @@ static int tcf_gate_dump(struct sk_buff *skb, struct =
tc_action *a,
 {
 =09unsigned char *b =3D skb_tail_pointer(skb);
 =09struct tcf_gate *gact =3D to_gate(a);
-=09struct tc_gate opt =3D {
-=09=09.index    =3D gact->tcf_index,
-=09=09.refcnt   =3D refcount_read(&gact->tcf_refcnt) - ref,
-=09=09.bindcnt  =3D atomic_read(&gact->tcf_bindcnt) - bind,
-=09};
+=09struct tc_gate opt =3D { };
 =09struct tcfg_gate_entry *entry;
 =09struct tcf_gate_params *p;
 =09struct nlattr *entry_list;
 =09struct tcf_t t;
=20
 =09spin_lock_bh(&gact->tcf_lock);
+=09opt.index    =3D gact->tcf_index;
+=09opt.refcnt   =3D refcount_read(&gact->tcf_refcnt) - ref;
+=09opt.bindcnt  =3D atomic_read(&gact->tcf_bindcnt) - bind;
 =09opt.action =3D gact->tcf_action;
=20
 =09p =3D rcu_dereference_protected(gact->param,
--=20
2.52.GIT




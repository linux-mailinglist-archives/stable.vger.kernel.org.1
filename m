Return-Path: <stable+bounces-225441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDESAyi3tWkj4AAAu9opvQ
	(envelope-from <stable+bounces-225441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 20:29:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883828E982
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 20:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4912630215B8
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 19:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AFA33F594;
	Sat, 14 Mar 2026 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="jqvhTO9Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981464A35;
	Sat, 14 Mar 2026 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773516576; cv=none; b=rvUR3nZHrVcCKv29B2cgu8VzCzsM66Su8zbsLok6dweAR65pKoPnYR85ta9y8HLEYoIE+x5u+F4QTj3Q3vkmFsJqGIIghxyG0KlQmXDfkLnFqlk62pgfpemGbMwQrgo7Etvwa6rezqHEGfJcfWVCzdCD+79nQhLBbzItxzn8i5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773516576; c=relaxed/simple;
	bh=Bgmcbq9oKuH7wBe/gofoij0gbrlNnMKsyHtucKsYpX0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgAjM/+hPxU1zAnqBd3fi/9OIbiDG9iVl92sLCPhudWq5gRx7exOLcltwgL18ws2sF9DP+cA5pI6hY+YsxCOrEN3Lert2v7ySOaHtet64gybCJRqieU3lf6JCr3aUUwhPiZkDYaWxykrXz4WL/ERWfAu1E7hATb0EMlf1tVUkjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=jqvhTO9Q; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail3; t=1773516554; x=1773775754;
	bh=OQ+MzS+TsnjSS3Tt5b0aBZsS9ft/puTKKEeze9mG2OY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jqvhTO9QtqgaUnhMexYpyX7wFOq0rLnfCGTHf85OQIq912/BoJ0fumOm6wEnSkx+N
	 bSZue+cqsknJVDqsAjaYG3WODL/jvZ3nXqn1UXWWjmhy9U9xUdYuEs/u4d09UjaULl
	 FuJmixTwyUVZWe0THKhBNATFekTKmzavhe9gBt1xF0+Iss+a67Y2v9phv8V/lPhkDZ
	 UY0+BJ1pbub4MY/P4eqgbaA8JHe26tdIy8DOK7SjT8njXYfYWRZilJxyuQ3+Hs7fGf
	 rWKeoR6IOvyWnB6HAUgjZBCG74NiSqIUMRGD63QEiVA0hHRA0c4534TPS623M00sTV
	 NlmTcRSyylxQA==
Date: Sat, 14 Mar 2026 19:29:10 +0000
To: Stephen Hemminger <stephen@networkplumber.org>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Savino Dicanosa <savy@syst3mfailure.io>, Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH 03/12] net/sched: netem: add per-CPU recursion guard for duplication
Message-ID: <ydqKfVXU_4_kSsU89EbfSyd66aGeaCaVHFr6kXhrF-qG7G2WCAAOS51LTAM2y_thGnB0pp-pbGLDWqM4XooMX-jelz30W0KbpE3KzCKiWqo=@willsroot.io>
In-Reply-To: <20260313211646.12549-4-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org> <20260313211646.12549-4-stephen@networkplumber.org>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 6f1399f9c83baaca7c8f762ed71be5a2e689db52
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[willsroot.io,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[willsroot.io:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225441-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[willsroot.io:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@willsroot.io,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syst3mfailure.io:email,willsroot.io:dkim,willsroot.io:email,willsroot.io:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7883828E982
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Looping in Jamal and Victor.

On Friday, March 13th, 2026 at 9:17 PM, Stephen Hemminger <stephen@networkp=
lumber.org> wrote:

> Add a per-CPU recursion depth counter to netem_enqueue(). When netem
> duplicates a packet, the clone is re-enqueued at the root qdisc. If
> the tree contains other netem instances, this can recurse without
> bound, causing soft lockups and OOM.
>=20
> This approach was previously considered but rejected on the grounds
> that netem_dequeue calling enqueue on a child netem could bypass the
> depth check. That concern does not apply: the child netem's
> netem_enqueue() increments the same per-CPU counter, so the total
> nesting depth across all netem instances in the call chain is tracked
> correctly.

I'm assuming you are referring to [1] (and other relevant followup messages=
), but has this setup been tested against the original repro? I think there=
 was a similar draft fix originally but it failed during testing because DO=
S still happened [2].

If I remember correctly,  the issue is less so the recursive depth but more=
 so being able to differentiate between packets that are previously involve=
d in duplication or not.

>=20
> A depth limit of 4 is generous for any legitimate configuration.
>=20
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220774
> Cc: stable@vger.kernel.org
> Reported-by: William Liu <will@willsroot.io>
> Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  net/sched/sch_netem.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index 0ccf74a9cb82..085fa3ad6f83 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -21,6 +21,7 @@
>  #include <linux/rtnetlink.h>
>  #include <linux/reciprocal_div.h>
>  #include <linux/rbtree.h>
> +#include <linux/percpu.h>
>=20
>  #include <net/gso.h>
>  #include <net/netlink.h>
> @@ -29,6 +30,15 @@
>=20
>  #define VERSION "1.3"
>=20
> +/*
> + * Limit for recursion from duplication.
> + * Duplicated packets are re-enqueued at the root qdisc, which may
> + * reach this or another netem instance, causing nested calls to
> + * netem_enqueue(). This per-CPU counter limits the total depth.
> + */
> +static DEFINE_PER_CPU(unsigned int, netem_enqueue_depth);
> +#define NETEM_RECURSION_LIMIT=094
> +
>  /*=09Network Emulation Queuing algorithm.
>  =09=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> @@ -460,6 +470,14 @@ static int netem_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>  =09/* Do not fool qdisc_drop_all() */
>  =09skb->prev =3D NULL;
>=20
> +=09/* Guard against recursion from duplication re-injection. */
> +=09if (unlikely(this_cpu_inc_return(netem_enqueue_depth) >
> +=09=09     NETEM_RECURSION_LIMIT)) {
> +=09=09this_cpu_dec(netem_enqueue_depth);
> +=09=09qdisc_drop(skb, sch, to_free);
> +=09=09return NET_XMIT_DROP;
> +=09}
> +
>  =09/* Random duplication */
>  =09if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q->pr=
ng))
>  =09=09++count;
> @@ -474,6 +492,7 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
>  =09if (count =3D=3D 0) {
>  =09=09qdisc_qstats_drop(sch);
>  =09=09__qdisc_drop(skb, to_free);
> +=09=09this_cpu_dec(netem_enqueue_depth);
>  =09=09return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>  =09}
>=20
> @@ -529,6 +548,7 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
>  =09=09qdisc_drop_all(skb, sch, to_free);
>  =09=09if (skb2)
>  =09=09=09__qdisc_drop(skb2, to_free);
> +=09=09this_cpu_dec(netem_enqueue_depth);
>  =09=09return NET_XMIT_DROP;
>  =09}
>=20
> @@ -643,8 +663,10 @@ static int netem_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>  =09=09/* Parent qdiscs accounted for 1 skb of size @prev_len */
>  =09=09qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_len));
>  =09} else if (!skb) {
> +=09=09this_cpu_dec(netem_enqueue_depth);
>  =09=09return NET_XMIT_DROP;
>  =09}
> +=09this_cpu_dec(netem_enqueue_depth);
>  =09return NET_XMIT_SUCCESS;
>  }
>=20
> --
> 2.51.0
>=20
>=20

What about the last suggestion for a robust fix from [3]?

Best,
Will

[1] https://lore.kernel.org/netdev/DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6FplNm=
kpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=3D@will=
sroot.io/
[2] https://lore.kernel.org/netdev/q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZgGmAg=
kH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=3D@will=
sroot.io/
[3] https://lore.kernel.org/netdev/20260111163947.811248-6-jhs@mojatatu.com=
/


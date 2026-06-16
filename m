Return-Path: <stable+bounces-263492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W89QKIKVMGrmUgUAu9opvQ
	(envelope-from <stable+bounces-263492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:14:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F3E68AD98
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:14:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=m3Nq776i;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263492-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263492-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91ABF307ED85
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 00:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3C414F70;
	Tue, 16 Jun 2026 00:12:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37F17555
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:12:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781568757; cv=none; b=HceZ5zy2B+HofTZMc6cmzlsIV04rN+SVxR0Qyhya8Xt9l+1S/NLYQTrVMvnk5RGEgyKKA82PidZr3rwjY+wxFSl4tpny3DXMqV1yH9tTcp7L+sMXLP4OCHeWwazT73n0y3cvmpykJdtmd7FRX3OWvplSnr+3sX0TOC6gn05mtKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781568757; c=relaxed/simple;
	bh=gHU0o8P6ChzWk1DbkK6CCpDdRsvZfq8ko5gZbqJ1SWk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GM/e+G74KAmzha7m5A+AG8hE0X7EEdIxgbIdbgDFbP3CLFqbC6CH06cFQj948q6rvzxG379H/08/DklAOda7fYgwV+l54bgP4saotrIn7uLNQKOl892GrFpfp5q85572bAzd+SRrrTEQ1Y2SpRhplm0SHElTscTJ5K7Hja56Rlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=m3Nq776i; arc=none smtp.client-ip=79.135.106.99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781568749; x=1781827949;
	bh=BdI7Z8rYqKCtK3JUz8tPFyG8Q3/wXtIHV1fyc1ijCZ4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=m3Nq776i8+bwaRb3psuy6/brbJqb6ijM8Bn1ltCxzty17DZu0ed08n8RgoHt6Bpb/
	 Jq706iwdCzqsNAqD4X4JN+BQ46dirWMMWnJrg+/B/LqVxpBhcVxwC3JYSU276B3AKm
	 2iN9/EStJkNGhlpKAjzndDpHyxFrElWQDAm31AAxIIuWwe4F5WDzJHHaSMhGQZn5cH
	 HscXpvn1WgVdPiL8spFfLZM8YQjhznbT2Xzs1nNcNaDuq4kpfdqEu3OET+oVp9pJQO
	 7hiyL88Ay5E4plxiqtOXej4/gWvHOE+Tar+VeT6bGQ6GvCyT6QS/7Ji2l9TSS4rPVq
	 43VtmwC2IVN3g==
Date: Tue, 16 Jun 2026 00:12:24 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: =?utf-8?B?7KCV7KeA7IiY?= <jschung2@proton.me>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, Gerlinde <lrGerlinde@mailfence.com>, zyc zyc <zyc199902@zohomail.cn>, Manas Ghandat <ghandatmanas@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 073/307] net/sched: Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Message-ID: <1vJDIl9l1-tRjd8Ud-slhuPjlivZ2VITgfJJiZ9QtYz9ljn1ItiHb1sZ_X2JgCO8qepuo1jb3N5HH6azmiky9NA66NeyBxzZzV7Bc03ulBI=@proton.me>
In-Reply-To: <20260607095730.443050343@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org> <20260607095730.443050343@linuxfoundation.org>
Feedback-ID: 167072316:user:proton
X-Pm-Message-ID: 6f86f1f6be0a9a0aa17565ea756a4115eae5fb4d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,mailfence.com,zohomail.cn,gmail.com,networkplumber.org,mojatatu.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-263492-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jschung2@proton.me,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:lrGerlinde@mailfence.com,m:zyc199902@zohomail.cn,m:ghandatmanas@gmail.com,m:stephen@networkplumber.org,m:jhs@mojatatu.com,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[proton.me:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jschung2@proton.me,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,mojatatu.com:email,zohomail.cn:email,mailfence.com:email,networkplumber.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00F3E68AD98





=EC=95=88=EC=A0=84=ED=95=9C Proton Mail=EB=A1=9C =EC=A0=84=EC=86=A1=
=EB=90=98=EC=97=88=EC=8A=B5=EB=8B=88=EB=8B=A4.

=EC=97=90 2026=EB=85=84 6=EC=9B=94 7=EC=9D=BC =EC=9D=BC=EC=9A=94=EC=9D=
=BC 10:20 Greg Kroah-Hartman <gregkh@linuxfoundation.org> =EB=8B=98=
=EC=9D=B4 =EC=9E=91=EC=84=B1=ED=95=A8:

> 6.12-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Jamal Hadi Salim <jhs@mojatatu.com>
>=20
> [ Upstream commit eda0b7f203bb166c98d1418b204135bd566ac83b ]
>=20
> This reverts commit ec8e0e3d7adef940cdf9475e2352c0680189d14e.
>=20
> The original patch rejects any tree containing two netems when
> either has duplication set, even when they sit on unrelated classes
> of the same classful parent. That broke configurations that have
> worked since netem was introduced.
>=20
> The re-entrancy problem the original commit was trying to solve is
> handled by later patch using tc_depth flag.
>=20
> Doing this revert will (re)expose the original bug with multiple
> netem duplication. When this patch is backported make sure
> and get the full series.
>=20
> Fixes: ec8e0e3d7ade ("net/sched: Restrict conditions for adding duplicati=
ng netems to qdisc tree")
> Reported-by: Ji-Soo Chung <jschung2@proton.me>
> Reported-by: Gerlinde <lrGerlinde@mailfence.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220774
> Reported-by: zyc zyc <zyc199902@zohomail.cn>
> Closes: https://lore.kernel.org/all/19adda5a1e2.12410b78222774.9191120410=
578703463@zohomail.cn/
> Reported-by: Manas Ghandat <ghandatmanas@gmail.com>
> Closes: https://lore.kernel.org/netdev/f69b2c8f-8325-4c2e-a011-6dbc089f30=
e4@gmail.com/
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Link: https://patch.msgid.link/20260525122556.973584-3-jhs@mojatatu.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/sched/sch_netem.c | 40 ----------------------------------------
>  1 file changed, 40 deletions(-)
>=20
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index 498c18d7d9c39b..1fdebf2ab7ee46 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -1005,41 +1005,6 @@ static int parse_attr(struct nlattr *tb[], int max=
type, struct nlattr *nla,
>  =09return 0;
>  }
>=20
> -static const struct Qdisc_class_ops netem_class_ops;
> -
> -static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
> -=09=09=09       struct netlink_ext_ack *extack)
> -{
> -=09struct Qdisc *root, *q;
> -=09unsigned int i;
> -
> -=09root =3D qdisc_root_sleeping(sch);
> -
> -=09if (sch !=3D root && root->ops->cl_ops =3D=3D &netem_class_ops) {
> -=09=09if (duplicates ||
> -=09=09    ((struct netem_sched_data *)qdisc_priv(root))->duplicate)
> -=09=09=09goto err;
> -=09}
> -
> -=09if (!qdisc_dev(root))
> -=09=09return 0;
> -
> -=09hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
> -=09=09if (sch !=3D q && q->ops->cl_ops =3D=3D &netem_class_ops) {
> -=09=09=09if (duplicates ||
> -=09=09=09    ((struct netem_sched_data *)qdisc_priv(q))->duplicate)
> -=09=09=09=09goto err;
> -=09=09}
> -=09}
> -
> -=09return 0;
> -
> -err:
> -=09NL_SET_ERR_MSG(extack,
> -=09=09       "netem: cannot mix duplicating netems with other netems in =
tree");
> -=09return -EINVAL;
> -}
> -
>  /* Parse netlink message to set options */
>  static int netem_change(struct Qdisc *sch, struct nlattr *opt,
>  =09=09=09struct netlink_ext_ack *extack)
> @@ -1116,11 +1081,6 @@ static int netem_change(struct Qdisc *sch, struct =
nlattr *opt,
>  =09q->gap =3D qopt->gap;
>  =09q->counter =3D 0;
>  =09q->loss =3D qopt->loss;
> -
> -=09ret =3D check_netem_in_tree(sch, qopt->duplicate, extack);
> -=09if (ret)
> -=09=09goto unlock;
> -
>  =09q->duplicate =3D qopt->duplicate;
>=20
>  =09/* for compatibility with earlier versions.
> --
> 2.53.0
>=20
>=20
>=20
> 


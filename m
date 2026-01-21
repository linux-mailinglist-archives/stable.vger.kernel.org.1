Return-Path: <stable+bounces-210754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFKoEhbYcGkOaAAAu9opvQ
	(envelope-from <stable+bounces-210754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:43:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8CD57B1D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C03F26A2127
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E553048AE3D;
	Wed, 21 Jan 2026 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="g4k6poje"
X-Original-To: stable@vger.kernel.org
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C248B367;
	Wed, 21 Jan 2026 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001668; cv=none; b=HNIkPXn8AFeg3Rv/NaqtpV9A6h5xR8eu38a8dnL8cQDCQSKK8CA4NsFksFqvNiJOqqqQu2pdxhyBHcruQYuf9QXZLjJO76vRIb/v02K0tgBL0am+dFyuLwJB5OplDA/P5zGUoYo5Y3WayJPhaRtjvSZLH1Q3NB6Q35EiPb9CcN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001668; c=relaxed/simple;
	bh=TPdEcIfJbqvoBHnoEwlBnlyJ+FPShZCQQ5uzsnJd7n0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MT9KqxpwyoeYuFcqqMopeOvHS+hgWeXLs8Ou5BNE4/hUfu0L2L6r8SbhwMus73B3J8QQJG5e4PyC/kfYuImJie3gBSyimBr2cPpuPNAfdPgh7GyP62Ztf6K892cMxT2XzPHZDqNDhjEmdZIC8XYRk9/5ly0ijck3+NwKiAxNVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=g4k6poje; arc=none smtp.client-ip=185.70.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769001661; x=1769260861;
	bh=TPdEcIfJbqvoBHnoEwlBnlyJ+FPShZCQQ5uzsnJd7n0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=g4k6pojemtv1avJcQjJOb12NGsD6P71kYNK1XyAxg9oY0Tjg4ToGwCKXiev89NqdB
	 jPqx2+zxqxTUWaWv9pMrJ7Btw+WlPtQlww7UMZfwynEV4JIPvpVa58UuUmcgjmD3dr
	 pE6jdAAwrmT4XtelenZlaTXa0oFoE4cho7aLTZz3hjxXSyMCpp9hZi9kiNFQs/PT6j
	 valIqdHgjCqt91gMRlP2ng2R3tjekZRpPU3wxLPyMi9RDG5Zl+IMzGfNLdcOuKGbMX
	 K1T1CfrirRzuejchmKGHqltLwfQbN6uEGDyKy1RgOT7HMtI3OFDu+sbKmzI6OIhqBu
	 9K3k9fWTINlIQ==
Date: Wed, 21 Jan 2026 13:20:59 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v3 6/7] net/sched: act_gate: reject empty schedule list
Message-ID: <20260121131954.2710459-7-p@1g4.org>
In-Reply-To: <20260121131954.2710459-1-p@1g4.org>
References: <20260121131954.2710459-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 7d60970e1245a4f9269fc3b9069c5a4c9c5c7552
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210754-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,1g4.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[1g4.org,quarantine];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,1g4.org:dkim,1g4.org:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: DC8CD57B1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject empty schedules (num_entries =3D=3D 0) so next_entry is always valid=
 and
RCU readers/timer logic never walk an empty list. taprio enforces the same
constraint on schedules (sch_taprio.c, commit 09dbdf28f9f9fa).

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Signed-off-by: Paul Moses <p@1g4.org>
Cc: stable@vger.kernel.org
---
 net/sched/act_gate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 48ff378bb051a..e4134b9a4a314 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -509,6 +509,12 @@ static int tcf_gate_init(struct net *net, struct nlatt=
r *nla,
 =09=09cycletime_ext =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
 =09p->tcfg_cycletime_ext =3D cycletime_ext;
=20
+=09if (p->num_entries =3D=3D 0) {
+=09=09NL_SET_ERR_MSG(extack, "The entry list is empty");
+=09=09err =3D -EINVAL;
+=09=09goto release_mem;
+=09}
+
 =09err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
 =09if (err < 0)
 =09=09goto release_mem;
--=20
2.52.GIT




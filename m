Return-Path: <stable+bounces-217667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKvFOjUPm2nXrQMAu9opvQ
	(envelope-from <stable+bounces-217667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 15:14:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FEE16F4CF
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42CC73010D8A
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43734F263;
	Sun, 22 Feb 2026 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="Po4eeMZE"
X-Original-To: stable@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14F14F9FB
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771769646; cv=none; b=lnGq8o7ENT9hOJdfOST5ZhAczJnzfkFK74wjDRjQG3bilE5RcM8E1tl/ihqThQc9VHhOvR8tn6s6ZdIotFRPnKHmsjgbM+xgaAsu81SEelnP7Ao3s0HJzg6L2TGzW36fKTx8qVY30hWJIVfORctZfqPAe0FPqL3PjR0HPA9wVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771769646; c=relaxed/simple;
	bh=YlhwZtT6lQpJZQrBwYMuS4uodMU+A7IJ0QGf7iOpS/Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgHM/1cP/tOiX2ov/dQDR50tjjWq8VC7TM//oBKMjHUMuZHSA7bkn7JRSPVD5Dcd8C23oDQw1P8JcLqvXkNuzuSgCBHxEoUTjpSTKUOOBExtCq2NLBPUEV1kniRzhNvHGp1or15mOVbnnli9laSBesJNJMW3N+BIC//pXXPhiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=Po4eeMZE; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1771769633; x=1772028833;
	bh=WKetLVT5qlJRXWScnFoa6cZZfrOZXHZRzM7RAgDP9Io=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Po4eeMZE/wTBHxtR1Dy/WKr/SMoXZedjRb2ky4jTwEjpHBpn3gYHd3f/n7L2TNDyS
	 fLUfn8Uoc80/Zs5ShRU4DbjuMboX6qQHSkMOZiDRzOov3JIXdWsGA81TpWsyX30PB4
	 opfsdO30xQ++WoE0OjAfA6NhLfUSFiqlqFFe03d+sBqfPCVgUh8FcA1CHoqs2M5KS+
	 EYdOKO9Qit+usVEHOl35XqET4uDclKBrgshzgyDIlnfeqSGnX2XMzEOEahpRpMukYg
	 IcY8S6XFzCE57R+88+Tkc2zg3zSVHmWjhql9SsM/eOf71ItZxn+9+6uWOFClYZ7bFK
	 dj0yBR79a7CFw==
Date: Sun, 22 Feb 2026 14:13:46 +0000
To: Victor Nogueira <victor@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v7 1/1] net/sched: act_gate: snapshot parameters with RCU on replace
Message-ID: <TtHh0X2fAHdo4Gs6voxOjI5iFT3kt9qJkutxcHLc3nSpal0RiOTy6cXeZ4FSJMRcD2qVJy__ER-pvJhgBhbj9qucVu5yNecJfCeD44HmtBE=@1g4.org>
In-Reply-To: <CA+NMeC-WmxL48X5dSqGx5+2T_dR8B_g5C2BL2Hre_HG1-UkXDg@mail.gmail.com>
References: <20260219023151.171753-1-p@1g4.org> <20260219023151.171753-2-p@1g4.org> <CA+NMeC-WmxL48X5dSqGx5+2T_dR8B_g5C2BL2Hre_HG1-UkXDg@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 8c574c358d6a0b0b06cd1f28e567252f4d25342e
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217667-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85FEE16F4CF
X-Rspamd-Action: no action

Yes, I only see it as unreachable code cleanup.

While looking at cycletime, should I move that block before=20
spin_lock_bh()? It only touches the private p snapshot before it
is published, so it looks safe to run outside the lock. I am not sure=20
where the line is before this turns into a refactor.



diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index d09013ae1892a..660d833dce557 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -483,6 +483,15 @@ static int tcf_gate_init(struct net *net, struct nlatt=
r *nla,
                goto err_free;
        timer_clockid =3D clockid;
=20
+       if (!cycletime) {
+               struct tcfg_gate_entry *entry;
+               ktime_t cycle =3D 0;
+
+               list_for_each_entry(entry, &p->entries, list)
+                       cycle =3D ktime_add_ns(cycle, entry->interval);
+               cycletime =3D cycle;
+       }
+
        need_cancel =3D ret !=3D ACT_P_CREATED &&
                      gate_timer_needs_cancel(basetime, old_basetime,
                                              tko, old_tk_offset,
@@ -493,14 +502,6 @@ static int tcf_gate_init(struct net *net, struct nlatt=
r *nla,
=20
        spin_lock_bh(&gact->tcf_lock);
=20
-       if (!cycletime) {
-               struct tcfg_gate_entry *entry;
-               ktime_t cycle =3D 0;
-
-               list_for_each_entry(entry, &p->entries, list)
-                       cycle =3D ktime_add_ns(cycle, entry->interval);
-               cycletime =3D cycle;
-       }
        p->tcfg_cycletime =3D cycletime;
        p->tcfg_cycletime_ext =3D cycletime_ext;
=20



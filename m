Return-Path: <stable+bounces-212883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBNLMoK2fGm7OQIAu9opvQ
	(envelope-from <stable+bounces-212883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:47:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A44ABB530
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77B3D303F7FC
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D88630C61D;
	Fri, 30 Jan 2026 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="U1IYfEJ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19532690EC;
	Fri, 30 Jan 2026 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780633; cv=none; b=LTLDbcMVZw+LIMjrvexQOCm7qf5mfIHOCRVxcXs2cLdr6xulxwYSTCFL1katOo77/SEiwJeQUhu2Ua8ZP/NtUeF7Vnwd2/a3+CSPOtaWm+iRNr7XR3SEmw3woTIBBvGNuG1H1de4YDGHf+ty49AIHnc1d7N+oPD26i3F7c/4drM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780633; c=relaxed/simple;
	bh=rAGOGx/VCQd8tSSh1Fy/QiBJT9QETQryqJToEiumKio=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YeZhDddbTSKBBO3zTLLjF7iBMvKQv8LLeLD4/BHxUtCOv6s+LDt+zmmWE+7nR0r5xHFJhVMVcVcmx4BDIzdAnUv7wcAtzmHrlA4yt+uo7/6IIFV69xxdmpZ3FT87CrUunUrM84D5YTLmsVT3nAHISn7jxVQoSnVbtP0eajLwhvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=U1IYfEJ/; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769780613; x=1770039813;
	bh=4KDZUqvmMno7yW8oOrUdUcN5Nz5/pz+QmHHRkxvLtuU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=U1IYfEJ/Ko4xyhSTf72fovpGvLO3FmrTGYd97ILt7fbVP8jcVw6o4+C+GXjPkiB7u
	 Ej3N2HXJNLdCw5/Jn9jVM35h8e1l/t0ZTA0kUqsw5dBh6nTc8kYILYXdZ1+SQiLioK
	 8/aU7X/aCcfuMEwcAWr4p8+WC73fK/EBYy1vfLaZ0YlK9b2WbhZSxKDlwAFCy0OeRJ
	 6UOn6DTAY+KGO4xACZDkjiTB6dYuX6KLpOFeSg8DHfg9T8i83HpH40n+lviYVTE2o8
	 JarKd9Qv9BbHONak7JZjZGpOQEtbNiVJbl9GRrI5weTAni5hEyfiOMQaTLFfTOoHHk
	 fCwIAyC2Os97Q==
Date: Fri, 30 Jan 2026 13:43:29 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
Message-ID: <20260130134220.305757-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 8aee2c205e039bc00247308ff3996e9fb0d23fc8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212883-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,1g4.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,1g4.org:dkim,1g4.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A44ABB530
X-Rspamd-Action: no action

tcf_action_fill_size() already computes the required dump size, but
RTM_GETACTION replies always allocate NLMSG_GOODSIZE. Large action
state can overrun that skb and make dumps fail.

Use the computed reply size for RTM_GETACTION replies so large actions
can be dumped, while still keeping NLMSG_GOODSIZE as a floor.

Fixes: 4e76e75d6aba ("net sched actions: calculate add/delete event message=
 size")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 net/sched/act_api.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index e1ab0faeb8113..8ab016d352850 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1685,12 +1685,12 @@ static int tca_get_fill(struct sk_buff *skb, struct=
 tc_action *actions[],
=20
 static int
 tcf_get_notify(struct net *net, u32 portid, struct nlmsghdr *n,
-=09       struct tc_action *actions[], int event,
+=09       struct tc_action *actions[], int event, size_t attr_size,
 =09       struct netlink_ext_ack *extack)
 {
 =09struct sk_buff *skb;
=20
-=09skb =3D alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+=09skb =3D alloc_skb(max_t(size_t, attr_size, NLMSG_GOODSIZE), GFP_KERNEL)=
;
 =09if (!skb)
 =09=09return -ENOBUFS;
 =09if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, event,
@@ -2041,7 +2041,8 @@ tca_action_gd(struct net *net, struct nlattr *nla, st=
ruct nlmsghdr *n,
 =09attr_size =3D tcf_action_full_attrs_size(attr_size);
=20
 =09if (event =3D=3D RTM_GETACTION)
-=09=09ret =3D tcf_get_notify(net, portid, n, actions, event, extack);
+=09=09ret =3D tcf_get_notify(net, portid, n, actions, event,
+=09=09=09=09     attr_size, extack);
 =09else { /* delete */
 =09=09ret =3D tcf_del_notify(net, n, actions, portid, attr_size, extack);
 =09=09if (ret)
--=20
2.52.GIT




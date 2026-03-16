Return-Path: <stable+bounces-225659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKT0E35RuGmKcAEAu9opvQ
	(envelope-from <stable+bounces-225659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:52:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCB029F526
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B9D93062438
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E13D5652;
	Mon, 16 Mar 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="YDZKP+6q"
X-Original-To: stable@vger.kernel.org
Received: from mail-106100.protonmail.ch (mail-106100.protonmail.ch [79.135.106.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2337D30B509
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686764; cv=none; b=lHit1EKjJMNVMBpzXxwR4OaTkAabLanNJpHVwRdGk6aYt2ocjZFNtJcuSZZveiZOW6fAKEiSMGdijC60cYhyF6fShrMxsUZiW91fYEcKJxTxzscKV2WAmExw73K8PTmz+MDakXWGO6i7vvpobtV4NCmYkwpWt3PecoWM0O+JePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686764; c=relaxed/simple;
	bh=GhaGTWaAC9f2cyezBsr1nAmhVqDMM4husB5sfRHYLqs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXoSsxU4/kMEFDo8UiycbgX28lT56NKoaqTl9qMREqWeJe6/+MEyu76vQihLBblCoQ4nEKfbLphooM4ZfxqMAn9ITWBXNm3ZJYUJJk0UhrAHQFaPJAVvoBIstbdgWcea1gRCVXahAg8JYSm5ivb95umbLjVKVbe6KrdDD/wxt6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=YDZKP+6q; arc=none smtp.client-ip=79.135.106.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773686752; x=1773945952;
	bh=jYCSUK08Navzfq6Y6W1JAa1hQPi9EJkF7xj1O3nnbBI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YDZKP+6qwHw+vopjjYN5aLZgLhIQPPMnBe3awSYFntqha02lWBIT5q3fcgI4lC6Kv
	 WfGP+ZJwrEerUHwcKGni4trdlzGETmk4PrrPh53BFfh2ZuVzp+7HflXSHnqzyJ926n
	 IRTPaECiUgAyIeLzNbTSp2WwAjYKAQR/m786KejOQGXqZDQy63ECrHnY/15huN82uC
	 m+8YCeedD4A7mcHjeG7hGQhaWeM+VtzbppYISK+N2kVQ6uaCoJ+Woi6xVrSyRtLcJl
	 6F8Gz7jhdRHCuBq7B3oBiuibHPXRwQhzkh/343Km2tqwGE5LW0jVgJl1pmtpdxeC8H
	 ytpCf9rPLxRAg==
Date: Mon, 16 Mar 2026 18:45:48 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer flush frees with RCU
Message-ID: <hHYLQqDrBCcK_2x6uSbGsBott3QuXe8o-R9tj4vNmw8UUEFxpzoD_PCMiHMyyOnySAtQbJtCAB8yVoCmWxzO07C02Q5o0J6fHu4NLEa-ggY=@1g4.org>
In-Reply-To: <20260310192842.3c3b2070@kernel.org>
References: <20260309173450.538026-1-p@1g4.org> <20260310192842.3c3b2070@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 0ccbae606882ace79d5a92f44365f6688dda9b9d
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
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225659-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[1g4.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBCB029F526
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This is not the right fix. The shaper hierarchy as a while is not under
> RCU. The problem is that we take a ref on netdev and then lock it,
> assuming that it's still alive. But it may have gotten unregistered in
> the meantime. The correct fix is to check that the netdev is still
> alive after we lock the binding or take RCU from the Netlink side.

Ok I see it now, I didn't care about anything except queue because it's the=
 only=20
path that affected both drivers. This is an entirely different issue.

1. net_shaper_nl_pre_doit() =E2=86=92 net_shaper_ctx_setup()
=09gets dev =3D netdev_get_by_index(...) (ref only, no alive check)=20
2. Before doit runs, unregister can do:
=09- unlist_netdevice(dev) (dev.c:12388)
=09- dev->reg_state =3D NETREG_UNREGISTERING=20
3. Doit then runs:
=09- net_shaper_lock(binding)=20
=09- continues without checking reg_state
=09- may call ops->set/delete/group() on a dying device

Here's the flow of reported issue:

1) A userspace GET doit path does this:

  net_shaper_nl_get_doit()
    -> rcu_read_lock()
    -> net_shaper_lookup()
         -> net_shaper_hierarchy()
              -> READ_ONCE(dev->net_shaper_hierarchy)
         -> xa_get_mark() / xa_load()
              -> dereference hierarchy->shapers
    -> rcu_read_unlock()

That can race with netdevice unregister teardown:

  net_shaper_flush_netdev()
    -> net_shaper_flush()
         -> xa_for_each(...) {
              __xa_erase(...)
              kfree(cur)
            }
         -> kfree(hierarchy)

The problem is that readers walk the published hierarchy locklessly under
an RCU read-side section, but teardown reclaims both the shapers and the
hierarchy with plain kfree() rather than kfree_rcu().

2) The original flush path does this:

  net_shaper_flush()
    -> hierarchy =3D net_shaper_hierarchy(binding)
    -> ... free shapers ...
    -> kfree(hierarchy)
    -> no WRITE_ONCE(dev->net_shaper_hierarchy, NULL)

So a later GET reader can still do:

  net_shaper_hierarchy()
    -> return stale non-NULL pointer

and then walk the freed hierarchy through xa_* operations.

The only remaining issue I found after fully reviewing this is the dump
path, but I have not been able to reproduce it so far:

- kfree_rcu() only protects readers that have already entered
  rcu_read_lock()
- In the old net_shaper_nl_get_dumpit(), hierarchy was loaded before
  rcu_read_lock()
- So this sequence is possible:
    1. dump path reads the hierarchy pointer
    2. gets preempted
    3. teardown detaches the pointer and queues kfree_rcu()
    4. the grace period ends and the object is freed
    5. dump resumes, enters rcu_read_lock(), and dereferences the stale
       pointer

=09diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
=09index ab0de415546d6..452557c52488b 100644
=09--- a/net/shaper/shaper.c
=09+++ b/net/shaper/shaper.c
=09@@ -779,11 +779,13 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 =09
 =09=09/* Don't error out dumps performed before any set operation. */
 =09=09binding =3D net_shaper_binding_from_ctx(ctx);
=09+=09rcu_read_lock();
 =09=09hierarchy =3D net_shaper_hierarchy(binding);
=09-=09if (!hierarchy)
=09+=09if (!hierarchy) {
=09+=09=09rcu_read_unlock();
 =09=09=09return 0;
=09+=09}
 =09
=09-=09rcu_read_lock();
 =09=09for (; (shaper =3D xa_find(&hierarchy->shapers, &ctx->start_index,
 =09=09=09=09 =09U32_MAX, XA_PRESENT)); ctx->start_index++) {
 =09=09=09ret =3D net_shaper_fill_one(skb, binding, shaper, info);
=09--=20
=092.53.GIT


So I still have no more changes besides possibly the inclusion of this patc=
h.

Thanks,
Paul


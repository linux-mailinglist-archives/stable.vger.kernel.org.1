Return-Path: <stable+bounces-223712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMMrG4EFr2knLwIAu9opvQ
	(envelope-from <stable+bounces-223712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 18:38:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EBA23DB9D
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 18:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E1F0309B0B9
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 17:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2677F2D7DD5;
	Mon,  9 Mar 2026 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="Golh6LwF"
X-Original-To: stable@vger.kernel.org
Received: from mail-244117.protonmail.ch (mail-244117.protonmail.ch [109.224.244.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686153ECBF7;
	Mon,  9 Mar 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077722; cv=none; b=URSQmvf4KZs77lEe2Cwc6+jGxkx4MUzyDX3vV314BL2xXP7EQVp2X/A9Io1oyhIa/1vgbe6v3Ofne21BzB1AY+uVBSxkDgyqSp+75z3rsRpymqEh2uDmxBK6xg5ShzSfGUNBTJkHVEwbFqiPfeMywT2AXENAhRCfQiOSbtUvj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077722; c=relaxed/simple;
	bh=AA9NhOwrZ/h1fhavsjFZKOJ+oGWiLEmHsg9UTIYODC0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qu9idepMWq1K6FWb9SN3+DSRfPZ0Svq8BNdONeCCL3zyh3Psw6ThbR2fGmrWlvjWlbyvKpavnPCh5dWgpFBVC4+2ajZxTe66HfWtwaO/dSPkxLY2YiOSF2pEF92b75d4bUMX16Peof0wQaVZUzqGRS00JyFWSVdvLYK9T9t96CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=Golh6LwF; arc=none smtp.client-ip=109.224.244.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773077710; x=1773336910;
	bh=AA9NhOwrZ/h1fhavsjFZKOJ+oGWiLEmHsg9UTIYODC0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Golh6LwFSC/WcJFLms3I8AlKPtmqwiqGhQkUlCB+DJkGRnOrsXqa77amRZOdYL7u1
	 jWJsjCjbKxS5MR0rsrT0YJxOofyyix8t5mR4b8kpuETgh84pme9Hyz4/JAPG93TG9a
	 azc7yq0O1ZH1EEwhwlm3oPX4e1de3e2TxphX5QEK5b0Uv+44CQe7PXbgNBWhWw+7y5
	 X81MGn1aMDtgkRrDKN866yp/ZfgSLaZSjyQZ+4oCgbMv5UTG4zQBqS7p0D4FOumjCI
	 bySvGCIUi60LWljkG+10sZzfNF/JfkpYj0pPh2qEDScslNnjddn8qVm02M1ZEXk85e
	 NGYtXNkz56M8w==
Date: Mon, 09 Mar 2026 17:35:06 +0000
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
From: Paul Moses <p@1g4.org>
Cc: horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer flush frees with RCU
Message-ID: <20260309173450.538026-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 83bc13857a5f90e0748ffeda2567d54b327ca421
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E0EBA23DB9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223712-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,1g4.org:dkim,1g4.org:email,1g4.org:mid]
X-Rspamd-Action: no action

net_shaper_lookup() and the GET dump path traverse shaper state
under rcu_read_lock() without taking the shaper lock. During
teardown, net_shaper_flush() freed both the shapers and the
hierarchy with kfree(), but netdev->net_shaper_hierarchy still
pointed at the freed hierarchy.

This lets GET readers race netdevice teardown and walk freed
xarray state or freed shaper objects.

Detach the hierarchy pointer from the netdevice under the
shaper lock before teardown and switch the shaper and hierarchy
frees in flush to kfree_rcu().

Fixes: 4b623f9f0f59 ("net-shapers: implement NL get operation")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 net/shaper/shaper.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 005bfc766e22d..3ad5a2d621a91 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -23,6 +23,7 @@
=20
 struct net_shaper_hierarchy {
 =09struct xarray shapers;
+=09struct rcu_head rcu;
 };
=20
 struct net_shaper_nl_ctx {
@@ -1352,23 +1353,28 @@ int net_shaper_nl_cap_get_dumpit(struct sk_buff *sk=
b,
=20
 static void net_shaper_flush(struct net_shaper_binding *binding)
 {
-=09struct net_shaper_hierarchy *hierarchy =3D net_shaper_hierarchy(binding=
);
+=09struct net_shaper_hierarchy *hierarchy;
 =09struct net_shaper *cur;
 =09unsigned long index;
=20
-=09if (!hierarchy)
+=09net_shaper_lock(binding);
+=09hierarchy =3D net_shaper_hierarchy(binding);
+=09if (!hierarchy) {
+=09=09net_shaper_unlock(binding);
 =09=09return;
+=09}
+
+=09WRITE_ONCE(binding->netdev->net_shaper_hierarchy, NULL);
=20
-=09net_shaper_lock(binding);
 =09xa_lock(&hierarchy->shapers);
 =09xa_for_each(&hierarchy->shapers, index, cur) {
 =09=09__xa_erase(&hierarchy->shapers, index);
-=09=09kfree(cur);
+=09=09kfree_rcu(cur, rcu);
 =09}
 =09xa_unlock(&hierarchy->shapers);
 =09net_shaper_unlock(binding);
=20
-=09kfree(hierarchy);
+=09kfree_rcu(hierarchy, rcu);
 }
=20
 void net_shaper_flush_netdev(struct net_device *dev)
--=20
2.53.GIT




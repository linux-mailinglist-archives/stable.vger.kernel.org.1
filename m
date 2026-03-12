Return-Path: <stable+bounces-224849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI9cEg2msmnwOQAAu9opvQ
	(envelope-from <stable+bounces-224849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 12:39:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA62711EC
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 12:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81635301A7F8
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E74327C18;
	Thu, 12 Mar 2026 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="s60zAnIR"
X-Original-To: stable@vger.kernel.org
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2E3314C2;
	Thu, 12 Mar 2026 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315567; cv=none; b=IGrVx2sOFOLvy5bIVs90kc7MHIrB2KdQv5rDLXeiB8r0Uh4rAps2B1X/DGP9aMsVBWBOJvdhEPpy02jOReYZwPIiAHqGZDEp1GU1ZS6AYvA15wozAWJChbV+OnHgGLehW27s2PHAqRdmATAZytu4NQwqZZCRKftYGFOE3XJ+bDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315567; c=relaxed/simple;
	bh=kyZAMKw4V1o9gGmNIRpZixDA50Qf3DiNCsfDJ1vw41k=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kV8j0kRSwuJazZzqMjd+suQ1pnhwH3v6GK/S6F0vJ/Mq3bTJ08STjkPI4D1/aEb7bhIGWod9NlO8CFFYqcj9yU/7Ydn2uZc9k/YqLAZwF/KVo/gbLstIdfrz25BzRTlxWS7rfGsd84Jpqi+xJMeQ+EmM9t7sKYG62hylDP9SaSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=s60zAnIR; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773315554; x=1773574754;
	bh=kyZAMKw4V1o9gGmNIRpZixDA50Qf3DiNCsfDJ1vw41k=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=s60zAnIRfLkomsTfxSWfxjdMVXkSFN3Uk1KNb3rOFLIrAU2N0CRmR1VhcU7pwq9/u
	 XG3mv9GcXLImNR+iZDZBZZ4pL1aZgam9eYchlwObdUc04XE6zUzpoUInp0jgDOo+VT
	 tVoOPlQWoQ9NyMV+y4PUMILWgHnO0tyvsrQV4lrJmxGYIuYKznZ0fYQyk5Eb52nngO
	 mENI6DSeY3kyCA29OGpV4nX14Xy3Sz+cUKVZ1pTEJhTHtWjx0t8sv+sMGiNkRoUYbC
	 t2/x2Jgik4bG2xXvsWl0heBBJpZiIWCFpLp1chlAsGHDLRXNmYaTYcEOVRbHK9iNRj
	 FFEGWXSRzTQ8Q==
Date: Thu, 12 Mar 2026 11:39:09 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, chopps@labn.net, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v2] xfrm: iptfs: only publish mode_data after clone setup
Message-ID: <20260312113843.2883169-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: ff4493f192468e5adf684ad20129db110499d72e
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224849-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31FA62711EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iptfs_clone_state() stores x->mode_data before allocating the reorder
window. If that allocation fails, the code frees the cloned state and
returns -ENOMEM, leaving x->mode_data pointing at freed memory.

The xfrm clone unwind later runs destroy_state() through x->mode_data,
so the failed clone path tears down IPTFS state that clone_state()
already freed.

Keep the cloned IPTFS state private until all allocations succeed so
failed clones leave x->mode_data unset. The destroy path already
handles a NULL mode_data pointer.

Fixes: 6be02e3e4f37 ("xfrm: iptfs: handle reordering of received packets")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
Changes in v2:
- Fix Fixes tag to point to 6be02e3e4f37

 net/xfrm/xfrm_iptfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 050a82101ca51..4d7a925f59b7c 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2653,9 +2653,6 @@ static int iptfs_clone_state(struct xfrm_state *x, st=
ruct xfrm_state *orig)
 =09if (!xtfs)
 =09=09return -ENOMEM;
=20
-=09x->mode_data =3D xtfs;
-=09xtfs->x =3D x;
-
 =09xtfs->ra_newskb =3D NULL;
 =09if (xtfs->cfg.reorder_win_size) {
 =09=09xtfs->w_saved =3D kzalloc_objs(*xtfs->w_saved,
@@ -2666,6 +2663,9 @@ static int iptfs_clone_state(struct xfrm_state *x, st=
ruct xfrm_state *orig)
 =09=09}
 =09}
=20
+=09x->mode_data =3D xtfs;
+=09xtfs->x =3D x;
+
 =09return 0;
 }
=20
--=20
2.53.GIT




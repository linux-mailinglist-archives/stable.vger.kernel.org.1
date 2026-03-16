Return-Path: <stable+bounces-225570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB03HE4auGn/YwEAu9opvQ
	(envelope-from <stable+bounces-225570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:57:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF5F29BDBA
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57D83302CB16
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA81D30648C;
	Mon, 16 Mar 2026 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="rZW/B/xb"
X-Original-To: stable@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA01304BCB
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673027; cv=none; b=a4VDYTHwZlVKnUQ1z5d/kh2ioh6vr7EsdsG10DUWEAC08jYZtQEy1efXzZznja6gz+ZkkLmQlSGbccRI2y8/oormBqQEJCpr2EcHwCqiCvkVOJG5ESKRFOlQ8oD2hg4Juyckjl6C9lRAq+JBDsySLSu3nhv449LZpcxFRIvuf70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673027; c=relaxed/simple;
	bh=Y1ReUoDwMJO+LpydzwkDbXsa1KYgRtYo1UWlqvLRxbg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iLl/YXwVCyRwDMEOPBz88xya3YraQRhlutrTxv8l9JbfBkYoMJZSd38+FixtvLrtmt1UxJsSNkpneMqY/gRgZwUTTOu9foB1hbCv0YvFzEo6ZyuO05NRtx/PsMawtQIKY7LTJVXjylWz6mD+nGl08k0SjY0ebn4FotY0z+3/4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=rZW/B/xb; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773673016; x=1773932216;
	bh=Y1ReUoDwMJO+LpydzwkDbXsa1KYgRtYo1UWlqvLRxbg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rZW/B/xbv8RTkcBgZxlEZAs0uBgOsFuhBGzcEto8Mt6Ih3gPJj6gVIE7KRH85cejC
	 TrkzWg6ubYRaYKCGwwjljnTi6/ZN8XB4x+cMoPAhdPlgeBYFof9Y4nQYZ0djrtRFpg
	 OpTQlMqRekuDcL1F9V0Rrvw+lpcL/UnscYmxr2TBQQI1DReWP7f0fRlTaXhFxhIqHa
	 Y3OxoaUZNvDhYmf8JFoNIltwWpUBy7cO8yOgVrZ3vuZS56nzs9KtphtniVg5tG6k4C
	 HcONW2GaNzRFBYS9cqEosyH48gXZlvLKLsTALhFX98DGnLqxagutQMoYr0Nsxhu8Yx
	 cCIz8uVSzJRQg==
Date: Mon, 16 Mar 2026 14:56:51 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, chopps@labn.net, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v3] xfrm: iptfs: only publish mode_data after clone setup
Message-ID: <20260316145642.4154656-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 47428d8ed8b1babe832c1a8256bc94242e64a3a3
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225570-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BF5F29BDBA
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
Changes in v3:
- Rebase on top of current ipsec tree

 net/xfrm/xfrm_iptfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 2c87290fe06c..7cd97c1dcd11 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2664,9 +2664,6 @@ static int iptfs_clone_state(struct xfrm_state *x, st=
ruct xfrm_state *orig)
 =09if (!xtfs)
 =09=09return -ENOMEM;
=20
-=09x->mode_data =3D xtfs;
-=09xtfs->x =3D x;
-
 =09xtfs->ra_newskb =3D NULL;
 =09if (xtfs->cfg.reorder_win_size) {
 =09=09xtfs->w_saved =3D kcalloc(xtfs->cfg.reorder_win_size,
@@ -2677,6 +2674,9 @@ static int iptfs_clone_state(struct xfrm_state *x, st=
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




Return-Path: <stable+bounces-223081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHOdK+hMqGnUswAAu9opvQ
	(envelope-from <stable+bounces-223081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 16:16:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE08202699
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 16:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6733D316706E
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F64F238C1B;
	Wed,  4 Mar 2026 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR3KgY7+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5CD611E
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636896; cv=none; b=WazjCEJw7sMmCsA0VvwBlSgQg/KEBI5hipZBGenB0mEPN3tgKWuoIHIufdqzbgVDjS9hVf521ahbDy1VsSTZqAQu6FNCk5gE/rFKtjJDLlBGILyvA7A+6w0ea12aWihWDIC4GxOxxSRnX2weTpSs0bqa17gu2bsOr8IL3wqSpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636896; c=relaxed/simple;
	bh=hJZHBWjuAKHUq98wKq5xbX82Tb0T8NwOLsZYbigMbwM=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVtzHhZ0ZJyeyEgZTD7KaxG141PUW6BIlJLd0KrqTjeR3lUDcgwIOeCVrmzl1RAM4DtFGSj5+X4tTgsFo5J1UJgGDQC0+IFMHR/nqkMXSCHv2JEg3lHIi4+PAh9peHEXQYwcZ3nYQhrRDt4DTfNsmeuZV2Mkf2emEL/bbsHN3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR3KgY7+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4837634de51so29764185e9.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 07:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772636892; x=1773241692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :subject:cc:to:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2z8WY7vcCUjakM8BrF/pvnkiGxjrd9kxLwbg9kPn+Y=;
        b=HR3KgY7+riW/WFfevgOnei2yYiTzafIiMiZOZLmF92ja7GhxB8GT6YoiUKWizl84Qx
         AJwQd4EtVetYLIqxGsn6I5GgIHPjpnVeaEsIugyfgUWU2bENebeH9nvwBSIVKGV5SQCJ
         HtInXv1vdUWQavyjdSsA1Q6nfZ2fAf7VjBf+GJZaoyniBt7edL//9lwK2QZH09yyc3wv
         t5Kg5/6tJZFW1t6nZrwF3Xh2v/UVKKJPd6I+xDYKsRfsDzT0WSPxyLywqdIBVZvLPCt1
         wyRMUC8mxNee7Aweh/ER1eiRZTWT6LoZQwkqShnbb1wmwRikoiEZgIiNjQ7V3R4QrGdM
         sutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636892; x=1773241692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :subject:cc:to:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H2z8WY7vcCUjakM8BrF/pvnkiGxjrd9kxLwbg9kPn+Y=;
        b=TpWDGCC374OOtEqBhWTcK7TybZz7blaB0eMGSGntpGdhQ/SLEi2WXrsr6IRcliEHlP
         Ucf4V3LAsWxCKRdoRHtO91htmdrPjfJ/C8r21nFCaPkNVSvgRAS0N5Oot4Pd5KlnkU0I
         koCjcH+DX1Qy5aGNEHaBpfKTrvIv/c/sVDT6UnGvYsZOmiLxaGcyQL9iJE6iou2N5O6m
         QWjswB0CwUDQ7Dn4hByzHC1IjlS3E5ofJokgREoe5jGLgsL/PBhLItgINpewZ5XFXySy
         ulmhxyCUhMecTFct1gmOdHzW/Uyrmx8ChdRRazDYG3TXE1VV3vruN8fRHrMI+I5RPsBo
         TYfw==
X-Gm-Message-State: AOJu0Yz1Y04rXnVN1ByVKH+qMYrENpV0IDr3juzCQYphfuf8Wmldj/gN
	2+A+bLtoaUQZvJtjKjn2hncZB3KYO01gM8ubWT0Nk7EgNqtPaStoCymZ6B0tO3pkcwo=
X-Gm-Gg: ATEYQzx/MpmZUGKa10GmTIeXfseZJo7SF3h4loCfFicwUDtd3qNDed4rkWC1P1VNEUn
	H326PVi8tcMF6IllDHV4WG8yGQCloxvo+UxpS3ES1RSiFCCFWzJAsBjBfUCf//SIuNtJ0CyinlG
	tkU0Cp23+vJ6GI/s8aZyL0oSGTO4DrPWMDR0Sd0odm7ki33RQJjUwQq0B1GIlVA4oZphzESaqLC
	OoECEz90+IdL3TjOZ+BLkj4tqBIblcqYRtT0vaNkTLFgB7DTsIH9kyMXNrBG+C3TJzd5XHXM5iz
	SjPrtlUY2zdOTKajD+4mWwWsmRmqZZ4kFj+EhcIWZrOzRp0X2XT/4REBX79ZGefNM4887VtP0wS
	JQBJPvD8olC0BX/S5yUflNU9Bnv6+eLgMDaBS/46lXCJj7QaGr4mupb5I0UsbVUH85/hJC9iVwb
	snyIgf/2COADHnWsdFXGkpx3aTUpigK4FDOtkUUsgiTpspcFj42LXrDv7Xmkli0Sav9QXsyaSaa
	EtuZ3nHSjc=
X-Received: by 2002:a05:600c:621b:b0:483:c490:8c0 with SMTP id 5b1f17b1804b1-485198554cemr39191905e9.11.1772636892357;
        Wed, 04 Mar 2026 07:08:12 -0800 (PST)
Received: from [192.168.87.1] ([2001:8f8:1623:5b27:105a:4143:17c9:9894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188914ddsm71250885e9.12.2026.03.04.07.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:08:12 -0800 (PST)
Message-ID: <69a84adc.050a0220.1cea47.3011@mx.google.com>
Date: Wed, 04 Mar 2026 07:08:12 -0800 (PST)
From: Natarajan KV <natarajankv91@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, pablo@netfilter.org, kadlec@netfilter.org,
 fw@strlen.de
Subject: [PATCH v2] netfilter: nft_set_pipapo: move clone allocation to
 insert/removal path
In-Reply-To: <20260304133859.28372-1-natarajankv91@gmail.com>
References: <20260304133859.28372-1-natarajankv91@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0CE08202699
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223081-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natarajankv91@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mx.google.com:mid]
X-Rspamd-Action: no action

Move pipapo_clone() from the commit/abort callbacks to the
insert and removal paths via pipapo_maybe_clone(), which creates
the working copy on demand and can propagate allocation failures.

Previously, pipapo_clone() was called from nft_pipapo_commit() and
nft_pipapo_abort() which return void, making it impossible to
report allocation failures. When pipapo_clone() failed during abort,
the stale clone persisted with dirty =3D=3D true, causing subsequent
commits to promote a clone containing freed element references --
a use-after-free.

With this change:
 - pipapo_maybe_clone() allocates the clone lazily on first insert,
   deactivate, walk(UPDATE), or remove. Allocation failure returns
   NULL and propagates -ENOMEM to the caller.
 - nft_pipapo_commit() simply swaps clone to match and sets clone
   to NULL. No allocation needed.
 - nft_pipapo_abort() simply frees the clone and sets it to NULL.
   No allocation needed.
 - The dirty flag is removed; clone !=3D NULL indicates pending changes.
 - nft_pipapo_init() no longer pre-allocates a clone.

This is a backport adaptation of the mainline on-demand clone refactor
series from commit a590f4760922 ("netfilter: nft_set_pipapo: move
prove_locking helper around") through commit 532aec7e878b
("netfilter: nft_set_pipapo: remove dirty flag") to the 6.6.x
stable tree, preserving the 6.6.x function signatures and API
conventions.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of =
ranges")
Cc: stable@vger.kernel.org
Signed-off-by: Natarajan KV <natarajankv91@gmail.com>
---
 net/netfilter/nft_set_pipapo.c | 119 ++++++++++++++++++---------------
 net/netfilter/nft_set_pipapo.h |   2 -
 2 files changed, 66 insertions(+), 55 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 4274831b6e67..26fff610d9a3 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -512,20 +512,15 @@ bool nft_pipapo_lookup(const struct net *net, const str=
uct nft_set *set,
  *
  * Return: pointer to &struct nft_pipapo_elem on match, error pointer otherw=
ise.
  */
-static struct nft_pipapo_elem *pipapo_get(const struct net *net,
-					  const struct nft_set *set,
+static struct nft_pipapo_elem *pipapo_get(const struct nft_pipapo_match *m,
 					  const u8 *data, u8 genmask,
 					  u64 tstamp)
 {
 	struct nft_pipapo_elem *ret =3D ERR_PTR(-ENOENT);
-	struct nft_pipapo *priv =3D nft_set_priv(set);
 	unsigned long *res_map, *fill_map =3D NULL;
-	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
 	int i;
=20
-	m =3D priv->clone;
-
 	res_map =3D kmalloc_array(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
 	if (!res_map) {
 		ret =3D ERR_PTR(-ENOMEM);
@@ -606,7 +601,18 @@ static struct nft_pipapo_elem *pipapo_get(const struct n=
et *net,
 static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
-	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
+	struct nft_pipapo *priv =3D nft_set_priv(set);
+	const struct nft_pipapo_match *m;
+
+	m =3D priv->clone;
+	if (!m) {
+		struct nftables_pernet *nft_net;
+
+		nft_net =3D nft_pernet(read_pnet(&set->net));
+		m =3D rcu_dereference_check(priv->match,
+					  lockdep_is_held(&nft_net->commit_mutex));
+	}
+	return pipapo_get(m, (const u8 *)elem->key.val.data,
 			 nft_genmask_cur(net), get_jiffies_64());
 }
=20
@@ -1181,6 +1187,8 @@ static int pipapo_realloc_scratch(struct nft_pipapo_mat=
ch *clone,
 	return 0;
 }
=20
+static struct nft_pipapo_match *pipapo_maybe_clone(const struct nft_set *set=
);
+
 /**
  * nft_pipapo_insert() - Validate and insert ranged elements
  * @net:	Network namespace
@@ -1198,20 +1206,22 @@ static int nft_pipapo_insert(const struct net *net, c=
onst struct nft_set *set,
 	union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
 	const u8 *start =3D (const u8 *)elem->key.val.data, *end;
 	struct nft_pipapo_elem *e =3D elem->priv, *dup;
-	struct nft_pipapo *priv =3D nft_set_priv(set);
-	struct nft_pipapo_match *m =3D priv->clone;
+	struct nft_pipapo_match *m =3D pipapo_maybe_clone(set);
 	u8 genmask =3D nft_genmask_next(net);
 	u64 tstamp =3D nft_net_tstamp(net);
 	struct nft_pipapo_field *f;
 	const u8 *start_p, *end_p;
 	int i, bsize_max, err =3D 0;
=20
+	if (!m)
+		return -ENOMEM;
+
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_KEY_END))
 		end =3D (const u8 *)nft_set_ext_key_end(ext)->data;
 	else
 		end =3D start;
=20
-	dup =3D pipapo_get(net, set, start, genmask, tstamp);
+	dup =3D pipapo_get(m, start, genmask, tstamp);
 	if (!IS_ERR(dup)) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
@@ -1233,7 +1243,7 @@ static int nft_pipapo_insert(const struct net *net, con=
st struct nft_set *set,
=20
 	if (PTR_ERR(dup) =3D=3D -ENOENT) {
 		/* Look for partially overlapping entries */
-		dup =3D pipapo_get(net, set, end, nft_genmask_next(net), tstamp);
+		dup =3D pipapo_get(m, end, nft_genmask_next(net), tstamp);
 	}
=20
 	if (PTR_ERR(dup) !=3D -ENOENT) {
@@ -1259,8 +1269,6 @@ static int nft_pipapo_insert(const struct net *net, con=
st struct nft_set *set,
 	}
=20
 	/* Insert */
-	priv->dirty =3D true;
-
 	bsize_max =3D m->bsize_max;
=20
 	nft_pipapo_for_each_field(f, i, m) {
@@ -1620,8 +1628,6 @@ static void pipapo_gc(struct nft_set *set, struct nft_p=
ipapo_match *m)
 		 * NFT_SET_ELEM_DEAD_BIT.
 		 */
 		if (__nft_set_elem_expired(&e->ext, tstamp)) {
-			priv->dirty =3D true;
-
 			gc =3D nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
 			if (!gc)
 				return;
@@ -1699,26 +1705,20 @@ static void pipapo_reclaim_match(struct rcu_head *rcu)
 static void nft_pipapo_commit(struct nft_set *set)
 {
 	struct nft_pipapo *priv =3D nft_set_priv(set);
-	struct nft_pipapo_match *new_clone, *old;
-
-	if (time_after_eq(jiffies, priv->last_gc + nft_set_gc_interval(set)))
-		pipapo_gc(set, priv->clone);
-
-	if (!priv->dirty)
-		return;
+	struct nft_pipapo_match *old;
=20
-	new_clone =3D pipapo_clone(priv->clone);
-	if (IS_ERR(new_clone))
+	if (!priv->clone)
 		return;
=20
-	priv->dirty =3D false;
+	if (time_after_eq(jiffies, priv->last_gc + nft_set_gc_interval(set)))
+		pipapo_gc(set, priv->clone);
=20
 	old =3D rcu_access_pointer(priv->match);
 	rcu_assign_pointer(priv->match, priv->clone);
+	priv->clone =3D NULL;
+
 	if (old)
 		call_rcu(&old->rcu, pipapo_reclaim_match);
-
-	priv->clone =3D new_clone;
 }
=20
 static bool nft_pipapo_transaction_mutex_held(const struct nft_set *set)
@@ -1732,24 +1732,38 @@ static bool nft_pipapo_transaction_mutex_held(const s=
truct nft_set *set)
 #endif
 }
=20
-static void nft_pipapo_abort(const struct nft_set *set)
+static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old);
+
+/**
+ * pipapo_maybe_clone() - Build clone for pending data changes, if not exist=
ing
+ * @set:	nftables API set representation
+ *
+ * Return: newly created or existing clone, if any. NULL on allocation failu=
re.
+ */
+static struct nft_pipapo_match *pipapo_maybe_clone(const struct nft_set *set)
 {
 	struct nft_pipapo *priv =3D nft_set_priv(set);
-	struct nft_pipapo_match *new_clone, *m;
+	struct nft_pipapo_match *m;
=20
-	if (!priv->dirty)
-		return;
+	if (priv->clone)
+		return priv->clone;
+
+	m =3D rcu_dereference_protected(priv->match,
+				      nft_pipapo_transaction_mutex_held(set));
+	priv->clone =3D pipapo_clone(m);
=20
-	m =3D rcu_dereference_protected(priv->match, nft_pipapo_transaction_mutex_h=
eld(set));
+	return priv->clone;
+}
=20
-	new_clone =3D pipapo_clone(m);
-	if (IS_ERR(new_clone))
-		return;
+static void nft_pipapo_abort(const struct nft_set *set)
+{
+	struct nft_pipapo *priv =3D nft_set_priv(set);
=20
-	priv->dirty =3D false;
+	if (!priv->clone)
+		return;
=20
 	pipapo_free_match(priv->clone);
-	priv->clone =3D new_clone;
+	priv->clone =3D NULL;
 }
=20
 /**
@@ -1788,9 +1802,13 @@ static void nft_pipapo_activate(const struct net *net,
 static void *pipapo_deactivate(const struct net *net, const struct nft_set *=
set,
 			       const u8 *data, const struct nft_set_ext *ext)
 {
+	struct nft_pipapo_match *m =3D pipapo_maybe_clone(set);
 	struct nft_pipapo_elem *e;
=20
-	e =3D pipapo_get(net, set, data, nft_genmask_next(net), nft_net_tstamp(net)=
);
+	if (!m)
+		return NULL;
+
+	e =3D pipapo_get(m, data, nft_genmask_next(net), nft_net_tstamp(net));
 	if (IS_ERR(e))
 		return NULL;
=20
@@ -1973,8 +1991,7 @@ static bool pipapo_match_field(struct nft_pipapo_field =
*f,
 static void nft_pipapo_remove(const struct net *net, const struct nft_set *s=
et,
 			      const struct nft_set_elem *elem)
 {
-	struct nft_pipapo *priv =3D nft_set_priv(set);
-	struct nft_pipapo_match *m =3D priv->clone;
+	struct nft_pipapo_match *m =3D pipapo_maybe_clone(set);
 	struct nft_pipapo_elem *e =3D elem->priv;
 	int rules_f0, first_rule =3D 0;
 	const u8 *data;
@@ -2014,7 +2031,6 @@ static void nft_pipapo_remove(const struct net *net, co=
nst struct nft_set *set,
 			match_end +=3D NFT_PIPAPO_GROUPS_PADDED_SIZE(f);
=20
 			if (last && f->mt[rulemap[i].to].e =3D=3D e) {
-				priv->dirty =3D true;
 				pipapo_drop(m, rulemap);
 				return;
 			}
@@ -2048,10 +2064,15 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx=
, struct nft_set *set,
 		     iter->type !=3D NFT_ITER_UPDATE);
=20
 	rcu_read_lock();
-	if (iter->type =3D=3D NFT_ITER_READ)
+	if (iter->type =3D=3D NFT_ITER_READ) {
 		m =3D rcu_dereference(priv->match);
-	else
-		m =3D priv->clone;
+	} else {
+		m =3D pipapo_maybe_clone(set);
+		if (!m) {
+			iter->err =3D -ENOMEM;
+			goto out;
+		}
+	}
=20
 	if (unlikely(!m))
 		goto out;
@@ -2181,20 +2202,12 @@ static int nft_pipapo_init(const struct nft_set *set,
 		f->mt =3D NULL;
 	}
=20
-	/* Create an initial clone of matching data for next insertion */
-	priv->clone =3D pipapo_clone(m);
-	if (IS_ERR(priv->clone)) {
-		err =3D PTR_ERR(priv->clone);
-		goto out_free;
-	}
-
-	priv->dirty =3D false;
+	priv->clone =3D NULL;
=20
 	rcu_assign_pointer(priv->match, m);
=20
 	return 0;
=20
-out_free:
 	free_percpu(m->scratch);
 out_scratch:
 	kfree(m);
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index aad9130cc763..8442aaecbe7d 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -163,14 +163,12 @@ struct nft_pipapo_match {
  * @match:	Currently in-use matching data
  * @clone:	Copy where pending insertions and deletions are kept
  * @width:	Total bytes to be matched for one packet, including padding
- * @dirty:	Working copy has pending insertions or deletions
  * @last_gc:	Timestamp of last garbage collection run, jiffies
  */
 struct nft_pipapo {
 	struct nft_pipapo_match __rcu *match;
 	struct nft_pipapo_match *clone;
 	int width;
-	bool dirty;
 	unsigned long last_gc;
 };
=20
--=20
2.34.1



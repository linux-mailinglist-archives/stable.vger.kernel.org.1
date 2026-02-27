Return-Path: <stable+bounces-220012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O16LYoLomk2ygQAu9opvQ
	(envelope-from <stable+bounces-220012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 22:24:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3961BE27E
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 22:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66BEC30988A5
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EE2478E55;
	Fri, 27 Feb 2026 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fmoxVIdz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AD2BE63F;
	Fri, 27 Feb 2026 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227462; cv=none; b=tKMh5udb2J+08MTU6zSTjCDOq8dE56zBESWXW9n5DL5Ef+zp+cny7J7mslWS1w4eA9PKuaBhqg+R7dyhHMi7ZS5GEKHZLApjIPDi079jPYhEVufCCXcQ1Lmst54KnXdCsqmz/ibALBru3StajTcRI2vpyYzqSLBj5zZwlXcMLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227462; c=relaxed/simple;
	bh=hTf3RU/vghZVS44+6Feh2gDn78HYCrIrb8Mh2JN/s9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sk5q+fCnQxPg0PnWOgs58T2O0AjD8XE6q6tmrg9wT+rrwHm9+OA1q1dhcblxMQuGKaQT9Hfia0ElBuO8uNlIDF7x37Ggqa8dCztZBuUn7K+y3k6INUrhLgfz/2G8mccScTBDA+YEYKPYEgSmHkyTuSBsOFX0SboSowlyHZ0wejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fmoxVIdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BF6C116C6;
	Fri, 27 Feb 2026 21:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772227462;
	bh=hTf3RU/vghZVS44+6Feh2gDn78HYCrIrb8Mh2JN/s9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmoxVIdzObAwTu7oqKYwLjebNYIgUWHVwJch8DW/8VoZG6sq67AtEAdw4Ob0Jzw1W
	 0XKWOs2Xk9PN4bs0ogpeEfw1ePuUt4wLaZjsg365Ac7fCbljgnTRyHQQ6Dbmxg1FAz
	 T7aEXG0QV1eptJaTUg5TW/YJE2aw0JYjYAsjD8bs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.18.15
Date: Fri, 27 Feb 2026 16:24:09 -0500
Message-ID: <2026022738-latitude-spendable-ee9e@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026022738-doornail-childlike-10e2@gregkh>
References: <2026022738-doornail-childlike-10e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220012-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B3961BE27E
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index d166d0695099..e4aa2e76ea56 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 18
-SUBLEVEL = 14
+SUBLEVEL = 15
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 7eac73f9b4ce..05f57ba62244 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -456,6 +456,7 @@ struct nft_set_ext;
  *	@init: initialize private data of new set instance
  *	@destroy: destroy private data of set instance
  *	@gc_init: initialize garbage collection
+ *	@abort_skip_removal: skip removal of elements from abort path
  *	@elemsize: element private size
  *
  *	Operations lookup, update and delete have simpler interfaces, are faster
@@ -513,6 +514,7 @@ struct nft_set_ops {
 						   const struct nft_set *set);
 	void				(*gc_init)(const struct nft_set *set);
 
+	bool				abort_skip_removal;
 	unsigned int			elemsize;
 };
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index df367638cdef..d4babc4d3bff 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7821,7 +7821,8 @@ static bool nft_trans_elems_new_abort(const struct nft_ctx *ctx,
 			continue;
 		}
 
-		if (!te->set->ops->abort || nft_setelem_is_catchall(te->set, te->elems[i].priv))
+		if (!te->set->ops->abort_skip_removal ||
+		    nft_setelem_is_catchall(te->set, te->elems[i].priv))
 			nft_setelem_remove(ctx->net, te->set, te->elems[i].priv);
 
 		if (!nft_setelem_is_catchall(te->set, te->elems[i].priv))
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 6d77a5f0088a..18e1903b1d3d 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2370,6 +2370,7 @@ const struct nft_set_type nft_set_pipapo_type = {
 		.gc_init	= nft_pipapo_gc_init,
 		.commit		= nft_pipapo_commit,
 		.abort		= nft_pipapo_abort,
+		.abort_skip_removal = true,
 		.elemsize	= offsetof(struct nft_pipapo_elem, ext),
 	},
 };
@@ -2394,6 +2395,7 @@ const struct nft_set_type nft_set_pipapo_avx2_type = {
 		.gc_init	= nft_pipapo_gc_init,
 		.commit		= nft_pipapo_commit,
 		.abort		= nft_pipapo_abort,
+		.abort_skip_removal = true,
 		.elemsize	= offsetof(struct nft_pipapo_elem, ext),
 	},
 };


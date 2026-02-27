Return-Path: <stable+bounces-220014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBRWJOELomk3ygQAu9opvQ
	(envelope-from <stable+bounces-220014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 22:25:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E99A51BE2B9
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 22:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73A3230D6D27
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF5847A0B5;
	Fri, 27 Feb 2026 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TKWhqri+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5C478E55;
	Fri, 27 Feb 2026 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227494; cv=none; b=NMjqbwDkGxuv0wL1x/Afpe24qpJ/FY4bs4QUMr3obAcDmQUarNbyrz7nD9vt2+IPzRuq5pnLvHyE/BlF1tC4EBJ+WT/4YP6K1fbaM1JdHTVgM7c7/re1mx+WL6W2+NjpNb2LPquZTFj6iKhvtKni/0HnCuvf+Z5zBDo9djBJhzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227494; c=relaxed/simple;
	bh=5HaXxr23IJw+Raah1CZbGq+7dyanxbW2KLRgzMmq0iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRG8FjOJVdv0UW5t8ROM9S87R75iRLHn3W1buoKP+GVBLznQxkGGLDOHSdiqfFPMU5Aln0d7Vki8wTUU0lIvsx0IG96aaqUX+/TsE3HlOj7TXiJ5tg6p02L2z1V7+ljS6i0gUYYg4nOp7amZ/ggu3kqWsqVFw9+mYpD+ibhMLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TKWhqri+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B788C116C6;
	Fri, 27 Feb 2026 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772227494;
	bh=5HaXxr23IJw+Raah1CZbGq+7dyanxbW2KLRgzMmq0iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKWhqri+zl+gRWfAsdZCX5e7KCIwmqKmsQjCl036g0rP4VZbuNA5TkQUOgNHf4s/g
	 CGlyYMH5ipcbDBRYgaKPbidDGCpkY+xn0tO1ISgoouD37NHjiKAiyf5aoAjMeNYnw9
	 GLyPQOU3XmS2KLR2WmYWSFEncZ2jnAAH1CazmWZc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.19.5
Date: Fri, 27 Feb 2026 16:24:42 -0500
Message-ID: <2026022720-trekker-fondly-ae80@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026022720-tricolor-starved-baef@gregkh>
References: <2026022720-tricolor-starved-baef@gregkh>
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
	TAGGED_FROM(0.00)[bounces-220014-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E99A51BE2B9
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index e9396657c546..f486050e0bee 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 19
-SUBLEVEL = 4
+SUBLEVEL = 5
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
index 8dae197c7faf..3b9c559ab123 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7702,7 +7702,8 @@ static bool nft_trans_elems_new_abort(const struct nft_ctx *ctx,
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


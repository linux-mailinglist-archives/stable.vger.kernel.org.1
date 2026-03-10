Return-Path: <stable+bounces-223784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEyWDifRr2kfcgIAu9opvQ
	(envelope-from <stable+bounces-223784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:07:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D9D246F16
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38B80306F0F6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3604F3ED111;
	Tue, 10 Mar 2026 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="Lu/tSzCm"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21E3EBF34;
	Tue, 10 Mar 2026 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129868; cv=none; b=MYni21z09/z9Heq6aCHFnxPqW0TP0cXOm/nldkPyht2iJifuGr5wcAb5IEUjayUSRBSSiQSa/eUKxmOug02VdfrSmQVp2PVn8abF/eMzXNqPk6mTJek3hTmn0tSBFJT5IqP6N56m5YrE2Y2H7YlLS4ejxFrI5xoY4aFwDnfnUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129868; c=relaxed/simple;
	bh=dl7cFGu/krscEUd4X4c2fSMgudGGbvCNgTfInuMm0JI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M8PPpPSKTwUxq8WLIN32TmaDlisRdSi+YsFGKyv9jV8unGZ/z3eukpfEvCFqD6p93W0ogEsoXLMhN+wBaPLbjKxkTcdNcgoAiRwKYrOFMFI+9i2aygzBDP0x1YtbXgp1XylbiFfT36WjHuZDk2MtssXOVSE6hcITJp6pxX3elUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=Lu/tSzCm; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Lu/tSzCmsVobKT2GToBAIM84pTfLIgIg4+sPxdS9Dry+o01QeOIHVphGbqxyXTw8vKhrETrUvv4Ek
	 7LCSZKy6Lb6ortHNiQUovnF7ToRTLlCVzoFCCOqy3OvgpFsUhSMfiqO9ByfFCKtrFW4vLZ5PivronS
	 n7wJjoO5EF1rZ2Qo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-kernel-team (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-09-12087 (RichMail) with SMTP id 2f3769afd069396-023cc;
	Tue, 10 Mar 2026 16:04:12 +0800 (CST)
X-RM-TRANSID:2f3769afd069396-023cc
From: XiaoHua Wang <561399680@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: pablo@netfilter.org,
	netdev@vger.kernel.org,
	sbrivio@redhat.com,
	XiaoHua Wang <561399680@139.com>
Subject: [PATCH 6.1.y 1/2] netfilter: nf_tables: missing objects with no memcg accounting
Date: Tue, 10 Mar 2026 16:02:45 +0800
Message-Id: <20260310080246.3543546-1-561399680@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E3D9D246F16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223784-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[netfilter.org,vger.kernel.org,redhat.com,139.com];
	DKIM_TRACE(0.00)[139.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[561399680@139.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[139.com:mid,139.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 69e687cea79fc99a17dfb0116c8644b9391b915e ]

Several ruleset objects are still not using GFP_KERNEL_ACCOUNT for
memory accounting, update them. This includes:

- catchall elements
- compat match large info area
- log prefix
- meta secctx
- numgen counters
- pipapo set backend datastructure
- tunnel private objects

Fixes: 33758c891479 ("memcg: enable accounting for nft objects")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[ The function pipapo_realloc_mt() does not exist in 6.1.y,
so the fix for pipapo_realloc_mt() was not backported. ]
Signed-off-by: XiaoHua Wang <561399680@139.com>
---
 net/netfilter/nf_tables_api.c  |  2 +-
 net/netfilter/nft_compat.c     |  6 +++---
 net/netfilter/nft_log.c        |  2 +-
 net/netfilter/nft_meta.c       |  2 +-
 net/netfilter/nft_numgen.c     |  2 +-
 net/netfilter/nft_set_pipapo.c | 10 +++++-----
 net/netfilter/nft_tunnel.c     |  5 +++--
 7 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ac3618395651..4bf42e4f8595 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6177,7 +6177,7 @@ static int nft_setelem_catchall_insert(const struct net *net,
 		}
 	}
 
-	catchall = kmalloc(sizeof(*catchall), GFP_KERNEL);
+	catchall = kmalloc(sizeof(*catchall), GFP_KERNEL_ACCOUNT);
 	if (!catchall)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 4f674a472bb6..37090ada8e8d 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -537,7 +537,7 @@ nft_match_large_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	struct xt_match *m = expr->ops->data;
 	int ret;
 
-	priv->info = kmalloc(XT_ALIGN(m->matchsize), GFP_KERNEL);
+	priv->info = kmalloc(XT_ALIGN(m->matchsize), GFP_KERNEL_ACCOUNT);
 	if (!priv->info)
 		return -ENOMEM;
 
@@ -814,7 +814,7 @@ nft_match_select_ops(const struct nft_ctx *ctx,
 		goto err;
 	}
 
-	ops = kzalloc(sizeof(struct nft_expr_ops), GFP_KERNEL);
+	ops = kzalloc(sizeof(struct nft_expr_ops), GFP_KERNEL_ACCOUNT);
 	if (!ops) {
 		err = -ENOMEM;
 		goto err;
@@ -904,7 +904,7 @@ nft_target_select_ops(const struct nft_ctx *ctx,
 		goto err;
 	}
 
-	ops = kzalloc(sizeof(struct nft_expr_ops), GFP_KERNEL);
+	ops = kzalloc(sizeof(struct nft_expr_ops), GFP_KERNEL_ACCOUNT);
 	if (!ops) {
 		err = -ENOMEM;
 		goto err;
diff --git a/net/netfilter/nft_log.c b/net/netfilter/nft_log.c
index 0e13c003f0c1..4eb59c3f42b8 100644
--- a/net/netfilter/nft_log.c
+++ b/net/netfilter/nft_log.c
@@ -163,7 +163,7 @@ static int nft_log_init(const struct nft_ctx *ctx,
 
 	nla = tb[NFTA_LOG_PREFIX];
 	if (nla != NULL) {
-		priv->prefix = kmalloc(nla_len(nla) + 1, GFP_KERNEL);
+		priv->prefix = kmalloc(nla_len(nla) + 1, GFP_KERNEL_ACCOUNT);
 		if (priv->prefix == NULL)
 			return -ENOMEM;
 		nla_strscpy(priv->prefix, nla, nla_len(nla) + 1);
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 6e8332192622..587ef60c8f32 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -888,7 +888,7 @@ static int nft_secmark_obj_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_SECMARK_CTX] == NULL)
 		return -EINVAL;
 
-	priv->ctx = nla_strdup(tb[NFTA_SECMARK_CTX], GFP_KERNEL);
+	priv->ctx = nla_strdup(tb[NFTA_SECMARK_CTX], GFP_KERNEL_ACCOUNT);
 	if (!priv->ctx)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_numgen.c b/net/netfilter/nft_numgen.c
index 45d3dc9e96f2..5b4dde41ec36 100644
--- a/net/netfilter/nft_numgen.c
+++ b/net/netfilter/nft_numgen.c
@@ -66,7 +66,7 @@ static int nft_ng_inc_init(const struct nft_ctx *ctx,
 	if (priv->offset + priv->modulus - 1 < priv->offset)
 		return -EOVERFLOW;
 
-	priv->counter = kmalloc(sizeof(*priv->counter), GFP_KERNEL);
+	priv->counter = kmalloc(sizeof(*priv->counter), GFP_KERNEL_ACCOUNT);
 	if (!priv->counter)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 863162c82330..ad9d0bb43248 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -874,7 +874,7 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 		return;
 	}
 
-	new_lt = kvzalloc(lt_size + NFT_PIPAPO_ALIGN_HEADROOM, GFP_KERNEL);
+	new_lt = kvzalloc(lt_size + NFT_PIPAPO_ALIGN_HEADROOM, GFP_KERNEL_ACCOUNT);
 	if (!new_lt)
 		return;
 
@@ -1150,7 +1150,7 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 		scratch = kzalloc_node(struct_size(scratch, map,
 						   bsize_max * 2) +
 				       NFT_PIPAPO_ALIGN_HEADROOM,
-				       GFP_KERNEL, cpu_to_node(i));
+				       GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!scratch) {
 			/* On failure, there's no need to undo previous
 			 * allocations: this means that some scratch maps have
@@ -1324,7 +1324,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	int i;
 
 	new = kmalloc(sizeof(*new) + sizeof(*dst) * old->field_count,
-		      GFP_KERNEL);
+		      GFP_KERNEL_ACCOUNT);
 	if (!new)
 		return ERR_PTR(-ENOMEM);
 
@@ -1354,7 +1354,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		new_lt = kvzalloc(src->groups * NFT_PIPAPO_BUCKETS(src->bb) *
 				  src->bsize * sizeof(*dst->lt) +
 				  NFT_PIPAPO_ALIGN_HEADROOM,
-				  GFP_KERNEL);
+				  GFP_KERNEL_ACCOUNT);
 		if (!new_lt)
 			goto out_lt;
 
@@ -1368,7 +1368,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		if (src->rules > (INT_MAX / sizeof(*src->mt)))
 			goto out_mt;
 
-		dst->mt = kvmalloc(src->rules * sizeof(*src->mt), GFP_KERNEL);
+		dst->mt = kvmalloc(src->rules * sizeof(*src->mt), GFP_KERNEL_ACCOUNT);
 		if (!dst->mt)
 			goto out_mt;
 
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index be741db50ffa..cdbfbd88efd1 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -503,13 +503,14 @@ static int nft_tunnel_obj_init(const struct nft_ctx *ctx,
 			return err;
 	}
 
-	md = metadata_dst_alloc(priv->opts.len, METADATA_IP_TUNNEL, GFP_KERNEL);
+	md = metadata_dst_alloc(priv->opts.len, METADATA_IP_TUNNEL,
+				GFP_KERNEL_ACCOUNT);
 	if (!md)
 		return -ENOMEM;
 
 	memcpy(&md->u.tun_info, &info, sizeof(info));
 #ifdef CONFIG_DST_CACHE
-	err = dst_cache_init(&md->u.tun_info.dst_cache, GFP_KERNEL);
+	err = dst_cache_init(&md->u.tun_info.dst_cache, GFP_KERNEL_ACCOUNT);
 	if (err < 0) {
 		metadata_dst_free(md);
 		return err;
-- 
2.43.0




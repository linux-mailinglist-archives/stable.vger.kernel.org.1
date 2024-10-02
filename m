Return-Path: <stable+bounces-80559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE71B98DE68
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FC4283357
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D61D079C;
	Wed,  2 Oct 2024 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O7qKoA4I"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8510E9
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881629; cv=none; b=R/dY51rf39L+CP4fZ45LDuPGSbxRSqvEl8ZO8LkI43my7pvtoAOCiyGs3yKeNcRnV3h9M2pFxd27H25J1wvSRnOFmn8VgdbNY15J6tpWkUIM3IZ3SkAJJyL7hPIe9C7ohtgphLB91yyGK75C4W8LN+giIVe0betgWKvCWzSAurw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881629; c=relaxed/simple;
	bh=3KALkW0oGqBz08HTKBreMmHBr6GZ6op6k8xWj2EkqkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nR3HPF8x1JsHLpGxFGQN0cHOz0jKp0HJVili2cNA9ZGbC7gPXW2m/mhNBnzXtyXkvrc/wmQ61KIpx6qpOkTOujQNHBXbzEExu9x5EFgGNR4Uf1J3wgPGjtUhYL4XXKPlXsFIIy+/vWV1TGtp4hh6t+zkR25Ufv0rYKDw8ODys+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O7qKoA4I; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Cd47r011627;
	Wed, 2 Oct 2024 15:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=a
	eJ4jIsAATKVjeF6d6quJtHzhoxm7LWB2mMp7y4EzHE=; b=O7qKoA4Ip95fgZm1P
	jUrW6AkdCvWQgVp6mMcv+/P8k3cvbqtivQpOlB2RSnMurRTxr6mkoK54PKciAJ15
	M5WJgNguVT2Tq4Kzi88eEkSp5bIZxVS/QOCCKJ/dwiW1qN9yp5vR+NXLDfQlBL1U
	qa+oxN6m90RrjroGtZ+UcV2ALAkl0D1uK8R1kh1xeEqofaUujDFxkBbL1uQzdfLm
	PnUNAeah8ssdUuyjhHEnW1X/ogAykOXGTX3u+bZkjkg9fcqpP28zrpo096Ps5/RV
	W4vKFCFJ2rrbbpjwn8PeQ4yHg/z+LM8sgmcYFj/67VSIIDABkVj5HOxypLf2h0GE
	W8tvw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k39p6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:06:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492EHffR017330;
	Wed, 2 Oct 2024 15:06:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888y0sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:06:57 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492F1lZQ012831;
	Wed, 2 Oct 2024 15:06:56 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x888xyse-8;
	Wed, 02 Oct 2024 15:06:56 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com, Pablo Neira Ayuso <pablo@netfilter.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 6.6.y 07/15] netfilter: nf_tables: restore set elements when delete set fails
Date: Wed,  2 Oct 2024 17:05:58 +0200
Message-Id: <20241002150606.11385-8-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002150606.11385-1-vegard.nossum@oracle.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020109
X-Proofpoint-GUID: aLWoVdQW85kPAtKzvEukcJcvSdBW91fX
X-Proofpoint-ORIG-GUID: aLWoVdQW85kPAtKzvEukcJcvSdBW91fX

From: Pablo Neira Ayuso <pablo@netfilter.org>

From abort path, nft_mapelem_activate() needs to restore refcounters to
the original state. Currently, it uses the set->ops->walk() to iterate
over these set elements. The existing set iterator skips inactive
elements in the next generation, this does not work from the abort path
to restore the original state since it has to skip active elements
instead (not inactive ones).

This patch moves the check for inactive elements to the set iterator
callback, then it reverses the logic for the .activate case which
needs to skip active elements.

Toggle next generation bit for elements when delete set command is
invoked and call nft_clear() from .activate (abort) path to restore the
next generation bit.

The splat below shows an object in mappings memleak:

[43929.457523] ------------[ cut here ]------------
[43929.457532] WARNING: CPU: 0 PID: 1139 at include/net/netfilter/nf_tables.h:1237 nft_setelem_data_deactivate+0xe4/0xf0 [nf_tables]
[...]
[43929.458014] RIP: 0010:nft_setelem_data_deactivate+0xe4/0xf0 [nf_tables]
[43929.458076] Code: 83 f8 01 77 ab 49 8d 7c 24 08 e8 37 5e d0 de 49 8b 6c 24 08 48 8d 7d 50 e8 e9 5c d0 de 8b 45 50 8d 50 ff 89 55 50 85 c0 75 86 <0f> 0b eb 82 0f 0b eb b3 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90
[43929.458081] RSP: 0018:ffff888140f9f4b0 EFLAGS: 00010246
[43929.458086] RAX: 0000000000000000 RBX: ffff8881434f5288 RCX: dffffc0000000000
[43929.458090] RDX: 00000000ffffffff RSI: ffffffffa26d28a7 RDI: ffff88810ecc9550
[43929.458093] RBP: ffff88810ecc9500 R08: 0000000000000001 R09: ffffed10281f3e8f
[43929.458096] R10: 0000000000000003 R11: ffff0000ffff0000 R12: ffff8881434f52a0
[43929.458100] R13: ffff888140f9f5f4 R14: ffff888151c7a800 R15: 0000000000000002
[43929.458103] FS:  00007f0c687c4740(0000) GS:ffff888390800000(0000) knlGS:0000000000000000
[43929.458107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[43929.458111] CR2: 00007f58dbe5b008 CR3: 0000000123602005 CR4: 00000000001706f0
[43929.458114] Call Trace:
[43929.458118]  <TASK>
[43929.458121]  ? __warn+0x9f/0x1a0
[43929.458127]  ? nft_setelem_data_deactivate+0xe4/0xf0 [nf_tables]
[43929.458188]  ? report_bug+0x1b1/0x1e0
[43929.458196]  ? handle_bug+0x3c/0x70
[43929.458200]  ? exc_invalid_op+0x17/0x40
[43929.458211]  ? nft_setelem_data_deactivate+0xd7/0xf0 [nf_tables]
[43929.458271]  ? nft_setelem_data_deactivate+0xe4/0xf0 [nf_tables]
[43929.458332]  nft_mapelem_deactivate+0x24/0x30 [nf_tables]
[43929.458392]  nft_rhash_walk+0xdd/0x180 [nf_tables]
[43929.458453]  ? __pfx_nft_rhash_walk+0x10/0x10 [nf_tables]
[43929.458512]  ? rb_insert_color+0x2e/0x280
[43929.458520]  nft_map_deactivate+0xdc/0x1e0 [nf_tables]
[43929.458582]  ? __pfx_nft_map_deactivate+0x10/0x10 [nf_tables]
[43929.458642]  ? __pfx_nft_mapelem_deactivate+0x10/0x10 [nf_tables]
[43929.458701]  ? __rcu_read_unlock+0x46/0x70
[43929.458709]  nft_delset+0xff/0x110 [nf_tables]
[43929.458769]  nft_flush_table+0x16f/0x460 [nf_tables]
[43929.458830]  nf_tables_deltable+0x501/0x580 [nf_tables]

Fixes: 628bd3e49cba ("netfilter: nf_tables: drop map element references from preparation phase")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
(cherry picked from commit e79b47a8615d42c68aaeb68971593333667382ed)
[Vegard: CVE-2024-27012; fixed conflicts due to missing commits
 0e1ea651c9717ddcd8e0648d8468477a31867b0a ("netfilter: nf_tables: shrink
 memory consumption of set elements") and
 9dad402b89e81a0516bad5e0ac009b7a0a80898f ("netfilter: nf_tables: expose
 opaque set element as struct nft_elem_priv") so we pass the correct types
 and values to nft_setelem_data_deactivate(), nft_setelem_validate(),
 nft_set_elem_ext(), etc.]
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 net/netfilter/nf_tables_api.c  | 41 ++++++++++++++++++++++++++++++----
 net/netfilter/nft_set_bitmap.c |  4 +---
 net/netfilter/nft_set_hash.c   |  8 ++-----
 net/netfilter/nft_set_pipapo.c |  5 +----
 net/netfilter/nft_set_rbtree.c |  4 +---
 5 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 88824fa67c534..d380e8f0f40eb 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -594,6 +594,12 @@ static int nft_mapelem_deactivate(const struct nft_ctx *ctx,
 				  const struct nft_set_iter *iter,
 				  struct nft_set_elem *elem)
 {
+	struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
+
+	if (!nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
+	nft_set_elem_change_active(ctx->net, set, ext);
 	nft_setelem_data_deactivate(ctx->net, set, elem);
 
 	return 0;
@@ -619,6 +625,7 @@ static void nft_map_catchall_deactivate(const struct nft_ctx *ctx,
 			continue;
 
 		elem.priv = catchall->elem;
+		nft_set_elem_change_active(ctx->net, set, ext);
 		nft_setelem_data_deactivate(ctx->net, set, &elem);
 		break;
 	}
@@ -3820,6 +3827,9 @@ int nft_setelem_validate(const struct nft_ctx *ctx, struct nft_set *set,
 	const struct nft_data *data;
 	int err;
 
+	if (!nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_FLAGS) &&
 	    *nft_set_ext_flags(ext) & NFT_SET_ELEM_INTERVAL_END)
 		return 0;
@@ -3843,19 +3853,22 @@ int nft_setelem_validate(const struct nft_ctx *ctx, struct nft_set *set,
 
 int nft_set_catchall_validate(const struct nft_ctx *ctx, struct nft_set *set)
 {
-	u8 genmask = nft_genmask_next(ctx->net);
+	struct nft_set_iter dummy_iter = {
+		.genmask	= nft_genmask_next(ctx->net),
+	};
 	struct nft_set_elem_catchall *catchall;
 	struct nft_set_elem elem;
+
 	struct nft_set_ext *ext;
 	int ret = 0;
 
 	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_set_elem_active(ext, genmask))
+		if (!nft_set_elem_active(ext, dummy_iter.genmask))
 			continue;
 
 		elem.priv = catchall->elem;
-		ret = nft_setelem_validate(ctx, set, NULL, &elem);
+		ret = nft_setelem_validate(ctx, set, &dummy_iter, &elem);
 		if (ret < 0)
 			return ret;
 	}
@@ -5347,6 +5360,11 @@ static int nf_tables_bind_check_setelem(const struct nft_ctx *ctx,
 					const struct nft_set_iter *iter,
 					struct nft_set_elem *elem)
 {
+	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
+
+	if (!nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
 	return nft_setelem_data_validate(ctx, set, elem);
 }
 
@@ -5441,6 +5459,13 @@ static int nft_mapelem_activate(const struct nft_ctx *ctx,
 				const struct nft_set_iter *iter,
 				struct nft_set_elem *elem)
 {
+	struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
+
+	/* called from abort path, reverse check to undo changes. */
+	if (nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
+	nft_clear(ctx->net, ext);
 	nft_setelem_data_activate(ctx->net, set, elem);
 
 	return 0;
@@ -5459,6 +5484,7 @@ static void nft_map_catchall_activate(const struct nft_ctx *ctx,
 		if (!nft_set_elem_active(ext, genmask))
 			continue;
 
+		nft_clear(ctx->net, ext);
 		elem.priv = catchall->elem;
 		nft_setelem_data_activate(ctx->net, set, &elem);
 		break;
@@ -5733,6 +5759,9 @@ static int nf_tables_dump_setelem(const struct nft_ctx *ctx,
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	struct nft_set_dump_args *args;
 
+	if (!nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
 	if (nft_set_elem_expired(ext) || nft_set_elem_is_dead(ext))
 		return 0;
 
@@ -6500,7 +6529,7 @@ static void nft_setelem_activate(struct net *net, struct nft_set *set,
 	struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 
 	if (nft_setelem_is_catchall(set, elem)) {
-		nft_set_elem_change_active(net, set, ext);
+		nft_clear(net, ext);
 	} else {
 		set->ops->activate(net, set, elem);
 	}
@@ -7188,9 +7217,13 @@ static int nft_setelem_flush(const struct nft_ctx *ctx,
 			     const struct nft_set_iter *iter,
 			     struct nft_set_elem *elem)
 {
+	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	struct nft_trans *trans;
 	int err;
 
+	if (!nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
 	trans = nft_trans_alloc_gfp(ctx, NFT_MSG_DELSETELEM,
 				    sizeof(struct nft_trans_elem), GFP_ATOMIC);
 	if (!trans)
diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
index 1e5e7a181e0bc..cbf7f7825f1b8 100644
--- a/net/netfilter/nft_set_bitmap.c
+++ b/net/netfilter/nft_set_bitmap.c
@@ -171,7 +171,7 @@ static void nft_bitmap_activate(const struct net *net,
 	nft_bitmap_location(set, nft_set_ext_key(&be->ext), &idx, &off);
 	/* Enter 11 state. */
 	priv->bitmap[idx] |= (genmask << off);
-	nft_set_elem_change_active(net, set, &be->ext);
+	nft_clear(net, &be->ext);
 }
 
 static bool nft_bitmap_flush(const struct net *net,
@@ -223,8 +223,6 @@ static void nft_bitmap_walk(const struct nft_ctx *ctx,
 	list_for_each_entry_rcu(be, &priv->list, head) {
 		if (iter->count < iter->skip)
 			goto cont;
-		if (!nft_set_elem_active(&be->ext, iter->genmask))
-			goto cont;
 
 		elem.priv = be;
 
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 2013de934cef0..3a96d4a77a228 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -189,7 +189,7 @@ static void nft_rhash_activate(const struct net *net, const struct nft_set *set,
 {
 	struct nft_rhash_elem *he = elem->priv;
 
-	nft_set_elem_change_active(net, set, &he->ext);
+	nft_clear(net, &he->ext);
 }
 
 static bool nft_rhash_flush(const struct net *net,
@@ -277,8 +277,6 @@ static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (!nft_set_elem_active(&he->ext, iter->genmask))
-			goto cont;
 
 		elem.priv = he;
 
@@ -587,7 +585,7 @@ static void nft_hash_activate(const struct net *net, const struct nft_set *set,
 {
 	struct nft_hash_elem *he = elem->priv;
 
-	nft_set_elem_change_active(net, set, &he->ext);
+	nft_clear(net, &he->ext);
 }
 
 static bool nft_hash_flush(const struct net *net,
@@ -641,8 +639,6 @@ static void nft_hash_walk(const struct nft_ctx *ctx, struct nft_set *set,
 		hlist_for_each_entry_rcu(he, &priv->table[i], node) {
 			if (iter->count < iter->skip)
 				goto cont;
-			if (!nft_set_elem_active(&he->ext, iter->genmask))
-				goto cont;
 
 			elem.priv = he;
 
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 22407e7e0b51e..334958ef8d66c 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1766,7 +1766,7 @@ static void nft_pipapo_activate(const struct net *net,
 {
 	struct nft_pipapo_elem *e = elem->priv;
 
-	nft_set_elem_change_active(net, set, &e->ext);
+	nft_clear(net, &e->ext);
 }
 
 /**
@@ -2068,9 +2068,6 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		e = f->mt[r].e;
 
-		if (!nft_set_elem_active(&e->ext, iter->genmask))
-			goto cont;
-
 		elem.priv = e;
 
 		iter->err = iter->fn(ctx, set, iter, &elem);
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 5bf5572e945cc..afbda7e3fd048 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -527,7 +527,7 @@ static void nft_rbtree_activate(const struct net *net,
 {
 	struct nft_rbtree_elem *rbe = elem->priv;
 
-	nft_set_elem_change_active(net, set, &rbe->ext);
+	nft_clear(net, &rbe->ext);
 }
 
 static bool nft_rbtree_flush(const struct net *net,
@@ -596,8 +596,6 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (!nft_set_elem_active(&rbe->ext, iter->genmask))
-			goto cont;
 
 		elem.priv = rbe;
 
-- 
2.34.1



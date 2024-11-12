Return-Path: <stable+bounces-92436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F085E9C53FC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFAC2840CB
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A9F2123DB;
	Tue, 12 Nov 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u6epfwYy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623A1A76C7;
	Tue, 12 Nov 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407654; cv=none; b=dJcUEFqHV+APQycQ5zb7YYS8sc4hRrdmMZqtybXDI5VYOiZCvud3SXOVgsIetzApsk/Uu3RNCMB2FzoJGGtJkWy8azlhArlq4ALJLYt76sJmPEaGBlBYpPaUGeXuOUOuVH7RlicHb/gb3lAkWfX1ykwgRa6wie90Opim0XXqfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407654; c=relaxed/simple;
	bh=0j5bIBf4mvyNHFYEXeGF/xgRrh8/ogdv9J2u/iPLgVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcHH731Aaw98I4b9jJmhpfCYx5qOURTAU4Roc2xSxZEcMGhva6C73u0RUeGgkJkp95lcYMoZeP33gp+zIYOejOISze7pCDBpVFCxqCuJYBDDEQQNWf1YuqGnoEo6AQJPzCjcbQZj+Ye1CXIfz6TghhzAwuxvla1qOpQMRAl51nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u6epfwYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25CCC4CECD;
	Tue, 12 Nov 2024 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407654;
	bh=0j5bIBf4mvyNHFYEXeGF/xgRrh8/ogdv9J2u/iPLgVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6epfwYyHWGHHm9k+h8b6atg5U1CJ0EIwjfDPPT6pnakBcGxGqMHmLxyTxVmY30Dg
	 b+74ev+bHqnYDbIXNRHpC9kLKWplAvu/A1YesXX3vcBoktaxSEwQx4QBV6oxrEzd+z
	 R2lNvKn0y2SInU88vyCf/HMkXbUVScr6f6zvSD0s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	George Guo <guodongtai@kylinos.cn>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 042/119] netfilter: nf_tables: cleanup documentation
Date: Tue, 12 Nov 2024 11:20:50 +0100
Message-ID: <20241112101850.326173598@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
References: <20241112101848.708153352@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: George Guo <guodongtai@kylinos.cn>

[ Upstream commit b253d87fd78bf8d3e7efc5d149147765f044e89d ]

- Correct comments for nlpid, family, udlen and udata in struct nft_table,
  and afinfo is no longer a member of enum nft_set_class.

- Add comment for data in struct nft_set_elem.

- Add comment for flags in struct nft_ctx.

- Add comments for timeout in struct nft_set_iter, and flags is not a
  member of struct nft_set_iter, remove the comment for it.

- Add comments for commit, abort, estimate and gc_init in struct
  nft_set_ops.

- Add comments for pending_update, num_exprs, exprs and catchall_list
  in struct nft_set.

- Add comment for ext_len in struct nft_set_ext_tmpl.

- Add comment for inner_ops in struct nft_expr_type.

- Add comments for clone, destroy_clone, reduce, gc, offload,
  offload_action, offload_stats in struct nft_expr_ops.

- Add comments for blob_gen_0, blob_gen_1, bound, genmask, udlen, udata,
  blob_next in struct nft_chain.

- Add comment for flags in struct nft_base_chain.

- Add comments for udlen, udata in struct nft_object.

- Add comment for type in struct nft_object_ops.

- Add comment for hook_list in struct nft_flowtable, and remove comments
  for dev_name and ops which are not members of struct nft_flowtable.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: c03d278fdf35 ("netfilter: nf_tables: wait for rcu grace period on net_device removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h | 49 ++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 1b95c34a4e3d1..af62804b27ec7 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -205,6 +205,7 @@ static inline void nft_data_copy(u32 *dst, const struct nft_data *src,
  *	@nla: netlink attributes
  *	@portid: netlink portID of the original message
  *	@seq: netlink sequence number
+ *	@flags: modifiers to new request
  *	@family: protocol family
  *	@level: depth of the chains
  *	@report: notify via unicast netlink message
@@ -279,6 +280,7 @@ struct nft_userdata {
  *
  *	@key: element key
  *	@key_end: closing element key
+ *	@data: element data
  *	@priv: element private data and extensions
  */
 struct nft_set_elem {
@@ -330,10 +332,10 @@ struct nft_set_iter {
  *	@dtype: data type
  *	@dlen: data length
  *	@objtype: object type
- *	@flags: flags
  *	@size: number of set elements
  *	@policy: set policy
  *	@gc_int: garbage collector interval
+ *	@timeout: element timeout
  *	@field_len: length of each field in concatenation, bytes
  *	@field_count: number of concatenated fields in element
  *	@expr: set must support for expressions
@@ -356,9 +358,9 @@ struct nft_set_desc {
 /**
  *	enum nft_set_class - performance class
  *
- *	@NFT_LOOKUP_O_1: constant, O(1)
- *	@NFT_LOOKUP_O_LOG_N: logarithmic, O(log N)
- *	@NFT_LOOKUP_O_N: linear, O(N)
+ *	@NFT_SET_CLASS_O_1: constant, O(1)
+ *	@NFT_SET_CLASS_O_LOG_N: logarithmic, O(log N)
+ *	@NFT_SET_CLASS_O_N: linear, O(N)
  */
 enum nft_set_class {
 	NFT_SET_CLASS_O_1,
@@ -427,9 +429,13 @@ struct nft_set_ext;
  *	@remove: remove element from set
  *	@walk: iterate over all set elements
  *	@get: get set elements
+ *	@commit: commit set elements
+ *	@abort: abort set elements
  *	@privsize: function to return size of set private data
+ *	@estimate: estimate the required memory size and the lookup complexity class
  *	@init: initialize private data of new set instance
  *	@destroy: destroy private data of set instance
+ *	@gc_init: initialize garbage collection
  *	@elemsize: element private size
  *
  *	Operations lookup, update and delete have simpler interfaces, are faster
@@ -544,13 +550,16 @@ struct nft_set_elem_expr {
  *	@policy: set parameterization (see enum nft_set_policies)
  *	@udlen: user data length
  *	@udata: user data
- *	@expr: stateful expression
+ *	@pending_update: list of pending update set element
  * 	@ops: set ops
  * 	@flags: set flags
  *	@dead: set will be freed, never cleared
  *	@genmask: generation mask
  * 	@klen: key length
  * 	@dlen: data length
+ *	@num_exprs: numbers of exprs
+ *	@exprs: stateful expression
+ *	@catchall_list: list of catch-all set element
  * 	@data: private set data
  */
 struct nft_set {
@@ -701,6 +710,7 @@ extern const struct nft_set_ext_type nft_set_ext_types[];
  *
  *	@len: length of extension area
  *	@offset: offsets of individual extension types
+ *	@ext_len: length of the expected extension(used to sanity check)
  */
 struct nft_set_ext_tmpl {
 	u16	len;
@@ -846,6 +856,7 @@ struct nft_expr_ops;
  *	@select_ops: function to select nft_expr_ops
  *	@release_ops: release nft_expr_ops
  *	@ops: default ops, used when no select_ops functions is present
+ *	@inner_ops: inner ops, used for inner packet operation
  *	@list: used internally
  *	@name: Identifier
  *	@owner: module reference
@@ -887,14 +898,22 @@ struct nft_offload_ctx;
  *	struct nft_expr_ops - nf_tables expression operations
  *
  *	@eval: Expression evaluation function
+ *	@clone: Expression clone function
  *	@size: full expression size, including private data size
  *	@init: initialization function
  *	@activate: activate expression in the next generation
  *	@deactivate: deactivate expression in next generation
  *	@destroy: destruction function, called after synchronize_rcu
+ *	@destroy_clone: destruction clone function
  *	@dump: function to dump parameters
- *	@type: expression type
  *	@validate: validate expression, called during loop detection
+ *	@reduce: reduce expression
+ *	@gc: garbage collection expression
+ *	@offload: hardware offload expression
+ *	@offload_action: function to report true/false to allocate one slot or not in the flow
+ *			 offload array
+ *	@offload_stats: function to synchronize hardware stats via updating the counter expression
+ *	@type: expression type
  *	@data: extra data to attach to this expression operation
  */
 struct nft_expr_ops {
@@ -1047,14 +1066,21 @@ struct nft_rule_blob {
 /**
  *	struct nft_chain - nf_tables chain
  *
+ *	@blob_gen_0: rule blob pointer to the current generation
+ *	@blob_gen_1: rule blob pointer to the future generation
  *	@rules: list of rules in the chain
  *	@list: used internally
  *	@rhlhead: used internally
  *	@table: table that this chain belongs to
  *	@handle: chain handle
  *	@use: number of jump references to this chain
- *	@flags: bitmask of enum nft_chain_flags
+ *	@flags: bitmask of enum NFTA_CHAIN_FLAGS
+ *	@bound: bind or not
+ *	@genmask: generation mask
  *	@name: name of the chain
+ *	@udlen: user data length
+ *	@udata: user data in the chain
+ *	@blob_next: rule blob pointer to the next in the chain
  */
 struct nft_chain {
 	struct nft_rule_blob		__rcu *blob_gen_0;
@@ -1152,6 +1178,7 @@ struct nft_hook {
  *	@hook_list: list of netfilter hooks (for NFPROTO_NETDEV family)
  *	@type: chain type
  *	@policy: default policy
+ *	@flags: indicate the base chain disabled or not
  *	@stats: per-cpu chain stats
  *	@chain: the chain
  *	@flow_block: flow block (for hardware offload)
@@ -1277,11 +1304,13 @@ struct nft_object_hash_key {
  *	struct nft_object - nf_tables stateful object
  *
  *	@list: table stateful object list node
- *	@key:  keys that identify this object
  *	@rhlhead: nft_objname_ht node
+ *	@key: keys that identify this object
  *	@genmask: generation mask
  *	@use: number of references to this stateful object
  *	@handle: unique object handle
+ *	@udlen: length of user data
+ *	@udata: user data
  *	@ops: object operations
  *	@data: object data, layout depends on type
  */
@@ -1349,6 +1378,7 @@ struct nft_object_type {
  *	@destroy: release existing stateful object
  *	@dump: netlink dump stateful object
  *	@update: update stateful object
+ *	@type: pointer to object type
  */
 struct nft_object_ops {
 	void				(*eval)(struct nft_object *obj,
@@ -1384,9 +1414,8 @@ void nft_unregister_obj(struct nft_object_type *obj_type);
  *	@genmask: generation mask
  *	@use: number of references to this flow table
  * 	@handle: unique object handle
- *	@dev_name: array of device names
+ *	@hook_list: hook list for hooks per net_device in flowtables
  *	@data: rhashtable and garbage collector
- * 	@ops: array of hooks
  */
 struct nft_flowtable {
 	struct list_head		list;
-- 
2.43.0





Return-Path: <stable+bounces-252258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIpfMTwBDmo95QUAu9opvQ
	(envelope-from <stable+bounces-252258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:45:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC855972E2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3CE43586627
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6B53F4DD6;
	Wed, 20 May 2026 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g6iVSN8n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C403ED3B8;
	Wed, 20 May 2026 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300204; cv=none; b=Z1YLxh2JjRw5vdxllGIGI6dtit6K6IPg65DLuq3qEeO/TwU5W9rufM/2XcYTQOLhszsYFNczTlJrDIKKwagg654g07C8UWccA3slGXDtEAf457aEyp0JkFxVV5mPGuPrmk9OZdFlwa+S/bLiuT0P6kpqpLURrCZRiNpspZRI/H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300204; c=relaxed/simple;
	bh=9Qmy7kh5044NbsJ9Y6Usl1/0TqcdDQW/T+JZPxo8fVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8a4HYzE9/92J9PjkXvd87uw9QpZBbkUT5wGmQsIqtG/iZ1P0qn0wDjJ6uzIGiKzkVHGrMj+491x4Bz5nvwUNEdGoEVGB8bGRT1qP52UGObjIAWAACYlJxfmhqDgNentUG21Lrqm0EutUdb5yDz0OTkL4Qa7Uo5PDLIOyFIagGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g6iVSN8n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024D11F000E9;
	Wed, 20 May 2026 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300203;
	bh=aNwo12LEfTMnbXx57JLepaSBcFxBH5xiorrDaLXWBjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g6iVSN8nnIE2nM2NYhal1aIhoipry1suVBJZfEAgDJSSIRR5EPMwsu3bZz90qbEDi
	 rOO/8GDezSv40CgarA/QOv0KlEALx/Oi3ySSv+w4n5sm5jcMeZTsDYWOfZEwoUiP6F
	 USZbYyEa4kWQpYFthIti+qHwSb8ju3qjh66TBR3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 087/666] bpf: Relax scalar id equivalence for state pruning
Date: Wed, 20 May 2026 18:14:58 +0200
Message-ID: <20260520162113.114490263@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252258-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BDC855972E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Puranjay Mohan <puranjay@kernel.org>

[ Upstream commit b0388bafa4949bd30af7b3be5ee415f2a25ac014 ]

Scalar register IDs are used by the verifier to track relationships
between registers and enable bounds propagation across those
relationships. Once an ID becomes singular (i.e. only a single
register/stack slot carries it), it can no longer contribute to bounds
propagation and effectively becomes stale. The previous commit makes the
verifier clear such ids before caching the state.

When comparing the current and cached states for pruning, these stale
IDs can cause technically equivalent states to be considered different
and thus prevent pruning.

For example, in the selftest added in the next commit, two registers -
r6 and r7 are not linked to any other registers and get cached with
id=0, in the current state, they are both linked to each other with
id=A.  Before this commit, check_scalar_ids would give temporary ids to
r6 and r7 (say tid1 and tid2) and then check_ids() would map tid1->A,
and when it would see tid2->A, it would not consider these state
equivalent.

Relax scalar ID equivalence by treating rold->id == 0 as "independent":
if the old state did not rely on any ID relationships for a register,
then any ID/linking present in the current state only adds constraints
and is always safe to accept for pruning. Implement this by returning
true immediately in check_scalar_ids() when old_id == 0.

Maintain correctness for the opposite direction (old_id != 0 && cur_id
== 0) by still allocating a temporary ID for cur_id == 0. This avoids
incorrectly allowing multiple independent current registers (id==0) to
satisfy a single linked old ID during mapping.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/r/20260203165102.2302462-5-puranjay@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 2f2ec8e7730e ("bpf: Enforce regsafe base id consistency for BPF_ADD_CONST scalars")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c                         | 63 +++++++++++++++----
 .../selftests/bpf/progs/verifier_scalar_ids.c |  8 ++-
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index feb90c6e94620..87d631917f4dd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17425,13 +17425,29 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 	return false;
 }
 
-/* Similar to check_ids(), but allocate a unique temporary ID
- * for 'old_id' or 'cur_id' of zero.
- * This makes pairs like '0 vs unique ID', 'unique ID vs 0' valid.
+/*
+ * Compare scalar register IDs for state equivalence.
+ *
+ * When old_id == 0, the old register is independent - not linked to any
+ * other register. Any linking in the current state only adds constraints,
+ * making it more restrictive. Since the old state didn't rely on any ID
+ * relationships for this register, it's always safe to accept cur regardless
+ * of its ID. Hence, return true immediately.
+ *
+ * When old_id != 0 but cur_id == 0, we need to ensure that different
+ * independent registers in cur don't incorrectly satisfy the ID matching
+ * requirements of linked registers in old.
+ *
+ * Example: if old has r6.id=X and r7.id=X (linked), but cur has r6.id=0
+ * and r7.id=0 (both independent), without temp IDs both would map old_id=X
+ * to cur_id=0 and pass. With temp IDs: r6 maps X->temp1, r7 tries to map
+ * X->temp2, but X is already mapped to temp1, so the check fails correctly.
  */
 static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 {
-	old_id = old_id ? old_id : ++idmap->tmp_id_gen;
+	if (!old_id)
+		return true;
+
 	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
 
 	return check_ids(old_id, cur_id, idmap);
@@ -17600,11 +17616,21 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		}
 		if (!rold->precise && exact == NOT_EXACT)
 			return true;
-		if ((rold->id & BPF_ADD_CONST) != (rcur->id & BPF_ADD_CONST))
-			return false;
-		if ((rold->id & BPF_ADD_CONST) && (rold->off != rcur->off))
-			return false;
-		/* Why check_ids() for scalar registers?
+		/*
+		 * Linked register tracking uses rold->id to detect relationships.
+		 * When rold->id == 0, the register is independent and any linking
+		 * in rcur only adds constraints. When rold->id != 0, we must verify
+		 * id mapping and (for BPF_ADD_CONST) offset consistency.
+		 *
+		 * +------------------+-----------+------------------+---------------+
+		 * |                  | rold->id  | rold + ADD_CONST | rold->id == 0 |
+		 * |------------------+-----------+------------------+---------------|
+		 * | rcur->id         | range,ids | false            | range         |
+		 * | rcur + ADD_CONST | false     | range,ids,off    | range         |
+		 * | rcur->id == 0    | range,ids | false            | range         |
+		 * +------------------+-----------+------------------+---------------+
+		 *
+		 * Why check_ids() for scalar registers?
 		 *
 		 * Consider the following BPF code:
 		 *   1: r6 = ... unbound scalar, ID=a ...
@@ -17628,9 +17654,22 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * ---
 		 * Also verify that new value satisfies old value range knowledge.
 		 */
-		return range_within(rold, rcur) &&
-		       tnum_in(rold->var_off, rcur->var_off) &&
-		       check_scalar_ids(rold->id, rcur->id, idmap);
+
+		/* ADD_CONST mismatch: different linking semantics */
+		if ((rold->id & BPF_ADD_CONST) && !(rcur->id & BPF_ADD_CONST))
+			return false;
+
+		if (rold->id && !(rold->id & BPF_ADD_CONST) && (rcur->id & BPF_ADD_CONST))
+			return false;
+
+		/* Both have offset linkage: offsets must match */
+		if ((rold->id & BPF_ADD_CONST) && rold->off != rcur->off)
+			return false;
+
+		if (!check_scalar_ids(rold->id, rcur->id, idmap))
+			return false;
+
+		return range_within(rold, rcur) && tnum_in(rold->var_off, rcur->var_off);
 	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
 	case PTR_TO_MEM:
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 7c5e5e6d10ebc..dc65218e93c47 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -723,9 +723,9 @@ __success __log_level(2)
 /* The exit instruction should be reachable from two states,
  * use two matches and "processed .. insns" to ensure this.
  */
-__msg("13: (95) exit")
-__msg("13: (95) exit")
-__msg("processed 18 insns")
+__msg("15: (95) exit")
+__msg("15: (95) exit")
+__msg("processed 20 insns")
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void two_old_ids_one_cur_id(void)
 {
@@ -734,9 +734,11 @@ __naked void two_old_ids_one_cur_id(void)
 	"call %[bpf_ktime_get_ns];"
 	"r0 &= 0xff;"
 	"r6 = r0;"
+	"r8 = r0;"
 	"call %[bpf_ktime_get_ns];"
 	"r0 &= 0xff;"
 	"r7 = r0;"
+	"r9 = r0;"
 	"r0 = 0;"
 	/* Maybe make r{6,7} IDs identical */
 	"if r6 > r7 goto l0_%=;"
-- 
2.53.0





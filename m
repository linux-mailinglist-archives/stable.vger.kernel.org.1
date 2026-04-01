Return-Path: <stable+bounces-232673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKWMH6yRzGk7UAYAu9opvQ
	(envelope-from <stable+bounces-232673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:31:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27491374688
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE671302B193
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 03:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D74C37E300;
	Wed,  1 Apr 2026 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oGehAKZa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC137CD4E;
	Wed,  1 Apr 2026 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014312; cv=none; b=D7RpaD8ykVRVREIswGSf0Td/xnRhraLlG87n0MuUDaAjx+c1MOYZRlbsd3dEApCnWqE9rCla/GKJkFbRcoAVRvLZwwGInUBDiWvIknIN7FswUrNiel2WHCksoSq4AWVlfuIZRfDbuhqG6jwTkczgbBOpd4ERA074yd+IWB+DBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014312; c=relaxed/simple;
	bh=UPDVxCwWeAkiT+tQLpZ8IrXQEC5M/jntkDs2hTldDE0=;
	h=Date:To:From:Subject:Message-Id; b=GcP7W7SLHmYR0ru+uRGkvhhnVEljH7UdvNbUHwiULhtBZ89K06MfVERb6upI6ulNvw+ZuScpTJUrvkV4x4hhBGucAvBNA7zBRbuVol2Rml1cJ6ddQjp7WTfPCeowv1tTxB4cO2a+biz2SbUHfhlSnsXqrHs7NLjvhgfns3BBC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oGehAKZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9DAC4CEF7;
	Wed,  1 Apr 2026 03:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775014311;
	bh=UPDVxCwWeAkiT+tQLpZ8IrXQEC5M/jntkDs2hTldDE0=;
	h=Date:To:From:Subject:From;
	b=oGehAKZakeKQhw2pZGs/C3miBYzT9iewFr66/auBgHr8puntMp5Z2RgEdSB7fWaVh
	 VPX5DJq2uQhffoAH6hWQ18pWHRgA7F9xzTUH4iekAeIqp2ipLKim0gS2Zp0EB3knWX
	 SZVCM6kOlXD3wh/OA63kpKVXaCg4+nD7x5xmwrmE=
Date: Tue, 31 Mar 2026 20:31:51 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,sj@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-damon-core-validate-damos_quota_goal-nid-for-node_mem_usedfree_bp.patch added to mm-hotfixes-unstable branch
Message-Id: <20260401033151.CB9DAC4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232673-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:email,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 27491374688
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-damon-core-validate-damos_quota_goal-nid-for-node_mem_usedfree_bp.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-damon-core-validate-damos_quota_goal-nid-for-node_mem_usedfree_bp.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
Date: Sat, 28 Mar 2026 21:38:59 -0700

Patch series "mm/damon/core: validate damos_quota_goal->nid".

node_mem[cg]_{used,free}_bp DAMOS quota goals receive the node id.  The
node id is used for si_meminfo_node() and NODE_DATA() without proper
validation.  As a result, privileged users can trigger an out of bounds
memory access using DAMON_SYSFS.  Fix the issues.

The issue was originally reported [1] with a fix by another author.  The
original author announced [2] that they will stop working including the
fix that was still in the review stage.  Hence I'm restarting this.


Users can set damos_quota_goal->nid with arbitrary value for
node_mem_{used,free}_bp.  But DAMON core is using those for
si_meminfo_node() without the validation of the value.  This can result in
out of bounds memory access.  The issue can actually triggered using DAMON
user-space tool (damo), like below.

    $ sudo ./damo start --damos_action stat \
    	--damos_quota_goal node_mem_used_bp 50% -1 \
    	--damos_quota_interval 1s
    $ sudo dmesg
    [...]
    [   65.565986] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000098

Fix this issue by adding the validation of the given node.  If an invalid
node id is given, it returns 0% for used memory ratio, and 100% for free
memory ratio.

Link: https://lkml.kernel.org/r/20260329043902.46163-2-sj@kernel.org
Link: https://lore.kernel.org/20260325073034.140353-1-objecting@objecting.org [1]
Link: https://lore.kernel.org/20260327040924.68553-1-sj@kernel.org [2]
Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics for memory node utilization")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/core.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/mm/damon/core.c~mm-damon-core-validate-damos_quota_goal-nid-for-node_mem_usedfree_bp
+++ a/mm/damon/core.c
@@ -2078,12 +2078,24 @@ static inline u64 damos_get_some_mem_psi
 #endif	/* CONFIG_PSI */
 
 #ifdef CONFIG_NUMA
+static bool invalid_mem_node(int nid)
+{
+	return nid < 0 || nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY);
+}
+
 static __kernel_ulong_t damos_get_node_mem_bp(
 		struct damos_quota_goal *goal)
 {
 	struct sysinfo i;
 	__kernel_ulong_t numerator;
 
+	if (invalid_mem_node(goal->nid)) {
+		if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
+			return 0;
+		else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
+			return 10000;
+	}
+
 	si_meminfo_node(&i, goal->nid);
 	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
 		numerator = i.totalram - i.freeram;
_

Patches currently in -mm which might be from sj@kernel.org are

mm-damon-sysfs-dealloc-repeat_call_control-if-damon_call-fails.patch
mm-damon-core-fix-damon_call-vs-kdamond_fn-exit-race.patch
mm-damon-core-fix-damos_walk-vs-kdamond_fn-exit-race.patch
mm-damon-core-validate-damos_quota_goal-nid-for-node_mem_usedfree_bp.patch
mm-damon-core-validate-damos_quota_goal-nid-for-node_memcg_usedfree_bp.patch



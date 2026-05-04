Return-Path: <stable+bounces-243536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOQTInqt+GkuxwIAu9opvQ
	(envelope-from <stable+bounces-243536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:30:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF24BF917
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9568305E369
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D23DE425;
	Mon,  4 May 2026 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fwGBysYQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7CA1A6827;
	Mon,  4 May 2026 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904136; cv=none; b=geI6NZfJwiuuQeLvE7tg8Y/sbGM+YIbvIYF5D2HDkF/ZPtyT8aXMRUiwsat28YEZQliXbYbtOeFwSDs0mDTJ0xFwWCb5oFpRnocl6BWfafXi+N7upmHYfOsAQ2ukW3wB0vkfSQKCTpXdZLu2bTTUgYs8qjPUb12/k8inshojKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904136; c=relaxed/simple;
	bh=FsNKWt0kF1L9HlhElEExQK1LNXy8mlEUE5ZAmJpLrpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W46kpzgqlYjuHmPX0T/ITng/eZ2gXmel11DHGZ+k9F5tfWbo44kbvG0Yw924DojqrxxGpNXJt3OZMLW5dAKYzyb+CyDGoXljvVV+U2EnMNMrcc94jpVS2sEDkNhY5A+PTQtkC0fs+sjnwcVFL28qKThw4t0gMg3ai5+eKjJHSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fwGBysYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19100C2BCB8;
	Mon,  4 May 2026 14:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904136;
	bh=FsNKWt0kF1L9HlhElEExQK1LNXy8mlEUE5ZAmJpLrpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fwGBysYQd+HsK19797g92ZbICA1Vl+xfEn3/B5qtlBtTMOepJe/fq2DOcK9r68uv/
	 xI/xTuEG/uMS4Ti5jcpy4cjEU4s6xdnVXG4sS7NvEkwArXx78IZv5NJ5WNZToPsQkU
	 YDUFbTv6VWt47nIzIq5cBB+ntTdlXQszZooroaT8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 164/275] mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
Date: Mon,  4 May 2026 15:51:44 +0200
Message-ID: <20260504135149.142139699@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: EAAF24BF917
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243536-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linux-foundation.org:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj@kernel.org>

commit 40250b2dded0604a112be605f3828700d80ad7c2 upstream.

Patch series "mm/damon/core: validate damos_quota_goal->nid".

node_mem[cg]_{used,free}_bp DAMOS quota goals receive the node id.  The
node id is used for si_meminfo_node() and NODE_DATA() without proper
validation.  As a result, privileged users can trigger an out of bounds
memory access using DAMON_SYSFS.  Fix the issues.

The issue was originally reported [1] with a fix by another author.  The
original author announced [2] that they will stop working including the
fix that was still in the review stage.  Hence I'm restarting this.


This patch (of 2):

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

Link: https://lore.kernel.org/20260329043902.46163-2-sj@kernel.org
Link: https://lore.kernel.org/20260325073034.140353-1-objecting@objecting.org [1]
Link: https://lore.kernel.org/20260327040924.68553-1-sj@kernel.org [2]
Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics for memory node utilization")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/core.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2038,12 +2038,24 @@ static inline u64 damos_get_some_mem_psi
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




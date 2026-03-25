Return-Path: <stable+bounces-230361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDKBKcQIxGk+vgQAu9opvQ
	(envelope-from <stable+bounces-230361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:09:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927EA328BB7
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA086300E19A
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 15:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3992C3E9288;
	Wed, 25 Mar 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="gvTVpj8F"
X-Original-To: stable@vger.kernel.org
Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E143E63A0;
	Wed, 25 Mar 2026 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453963; cv=pass; b=lwRXn2n4qqIAGr3e4K42nEjwgUwq4xPDM+/5Cn5LKPpIvjOapez8CQe955aX1DPh0sj033mXsXSL797sx1BTVFlomSNdjC+0jgd6I4RODDy/2CJaVKLbGIAlKjdBwKHg4P1YnWRTiy4iwvL3YWU6U55RAU0AgbCyobKzN3rqxIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453963; c=relaxed/simple;
	bh=zjiPY9F9l+ajrYz/2vXsmADRabg/kNZ3PxSKmwn/tpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kYEWyStr7UlbUzG5bK4uuA1BU+DzSH09mXeDD8u0HUPSssl2K/9izcW2NsoRnSiwwLGEvJoMzza3Uafhq2S2zzBmbmZj7r3ez400aEyfhvJYdQGgCSzelAfQJKl9Z54MTm+O92TypklPP7bhUB8laV1Fx/V6YXMSEsHJLPaGaKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=gvTVpj8F; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
ARC-Seal: i=1; a=rsa-sha256; t=1774453946; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=QdFFblBuAIkc6r/hP0G/80ZU7VKnIJtskTQLbHME4lRh/tygvBog4xcTtiUlLFzZU5rGd0A1gs2Fwm63WzcEKRZqhmEWoS0K5NkxgsfOPdoYI/gAdJSWuDjIH9G8xgpfFKFQ3fhFhUzdBOsPJKe6ZukaFNEdZRrB5Wkl+owup2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774453946; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+OzSO0IWlJMDnZOc5tQIiXlFwu3Jx/5/svjrKhbwCZM=; 
	b=cENAaHNeGLRRVYUam3qFB8h+BQvS/7Lcaop9gRCmEaN3bbW/+yK3HZszuXv2zc6Jn4un0df95S0fqObgtVcInWN3KrTug7C7Lbxvi3dSVzv4ZaGKRtvspCz58YEFu+t0wQECUiTBkIfCysdxmdYDFw8ayof3kJydbmYNk1ROCoU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774453946;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=+OzSO0IWlJMDnZOc5tQIiXlFwu3Jx/5/svjrKhbwCZM=;
	b=gvTVpj8F2f5gybCbW7aMb360K5/13wRUmPh06eJonIc5nItoMp4GzmVzkBxsEySi
	BPG7GZgT9akuW8c6ESR2uvBmLViiAdgaD1dB6VMjE00xeVuuljMwls5Im+A0ALk4GyV
	4DN4BezgucKGlEtdD7d3AKI7sknT0zwy55NT4ni4=
Received: by mx.zoho.eu with SMTPS id 1774453943350571.0589292966793;
	Wed, 25 Mar 2026 16:52:23 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v2] mm/damon/core: validate goal nid before accessing node data
Date: Wed, 25 Mar 2026 15:52:21 +0000
Message-Id: <20260325155221.202700-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[objecting.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[objecting.org:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230361-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[objecting.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[objecting@objecting.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,objecting.org:dkim,objecting.org:email,objecting.org:mid]
X-Rspamd-Queue-Id: 927EA328BB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

damos_get_node_mem_bp() and damos_get_node_memcg_used_bp() pass
goal->nid directly to si_meminfo_node() and NODE_DATA() without
checking that it refers to a valid, online NUMA node.  Since
goal->nid is set from userspace via sysfs with no validation, a
negative or out-of-range value causes an out-of-bounds access in
NODE_DATA(), and a valid but offline node gives undefined results.

Add bounds and node_state(N_MEMORY) checks before using the nid,
consistent with damon_migrate_pages().

Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics for memory node utilization")
Cc: stable@vger.kernel.org
Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 59b709f04975..112125b635d7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2227,6 +2227,10 @@ static __kernel_ulong_t damos_get_node_mem_bp(
 	struct sysinfo i;
 	__kernel_ulong_t numerator;
 
+	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
+	    !node_state(goal->nid, N_MEMORY))
+		return 0;
+
 	si_meminfo_node(&i, goal->nid);
 	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
 		numerator = i.totalram - i.freeram;
@@ -2243,6 +2247,10 @@ static unsigned long damos_get_node_memcg_used_bp(
 	unsigned long used_pages, numerator;
 	struct sysinfo i;
 
+	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
+	    !node_state(goal->nid, N_MEMORY))
+		return 0;
+
 	memcg = mem_cgroup_get_from_id(goal->memcg_id);
 	if (!memcg) {
 		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
-- 
2.34.1



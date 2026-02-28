Return-Path: <stable+bounces-220802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEifBp9Xo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:01:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6711C8B30
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D620231C0D3E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD1F40F364;
	Sat, 28 Feb 2026 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNu9vZHw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF888494A04;
	Sat, 28 Feb 2026 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300687; cv=none; b=OrnO7Cb68XsC6NsNy1JPuMHSo7bop3JtAtSJDd/TNxooox0eVeM37GZt9eZDlXyKJIwUJtOeUii7nIzvZhpkBXGnAuxtE5bP+pH1ydPYZdwnuU0RYMT/r2VTlFySNrHjBtk0LvaQoUqZ/XcMcstyOQGP6tZHcgbyO9VI+xvMZtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300687; c=relaxed/simple;
	bh=1cbUP4+f5t1+aDgDls9jn2QhrK4hzb6Zn4PR9dAMTyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoJK+rD+7paBD0Y72DwM7kOGXvG0D9MM/onAabQZLo427rpZYdDDNwVyPeqpkzaqNozPmA8FjKLY+MkcTHlmbtba8aw/UHFl1EQVf2f8A8+MAztrfDjc0NQcrDQNCxzsIgEl6n3LZtDQibM7/hAUWl7v7bL9gQnvoZRQswJq6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNu9vZHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C8DC116D0;
	Sat, 28 Feb 2026 17:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300687;
	bh=1cbUP4+f5t1+aDgDls9jn2QhrK4hzb6Zn4PR9dAMTyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNu9vZHwQcXLK3wfARChmOip4+0ElJBfT8Kenn3TOAcCLo8cIVpFZmFiOsAVg35OM
	 uUi9U/qi8n6A8rWsP/4SokFXRwZlJLy0RcOGEACEwfiM0PxAPXgFMEsN21QqI0m/0h
	 pIL2U0s78Ym9vKut7Z8j8I43ygfTH3DGW7YZPicS2ISITp7IdcZbfVy4H7n8djW8r8
	 uewtwSr3Iyn3EJe/970bgGEI/ZR7gv4TgtGpjZk1uCJlmz8yq/jPT7CtJkKsKjfm2L
	 tu+qwpKkzxbmJEr+Mrh8aIEp6urOGLprRQsgwihgMXqu1e13i8bacHxw4w9IULyGh9
	 iMM3traghJ22w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 723/844] kho: skip memoryless NUMA nodes when reserving scratch areas
Date: Sat, 28 Feb 2026 12:30:36 -0500
Message-ID: <20260228173244.1509663-724-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220802-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,soleen.com:email]
X-Rspamd-Queue-Id: 1C6711C8B30
X-Rspamd-Action: no action

From: Evangelos Petrongonas <epetron@amazon.de>

[ Upstream commit 427b2535f51342de3156babc6bdc3f3b7dd2c707 ]

kho_reserve_scratch() iterates over all online NUMA nodes to allocate
per-node scratch memory.  On systems with memoryless NUMA nodes (nodes
that have CPUs but no memory), memblock_alloc_range_nid() fails because
there is no memory available on that node.  This causes KHO initialization
to fail and kho_enable to be set to false.

Some ARM64 systems have NUMA topologies where certain nodes contain only
CPUs without any associated memory.  These configurations are valid and
should not prevent KHO from functioning.

Fix this by only counting nodes that have memory (N_MEMORY state) and skip
memoryless nodes in the per-node scratch allocation loop.

Link: https://lkml.kernel.org/r/20260120175913.34368-1-epetron@amazon.de
Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers").
Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 90d411a59f76d..fcbbfcd3365f6 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -645,7 +645,7 @@ static void __init kho_reserve_scratch(void)
 	scratch_size_update();
 
 	/* FIXME: deal with node hot-plug/remove */
-	kho_scratch_cnt = num_online_nodes() + 2;
+	kho_scratch_cnt = nodes_weight(node_states[N_MEMORY]) + 2;
 	size = kho_scratch_cnt * sizeof(*kho_scratch);
 	kho_scratch = memblock_alloc(size, PAGE_SIZE);
 	if (!kho_scratch)
@@ -675,7 +675,11 @@ static void __init kho_reserve_scratch(void)
 	kho_scratch[i].size = size;
 	i++;
 
-	for_each_online_node(nid) {
+	/*
+	 * Loop over nodes that have both memory and are online. Skip
+	 * memoryless nodes, as we can not allocate scratch areas there.
+	 */
+	for_each_node_state(nid, N_MEMORY) {
 		size = scratch_size_node(nid);
 		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
 						0, MEMBLOCK_ALLOC_ACCESSIBLE,
-- 
2.51.0



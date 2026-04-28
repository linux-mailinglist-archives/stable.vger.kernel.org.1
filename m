Return-Path: <stable+bounces-241679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFJcOknN8GkKYwEAu9opvQ
	(envelope-from <stable+bounces-241679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:07:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2614878CA
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2CF431862CA
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7D37DEA6;
	Tue, 28 Apr 2026 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9MfRWxL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44F38AC97
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386761; cv=none; b=M2M/9tchRJEwMzYe+r8X7gQS/9wv1hgZ6MUUfDf+W/f3hWyN3R3S9Qj3bYUOLO0Kg5fSSNg5AGm+Wf72iR0StOEZKhEb31ubGhXOchWjU1KvNy1ESAO6A1Mq5Fbq857z5QA2lS/8c5PYBjYMMjzi3zBpPXvjJ86M7JCcuF2CkVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386761; c=relaxed/simple;
	bh=y3sSnCFNL023bVay7JLaOBxL4op53k7t4wt9O4DUFXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxJ2JaQpYwmFY2KajCIVsjfDYv/EVbE3kd2jPIjaJ98YyetfiwG70YOlQAdW1BMyY7WFMrUoRDTYnKovFCOwViTTtwTi+bV1DNZecBKkBhWrVWS3LkDIRXW2+x5U5kJ6Lm/byJuWv2oCKHd7tx9AEWA7BS6TZahZRp0ux6qvy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9MfRWxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C85C2BCB7;
	Tue, 28 Apr 2026 14:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777386760;
	bh=y3sSnCFNL023bVay7JLaOBxL4op53k7t4wt9O4DUFXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9MfRWxLfuNNskdQym0SthJ0B6hxeaRUAHjIJcfpxo3UqWOfdiVwMvG8qmYDIknZ6
	 fy8M5lR/xAwZpYnFg0LBuDRpTVHvXo7va5l27r1h2/P/c8rpfPq4xjIqiwgrc7O7uH
	 zycdiQXrUMrpGtY0zXjgOQaoDMJDD4QUfRsM/jBhgEmpTf9qZToZvWUvbDViSCNIH8
	 n3vSxrurJLeixw1MO4GD7WI3N7xET5ujyCGz6OExx6gUOa7i6Yp1NskmhlwPFXCks4
	 7PuU0Q+gVlqfyMMXLIuLIFCF/4LeuVXDeH497LWWQNSW8Vudm8QMg1oZ6WeBb0fH//
	 hPBaTQtMIW3nA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] arm64: mm: Simplify check in arch_kfence_init_pool()
Date: Tue, 28 Apr 2026 10:32:37 -0400
Message-ID: <20260428143238.2960283-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042741-lagged-ricotta-aa8b@gregkh>
References: <2026042741-lagged-ricotta-aa8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A2614878CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241679-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email]

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit b7737c38e7cb611c2fbd87af3b09afeb92c96fe7 ]

TL;DR: checking force_pte_mapping() in arch_kfence_init_pool() is
sufficient

Commit ce2b3a50ad92 ("arm64: mm: Don't sleep in
split_kernel_leaf_mapping() when in atomic context") recently added
an arm64 implementation of arch_kfence_init_pool() to ensure that
the KFENCE pool is PTE-mapped. Assuming that the pool was not
initialised early, block splitting is necessary if the linear
mapping is not fully PTE-mapped, in other words if
force_pte_mapping() is false.

arch_kfence_init_pool() currently makes another check: whether
BBML2-noabort is supported, i.e. whether we are *able* to split
block mappings. This check is however unnecessary, because
force_pte_mapping() is always true if KFENCE is enabled and
BBML2-noabort is not supported. This must be the case by design,
since KFENCE requires PTE-mapped pages in all cases. We can
therefore remove that check.

The situation is different in split_kernel_leaf_mapping(), as that
function is called unconditionally regardless of the configuration.
If BBML2-noabort is not supported, it cannot do anything and bails
out. If force_pte_mapping() is true, there is nothing to do and it
also bails out, but these are independent checks.

Commit 53357f14f924 ("arm64: mm: Tidy up force_pte_mapping()")
grouped these checks into a helper, split_leaf_mapping_possible().
This isn't so helpful as only split_kernel_leaf_mapping() should
check both. Revert the parts of that commit that introduced the
helper, reintroducing the more accurate comments in
split_kernel_leaf_mapping().

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Stable-dep-of: f12b435de2f2 ("arm64: mm: Fix rodata=full block mapping support for realm guests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/mmu.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ed04c42a826d8..bffb01ee04147 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -773,18 +773,6 @@ static inline bool force_pte_mapping(void)
 	return rodata_full || arm64_kfence_can_set_direct_map() || is_realm_world();
 }
 
-static inline bool split_leaf_mapping_possible(void)
-{
-	/*
-	 * !BBML2_NOABORT systems should never run into scenarios where we would
-	 * have to split. So exit early and let calling code detect it and raise
-	 * a warning.
-	 */
-	if (!system_supports_bbml2_noabort())
-		return false;
-	return !force_pte_mapping();
-}
-
 static DEFINE_MUTEX(pgtable_split_lock);
 
 int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
@@ -792,11 +780,22 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
 	int ret;
 
 	/*
-	 * Exit early if the region is within a pte-mapped area or if we can't
-	 * split. For the latter case, the permission change code will raise a
-	 * warning if not already pte-mapped.
+	 * !BBML2_NOABORT systems should not be trying to change permissions on
+	 * anything that is not pte-mapped in the first place. Just return early
+	 * and let the permission change code raise a warning if not already
+	 * pte-mapped.
 	 */
-	if (!split_leaf_mapping_possible() || is_kfence_address((void *)start))
+	if (!system_supports_bbml2_noabort())
+		return 0;
+
+	/*
+	 * If the region is within a pte-mapped area, there is no need to try to
+	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
+	 * change permissions from atomic context so for those cases (which are
+	 * always pte-mapped), we must not go any further because taking the
+	 * mutex below may sleep.
+	 */
+	if (force_pte_mapping() || is_kfence_address((void *)start))
 		return 0;
 
 	/*
@@ -1095,7 +1094,7 @@ bool arch_kfence_init_pool(void)
 	int ret;
 
 	/* Exit early if we know the linear map is already pte-mapped. */
-	if (!split_leaf_mapping_possible())
+	if (force_pte_mapping())
 		return true;
 
 	/* Kfence pool is already pte-mapped for the early init case. */
-- 
2.53.0



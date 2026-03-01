Return-Path: <stable+bounces-221701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDhgIYSYo2lIHwUAu9opvQ
	(envelope-from <stable+bounces-221701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:38:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E72071CB308
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC047303B90C
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329A81E0B86;
	Sun,  1 Mar 2026 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odpbHLry"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA68E1ADFE4
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328930; cv=none; b=RxItQ3GkvEeh8kAMiQgEP0BH6Tu1H870xT6JfcfzeoghcKkXX8SXYEr9gcu5MLsjtEA0+MUXQtxl8B0uG+2gX8cvCpmled1do4CDCS8sgfnZI3S1W2w2m5hyB1z0uc5rcPoulC1k8bPWDtDlmvwS87h+zOBzyfR1XWv9irch7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328930; c=relaxed/simple;
	bh=hQHVjddpf7hi5VOf+HYbPLrWcsziyH8t913F44jchaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrPhbiUPJo4/2hVS8vOIW5Lg/3XkWKkn0m9PKIpBxbcP3po6tXiEOTTm+CcapXzq281CgDE1Gbq/AW05UMovrjuwVOUtokTE4DtzC4+LCr5Af6wfMPJyJJbXm/TdniVwZhCGn8JNHnXoHDcQ6EVc1mZA3mx2HQqSnrE2G9b7HCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odpbHLry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BEEC19421;
	Sun,  1 Mar 2026 01:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328929;
	bh=hQHVjddpf7hi5VOf+HYbPLrWcsziyH8t913F44jchaQ=;
	h=From:To:Cc:Subject:Date:From;
	b=odpbHLry6Hh3GYPuHUpYccY/MA93eYzgumtTpZelWRy72iQr75m0bq6ebdPK0HEDb
	 GpjfMz+JeeolR8SsHY12pGODNB5Tosy860u2WrszAhF69j+JwHFeKVm9FILcFfCqLs
	 nHxkUyoDJKdcxVYHCgZKuNOZqZL8ghcopYNzcocIMmiQ2TnYTtdaK+RH76APGAGx5h
	 tnyFhOQiAwZglcHE5wk3pMG4jJLCkeFt+a8N8HRkSY0V03y/X3DCJk0n0cnWWKukP0
	 64ktFNFwKLUck0pS9nr7IOcmZjIKdhKROBndm/ga2GhU4hKs+InG5sHNMMXSxlmjJB
	 n0Xa+uxSO9W0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lgs201920130244@gmail.com
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "powerpc/smp: Add check for kcalloc() failure in parse_thread_groups()" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:35:27 -0500
Message-ID: <20260301013528.1695155-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221701-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E72071CB308
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 33c1c6d8a28a2761ac74b0380b2563cf546c2a3a Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 23 Sep 2025 21:32:35 +0800
Subject: [PATCH] powerpc/smp: Add check for kcalloc() failure in
 parse_thread_groups()

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing it to of_property_read_u32_array().

Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Cc: stable@vger.kernel.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20250923133235.1862108-1-lgs201920130244@gmail.com
---
 arch/powerpc/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 292fee8809bc8..cad3358fa4c35 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,6 +822,8 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
+	if (!thread_group_array)
+		return -ENOMEM;
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
 	if (ret)
-- 
2.51.0






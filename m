Return-Path: <stable+bounces-220158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH81NxQso2mF+AQAu9opvQ
	(envelope-from <stable+bounces-220158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 865AD1C537F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7948D310DB15
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99388494A14;
	Sat, 28 Feb 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPNHucj0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B412494A0D;
	Sat, 28 Feb 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300066; cv=none; b=AgUd93dXNZ5LX8DMKt3fKUsu0Ii9ibVFdEgFvE0yQt7V35x9fn2D1JygXpFjf9+zPzHlMT0JrtRF3nWQQbF9DKddAJWuI1ab26K4mRI4RKQqQR2ANqyKV4LGdRcO6kw2WcKCVwzHVDeCnjEE1PIoLkKKzcg4obrdp3lq3EPB5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300066; c=relaxed/simple;
	bh=9WitjgVvnfmCaDPrPZhij7/m17PwDVIt3q1JqDXF3A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REuQ6r8mjR3HZuvtD1yLFsgqyhxT7evBI8VKHoryiUJ8OYfgjqqvWGCD/Igjc77Z6dLvue5XH2jbRITm262hVLzHkFRSKjJuu05KOwFFB7jRVl7HBIgXNAeDcderzOVzzrcKzHkPTcJYP5X2wOM32TS0m9uysjTNPbRlxFB21BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPNHucj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D88FC19423;
	Sat, 28 Feb 2026 17:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300066;
	bh=9WitjgVvnfmCaDPrPZhij7/m17PwDVIt3q1JqDXF3A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPNHucj0dyOvcC4TD8gCjnsbx3pp3Zq+XYsOmCxrUzLV0HBI1kbefb8JlgfYhoM41
	 H6N5h0UYVWcU/iLpku53CgsJfyCaw4Zi5H/uU/NpgLXw5qUrtAE7CWGVdwjwb+HHZu
	 ldu3vv/oXNsHoD9L8Agt4KBMa8qWbh5ZtaX+e3SESjGxP6Py2BSYD7qtp+yxaSNqsD
	 M2/FMWx14nAq7zniPeiYH6r2zuea6ZybfDkTudx3plD6JcVm1FGZKpoZqY2sBiN1lk
	 /8DBgF2Kg8S13jkpw4YOxVqGpuUaHkIYN5TWcT2rHidaL/a6Sb4Jy1A7DrKCG5xUtc
	 u4ihT1UtlZRcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Carl Worth <carl@os.amperecomputing.com>,
	Taehyun Noh <taehyun@utexas.edu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 080/844] arm64: mte: Set TCMA1 whenever MTE is present in the kernel
Date: Sat, 28 Feb 2026 12:19:53 -0500
Message-ID: <20260228173244.1509663-81-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220158-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email,utexas.edu:email]
X-Rspamd-Queue-Id: 865AD1C537F
X-Rspamd-Action: no action

From: Carl Worth <carl@os.amperecomputing.com>

[ Upstream commit a4e5927115f30a301f9939ed43e6a21a343e06ad ]

Set the TCMA1 bit so that access to TTBR1 addresses with 0xf in their
tag bits will be treated as tag unchecked.

This is important to avoid unwanted tag checking on some
systems. Specifically, SCTLR_EL1.TCF can be set to indicate that no
tag check faults are desired. But the architecture doesn't guarantee
that in this case the system won't still perform tag checks.

Use TCMA1 to ensure that undesired tag checks are not performed. This
bit was already set in the KASAN case. Adding it to the non-KASAN case
prevents tag checking since all TTBR1 address will have a value of 0xf
in their tag bits.

This patch has been measured on an Ampere system to improve the following:

* Eliminate over 98% of kernel-side tag checks during "perf bench
  futex hash", as measured with "perf stat".

* Eliminate all MTE overhead (was previously a 25% performance
  penalty) from the Phoronix pts/memcached benchmark (1:10 Set:Get
  ration with 96 cores).

Reported-by: Taehyun Noh <taehyun@utexas.edu>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Carl Worth <carl@os.amperecomputing.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/proc.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5d907ce3b6d3f..22866b49be372 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -48,14 +48,14 @@
 #define TCR_KASAN_SW_FLAGS 0
 #endif
 
-#ifdef CONFIG_KASAN_HW_TAGS
-#define TCR_MTE_FLAGS TCR_EL1_TCMA1 | TCR_EL1_TBI1 | TCR_EL1_TBID1
-#elif defined(CONFIG_ARM64_MTE)
+#ifdef CONFIG_ARM64_MTE
 /*
  * The mte_zero_clear_page_tags() implementation uses DC GZVA, which relies on
- * TBI being enabled at EL1.
+ * TBI being enabled at EL1.  TCMA1 is needed to treat accesses with the
+ * match-all tag (0xF) as Tag Unchecked, irrespective of the SCTLR_EL1.TCF
+ * setting.
  */
-#define TCR_MTE_FLAGS TCR_EL1_TBI1 | TCR_EL1_TBID1
+#define TCR_MTE_FLAGS TCR_EL1_TCMA1 | TCR_EL1_TBI1 | TCR_EL1_TBID1
 #else
 #define TCR_MTE_FLAGS 0
 #endif
-- 
2.51.0



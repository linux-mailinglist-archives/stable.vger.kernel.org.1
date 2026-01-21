Return-Path: <stable+bounces-211025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EN2MAMscWl1fAAAu9opvQ
	(envelope-from <stable+bounces-211025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:41:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E88F5C626
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CC4C8020AE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA94337F0FA;
	Wed, 21 Jan 2026 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZVr89ryr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8965D285060;
	Wed, 21 Jan 2026 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020182; cv=none; b=ZCE5AN4tiZusCw8Rd/D7xe6c7GhRJf6yW/PXnAddOmV6YlqYGGA3IRpV19DVQ72heeLYuTojqIBPJNYiMM/qXAF85YcKhEPtN7GBLWri2c2t2cGDMlulqjxRTjKjXl1zoBncbu7fZ1PjOUjhC4RinhDJozGfcVi+BAoE5MfKIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020182; c=relaxed/simple;
	bh=3PXF09dbt+BQ0v3l3iaKlUUJ9JxIxHrqzYa/9NpXGU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRHBe4hGjEhXvAt4CwLPn28uJDY66NwwsmSgLJpuFYg9cAR+pQt2/EYTkauaQof+WrlVVzOOtYgapAw/vStZ67NSwoFCd8491ooMKozZZsrwt3k3tJL1CRu+B0DTGOoaRYtbHqN0RaOPLuqZDBrKvdE8D0FfWHkBWLERZxaHfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZVr89ryr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8381AC16AAE;
	Wed, 21 Jan 2026 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020182;
	bh=3PXF09dbt+BQ0v3l3iaKlUUJ9JxIxHrqzYa/9NpXGU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVr89ryr01yKOHqBoXFPwSckiVVwfo1AQyKw++xoMnqq6i6cuwHUBrg2NsLUr1kSS
	 MJFIZBmO4hASOdQTebiE5rNbFhQwOrOHwE5ygt6E5GWFn0jWVUoC7ACF5anErD1AyH
	 XzeKnJh7VCQXez6Eoah8FpZh4DyjRKDYB5D8t0q8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 066/198] mips: fix HIGHMEM initialization
Date: Wed, 21 Jan 2026 19:14:54 +0100
Message-ID: <20260121181420.935080219@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-211025-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmx.de,alliedtelesis.co.nz,hauke-m.de,gmail.com,alpha.franken.de,linutronix.de,linux-foundation.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux-foundation.org:email,linutronix.de:email,alliedtelesis.co.nz:email,gmx.de:email,franken.de:email]
X-Rspamd-Queue-Id: 5E88F5C626
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

[ Upstream commit f171b55f1441294344b86edfeaa575ea9673fd23 ]

Commit 6faea3422e3b ("arch, mm: streamline HIGHMEM freeing") overzealously
removed mem_init_free_highmem() function that beside freeing high memory
pages checked for CPU support for high memory as a prerequisite.

Partially restore mem_init_free_highmem() with a new highmem_init() name
and make it discard high memory in case there is no CPU support for it.

Link: https://lkml.kernel.org/r/20251231105701.519711-1-rppt@kernel.org
Fixes: 6faea3422e3b ("arch, mm: streamline HIGHMEM freeing")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reported-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/mm/init.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index a673d3d68254b..8986048f9b110 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -425,6 +425,28 @@ void __init paging_init(void)
 static struct kcore_list kcore_kseg0;
 #endif
 
+static inline void __init highmem_init(void)
+{
+#ifdef CONFIG_HIGHMEM
+	unsigned long tmp;
+
+	/*
+	 * If CPU cannot support HIGHMEM discard the memory above highstart_pfn
+	 */
+	if (cpu_has_dc_aliases) {
+		memblock_remove(PFN_PHYS(highstart_pfn), -1);
+		return;
+	}
+
+	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
+		struct page *page = pfn_to_page(tmp);
+
+		if (!memblock_is_memory(PFN_PHYS(tmp)))
+			SetPageReserved(page);
+	}
+#endif
+}
+
 void __init arch_mm_preinit(void)
 {
 	/*
@@ -435,6 +457,7 @@ void __init arch_mm_preinit(void)
 
 	maar_init();
 	setup_zero_pages();	/* Setup zeroed pages.  */
+	highmem_init();
 
 #ifdef CONFIG_64BIT
 	if ((unsigned long) &_text > (unsigned long) CKSEG0)
-- 
2.51.0





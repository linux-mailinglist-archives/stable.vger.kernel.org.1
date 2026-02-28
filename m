Return-Path: <stable+bounces-221153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE+aE6ldo2lxBQUAu9opvQ
	(envelope-from <stable+bounces-221153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:27:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CF01C910F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 204283753B4E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E572373139;
	Sat, 28 Feb 2026 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHWQJtQC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D237312B;
	Sat, 28 Feb 2026 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301506; cv=none; b=Oxp2LtbFw4ND5XS9p6eo280sKulwRBoSh1r44lmK7lEAKm1y6QoRk1ucNI6Re0TsNj5xxILEy3EYJZWGOL3uomNfzF+pFg7+/aj1AEPAtwLCxdSZwJkMgTqsjpfZOeQM/CEiWJZ8OPuKfRwCyVsLfLh2B1Q6pSr4wrhxJ8n62oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301506; c=relaxed/simple;
	bh=qFB2osV4uyJ47nNetqOZrBvwt9IAQKHhsyyqPsciP6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cR/Lu9+6KsBSeEwCjcvLiubI4XNhxz5dwcLY6Mf2f28BCFhT2vcfn3bQv8JqfRgqyNnXYB5mzAMbveFhT6mxaDQexSEmM0znA7SO5pRTwBizO2D6r9L9n2GUTo9RaAwc+C3XHY9gcXusp22rNzuP62o+Vqi+ruMsxfnX6esAIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHWQJtQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDDDC19423;
	Sat, 28 Feb 2026 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301506;
	bh=qFB2osV4uyJ47nNetqOZrBvwt9IAQKHhsyyqPsciP6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHWQJtQCiSHz/QYEqWxdzAAlDekElds/E5wWGqjxgL7YkBoahtcWb+fb4ekBwzZN0
	 rcPKqD2Ovoa/2CvErgZqDDjXIOpcqhyRSiregoC/OBnIg3+QqHITYD5pIxNFeChHfH
	 ZhuzGGhCiHKI3nAvK/dbus5+DgeTs2f4Gl0Kb7H9yHrfI2dvdR5+OQ1BXQuzOOFZE/
	 KFXmcfZYaMBXAuPwvBhGDlHl8Mo9HupcbanFLy4Ut53g64m+N7v6Qvp/VrcOgSug33
	 kf716Wq9qOQ99VyFPjhPRBPYfnwdZwu2Fm7i1jxAljks46z9adQbgF7EHjcKyEv8s+
	 s5ZKALYAdXp2g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 691/752] LoongArch: Disable instrumentation for setup_ptwalker()
Date: Sat, 28 Feb 2026 12:46:42 -0500
Message-ID: <20260228174750.1542406-691-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221153-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: E5CF01C910F
X-Rspamd-Action: no action

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 7cb37af61f09c9cfd90c43c9275307c16320cbf2 ]

According to Documentation/dev-tools/kasan.rst, software KASAN modes use
compiler instrumentation to insert validity checks. Such instrumentation
might be incompatible with some parts of the kernel, and therefore needs
to be disabled, just use the attribute __no_sanitize_address to disable
instrumentation for the low level function setup_ptwalker().

Otherwise bringing up the secondary CPUs failed when CONFIG_KASAN is set
(especially when PTW is enabled), here are the call chains:

    smpboot_entry()
      start_secondary()
        cpu_probe()
          per_cpu_trap_init()
            tlb_init()
              setup_tlb_handler()
                setup_ptwalker()

The reason is the PGD registers are configured in setup_ptwalker(), but
KASAN instrumentation may cause TLB exceptions before that.

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 3b427b319db21..f46c15d6e7eae 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -202,7 +202,7 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t *ptep
 	local_irq_restore(flags);
 }
 
-static void setup_ptwalker(void)
+static void __no_sanitize_address setup_ptwalker(void)
 {
 	unsigned long pwctl0, pwctl1;
 	unsigned long pgd_i = 0, pgd_w = 0;
-- 
2.51.0



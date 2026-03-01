Return-Path: <stable+bounces-221520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOgKKo6Wo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:29:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9E31CACE3
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0F87302CB24
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFDC285C84;
	Sun,  1 Mar 2026 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaFoOGgc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425DD1F1932;
	Sun,  1 Mar 2026 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328471; cv=none; b=YBD4Z+SfUXCU5NFo/otCgh9jQVK0O4c9tP8iFDuAGocKmteFKv07gYWqXmygmseDkvuWEs1vw/LgExHf0UDH8oQ02UlY2fgSeYNrdbJj6/Y5f3+B8nnz5lgcQjYPcKI5pYO+1y1PuaiG0P8f/0qZS3NIeaFpgFxtjbUHjg2c7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328471; c=relaxed/simple;
	bh=tldCM8Dh3pmP6Oi5yPzUFKUuWHOH1zp4QJkG6PwR8uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dpOApHWq+UXTaXuxoW7rWpR+pO8mjxB1h0hNznhmupeumfJiYZOdMFY/C7S6UAfZFz+AIuov2Y311lTh7d1BCyHDGCt6asbi3DQ4k7/0rPfqiNfjxVQoei/UBhm0gd3kExYPijWf6wHYBV5avWk2nm2CIVbXRfAlDpjy8QU5T6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaFoOGgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9900C19421;
	Sun,  1 Mar 2026 01:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328471;
	bh=tldCM8Dh3pmP6Oi5yPzUFKUuWHOH1zp4QJkG6PwR8uU=;
	h=From:To:Cc:Subject:Date:From;
	b=eaFoOGgcv1eDkC5L3yJM8G3ZuXSPM3Rh6Ai2aXvkAY8meDFunjIDIRiMEr82IWzE1
	 2zRpggriBBdWKaUMf8FdudbRoO1h1zWC3of5yW7ipSvUYTfiqzOQqHhQCGvWQKCKlP
	 5PLuTYjHzdnievk8snsYmaeqvEfkuDy03yTICBaJa+RKqd2jhuDcPcXjrr0PgtIIZk
	 2sr7rmJOVSoAou66L/rnVECjXRbtFlH2fm8e+Ygw6ZC5WvPojSlJL1Wrf93LPYyNz1
	 k9uG9uOS5bex6ZOBliTNwln0DaYvvL+Vg75TNFuts17flSN7+qNkQqV9QorhPTu9zb
	 cQCJmTn1Bi/zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Disable instrumentation for setup_ptwalker()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:27:49 -0500
Message-ID: <20260301012749.1685415-1-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221520-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: 8A9E31CACE3
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7cb37af61f09c9cfd90c43c9275307c16320cbf2 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Tue, 10 Feb 2026 19:31:17 +0800
Subject: [PATCH] LoongArch: Disable instrumentation for setup_ptwalker()

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
---
 arch/loongarch/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 4014c44695878..aaf7d685cc2aa 100644
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






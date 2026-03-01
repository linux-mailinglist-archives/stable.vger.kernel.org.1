Return-Path: <stable+bounces-222189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFp9IPSso2kmJwUAu9opvQ
	(envelope-from <stable+bounces-222189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:05:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E39271CE320
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 837D5329F433
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A330130B517;
	Sun,  1 Mar 2026 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvgZh3gy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662DC2DB7B5;
	Sun,  1 Mar 2026 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330120; cv=none; b=X20wSEFnnRvev9XoPsQubU82umL3exz6wVon7sp6chra/I3AsKtYja12/H7YgcdNjLqS/jZp4bRMK34Gg5xcZMJnyNUITe5g4Wf+JcQItsUIu/mAF/+AhSilPQzYDKiWXccX+UZ5EZV6x16iBXksLk/nLLNzAlZEwOoSG/2xLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330120; c=relaxed/simple;
	bh=0pTxAGVlKbMivZuPzyc+wak+hRdqT70/3tz5oR7nXRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTBxNr3fK29x3Z/uAOiuIVUX+DJxZM8yKl/Dxxl7zOpu7ZzlpRehHv/DC/+JdtYR6hg7CSTJKrjThrp12EbB6vgcy6on6+U95EwhRNHXaPpu+c0Quba9cFcaqWXcb3GUt/V+7t0fUgmy4SwOMWOWoQFQtVLseGdtIMsiAGSOt3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvgZh3gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF876C19421;
	Sun,  1 Mar 2026 01:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330120;
	bh=0pTxAGVlKbMivZuPzyc+wak+hRdqT70/3tz5oR7nXRU=;
	h=From:To:Cc:Subject:Date:From;
	b=SvgZh3gy2q407rFTeI6bCArNg0QsYMBT4wv4WeVEMgYhVY6zjdHL3OOIMoP/safZp
	 k03lCajLE6YWhvh4mn5Aknyg61xLHrjcYRTlh04W7lv8JZ8xGpvDcIRXF4NFHM9NdA
	 FKMbEg+Fqzx0kXhjnfXJs8Hxd3ghpxFEOM2GFV5GJFrm3lZNb2hgSesCjMCEffishS
	 PCiB5yOaT2Aos7gr6qHbfnuYH8vpW3/JMau4vjNsHVWMsatcUNEOV1p7MTk09QCRAC
	 6RTQ7HDOuQTipCead6f5LehqvcveZV0qf3K1Ctlm++Im8w23tMpVxfrpXWv0kbeYSR
	 CSfBMvNfaXzIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	loongarch@lists.linux.dev
Subject: FAILED: Patch "LoongArch: Disable instrumentation for setup_ptwalker()" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:55:18 -0500
Message-ID: <20260301015518.1722495-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222189-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E39271CE320
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
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






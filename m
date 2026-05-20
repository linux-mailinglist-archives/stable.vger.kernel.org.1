Return-Path: <stable+bounces-250758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKamOnH3DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:03:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEE15952F5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34830380AF8B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3723EEAD6;
	Wed, 20 May 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gfgSbBXT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9150A3ED3CF;
	Wed, 20 May 2026 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296240; cv=none; b=d5DpqYjD67KUOzj6U9RlQwrEjFqcHOlXTy08M4PIE9yrrECOACJp8Mc/cxRT2G7nlwpqESF/xcS5LTixdkO/djRBKZO18BXuY4tICyhoXfCFtxoPh7GGF9ezF6pVXqyj6suYEpplpcxkjO2Z3hym4bZPwt6HkjHuwRhNk+8sRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296240; c=relaxed/simple;
	bh=lUZX27PyRHPnqrNpZd+ZggGnVbbpmVMidmfC35uCfM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR3XqJwm9n3Tt50SnX3Av+4HF6aFVyX8s9gtMarprPFhm1sBb+Flb0RQBMuuuug4XNACBNlBf+KQAvT41aif8+zcQqYjZD1lw77IrAfpc3qiORtM9nXUIMlAFaf9z/INvUddutFRPI2IO0P6yfoaATJ1rJl2pNxdh+xxn+zMN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gfgSbBXT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BD51F000E9;
	Wed, 20 May 2026 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296239;
	bh=mqHiO65SpHjucodakRQvHU0V350l7rbjwEQpWkl1m84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gfgSbBXTBmmhUXRmk1L4cE9x9NoGCuA8rbjs7MkXizGPVOF6OfYrHjlhtF2JHQmjv
	 ZqUWaoKHRo3PBL21l+zivcwby8dmpaiLnp2oP6VC2tsDl0H9VD4Ctmr/3uXdRHwY8k
	 CITlDmED1Iji+V4YijFvRssxF7fO1JuHu2Y6ygCw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0723/1146] um: Fix potential race condition in TLB sync
Date: Wed, 20 May 2026 18:16:13 +0200
Message-ID: <20260520162204.567122676@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250758-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,antgroup.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 5AEE15952F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit 102331b66bcaf1f41f50b9c4cd5c36e46bafa9f3 ]

During the TLB sync, we need to traverse and modify the page table,
so we should hold the page table lock. Since full SMP support for
threads within the same process is still missing, let's disable the
split page table lock for simplicity.

Fixes: 1e4ee5135d81 ("um: Add initial SMP support")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20260302235224.1915380-2-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/tlb.c | 1 +
 mm/Kconfig           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 39608cccf2c69..5386ab2d0da50 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -165,6 +165,7 @@ int um_tlb_sync(struct mm_struct *mm)
 	unsigned long addr, next;
 	int ret = 0;
 
+	guard(spinlock_irqsave)(&mm->page_table_lock);
 	guard(spinlock_irqsave)(&mm->context.sync_tlb_lock);
 
 	if (mm->context.sync_tlb_range_to == 0)
diff --git a/mm/Kconfig b/mm/Kconfig
index ebd8ea353687e..befa8909ae29d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -572,6 +572,7 @@ config SPLIT_PTE_PTLOCKS
 	depends on !ARM || CPU_CACHE_VIPT
 	depends on !PARISC || PA20
 	depends on !SPARC32
+	depends on !UML
 
 config ARCH_ENABLE_SPLIT_PMD_PTLOCK
 	bool
-- 
2.53.0





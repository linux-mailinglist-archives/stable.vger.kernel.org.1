Return-Path: <stable+bounces-272893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dhs3HNyQT2o7jwIAu9opvQ
	(envelope-from <stable+bounces-272893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 14:15:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC0730DF6
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 14:15:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=kTTNyZow;
	dmarc=pass (policy=none) header.from=arm.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272893-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272893-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD6D3031803
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DCE40BCB6;
	Thu,  9 Jul 2026 12:14:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895DD3EDE76
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 12:13:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599241; cv=none; b=C8P0MbiMzSKvK2sMAWJ/Kj5VFS9M8rilpSR820431gInKnDjt3cqF8j2u9e8HB9TC8csY5vREOzs0G8UvnKrnGWen4axQHX3IlE+8Z3QxiOzoWAKu31rPv/i5Ociu8nL83Lv8yeeOHXIzHejaU6ICpo/dS2wnQqOUlx6cclWI00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599241; c=relaxed/simple;
	bh=A0HThDhV2EiHgkmjSvC1XV12EMUkekerQnoQu3QMhzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCL7G/Ge1OcT/6grloaukgAbyH2Un8xIBe9K3AXc2d8Qql4hxU/w7hCSIGGHh1NSDqqbXPCt1Ic3Oh3yMpj/hhlLbQsD0LZuk3109OxUGkPinfSRYjAmICfhQ8g8bbUeaWQxuhUDZc3ir66O+cRh8kFeEWNwDWMC7ZKvxeqniMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kTTNyZow; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 880643569;
	Thu,  9 Jul 2026 05:13:54 -0700 (PDT)
Received: from login2.euhpc2.arm.com (login2.euhpc2.arm.com [10.58.100.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 98B663F66F;
	Thu,  9 Jul 2026 05:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783599238; bh=A0HThDhV2EiHgkmjSvC1XV12EMUkekerQnoQu3QMhzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTTNyZowsGIdS5pykPgtJf7DxIDrQ79kMNcRJqRqZyy0Mr/a5+fYqNSHYFj1oj7mF
	 Ml8YVblaTdInjf5iwukEa4ygrpXEo/CdLJ81EbZ4nN5D3t5Gh6yzBU4mNyoCub9MXM
	 xcWp1/7ys/ooIn5DzyPdK6WT/hgTIdsPHWhS+p6E=
From: Vladimir Murzin <vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com,
	maz@kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	ruanjinjie@huawei.com,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH 03/36] arm64: hibernate: mask DAIF before restoring hibernated kernel
Date: Thu,  9 Jul 2026 13:13:00 +0100
Message-Id: <20260709121333.23507-4-vladimir.murzin@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20260709121333.23507-1-vladimir.murzin@arm.com>
References: <20260709121333.23507-1-vladimir.murzin@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272893-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-arm-kernel@lists.infradead.org,m:mark.rutland@arm.com,m:maz@kernel.org,m:will@kernel.org,m:catalin.marinas@arm.com,m:ruanjinjie@huawei.com,m:ada.coupriediaz@arm.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vladimir.murzin@arm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[vladimir.murzin@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:from_mime,arm.com:email,arm.com:mid,arm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1AC0730DF6

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

The arm64 hibernate code manages the exception masking in an unsound
way, leading to potential crashes and/or warnings during resume.

When a hibernation image is saved in `swsusp_arch_suspend()`, all DAIF
exceptions are masked (by virtue of `local_daif_save()`), and the
suspended image is saved assuming that all DAIF exceptions will remain
masked when the image is restored.

When a hibernation image is resumed by `swsusp_arch_resume()`, only
interrupts are masked (by virtue of `local_irq_save()` in
`resume_target_kernel()`). When pseudo-NMI is enabled the DAIF.IF bits
will be clear, and regardless of pseudo-NMI the DAIF.DA bits will be
clear.

This means that there are two problems:

(1) It is possible to take Debug, SError, or pseudo-NMI exceptions
    during the resume process. This is unsafe, as during the resume
    process both the old ane new kernels will tranisently be in an
    inconsistent state, and swsusp_arch_suspend_exit() won't retain
    an executable mapping of any exception vectors.

    Any exception taken here will be fatal and silent.

(2) When re-entering the resumed kernel, some DAIF bits will be clear
    unexpectedly. This permits Debug, SError, or pseudo-NMI exceptions
    to be taken for a short period while the resumed kernel is not yet
    in a consistent state.

    This is detected by CONFIG_ARM64_DEBUG_PRIORITY_MASKING.

Avoid these issues by masking all DAIF exceptions during resume.

Cc: stable@vger.kernel.org
Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm64/kernel/hibernate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 9717568518ba..d0d9bd91e639 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -405,6 +405,7 @@ int swsusp_arch_suspend(void)
 int __nocfi swsusp_arch_resume(void)
 {
 	int rc;
+	unsigned long flags;
 	void *zero_page;
 	size_t exit_size;
 	pgd_t *tmp_pg_dir;
@@ -465,9 +466,21 @@ int __nocfi swsusp_arch_resume(void)
 	if (el2_reset_needed())
 		__hyp_set_vectors(el2_vectors);
 
+	/*
+	 * It is necessary to mask all DAIF exceptions here as:
+	 *
+	 * - The copy of swsusp_arch_suspend_exit() in the hibernation
+	 *   text cannot handle taking any exceptions.
+	 *
+	 * - The suspended kernel masked all DAIF exceptions in
+	 *   swsusp_arch_resume(), and expects to be re-entered in the
+	 *   same state : with all DAIF exceptions masked.
+	 */
+	flags = local_daif_save();
 	hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
 		       resume_hdr.reenter_kernel, restore_pblist,
 		       resume_hdr.__hyp_stub_vectors, virt_to_phys(zero_page));
+	local_daif_restore(flags);
 
 	return 0;
 }
-- 
2.34.1



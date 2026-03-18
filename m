Return-Path: <stable+bounces-227055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEQgFD2dummHZgIAu9opvQ
	(envelope-from <stable+bounces-227055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:40:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0F52BBA13
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 887593026909
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65DF3D668C;
	Wed, 18 Mar 2026 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw4+HqZr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0911D88AC
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837575; cv=none; b=A2rbYm5e04Kj/A/zO9tXeyM+y9f70BUrdNWbC4MRp4fKlr9QDacpFxIaXpqk5CXy5HbCBj5LQtU4jaVlAmykxmyLN+igIIolO5d9kO9j729NhqFhLNe+KsdvKxUwyt4xXL1sz9CbFqUaw9rlwbcTciRHLPkbaH6RbntBdtRf56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837575; c=relaxed/simple;
	bh=rKRQmIMH+QWLTYSDsbASVkFhg2ol4oGDGq73sLtDtQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqeIUGEjA0YEhAZkG2nRoZ06ZuIshdpTf1/vUq3XCPDUJSmEyJvfhfdDdLoR6a2lZ1BoBNA7W1IchUgBmz7C07HPiKFUvLU+g1dkTqtjEC0d/fZlTJoeofOQE4nqABeUbKxF5HX5Z7qTzykzc56DhxrZjF5k4Bg9QgHjsvU5dtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw4+HqZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65975C19421;
	Wed, 18 Mar 2026 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773837575;
	bh=rKRQmIMH+QWLTYSDsbASVkFhg2ol4oGDGq73sLtDtQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gw4+HqZrRclex7r4KI6Ug7Y4QP+ZTHteuyNBPBm3WIy2vnWrbKLG7WzGZBn5cJSWo
	 C03ELx9M/UvWe7HxAyWirdhIYnh+D8fe2Cu1TGkZFGSnqCRirbLp9sgeoZ+4LX6AMU
	 C++kz/evI+dwn4880Y5Cxvwd8RxcUVUl2iqmy0UnwUptpg9JjX3HzIZdwokcKAX4ZP
	 r/jPXYWD+XMzZDgPNCoyhTqXcfxHgsIyEGGCf9A6LA8nTkiLr/CvyZhm2cbRuvsQfb
	 pIG2XhYpLIBagCvywBcN0fXMg/GP6XJXcmlI4wgNtV/4qvJT0pRbvQvT1yBmA+S/fJ
	 Asd2kq3qJMWKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] arm64: reorganise PAGE_/PROT_ macros
Date: Wed, 18 Mar 2026 08:39:31 -0400
Message-ID: <20260318123932.704033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031755-gravel-surfacing-cad8@gregkh>
References: <2026031755-gravel-surfacing-cad8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227055-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D0F52BBA13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Joey Gouly <joey.gouly@arm.com>

[ Upstream commit fa4cdccaa58224a12591f2c045c24abc5251bb9d ]

Make these macros available to assembly code, so they can be re-used by the
PIE initialisation code.

This involves adding some extra macros, prepended with _ that are the raw
values not `pgprot` values.

A dummy value for PTE_MAYBE_NG is also provided, for use in assembly.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20230606145859.697944-14-joey.gouly@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Stable-dep-of: c25c4aa3f79a ("arm64: mm: Add PTE_DIRTY back to PAGE_KERNEL* to fix kexec/hibernation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/pgtable-prot.h | 72 ++++++++++++++++-----------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index b1e1b74d993c3..2c49c93663f1f 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -26,6 +26,40 @@
  */
 #define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
 
+#define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
+#define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
+
+#define PROT_DEFAULT		(_PROT_DEFAULT | PTE_MAYBE_NG)
+#define PROT_SECT_DEFAULT	(_PROT_SECT_DEFAULT | PMD_MAYBE_NG)
+
+#define PROT_DEVICE_nGnRnE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRnE))
+#define PROT_DEVICE_nGnRE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRE))
+#define PROT_NORMAL_NC		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_NC))
+#define PROT_NORMAL		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL))
+#define PROT_NORMAL_TAGGED	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_TAGGED))
+
+#define PROT_SECT_DEVICE_nGnRE	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_DEVICE_nGnRE))
+#define PROT_SECT_NORMAL	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
+#define PROT_SECT_NORMAL_EXEC	(PROT_SECT_DEFAULT | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
+
+#define _PAGE_DEFAULT		(_PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
+
+#define _PAGE_KERNEL		(PROT_NORMAL)
+#define _PAGE_KERNEL_RO		((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY)
+#define _PAGE_KERNEL_ROX	((PROT_NORMAL & ~(PTE_WRITE | PTE_PXN)) | PTE_RDONLY)
+#define _PAGE_KERNEL_EXEC	(PROT_NORMAL & ~PTE_PXN)
+#define _PAGE_KERNEL_EXEC_CONT	((PROT_NORMAL & ~PTE_PXN) | PTE_CONT)
+
+#define _PAGE_SHARED		(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
+#define _PAGE_SHARED_EXEC	(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_WRITE)
+#define _PAGE_READONLY		(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
+#define _PAGE_READONLY_EXEC	(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN)
+#define _PAGE_EXECONLY		(_PAGE_DEFAULT | PTE_RDONLY | PTE_NG | PTE_PXN)
+
+#ifdef __ASSEMBLY__
+#define PTE_MAYBE_NG	0
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <asm/cpufeature.h>
@@ -33,9 +67,6 @@
 
 extern bool arm64_use_ng_mappings;
 
-#define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
-#define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
-
 #define PTE_MAYBE_NG		(arm64_use_ng_mappings ? PTE_NG : 0)
 #define PMD_MAYBE_NG		(arm64_use_ng_mappings ? PMD_SECT_NG : 0)
 
@@ -49,26 +80,11 @@ extern bool arm64_use_ng_mappings;
 #define PTE_MAYBE_GP		0
 #endif
 
-#define PROT_DEFAULT		(_PROT_DEFAULT | PTE_MAYBE_NG)
-#define PROT_SECT_DEFAULT	(_PROT_SECT_DEFAULT | PMD_MAYBE_NG)
-
-#define PROT_DEVICE_nGnRnE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRnE))
-#define PROT_DEVICE_nGnRE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRE))
-#define PROT_NORMAL_NC		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_NC))
-#define PROT_NORMAL		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL))
-#define PROT_NORMAL_TAGGED	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_TAGGED))
-
-#define PROT_SECT_DEVICE_nGnRE	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_DEVICE_nGnRE))
-#define PROT_SECT_NORMAL	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
-#define PROT_SECT_NORMAL_EXEC	(PROT_SECT_DEFAULT | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
-
-#define _PAGE_DEFAULT		(_PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
-
-#define PAGE_KERNEL		__pgprot(PROT_NORMAL)
-#define PAGE_KERNEL_RO		__pgprot((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY)
-#define PAGE_KERNEL_ROX		__pgprot((PROT_NORMAL & ~(PTE_WRITE | PTE_PXN)) | PTE_RDONLY)
-#define PAGE_KERNEL_EXEC	__pgprot(PROT_NORMAL & ~PTE_PXN)
-#define PAGE_KERNEL_EXEC_CONT	__pgprot((PROT_NORMAL & ~PTE_PXN) | PTE_CONT)
+#define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
+#define PAGE_KERNEL_RO		__pgprot(_PAGE_KERNEL_RO)
+#define PAGE_KERNEL_ROX		__pgprot(_PAGE_KERNEL_ROX)
+#define PAGE_KERNEL_EXEC	__pgprot(_PAGE_KERNEL_EXEC)
+#define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_KERNEL_EXEC_CONT)
 
 #define PAGE_S2_MEMATTR(attr, has_fwb)					\
 	({								\
@@ -82,11 +98,11 @@ extern bool arm64_use_ng_mappings;
 
 #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
 /* shared+writable pages are clean by default, hence PTE_RDONLY|PTE_WRITE */
-#define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
-#define PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_WRITE)
-#define PAGE_READONLY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
-#define PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN)
-#define PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_RDONLY | PTE_NG | PTE_PXN)
+#define PAGE_SHARED		__pgprot(_PAGE_SHARED)
+#define PAGE_SHARED_EXEC	__pgprot(_PAGE_SHARED_EXEC)
+#define PAGE_READONLY		__pgprot(_PAGE_READONLY)
+#define PAGE_READONLY_EXEC	__pgprot(_PAGE_READONLY_EXEC)
+#define PAGE_EXECONLY		__pgprot(_PAGE_EXECONLY)
 
 #define __P000  PAGE_NONE
 #define __P001  PAGE_READONLY
-- 
2.51.0



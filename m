Return-Path: <stable+bounces-196574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F42C7C50E
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 04:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9733A59E6
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 03:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D591B1EEE6;
	Sat, 22 Nov 2025 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niiL7EFL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9532F10E3
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763783155; cv=none; b=krJdx4dlEb7Jn+3E40VL5gWtCnS945NV9SHRNIWUcHi3We+PyABOSMr+AUFIQli6dXU3jv51H56ZFk0uJuRs5j1cvqzemA3tTUmluY1jzlJtOowaZWjcV9qfaCqpjjDRDQPUXQRW0Q53DyAlgb2ji3A52mSiBmFnBNnJPO/PJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763783155; c=relaxed/simple;
	bh=oFZpw86fsLHZTpXqxUmOFsCYpCaK30/ysiNiZ3eYPGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRWRVFJ2xIyU+pRuK9SX3QtBgipx65S9gH1AC4PbZ8/5wyxSC+Sne6gNQ6i4KG2NwNg0JD1Pbi1RmVnJU4fngeWVGQ9fFmndJViJx7/nik4NHPBitxNQxA1I7+NGPVPj03Cmo506Ck6R4LlscVG1irQiB+8opVbIG+f99PLlJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niiL7EFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27B6C16AAE;
	Sat, 22 Nov 2025 03:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763783155;
	bh=oFZpw86fsLHZTpXqxUmOFsCYpCaK30/ysiNiZ3eYPGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=niiL7EFLEm72C/pNqODAopW5RZMJZHdzPyOKRFyHigJ+gJTp5pRORhb0VTeQkYJRg
	 IV2TT4VFd1KKGd6BJm87CAGcJT4L38Ksm7IAPau2ze4mVgx1Jg00ayHnILTLhHSc+c
	 4MGr+5y1f2UmMoS6Z7Ps5VNzu8nykKkl4vBGZSX/3OlTWBBR/6vmfrqDhPlPZXb0LP
	 9znCimCa2Zd5A8NGmSoMz6euv2FbJPS7Udu6tg0AZs0NaA82mcvwqI5Z8fQVAHAL6m
	 GmNPQzxgsFeYBHVB7KciJ3nsHgyXTdv6WNeHjDxiXJGvK2e5Ril8vzm5bxnq7GVFYa
	 Hj7AOkkTf/UiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/3] kho: check if kho is finalized in __kho_preserve_order()
Date: Fri, 21 Nov 2025 22:45:50 -0500
Message-ID: <20251122034552.2782626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112136-panama-nape-342b@gregkh>
References: <2025112136-panama-nape-342b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

[ Upstream commit 469661d0d3a55a7ba1e7cb847c26baf78cace086 ]

Patch series "kho: add support for preserving vmalloc allocations", v5.

Following the discussion about preservation of memfd with LUO [1] these
patches add support for preserving vmalloc allocations.

Any KHO uses case presumes that there's a data structure that lists
physical addresses of preserved folios (and potentially some additional
metadata).  Allowing vmalloc preservations with KHO allows scalable
preservation of such data structures.

For instance, instead of allocating array describing preserved folios in
the fdt, memfd preservation can use vmalloc:

        preserved_folios = vmalloc_array(nr_folios, sizeof(*preserved_folios));
        memfd_luo_preserve_folios(preserved_folios, folios, nr_folios);
        kho_preserve_vmalloc(preserved_folios, &folios_info);

This patch (of 4):

Instead of checking if kho is finalized in each caller of
__kho_preserve_order(), do it in the core function itself.

Link: https://lkml.kernel.org/r/20250921054458.4043761-1-rppt@kernel.org
Link: https://lkml.kernel.org/r/20250921054458.4043761-2-rppt@kernel.org
Link: https://lore.kernel.org/all/20250807014442.3829950-30-pasha.tatashin@soleen.com [1]
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Changyuan Lyu <changyuanl@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: a2fff99f92da ("kho: increase metadata bitmap size to PAGE_SIZE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec_handover.c | 55 +++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index c58afd23a241f..4e5774a6f0738 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -91,6 +91,29 @@ struct kho_serialization {
 	struct khoser_mem_chunk *preserved_mem_map;
 };
 
+struct kho_out {
+	struct blocking_notifier_head chain_head;
+
+	struct dentry *dir;
+
+	struct mutex lock; /* protects KHO FDT finalization */
+
+	struct kho_serialization ser;
+	bool finalized;
+};
+
+static struct kho_out kho_out = {
+	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
+	.lock = __MUTEX_INITIALIZER(kho_out.lock),
+	.ser = {
+		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
+		.track = {
+			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
+		},
+	},
+	.finalized = false,
+};
+
 static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 {
 	void *elm, *res;
@@ -149,6 +172,9 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 
 	might_sleep();
 
+	if (kho_out.finalized)
+		return -EBUSY;
+
 	physxa = xa_load(&track->orders, order);
 	if (!physxa) {
 		int err;
@@ -631,29 +657,6 @@ int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-struct kho_out {
-	struct blocking_notifier_head chain_head;
-
-	struct dentry *dir;
-
-	struct mutex lock; /* protects KHO FDT finalization */
-
-	struct kho_serialization ser;
-	bool finalized;
-};
-
-static struct kho_out kho_out = {
-	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
-	.lock = __MUTEX_INITIALIZER(kho_out.lock),
-	.ser = {
-		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
-		.track = {
-			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
-		},
-	},
-	.finalized = false,
-};
-
 int register_kho_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
@@ -681,9 +684,6 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.ser.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	return __kho_preserve_order(track, pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
@@ -707,9 +707,6 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 	int err = 0;
 	struct kho_mem_track *track = &kho_out.ser.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
-- 
2.51.0



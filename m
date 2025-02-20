Return-Path: <stable+bounces-118464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF35BA3DF9B
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21B13B1A2D
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862B7200B9F;
	Thu, 20 Feb 2025 15:58:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B61FFC4E
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067085; cv=none; b=G1BXyfKb5bmSkh9Lb0DdE9hZv23nMlNwVhdAuLVyU5f28wvdk7qZIXEV4Crtm5l4QrNQkkKIonRgcnU02F5iOVm8YwGXWPm31Wc/D0aQSg/nhuqqoTA7gt9DeBsLcMDnDcLFbJOQAIG3w/h1dRw+5AZddAyQkaEI6GdgMFlhrys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067085; c=relaxed/simple;
	bh=6ykkv+W0spNvHgu8/Te6LPh8g+8GHXx9v/OvxURoVNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DAalHOOjVavEbQlWaJ3a1NAh3Sh35az5yVuG7WoCNJB0CtYcH5KeCOK5RWogyasUR1W1ZhwKvKlsNivtXIbxetzpbsKULA/OWKv2wY9u/dnVhxq4+cQDFN9wjyOGN0hjVPsObbbNlv1bVsjnkLdcw/eLk7ej31R0bFNt4IwUTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94A6C4CED1;
	Thu, 20 Feb 2025 15:58:03 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: yang@os.amperecomputing.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH stable 5.10.y-6.12.y] arm64: mte: Do not allow PROT_MTE on MAP_HUGETLB user mappings
Date: Thu, 20 Feb 2025 15:58:01 +0000
Message-Id: <20250220155801.1731061-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PROT_MTE (memory tagging extensions) is not supported on all user mmap()
types for various reasons (memory attributes, backing storage, CoW
handling). The arm64 arch_validate_flags() function checks whether the
VM_MTE_ALLOWED flag has been set for a vma during mmap(), usually by
arch_calc_vm_flag_bits().

Linux prior to 6.13 does not support PROT_MTE hugetlb mappings. This was
added by commit 25c17c4b55de ("hugetlb: arm64: add mte support").
However, earlier kernels inadvertently set VM_MTE_ALLOWED on
(MAP_ANONYMOUS | MAP_HUGETLB) mappings by only checking for
MAP_ANONYMOUS.

Explicitly check MAP_HUGETLB in arch_calc_vm_flag_bits() and avoid
setting VM_MTE_ALLOWED for such mappings.

Fixes: 9f3419315f3c ("arm64: mte: Add PROT_MTE support to mmap() and mprotect()")
Cc: <stable@vger.kernel.org> # 5.10.x-6.12.x
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Hi Greg,

This patch applies cleanly on top of the stable-rc/linux-6.12.y to
5.10.y LTS, so I'm only sending it once. It's not for 6.13 onwards since
those kernels support hugetlbfs with MTE.

Thanks,

Catalin

 arch/arm64/include/asm/mman.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 798d965760d4..5a280ac7570c 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -41,9 +41,12 @@ static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() &&
-	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
-		return VM_MTE_ALLOWED;
+	if (system_supports_mte()) {
+		if ((flags & MAP_ANONYMOUS) && !(flags & MAP_HUGETLB))
+			return VM_MTE_ALLOWED;
+		if (shmem_file(file))
+			return VM_MTE_ALLOWED;
+	}
 
 	return 0;
 }


Return-Path: <stable+bounces-150692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CECACC520
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E136F1893566
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8471E22DF84;
	Tue,  3 Jun 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXPp91vy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408BF1F5E6;
	Tue,  3 Jun 2025 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949296; cv=none; b=PMwTjCaMoHUr4/yWFTlXxES+4X4x/BO6IhIAMDEBQUyPfdD6h9dxLV3WnF1Cr8HBmJ3LLzfSNMcVX0gkuo67z2iYvxOzWjfvrw4Er/uE7fEKjus2UCZCRDRA5VOHG6P6zfayeEoPh75GYjkxKtS32708J9uIGY/lpVftYPMZJGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949296; c=relaxed/simple;
	bh=gHKElpoPrd324hZcX9bxb2VBNfY2GsZI2oRiWvUVO/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBEvH8Qcd1piL6t6WL9Bto8iNky77JfzevPcYgS8E+qljZHFHHAmswPIxyLJJqVfKQ+cZSXnorN6UzGxRvJWXD8RNMhcBYixMFt2dPQqSibP4hvx4zRcKnHvu7T50bF/VQsoShGyhLE42qidB0zoqS4gfDvhaBSVDqfCpjU1ajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXPp91vy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C12C4CEEF;
	Tue,  3 Jun 2025 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748949295;
	bh=gHKElpoPrd324hZcX9bxb2VBNfY2GsZI2oRiWvUVO/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OXPp91vyQ+gAIZoYMlwHZHEyTpt0yE1jYgax77HwjOmFYf8K26LX3sS6WBoykeaez
	 nrz/J9ZN1ovjh8pe1t54fRn0yrHYl0UhOAWF7iTbtSgyr5+exYjkiIq6ZtT+9gPkxx
	 el4UZJ7icBLEF5p75+bbKnkRgLEuANfg+/5jsQGGSwHhB2cJSAH9hFGouf8FEImWJM
	 4X9tqFviV+cP/giDXDfaE7oOgGL1CtZhtpSl6RSjqx+fBymKMP33RaKwHv1TPcdhQa
	 rmrkdZMAaT22dO6147aoR7sr9jhyAjiN70E7u/RABsMbla5JHiZY0FpjHHRvPminCt
	 FSyPEziW72b/w==
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	=?UTF-8?q?J=FCrgen=20Gro=DF?= <jgross@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xin Li <xin@zytor.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 1/5] x86/mm/pat: don't collapse pages without PSE set
Date: Tue,  3 Jun 2025 14:14:41 +0300
Message-ID: <20250603111446.2609381-2-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603111446.2609381-1-rppt@kernel.org>
References: <20250603111446.2609381-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Juergen Gross <jgross@suse.com>

Collapsing pages to a leaf PMD or PUD should be done only if
X86_FEATURE_PSE is available, which is not the case when running e.g.
as a Xen PV guest.

Cc: stable@vger.kernel.org
Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
Signed-off-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20250528123557.12847-3-jgross@suse.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index def3d9284254..9292f835cf5a 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1257,6 +1257,9 @@ static int collapse_pmd_page(pmd_t *pmd, unsigned long addr,
 	pgprot_t pgprot;
 	int i = 0;
 
+	if (!cpu_feature_enabled(X86_FEATURE_PSE))
+		return 0;
+
 	addr &= PMD_MASK;
 	pte = pte_offset_kernel(pmd, addr);
 	first = *pte;
-- 
2.47.2



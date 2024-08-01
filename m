Return-Path: <stable+bounces-65074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 613F8943EA9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4FD9B2CE17
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FA719AD78;
	Thu,  1 Aug 2024 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3HRAs+u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024401D4EC9;
	Thu,  1 Aug 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472256; cv=none; b=X0QHkkTS30VdJRO2UpIUiWcGYALkRVerFXnmHrT2TBBEy5tVX3gatCUxUGBTk0OXWxv8zB7A+edyWV9lnMVY9fy56oD0hZ0LyaEi9Cmc4zHyXzTtLH3OrAA6Cgm7oz9rJXn6kZe+TAgYAjq52dmTg0xnpTmxUYAhC25G/eco3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472256; c=relaxed/simple;
	bh=XnPP389Q+Yy4UtqdusLZFaBX12G1yQmJtrBdZkh07Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL+YiCwpu4UVqO4nR1Q0DlDAKaSBmuSU/HysTNncEtiUQKnim2Mah4Yz8yqk3fxCpcH4bGRUKYZ1uNV4/6xtA5VmQOF7RqnPUMAcpEzOCKcT7bql8Z/hl46IyA+2vam2ZDe0CHhKIznsDHYFUKDkVD1lDjR0PEpRgVez2mnlbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3HRAs+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C5BC116B1;
	Thu,  1 Aug 2024 00:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472255;
	bh=XnPP389Q+Yy4UtqdusLZFaBX12G1yQmJtrBdZkh07Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S3HRAs+uqVufrIITL3FHpSwfAxDA5o3tSTU/UT2lb96bV752D1zVgOFiabSIHgsCx
	 YQFp69Zke8LRrp9xAaXONQapkI2MBhDMXIkGbGnmlC4wl5BMEDbZQidTc+OGgzs9Q/
	 lOhZJjNquqS0ZrfCbPp+NT0GoOywXrOD1/Kc5V7MutHs3Ry7OdkQbvVUdsEslrnNp5
	 yqHNZFkOnNtwd4PR3tReEH7y85lUZqXDSiTmpBu545aBHealUeTLMAp0ZFjhiszxsJ
	 DiC0EPKiXzjGl9J/Aae7nqH0/XiM2tj0+w+3cemX9FAogXmrQREyipGf1UQrFQ15/b
	 4aqixiUhvvnwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Alexander Potapenko <glider@google.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.1 45/61] x86/kmsan: Fix hook for unaligned accesses
Date: Wed, 31 Jul 2024 20:26:03 -0400
Message-ID: <20240801002803.3935985-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>

[ Upstream commit bf6ab33d8487f5e2a0998ce75286eae65bb0a6d6 ]

When called with a 'from' that is not 4-byte-aligned, string_memcpy_fromio()
calls the movs() macro to copy the first few bytes, so that 'from' becomes
4-byte-aligned before calling rep_movs(). This movs() macro modifies 'to', and
the subsequent line modifies 'n'.

As a result, on unaligned accesses, kmsan_unpoison_memory() uses the updated
(aligned) values of 'to' and 'n'. Hence, it does not unpoison the entire
region.

Save the original values of 'to' and 'n', and pass those to
kmsan_unpoison_memory(), so that the entire region is unpoisoned.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/r/20240523215029.4160518-1-bjohannesmeyer@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/lib/iomem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index e0411a3774d49..5eecb45d05d5d 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -25,6 +25,9 @@ static __always_inline void rep_movs(void *to, const void *from, size_t n)
 
 static void string_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 {
+	const void *orig_to = to;
+	const size_t orig_n = n;
+
 	if (unlikely(!n))
 		return;
 
@@ -39,7 +42,7 @@ static void string_memcpy_fromio(void *to, const volatile void __iomem *from, si
 	}
 	rep_movs(to, (const void *)from, n);
 	/* KMSAN must treat values read from devices as initialized. */
-	kmsan_unpoison_memory(to, n);
+	kmsan_unpoison_memory(orig_to, orig_n);
 }
 
 static void string_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
-- 
2.43.0



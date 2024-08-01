Return-Path: <stable+bounces-64917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B0B943C5F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F232AB24BEE
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F047614C59C;
	Thu,  1 Aug 2024 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAZ1x6q/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF211BE855;
	Thu,  1 Aug 2024 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471422; cv=none; b=rIlQQQrtQwqFaEDKygb6QC1TtTfAqnsVozvjkO3ZZNfznhVvDFHnvIOlrgkVfMAEAJA0CFjjkP4A36VHEdWEkWQg85vPSN6KQ0ZxXFuuq+YsZ+lZJ850kCGZWPP94zTsHxQf3dWF2VCfChO+NxsLRGKjAZn6DrDViv0uEyrFoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471422; c=relaxed/simple;
	bh=XnPP389Q+Yy4UtqdusLZFaBX12G1yQmJtrBdZkh07Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCw2QxNULq8PVUECPu27HH2hehKWFO5gDEvztoDQa3lhvtmCzRRobPv3o2/27ycrm9aBo2LCwUz3yKzJTsSTv8E9C7ghzvic1Sqvo4buFY9S6aL+DhCR6i7GJpIqFjn8PqfpCuhJkAOab8YJPb4C8bofV994BB9pQHykts1kquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAZ1x6q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02090C4AF0E;
	Thu,  1 Aug 2024 00:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471422;
	bh=XnPP389Q+Yy4UtqdusLZFaBX12G1yQmJtrBdZkh07Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAZ1x6q/ZWxd5bTsf6V0B+a3Grw3N5yjIx90zZI3sHL0lVuup9slnGQWCsyfjKkwK
	 fV2JJ2rzNCw3B0Gl5JoKeZ67PmS6NL5PArN/EC1xFWmhiCEkoUEeV2ruG5ErHh4K/7
	 ecm7qvB0LImSylPb7UUFhhzq1nwZeJ0fn7BqeqEyfc5imTFzbqFShZ0LproAjJgLEn
	 TKyiiSoCjUkDL6FFK9rAXA5mofnlm+w2TRnIqLPJnN0Z4ttgBaMuJ2yMh78hHZePup
	 9PlHY6D89R1QCAXjI8psO7QxBEFt6Ic4ClloV/luy0wpVL5plKooXBFywAeOos5l1t
	 oVIABYNUdREhw==
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
Subject: [PATCH AUTOSEL 6.10 092/121] x86/kmsan: Fix hook for unaligned accesses
Date: Wed, 31 Jul 2024 20:00:30 -0400
Message-ID: <20240801000834.3930818-92-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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



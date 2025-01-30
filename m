Return-Path: <stable+bounces-111248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0EBA22732
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 01:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E9416185D
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 00:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23DA8BE8;
	Thu, 30 Jan 2025 00:28:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA98C1F
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738196898; cv=none; b=urTBiHEEO31D8WXe7VmW+o0M7wPZF/8BeAtG4hipKpYkUTPeH+vR8O0DBl3offYx+w7q+Bgg0KxvfkZY99Hy5X1EjaIlY0m4kEajo60fU0ZVjcyg0+tp/6L0o0enbdP32t/Hz5JZGfdzMU1WMpY7U+kPyZadmDgimTiQnOG55V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738196898; c=relaxed/simple;
	bh=Y8Ai1JGmV2H19nrg3fxEBsIxN+goQJftVfoEUwZNzaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNA2AkpHtSgoBgZvGAnwPNl3XC+Keh0P0SUDqpT83MVWEuK93uSohLaZGUKZvUvGGb4Bo8Q9eETku6deD0JjO+DoCfdGeKDTGYGuFPPjrcMdYxtdtrd9dygj2IGpe5CdqYGiH8eEud29S35jrMb4+y/DPLol4JKfWnIS4dlhM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 7626F23417;
	Thu, 30 Jan 2025 03:28:06 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH v2 5.10/5.15/6.1 5/5] x86/mm: Do not shuffle CPU entry areas without KASLR
Date: Thu, 30 Jan 2025 03:27:41 +0300
Message-Id: <20250130002741.66796-6-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20250130002741.66796-1-kovalev@altlinux.org>
References: <20250130002741.66796-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michal Koutný <mkoutny@suse.com>

commit a3f547addcaa10df5a226526bc9e2d9a94542344 upstream.

The commit 97e3d26b5e5f ("x86/mm: Randomize per-cpu entry area") fixed
an omission of KASLR on CPU entry areas. It doesn't take into account
KASLR switches though, which may result in unintended non-determinism
when a user wants to avoid it (e.g. debugging, benchmarking).

Generate only a single combination of CPU entry areas offsets -- the
linear array that existed prior randomization when KASLR is turned off.

Since we have 3f148f331814 ("x86/kasan: Map shadow for percpu pages on
demand") and followups, we can use the more relaxed guard
kasrl_enabled() (in contrast to kaslr_memory_enabled()).

Fixes: 97e3d26b5e5f ("x86/mm: Randomize per-cpu entry area")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20230306193144.24605-1-mkoutny%40suse.com
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 arch/x86/mm/cpu_entry_area.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 559d12ecef712a..e81363fe8d06fb 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -11,6 +11,7 @@
 #include <asm/fixmap.h>
 #include <asm/desc.h>
 #include <asm/kasan.h>
+#include <asm/setup.h>
 
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage);
 
@@ -30,6 +31,12 @@ static __init void init_cea_offsets(void)
 	unsigned int max_cea;
 	unsigned int i, j;
 
+	if (!kaslr_enabled()) {
+		for_each_possible_cpu(i)
+			per_cpu(_cea_offset, i) = i;
+		return;
+	}
+
 	max_cea = (CPU_ENTRY_AREA_MAP_SIZE - PAGE_SIZE) / CPU_ENTRY_AREA_SIZE;
 
 	/* O(sodding terrible) */
-- 
2.33.8



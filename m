Return-Path: <stable+bounces-92848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F19C6468
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 23:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985B52839F8
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 22:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3830A217451;
	Tue, 12 Nov 2024 22:42:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036C193092
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 22:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451361; cv=none; b=RLS0N+zp32GePciQrXORkUwj/BYjgsHqFDeKJiJFd0Ixh2xk47qk6ympZulMSTvB0fxDs4W+ZWP/Xz8CymEduaJH2utcOGRKh6ZvAFRMISHdfOnXHnyFuRsQnCpLYK58dYdV86DjYGId2E1aYiocTUcqWVLOgM1WNy7JXoZQ5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451361; c=relaxed/simple;
	bh=/vN2sRKRD0NvXposdq4oWoWeJ/Xhy4mnTMpiHsoIbJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIT+RZfUaAIKkXSWn9Tq79/rfWpNnpJK3stHFROu9aJkSqeg/gDRFrYQdPZnS/R8qJ/jzI5cKj56IZ+ZwmYrR4FFDpSDPVVXEC1KPm/VqByYp67DZaUldu7Z6oyQgXadUGET28y6CjnR5yXfYgvR2NOfiFCmg5uY8lKynPw4WAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id AA44E233FC;
	Wed, 13 Nov 2024 01:42:32 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: lvc-patches@linuxtesting.org,
	nickel@altlinux.org,
	dutyrok@altlinux.org,
	gerben@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10/5.15/6.1 5/5] x86/mm: Do not shuffle CPU entry areas without KASLR
Date: Wed, 13 Nov 2024 01:42:01 +0300
Message-Id: <20241112224201.289285-6-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20241112224201.289285-1-kovalev@altlinux.org>
References: <20241112224201.289285-1-kovalev@altlinux.org>
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
index 350868f181116..4b7c9adc14ada 100644
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



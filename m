Return-Path: <stable+bounces-151985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C4AD17A5
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 06:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780C23A9948
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFF824676B;
	Mon,  9 Jun 2025 04:12:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F011813AC1;
	Mon,  9 Jun 2025 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749442356; cv=none; b=UR5BEYeV8LwPf5cy4eWS11TbJ/cYYRg/QB5jiTA2E4K+tvgnB7AuXAKJ7TiJj8anEmgS0sEuN9lg5CcLjJ3StKzAXuW5GZJU4cqNUbH52xoeYt8edO6s3AAYprKRyHM7aP1/VQOq5iMrJ0knLyXDSWn0mm9Bydw5VEc5tHUNdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749442356; c=relaxed/simple;
	bh=AirhTziG8+R2vrdEjtsIrRarvIhm+QQe5wcMlTkArBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bNouyYdQsOD+N0Fvcy0xlb9B2dvR9syWqZ/o4Kh6GLKIa46O1aRgmiSq9FFWzI1BTe2XCQvRIKSidnrvOzLsmI4fvdMg6EZtt/A2oB5skmlIPC16tmOI4Db58baZajRH+TJm88JX4TLDZxW5HFAbPEHPSaSPYoEzmkzFQA5xLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86AB71515;
	Sun,  8 Jun 2025 21:12:08 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CEC33F673;
	Sun,  8 Jun 2025 21:12:25 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	stable@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] arm64/ptdump: Ensure memory hotplug is prevented during ptdump_check_wx()
Date: Mon,  9 Jun 2025 05:12:14 +0100
Message-Id: <20250609041214.285664-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arm64 page table dump code can race with concurrent modification of the
kernel page tables. When a leaf entries are modified concurrently, the dump
code may log stale or inconsistent information for a VA range, but this is
otherwise not harmful.

When intermediate levels of table are freed, the dump code will continue to
use memory which has been freed and potentially reallocated for another
purpose. In such cases, the dump code may dereference bogus addresses,
leading to a number of potential problems.

This problem was fixed for ptdump_show() earlier via commit 'bf2b59f60ee1
("arm64/mm: Hold memory hotplug lock while walking for kernel page table
dump")' but a same was missed for ptdump_check_wx() which faced the race
condition as well. Let's just take the memory hotplug lock while executing
ptdump_check_wx().

Cc: stable@vger.kernel.org
Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reported-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.16-rc1

Dev Jain found this via code inspection.

 arch/arm64/mm/ptdump.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 421a5de806c62..551f80d41e8d2 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -328,7 +328,7 @@ static struct ptdump_info kernel_ptdump_info __ro_after_init = {
 	.mm		= &init_mm,
 };
 
-bool ptdump_check_wx(void)
+static bool __ptdump_check_wx(void)
 {
 	struct ptdump_pg_state st = {
 		.seq = NULL,
@@ -367,6 +367,16 @@ bool ptdump_check_wx(void)
 	}
 }
 
+bool ptdump_check_wx(void)
+{
+	bool ret;
+
+	get_online_mems();
+	ret = __ptdump_check_wx();
+	put_online_mems();
+	return ret;
+}
+
 static int __init ptdump_init(void)
 {
 	u64 page_offset = _PAGE_OFFSET(vabits_actual);
-- 
2.30.2



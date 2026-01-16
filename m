Return-Path: <stable+bounces-210050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24999D31CA6
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 14:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E0B5301E230
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE35265CC2;
	Fri, 16 Jan 2026 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="okh4yN8c"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FE126C3A2
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569903; cv=none; b=S8gqijg36PylJzLe84+QUqoha5SpE68GQO8R4wr303rKesjtnMdjBDimBClH2FljaLlENm9QbmbPjCT/d3i+Eo91tR5CVupnrFGGh2qlg/537PbQ7xnUngvuni8nBQJTKj1PSgzDM6uTuJFPGtNDtJaL47QJsmQIoPdB8c8wB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569903; c=relaxed/simple;
	bh=6nvAT2nizZukeyYIo3PfjaccCYmiXFZJhWUMJuDRU0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mItKHLtUJJgqqDhYH74ZORD5IytaWFZVbN5QiOdVztAha/5CnKhPiSU1hKhu9bqr1UQK63i0sJsPSAMfrs4V5gnJbaqsoAh37NJpCaaYfYMyE+jB00t/WIqkw3cexnx3Gj+Pnqagcyz0Ea1s9aAqJl7Cz8yPn9Q+jpDybzTTM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=okh4yN8c; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id gjEOvihIlipkCgjoyvucoZ; Fri, 16 Jan 2026 13:25:00 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id gjoyvSBCzhoT4gjoyvoikc; Fri, 16 Jan 2026 13:25:00 +0000
X-Authority-Analysis: v=2.4 cv=XZyJzJ55 c=1 sm=1 tr=0 ts=696a3c2c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=h0uksLzaAAAA:8 a=HaFmDPmJAAAA:8 a=djn8nBB36KeQ6tMeFF8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=MSi_79tMYmZZG2gvAgS0:22 a=nmWuMzfKamIsx3l42hEX:22
 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gzY9T/wOxG/DeCeifioZfFDO1q/aXoaa8lYWCbgpxgY=; b=okh4yN8cnWwvtolNMSGTmfKjYh
	88w44fVc82dU10XN97d5Q39K2xGHyQybPtSCX7ZpzYycCgVyvgyp7Y2Ocnnf08DVi7E21hxKp55XG
	iJINMDdX5jUT78wZbURE8DYd858WgyJPSqDVqcRZycifa4fJkh4/+otYlDLIDgdpZKJSlqZhhNhdv
	/OCYYh4noPXx3ph2NqFz9C5mXE0y80woyesz/WInIASYu+DttmPh550n4bIvOGQl+eSs5dV9Ko4kP
	qYwFKcXi+DTfq+LO4o0ClEmYEHdpckT9aabPevz1ntfcFdSxm9vm1ZZz+Iv75LtLuRjdhvGKGrw3j
	kGctm/QA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:56854 helo=beavis.silicon)
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vgjox-00000001U44-3B3G;
	Fri, 16 Jan 2026 06:24:59 -0700
From: Ron Economos <re@w6rz.net>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Ron Economos <re@w6rz.net>
Subject: [PATCH 6.6] riscv: Replace function-like macro by static inline function
Date: Fri, 16 Jan 2026 05:24:38 -0800
Message-ID: <20260116132438.964314-1-re@w6rz.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1vgjox-00000001U44-3B3G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net (beavis.silicon) [73.92.56.26]:56854
X-Source-Auth: re@w6rz.net
X-Email-Count: 6
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJIprIH4WQwrrS8cQ6cSOiDzGhC/1a9U4xapm3LYEbFoVgWsJbx2/XqsHBkjw0XY1nOGwjoGH4HxJmIT314WCM3eSKYkqU7BmsxG1sGOPkPna17VllBP
 ukJOwasrYj+TdUELpk4zAPDAQe3OsZUlZLG1Cnr5b2seQ9Oe1MvcJbJAwWFxoCy5Bc6ShQ5S5raDaA==

From: Björn Töpel <bjorn@rivosinc.com>

[ upstream commit 121f34341d396b666d8a90b24768b40e08ca0d61 ]

The flush_icache_range() function is implemented as a "function-like
macro with unused parameters", which can result in "unused variables"
warnings.

Replace the macro with a static inline function, as advised by
Documentation/process/coding-style.rst.

Fixes: 08f051eda33b ("RISC-V: Flush I$ when making a dirty page executable")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20250419111402.1660267-1-bjorn@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Ron Economos <re@w6rz.net>
---
 arch/riscv/include/asm/cacheflush.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 3f65acd0ef75..2b7f5da96c50 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -34,11 +34,6 @@ static inline void flush_dcache_page(struct page *page)
 	flush_dcache_folio(page_folio(page));
 }
 
-/*
- * RISC-V doesn't have an instruction to flush parts of the instruction cache,
- * so instead we just flush the whole thing.
- */
-#define flush_icache_range(start, end) flush_icache_all()
 #define flush_icache_user_page(vma, pg, addr, len) \
 	flush_icache_mm(vma->vm_mm, 0)
 
@@ -59,6 +54,16 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
 
 #endif /* CONFIG_SMP */
 
+/*
+ * RISC-V doesn't have an instruction to flush parts of the instruction cache,
+ * so instead we just flush the whole thing.
+ */
+#define flush_icache_range flush_icache_range
+static inline void flush_icache_range(unsigned long start, unsigned long end)
+{
+	flush_icache_all();
+}
+
 extern unsigned int riscv_cbom_block_size;
 extern unsigned int riscv_cboz_block_size;
 void riscv_init_cbo_blocksizes(void);
-- 
2.43.0



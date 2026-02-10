Return-Path: <stable+bounces-215634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGDwETwCi2npPAAAu9opvQ
	(envelope-from <stable+bounces-215634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:02:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3712C11951B
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A781302BDE4
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEC6346AE3;
	Tue, 10 Feb 2026 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="m6wQLq+F"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B648344D97
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717750; cv=none; b=n2mCx4bjEftz+kmf7kHgmohaevJ3kWb/xkDBThvbAUgow623EfGwsw68+cBMTv/YpySinLZWlyiKWrA0cU+Xfir6ZEGjtRoZPnclLBEFn+hOtOMYIN3YLWE5tHV16VJmls/v46GeyUAGuOUTObPdhntLc5t3fTAkYoiNKar0us8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717750; c=relaxed/simple;
	bh=D5zc+mEsKUNcL+dL8qQRS578P6ZdoxEsV5FPL4Q0XT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z+6IL2UO0v/S4YeKqEmRe1WOgzSdhOOGiDSWjE9z9OIDGYiAcqY3Qum2oc+YlGKwrg1h5xNrWx7WE5ePymhxFcEWqCreL/j1mkEpPnV+TzTfTtdsCOUHhGYH49zCKdtQQfouOxuVmdVtXClPWc+/QxQ15HvaUNUbeNK+1ex7y8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=m6wQLq+F; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id pfr2vsw3HVCBNpkZdvkpX0; Tue, 10 Feb 2026 10:02:26 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id pkZcvGkx92l0kpkZdvNM9f; Tue, 10 Feb 2026 10:02:25 +0000
X-Authority-Analysis: v=2.4 cv=UfRRSLSN c=1 sm=1 tr=0 ts=698b0231
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=h0uksLzaAAAA:8 a=HaFmDPmJAAAA:8 a=djn8nBB36KeQ6tMeFF8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=MSi_79tMYmZZG2gvAgS0:22 a=nmWuMzfKamIsx3l42hEX:22
 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zzGhcwBQ0Ex+g2JcqOwHNtbJCaWlj3nGXCTugZPDWrw=; b=m6wQLq+FLvPgIaTsIrrt0cJ2yH
	jKSj1JhyXvD1rdqXsWXDSkIBui/QhDeK8/rp77PsPGvYNpsatLO/+3Cs4X9EREnbcbOcMB2q47rHt
	dKxJ9hgwVf7KD5ikn83DvbAF1XKps5yJbPA+V4f2ih6QYjBgi7ObeoWMxSFAb2yRkdkrCpyrVhIoL
	hpMFxTLkRp1qUTgr4wtX99r7s4Xx5UUkG45uZW8j6sBgkh9NUWDjZUGxOCOeVvOXxhd85tLJEFPb8
	R7jkCWWc0MBjX5Rhb0B5MqapCU9bwSZA1sIlbH71of2abHNwTnCMinMAYEuY5Vwbd7k4Y2vFXikjn
	S7vswPkQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:44804 helo=beavis.silicon)
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vpkZc-00000000nbw-2jNV;
	Tue, 10 Feb 2026 03:02:24 -0700
From: Ron Economos <re@w6rz.net>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Ron Economos <re@w6rz.net>
Subject: [PATCH 5.15] riscv: Replace function-like macro by static inline function
Date: Tue, 10 Feb 2026 02:01:48 -0800
Message-ID: <20260210100148.3674334-1-re@w6rz.net>
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
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1vpkZc-00000000nbw-2jNV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net (beavis.silicon) [73.162.206.103]:44804
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNmNHp/iecChfG0PGxVi8B2YyV1UZBlSFYF2VUFOVx3s8BOrk3THnFhBWnyNN9k049sYFMInsnzTNxb9F1kq3MKL9bKvWZTiCUBqQG6Eb63HaMJkahLS
 Lrax0u/same/iTQwNwPfB8Zi0robzmVntnN6rH6ELdtwoKope+0uAkRKy25bszzWROwUaozYT1QSVg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_X_SOURCE(0.00)[];
	TAGGED_FROM(0.00)[bounces-215634-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[re@w6rz.net,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[w6rz.net:-];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,w6rz.net:mid,w6rz.net:email,rivosinc.com:email]
X-Rspamd-Queue-Id: 3712C11951B
X-Rspamd-Action: no action

From: Björn Töpel <bjorn@rivosinc.com>

commit 121f34341d396b666d8a90b24768b40e08ca0d61 upstream.

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
index 23ff70350992..f42d73573f3c 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -22,11 +22,6 @@ static inline void flush_dcache_page(struct page *page)
 }
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 
-/*
- * RISC-V doesn't have an instruction to flush parts of the instruction cache,
- * so instead we just flush the whole thing.
- */
-#define flush_icache_range(start, end) flush_icache_all()
 #define flush_icache_user_page(vma, pg, addr, len) \
 	flush_icache_mm(vma->vm_mm, 0)
 
@@ -42,6 +37,16 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
 
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
 /*
  * Bits in sys_riscv_flush_icache()'s flags argument.
  */
-- 
2.43.0



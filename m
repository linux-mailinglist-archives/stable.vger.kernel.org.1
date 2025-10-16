Return-Path: <stable+bounces-186007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900FEBE3338
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A023E14E2
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834A531CA54;
	Thu, 16 Oct 2025 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql5hZC98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435502D320B
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615836; cv=none; b=G5HzEMmdvQHZu4X+Tpl45mkHk9bgRf0lWQX2WkNYrGuYaiRnwiSZnqIxczMJBYNPuRPE06HS3Te+ciY4O8tgJiHKS/RXeVWcXOSmdoy8ORaHE28zfGmDudmlzLVbTGQiLEhOriMho34Y8t5oczzSeqJfYikzW/mv4P2r2IO7YPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615836; c=relaxed/simple;
	bh=FHWF6s8/FT6uKQms5D3kFFlzon1Nut+1+2gvXEnCUQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOVUKntjTfh3ETjKTNthCaXdBkXWhdGmh8utMRKVUEKKSY6GutxmvZDSp4aQDuSUoNdwFHzS41m9h1fLHk2M2zqohFi4AFxgOAH724RXlM/u+ujRSpthFwWWAUkzpiUt6UrvvFMaP07wTCVl1nv1RZ9eE1oYXzkQOlXNrNFheIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql5hZC98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C7CC113D0;
	Thu, 16 Oct 2025 11:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760615835;
	bh=FHWF6s8/FT6uKQms5D3kFFlzon1Nut+1+2gvXEnCUQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ql5hZC98gp5NAgJR6HM1/r2Q9pDUjiJOpGbuqCfieHdok7VUjaM6c9w0CkZERIMxz
	 n1hSD0f276Vj+CiMUu8veq4+/AOEGCUZljHVJrKNDJxGKU6pJ5/rjq6gL7TQvE7Kwq
	 RwUlInZHUdiJs70rfvti/XSVy9tRMCQAPU7Hh13dW5DWpsfHJInlUCD/FsTDNE8MRy
	 yfspNb4rZKANofEaVaFzCCLB0cWYeum5lpABrJ3wBDBNi6HLSqqhm203spNnKLGRkU
	 O7/VI5wlEZLaw/skU5PBpRBdm/dWah/B5jfo1Wn82oakaRObXFxzQhmDg008jOILv6
	 5jEGroQyx4ZeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Varad Gautam <varadgautam@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] asm-generic/io.h: Skip trace helpers if rwmmio events are disabled
Date: Thu, 16 Oct 2025 07:57:09 -0400
Message-ID: <20251016115709.3259702-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016115709.3259702-1-sashal@kernel.org>
References: <2025101544-snoring-unseemly-47ff@gregkh>
 <20251016115709.3259702-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Varad Gautam <varadgautam@google.com>

[ Upstream commit 8327bd4fcb6c1dab01ce5c6ff00b42496836dcd2 ]

With `CONFIG_TRACE_MMIO_ACCESS=y`, the `{read,write}{b,w,l,q}{_relaxed}()`
mmio accessors unconditionally call `log_{post_}{read,write}_mmio()`
helpers, which in turn call the ftrace ops for `rwmmio` trace events

This adds a performance penalty per mmio accessor call, even when
`rwmmio` events are disabled at runtime (~80% overhead on local
measurement).

Guard these with `tracepoint_enabled()`.

Signed-off-by: Varad Gautam <varadgautam@google.com>
Fixes: 210031971cdd ("asm-generic/io: Add logging support for MMIO accessors")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/io.h | 98 +++++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 32 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 587e7e9b9a375..b5c5aa25bb8bf 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -74,6 +74,7 @@
 #if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MMIO__))
 #include <linux/tracepoint-defs.h>
 
+#define rwmmio_tracepoint_enabled(tracepoint) tracepoint_enabled(tracepoint)
 DECLARE_TRACEPOINT(rwmmio_write);
 DECLARE_TRACEPOINT(rwmmio_post_write);
 DECLARE_TRACEPOINT(rwmmio_read);
@@ -90,6 +91,7 @@ void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
 
 #else
 
+#define rwmmio_tracepoint_enabled(tracepoint) false
 static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
 				  unsigned long caller_addr, unsigned long caller_addr0) {}
 static inline void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
@@ -188,11 +190,13 @@ static inline u8 readb(const volatile void __iomem *addr)
 {
 	u8 val;
 
-	log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __raw_readb(addr);
 	__io_ar(val);
-	log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -203,11 +207,13 @@ static inline u16 readw(const volatile void __iomem *addr)
 {
 	u16 val;
 
-	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
 	__io_ar(val);
-	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -218,11 +224,13 @@ static inline u32 readl(const volatile void __iomem *addr)
 {
 	u32 val;
 
-	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
 	__io_ar(val);
-	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -234,11 +242,13 @@ static inline u64 readq(const volatile void __iomem *addr)
 {
 	u64 val;
 
-	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
 	__io_ar(val);
-	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -248,11 +258,13 @@ static inline u64 readq(const volatile void __iomem *addr)
 #define writeb writeb
 static inline void writeb(u8 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writeb(value, addr);
 	__io_aw();
-	log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -260,11 +272,13 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
 #define writew writew
 static inline void writew(u16 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writew((u16 __force)cpu_to_le16(value), addr);
 	__io_aw();
-	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -272,11 +286,13 @@ static inline void writew(u16 value, volatile void __iomem *addr)
 #define writel writel
 static inline void writel(u32 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
 	__io_aw();
-	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -285,11 +301,13 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 #define writeq writeq
 static inline void writeq(u64 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
 	__io_aw();
-	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 #endif /* CONFIG_64BIT */
@@ -305,9 +323,11 @@ static inline u8 readb_relaxed(const volatile void __iomem *addr)
 {
 	u8 val;
 
-	log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
 	val = __raw_readb(addr);
-	log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -318,9 +338,11 @@ static inline u16 readw_relaxed(const volatile void __iomem *addr)
 {
 	u16 val;
 
-	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
 	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
-	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -331,9 +353,11 @@ static inline u32 readl_relaxed(const volatile void __iomem *addr)
 {
 	u32 val;
 
-	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
 	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
-	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -344,9 +368,11 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 {
 	u64 val;
 
-	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_read))
+		log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
 	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
-	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_read))
+		log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -355,9 +381,11 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 #define writeb_relaxed writeb_relaxed
 static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 	__raw_writeb(value, addr);
-	log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -365,9 +393,11 @@ static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 #define writew_relaxed writew_relaxed
 static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 	__raw_writew((u16 __force)cpu_to_le16(value), addr);
-	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -375,9 +405,11 @@ static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 #define writel_relaxed writel_relaxed
 static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
-	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -385,9 +417,11 @@ static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 #define writeq_relaxed writeq_relaxed
 static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_write))
+		log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
-	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
+	if (rwmmio_tracepoint_enabled(rwmmio_post_write))
+		log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
-- 
2.51.0



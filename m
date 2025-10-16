Return-Path: <stable+bounces-186005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1BEBE3332
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58AB44EA5A9
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDA631B12D;
	Thu, 16 Oct 2025 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E05hwqCM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC22D320B
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615833; cv=none; b=AaA9qyMpQA/r7+uvT0DRyzVPvCWdK4Ra+zb0l/nNlelvd1YyJCGHUy6VWL0v/GUgPdYD1U7XfsmkpcdnK3Md6084xld47i6wk9HKsKENpHN8N9/yNR1Ut8TmheASyrwmIfvCMcTaKlxklR9INrkjnMDfg4SE8q3V3AJSm3TTKJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615833; c=relaxed/simple;
	bh=+9Lct34HAzNb5CWVqjQTI7kA195G5vD/tzvh7h79Gdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2APRQ3m4VCv6uSbfaCZWiRYmkGhgJ3gUQarg80ut26HDVpLSf6dOEL27q42Plkb/VyUzOJz2ccmMxLVipniQ0HVIEGmcY6JFTM7OSf1sLqT6H7ngaJTgUZAxuYMS/ocA5HbgbEm3Ov84Tkk+vr3DZyt73Y4owT45V1b+XnPpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E05hwqCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AE8C4CEF1;
	Thu, 16 Oct 2025 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760615833;
	bh=+9Lct34HAzNb5CWVqjQTI7kA195G5vD/tzvh7h79Gdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E05hwqCM0WaI36V/BNo6uXKGLorMHs36od17GatXuDoy+pE8PRrx7yaEU9fqykYYJ
	 qWHkx9Xf0Bt983QOoQDmmT40z+RDqS8oCkgE60UwLW1pJagbEIZN5EopkdkhIpwy4C
	 H7P5rqoItot1sUT2pwzEti7oNpcxgPsOuW5OtK+/i5wMk5x/QkWcxjdfDfhjIu9iSV
	 GdceREi8jVjIORKhp0WP058YoEbFiUTniW9FemURhWRiWwmj4v/K5qvFvHKA2jJn7O
	 fqYOC4ie3RR7lgtqp5E54uxGCdc7s/nh4funKTSl6AEjQoWTgcstGUSzCQNvF1Ycvz
	 bcA5xMrnobKTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] asm-generic/io: Add _RET_IP_ to MMIO trace for more accurate debug info
Date: Thu, 16 Oct 2025 07:57:07 -0400
Message-ID: <20251016115709.3259702-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101544-snoring-unseemly-47ff@gregkh>
References: <2025101544-snoring-unseemly-47ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sai Prakash Ranjan <quic_saipraka@quicinc.com>

[ Upstream commit 5e5ff73c2e5863f93fc5fd78d178cd8f2af12464 ]

Due to compiler optimizations like inlining, there are cases where
MMIO traces using _THIS_IP_ for caller information might not be
sufficient to provide accurate debug traces.

1) With optimizations (Seen with GCC):

In this case, _THIS_IP_ works fine and prints the caller information
since it will be inlined into the caller and we get the debug traces
on who made the MMIO access, for ex:

rwmmio_read: qcom_smmu_tlb_sync+0xe0/0x1b0 width=32 addr=0xffff8000087447f4
rwmmio_post_read: qcom_smmu_tlb_sync+0xe0/0x1b0 width=32 val=0x0 addr=0xffff8000087447f4

2) Without optimizations (Seen with Clang):

_THIS_IP_ will not be sufficient in this case as it will print only
the MMIO accessors itself which is of not much use since it is not
inlined as below for example:

rwmmio_read: readl+0x4/0x80 width=32 addr=0xffff8000087447f4
rwmmio_post_read: readl+0x48/0x80 width=32 val=0x4 addr=0xffff8000087447f4

So in order to handle this second case as well irrespective of the compiler
optimizations, add _RET_IP_ to MMIO trace to make it provide more accurate
debug information in all these scenarios.

Before:

rwmmio_read: readl+0x4/0x80 width=32 addr=0xffff8000087447f4
rwmmio_post_read: readl+0x48/0x80 width=32 val=0x4 addr=0xffff8000087447f4

After:

rwmmio_read: qcom_smmu_tlb_sync+0xe0/0x1b0 -> readl+0x4/0x80 width=32 addr=0xffff8000087447f4
rwmmio_post_read: qcom_smmu_tlb_sync+0xe0/0x1b0 -> readl+0x4/0x80 width=32 val=0x0 addr=0xffff8000087447f4

Fixes: 210031971cdd ("asm-generic/io: Add logging support for MMIO accessors")
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Stable-dep-of: 8327bd4fcb6c ("asm-generic/io.h: Skip trace helpers if rwmmio events are disabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/io.h      | 80 +++++++++++++++++------------------
 include/trace/events/rwmmio.h | 43 ++++++++++++-------
 lib/trace_readwrite.c         | 16 +++----
 3 files changed, 75 insertions(+), 64 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index cde032f86856e..d78c3056c98f9 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -80,24 +80,24 @@ DECLARE_TRACEPOINT(rwmmio_read);
 DECLARE_TRACEPOINT(rwmmio_post_read);
 
 void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-		    unsigned long caller_addr);
+		    unsigned long caller_addr, unsigned long caller_addr0);
 void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-			 unsigned long caller_addr);
+			 unsigned long caller_addr, unsigned long caller_addr0);
 void log_read_mmio(u8 width, const volatile void __iomem *addr,
-		   unsigned long caller_addr);
+		   unsigned long caller_addr, unsigned long caller_addr0);
 void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
-			unsigned long caller_addr);
+			unsigned long caller_addr, unsigned long caller_addr0);
 
 #else
 
 static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-				  unsigned long caller_addr) {}
+				  unsigned long caller_addr, unsigned long caller_addr0) {}
 static inline void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-				       unsigned long caller_addr) {}
+				       unsigned long caller_addr, unsigned long caller_addr0) {}
 static inline void log_read_mmio(u8 width, const volatile void __iomem *addr,
-				 unsigned long caller_addr) {}
+				 unsigned long caller_addr, unsigned long caller_addr0) {}
 static inline void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
-				      unsigned long caller_addr) {}
+				      unsigned long caller_addr, unsigned long caller_addr0) {}
 
 #endif /* CONFIG_TRACE_MMIO_ACCESS */
 
@@ -188,11 +188,11 @@ static inline u8 readb(const volatile void __iomem *addr)
 {
 	u8 val;
 
-	log_read_mmio(8, addr, _THIS_IP_);
+	log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __raw_readb(addr);
 	__io_ar(val);
-	log_post_read_mmio(val, 8, addr, _THIS_IP_);
+	log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -203,11 +203,11 @@ static inline u16 readw(const volatile void __iomem *addr)
 {
 	u16 val;
 
-	log_read_mmio(16, addr, _THIS_IP_);
+	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
 	__io_ar(val);
-	log_post_read_mmio(val, 16, addr, _THIS_IP_);
+	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -218,11 +218,11 @@ static inline u32 readl(const volatile void __iomem *addr)
 {
 	u32 val;
 
-	log_read_mmio(32, addr, _THIS_IP_);
+	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
 	__io_ar(val);
-	log_post_read_mmio(val, 32, addr, _THIS_IP_);
+	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -234,11 +234,11 @@ static inline u64 readq(const volatile void __iomem *addr)
 {
 	u64 val;
 
-	log_read_mmio(64, addr, _THIS_IP_);
+	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
 	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
 	__io_ar(val);
-	log_post_read_mmio(val, 64, addr, _THIS_IP_);
+	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -248,11 +248,11 @@ static inline u64 readq(const volatile void __iomem *addr)
 #define writeb writeb
 static inline void writeb(u8 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 8, addr, _THIS_IP_);
+	log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writeb(value, addr);
 	__io_aw();
-	log_post_write_mmio(value, 8, addr, _THIS_IP_);
+	log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -260,11 +260,11 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
 #define writew writew
 static inline void writew(u16 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 16, addr, _THIS_IP_);
+	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writew((u16 __force)cpu_to_le16(value), addr);
 	__io_aw();
-	log_post_write_mmio(value, 16, addr, _THIS_IP_);
+	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -272,11 +272,11 @@ static inline void writew(u16 value, volatile void __iomem *addr)
 #define writel writel
 static inline void writel(u32 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 32, addr, _THIS_IP_);
+	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
 	__io_aw();
-	log_post_write_mmio(value, 32, addr, _THIS_IP_);
+	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -285,11 +285,11 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 #define writeq writeq
 static inline void writeq(u64 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 64, addr, _THIS_IP_);
+	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
 	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
 	__io_aw();
-	log_post_write_mmio(value, 64, addr, _THIS_IP_);
+	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 #endif /* CONFIG_64BIT */
@@ -305,9 +305,9 @@ static inline u8 readb_relaxed(const volatile void __iomem *addr)
 {
 	u8 val;
 
-	log_read_mmio(8, addr, _THIS_IP_);
+	log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
 	val = __raw_readb(addr);
-	log_post_read_mmio(val, 8, addr, _THIS_IP_);
+	log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -318,9 +318,9 @@ static inline u16 readw_relaxed(const volatile void __iomem *addr)
 {
 	u16 val;
 
-	log_read_mmio(16, addr, _THIS_IP_);
+	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
 	val = __le16_to_cpu(__raw_readw(addr));
-	log_post_read_mmio(val, 16, addr, _THIS_IP_);
+	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -331,9 +331,9 @@ static inline u32 readl_relaxed(const volatile void __iomem *addr)
 {
 	u32 val;
 
-	log_read_mmio(32, addr, _THIS_IP_);
+	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
 	val = __le32_to_cpu(__raw_readl(addr));
-	log_post_read_mmio(val, 32, addr, _THIS_IP_);
+	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -344,9 +344,9 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 {
 	u64 val;
 
-	log_read_mmio(64, addr, _THIS_IP_);
+	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
 	val = __le64_to_cpu(__raw_readq(addr));
-	log_post_read_mmio(val, 64, addr, _THIS_IP_);
+	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
 #endif
@@ -355,9 +355,9 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 #define writeb_relaxed writeb_relaxed
 static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 8, addr, _THIS_IP_);
+	log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 	__raw_writeb(value, addr);
-	log_post_write_mmio(value, 8, addr, _THIS_IP_);
+	log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -365,9 +365,9 @@ static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 #define writew_relaxed writew_relaxed
 static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 16, addr, _THIS_IP_);
+	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 	__raw_writew(cpu_to_le16(value), addr);
-	log_post_write_mmio(value, 16, addr, _THIS_IP_);
+	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -375,9 +375,9 @@ static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 #define writel_relaxed writel_relaxed
 static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 32, addr, _THIS_IP_);
+	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 	__raw_writel(__cpu_to_le32(value), addr);
-	log_post_write_mmio(value, 32, addr, _THIS_IP_);
+	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
@@ -385,9 +385,9 @@ static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 #define writeq_relaxed writeq_relaxed
 static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
 {
-	log_write_mmio(value, 64, addr, _THIS_IP_);
+	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 	__raw_writeq(__cpu_to_le64(value), addr);
-	log_post_write_mmio(value, 64, addr, _THIS_IP_);
+	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
 
diff --git a/include/trace/events/rwmmio.h b/include/trace/events/rwmmio.h
index de41159216c19..a43e5dd7436b5 100644
--- a/include/trace/events/rwmmio.h
+++ b/include/trace/events/rwmmio.h
@@ -12,12 +12,14 @@
 
 DECLARE_EVENT_CLASS(rwmmio_rw_template,
 
-	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
+	TP_PROTO(unsigned long caller, unsigned long caller0, u64 val, u8 width,
+		 volatile void __iomem *addr),
 
-	TP_ARGS(caller, val, width, addr),
+	TP_ARGS(caller, caller0, val, width, addr),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, caller)
+		__field(unsigned long, caller0)
 		__field(unsigned long, addr)
 		__field(u64, val)
 		__field(u8, width)
@@ -25,56 +27,64 @@ DECLARE_EVENT_CLASS(rwmmio_rw_template,
 
 	TP_fast_assign(
 		__entry->caller = caller;
+		__entry->caller0 = caller0;
 		__entry->val = val;
 		__entry->addr = (unsigned long)addr;
 		__entry->width = width;
 	),
 
-	TP_printk("%pS width=%d val=%#llx addr=%#lx",
-		(void *)__entry->caller, __entry->width,
+	TP_printk("%pS -> %pS width=%d val=%#llx addr=%#lx",
+		(void *)__entry->caller0, (void *)__entry->caller, __entry->width,
 		__entry->val, __entry->addr)
 );
 
 DEFINE_EVENT(rwmmio_rw_template, rwmmio_write,
-	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
-	TP_ARGS(caller, val, width, addr)
+	TP_PROTO(unsigned long caller, unsigned long caller0, u64 val, u8 width,
+		 volatile void __iomem *addr),
+	TP_ARGS(caller, caller0, val, width, addr)
 );
 
 DEFINE_EVENT(rwmmio_rw_template, rwmmio_post_write,
-	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
-	TP_ARGS(caller, val, width, addr)
+	TP_PROTO(unsigned long caller, unsigned long caller0, u64 val, u8 width,
+		 volatile void __iomem *addr),
+	TP_ARGS(caller, caller0, val, width, addr)
 );
 
 TRACE_EVENT(rwmmio_read,
 
-	TP_PROTO(unsigned long caller, u8 width, const volatile void __iomem *addr),
+	TP_PROTO(unsigned long caller, unsigned long caller0, u8 width,
+		 const volatile void __iomem *addr),
 
-	TP_ARGS(caller, width, addr),
+	TP_ARGS(caller, caller0, width, addr),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, caller)
+		__field(unsigned long, caller0)
 		__field(unsigned long, addr)
 		__field(u8, width)
 	),
 
 	TP_fast_assign(
 		__entry->caller = caller;
+		__entry->caller0 = caller0;
 		__entry->addr = (unsigned long)addr;
 		__entry->width = width;
 	),
 
-	TP_printk("%pS width=%d addr=%#lx",
-		 (void *)__entry->caller, __entry->width, __entry->addr)
+	TP_printk("%pS -> %pS width=%d addr=%#lx",
+		 (void *)__entry->caller0, (void *)__entry->caller, __entry->width, __entry->addr)
 );
 
 TRACE_EVENT(rwmmio_post_read,
 
-	TP_PROTO(unsigned long caller, u64 val, u8 width, const volatile void __iomem *addr),
+	TP_PROTO(unsigned long caller, unsigned long caller0, u64 val, u8 width,
+		 const volatile void __iomem *addr),
 
-	TP_ARGS(caller, val, width, addr),
+	TP_ARGS(caller, caller0, val, width, addr),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, caller)
+		__field(unsigned long, caller0)
 		__field(unsigned long, addr)
 		__field(u64, val)
 		__field(u8, width)
@@ -82,13 +92,14 @@ TRACE_EVENT(rwmmio_post_read,
 
 	TP_fast_assign(
 		__entry->caller = caller;
+		__entry->caller0 = caller0;
 		__entry->val = val;
 		__entry->addr = (unsigned long)addr;
 		__entry->width = width;
 	),
 
-	TP_printk("%pS width=%d val=%#llx addr=%#lx",
-		 (void *)__entry->caller, __entry->width,
+	TP_printk("%pS -> %pS width=%d val=%#llx addr=%#lx",
+		 (void *)__entry->caller0, (void *)__entry->caller, __entry->width,
 		 __entry->val, __entry->addr)
 );
 
diff --git a/lib/trace_readwrite.c b/lib/trace_readwrite.c
index 88637038b30c8..62b4e8b3c733b 100644
--- a/lib/trace_readwrite.c
+++ b/lib/trace_readwrite.c
@@ -14,33 +14,33 @@
 
 #ifdef CONFIG_TRACE_MMIO_ACCESS
 void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-		    unsigned long caller_addr)
+		    unsigned long caller_addr, unsigned long caller_addr0)
 {
-	trace_rwmmio_write(caller_addr, val, width, addr);
+	trace_rwmmio_write(caller_addr, caller_addr0, val, width, addr);
 }
 EXPORT_SYMBOL_GPL(log_write_mmio);
 EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_write);
 
 void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
-			 unsigned long caller_addr)
+			 unsigned long caller_addr, unsigned long caller_addr0)
 {
-	trace_rwmmio_post_write(caller_addr, val, width, addr);
+	trace_rwmmio_post_write(caller_addr, caller_addr0, val, width, addr);
 }
 EXPORT_SYMBOL_GPL(log_post_write_mmio);
 EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_post_write);
 
 void log_read_mmio(u8 width, const volatile void __iomem *addr,
-		   unsigned long caller_addr)
+		   unsigned long caller_addr, unsigned long caller_addr0)
 {
-	trace_rwmmio_read(caller_addr, width, addr);
+	trace_rwmmio_read(caller_addr, caller_addr0, width, addr);
 }
 EXPORT_SYMBOL_GPL(log_read_mmio);
 EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_read);
 
 void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
-			unsigned long caller_addr)
+			unsigned long caller_addr, unsigned long caller_addr0)
 {
-	trace_rwmmio_post_read(caller_addr, val, width, addr);
+	trace_rwmmio_post_read(caller_addr, caller_addr0, val, width, addr);
 }
 EXPORT_SYMBOL_GPL(log_post_read_mmio);
 EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_post_read);
-- 
2.51.0



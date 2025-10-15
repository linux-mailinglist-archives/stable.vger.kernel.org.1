Return-Path: <stable+bounces-185799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AB7BDE2E1
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F20E64E034D
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FD9265606;
	Wed, 15 Oct 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aPPbvoXm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA001CD15
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526167; cv=none; b=H5xdm/Z0fh6XILJtDWbhBvTGJHm5JUgHgcZIRURlqtFwCceaMc5JZmaQo9gyJqzqgQGhM8/dqFw+se7sPR7dwC+gFOfy3dbWh8/7M0X+76kR9K1qdEvS0y9hBnMCRmLfrQAPXzr9e0NtKO6wu1IyWUQ3nUSi8WNS9Oc3gWs9sw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526167; c=relaxed/simple;
	bh=uLugqKq9jqEemkb9ZADZk+yBeM+E2451pSg+uZKc71w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jiS91wPac2R/aa1f8lCOE7s5l4yBuvoDewDLAtTyd0oqn/zEaxHoWa6PY77y2ozlpJVe7SpOxMG5boPEvgPDLrhxslwXv8sI/sBDx1B97gKA+jAF+4hovqqsJvlV2Cuf3rTQsDfbb0qZuKIIKBzEDMCKMrAgGtc/YPDFc3UrWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aPPbvoXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2D8C4CEF8;
	Wed, 15 Oct 2025 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760526167;
	bh=uLugqKq9jqEemkb9ZADZk+yBeM+E2451pSg+uZKc71w=;
	h=Subject:To:Cc:From:Date:From;
	b=aPPbvoXmGYYgX/90sBkp6rvo7aS+JsB1ZQw4podPqYVGKXE3G+J3UEehtFtl4rmWG
	 V+xE7/UoO39I/h0S6qNTu/64ipkF0lcmV4lRA0ODTvVdK5T05tmKMKZK7TL+XvpMeJ
	 z/Hz5GbVkKpbN+Zrp+RCVpOch7XOpv/RQQI/b+lg=
Subject: FAILED: patch "[PATCH] asm-generic/io.h: Skip trace helpers if rwmmio events are" failed to apply to 6.1-stable tree
To: varadgautam@google.com,arnd@arndb.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Oct 2025 13:02:44 +0200
Message-ID: <2025101544-snoring-unseemly-47ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8327bd4fcb6c1dab01ce5c6ff00b42496836dcd2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101544-snoring-unseemly-47ff@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8327bd4fcb6c1dab01ce5c6ff00b42496836dcd2 Mon Sep 17 00:00:00 2001
From: Varad Gautam <varadgautam@google.com>
Date: Sun, 30 Mar 2025 16:42:29 +0000
Subject: [PATCH] asm-generic/io.h: Skip trace helpers if rwmmio events are
 disabled

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

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 11abad6c87e1..ca5a1ce6f0f8 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -75,6 +75,7 @@
 #if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MMIO__))
 #include <linux/tracepoint-defs.h>
 
+#define rwmmio_tracepoint_enabled(tracepoint) tracepoint_enabled(tracepoint)
 DECLARE_TRACEPOINT(rwmmio_write);
 DECLARE_TRACEPOINT(rwmmio_post_write);
 DECLARE_TRACEPOINT(rwmmio_read);
@@ -91,6 +92,7 @@ void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
 
 #else
 
+#define rwmmio_tracepoint_enabled(tracepoint) false
 static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
 				  unsigned long caller_addr, unsigned long caller_addr0) {}
 static inline void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
@@ -189,11 +191,13 @@ static inline u8 readb(const volatile void __iomem *addr)
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
@@ -204,11 +208,13 @@ static inline u16 readw(const volatile void __iomem *addr)
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
@@ -219,11 +225,13 @@ static inline u32 readl(const volatile void __iomem *addr)
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
@@ -235,11 +243,13 @@ static inline u64 readq(const volatile void __iomem *addr)
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
@@ -249,11 +259,13 @@ static inline u64 readq(const volatile void __iomem *addr)
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
 
@@ -261,11 +273,13 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
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
 
@@ -273,11 +287,13 @@ static inline void writew(u16 value, volatile void __iomem *addr)
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
 
@@ -286,11 +302,13 @@ static inline void writel(u32 value, volatile void __iomem *addr)
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
@@ -306,9 +324,11 @@ static inline u8 readb_relaxed(const volatile void __iomem *addr)
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
@@ -319,9 +339,11 @@ static inline u16 readw_relaxed(const volatile void __iomem *addr)
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
@@ -332,9 +354,11 @@ static inline u32 readl_relaxed(const volatile void __iomem *addr)
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
@@ -345,9 +369,11 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
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
@@ -356,9 +382,11 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
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
 
@@ -366,9 +394,11 @@ static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
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
 
@@ -376,9 +406,11 @@ static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
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
 
@@ -386,9 +418,11 @@ static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
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
 



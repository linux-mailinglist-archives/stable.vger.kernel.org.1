Return-Path: <stable+bounces-127022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03E1A75B02
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 18:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0A73A662F
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 16:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD891D95A9;
	Sun, 30 Mar 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Co8gB9Ov"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE181D79B8
	for <stable@vger.kernel.org>; Sun, 30 Mar 2025 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743352981; cv=none; b=fbr1Qj1U9qv0oi7eIIKANaFlM7YP2P8pYAznQj9X5WTlUp83noFvqtn8Qf7pRXKjaj8LlwbD0zkIrdHVBzsTc/QiW6UynYJrHZwxUsEMttfzOinQ4F1s74g9PHGtBXM69bFAE2smBHKnuecnVLlUoEc+QIPj5gm6vwWEXacxwq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743352981; c=relaxed/simple;
	bh=slPFaGckddE2DCMg2LYYoOVtr3L7yY3dnO7oMTazch0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LFfW7gPCNsFq2AwG2q4q0gmQE6ViRexNYegYR1zivITovL68/rfizAulivifjnT6TgihVx/m8XCOkPYQ/Ky9VY9/OkzKRiXe3CgxYVHGZzzlVHXk74wpUHnCcitUqwD8RfO22ofWbAIALZ31+eh+cH8wM74x0O2gxnmo9OlqIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--varadgautam.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Co8gB9Ov; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--varadgautam.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5e6136633b1so2991663a12.0
        for <stable@vger.kernel.org>; Sun, 30 Mar 2025 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743352978; x=1743957778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8VOw4BnGc7xbj9oV5lFLU1iUMY/Pt0vOsWqENzlXcbk=;
        b=Co8gB9OvMb2IsRiUQ/gaax0XIl1QXqXr31qNZP/8w3tezVeL0MZsFfdLhxLYHLgQt2
         fsTa5NsKBDjB4cSDoluIz095JWgcnAhEpTl1BLdDxgQhEp290qS0Mls9xGE4oUKp6tdx
         NU3NiBaI1Yl4mcv3owKca3ffkSYx8nis98+NMMa/buBTxpBCRbftBBN+mjQBn9Ltpon6
         Xej7+O3f8Yi7GjZu5ZrgmN5YL+YYushDM1WcixKPTZzvX/NaN2+uyfIBOG0k3/m7bEVo
         7iteXb9B3uXARDyyHiaROTjlr27NRxAGJLb3wBZxQxWcTtHfbylajEl2EeNNNmp6yRwf
         4UJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743352978; x=1743957778;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8VOw4BnGc7xbj9oV5lFLU1iUMY/Pt0vOsWqENzlXcbk=;
        b=A0WtarrFld3ly2mKlHf984phMTU/LsxZad/Ni8oPOBeW1vZXq/vkqF1QYS9n6vC8Bs
         JwIRI4adww60cu6bzyulLoOmkqus1CExxjKKdmbGs3vleUqXFPffUmvepL0wMqviPmQp
         +mX0iE7FozfwLXbc/e56+bbgGdmX3wqowz7Y4JOkp/KHaQMJYbsC2wMNfzqrX9Ln6mPO
         k0gN09GpwmLO50SAZsaFbptx5epxgM7LYhUv2LJfHNVTE4+fZ651qL+zEz+/yhNzVKUO
         6v4ei2FctQyol9+p77N89Z2eZX4CY+A/RN0dlzgD9jVVHebNGerm/vvlohaQKC885RCD
         K8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfFRoXkwSAaV1jn73cB2ra8dSETCVgiNBgFt1jDGJAg91aTuYGC6qkTWBI/9ALh4eDAhwavfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuB7bZ5Wqy6zX+PPP/NbMC22zfNrDMQWE9t8i8dQNmvae7xEdC
	YSzYbVQo4qKFHf1jZdQ+1McIyNWa3z76dmuSrvEJ+zCYZEZngEWyqF52UuBYcGNnjqyNviFbzgf
	K9gkaQz5Yg4zHVMffoM0JQg==
X-Google-Smtp-Source: AGHT+IF7boLCd9mSSf0V/oJnLTSOKbBDiPIKmsbS2PojB7xKclgvZGcjYldvGKGL9TF90xl87kwVtSrRAa/b4fvjSA==
X-Received: from ediv3.prod.google.com ([2002:a50:d583:0:b0:5e4:d4fc:483c])
 (user=varadgautam job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:50c7:b0:5dc:c9ce:b01b with SMTP id 4fb4d7f45d1cf-5edfceae54cmr4684493a12.8.1743352977764;
 Sun, 30 Mar 2025 09:42:57 -0700 (PDT)
Date: Sun, 30 Mar 2025 16:42:29 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250330164229.2174672-1-varadgautam@google.com>
Subject: [PATCH] asm-generic/io.h: Skip trace helpers if rwmmio events are disabled
From: Varad Gautam <varadgautam@google.com>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Sai Prakash Ranjan <quic_saipraka@quicinc.com>, 
	linux-kernel@vger.kernel.org, Varad Gautam <varadgautam@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With `CONFIG_TRACE_MMIO_ACCESS=y`, the `{read,write}{b,w,l,q}{_relaxed}()`
mmio accessors unconditionally call `log_{post_}{read,write}_mmio()`
helpers, which in turn call the ftrace ops for `rwmmio` trace events

This adds a performance penalty per mmio accessor call, even when
`rwmmio` events are disabled at runtime (~80% overhead on local
measurement).

Guard these with `tracepoint_enabled()`.

Signed-off-by: Varad Gautam <varadgautam@google.com>
Fixes: 210031971cdd ("asm-generic/io: Add logging support for MMIO accessors")
Cc: <stable@vger.kernel.org>
---
 include/asm-generic/io.h | 98 +++++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 32 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 3c61c29ff6ab..a9b5da547523 100644
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
 
-- 
2.49.0.472.ge94155a9ec-goog



Return-Path: <stable+bounces-172508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC7AB322E8
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 21:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B75B06D43
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B0A2C0297;
	Fri, 22 Aug 2025 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHb7CN2Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655C4A1A
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891306; cv=none; b=P2kLbT6zYEzQjZNhIarOsCiwTujiMtwBJNSIeCxH2jmUwdjK2ob5svAXiEO3oRgX9sMAn4VLv2k2BhMTteoZm8+yzU3k0/Dde+rD5v3vXsbNRN/BwcroamwzLWov3fa+hcHsoQgRBQ2y/hBdm0v/3EIbaezLEOk8KKZIPJOqIIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891306; c=relaxed/simple;
	bh=2Cs4kSd1rbsZdIXL+evRJjDMriuwhprDgofSILXGTXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjuLdiq2c3KoZpZR+cT8Pd5P+IuNLbkvQC/ddvC/gwq4oJoWFsdntYbbGHsxESVowVk4EfgOtKJCSGzhCGHhMiLmZhxFVxC1Sz2ucwrXmlBvn5/IUgORPEf3vgcNGWWqDcvCrbN2Ezi+CY74HTaRRXFbOXKJ8R2taXzZvWWYLqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHb7CN2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769E9C4CEED;
	Fri, 22 Aug 2025 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755891304;
	bh=2Cs4kSd1rbsZdIXL+evRJjDMriuwhprDgofSILXGTXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vHb7CN2YMZxRir6y3cxwfSxzVJ97gjUbR6Gus9zaDpvyWLZIdsqXWLJuSWTXjEVTb
	 Xjz8+RnWKfdnY+TDBTb6U51DZbafdfupMDSbuGaYWn2+AZZ/JkZBICaXxh8iWwOVmz
	 9YZg20Jqnez4mKUM4bKc8TrTAnzgMxnpUTG1pZslC3Zktxb24OtfAQWwjrbPKZiPM3
	 RGn+CF2aYkOzjnYOOdKYGMGuid7xpkeopWWmilyyfXqSziWtsRe2kcK+TN77JszBbO
	 Nj8t4+5CPSdqIPTkTQMhQXz7hQL8/TlpTBaRxjqEZy1y6NzPFCpXJaNXiFCXqKkCDR
	 qppm+b7PhfFOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] locking/barriers, kcsan: Support generic instrumentation
Date: Fri, 22 Aug 2025 15:35:00 -0400
Message-ID: <20250822193502.1445377-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082143-halved-suitably-b32b@gregkh>
References: <2025082143-halved-suitably-b32b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Elver <elver@google.com>

[ Upstream commit 2505a51ac6f249956735e0a369e2404f96eebef0 ]

Thus far only smp_*() barriers had been defined by asm-generic/barrier.h
based on __smp_*() barriers, because the !SMP case is usually generic.

With the introduction of instrumentation, it also makes sense to have
asm-generic/barrier.h assist in the definition of instrumented versions
of mb(), rmb(), wmb(), dma_rmb(), and dma_wmb().

Because there is no requirement to distinguish the !SMP case, the
definition can be simpler: we can avoid also providing fallbacks for the
__ prefixed cases, and only check if `defined(__<barrier>)`, to finally
define the KCSAN-instrumented versions.

This also allows for the compiler to complain if an architecture
accidentally defines both the normal and __ prefixed variant.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Stable-dep-of: aa6956150f82 ("wifi: ath11k: fix dest ring-buffer corruption when ring is full")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/barrier.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 640f09479bdf..05aae2922485 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -20,6 +20,31 @@
 #define nop()	asm volatile ("nop")
 #endif
 
+/*
+ * Architectures that want generic instrumentation can define __ prefixed
+ * variants of all barriers.
+ */
+
+#ifdef __mb
+#define mb()	do { kcsan_mb(); __mb(); } while (0)
+#endif
+
+#ifdef __rmb
+#define rmb()	do { kcsan_rmb(); __rmb(); } while (0)
+#endif
+
+#ifdef __wmb
+#define wmb()	do { kcsan_wmb(); __wmb(); } while (0)
+#endif
+
+#ifdef __dma_rmb
+#define dma_rmb()	do { kcsan_rmb(); __dma_rmb(); } while (0)
+#endif
+
+#ifdef __dma_wmb
+#define dma_wmb()	do { kcsan_wmb(); __dma_wmb(); } while (0)
+#endif
+
 /*
  * Force strict CPU ordering. And yes, this is required on UP too when we're
  * talking to devices.
-- 
2.50.1



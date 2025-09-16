Return-Path: <stable+bounces-179753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2D4B5A3CF
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 23:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4001BC8403
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 21:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913B12D9EE5;
	Tue, 16 Sep 2025 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="SmzCuHWw"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76EF2582;
	Tue, 16 Sep 2025 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.143.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057815; cv=none; b=BdjkQvAvPQzE7NLzycDGv49NGgvHEm8VdOXV4394GOnt/E2H63/8X10+BRNRNGv7Qh8wIGgh9KpNiP4HDjmd5Z0+m9OwJUp9wA0KhF4RrKM7Ow/ZLW7RilF8j6y2Dom00Ds4UklT+Ns9+UyLlF6B9wvsZZ7dUr02PbVB4TI9PCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057815; c=relaxed/simple;
	bh=5XR/Nu7YN6Mb0hln5K8aUCoScT/acOCPiKkGyc9xAGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKKmogrTfTBv3mX5WiX6SI+J4fQfKrOG3r8bSQLyRD2+aPPpZX9JaAYDmGb0rZLO3OYv6YQ4lmoJNeDhWq+Kb+wDbVfVXQd3r/5jwV0XweBc0YZ0DEMJfLpW4qb9lFUdJFT197Y4BATd/+21VwUEQFlzDvLomtQby1+3gBnNlQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=SmzCuHWw; arc=none smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758057813; x=1789593813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3kgm8GxYEPdMjTswKbqKIM4NTuUgeLbOvcH9Wo5RG/8=;
  b=SmzCuHWwBfLFTtjMm/u6pb4TvZXZ1N1jKy9lXFYWs+mzVhA/zymelc8S
   GqIVsn0ANJ24AC1YbZLTyQpzMbtmfHpBcZjWaP/ZgSjHojXyh/AHPfGZg
   okAdaIMYMVrmY8DC8Q45JZInARQ5Exw7zv5oPN1azgDtJRohRzRj7RIRi
   AwekJgrdWBq7KXwbzfC5X4hGpRnuh0zIj+jBqSSYMXPRjCU7c3/TtbVzd
   sW6EY13Ur92VkvJDknbm0Wzdic6fobnh2aoV3h9XsTe01qo5mb5ONBwOl
   Wpl69bMqydrVQqYnYbwrxQcjerljCyUbb2BuS1GpTdfGc9tfvDBSWCGS6
   Q==;
X-CSE-ConnectionGUID: +DMxqd5qQkiCxbzxF5IjqQ==
X-CSE-MsgGUID: STNCBFudQY+K7/nihwt2TQ==
X-IronPort-AV: E=Sophos;i="6.18,270,1751241600"; 
   d="scan'208";a="2106538"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 21:23:23 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:23013]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.21.238:2525] with esmtp (Farcaster)
 id 63959fd0-27a5-43aa-8cc2-e0bb2692163b; Tue, 16 Sep 2025 21:23:22 +0000 (UTC)
X-Farcaster-Flow-ID: 63959fd0-27a5-43aa-8cc2-e0bb2692163b
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 21:23:22 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 16 Sep 2025
 21:23:17 +0000
From: Eliav Farber <farbere@amazon.com>
To: <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <mingo@redhat.com>,
	<akpm@linux-foundation.org>, <gregkh@linuxfoundation.org>, <sj@kernel.org>,
	<David.Laight@ACULAB.COM>, <Jason@zx2c4.com>,
	<andriy.shevchenko@linux.intel.com>, <bvanassche@acm.org>,
	<keescook@chromium.org>, <linux-sparse@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jonnyc@amazon.com>, <farbere@amazon.com>, <stable@vger.kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/7 5.10.y] tracing: Define the is_signed_type() macro once
Date: Tue, 16 Sep 2025 21:22:53 +0000
Message-ID: <20250916212259.48517-2-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916212259.48517-1-farbere@amazon.com>
References: <20250916212259.48517-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: Bart Van Assche <bvanassche@acm.org>

commit 92d23c6e94157739b997cacce151586a0d07bb8a upstream.

There are two definitions of the is_signed_type() macro: one in
<linux/overflow.h> and a second definition in <linux/trace_events.h>.

As suggested by Linus, move the definition of the is_signed_type() macro
into the <linux/compiler.h> header file.  Change the definition of the
is_signed_type() macro to make sure that it does not trigger any sparse
warnings with future versions of sparse for bitwise types.

Link: https://lore.kernel.org/all/CAHk-=whjH6p+qzwUdx5SOVVHjS3WvzJQr6mDUwhEyTf6pJWzaQ@mail.gmail.com/
Link: https://lore.kernel.org/all/CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com/
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit a49a64b5bf195381c09202c524f0f84b5f3e816f)
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/compiler.h     | 6 ++++++
 include/linux/overflow.h     | 1 -
 include/linux/trace_events.h | 2 --
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index bbd74420fa21..004a030d5ad2 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -245,6 +245,12 @@ static inline void *offset_to_ptr(const int *off)
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
+/*
+ * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
+ * bool and also pointer types.
+ */
+#define is_signed_type(type) (((type)(-1)) < (__force type)1)
+
 /*
  * This is needed in functions which generate the stack canary, see
  * arch/x86/kernel/smpboot.c::start_secondary() for an example.
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 35af574d006f..66dd311ad8eb 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -32,7 +32,6 @@
  * https://mail-index.netbsd.org/tech-misc/2007/02/05/0000.html -
  * credit to Christian Biere.
  */
-#define is_signed_type(type)       (((type)(-1)) < (type)1)
 #define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
 #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
 #define type_min(T) ((T)((T)-type_max(T)-(T)1))
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5af2acb9fb7d..0c8c3cf36f96 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -700,8 +700,6 @@ extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
 
-#define is_signed_type(type)	(((type)(-1)) < (type)1)
-
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
 int trace_array_set_clr_event(struct trace_array *tr, const char *system,
-- 
2.47.3



Return-Path: <stable+bounces-179381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 238CCB553A7
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 17:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 568B7BA2C88
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1C31AF27;
	Fri, 12 Sep 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TbTjTqdw"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.156.205.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85931AF0E;
	Fri, 12 Sep 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.156.205.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691092; cv=none; b=YtU/IPn2aXjkZDUwqy4vtEc4tg4UIs6S4zTfzExo+10EDhj6Mri7f++aBNkR0ZL0uGlzI7fWgJBP1H1Fm6GXmqJBUuUajEwVAIDqx7QKgC1/iPDkGMVVLooMD5eTVVRRqbvrXy/f14ahdywEMbDePLa5PSvJK/L7icGx5cMcgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691092; c=relaxed/simple;
	bh=NSzvNrJAMUb9GfFJEBhQ9uNIUWa7KeQFbp7whiUmZTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nk8lXse75mXeDM75J4a7ZhlAK0obv5OK2MGVEdD+R7maTUecvSIenG8HKn9kHeyPbMcM/7wlsanI/bkzhycP9c8SRNPuLnNzmPpt2bpRf/N15IVicw8qIYZqSVFDXAm0z76ZcIQlwMSjuxkVFtYmlQR9XTh1ZMrDUCIhBfOW9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TbTjTqdw; arc=none smtp.client-ip=18.156.205.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757691090; x=1789227090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x1XW1KMO+D5uSaQ8WeTblJJV7MJ293yX+nAqnx5MTkY=;
  b=TbTjTqdw2g0Bp1lq0r4wC3m3JRNj8q+7jwTpvBko7d0/rnzaW1UW2q2c
   bWwxxyDIcZ7CBGm8Sde73nPpDTx071vqRp/RhRLp7X21yuv3qBsUD0Aa5
   JQ+Ver68ecB9ooZi51AfTi5qQHY5Vls8FhweFf+93DKcDD5avuIRukqsV
   Q2AKZidLLJSOx8K5nrlB6FzWTt00MfZBk0iSPaXrvxl7YfBR7wnJsF5PJ
   jD4zQ63Xp21BUbXNv6Pej7M5QQlmxNxrqZE9armB10nQ/UXh00uADbaEa
   WgdmWksie9MNXFonvYdFtS8L0CCuTwS5y2bipcMdJAdqbr+crjvPEUFii
   A==;
X-CSE-ConnectionGUID: /yGqciskQ5qMFX1+5dZ7eg==
X-CSE-MsgGUID: 9owVXk/KQpGgux3b9jlKhA==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="2028376"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:31:19 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:29994]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.32.129:2525] with esmtp (Farcaster)
 id e80810c2-caec-4488-8f15-2e0fa38b0b4f; Fri, 12 Sep 2025 15:31:19 +0000 (UTC)
X-Farcaster-Flow-ID: e80810c2-caec-4488-8f15-2e0fa38b0b4f
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 15:31:19 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 15:31:13 +0000
From: Eliav Farber <farbere@amazon.com>
To: <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>, <mingo@redhat.com>,
	<natechancellor@gmail.com>, <ndesaulniers@google.com>,
	<keescook@chromium.org>, <sashal@kernel.org>, <akpm@linux-foundation.org>,
	<ojeda@kernel.org>, <elver@google.com>, <gregkh@linuxfoundation.org>,
	<kbusch@kernel.org>, <sj@kernel.org>, <bvanassche@acm.org>,
	<leon@kernel.org>, <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
	<linux-sparse@vger.kernel.org>, <clang-built-linux@googlegroups.com>,
	<stable@vger.kernel.org>
CC: <jonnyc@amazon.com>, <farbere@amazon.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>
Subject: [PATCH v2 4/4 5.10.y] tracing: Define the is_signed_type() macro once
Date: Fri, 12 Sep 2025 15:30:38 +0000
Message-ID: <20250912153040.26691-5-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250912153040.26691-1-farbere@amazon.com>
References: <20250912153040.26691-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: Bart Van Assche <bvanassche@acm.org>

commit a49a64b5bf195381c09202c524f0f84b5f3e816f upstream.

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
index 73bc67ec2136..e6bf14f462e9 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -29,7 +29,6 @@
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



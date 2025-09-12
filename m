Return-Path: <stable+bounces-179361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD4B54EA6
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 14:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B137517733A
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B761230DED1;
	Fri, 12 Sep 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="f8guYVpd"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11A730E0CD;
	Fri, 12 Sep 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681819; cv=none; b=K/RiRYuyx3v2bQ8E1W6b4/oJc+f57Bzzz8K9ARNhIPDvHNh5/YhxWMwOVASKXsJV2uJOUDqMPU+0PjgdeOdmhM8fyUpMK9dWCc5rDAkdB9qoy0MbI6wIxp3cQPrlx1ka0tK5t4sHQO9Rmq60B8FbTsQYVa4aPddE4vskUy19EFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681819; c=relaxed/simple;
	bh=t0YLY8EiinGEmdO39qs/0vr8Y4OdLgym4zLPBz0ZjIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwCqGPpxA+nwYdYOXElB5hE6/mqIYmOn9eroNOpltq4gXbQmUbqwSDIy3bdTLds1YZPcNq7db87Gu0qKXZyhAs3V90sA17kbAT7p04p0k84+I2G4Vpp8UihiEJj721Oo2xdc/eCnkN2aYJiYNku9I/IVgzCWNDeB5asdO1JIRB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=f8guYVpd; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757681817; x=1789217817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=82mFA+mEQjheUnk2vX45eaE13KVipYmy0vxoxzfkwSk=;
  b=f8guYVpdavy4yzPQXX94s+8qksvfz/9kM/eIgiYmLYib2RMzILmqe+TH
   6R3DZ4RCd/czLHhNT3ez7JFS7PYR2bCt9Z8DAMdAHDGQoXTsSuzN6g5iB
   TULpRC3ekBprsAl8aJcoUYvgw9RK73Z9NyojixEu8a7F8vqsqxzG7v0e9
   9VUmZlOcQMfS8J1Zf6BI/QJ/k9TmbI4PgO3T+GwDzNtAiKL3PL4jpIWVk
   P4MqlC8Dqo6niiNUzVexIKp0NiWrjXDyNFkPUCuBM7HxkuEHzdF15M1Ap
   5/Hey+cTPhCdG8N393dvW/ojIq8EIAiBxPCu1zneAoInbPV6mjkki7V2i
   w==;
X-CSE-ConnectionGUID: KM2YLXIVSUC+c3pgswx9pg==
X-CSE-MsgGUID: R3q6q5afQRizGeg+ej46Jg==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="2022278"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 12:56:46 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:23913]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.11.107:2525] with esmtp (Farcaster)
 id c0e44276-4d55-4045-bc66-3e54ff42c2d9; Fri, 12 Sep 2025 12:56:46 +0000 (UTC)
X-Farcaster-Flow-ID: c0e44276-4d55-4045-bc66-3e54ff42c2d9
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 12:56:46 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 12:56:39 +0000
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
Subject: [PATCH 4/4 5.10.y] tracing: Define the is_signed_type() macro once
Date: Fri, 12 Sep 2025 12:56:05 +0000
Message-ID: <20250912125606.13262-5-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250912125606.13262-1-farbere@amazon.com>
References: <20250912125606.13262-1-farbere@amazon.com>
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



Return-Path: <stable+bounces-60305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E39933026
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8A71F218E5
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00241A2FDE;
	Tue, 16 Jul 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwDOK7Iy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853D1A2FD9;
	Tue, 16 Jul 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154820; cv=none; b=fTiWKZHQcPW//1b6rLTWJHNp5eArKl+92DiYVA/Ws0PVk4a1w8dawUxgUYO8TyA56YeLiSUsXOSlyvJ/Kj+2aQHf3/WUWTqADzSRZP+Xj8kh22tBfcIkAYd2PO8bzs3FIKeEbrSc/juRC6VygtcbVX05LP+o9x1/xIqLSy2PR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154820; c=relaxed/simple;
	bh=eSQnHIurCv0WdHboEQsJS3wu5QW1VDQGyaA45BgH5o4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWd2jJCXk3udrfen+WET+lkGwlCJ1tGDs/xbRNB+k05djx/NR0vTDjXfE6zlLYyRx78yObI4Ux1cwCUleXMU63RadqwpHxNoThqK5lvA0iW8Ybu5Ub4J93fxZGv7kqxdxzonK2jkmv/TIA6aRVJJ1h7WAMSzroVqEbjjUppvphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwDOK7Iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C28C4AF0F;
	Tue, 16 Jul 2024 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154820;
	bh=eSQnHIurCv0WdHboEQsJS3wu5QW1VDQGyaA45BgH5o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwDOK7IyT/ZM6ao4qA5AG2Tzcp31+ojHGao7k37lf8pMqKmRozSAIKd6x/tc0nA1u
	 t3sooCktKLoSa36FQTQRpbyBYJrGeoHp+ovrdg4d2Tb9hIwIf4AX7mYsvIIzmCzY6K
	 O0z7Mj9FGdOQhB1vYIsuzeXKCoJZckKpXEBFuExzscISoUr4m03JQmZWhBHvvBnacw
	 tUAc4zgVEe6aiLne9vW9GsMSqbsXOzB8eWnBiCw6ABuEnpvi/4SEOZLyLeZJT1e5Y4
	 XzBJ3LX7JcCpq0HIEAswkqELRsUle9OfN1Lqe30mjO8XcXN0rd2kW4H2ZTrUWmQW8D
	 8apbV1iL8Dwog==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 5.15.y 1/8] tracing: Define the is_signed_type() macro once
Date: Tue, 16 Jul 2024 11:33:26 -0700
Message-Id: <20240716183333.138498-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716183333.138498-1-sj@kernel.org>
References: <20240716183333.138498-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 include/linux/compiler.h     | 6 ++++++
 include/linux/overflow.h     | 1 -
 include/linux/trace_events.h | 2 --
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 0f7fd205ab7e..65111de4ad6b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -246,6 +246,12 @@ static inline void *offset_to_ptr(const int *off)
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
index 17575aa2a53c..511c43ce9421 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -801,8 +801,6 @@ extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
 
-#define is_signed_type(type)	(((type)(-1)) < (type)1)
-
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
 int trace_array_set_clr_event(struct trace_array *tr, const char *system,
-- 
2.39.2



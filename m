Return-Path: <stable+bounces-106092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F19FC35D
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 03:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD18B18842FA
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 02:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91113211A;
	Wed, 25 Dec 2024 02:45:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F45E53E23;
	Wed, 25 Dec 2024 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735094702; cv=none; b=tBVeAk7gbFIRmpwKGlsMHUP7Xjy/4+ASGxtJZet0dPWc9PKRti333bJmzx47vb1uWEZi1fYojRqZrNydELjJ3t2qa4oB/3brKWoHArsWKH7od+hx0gaYYbybF6ELMiFaTfCHsUZHhtvxbz5v6jYlXS7mCIFoLgmCOFEhvdPdvLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735094702; c=relaxed/simple;
	bh=Hwu5c24DC5at5/TqglxlBqTR9dnnO1xr7Iyw+0MazWE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=B0qBK0gIlHb3uWbfalyAQ/98tEoQ4OYC+ElzDdWDId1JvBczSFfL/pipnP/cNnVfciC1Zda3q90CeQKw6qAezguVlAFPcp9C5O+YbvwMYcmslmokgREHWaMt2ONEycl/K8uKEDP+IYwy4I94RtfBuh3DUK21m8MLARFCUBAwZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4F8C4CED6;
	Wed, 25 Dec 2024 02:45:02 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tQHPJ-0000000Ektk-0Sv4;
	Tue, 24 Dec 2024 21:45:57 -0500
Message-ID: <20241225024556.965969273@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 24 Dec 2024 21:45:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [for-linus][PATCH 1/2] tracing: Constify string literal data member in struct
 trace_event_call
References: <20241225024536.865653915@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>

The name member of the struct trace_event_call is assigned with
generated string literals; declare them pointer to read-only.

Reported by clang:

    security/landlock/syscalls.c:179:1: warning: initializing 'char *' with an expression of type 'const char[34]' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
      179 | SYSCALL_DEFINE3(landlock_create_ruleset,
          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      180 |                 const struct landlock_ruleset_attr __user *const, attr,
          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      181 |                 const size_t, size, const __u32, flags)
          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/syscalls.h:226:36: note: expanded from macro 'SYSCALL_DEFINE3'
      226 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
          |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/syscalls.h:234:2: note: expanded from macro 'SYSCALL_DEFINEx'
      234 |         SYSCALL_METADATA(sname, x, __VA_ARGS__)                 \
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/syscalls.h:184:2: note: expanded from macro 'SYSCALL_METADATA'
      184 |         SYSCALL_TRACE_ENTER_EVENT(sname);                       \
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/syscalls.h:151:30: note: expanded from macro 'SYSCALL_TRACE_ENTER_EVENT'
      151 |                         .name                   = "sys_enter"#sname,    \
          |                                                   ^~~~~~~~~~~~~~~~~

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mickaël Salaün <mic@digikod.net>
Cc: Günther Noack <gnoack@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Link: https://lore.kernel.org/20241125105028.42807-1-cgoettsche@seltendoof.de
Fixes: b77e38aa240c3 ("tracing: add event trace infrastructure")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 91b8ffbdfa8c..58ad4ead33fc 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -364,7 +364,7 @@ struct trace_event_call {
 	struct list_head	list;
 	struct trace_event_class *class;
 	union {
-		char			*name;
+		const char		*name;
 		/* Set TRACE_EVENT_FL_TRACEPOINT flag when using "tp" */
 		struct tracepoint	*tp;
 	};
-- 
2.45.2




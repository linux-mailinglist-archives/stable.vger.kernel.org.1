Return-Path: <stable+bounces-94784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3E79D6F16
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E81162143
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894B01E22EB;
	Sun, 24 Nov 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVhNeUy9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D841E22E3;
	Sun, 24 Nov 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452395; cv=none; b=BiXb2Y0PXZd23LcsUuXzFsqEFFp8cEQPFTr8kVc5X199/nkAARu90KjA6V3/HlhD5EgvVd9MMJBqUtZDuPXUSfIbW39LX6LT3MCl52VLw/fAeawe240ovaZ1CrAHnuMgHn6ZvbXzCOeq7Gghhzjek3YWr6Jien+weN/Lx5pwJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452395; c=relaxed/simple;
	bh=OOs4+eiAwIjAgOT+wciiyQs1PkxA178hvLUPZ87+pTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atEy9sd5mfYpo0ZLLU38Ml+BozMgN6B3uW/fquKJsVnFSkYZclW7KT0TUQYslrWFRr38Krr0o+lCKdQWn7WAz9oPJpeOm6UYjmHtNHD2RR6nhC14apvXPsXDsqABOTgKC8mGMW/Cic4mHMutM39n7TTm6Yarzoy63EdOz6R2Eo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVhNeUy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E46C4CED1;
	Sun, 24 Nov 2024 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452394;
	bh=OOs4+eiAwIjAgOT+wciiyQs1PkxA178hvLUPZ87+pTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVhNeUy9lMPWH/oh4RmRvQIjjMbLtGCQddAFiHPLq7tgLk2LY9Ecdrm5MzCyY9tYH
	 PPbHL5ea5xv7iJqz//i6P/T4guJW6OGHUo6Ed3nbLKybJbwjI5pLxC1xvWkRv/zkmk
	 l0L3MlqHWfNZtHB1PZVSWColNp0dPgGw94+KDg7DoP8Wf5ttLUKCcuD3HAl2kmWdlS
	 Wbbh2XXyllU/B9/J9kavGXKnSyMm2R6RcDfd+7MFakNup8XuH/+QL+VxEeyVymOdFm
	 Lv65tlHFwEu1RgUIbHZYfN3fbEWNSfAtZFJ3oSdN2rH4CkfEVMl97o+cFpBt3scsND
	 2LDeLQ0MhAGEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	dan.j.williams@intel.com,
	kevin.tian@intel.com,
	dlechner@baylibre.com,
	mingo@kernel.org,
	ubizjak@gmail.com
Subject: [PATCH AUTOSEL 6.12 4/5] cleanup: Adjust scoped_guard() macros to avoid potential warning
Date: Sun, 24 Nov 2024 07:46:16 -0500
Message-ID: <20241124124623.3337983-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124623.3337983-1-sashal@kernel.org>
References: <20241124124623.3337983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

[ Upstream commit fcc22ac5baf06dd17193de44b60dbceea6461983 ]

Change scoped_guard() and scoped_cond_guard() macros to make reasoning
about them easier for static analysis tools (smatch, compiler
diagnostics), especially to enable them to tell if the given usage of
scoped_guard() is with a conditional lock class (interruptible-locks,
try-locks) or not (like simple mutex_lock()).

Add compile-time error if scoped_cond_guard() is used for non-conditional
lock class.

Beyond easier tooling and a little shrink reported by bloat-o-meter
this patch enables developer to write code like:

int foo(struct my_drv *adapter)
{
	scoped_guard(spinlock, &adapter->some_spinlock)
		return adapter->spinlock_protected_var;
}

Current scoped_guard() implementation does not support that,
due to compiler complaining:
error: control reaches end of non-void function [-Werror=return-type]

Technical stuff about the change:
scoped_guard() macro uses common idiom of using "for" statement to declare
a scoped variable. Unfortunately, current logic is too hard for compiler
diagnostics to be sure that there is exactly one loop step; fix that.

To make any loop so trivial that there is no above warning, it must not
depend on any non-const variable to tell if there are more steps. There is
no obvious solution for that in C, but one could use the compound
statement expression with "goto" jumping past the "loop", effectively
leaving only the subscope part of the loop semantics.

More impl details:
one more level of macro indirection is now needed to avoid duplicating
label names;
I didn't spot any other place that is using the
"for (...; goto label) if (0) label: break;" idiom, so it's not packed for
reuse beyond scoped_guard() family, what makes actual macros code cleaner.

There was also a need to introduce const true/false variable per lock
class, it is used to aid compiler diagnostics reasoning about "exactly
1 step" loops (note that converting that to function would undo the whole
benefit).

Big thanks to Andy Shevchenko for help on this patch, both internal and
public, ranging from whitespace/formatting, through commit message
clarifications, general improvements, ending with presenting alternative
approaches - all despite not even liking the idea.

Big thanks to Dmitry Torokhov for the idea of compile-time check for
scoped_cond_guard() (to use it only with conditional locsk), and general
improvements for the patch.

Big thanks to David Lechner for idea to cover also scoped_cond_guard().

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lkml.kernel.org/r/20241018113823.171256-1-przemyslaw.kitszel@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cleanup.h | 52 +++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 038b2d523bf88..9464724b99737 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -285,14 +285,20 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *      similar to scoped_guard(), except it does fail when the lock
  *      acquire fails.
  *
+ *      Only for conditional locks.
  */
 
+#define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
+static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
+
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
+	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
 	{ return *_T; }
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
+	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
 	EXTEND_CLASS(_name, _ext, \
 		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
 		     class_##_name##_t _T) \
@@ -303,17 +309,40 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
+#define __is_cond_ptr(_name) class_##_name##_is_conditional
 
-#define scoped_guard(_name, args...)					\
-	for (CLASS(_name, scope)(args),					\
-	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
-
-#define scoped_cond_guard(_name, _fail, args...) \
-	for (CLASS(_name, scope)(args), \
-	     *done = NULL; !done; done = (void *)1) \
-		if (!__guard_ptr(_name)(&scope)) _fail; \
-		else
-
+/*
+ * Helper macro for scoped_guard().
+ *
+ * Note that the "!__is_cond_ptr(_name)" part of the condition ensures that
+ * compiler would be sure that for the unconditional locks the body of the
+ * loop (caller-provided code glued to the else clause) could not be skipped.
+ * It is needed because the other part - "__guard_ptr(_name)(&scope)" - is too
+ * hard to deduce (even if could be proven true for unconditional locks).
+ */
+#define __scoped_guard(_name, _label, args...)				\
+	for (CLASS(_name, scope)(args);					\
+	     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);	\
+	     ({ goto _label; }))					\
+		if (0) {						\
+_label:									\
+			break;						\
+		} else
+
+#define scoped_guard(_name, args...)	\
+	__scoped_guard(_name, __UNIQUE_ID(label), args)
+
+#define __scoped_cond_guard(_name, _fail, _label, args...)		\
+	for (CLASS(_name, scope)(args); true; ({ goto _label; }))	\
+		if (!__guard_ptr(_name)(&scope)) {			\
+			BUILD_BUG_ON(!__is_cond_ptr(_name));		\
+			_fail;						\
+_label:									\
+			break;						\
+		} else
+
+#define scoped_cond_guard(_name, _fail, args...)	\
+	__scoped_cond_guard(_name, _fail, __UNIQUE_ID(label), args)
 /*
  * Additional helper macros for generating lock guards with types, either for
  * locks that don't have a native type (eg. RCU, preempt) or those that need a
@@ -369,14 +398,17 @@ static inline class_##_name##_t class_##_name##_constructor(void)	\
 }
 
 #define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
+__DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_1(_name, _type, _lock)
 
 #define DEFINE_LOCK_GUARD_0(_name, _lock, _unlock, ...)			\
+__DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_0(_name, _lock)
 
 #define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
+	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true);		\
 	EXTEND_CLASS(_name, _ext,					\
 		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
 		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\
-- 
2.43.0



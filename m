Return-Path: <stable+bounces-94789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8D99D6F19
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6832811A5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6CA1E261A;
	Sun, 24 Nov 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+UdBh0l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178801E2619;
	Sun, 24 Nov 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452415; cv=none; b=WPFm5/YdlHHPysBRVMrDwB3LSevtP3HN+OdEbjS+Pg1K4XnUD/LfjfioqQVclCfAf+0QFLjh+wz128Fq1b2j4HJckIV06FyFKz8DhHfvIykJaUrV4cHZIz27fsmW/izHnklZQBbZFyxh/yEekaziuT1NlMWFiKRCrzaw1ZQ0GD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452415; c=relaxed/simple;
	bh=VKpxCFUD125C+5rna1nnugocLt7LwqfbwJ/uVUNq1tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6nkNt2sR9XsZkAwRyGvhWCfKUWCQZrK8pq0lbx/wPoWlttD01gBm7QtQe1qeTcNHY0WXQtNX4fiJDsha7cAkqyyXOzsxFs0vEW7wmJ24E28CuUTqVYLN5w49WFys8DdYehzVhRer9LQX145Clix4sy+ohcjXGUl2zR+AuhMkTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+UdBh0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97458C4CECC;
	Sun, 24 Nov 2024 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452415;
	bh=VKpxCFUD125C+5rna1nnugocLt7LwqfbwJ/uVUNq1tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+UdBh0ldtHukRiICROinngPgyNw0fuIdL/0mG0ulNWJQgcIjYiG8iwZe3gv7JQlm
	 46blC7T72/5CIhV1GQYk0MBckHRVdo7FMS1W7U996JfHyQcKATzQ1r+xqFQAcwysfl
	 8UA4K7QlpCmTzWCh3dlwMw3jNNPAR88feU63HntCiNRfy9rj6g5XV6HDYMGlTfTACR
	 ExCb/GL99LWAw24GoNgkzgkxHwJKTC2biFQlekahHTolif+j64VSNA5OwDDaOWHoEs
	 gL+VUe4hMEOPZteFQdfS7vkBg/mRz71EIqzgHRtIJQmudqdBG7AhawT4fQCEBP+3Ra
	 3WXFu3C6ACaKw==
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
	alexander@mihalicyn.com,
	ubizjak@gmail.com,
	mingo@kernel.org,
	dlechner@baylibre.com
Subject: [PATCH AUTOSEL 6.11 4/5] cleanup: Adjust scoped_guard() macros to avoid potential warning
Date: Sun, 24 Nov 2024 07:46:37 -0500
Message-ID: <20241124124643.3338173-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124643.3338173-1-sashal@kernel.org>
References: <20241124124643.3338173-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
 include/linux/cleanup.h | 48 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index d9e613803df15..ce7c9524c9f18 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -149,14 +149,20 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
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
@@ -167,17 +173,40 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
+#define __is_cond_ptr(_name) class_##_name##_is_conditional
+
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
 
-#define scoped_guard(_name, args...)					\
-	for (CLASS(_name, scope)(args),					\
-	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
+#define scoped_guard(_name, args...)	\
+	__scoped_guard(_name, __UNIQUE_ID(label), args)
 
-#define scoped_cond_guard(_name, _fail, args...) \
-	for (CLASS(_name, scope)(args), \
-	     *done = NULL; !done; done = (void *)1) \
-		if (!__guard_ptr(_name)(&scope)) _fail; \
-		else
+#define __scoped_cond_guard(_name, _fail, _label, args...)		\
+	for (CLASS(_name, scope)(args); true; ({ goto _label; }))	\
+		if (!__guard_ptr(_name)(&scope)) {			\
+			BUILD_BUG_ON(!__is_cond_ptr(_name));		\
+			_fail;						\
+_label:									\
+			break;						\
+		} else
 
+#define scoped_cond_guard(_name, _fail, args...)	\
+	__scoped_cond_guard(_name, _fail, __UNIQUE_ID(label), args)
 /*
  * Additional helper macros for generating lock guards with types, either for
  * locks that don't have a native type (eg. RCU, preempt) or those that need a
@@ -233,14 +262,17 @@ static inline class_##_name##_t class_##_name##_constructor(void)	\
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



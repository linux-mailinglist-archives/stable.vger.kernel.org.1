Return-Path: <stable+bounces-185831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88393BDF479
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 17:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35B23A2061
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214D17B50F;
	Wed, 15 Oct 2025 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiB12Cxg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091721254B
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540759; cv=none; b=bo8wSAAzyMbKmaBmwZaQ20L0z5MG8+Ak9Y6I7tu83799BlewgW+T7v0QXj11ikW5HlUlDnczAAluDzjIgJf8acG7LlRH+IVpYOhCAmlyvQ/D2kx59DXM3Hng2gx5+HVmgM5w6S44BB2bOX6yt/ZHJ8E5bEu5kgymj82rWFYoc4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540759; c=relaxed/simple;
	bh=1+WLIe3jwxFnlQT6XjfwebsLVeMrZaqwKGqfxBbC3vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ck3Fv2DXESRatfiQenbODWEUKH3/qyMdFmhBwEJTiuv01I+/Pehw6SqV9pNgNK9ONXzXIT64qntM3MTf7YDyp5nn8ef2RDSQ1Z9657gXObmzEX5dI+4ydmtlHBwiqpQl0bNertRw9LHtp57x01paz2veqnkJxJ3eYjs1UPammZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiB12Cxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE64C4CEF8;
	Wed, 15 Oct 2025 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760540759;
	bh=1+WLIe3jwxFnlQT6XjfwebsLVeMrZaqwKGqfxBbC3vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YiB12Cxgw9KBy3dtTsUg5DOBmLQYAsKZhIFPbgCvDQixhiWROXJUJA6SiUCzclEdB
	 tJ+1EtDMQ5X0ZKZDiDLEq5xzI3ApBWJIAGaX8Eqig+tBOzR4Gqo51EmHJG481dFe8t
	 e0z9P0QNqb9ALLC33L2nJo4EKotKAS6vmp0Aok9mqZIM1ccOYARNRV94LiCCA939Z4
	 YPgTJ9iL8yKZecWhgkvbwzuaZAwT4waP7OGhRQmQ0Sd725CLrKNJoybJzAf5nTSPB2
	 xQQr+gOJJ2BdfJGIduZi9cxq2N7Nl2NOj0Umo6r1HoIuHclREgnT0HFyOOzPpR1Xs4
	 R7L//eEAlOrjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] locking: Introduce __cleanup() based infrastructure
Date: Wed, 15 Oct 2025 11:05:54 -0400
Message-ID: <20251015150555.1437678-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101543-quake-judicial-9e2e@gregkh>
References: <2025101543-quake-judicial-9e2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 54da6a0924311c7cf5015533991e44fb8eb12773 ]

Use __attribute__((__cleanup__(func))) to build:

 - simple auto-release pointers using __free()

 - 'classes' with constructor and destructor semantics for
   scope-based resource management.

 - lock guards based on the above classes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230612093537.614161713%40infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ioat/dma.c              |  12 +-
 include/linux/cleanup.h             | 171 ++++++++++++++++++++++++++++
 include/linux/compiler-clang.h      |   9 ++
 include/linux/compiler_attributes.h |   6 +
 include/linux/device.h              |   7 ++
 include/linux/file.h                |   6 +
 include/linux/irqflags.h            |   7 ++
 include/linux/mutex.h               |   4 +
 include/linux/percpu.h              |   4 +
 include/linux/preempt.h             |  47 ++++++++
 include/linux/rcupdate.h            |   3 +
 include/linux/rwsem.h               |   8 ++
 include/linux/sched/task.h          |   2 +
 include/linux/slab.h                |   3 +
 include/linux/spinlock.h            |  32 ++++++
 include/linux/srcu.h                |   5 +
 scripts/checkpatch.pl               |   2 +-
 17 files changed, 321 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/cleanup.h

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index e2070df6cad28..0b846c605d4bd 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -584,11 +584,11 @@ desc_get_errstat(struct ioatdma_chan *ioat_chan, struct ioat_ring_ent *desc)
 }
 
 /**
- * __cleanup - reclaim used descriptors
+ * __ioat_cleanup - reclaim used descriptors
  * @ioat_chan: channel (ring) to clean
  * @phys_complete: zeroed (or not) completion address (from status)
  */
-static void __cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
+static void __ioat_cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
 {
 	struct ioatdma_device *ioat_dma = ioat_chan->ioat_dma;
 	struct ioat_ring_ent *desc;
@@ -675,7 +675,7 @@ static void ioat_cleanup(struct ioatdma_chan *ioat_chan)
 	spin_lock_bh(&ioat_chan->cleanup_lock);
 
 	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
-		__cleanup(ioat_chan, phys_complete);
+		__ioat_cleanup(ioat_chan, phys_complete);
 
 	if (is_ioat_halted(*ioat_chan->completion)) {
 		u32 chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
@@ -712,7 +712,7 @@ static void ioat_restart_channel(struct ioatdma_chan *ioat_chan)
 
 	ioat_quiesce(ioat_chan, 0);
 	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
-		__cleanup(ioat_chan, phys_complete);
+		__ioat_cleanup(ioat_chan, phys_complete);
 
 	__ioat_restart_chan(ioat_chan);
 }
@@ -786,7 +786,7 @@ static void ioat_eh(struct ioatdma_chan *ioat_chan)
 
 	/* cleanup so tail points to descriptor that caused the error */
 	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
-		__cleanup(ioat_chan, phys_complete);
+		__ioat_cleanup(ioat_chan, phys_complete);
 
 	chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
 	pci_read_config_dword(pdev, IOAT_PCI_CHANERR_INT_OFFSET, &chanerr_int);
@@ -943,7 +943,7 @@ void ioat_timer_event(struct timer_list *t)
 		/* timer restarted in ioat_cleanup_preamble
 		 * and IOAT_COMPLETION_ACK cleared
 		 */
-		__cleanup(ioat_chan, phys_complete);
+		__ioat_cleanup(ioat_chan, phys_complete);
 		goto unlock_out;
 	}
 
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
new file mode 100644
index 0000000000000..53f1a7a932b08
--- /dev/null
+++ b/include/linux/cleanup.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_GUARDS_H
+#define __LINUX_GUARDS_H
+
+#include <linux/compiler.h>
+
+/*
+ * DEFINE_FREE(name, type, free):
+ *	simple helper macro that defines the required wrapper for a __free()
+ *	based cleanup function. @free is an expression using '_T' to access
+ *	the variable.
+ *
+ * __free(name):
+ *	variable attribute to add a scoped based cleanup to the variable.
+ *
+ * no_free_ptr(var):
+ *	like a non-atomic xchg(var, NULL), such that the cleanup function will
+ *	be inhibited -- provided it sanely deals with a NULL value.
+ *
+ * return_ptr(p):
+ *	returns p while inhibiting the __free().
+ *
+ * Ex.
+ *
+ * DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
+ *
+ *	struct obj *p __free(kfree) = kmalloc(...);
+ *	if (!p)
+ *		return NULL;
+ *
+ *	if (!init_obj(p))
+ *		return NULL;
+ *
+ *	return_ptr(p);
+ */
+
+#define DEFINE_FREE(_name, _type, _free) \
+	static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
+
+#define __free(_name)	__cleanup(__free_##_name)
+
+#define no_free_ptr(p) \
+	({ __auto_type __ptr = (p); (p) = NULL; __ptr; })
+
+#define return_ptr(p)	return no_free_ptr(p)
+
+
+/*
+ * DEFINE_CLASS(name, type, exit, init, init_args...):
+ *	helper to define the destructor and constructor for a type.
+ *	@exit is an expression using '_T' -- similar to FREE above.
+ *	@init is an expression in @init_args resulting in @type
+ *
+ * EXTEND_CLASS(name, ext, init, init_args...):
+ *	extends class @name to @name@ext with the new constructor
+ *
+ * CLASS(name, var)(args...):
+ *	declare the variable @var as an instance of the named class
+ *
+ * Ex.
+ *
+ * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
+ *
+ *	CLASS(fdget, f)(fd);
+ *	if (!f.file)
+ *		return -EBADF;
+ *
+ *	// use 'f' without concern
+ */
+
+#define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)		\
+typedef _type class_##_name##_t;					\
+static inline void class_##_name##_destructor(_type *p)			\
+{ _type _T = *p; _exit; }						\
+static inline _type class_##_name##_constructor(_init_args)		\
+{ _type t = _init; return t; }
+
+#define EXTEND_CLASS(_name, ext, _init, _init_args...)			\
+typedef class_##_name##_t class_##_name##ext##_t;			\
+static inline void class_##_name##ext##_destructor(class_##_name##_t *p)\
+{ class_##_name##_destructor(p); }					\
+static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
+{ class_##_name##_t t = _init; return t; }
+
+#define CLASS(_name, var)						\
+	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
+		class_##_name##_constructor
+
+
+/*
+ * DEFINE_GUARD(name, type, lock, unlock):
+ *	trivial wrapper around DEFINE_CLASS() above specifically
+ *	for locks.
+ *
+ * guard(name):
+ *	an anonymous instance of the (guard) class
+ *
+ * scoped_guard (name, args...) { }:
+ *	similar to CLASS(name, scope)(args), except the variable (with the
+ *	explicit name 'scope') is declard in a for-loop such that its scope is
+ *	bound to the next (compound) statement.
+ *
+ */
+
+#define DEFINE_GUARD(_name, _type, _lock, _unlock) \
+	DEFINE_CLASS(_name, _type, _unlock, ({ _lock; _T; }), _type _T)
+
+#define guard(_name) \
+	CLASS(_name, __UNIQUE_ID(guard))
+
+#define scoped_guard(_name, args...)					\
+	for (CLASS(_name, scope)(args),					\
+	     *done = NULL; !done; done = (void *)1)
+
+/*
+ * Additional helper macros for generating lock guards with types, either for
+ * locks that don't have a native type (eg. RCU, preempt) or those that need a
+ * 'fat' pointer (eg. spin_lock_irqsave).
+ *
+ * DEFINE_LOCK_GUARD_0(name, lock, unlock, ...)
+ * DEFINE_LOCK_GUARD_1(name, type, lock, unlock, ...)
+ *
+ * will result in the following type:
+ *
+ *   typedef struct {
+ *	type *lock;		// 'type := void' for the _0 variant
+ *	__VA_ARGS__;
+ *   } class_##name##_t;
+ *
+ * As above, both _lock and _unlock are statements, except this time '_T' will
+ * be a pointer to the above struct.
+ */
+
+#define __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, ...)		\
+typedef struct {							\
+	_type *lock;							\
+	__VA_ARGS__;							\
+} class_##_name##_t;							\
+									\
+static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
+{									\
+	if (_T->lock) { _unlock; }					\
+}
+
+
+#define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
+static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
+{									\
+	class_##_name##_t _t = { .lock = l }, *_T = &_t;		\
+	_lock;								\
+	return _t;							\
+}
+
+#define __DEFINE_LOCK_GUARD_0(_name, _lock)				\
+static inline class_##_name##_t class_##_name##_constructor(void)	\
+{									\
+	class_##_name##_t _t = { .lock = (void*)1 },			\
+			 *_T __maybe_unused = &_t;			\
+	_lock;								\
+	return _t;							\
+}
+
+#define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
+__DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
+__DEFINE_LOCK_GUARD_1(_name, _type, _lock)
+
+#define DEFINE_LOCK_GUARD_0(_name, _lock, _unlock, ...)			\
+__DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
+__DEFINE_LOCK_GUARD_0(_name, _lock)
+
+#endif /* __LINUX_GUARDS_H */
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index cc3b972f8a270..29be8ad715498 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -5,6 +5,15 @@
 
 /* Compiler specific definitions for Clang compiler */
 
+/*
+ * Clang prior to 17 is being silly and considers many __cleanup() variables
+ * as unused (because they are, their sole purpose is to go out of scope).
+ *
+ * https://reviews.llvm.org/D152180
+ */
+#undef __cleanup
+#define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
+
 /* same as gcc, this was present in clang-2.6 so we can assume it works
  * with any version that can compile the kernel
  */
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 932b8fd6f36f0..5ee9e2aeab63f 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -80,6 +80,12 @@
  */
 #define __cold                          __attribute__((__cold__))
 
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-cleanup-variable-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#cleanup
+ */
+#define __cleanup(func)			__attribute__((__cleanup__(func)))
+
 /*
  * Note the long name.
  *
diff --git a/include/linux/device.h b/include/linux/device.h
index 440c9f1a3f350..a77390035a8a0 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -30,6 +30,7 @@
 #include <linux/device/bus.h>
 #include <linux/device/class.h>
 #include <linux/device/driver.h>
+#include <linux/cleanup.h>
 #include <asm/device.h>
 
 struct device;
@@ -822,6 +823,9 @@ void device_unregister(struct device *dev);
 void device_initialize(struct device *dev);
 int __must_check device_add(struct device *dev);
 void device_del(struct device *dev);
+
+DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
+
 int device_for_each_child(struct device *dev, void *data,
 			  int (*fn)(struct device *dev, void *data));
 int device_for_each_child_reverse(struct device *dev, void *data,
@@ -952,6 +956,9 @@ extern int (*platform_notify_remove)(struct device *dev);
  */
 struct device *get_device(struct device *dev);
 void put_device(struct device *dev);
+
+DEFINE_FREE(put_device, struct device *, if (_T) put_device(_T))
+
 bool kill_device(struct device *dev);
 
 #ifdef CONFIG_DEVTMPFS
diff --git a/include/linux/file.h b/include/linux/file.h
index 51e830b4fe3ab..6726240b9279a 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/posix_types.h>
 #include <linux/errno.h>
+#include <linux/cleanup.h>
 
 struct file;
 
@@ -82,6 +83,8 @@ static inline void fdput_pos(struct fd f)
 	fdput(f);
 }
 
+DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
+
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
 extern void set_close_on_exec(unsigned int fd, int flag);
@@ -90,6 +93,9 @@ extern int __get_unused_fd_flags(unsigned flags, unsigned long nofile);
 extern int get_unused_fd_flags(unsigned flags);
 extern void put_unused_fd(unsigned int fd);
 
+DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
+	     get_unused_fd_flags(flags), unsigned flags)
+
 extern void fd_install(unsigned int fd, struct file *file);
 
 extern int __receive_fd(struct file *file, int __user *ufd,
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 37738ec87de31..c4288c7ae613f 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -13,6 +13,7 @@
 #define _LINUX_TRACE_IRQFLAGS_H
 
 #include <linux/typecheck.h>
+#include <linux/cleanup.h>
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
 
@@ -260,4 +261,10 @@ extern void warn_bogus_irq_restore(void);
 
 #define irqs_disabled_flags(flags) raw_irqs_disabled_flags(flags)
 
+DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
+DEFINE_LOCK_GUARD_0(irqsave,
+		    local_irq_save(_T->flags),
+		    local_irq_restore(_T->flags),
+		    unsigned long flags)
+
 #endif
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 9ef01b9d24563..5b5630e58407a 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -19,6 +19,7 @@
 #include <asm/processor.h>
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
+#include <linux/cleanup.h>
 
 struct device;
 
@@ -246,4 +247,7 @@ extern void mutex_unlock(struct mutex *lock);
 
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
+DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
+DEFINE_FREE(mutex, struct mutex *, if (_T) mutex_unlock(_T))
+
 #endif /* __LINUX_MUTEX_H */
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 5e76af742c807..c9a84532bb793 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -9,6 +9,7 @@
 #include <linux/printk.h>
 #include <linux/pfn.h>
 #include <linux/init.h>
+#include <linux/cleanup.h>
 
 #include <asm/percpu.h>
 
@@ -134,6 +135,9 @@ extern void __init setup_per_cpu_areas(void);
 extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp);
 extern void __percpu *__alloc_percpu(size_t size, size_t align);
 extern void free_percpu(void __percpu *__pdata);
+
+DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
+
 extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 
 #define alloc_percpu_gfp(type, gfp)					\
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 9c4534a69a8f7..436f030a93f37 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cleanup.h>
 #include <linux/list.h>
 
 /*
@@ -431,4 +432,50 @@ static inline void migrate_enable(void) { }
 
 #endif /* CONFIG_SMP */
 
+/**
+ * preempt_disable_nested - Disable preemption inside a normally preempt disabled section
+ *
+ * Use for code which requires preemption protection inside a critical
+ * section which has preemption disabled implicitly on non-PREEMPT_RT
+ * enabled kernels, by e.g.:
+ *  - holding a spinlock/rwlock
+ *  - soft interrupt context
+ *  - regular interrupt handlers
+ *
+ * On PREEMPT_RT enabled kernels spinlock/rwlock held sections, soft
+ * interrupt context and regular interrupt handlers are preemptible and
+ * only prevent migration. preempt_disable_nested() ensures that preemption
+ * is disabled for cases which require CPU local serialization even on
+ * PREEMPT_RT. For non-PREEMPT_RT kernels this is a NOP.
+ *
+ * The use cases are code sequences which are not serialized by a
+ * particular lock instance, e.g.:
+ *  - seqcount write side critical sections where the seqcount is not
+ *    associated to a particular lock and therefore the automatic
+ *    protection mechanism does not work. This prevents a live lock
+ *    against a preempting high priority reader.
+ *  - RMW per CPU variable updates like vmstat.
+ */
+/* Macro to avoid header recursion hell vs. lockdep */
+#define preempt_disable_nested()				\
+do {								\
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))			\
+		preempt_disable();				\
+	else							\
+		lockdep_assert_preemption_disabled();		\
+} while (0)
+
+/**
+ * preempt_enable_nested - Undo the effect of preempt_disable_nested()
+ */
+static __always_inline void preempt_enable_nested(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+}
+
+DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
+DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
+DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 978769e545b5f..552216218d734 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -27,6 +27,7 @@
 #include <linux/preempt.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
+#include <linux/cleanup.h>
 #include <asm/processor.h>
 #include <linux/cpumask.h>
 
@@ -1060,4 +1061,6 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
+DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
+
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 352c6127cb90f..458a0c92cc689 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/err.h>
+#include <linux/cleanup.h>
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __RWSEM_DEP_MAP_INIT(lockname)			\
@@ -202,6 +203,13 @@ extern void up_read(struct rw_semaphore *sem);
  */
 extern void up_write(struct rw_semaphore *sem);
 
+DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
+DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
+
+DEFINE_FREE(up_read, struct rw_semaphore *, if (_T) up_read(_T))
+DEFINE_FREE(up_write, struct rw_semaphore *, if (_T) up_write(_T))
+
+
 /*
  * downgrade write lock to read lock
  */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index f254a7d851fe1..ff5aaed609695 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -142,6 +142,8 @@ static inline void put_task_struct(struct task_struct *t)
 		__put_task_struct(t);
 }
 
+DEFINE_FREE(put_task, struct task_struct *, if (_T) put_task_struct(_T))
+
 static inline void put_task_struct_many(struct task_struct *t, int nr)
 {
 	if (refcount_sub_and_test(nr, &t->usage))
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 3482c2ced139e..58efa0b1b6904 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/percpu-refcount.h>
+#include <linux/cleanup.h>
 
 
 /*
@@ -186,6 +187,8 @@ void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
+DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
+
 /**
  * ksize - Report actual allocation size of associated object
  *
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 45310ea1b1d78..6c02b2c3974fc 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -61,6 +61,7 @@
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
+#include <linux/cleanup.h>
 #include <asm/barrier.h>
 #include <asm/mmiowb.h>
 
@@ -506,4 +507,35 @@ int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 
 void free_bucket_spinlocks(spinlock_t *locks);
 
+DEFINE_LOCK_GUARD_1(raw_spinlock, raw_spinlock_t,
+		    raw_spin_lock(_T->lock),
+		    raw_spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(raw_spinlock_nested, raw_spinlock_t,
+		    raw_spin_lock_nested(_T->lock, SINGLE_DEPTH_NESTING),
+		    raw_spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
+		    raw_spin_lock_irq(_T->lock),
+		    raw_spin_unlock_irq(_T->lock))
+
+DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
+		    raw_spin_lock_irqsave(_T->lock, _T->flags),
+		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
+DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
+		    spin_lock(_T->lock),
+		    spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
+		    spin_lock_irq(_T->lock),
+		    spin_unlock_irq(_T->lock))
+
+DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
+		    spin_lock_irqsave(_T->lock, _T->flags),
+		    spin_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
+#undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e6011a9975af2..e94687215fbe1 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -211,4 +211,9 @@ static inline void smp_mb__after_srcu_read_unlock(void)
 	/* __srcu_read_unlock has smp_mb() internally so nothing to do here. */
 }
 
+DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
+		    _T->idx = srcu_read_lock(_T->lock),
+		    srcu_read_unlock(_T->lock, _T->idx),
+		    int idx)
+
 #endif
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 88cb294dc4472..b4fe18228805c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4895,7 +4895,7 @@ sub process {
 				if|for|while|switch|return|case|
 				volatile|__volatile__|
 				__attribute__|format|__extension__|
-				asm|__asm__)$/x)
+				asm|__asm__|scoped_guard)$/x)
 			{
 			# cpp #define statements have non-optional spaces, ie
 			# if there is a space between the name and the open
-- 
2.51.0



Return-Path: <stable+bounces-185849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 012EEBE03B1
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 20:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1E2E4F245D
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3BE2FFFAC;
	Wed, 15 Oct 2025 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wyx7LDB2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0082FFFA8
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553870; cv=none; b=Oku3+8DrnJKb5fPD8kc3ylsZTWMDwmsTNwfWvcyPhUoyStnKy1g7znAlSp+Rk2G1NnC9cpAj82R0/j2vaINrZcNLFnEeGbBZc5uAMpScRu5stJ/lmA1YaX31sR9jUlsrvqIaF6iRekYzE7MmTTtm5q4hDdYpmuPS3wHzbARoAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553870; c=relaxed/simple;
	bh=J2z/7VTCC3/Tunpzp/ygQYHpvyhPCdU0blyzUtxYnes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8o6wHz1E+86Sxi4V3f5gokgMtD4WfGbbTU7s9Pw4uIRQIT6CeZVc7IgP+pe8EfM6dVZgnJS/UhU73wL1SzGLgndVuhOXHFc8SKdXeR36wutwmoJKCuUWZVEm2BkEmTL9IfMwHA9cpGPgZjcmSTQbBApuaMrdNcODhax4MSfXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wyx7LDB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32766C4CEFB;
	Wed, 15 Oct 2025 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760553870;
	bh=J2z/7VTCC3/Tunpzp/ygQYHpvyhPCdU0blyzUtxYnes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wyx7LDB21EmO0R5DTeCPqZ38DznyFOfQCAmvOjAIDWJks6GQsVlYRqiAzbo9K7mkI
	 Mi6OZtOtB6HRNOmcSPxegJqMPI5jePmdxzxWQlLNauTgrBfGdYFPhAunrB7sxTr2K4
	 bfAR8mDPNdoUphfoRctucZ6GL7S6Q05bs6S66k9DaoCfZulDVtzAL+yT00DL+rHYVn
	 0qnJr3flBnrI5ooweAe1Ao4mcb8tJOdoKI1RPsZlbLiT0JjC/kJRoK1nuNBUJPDRbk
	 x0gAIUEytKQ5fzZ6o8Aetlxq/rHp8YMo1fZX0tnuNcC7MtDEaHQl5BSdYvTZno7Xyy
	 EUnUtOvzs8ulA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] locking: Introduce __cleanup() based infrastructure
Date: Wed, 15 Oct 2025 14:44:26 -0400
Message-ID: <20251015184427.1495851-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101539-racoon-uneasily-cfd4@gregkh>
References: <2025101539-racoon-uneasily-cfd4@gregkh>
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
 include/linux/preempt.h             |   5 +
 include/linux/rcupdate.h            |   3 +
 include/linux/rwsem.h               |   9 ++
 include/linux/sched/task.h          |   2 +
 include/linux/slab.h                |   3 +
 include/linux/spinlock.h            |  32 ++++++
 include/linux/srcu.h                |   5 +
 scripts/checkpatch.pl               |   2 +-
 17 files changed, 280 insertions(+), 7 deletions(-)
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
index 777fded63f4ed..383295e21e52b 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -15,6 +15,15 @@
 
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
index a3b85459959e8..79d306092b484 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -94,6 +94,12 @@
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
index d615719b19d4d..cfcf94757f6bf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -30,6 +30,7 @@
 #include <linux/device/bus.h>
 #include <linux/device/class.h>
 #include <linux/device/driver.h>
+#include <linux/cleanup.h>
 #include <asm/device.h>
 
 struct device;
@@ -826,6 +827,9 @@ void device_unregister(struct device *dev);
 void device_initialize(struct device *dev);
 int __must_check device_add(struct device *dev);
 void device_del(struct device *dev);
+
+DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
+
 int device_for_each_child(struct device *dev, void *data,
 			  int (*fn)(struct device *dev, void *data));
 int device_for_each_child_reverse(struct device *dev, void *data,
@@ -954,6 +958,9 @@ extern int (*platform_notify_remove)(struct device *dev);
  */
 struct device *get_device(struct device *dev);
 void put_device(struct device *dev);
+
+DEFINE_FREE(put_device, struct device *, if (_T) put_device(_T))
+
 bool kill_device(struct device *dev);
 
 #ifdef CONFIG_DEVTMPFS
diff --git a/include/linux/file.h b/include/linux/file.h
index 225982792fa20..5b4e313886489 100644
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
 
 extern int __receive_fd(int fd, struct file *file, int __user *ufd,
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index a53adf4316a53..9beebc188fd40 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -13,6 +13,7 @@
 #define _LINUX_TRACE_IRQFLAGS_H
 
 #include <linux/typecheck.h>
+#include <linux/cleanup.h>
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
 
@@ -248,4 +249,10 @@ do {						\
 
 #define irqs_disabled_flags(flags) raw_irqs_disabled_flags(flags)
 
+DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
+DEFINE_LOCK_GUARD_0(irqsave,
+		    local_irq_save(_T->flags),
+		    local_irq_restore(_T->flags),
+		    unsigned long flags)
+
 #endif
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 4d671fba3cab4..bc20db59f5cd3 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -19,6 +19,7 @@
 #include <asm/processor.h>
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
+#include <linux/cleanup.h>
 
 struct ww_acquire_ctx;
 
@@ -224,4 +225,7 @@ enum mutex_trylock_recursive_enum {
 extern /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
 mutex_trylock_recursive(struct mutex *lock);
 
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
index 7d9c1c0e149c0..9a70e1e315d3a 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cleanup.h>
 #include <linux/list.h>
 
 /*
@@ -352,4 +353,8 @@ static __always_inline void migrate_enable(void)
 	preempt_enable();
 }
 
+DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
+DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
+DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 9b3e01db654e2..dc0a096aac7fb 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -27,6 +27,7 @@
 #include <linux/preempt.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
+#include <linux/cleanup.h>
 #include <asm/processor.h>
 #include <linux/cpumask.h>
 
@@ -1058,4 +1059,6 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
+DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
+
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 4c715be487171..debdd9c3a5e51 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -16,6 +16,8 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/err.h>
+#include <linux/cleanup.h>
+
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 #include <linux/osq_lock.h>
 #endif
@@ -152,6 +154,13 @@ extern void up_read(struct rw_semaphore *sem);
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
index de21a45a4ee7d..10545f5f6bb5b 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -143,6 +143,8 @@ static inline void put_task_struct(struct task_struct *t)
 		__put_task_struct(t);
 }
 
+DEFINE_FREE(put_task, struct task_struct *, if (_T) put_task_struct(_T))
+
 static inline void put_task_struct_many(struct task_struct *t, int nr)
 {
 	if (refcount_sub_and_test(nr, &t->usage))
diff --git a/include/linux/slab.h b/include/linux/slab.h
index dd6897f620107..dac1c1decf76e 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/percpu-refcount.h>
+#include <linux/cleanup.h>
 
 
 /*
@@ -187,6 +188,8 @@ void kfree_sensitive(const void *);
 size_t __ksize(const void *);
 size_t ksize(const void *);
 
+DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
+
 #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
 void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
 			bool to_user);
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 79897841a2cc8..7a95b9a990ea8 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -57,6 +57,7 @@
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
+#include <linux/cleanup.h>
 #include <asm/barrier.h>
 #include <asm/mmiowb.h>
 
@@ -493,4 +494,35 @@ int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 
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
index a0895bbf71ce0..e35168e0b9523 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -205,4 +205,9 @@ static inline void smp_mb__after_srcu_read_unlock(void)
 	/* __srcu_read_unlock has smp_mb() internally so nothing to do here. */
 }
 
+DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
+		    _T->idx = srcu_read_lock(_T->lock),
+		    srcu_read_unlock(_T->lock, _T->idx),
+		    int idx)
+
 #endif
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0ad235ee96f91..9a1c5ac4ba07f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4522,7 +4522,7 @@ sub process {
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



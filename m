Return-Path: <stable+bounces-147030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA3AC55C9
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E561BA6C96
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0CA271464;
	Tue, 27 May 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bYD5TZd9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6E1E89C;
	Tue, 27 May 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366056; cv=none; b=aottABT6ZgUMIIO+MB4s7PyvlMjlL0rUyG3HmjUBb0217G46XNTQtG1yHRQx3+wSqhqkJy2P5Og/OByjk6wi4zC3uFctavnYBBo/F1VUknUZj73lJr2hxdqVqXIMuzavp8Ez7JNRItQwFgjFMNvgWY1SZLq5oQ/HODfTodpNL8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366056; c=relaxed/simple;
	bh=8kxnQRGN9w6vWqKscCX+6gSeRq+3HCYJ9cjHxp88xcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5IzC2FcdlC1HnAZk4uL3Fdf5FiXy+QVeh/r1zdOFL9nVgVTMc2lLzT2Ir4awAQHpsiJlHnCwJEJRbfeOGI7SxbNUY05AqhnsIxkLAn7EbC42PgGFZWaSiQeTA4I15acDy3HEoMz+MYao3bTNxXXaCpXA7ZIeahlUqAjBjZYykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bYD5TZd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E6EC4CEE9;
	Tue, 27 May 2025 17:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366056;
	bh=8kxnQRGN9w6vWqKscCX+6gSeRq+3HCYJ9cjHxp88xcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYD5TZd9jNUOkySMxvphPqTIQhrKS5HrRa6gaIpDMRNxWnEzWJAgZYfVza0/9dGWQ
	 GsVVHuqIKOfOq1S/J6pKp+R11S6/4PtvYgLnVYzANDDZJp1VIJIiB5+BSG8agqHSdM
	 KLNN12K8kzwCjZarsURkgLw2RAAOIZqjIE6qnKVQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raag Jadav <raag.jadav@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 546/626] driver core: Split devres APIs to device/devres.h
Date: Tue, 27 May 2025 18:27:19 +0200
Message-ID: <20250527162507.168983075@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit a21cad9312767d26b5257ce0662699bb202cdda1 ]

device.h is a huge header which is hard to follow and easy to miss
something. Improve that by splitting devres APIs to device/devres.h.

In particular this helps to speedup the build of the code that includes
device.h solely for a devres APIs.

While at it, cast the error pointers to __iomem using IOMEM_ERR_PTR()
and fix sparse warnings.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Stable-dep-of: 7dd7f39fce00 ("ASoC: SOF: Intel: hda: Fix UAF when reloading module")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/device.h        | 119 +-------------------------------
 include/linux/device/devres.h | 124 ++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 118 deletions(-)
 create mode 100644 include/linux/device/devres.h

diff --git a/include/linux/device.h b/include/linux/device.h
index 667cb6db90193..39120b172992e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -26,9 +26,9 @@
 #include <linux/atomic.h>
 #include <linux/uidgid.h>
 #include <linux/gfp.h>
-#include <linux/overflow.h>
 #include <linux/device/bus.h>
 #include <linux/device/class.h>
+#include <linux/device/devres.h>
 #include <linux/device/driver.h>
 #include <linux/cleanup.h>
 #include <asm/device.h>
@@ -281,123 +281,6 @@ int __must_check device_create_bin_file(struct device *dev,
 void device_remove_bin_file(struct device *dev,
 			    const struct bin_attribute *attr);
 
-/* device resource management */
-typedef void (*dr_release_t)(struct device *dev, void *res);
-typedef int (*dr_match_t)(struct device *dev, void *res, void *match_data);
-
-void *__devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp,
-			  int nid, const char *name) __malloc;
-#define devres_alloc(release, size, gfp) \
-	__devres_alloc_node(release, size, gfp, NUMA_NO_NODE, #release)
-#define devres_alloc_node(release, size, gfp, nid) \
-	__devres_alloc_node(release, size, gfp, nid, #release)
-
-void devres_for_each_res(struct device *dev, dr_release_t release,
-			 dr_match_t match, void *match_data,
-			 void (*fn)(struct device *, void *, void *),
-			 void *data);
-void devres_free(void *res);
-void devres_add(struct device *dev, void *res);
-void *devres_find(struct device *dev, dr_release_t release,
-		  dr_match_t match, void *match_data);
-void *devres_get(struct device *dev, void *new_res,
-		 dr_match_t match, void *match_data);
-void *devres_remove(struct device *dev, dr_release_t release,
-		    dr_match_t match, void *match_data);
-int devres_destroy(struct device *dev, dr_release_t release,
-		   dr_match_t match, void *match_data);
-int devres_release(struct device *dev, dr_release_t release,
-		   dr_match_t match, void *match_data);
-
-/* devres group */
-void * __must_check devres_open_group(struct device *dev, void *id, gfp_t gfp);
-void devres_close_group(struct device *dev, void *id);
-void devres_remove_group(struct device *dev, void *id);
-int devres_release_group(struct device *dev, void *id);
-
-/* managed devm_k.alloc/kfree for device drivers */
-void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __alloc_size(2);
-void *devm_krealloc(struct device *dev, void *ptr, size_t size,
-		    gfp_t gfp) __must_check __realloc_size(3);
-__printf(3, 0) char *devm_kvasprintf(struct device *dev, gfp_t gfp,
-				     const char *fmt, va_list ap) __malloc;
-__printf(3, 4) char *devm_kasprintf(struct device *dev, gfp_t gfp,
-				    const char *fmt, ...) __malloc;
-static inline void *devm_kzalloc(struct device *dev, size_t size, gfp_t gfp)
-{
-	return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
-}
-static inline void *devm_kmalloc_array(struct device *dev,
-				       size_t n, size_t size, gfp_t flags)
-{
-	size_t bytes;
-
-	if (unlikely(check_mul_overflow(n, size, &bytes)))
-		return NULL;
-
-	return devm_kmalloc(dev, bytes, flags);
-}
-static inline void *devm_kcalloc(struct device *dev,
-				 size_t n, size_t size, gfp_t flags)
-{
-	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
-}
-static inline __realloc_size(3, 4) void * __must_check
-devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
-{
-	size_t bytes;
-
-	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
-		return NULL;
-
-	return devm_krealloc(dev, p, bytes, flags);
-}
-
-void devm_kfree(struct device *dev, const void *p);
-char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
-const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
-void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp)
-	__realloc_size(3);
-
-unsigned long devm_get_free_pages(struct device *dev,
-				  gfp_t gfp_mask, unsigned int order);
-void devm_free_pages(struct device *dev, unsigned long addr);
-
-#ifdef CONFIG_HAS_IOMEM
-void __iomem *devm_ioremap_resource(struct device *dev,
-				    const struct resource *res);
-void __iomem *devm_ioremap_resource_wc(struct device *dev,
-				       const struct resource *res);
-
-void __iomem *devm_of_iomap(struct device *dev,
-			    struct device_node *node, int index,
-			    resource_size_t *size);
-#else
-
-static inline
-void __iomem *devm_ioremap_resource(struct device *dev,
-				    const struct resource *res)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-static inline
-void __iomem *devm_ioremap_resource_wc(struct device *dev,
-				       const struct resource *res)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-static inline
-void __iomem *devm_of_iomap(struct device *dev,
-			    struct device_node *node, int index,
-			    resource_size_t *size)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-#endif
-
 /* allows to add/remove a custom action to devres stack */
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
 void devm_release_action(struct device *dev, void (*action)(void *), void *data);
diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
new file mode 100644
index 0000000000000..6b0b265058bcc
--- /dev/null
+++ b/include/linux/device/devres.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DEVICE_DEVRES_H_
+#define _DEVICE_DEVRES_H_
+
+#include <linux/err.h>
+#include <linux/gfp_types.h>
+#include <linux/numa.h>
+#include <linux/overflow.h>
+#include <linux/stdarg.h>
+#include <linux/types.h>
+
+struct device;
+struct device_node;
+struct resource;
+
+/* device resource management */
+typedef void (*dr_release_t)(struct device *dev, void *res);
+typedef int (*dr_match_t)(struct device *dev, void *res, void *match_data);
+
+void * __malloc
+__devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp, int nid, const char *name);
+#define devres_alloc(release, size, gfp) \
+	__devres_alloc_node(release, size, gfp, NUMA_NO_NODE, #release)
+#define devres_alloc_node(release, size, gfp, nid) \
+	__devres_alloc_node(release, size, gfp, nid, #release)
+
+void devres_for_each_res(struct device *dev, dr_release_t release,
+			 dr_match_t match, void *match_data,
+			 void (*fn)(struct device *, void *, void *),
+			 void *data);
+void devres_free(void *res);
+void devres_add(struct device *dev, void *res);
+void *devres_find(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
+void *devres_get(struct device *dev, void *new_res, dr_match_t match, void *match_data);
+void *devres_remove(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
+int devres_destroy(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
+int devres_release(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
+
+/* devres group */
+void * __must_check devres_open_group(struct device *dev, void *id, gfp_t gfp);
+void devres_close_group(struct device *dev, void *id);
+void devres_remove_group(struct device *dev, void *id);
+int devres_release_group(struct device *dev, void *id);
+
+/* managed devm_k.alloc/kfree for device drivers */
+void * __alloc_size(2)
+devm_kmalloc(struct device *dev, size_t size, gfp_t gfp);
+void * __must_check __realloc_size(3)
+devm_krealloc(struct device *dev, void *ptr, size_t size, gfp_t gfp);
+static inline void *devm_kzalloc(struct device *dev, size_t size, gfp_t gfp)
+{
+	return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
+}
+static inline void *devm_kmalloc_array(struct device *dev, size_t n, size_t size, gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
+		return NULL;
+
+	return devm_kmalloc(dev, bytes, flags);
+}
+static inline void *devm_kcalloc(struct device *dev, size_t n, size_t size, gfp_t flags)
+{
+	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
+}
+static inline __realloc_size(3, 4) void * __must_check
+devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
+		return NULL;
+
+	return devm_krealloc(dev, p, bytes, flags);
+}
+
+void devm_kfree(struct device *dev, const void *p);
+
+void * __realloc_size(3)
+devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
+
+char * __malloc
+devm_kstrdup(struct device *dev, const char *s, gfp_t gfp);
+const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
+char * __printf(3, 0) __malloc
+devm_kvasprintf(struct device *dev, gfp_t gfp, const char *fmt, va_list ap);
+char * __printf(3, 4) __malloc
+devm_kasprintf(struct device *dev, gfp_t gfp, const char *fmt, ...);
+
+unsigned long devm_get_free_pages(struct device *dev, gfp_t gfp_mask, unsigned int order);
+void devm_free_pages(struct device *dev, unsigned long addr);
+
+#ifdef CONFIG_HAS_IOMEM
+
+void __iomem *devm_ioremap_resource(struct device *dev, const struct resource *res);
+void __iomem *devm_ioremap_resource_wc(struct device *dev, const struct resource *res);
+
+void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
+			    resource_size_t *size);
+#else
+
+static inline
+void __iomem *devm_ioremap_resource(struct device *dev, const struct resource *res)
+{
+	return IOMEM_ERR_PTR(-EINVAL);
+}
+
+static inline
+void __iomem *devm_ioremap_resource_wc(struct device *dev, const struct resource *res)
+{
+	return IOMEM_ERR_PTR(-EINVAL);
+}
+
+static inline
+void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
+			    resource_size_t *size)
+{
+	return IOMEM_ERR_PTR(-EINVAL);
+}
+
+#endif
+
+#endif /* _DEVICE_DEVRES_H_ */
-- 
2.39.5





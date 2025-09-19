Return-Path: <stable+bounces-180668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BBFB8A15A
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 16:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E477BE68F
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B1D316915;
	Fri, 19 Sep 2025 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SEHOegfF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856B31690F;
	Fri, 19 Sep 2025 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293468; cv=none; b=EZ6l9yfu2xnFlXCJ2/qDheIEn3aqj5Bp76vbToJKW1VXHH3nE88Zw1Qte/3OvR6bQJoRMUWBXzreFKWgeQT7DrPYaEot6zu+ChCVnrQrbOBsW7sDZSdrqVTi0H9B/himt7cgP1LpWBmXjZFF1uMDkzzbwJWYnVEXENNlQ0irGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293468; c=relaxed/simple;
	bh=9eHhMYBEl3vc8ixtTzxhx0cG/kcDt8AMpgIMGkiQT28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugzVHfyM9pFaIJAoTfAC/smGzzGWfk0x2yPIcMRbONiqI/k256Sc3Yyn1q2hTiDUIe+gCAPvhn7UD553IpkwJMRzR9E0m5P42p+57yVKeYHCCJqOLO+S2GBIX0asvFGBqHq68a96DhgN2LEsXn1AfJsd5xQYpumsszihMzsphrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SEHOegfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE031C4CEF0;
	Fri, 19 Sep 2025 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758293467;
	bh=9eHhMYBEl3vc8ixtTzxhx0cG/kcDt8AMpgIMGkiQT28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEHOegfFc4MjAdBC6Vzjrayc70vyuSZUbW4zMKclGiiOAHP36U/8uGAckEi3EQtE/
	 ASyrDEA/bvD6b2iyezjmm2A716u0O5RVS3DiYGuoWkMQ78LN7JULHWU7F4Tee9lIOs
	 FCCZH+X1EVnnlrOPVOYYmehscscEGU4/5/VSX04A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.48
Date: Fri, 19 Sep 2025 16:50:57 +0200
Message-ID: <2025091956-quaking-finite-c545@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091956-breeching-ceramics-a2b8@gregkh>
References: <2025091956-breeching-ceramics-a2b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
index 89c462653e2d..8cc848ae11cb 100644
--- a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
@@ -41,7 +41,7 @@ properties:
           - const: dma_intr2
 
   clocks:
-    minItems: 1
+    maxItems: 1
 
   clock-names:
     const: sw_baud
diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
index bd1967e2eab3..20fc901a08f4 100644
--- a/Documentation/filesystems/nfs/localio.rst
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -306,6 +306,19 @@ is issuing IO to the underlying local filesystem that it is sharing with
 the NFS server. See: fs/nfs/localio.c:nfs_local_doio() and
 fs/nfs/localio.c:nfs_local_commit().
 
+With normal NFS that makes use of RPC to issue IO to the server, if an
+application uses O_DIRECT the NFS client will bypass the pagecache but
+the NFS server will not. Because the NFS server's use of buffered IO
+affords applications to be less precise with their alignment when
+issuing IO to the NFS client. LOCALIO can be configured to use O_DIRECT
+semantics by setting the 'localio_O_DIRECT_semantics' nfs module
+parameter to Y, e.g.:
+
+  echo Y > /sys/module/nfs/parameters/localio_O_DIRECT_semantics
+
+Once enabled, it will cause LOCALIO to use O_DIRECT semantics (this may
+cause IO to fail if applications do not properly align their IO).
+
 Security
 ========
 
diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index dc190bf838fe..7e295bad8b29 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -22,65 +22,67 @@ definitions:
       doc: unused event
      -
       name: created
-      doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+      doc: >-
         A new MPTCP connection has been created. It is the good time to
         allocate memory and send ADD_ADDR if needed. Depending on the
         traffic-patterns it can take a long time until the
         MPTCP_EVENT_ESTABLISHED is sent.
+        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, server-side.
      -
       name: established
-      doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+      doc: >-
         A MPTCP connection is established (can start new subflows).
+        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, server-side.
      -
       name: closed
-      doc:
-        token
+      doc: >-
         A MPTCP connection has stopped.
+        Attribute: token.
      -
       name: announced
       value: 6
-      doc:
-        token, rem_id, family, daddr4 | daddr6 [, dport]
+      doc: >-
         A new address has been announced by the peer.
+        Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
      -
       name: removed
-      doc:
-        token, rem_id
+      doc: >-
         An address has been lost by the peer.
+        Attributes: token, rem_id.
      -
       name: sub-established
       value: 10
-      doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
+      doc: >-
         A new subflow has been established. 'error' should not be set.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, backup, if-idx [, error].
      -
       name: sub-closed
-      doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
+      doc: >-
         A subflow has been closed. An error (copy of sk_err) could be set if an
         error has been detected for this subflow.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, backup, if-idx [, error].
      -
       name: sub-priority
       value: 13
-      doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
+      doc: >-
         The priority of a subflow has changed. 'error' should not be set.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, backup, if-idx [, error].
      -
       name: listener-created
       value: 15
-      doc:
-        family, sport, saddr4 | saddr6
+      doc: >-
         A new PM listener is created.
+        Attributes: family, sport, saddr4 | saddr6.
      -
       name: listener-closed
-      doc:
-        family, sport, saddr4 | saddr6
+      doc: >-
         A PM listener is closed.
+        Attributes: family, sport, saddr4 | saddr6.
 
 attribute-sets:
   -
@@ -253,8 +255,8 @@ attribute-sets:
         name: timeout
         type: u32
       -
-        name: if_idx
-        type: u32
+        name: if-idx
+        type: s32
       -
         name: reset-reason
         type: u32
diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 62519d38c58b..58cc609e8669 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -742,7 +742,7 @@ The broadcast manager sends responses to user space in the same form:
             struct timeval ival1, ival2;    /* count and subsequent interval */
             canid_t can_id;                 /* unique can_id for task */
             __u32 nframes;                  /* number of can_frames following */
-            struct can_frame frames[0];
+            struct can_frame frames[];
     };
 
 The aligned payload 'frames' uses the same basic CAN frame structure defined
diff --git a/Makefile b/Makefile
index 2500f343c6c8..ede8c04ea112 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 47
+SUBLEVEL = 48
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
index aa103530a5c8..6081327e55f5 100644
--- a/arch/riscv/include/asm/compat.h
+++ b/arch/riscv/include/asm/compat.h
@@ -9,7 +9,6 @@
  */
 #include <linux/types.h>
 #include <linux/sched.h>
-#include <linux/sched/task_stack.h>
 #include <asm-generic/compat.h>
 
 static inline int is_compat_task(void)
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 6d6b057b562f..b017db3344cb 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -761,8 +761,6 @@ static int __hw_perf_event_init(struct perf_event *event, unsigned int type)
 		break;
 
 	case PERF_TYPE_HARDWARE:
-		if (is_sampling_event(event))	/* No sampling support */
-			return -ENOENT;
 		ev = attr->config;
 		if (!attr->exclude_user && attr->exclude_kernel) {
 			/*
@@ -860,6 +858,8 @@ static int cpumf_pmu_event_init(struct perf_event *event)
 	unsigned int type = event->attr.type;
 	int err = -ENOENT;
 
+	if (is_sampling_event(event))	/* No sampling support */
+		return err;
 	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_RAW)
 		err = __hw_perf_event_init(event, type);
 	else if (event->pmu->type == type)
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 10725f5a6f0f..11200880a96c 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -286,10 +286,10 @@ static int paicrypt_event_init(struct perf_event *event)
 	/* PAI crypto PMU registered as PERF_TYPE_RAW, check event type */
 	if (a->type != PERF_TYPE_RAW && event->pmu->type != a->type)
 		return -ENOENT;
-	/* PAI crypto event must be in valid range */
+	/* PAI crypto event must be in valid range, try others if not */
 	if (a->config < PAI_CRYPTO_BASE ||
 	    a->config > PAI_CRYPTO_BASE + paicrypt_cnt)
-		return -EINVAL;
+		return -ENOENT;
 	/* Allow only CRYPTO_ALL for sampling */
 	if (a->sample_period && a->config != PAI_CRYPTO_BASE)
 		return -EINVAL;
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index a8f0bad99cf0..28398e313b58 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -266,7 +266,7 @@ static int paiext_event_valid(struct perf_event *event)
 		event->hw.config_base = offsetof(struct paiext_cb, acc);
 		return 0;
 	}
-	return -EINVAL;
+	return -ENOENT;
 }
 
 /* Might be called on different CPU than the one the event is intended for. */
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 0fab130a8249..78d05a068af4 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -174,24 +174,27 @@ static void topoext_fixup(struct topo_scan *tscan)
 
 static void parse_topology_amd(struct topo_scan *tscan)
 {
-	bool has_topoext = false;
-
 	/*
-	 * If the extended topology leaf 0x8000_001e is available
-	 * try to get SMT, CORE, TILE, and DIE shifts from extended
+	 * Try to get SMT, CORE, TILE, and DIE shifts from extended
 	 * CPUID leaf 0x8000_0026 on supported processors first. If
 	 * extended CPUID leaf 0x8000_0026 is not supported, try to
-	 * get SMT and CORE shift from leaf 0xb first, then try to
-	 * get the CORE shift from leaf 0x8000_0008.
+	 * get SMT and CORE shift from leaf 0xb. If either leaf is
+	 * available, cpu_parse_topology_ext() will return true.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
-		has_topoext = cpu_parse_topology_ext(tscan);
+	bool has_xtopology = cpu_parse_topology_ext(tscan);
 
-	if (!has_topoext && !parse_8000_0008(tscan))
+	/*
+	 * If XTOPOLOGY leaves (0x26/0xb) are not available, try to
+	 * get the CORE shift from leaf 0x8000_0008 first.
+	 */
+	if (!has_xtopology && !parse_8000_0008(tscan))
 		return;
 
-	/* Prefer leaf 0x8000001e if available */
-	if (parse_8000_001e(tscan, has_topoext))
+	/*
+	 * Prefer leaf 0x8000001e if available to get the SMT shift and
+	 * the initial APIC ID if XTOPOLOGY leaves are not available.
+	 */
+	if (parse_8000_001e(tscan, has_xtopology))
 		return;
 
 	/* Try the NODEID MSR */
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e2567c8f6bac..26449cd74c26 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -486,10 +486,18 @@ SECTIONS
 }
 
 /*
- * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
+ * COMPILE_TEST kernels can be large - CONFIG_KASAN, for example, can cause
+ * this.  Let's assume that nobody will be running a COMPILE_TEST kernel and
+ * let's assert that fuller build coverage is more valuable than being able to
+ * run a COMPILE_TEST kernel.
+ */
+#ifndef CONFIG_COMPILE_TEST
+/*
+ * The ASSERT() sync to . is intentional, for binutils 2.14 compatibility:
  */
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
+#endif
 
 /* needed for Clang - see arch/x86/entry/entry.S */
 PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index fee04fdb0822..b46eb8a552d7 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -36,7 +36,6 @@ config UDMABUF
 	depends on DMA_SHARED_BUFFER
 	depends on MEMFD_CREATE || COMPILE_TEST
 	depends on MMU
-	select VMAP_PFN
 	help
 	  A driver to let userspace turn memfd regions into dma-bufs.
 	  Qemu can use this to create host dmabufs for guest framebuffers.
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 959f690b1226..0e127a9109e7 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -74,29 +74,21 @@ static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
 static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
 {
 	struct udmabuf *ubuf = buf->priv;
-	unsigned long *pfns;
+	struct page **pages;
 	void *vaddr;
 	pgoff_t pg;
 
 	dma_resv_assert_held(buf->resv);
 
-	/**
-	 * HVO may free tail pages, so just use pfn to map each folio
-	 * into vmalloc area.
-	 */
-	pfns = kvmalloc_array(ubuf->pagecount, sizeof(*pfns), GFP_KERNEL);
-	if (!pfns)
+	pages = kvmalloc_array(ubuf->pagecount, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
 		return -ENOMEM;
 
-	for (pg = 0; pg < ubuf->pagecount; pg++) {
-		unsigned long pfn = folio_pfn(ubuf->folios[pg]);
-
-		pfn += ubuf->offsets[pg] >> PAGE_SHIFT;
-		pfns[pg] = pfn;
-	}
+	for (pg = 0; pg < ubuf->pagecount; pg++)
+		pages[pg] = &ubuf->folios[pg]->page;
 
-	vaddr = vmap_pfn(pfns, ubuf->pagecount, PAGE_KERNEL);
-	kvfree(pfns);
+	vaddr = vm_map_ram(pages, ubuf->pagecount, -1);
+	kvfree(pages);
 	if (!vaddr)
 		return -EINVAL;
 
diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
index 4fb8508419db..deadf135681b 100644
--- a/drivers/dma/dw/rzn1-dmamux.c
+++ b/drivers/dma/dw/rzn1-dmamux.c
@@ -48,12 +48,16 @@ static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	u32 mask;
 	int ret;
 
-	if (dma_spec->args_count != RNZ1_DMAMUX_NCELLS)
-		return ERR_PTR(-EINVAL);
+	if (dma_spec->args_count != RNZ1_DMAMUX_NCELLS) {
+		ret = -EINVAL;
+		goto put_device;
+	}
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
-	if (!map)
-		return ERR_PTR(-ENOMEM);
+	if (!map) {
+		ret = -ENOMEM;
+		goto put_device;
+	}
 
 	chan = dma_spec->args[0];
 	map->req_idx = dma_spec->args[4];
@@ -94,12 +98,15 @@ static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	if (ret)
 		goto clear_bitmap;
 
+	put_device(&pdev->dev);
 	return map;
 
 clear_bitmap:
 	clear_bit(map->req_idx, dmamux->used_chans);
 free_map:
 	kfree(map);
+put_device:
+	put_device(&pdev->dev);
 
 	return ERR_PTR(ret);
 }
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 18997f80bdc9..74a83203181d 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -187,27 +187,30 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->wq_enable_map) {
 		rc = -ENOMEM;
-		goto err_bitmap;
+		goto err_free_wqs;
 	}
 
 	for (i = 0; i < idxd->max_wqs; i++) {
 		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
 		if (!wq) {
 			rc = -ENOMEM;
-			goto err;
+			goto err_unwind;
 		}
 
 		idxd_dev_set_type(&wq->idxd_dev, IDXD_DEV_WQ);
 		conf_dev = wq_confdev(wq);
 		wq->id = i;
 		wq->idxd = idxd;
-		device_initialize(wq_confdev(wq));
+		device_initialize(conf_dev);
 		conf_dev->parent = idxd_confdev(idxd);
 		conf_dev->bus = &dsa_bus_type;
 		conf_dev->type = &idxd_wq_device_type;
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
-		if (rc < 0)
-			goto err;
+		if (rc < 0) {
+			put_device(conf_dev);
+			kfree(wq);
+			goto err_unwind;
+		}
 
 		mutex_init(&wq->wq_lock);
 		init_waitqueue_head(&wq->err_queue);
@@ -218,15 +221,20 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
+			put_device(conf_dev);
+			kfree(wq);
 			rc = -ENOMEM;
-			goto err;
+			goto err_unwind;
 		}
 
 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
+				kfree(wq->wqcfg);
+				put_device(conf_dev);
+				kfree(wq);
 				rc = -ENOMEM;
-				goto err_opcap_bmap;
+				goto err_unwind;
 			}
 			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 		}
@@ -237,13 +245,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 
 	return 0;
 
-err_opcap_bmap:
-	kfree(wq->wqcfg);
-
-err:
-	put_device(conf_dev);
-	kfree(wq);
-
+err_unwind:
 	while (--i >= 0) {
 		wq = idxd->wqs[i];
 		if (idxd->hw.wq_cap.op_config)
@@ -252,11 +254,10 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
 		kfree(wq);
-
 	}
 	bitmap_free(idxd->wq_enable_map);
 
-err_bitmap:
+err_free_wqs:
 	kfree(idxd->wqs);
 
 	return rc;
@@ -918,10 +919,12 @@ static void idxd_remove(struct pci_dev *pdev)
 	device_unregister(idxd_confdev(idxd));
 	idxd_shutdown(pdev);
 	idxd_device_remove_debugfs(idxd);
-	idxd_cleanup(idxd);
+	perfmon_pmu_remove(idxd);
+	idxd_cleanup_interrupts(idxd);
+	if (device_pasid_enabled(idxd))
+		idxd_disable_system_pasid(idxd);
 	pci_iounmap(pdev, idxd->reg_base);
 	put_device(idxd_confdev(idxd));
-	idxd_free(idxd);
 	pci_disable_device(pdev);
 }
 
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d43a881e43b9..348bb9a5c87b 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1283,13 +1283,17 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (!bdev->bamclk) {
 		ret = of_property_read_u32(pdev->dev.of_node, "num-channels",
 					   &bdev->num_channels);
-		if (ret)
+		if (ret) {
 			dev_err(bdev->dev, "num-channels unspecified in dt\n");
+			return ret;
+		}
 
 		ret = of_property_read_u32(pdev->dev.of_node, "qcom,num-ees",
 					   &bdev->num_ees);
-		if (ret)
+		if (ret) {
 			dev_err(bdev->dev, "num-ees unspecified in dt\n");
+			return ret;
+		}
 	}
 
 	ret = clk_prepare_enable(bdev->bamclk);
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 7f861fb07cb8..6333426b4c96 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2063,8 +2063,8 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	 * priority. So Q0 is the highest priority queue and the last queue has
 	 * the lowest priority.
 	 */
-	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
-					  GFP_KERNEL);
+	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1,
+					  sizeof(*queue_priority_map), GFP_KERNEL);
 	if (!queue_priority_map)
 		return -ENOMEM;
 
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index a059964b97f8..605493b50806 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -128,7 +128,6 @@ static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
 
 	ptemp = dma_alloc_coherent(mci->pdev, 16, &dma_handle, GFP_KERNEL);
 	if (!ptemp) {
-		dma_free_coherent(mci->pdev, 16, ptemp, dma_handle);
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Inject: Buffer Allocation error\n");
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 10da6e550d76..bc86a4455090 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -400,9 +400,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
 	ring->me = 0;
-
-	if (!ring->is_mes_queue)
-		ring->adev->rings[ring->idx] = NULL;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index be86f86b49e9..970041452096 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1813,15 +1813,19 @@ static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
 				struct amdgpu_job *job)
 {
 	struct drm_gpu_scheduler **scheds;
-
-	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&job->base.entity->fence_seq))
-		return -EINVAL;
+	struct dma_fence *fence;
 
 	/* if VCN0 is harvested, we can't support AV1 */
 	if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
 		return -EINVAL;
 
+	/* wait for all jobs to finish before switching to instance 0 */
+	fence = amdgpu_ctx_get_fence(p->ctx, job->base.entity, ~0ull);
+	if (fence) {
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+	}
+
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
 		[AMDGPU_RING_PRIO_DEFAULT].sched;
 	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index f391f0c54043..33d413444a46 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1737,15 +1737,19 @@ static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p,
 				struct amdgpu_job *job)
 {
 	struct drm_gpu_scheduler **scheds;
-
-	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&job->base.entity->fence_seq))
-		return -EINVAL;
+	struct dma_fence *fence;
 
 	/* if VCN0 is harvested, we can't support AV1 */
 	if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
 		return -EINVAL;
 
+	/* wait for all jobs to finish before switching to instance 0 */
+	fence = amdgpu_ctx_get_fence(p->ctx, job->base.entity, ~0ull);
+	if (fence) {
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+	}
+
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
 		[AMDGPU_RING_PRIO_0].sched;
 	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
@@ -1836,22 +1840,16 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 #define RADEON_VCN_ENGINE_TYPE_ENCODE			(0x00000002)
 #define RADEON_VCN_ENGINE_TYPE_DECODE			(0x00000003)
-
 #define RADEON_VCN_ENGINE_INFO				(0x30000001)
-#define RADEON_VCN_ENGINE_INFO_MAX_OFFSET		16
-
 #define RENCODE_ENCODE_STANDARD_AV1			2
 #define RENCODE_IB_PARAM_SESSION_INIT			0x00000003
-#define RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET	64
 
-/* return the offset in ib if id is found, -1 otherwise
- * to speed up the searching we only search upto max_offset
- */
-static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int max_offset)
+/* return the offset in ib if id is found, -1 otherwise */
+static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int start)
 {
 	int i;
 
-	for (i = 0; i < ib->length_dw && i < max_offset && ib->ptr[i] >= 8; i += ib->ptr[i]/4) {
+	for (i = start; i < ib->length_dw && ib->ptr[i] >= 8; i += ib->ptr[i] / 4) {
 		if (ib->ptr[i + 1] == id)
 			return i;
 	}
@@ -1866,33 +1864,29 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	struct amdgpu_vcn_decode_buffer *decode_buffer;
 	uint64_t addr;
 	uint32_t val;
-	int idx;
+	int idx = 0, sidx;
 
 	/* The first instance can decode anything */
 	if (!ring->me)
 		return 0;
 
-	/* RADEON_VCN_ENGINE_INFO is at the top of ib block */
-	idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO,
-			RADEON_VCN_ENGINE_INFO_MAX_OFFSET);
-	if (idx < 0) /* engine info is missing */
-		return 0;
-
-	val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
-	if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
-		decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];
-
-		if (!(decode_buffer->valid_buf_flag  & 0x1))
-			return 0;
-
-		addr = ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
-			decode_buffer->msg_buffer_address_lo;
-		return vcn_v4_0_dec_msg(p, job, addr);
-	} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
-		idx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT,
-			RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
-		if (idx >= 0 && ib->ptr[idx + 2] == RENCODE_ENCODE_STANDARD_AV1)
-			return vcn_v4_0_limit_sched(p, job);
+	while ((idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO, idx)) >= 0) {
+		val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
+		if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
+			decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];
+
+			if (!(decode_buffer->valid_buf_flag & 0x1))
+				return 0;
+
+			addr = ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
+				decode_buffer->msg_buffer_address_lo;
+			return vcn_v4_0_dec_msg(p, job, addr);
+		} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
+			sidx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT, idx);
+			if (sidx >= 0 && ib->ptr[sidx + 2] == RENCODE_ENCODE_STANDARD_AV1)
+				return vcn_v4_0_limit_sched(p, job);
+		}
+		idx += ib->ptr[idx] / 4;
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 48ab93e715c8..6e4f9c6108f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -239,6 +239,13 @@ static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
+	{
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
 };
 
 static const struct amdgpu_video_codecs cz_video_codecs_decode =
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9763752cf5cd..b585c321d345 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11483,6 +11483,11 @@ static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 		new_plane_state = drm_atomic_get_plane_state(state, plane);
 		old_plane_state = drm_atomic_get_plane_state(state, plane);
 
+		if (IS_ERR(new_plane_state) || IS_ERR(old_plane_state)) {
+			DRM_ERROR("Failed to get plane state for plane %s\n", plane->name);
+			return false;
+		}
+
 		if (old_plane_state->fb && new_plane_state->fb &&
 		    get_mem_type(old_plane_state->fb) != get_mem_type(new_plane_state->fb))
 			return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index 01480a04f85e..9a3be1dd352b 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -483,11 +483,10 @@ void dpp1_set_cursor_position(
 	if (src_y_offset + cursor_height <= 0)
 		cur_en = 0;  /* not visible beyond top edge*/
 
-	if (dpp_base->pos.cur0_ctl.bits.cur0_enable != cur_en) {
-		REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
+	REG_UPDATE(CURSOR0_CONTROL,
+			CUR0_ENABLE, cur_en);
 
-		dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
-	}
+	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
 }
 
 void dpp1_cnv_set_optional_cursor_attributes(
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index 712aff7e17f7..92b34fe47f74 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -155,11 +155,9 @@ void dpp401_set_cursor_position(
 	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
-	if (dpp_base->pos.cur0_ctl.bits.cur0_enable != cur_en) {
-		REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
+	REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
 
-		dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
-	}
+	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
 }
 
 void dpp401_set_optional_cursor_attributes(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index c74ee2d50a69..b405fa22f87a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -1044,13 +1044,11 @@ void hubp2_cursor_set_position(
 	if (src_y_offset + cursor_height <= 0)
 		cur_en = 0;  /* not visible beyond top edge*/
 
-	if (hubp->pos.cur_ctl.bits.cur_enable != cur_en) {
-		if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
-			hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
+	if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
+		hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
 
-		REG_UPDATE(CURSOR_CONTROL,
+	REG_UPDATE(CURSOR_CONTROL,
 			CURSOR_ENABLE, cur_en);
-	}
 
 	REG_SET_2(CURSOR_POSITION, 0,
 			CURSOR_X_POSITION, pos->x,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 7013c124efcf..2d52100510f0 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -718,13 +718,11 @@ void hubp401_cursor_set_position(
 			dc_fixpt_from_int(dst_x_offset),
 			param->h_scale_ratio));
 
-	if (hubp->pos.cur_ctl.bits.cur_enable != cur_en) {
-		if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
-			hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
+	if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
+		hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
 
-		REG_UPDATE(CURSOR_CONTROL,
-			CURSOR_ENABLE, cur_en);
-	}
+	REG_UPDATE(CURSOR_CONTROL,
+		CURSOR_ENABLE, cur_en);
 
 	REG_SET_2(CURSOR_POSITION, 0,
 		CURSOR_X_POSITION, x_pos,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 08fc2a2c399f..d96f52a55194 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -945,7 +945,7 @@ enum dc_status dcn20_enable_stream_timing(
 		return DC_ERROR_UNEXPECTED;
 	}
 
-	fsleep(stream->timing.v_total * (stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz));
+	udelay(stream->timing.v_total * (stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz));
 
 	params.vertical_total_min = stream->adjust.v_total_min;
 	params.vertical_total_max = stream->adjust.v_total_max;
diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index ef2fdbf97346..85335d8dfec1 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -1150,7 +1150,7 @@ static void icl_mbus_init(struct drm_i915_private *dev_priv)
 	if (DISPLAY_VER(dev_priv) == 12)
 		abox_regs |= BIT(0);
 
-	for_each_set_bit(i, &abox_regs, sizeof(abox_regs))
+	for_each_set_bit(i, &abox_regs, BITS_PER_TYPE(abox_regs))
 		intel_de_rmw(dev_priv, MBUS_ABOX_CTL(i), mask, val);
 }
 
@@ -1603,11 +1603,11 @@ static void tgl_bw_buddy_init(struct drm_i915_private *dev_priv)
 	if (table[config].page_mask == 0) {
 		drm_dbg(&dev_priv->drm,
 			"Unknown memory configuration; disabling address buddy logic.\n");
-		for_each_set_bit(i, &abox_mask, sizeof(abox_mask))
+		for_each_set_bit(i, &abox_mask, BITS_PER_TYPE(abox_mask))
 			intel_de_write(dev_priv, BW_BUDDY_CTL(i),
 				       BW_BUDDY_DISABLE);
 	} else {
-		for_each_set_bit(i, &abox_mask, sizeof(abox_mask)) {
+		for_each_set_bit(i, &abox_mask, BITS_PER_TYPE(abox_mask)) {
 			intel_de_write(dev_priv, BW_BUDDY_PAGE_MASK(i),
 				       table[config].page_mask);
 
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index b48373b16677..355a21eb4844 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -1469,6 +1469,19 @@ static void __reset_guc_busyness_stats(struct intel_guc *guc)
 	spin_unlock_irqrestore(&guc->timestamp.lock, flags);
 }
 
+static void __update_guc_busyness_running_state(struct intel_guc *guc)
+{
+	struct intel_gt *gt = guc_to_gt(guc);
+	struct intel_engine_cs *engine;
+	enum intel_engine_id id;
+	unsigned long flags;
+
+	spin_lock_irqsave(&guc->timestamp.lock, flags);
+	for_each_engine(engine, gt, id)
+		engine->stats.guc.running = false;
+	spin_unlock_irqrestore(&guc->timestamp.lock, flags);
+}
+
 static void __update_guc_busyness_stats(struct intel_guc *guc)
 {
 	struct intel_gt *gt = guc_to_gt(guc);
@@ -1619,6 +1632,9 @@ void intel_guc_busyness_park(struct intel_gt *gt)
 	if (!guc_submission_initialized(guc))
 		return;
 
+	/* Assume no engines are running and set running state to false */
+	__update_guc_busyness_running_state(guc);
+
 	/*
 	 * There is a race with suspend flow where the worker runs after suspend
 	 * and causes an unclaimed register access warning. Cancel the worker
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 2508e9e9431d..b08921902568 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -381,11 +381,11 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 
 		of_id = of_match_node(mtk_drm_of_ids, node);
 		if (!of_id)
-			goto next_put_node;
+			continue;
 
 		pdev = of_find_device_by_node(node);
 		if (!pdev)
-			goto next_put_node;
+			continue;
 
 		drm_dev = device_find_child(&pdev->dev, NULL, mtk_drm_match);
 		if (!drm_dev)
@@ -411,11 +411,10 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 next_put_device_pdev_dev:
 		put_device(&pdev->dev);
 
-next_put_node:
-		of_node_put(node);
-
-		if (cnt == MAX_CRTC)
+		if (cnt == MAX_CRTC) {
+			of_node_put(node);
 			break;
+		}
 	}
 
 	if (drm_priv->data->mmsys_dev_num == cnt) {
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index c520f156e2d7..03eb7d52209a 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1023,7 +1023,7 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 	struct drm_panthor_queue_create *queue_args;
 	int ret;
 
-	if (!args->queues.count)
+	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
 		return -EINVAL;
 
 	ret = PANTHOR_UOBJ_GET_ARRAY(queue_args, &args->queues);
diff --git a/drivers/gpu/drm/xe/tests/xe_bo.c b/drivers/gpu/drm/xe/tests/xe_bo.c
index 8dac069483e8..754df8e9d38a 100644
--- a/drivers/gpu/drm/xe/tests/xe_bo.c
+++ b/drivers/gpu/drm/xe/tests/xe_bo.c
@@ -222,7 +222,7 @@ static int evict_test_run_tile(struct xe_device *xe, struct xe_tile *tile, struc
 		}
 
 		xe_bo_lock(external, false);
-		err = xe_bo_pin_external(external);
+		err = xe_bo_pin_external(external, false);
 		xe_bo_unlock(external);
 		if (err) {
 			KUNIT_FAIL(test, "external bo pin err=%pe\n",
diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
index cedd3e88a6fb..5a6e0206989d 100644
--- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
@@ -89,15 +89,7 @@ static void check_residency(struct kunit *test, struct xe_bo *exported,
 		return;
 	}
 
-	/*
-	 * If on different devices, the exporter is kept in system  if
-	 * possible, saving a migration step as the transfer is just
-	 * likely as fast from system memory.
-	 */
-	if (params->mem_mask & XE_BO_FLAG_SYSTEM)
-		KUNIT_EXPECT_TRUE(test, xe_bo_is_mem_type(exported, XE_PL_TT));
-	else
-		KUNIT_EXPECT_TRUE(test, xe_bo_is_mem_type(exported, mem_type));
+	KUNIT_EXPECT_TRUE(test, xe_bo_is_mem_type(exported, mem_type));
 
 	if (params->force_different_devices)
 		KUNIT_EXPECT_TRUE(test, xe_bo_is_mem_type(imported, XE_PL_TT));
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 445bbe0299b0..b5058a35c451 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -157,6 +157,8 @@ static void try_add_system(struct xe_device *xe, struct xe_bo *bo,
 
 		bo->placements[*c] = (struct ttm_place) {
 			.mem_type = XE_PL_TT,
+			.flags = (bo_flags & XE_BO_FLAG_VRAM_MASK) ?
+			TTM_PL_FLAG_FALLBACK : 0,
 		};
 		*c += 1;
 	}
@@ -1743,6 +1745,7 @@ uint64_t vram_region_gpu_offset(struct ttm_resource *res)
 /**
  * xe_bo_pin_external - pin an external BO
  * @bo: buffer object to be pinned
+ * @in_place: Pin in current placement, don't attempt to migrate.
  *
  * Pin an external (not tied to a VM, can be exported via dma-buf / prime FD)
  * BO. Unique call compared to xe_bo_pin as this function has it own set of
@@ -1750,7 +1753,7 @@ uint64_t vram_region_gpu_offset(struct ttm_resource *res)
  *
  * Returns 0 for success, negative error code otherwise.
  */
-int xe_bo_pin_external(struct xe_bo *bo)
+int xe_bo_pin_external(struct xe_bo *bo, bool in_place)
 {
 	struct xe_device *xe = xe_bo_device(bo);
 	int err;
@@ -1759,9 +1762,11 @@ int xe_bo_pin_external(struct xe_bo *bo)
 	xe_assert(xe, xe_bo_is_user(bo));
 
 	if (!xe_bo_is_pinned(bo)) {
-		err = xe_bo_validate(bo, NULL, false);
-		if (err)
-			return err;
+		if (!in_place) {
+			err = xe_bo_validate(bo, NULL, false);
+			if (err)
+				return err;
+		}
 
 		if (xe_bo_is_vram(bo)) {
 			spin_lock(&xe->pinned.lock);
@@ -1913,6 +1918,9 @@ int xe_bo_validate(struct xe_bo *bo, struct xe_vm *vm, bool allow_res_evict)
 		.no_wait_gpu = false,
 	};
 
+	if (xe_bo_is_pinned(bo))
+		return 0;
+
 	if (vm) {
 		lockdep_assert_held(&vm->lock);
 		xe_vm_assert_held(vm);
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index d04159c59846..5e982be66c74 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -173,7 +173,7 @@ static inline void xe_bo_unlock_vm_held(struct xe_bo *bo)
 	}
 }
 
-int xe_bo_pin_external(struct xe_bo *bo);
+int xe_bo_pin_external(struct xe_bo *bo, bool in_place);
 int xe_bo_pin(struct xe_bo *bo);
 void xe_bo_unpin_external(struct xe_bo *bo);
 void xe_bo_unpin(struct xe_bo *bo);
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 78204578443f..a41f453bab59 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -72,7 +72,7 @@ static int xe_dma_buf_pin(struct dma_buf_attachment *attach)
 		return ret;
 	}
 
-	ret = xe_bo_pin_external(bo);
+	ret = xe_bo_pin_external(bo, true);
 	xe_assert(xe, !ret);
 
 	return 0;
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 75dab01d43a7..be7ca6a0ebeb 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1057,7 +1057,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, METEOR_LAKE_P_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
 	{ PCI_DEVICE_DATA(INTEL, METEOR_LAKE_SOC_S_SMBUS,	FEATURES_ICH5 | FEATURE_TCO_CNL) },
 	{ PCI_DEVICE_DATA(INTEL, METEOR_LAKE_PCH_S_SMBUS,	FEATURES_ICH5 | FEATURE_TCO_CNL) },
-	{ PCI_DEVICE_DATA(INTEL, BIRCH_STREAM_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
+	{ PCI_DEVICE_DATA(INTEL, BIRCH_STREAM_SMBUS,		FEATURES_ICH5)			 },
 	{ PCI_DEVICE_DATA(INTEL, ARROW_LAKE_H_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
 	{ PCI_DEVICE_DATA(INTEL, PANTHER_LAKE_H_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
 	{ PCI_DEVICE_DATA(INTEL, PANTHER_LAKE_P_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
diff --git a/drivers/input/misc/iqs7222.c b/drivers/input/misc/iqs7222.c
index 846aac9a5c9d..7a2e34949854 100644
--- a/drivers/input/misc/iqs7222.c
+++ b/drivers/input/misc/iqs7222.c
@@ -2430,6 +2430,9 @@ static int iqs7222_parse_chan(struct iqs7222_private *iqs7222,
 		if (error)
 			return error;
 
+		if (!iqs7222->kp_type[chan_index][i])
+			continue;
+
 		if (!dev_desc->event_offset)
 			continue;
 
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 8813db7eec39..630cdd5a1328 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1155,6 +1155,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "XxHP4NAx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "XxKK4NAx_XxSP4NAx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	/*
 	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
 	 * after suspend fixable with the forcenorestore quirk.
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 6f8eb7fa4c59..5b02119d8ba2 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1377,14 +1377,24 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 	if (ret)
 		return ret;
 
+	/*
+	 * Read setup timing depends on the operation done on the NAND:
+	 *
+	 * NRD_SETUP = max(tAR, tCLR)
+	 */
+	timeps = max(conf->timings.sdr.tAR_min, conf->timings.sdr.tCLR_min);
+	ncycles = DIV_ROUND_UP(timeps, mckperiodps);
+	totalcycles += ncycles;
+	ret = atmel_smc_cs_conf_set_setup(smcconf, ATMEL_SMC_NRD_SHIFT, ncycles);
+	if (ret)
+		return ret;
+
 	/*
 	 * The read cycle timing is directly matching tRC, but is also
 	 * dependent on the setup and hold timings we calculated earlier,
 	 * which gives:
 	 *
-	 * NRD_CYCLE = max(tRC, NRD_PULSE + NRD_HOLD)
-	 *
-	 * NRD_SETUP is always 0.
+	 * NRD_CYCLE = max(tRC, NRD_SETUP + NRD_PULSE + NRD_HOLD)
 	 */
 	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRC_min, mckperiodps);
 	ncycles = max(totalcycles, ncycles);
diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 0f67e96cc240..7488a4969502 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -272,6 +272,7 @@ struct stm32_fmc2_nfc {
 	struct sg_table dma_data_sg;
 	struct sg_table dma_ecc_sg;
 	u8 *ecc_buf;
+	dma_addr_t dma_ecc_addr;
 	int dma_ecc_len;
 	u32 tx_dma_max_burst;
 	u32 rx_dma_max_burst;
@@ -902,17 +903,10 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 
 	if (!write_data && !raw) {
 		/* Configure DMA ECC status */
-		p = nfc->ecc_buf;
 		for_each_sg(nfc->dma_ecc_sg.sgl, sg, eccsteps, s) {
-			sg_set_buf(sg, p, nfc->dma_ecc_len);
-			p += nfc->dma_ecc_len;
-		}
-
-		ret = dma_map_sg(nfc->dev, nfc->dma_ecc_sg.sgl,
-				 eccsteps, dma_data_dir);
-		if (!ret) {
-			ret = -EIO;
-			goto err_unmap_data;
+			sg_dma_address(sg) = nfc->dma_ecc_addr +
+					     s * nfc->dma_ecc_len;
+			sg_dma_len(sg) = nfc->dma_ecc_len;
 		}
 
 		desc_ecc = dmaengine_prep_slave_sg(nfc->dma_ecc_ch,
@@ -921,7 +915,7 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 						   DMA_PREP_INTERRUPT);
 		if (!desc_ecc) {
 			ret = -ENOMEM;
-			goto err_unmap_ecc;
+			goto err_unmap_data;
 		}
 
 		reinit_completion(&nfc->dma_ecc_complete);
@@ -929,7 +923,7 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 		desc_ecc->callback_param = &nfc->dma_ecc_complete;
 		ret = dma_submit_error(dmaengine_submit(desc_ecc));
 		if (ret)
-			goto err_unmap_ecc;
+			goto err_unmap_data;
 
 		dma_async_issue_pending(nfc->dma_ecc_ch);
 	}
@@ -949,7 +943,7 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 		if (!write_data && !raw)
 			dmaengine_terminate_all(nfc->dma_ecc_ch);
 		ret = -ETIMEDOUT;
-		goto err_unmap_ecc;
+		goto err_unmap_data;
 	}
 
 	/* Wait DMA data transfer completion */
@@ -969,11 +963,6 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 		}
 	}
 
-err_unmap_ecc:
-	if (!write_data && !raw)
-		dma_unmap_sg(nfc->dev, nfc->dma_ecc_sg.sgl,
-			     eccsteps, dma_data_dir);
-
 err_unmap_data:
 	dma_unmap_sg(nfc->dev, nfc->dma_data_sg.sgl, eccsteps, dma_data_dir);
 
@@ -996,9 +985,21 @@ static int stm32_fmc2_nfc_seq_write(struct nand_chip *chip, const u8 *buf,
 
 	/* Write oob */
 	if (oob_required) {
-		ret = nand_change_write_column_op(chip, mtd->writesize,
-						  chip->oob_poi, mtd->oobsize,
-						  false);
+		unsigned int offset_in_page = mtd->writesize;
+		const void *buf = chip->oob_poi;
+		unsigned int len = mtd->oobsize;
+
+		if (!raw) {
+			struct mtd_oob_region oob_free;
+
+			mtd_ooblayout_free(mtd, 0, &oob_free);
+			offset_in_page += oob_free.offset;
+			buf += oob_free.offset;
+			len = oob_free.length;
+		}
+
+		ret = nand_change_write_column_op(chip, offset_in_page,
+						  buf, len, false);
 		if (ret)
 			return ret;
 	}
@@ -1610,7 +1611,8 @@ static int stm32_fmc2_nfc_dma_setup(struct stm32_fmc2_nfc *nfc)
 		return ret;
 
 	/* Allocate a buffer to store ECC status registers */
-	nfc->ecc_buf = devm_kzalloc(nfc->dev, FMC2_MAX_ECC_BUF_LEN, GFP_KERNEL);
+	nfc->ecc_buf = dmam_alloc_coherent(nfc->dev, FMC2_MAX_ECC_BUF_LEN,
+					   &nfc->dma_ecc_addr, GFP_KERNEL);
 	if (!nfc->ecc_buf)
 		return -ENOMEM;
 
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index a33ad04e99cc..d1666b315181 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -122,6 +122,41 @@ static const struct mtd_ooblayout_ops w25n02kv_ooblayout = {
 	.free = w25n02kv_ooblayout_free,
 };
 
+static int w25n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 12;
+	region->length = 4;
+
+	return 0;
+}
+
+static int w25n01jw_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section);
+	region->length = 12;
+
+	/* Extract BBM */
+	if (!section) {
+		region->offset += 2;
+		region->length -= 2;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops w25n01jw_ooblayout = {
+	.ecc = w25n01jw_ooblayout_ecc,
+	.free = w25n01jw_ooblayout_free,
+};
+
 static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 				   u8 status)
 {
@@ -206,7 +241,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&w25n01jw_ooblayout, NULL)),
 	SPINAND_INFO("W25N02JWZEIF",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbf, 0x22),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 2, 1),
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 436c0e4b0344..91382225f114 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -690,14 +690,6 @@ static void xcan_write_frame(struct net_device *ndev, struct sk_buff *skb,
 		dlc |= XCAN_DLCR_EDL_MASK;
 	}
 
-	if (!(priv->devtype.flags & XCAN_FLAG_TX_MAILBOXES) &&
-	    (priv->devtype.flags & XCAN_FLAG_TXFEMP))
-		can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max, 0);
-	else
-		can_put_echo_skb(skb, ndev, 0, 0);
-
-	priv->tx_head++;
-
 	priv->write_reg(priv, XCAN_FRAME_ID_OFFSET(frame_offset), id);
 	/* If the CAN frame is RTR frame this write triggers transmission
 	 * (not on CAN FD)
@@ -730,6 +722,14 @@ static void xcan_write_frame(struct net_device *ndev, struct sk_buff *skb,
 					data[1]);
 		}
 	}
+
+	if (!(priv->devtype.flags & XCAN_FLAG_TX_MAILBOXES) &&
+	    (priv->devtype.flags & XCAN_FLAG_TXFEMP))
+		can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max, 0);
+	else
+		can_put_echo_skb(skb, ndev, 0, 0);
+
+	priv->tx_head++;
 }
 
 /**
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a1cc338cf20f..0bd814251d56 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2356,7 +2356,8 @@ static void fec_enet_phy_reset_after_clk_enable(struct net_device *ndev)
 		 */
 		phy_dev = of_phy_find_device(fep->phy_node);
 		phy_reset_after_clk_enable(phy_dev);
-		put_device(&phy_dev->mdio.dev);
+		if (phy_dev)
+			put_device(&phy_dev->mdio.dev);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 55fb362eb508..037c1a0cbd6a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4206,7 +4206,7 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 		irq_num = pf->msix_entries[base + vector].vector;
 		irq_set_affinity_notifier(irq_num, NULL);
 		irq_update_affinity_hint(irq_num, NULL);
-		free_irq(irq_num, &vsi->q_vectors[vector]);
+		free_irq(irq_num, vsi->q_vectors[vector]);
 	}
 	return err;
 }
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index ca6ccbc13954..6412c84e2d17 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2081,11 +2081,8 @@ static void igb_diag_test(struct net_device *netdev,
 	} else {
 		dev_info(&adapter->pdev->dev, "online testing starting\n");
 
-		/* PHY is powered down when interface is down */
-		if (if_running && igb_link_test(adapter, &data[TEST_LINK]))
+		if (igb_link_test(adapter, &data[TEST_LINK]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
-		else
-			data[TEST_LINK] = 0;
 
 		/* Online tests aren't run; pass by default */
 		data[TEST_REG] = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
index 61a1155d4b4f..ce541c60c5b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
@@ -165,14 +165,14 @@ static int hws_matcher_disconnect(struct mlx5hws_matcher *matcher)
 						    next->match_ste.rtc_0_id,
 						    next->match_ste.rtc_1_id);
 		if (ret) {
-			mlx5hws_err(tbl->ctx, "Failed to disconnect matcher\n");
-			goto matcher_reconnect;
+			mlx5hws_err(tbl->ctx, "Fatal error, failed to disconnect matcher\n");
+			return ret;
 		}
 	} else {
 		ret = mlx5hws_table_connect_to_miss_table(tbl, tbl->default_miss.miss_tbl);
 		if (ret) {
-			mlx5hws_err(tbl->ctx, "Failed to disconnect last matcher\n");
-			goto matcher_reconnect;
+			mlx5hws_err(tbl->ctx, "Fatal error, failed to disconnect last matcher\n");
+			return ret;
 		}
 	}
 
@@ -180,27 +180,19 @@ static int hws_matcher_disconnect(struct mlx5hws_matcher *matcher)
 	if (prev_ft_id == tbl->ft_id) {
 		ret = mlx5hws_table_update_connected_miss_tables(tbl);
 		if (ret) {
-			mlx5hws_err(tbl->ctx, "Fatal error, failed to update connected miss table\n");
-			goto matcher_reconnect;
+			mlx5hws_err(tbl->ctx,
+				    "Fatal error, failed to update connected miss table\n");
+			return ret;
 		}
 	}
 
 	ret = mlx5hws_table_ft_set_default_next_ft(tbl, prev_ft_id);
 	if (ret) {
 		mlx5hws_err(tbl->ctx, "Fatal error, failed to restore matcher ft default miss\n");
-		goto matcher_reconnect;
+		return ret;
 	}
 
 	return 0;
-
-matcher_reconnect:
-	if (list_empty(&tbl->matchers_list) || !prev)
-		list_add(&matcher->list_node, &tbl->matchers_list);
-	else
-		/* insert after prev matcher */
-		list_add(&matcher->list_node, &prev->list_node);
-
-	return ret;
 }
 
 static void hws_matcher_set_rtc_attr_sz(struct mlx5hws_matcher *matcher,
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 591e8fd33d8e..a508cd81cd4e 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -97,6 +97,7 @@ int mdiobus_unregister_device(struct mdio_device *mdiodev)
 	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
 		return -EINVAL;
 
+	gpiod_put(mdiodev->reset_gpio);
 	reset_control_put(mdiodev->reset_ctrl);
 
 	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
@@ -814,9 +815,6 @@ void mdiobus_unregister(struct mii_bus *bus)
 		if (!mdiodev)
 			continue;
 
-		if (mdiodev->reset_gpio)
-			gpiod_put(mdiodev->reset_gpio);
-
 		mdiodev->device_remove(mdiodev);
 		mdiodev->device_free(mdiodev);
 	}
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2bddc9f60fec..fdc9f1df0578 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -989,6 +989,9 @@ static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct rq_list *rqlist)
 {
 	struct request *req;
 
+	if (rq_list_empty(rqlist))
+		return;
+
 	spin_lock(&nvmeq->sq_lock);
 	while ((req = rq_list_pop(rqlist))) {
 		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index 163950e16dbe..c173c6244d9e 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -127,13 +127,13 @@ static int eusb2_repeater_init(struct phy *phy)
 			     rptr->cfg->init_tbl[i].value);
 
 	/* Override registers from devicetree values */
-	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &val))
+	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &val))
 		regmap_write(regmap, base + EUSB2_TUNE_USB2_PREEM, val);
 
 	if (!of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &val))
 		regmap_write(regmap, base + EUSB2_TUNE_HSDISC, val);
 
-	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &val))
+	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &val))
 		regmap_write(regmap, base + EUSB2_TUNE_IUSB2, val);
 
 	/* Wait for status OK */
diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index ebc8a7e21a31..3409924498e9 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -3164,18 +3164,22 @@ tegra210_xusb_padctl_probe(struct device *dev,
 	}
 
 	pdev = of_find_device_by_node(np);
+	of_node_put(np);
 	if (!pdev) {
 		dev_warn(dev, "PMC device is not available\n");
 		goto out;
 	}
 
-	if (!platform_get_drvdata(pdev))
+	if (!platform_get_drvdata(pdev)) {
+		put_device(&pdev->dev);
 		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	padctl->regmap = dev_get_regmap(&pdev->dev, "usb_sleepwalk");
 	if (!padctl->regmap)
 		dev_info(dev, "failed to find PMC regmap\n");
 
+	put_device(&pdev->dev);
 out:
 	return &padctl->base;
 }
diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 78e19b128962..0fea766a98d7 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -363,6 +363,13 @@ static void omap_usb2_init_errata(struct omap_usb *phy)
 		phy->flags |= OMAP_USB2_DISABLE_CHRG_DET;
 }
 
+static void omap_usb2_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int omap_usb2_probe(struct platform_device *pdev)
 {
 	struct omap_usb	*phy;
@@ -373,6 +380,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	struct device_node *control_node;
 	struct platform_device *control_pdev;
 	const struct usb_phy_data *phy_data;
+	int ret;
 
 	phy_data = device_get_match_data(&pdev->dev);
 	if (!phy_data)
@@ -423,6 +431,11 @@ static int omap_usb2_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 		phy->control_dev = &control_pdev->dev;
+
+		ret = devm_add_action_or_reset(&pdev->dev, omap_usb2_put_device,
+					       phy->control_dev);
+		if (ret)
+			return ret;
 	} else {
 		if (of_property_read_u32_index(node,
 					       "syscon-phy-power", 1,
diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 874c1a25ce36..8e94d2c6e266 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -667,12 +667,20 @@ static int ti_pipe3_get_clk(struct ti_pipe3 *phy)
 	return 0;
 }
 
+static void ti_pipe3_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 {
 	struct device *dev = phy->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *control_node;
 	struct platform_device *control_pdev;
+	int ret;
 
 	phy->phy_power_syscon = syscon_regmap_lookup_by_phandle(node,
 							"syscon-phy-power");
@@ -704,6 +712,11 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 		}
 
 		phy->control_dev = &control_pdev->dev;
+
+		ret = devm_add_action_or_reset(dev, ti_pipe3_put_device,
+					       phy->control_dev);
+		if (ret)
+			return ret;
 	}
 
 	if (phy->mode == PIPE3_MODE_PCIE) {
diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index d1e7ba1fb3e1..27e3d939b7bb 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -83,9 +83,11 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
 	if (!regmap)
 		return -EPROBE_DEFER;
 
-	gdp = devm_gpiod_get(pdev->dev.parent, "epd-pwr-good", GPIOD_IN);
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
+
+	gdp = devm_gpiod_get(&pdev->dev, "epd-pwr-good", GPIOD_IN);
 	if (IS_ERR(gdp)) {
-		dev_err(pdev->dev.parent, "Power good GPIO fault %ld\n", PTR_ERR(gdp));
+		dev_err(&pdev->dev, "Power good GPIO fault %ld\n", PTR_ERR(gdp));
 		return PTR_ERR(gdp);
 	}
 
@@ -105,7 +107,6 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
 	}
 
 	config.dev = &pdev->dev;
-	config.dev->of_node = pdev->dev.parent->of_node;
 	config.regmap = regmap;
 
 	rdev = devm_regulator_register(&pdev->dev, &desc, &config);
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index cd1f657f782d..13c663a154c4 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -543,10 +543,10 @@ static ssize_t hvc_write(struct tty_struct *tty, const u8 *buf, size_t count)
 	}
 
 	/*
-	 * Racy, but harmless, kick thread if there is still pending data.
+	 * Kick thread to flush if there's still pending data
+	 * or to wakeup the write queue.
 	 */
-	if (hp->n_outbuf)
-		hvc_kick();
+	hvc_kick();
 
 	return written;
 }
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 6a0a1cce3a89..835bd453c0e8 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1161,17 +1161,6 @@ static int sc16is7xx_startup(struct uart_port *port)
 	sc16is7xx_port_write(port, SC16IS7XX_FCR_REG,
 			     SC16IS7XX_FCR_FIFO_BIT);
 
-	/* Enable EFR */
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
-			     SC16IS7XX_LCR_CONF_MODE_B);
-
-	regcache_cache_bypass(one->regmap, true);
-
-	/* Enable write access to enhanced features and internal clock div */
-	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
-			      SC16IS7XX_EFR_ENABLE_BIT,
-			      SC16IS7XX_EFR_ENABLE_BIT);
-
 	/* Enable TCR/TLR */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_TCRTLR_BIT,
@@ -1183,7 +1172,8 @@ static int sc16is7xx_startup(struct uart_port *port)
 			     SC16IS7XX_TCR_RX_RESUME(24) |
 			     SC16IS7XX_TCR_RX_HALT(48));
 
-	regcache_cache_bypass(one->regmap, false);
+	/* Disable TCR/TLR access */
+	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG, SC16IS7XX_MCR_TCRTLR_BIT, 0);
 
 	/* Now, initialize the UART */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_WORD_LEN_8);
diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index 0c45936f51b3..cbb4481b9da8 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -1601,6 +1601,7 @@ static int f_midi2_create_card(struct f_midi2 *midi2)
 			strscpy(fb->info.name, ump_fb_name(b),
 				sizeof(fb->info.name));
 		}
+		snd_ump_update_group_attrs(ump);
 	}
 
 	for (i = 0; i < midi2->num_eps; i++) {
@@ -1738,9 +1739,12 @@ static int f_midi2_create_usb_configs(struct f_midi2 *midi2,
 	case USB_SPEED_HIGH:
 		midi2_midi1_ep_out_desc.wMaxPacketSize = cpu_to_le16(512);
 		midi2_midi1_ep_in_desc.wMaxPacketSize = cpu_to_le16(512);
-		for (i = 0; i < midi2->num_eps; i++)
+		for (i = 0; i < midi2->num_eps; i++) {
 			midi2_midi2_ep_out_desc[i].wMaxPacketSize =
 				cpu_to_le16(512);
+			midi2_midi2_ep_in_desc[i].wMaxPacketSize =
+				cpu_to_le16(512);
+		}
 		fallthrough;
 	case USB_SPEED_FULL:
 		midi1_in_eps = midi2_midi1_ep_in_descs;
@@ -1749,9 +1753,12 @@ static int f_midi2_create_usb_configs(struct f_midi2 *midi2,
 	case USB_SPEED_SUPER:
 		midi2_midi1_ep_out_desc.wMaxPacketSize = cpu_to_le16(1024);
 		midi2_midi1_ep_in_desc.wMaxPacketSize = cpu_to_le16(1024);
-		for (i = 0; i < midi2->num_eps; i++)
+		for (i = 0; i < midi2->num_eps; i++) {
 			midi2_midi2_ep_out_desc[i].wMaxPacketSize =
 				cpu_to_le16(1024);
+			midi2_midi2_ep_in_desc[i].wMaxPacketSize =
+				cpu_to_le16(1024);
+		}
 		midi1_in_eps = midi2_midi1_ep_in_ss_descs;
 		midi1_out_eps = midi2_midi1_ep_out_ss_descs;
 		break;
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 081ac7683c0b..fbb101c37594 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -764,8 +764,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	if (!dum->driver)
 		return -ESHUTDOWN;
 
-	local_irq_save(flags);
-	spin_lock(&dum->lock);
+	spin_lock_irqsave(&dum->lock, flags);
 	list_for_each_entry(iter, &ep->queue, queue) {
 		if (&iter->req != _req)
 			continue;
@@ -775,15 +774,16 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 		retval = 0;
 		break;
 	}
-	spin_unlock(&dum->lock);
 
 	if (retval == 0) {
 		dev_dbg(udc_dev(dum),
 				"dequeued req %p from %s, len %d buf %p\n",
 				req, _ep->name, _req->length, _req->buf);
+		spin_unlock(&dum->lock);
 		usb_gadget_giveback_request(_ep, _req);
+		spin_lock(&dum->lock);
 	}
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dum->lock, flags);
 	return retval;
 }
 
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 69188afa5266..91b47f9573cd 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -939,7 +939,7 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 out:
 	/* we are now at a leaf device */
 	xhci_debugfs_remove_slot(xhci, slot_id);
-	xhci_free_virt_device(xhci, vdev, slot_id);
+	xhci_free_virt_device(xhci, xhci->devs[slot_id], slot_id);
 }
 
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index e5cd33093423..fc869b7f803f 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1322,7 +1322,18 @@ static const struct usb_device_id option_ids[] = {
 	 .driver_info = NCTRL(0) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1033, 0xff),	/* Telit LE910C1-EUX (ECM) */
 	 .driver_info = NCTRL(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1034, 0xff),	/* Telit LE910C4-WWX (rmnet) */
+	 .driver_info = RSVD(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1035, 0xff) }, /* Telit LE910C4-WWX (ECM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1036, 0xff) },  /* Telit LE910C4-WWX */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1037, 0xff),	/* Telit LE910C4-WWX (rmnet) */
+	 .driver_info = NCTRL(0) | NCTRL(1) | RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1038, 0xff),	/* Telit LE910C4-WWX (rmnet) */
+	 .driver_info = NCTRL(0) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x103b, 0xff),	/* Telit LE910C4-WWX */
+	 .driver_info = NCTRL(0) | NCTRL(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x103c, 0xff),	/* Telit LE910C4-WWX */
+	 .driver_info = NCTRL(0) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG0),
 	  .driver_info = RSVD(0) | RSVD(1) | NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG1),
@@ -1369,6 +1380,12 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1077, 0xff),	/* Telit FN990A (rmnet + audio) */
+	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1078, 0xff),	/* Telit FN990A (MBIM + audio) */
+	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1079, 0xff),	/* Telit FN990A (RNDIS + audio) */
+	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990A (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1081, 0xff),	/* Telit FE990A (MBIM) */
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 43e3dac5129f..92ce01b7d049 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2375,17 +2375,21 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 		case ADEV_NONE:
 			break;
 		case ADEV_NOTIFY_USB_AND_QUEUE_VDM:
-			WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB, NULL));
-			typec_altmode_vdm(adev, p[0], &p[1], cnt);
+			if (rx_sop_type == TCPC_TX_SOP_PRIME) {
+				typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P, p[0], &p[1], cnt);
+			} else {
+				WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB, NULL));
+				typec_altmode_vdm(adev, p[0], &p[1], cnt);
+			}
 			break;
 		case ADEV_QUEUE_VDM:
-			if (response_tx_sop_type == TCPC_TX_SOP_PRIME)
+			if (rx_sop_type == TCPC_TX_SOP_PRIME)
 				typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P, p[0], &p[1], cnt);
 			else
 				typec_altmode_vdm(adev, p[0], &p[1], cnt);
 			break;
 		case ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL:
-			if (response_tx_sop_type == TCPC_TX_SOP_PRIME) {
+			if (rx_sop_type == TCPC_TX_SOP_PRIME) {
 				if (typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P,
 							    p[0], &p[1], cnt)) {
 					int svdm_version = typec_get_cable_svdm_version(
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d322cf82783f..afebc91882be 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -108,6 +108,25 @@ struct btrfs_bio_ctrl {
 	 * This is to avoid touching ranges covered by compression/inline.
 	 */
 	unsigned long submit_bitmap;
+	struct readahead_control *ractl;
+
+	/*
+	 * The start offset of the last used extent map by a read operation.
+	 *
+	 * This is for proper compressed read merge.
+	 * U64_MAX means we are starting the read and have made no progress yet.
+	 *
+	 * The current btrfs_bio_is_contig() only uses disk_bytenr as
+	 * the condition to check if the read can be merged with previous
+	 * bio, which is not correct. E.g. two file extents pointing to the
+	 * same extent but with different offset.
+	 *
+	 * So here we need to do extra checks to only merge reads that are
+	 * covered by the same extent map.
+	 * Just extent_map::start will be enough, as they are unique
+	 * inside the same inode.
+	 */
+	u64 last_em_start;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -929,6 +948,23 @@ static struct extent_map *get_extent_map(struct btrfs_inode *inode,
 
 	return em;
 }
+
+static void btrfs_readahead_expand(struct readahead_control *ractl,
+				   const struct extent_map *em)
+{
+	const u64 ra_pos = readahead_pos(ractl);
+	const u64 ra_end = ra_pos + readahead_length(ractl);
+	const u64 em_end = em->start + em->ram_bytes;
+
+	/* No expansion for holes and inline extents. */
+	if (em->disk_bytenr > EXTENT_MAP_LAST_BYTE)
+		return;
+
+	ASSERT(em_end >= ra_pos);
+	if (em_end > ra_end)
+		readahead_expand(ractl, ra_pos, em_end - ra_pos);
+}
+
 /*
  * basic readpage implementation.  Locked extent state structs are inserted
  * into the tree that are removed when the IO is done (by the end_io
@@ -937,7 +973,7 @@ static struct extent_map *get_extent_map(struct btrfs_inode *inode,
  * return 0 on success, otherwise return error
  */
 static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
-		      struct btrfs_bio_ctrl *bio_ctrl, u64 *prev_em_start)
+			     struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct inode *inode = folio->mapping->host;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
@@ -994,6 +1030,17 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 		iosize = min(extent_map_end(em) - cur, end - cur + 1);
 		iosize = ALIGN(iosize, blocksize);
+
+		/*
+		 * Only expand readahead for extents which are already creating
+		 * the pages anyway in add_ra_bio_pages, which is compressed
+		 * extents in the non subpage case.
+		 */
+		if (bio_ctrl->ractl &&
+		    !btrfs_is_subpage(fs_info, folio->mapping) &&
+		    compress_type != BTRFS_COMPRESS_NONE)
+			btrfs_readahead_expand(bio_ctrl->ractl, em);
+
 		if (compress_type != BTRFS_COMPRESS_NONE)
 			disk_bytenr = em->disk_bytenr;
 		else
@@ -1037,12 +1084,11 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		 * non-optimal behavior (submitting 2 bios for the same extent).
 		 */
 		if (compress_type != BTRFS_COMPRESS_NONE &&
-		    prev_em_start && *prev_em_start != (u64)-1 &&
-		    *prev_em_start != em->start)
+		    bio_ctrl->last_em_start != U64_MAX &&
+		    bio_ctrl->last_em_start != em->start)
 			force_bio_submit = true;
 
-		if (prev_em_start)
-			*prev_em_start = em->start;
+		bio_ctrl->last_em_start = em->start;
 
 		free_extent_map(em);
 		em = NULL;
@@ -1086,12 +1132,15 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	const u64 start = folio_pos(folio);
 	const u64 end = start + folio_size(folio) - 1;
 	struct extent_state *cached_state = NULL;
-	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.opf = REQ_OP_READ,
+		.last_em_start = U64_MAX,
+	};
 	struct extent_map *em_cached = NULL;
 	int ret;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
-	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
+	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
 	unlock_extent(&inode->io_tree, start, end, &cached_state);
 
 	free_extent_map(em_cached);
@@ -2360,19 +2409,22 @@ int btrfs_writepages(struct address_space *mapping, struct writeback_control *wb
 
 void btrfs_readahead(struct readahead_control *rac)
 {
-	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ | REQ_RAHEAD };
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.opf = REQ_OP_READ | REQ_RAHEAD,
+		.ractl = rac,
+		.last_em_start = U64_MAX,
+	};
 	struct folio *folio;
 	struct btrfs_inode *inode = BTRFS_I(rac->mapping->host);
 	const u64 start = readahead_pos(rac);
 	const u64 end = start + readahead_length(rac) - 1;
 	struct extent_state *cached_state = NULL;
 	struct extent_map *em_cached = NULL;
-	u64 prev_em_start = (u64)-1;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
 
 	while ((folio = readahead_folio(rac)) != NULL)
-		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
+		btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
 
 	unlock_extent(&inode->io_tree, start, end, &cached_state);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 98d087a14be5..19c0ec9c327c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5634,7 +5634,17 @@ static void btrfs_del_inode_from_root(struct btrfs_inode *inode)
 	bool empty = false;
 
 	xa_lock(&root->inodes);
-	entry = __xa_erase(&root->inodes, btrfs_ino(inode));
+	/*
+	 * This btrfs_inode is being freed and has already been unhashed at this
+	 * point. It's possible that another btrfs_inode has already been
+	 * allocated for the same inode and inserted itself into the root, so
+	 * don't delete it in that case.
+	 *
+	 * Note that this shouldn't need to allocate memory, so the gfp flags
+	 * don't really matter.
+	 */
+	entry = __xa_cmpxchg(&root->inodes, btrfs_ino(inode), inode, NULL,
+			     GFP_ATOMIC);
 	if (entry == inode)
 		empty = xa_empty(&root->inodes);
 	xa_unlock(&root->inodes);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 530a2bab6ada..2c9b38ae40da 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1501,6 +1501,7 @@ static int __qgroup_excl_accounting(struct btrfs_fs_info *fs_info, u64 ref_root,
 	struct btrfs_qgroup *qgroup;
 	LIST_HEAD(qgroup_list);
 	u64 num_bytes = src->excl;
+	u64 num_bytes_cmpr = src->excl_cmpr;
 	int ret = 0;
 
 	qgroup = find_qgroup_rb(fs_info, ref_root);
@@ -1512,11 +1513,12 @@ static int __qgroup_excl_accounting(struct btrfs_fs_info *fs_info, u64 ref_root,
 		struct btrfs_qgroup_list *glist;
 
 		qgroup->rfer += sign * num_bytes;
-		qgroup->rfer_cmpr += sign * num_bytes;
+		qgroup->rfer_cmpr += sign * num_bytes_cmpr;
 
 		WARN_ON(sign < 0 && qgroup->excl < num_bytes);
+		WARN_ON(sign < 0 && qgroup->excl_cmpr < num_bytes_cmpr);
 		qgroup->excl += sign * num_bytes;
-		qgroup->excl_cmpr += sign * num_bytes;
+		qgroup->excl_cmpr += sign * num_bytes_cmpr;
 
 		if (sign > 0)
 			qgroup_rsv_add_by_qgroup(fs_info, qgroup, src);
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 24c08078f5aa..74297fd2a365 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -55,8 +55,6 @@ static int mdsc_show(struct seq_file *s, void *p)
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct rb_node *rp;
-	int pathlen = 0;
-	u64 pathbase;
 	char *path;
 
 	mutex_lock(&mdsc->mutex);
@@ -81,8 +79,8 @@ static int mdsc_show(struct seq_file *s, void *p)
 		if (req->r_inode) {
 			seq_printf(s, " #%llx", ceph_ino(req->r_inode));
 		} else if (req->r_dentry) {
-			path = ceph_mdsc_build_path(mdsc, req->r_dentry, &pathlen,
-						    &pathbase, 0);
+			struct ceph_path_info path_info;
+			path = ceph_mdsc_build_path(mdsc, req->r_dentry, &path_info, 0);
 			if (IS_ERR(path))
 				path = NULL;
 			spin_lock(&req->r_dentry->d_lock);
@@ -91,7 +89,7 @@ static int mdsc_show(struct seq_file *s, void *p)
 				   req->r_dentry,
 				   path ? path : "");
 			spin_unlock(&req->r_dentry->d_lock);
-			ceph_mdsc_free_path(path, pathlen);
+			ceph_mdsc_free_path_info(&path_info);
 		} else if (req->r_path1) {
 			seq_printf(s, " #%llx/%s", req->r_ino1.ino,
 				   req->r_path1);
@@ -100,8 +98,8 @@ static int mdsc_show(struct seq_file *s, void *p)
 		}
 
 		if (req->r_old_dentry) {
-			path = ceph_mdsc_build_path(mdsc, req->r_old_dentry, &pathlen,
-						    &pathbase, 0);
+			struct ceph_path_info path_info;
+			path = ceph_mdsc_build_path(mdsc, req->r_old_dentry, &path_info, 0);
 			if (IS_ERR(path))
 				path = NULL;
 			spin_lock(&req->r_old_dentry->d_lock);
@@ -111,7 +109,7 @@ static int mdsc_show(struct seq_file *s, void *p)
 				   req->r_old_dentry,
 				   path ? path : "");
 			spin_unlock(&req->r_old_dentry->d_lock);
-			ceph_mdsc_free_path(path, pathlen);
+			ceph_mdsc_free_path_info(&path_info);
 		} else if (req->r_path2 && req->r_op != CEPH_MDS_OP_SYMLINK) {
 			if (req->r_ino2.ino)
 				seq_printf(s, " #%llx/%s", req->r_ino2.ino,
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 952109292d69..16c25c48465e 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1263,10 +1263,8 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 
 	/* If op failed, mark everyone involved for errors */
 	if (result) {
-		int pathlen = 0;
-		u64 base = 0;
-		char *path = ceph_mdsc_build_path(mdsc, dentry, &pathlen,
-						  &base, 0);
+		struct ceph_path_info path_info = {0};
+		char *path = ceph_mdsc_build_path(mdsc, dentry, &path_info, 0);
 
 		/* mark error on parent + clear complete */
 		mapping_set_error(req->r_parent->i_mapping, result);
@@ -1280,8 +1278,8 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 		mapping_set_error(req->r_old_inode->i_mapping, result);
 
 		pr_warn_client(cl, "failure path=(%llx)%s result=%d!\n",
-			       base, IS_ERR(path) ? "<<bad>>" : path, result);
-		ceph_mdsc_free_path(path, pathlen);
+			       path_info.vino.ino, IS_ERR(path) ? "<<bad>>" : path, result);
+		ceph_mdsc_free_path_info(&path_info);
 	}
 out:
 	iput(req->r_old_inode);
@@ -1339,8 +1337,6 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	int err = -EROFS;
 	int op;
 	char *path;
-	int pathlen;
-	u64 pathbase;
 
 	if (ceph_snap(dir) == CEPH_SNAPDIR) {
 		/* rmdir .snap/foo is RMSNAP */
@@ -1359,14 +1355,15 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	if (!dn) {
 		try_async = false;
 	} else {
-		path = ceph_mdsc_build_path(mdsc, dn, &pathlen, &pathbase, 0);
+		struct ceph_path_info path_info;
+		path = ceph_mdsc_build_path(mdsc, dn, &path_info, 0);
 		if (IS_ERR(path)) {
 			try_async = false;
 			err = 0;
 		} else {
 			err = ceph_mds_check_access(mdsc, path, MAY_WRITE);
 		}
-		ceph_mdsc_free_path(path, pathlen);
+		ceph_mdsc_free_path_info(&path_info);
 		dput(dn);
 
 		/* For none EACCES cases will let the MDS do the mds auth check */
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a7254cab44cc..6587c2d5af1e 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -368,8 +368,6 @@ int ceph_open(struct inode *inode, struct file *file)
 	int flags, fmode, wanted;
 	struct dentry *dentry;
 	char *path;
-	int pathlen;
-	u64 pathbase;
 	bool do_sync = false;
 	int mask = MAY_READ;
 
@@ -399,14 +397,15 @@ int ceph_open(struct inode *inode, struct file *file)
 	if (!dentry) {
 		do_sync = true;
 	} else {
-		path = ceph_mdsc_build_path(mdsc, dentry, &pathlen, &pathbase, 0);
+		struct ceph_path_info path_info;
+		path = ceph_mdsc_build_path(mdsc, dentry, &path_info, 0);
 		if (IS_ERR(path)) {
 			do_sync = true;
 			err = 0;
 		} else {
 			err = ceph_mds_check_access(mdsc, path, mask);
 		}
-		ceph_mdsc_free_path(path, pathlen);
+		ceph_mdsc_free_path_info(&path_info);
 		dput(dentry);
 
 		/* For none EACCES cases will let the MDS do the mds auth check */
@@ -614,15 +613,13 @@ static void ceph_async_create_cb(struct ceph_mds_client *mdsc,
 	mapping_set_error(req->r_parent->i_mapping, result);
 
 	if (result) {
-		int pathlen = 0;
-		u64 base = 0;
-		char *path = ceph_mdsc_build_path(mdsc, req->r_dentry, &pathlen,
-						  &base, 0);
+		struct ceph_path_info path_info = {0};
+		char *path = ceph_mdsc_build_path(mdsc, req->r_dentry, &path_info, 0);
 
 		pr_warn_client(cl,
 			"async create failure path=(%llx)%s result=%d!\n",
-			base, IS_ERR(path) ? "<<bad>>" : path, result);
-		ceph_mdsc_free_path(path, pathlen);
+			path_info.vino.ino, IS_ERR(path) ? "<<bad>>" : path, result);
+		ceph_mdsc_free_path_info(&path_info);
 
 		ceph_dir_clear_complete(req->r_parent);
 		if (!d_unhashed(dentry))
@@ -791,8 +788,6 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	int mask;
 	int err;
 	char *path;
-	int pathlen;
-	u64 pathbase;
 
 	doutc(cl, "%p %llx.%llx dentry %p '%pd' %s flags %d mode 0%o\n",
 	      dir, ceph_vinop(dir), dentry, dentry,
@@ -814,7 +809,8 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (!dn) {
 		try_async = false;
 	} else {
-		path = ceph_mdsc_build_path(mdsc, dn, &pathlen, &pathbase, 0);
+		struct ceph_path_info path_info;
+		path = ceph_mdsc_build_path(mdsc, dn, &path_info, 0);
 		if (IS_ERR(path)) {
 			try_async = false;
 			err = 0;
@@ -826,7 +822,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 				mask |= MAY_WRITE;
 			err = ceph_mds_check_access(mdsc, path, mask);
 		}
-		ceph_mdsc_free_path(path, pathlen);
+		ceph_mdsc_free_path_info(&path_info);
 		dput(dn);
 
 		/* For none EACCES cases will let the MDS do the mds auth check */
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index f7875e6f3029..ead51d9e019b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -55,6 +55,52 @@ static int ceph_set_ino_cb(struct inode *inode, void *data)
 	return 0;
 }
 
+/*
+ * Check if the parent inode matches the vino from directory reply info
+ */
+static inline bool ceph_vino_matches_parent(struct inode *parent,
+					    struct ceph_vino vino)
+{
+	return ceph_ino(parent) == vino.ino && ceph_snap(parent) == vino.snap;
+}
+
+/*
+ * Validate that the directory inode referenced by @req->r_parent matches the
+ * inode number and snapshot id contained in the reply's directory record.  If
+ * they do not match – which can theoretically happen if the parent dentry was
+ * moved between the time the request was issued and the reply arrived – fall
+ * back to looking up the correct inode in the inode cache.
+ *
+ * A reference is *always* returned.  Callers that receive a different inode
+ * than the original @parent are responsible for dropping the extra reference
+ * once the reply has been processed.
+ */
+static struct inode *ceph_get_reply_dir(struct super_block *sb,
+					struct inode *parent,
+					struct ceph_mds_reply_info_parsed *rinfo)
+{
+	struct ceph_vino vino;
+
+	if (unlikely(!rinfo->diri.in))
+		return parent; /* nothing to compare against */
+
+	/* If we didn't have a cached parent inode to begin with, just bail out. */
+	if (!parent)
+		return NULL;
+
+	vino.ino  = le64_to_cpu(rinfo->diri.in->ino);
+	vino.snap = le64_to_cpu(rinfo->diri.in->snapid);
+
+	if (likely(ceph_vino_matches_parent(parent, vino)))
+		return parent; /* matches – use the original reference */
+
+	/* Mismatch – this should be rare.  Emit a WARN and obtain the correct inode. */
+	WARN_ONCE(1, "ceph: reply dir mismatch (parent valid %llx.%llx reply %llx.%llx)\n",
+		  ceph_ino(parent), ceph_snap(parent), vino.ino, vino.snap);
+
+	return ceph_get_inode(sb, vino, NULL);
+}
+
 /**
  * ceph_new_inode - allocate a new inode in advance of an expected create
  * @dir: parent directory for new inode
@@ -1523,6 +1569,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	struct ceph_vino tvino, dvino;
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_client *cl = fsc->client;
+	struct inode *parent_dir = NULL;
 	int err = 0;
 
 	doutc(cl, "%p is_dentry %d is_target %d\n", req,
@@ -1536,10 +1583,17 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	}
 
 	if (rinfo->head->is_dentry) {
-		struct inode *dir = req->r_parent;
-
-		if (dir) {
-			err = ceph_fill_inode(dir, NULL, &rinfo->diri,
+		/*
+		 * r_parent may be stale, in cases when R_PARENT_LOCKED is not set,
+		 * so we need to get the correct inode
+		 */
+		parent_dir = ceph_get_reply_dir(sb, req->r_parent, rinfo);
+		if (unlikely(IS_ERR(parent_dir))) {
+			err = PTR_ERR(parent_dir);
+			goto done;
+		}
+		if (parent_dir) {
+			err = ceph_fill_inode(parent_dir, NULL, &rinfo->diri,
 					      rinfo->dirfrag, session, -1,
 					      &req->r_caps_reservation);
 			if (err < 0)
@@ -1548,14 +1602,14 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			WARN_ON_ONCE(1);
 		}
 
-		if (dir && req->r_op == CEPH_MDS_OP_LOOKUPNAME &&
+		if (parent_dir && req->r_op == CEPH_MDS_OP_LOOKUPNAME &&
 		    test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
 		    !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
 			bool is_nokey = false;
 			struct qstr dname;
 			struct dentry *dn, *parent;
 			struct fscrypt_str oname = FSTR_INIT(NULL, 0);
-			struct ceph_fname fname = { .dir	= dir,
+			struct ceph_fname fname = { .dir	= parent_dir,
 						    .name	= rinfo->dname,
 						    .ctext	= rinfo->altname,
 						    .name_len	= rinfo->dname_len,
@@ -1564,10 +1618,10 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			BUG_ON(!rinfo->head->is_target);
 			BUG_ON(req->r_dentry);
 
-			parent = d_find_any_alias(dir);
+			parent = d_find_any_alias(parent_dir);
 			BUG_ON(!parent);
 
-			err = ceph_fname_alloc_buffer(dir, &oname);
+			err = ceph_fname_alloc_buffer(parent_dir, &oname);
 			if (err < 0) {
 				dput(parent);
 				goto done;
@@ -1576,7 +1630,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			err = ceph_fname_to_usr(&fname, NULL, &oname, &is_nokey);
 			if (err < 0) {
 				dput(parent);
-				ceph_fname_free_buffer(dir, &oname);
+				ceph_fname_free_buffer(parent_dir, &oname);
 				goto done;
 			}
 			dname.name = oname.name;
@@ -1595,7 +1649,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				      dname.len, dname.name, dn);
 				if (!dn) {
 					dput(parent);
-					ceph_fname_free_buffer(dir, &oname);
+					ceph_fname_free_buffer(parent_dir, &oname);
 					err = -ENOMEM;
 					goto done;
 				}
@@ -1610,12 +1664,12 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				    ceph_snap(d_inode(dn)) != tvino.snap)) {
 				doutc(cl, " dn %p points to wrong inode %p\n",
 				      dn, d_inode(dn));
-				ceph_dir_clear_ordered(dir);
+				ceph_dir_clear_ordered(parent_dir);
 				d_delete(dn);
 				dput(dn);
 				goto retry_lookup;
 			}
-			ceph_fname_free_buffer(dir, &oname);
+			ceph_fname_free_buffer(parent_dir, &oname);
 
 			req->r_dentry = dn;
 			dput(parent);
@@ -1794,6 +1848,9 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 					    &dvino, ptvino);
 	}
 done:
+	/* Drop extra ref from ceph_get_reply_dir() if it returned a new inode */
+	if (unlikely(!IS_ERR_OR_NULL(parent_dir) && parent_dir != req->r_parent))
+		iput(parent_dir);
 	doutc(cl, "done err=%d\n", err);
 	return err;
 }
@@ -2483,22 +2540,21 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 	int truncate_retry = 20; /* The RMW will take around 50ms */
 	struct dentry *dentry;
 	char *path;
-	int pathlen;
-	u64 pathbase;
 	bool do_sync = false;
 
 	dentry = d_find_alias(inode);
 	if (!dentry) {
 		do_sync = true;
 	} else {
-		path = ceph_mdsc_build_path(mdsc, dentry, &pathlen, &pathbase, 0);
+		struct ceph_path_info path_info;
+		path = ceph_mdsc_build_path(mdsc, dentry, &path_info, 0);
 		if (IS_ERR(path)) {
 			do_sync = true;
 			err = 0;
 		} else {
 			err = ceph_mds_check_access(mdsc, path, MAY_WRITE);
 		}
-		ceph_mdsc_free_path(path, pathlen);
+		ceph_mdsc_free_path_info(&path_info);
 		dput(dentry);
 
 		/* For none EACCES cases will let the MDS do the mds auth check */
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f3af6330d74a..df89d45f33a1 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2686,8 +2686,7 @@ static u8 *get_fscrypt_altname(const struct ceph_mds_request *req, u32 *plen)
  * ceph_mdsc_build_path - build a path string to a given dentry
  * @mdsc: mds client
  * @dentry: dentry to which path should be built
- * @plen: returned length of string
- * @pbase: returned base inode number
+ * @path_info: output path, length, base ino+snap, and freepath ownership flag
  * @for_wire: is this path going to be sent to the MDS?
  *
  * Build a string that represents the path to the dentry. This is mostly called
@@ -2705,7 +2704,7 @@ static u8 *get_fscrypt_altname(const struct ceph_mds_request *req, u32 *plen)
  *   foo/.snap/bar -> foo//bar
  */
 char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
-			   int *plen, u64 *pbase, int for_wire)
+			   struct ceph_path_info *path_info, int for_wire)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct dentry *cur;
@@ -2815,16 +2814,28 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 
-	*pbase = base;
-	*plen = PATH_MAX - 1 - pos;
+	/* Initialize the output structure */
+	memset(path_info, 0, sizeof(*path_info));
+
+	path_info->vino.ino = base;
+	path_info->pathlen = PATH_MAX - 1 - pos;
+	path_info->path = path + pos;
+	path_info->freepath = true;
+
+	/* Set snap from dentry if available */
+	if (d_inode(dentry))
+		path_info->vino.snap = ceph_snap(d_inode(dentry));
+	else
+		path_info->vino.snap = CEPH_NOSNAP;
+
 	doutc(cl, "on %p %d built %llx '%.*s'\n", dentry, d_count(dentry),
-	      base, *plen, path + pos);
+	      base, PATH_MAX - 1 - pos, path + pos);
 	return path + pos;
 }
 
 static int build_dentry_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
-			     struct inode *dir, const char **ppath, int *ppathlen,
-			     u64 *pino, bool *pfreepath, bool parent_locked)
+			     struct inode *dir, struct ceph_path_info *path_info,
+			     bool parent_locked)
 {
 	char *path;
 
@@ -2833,41 +2844,47 @@ static int build_dentry_path(struct ceph_mds_client *mdsc, struct dentry *dentry
 		dir = d_inode_rcu(dentry->d_parent);
 	if (dir && parent_locked && ceph_snap(dir) == CEPH_NOSNAP &&
 	    !IS_ENCRYPTED(dir)) {
-		*pino = ceph_ino(dir);
+		path_info->vino.ino = ceph_ino(dir);
+		path_info->vino.snap = ceph_snap(dir);
 		rcu_read_unlock();
-		*ppath = dentry->d_name.name;
-		*ppathlen = dentry->d_name.len;
+		path_info->path = dentry->d_name.name;
+		path_info->pathlen = dentry->d_name.len;
+		path_info->freepath = false;
 		return 0;
 	}
 	rcu_read_unlock();
-	path = ceph_mdsc_build_path(mdsc, dentry, ppathlen, pino, 1);
+	path = ceph_mdsc_build_path(mdsc, dentry, path_info, 1);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
-	*ppath = path;
-	*pfreepath = true;
+	/*
+	 * ceph_mdsc_build_path already fills path_info, including snap handling.
+	 */
 	return 0;
 }
 
-static int build_inode_path(struct inode *inode,
-			    const char **ppath, int *ppathlen, u64 *pino,
-			    bool *pfreepath)
+static int build_inode_path(struct inode *inode, struct ceph_path_info *path_info)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct dentry *dentry;
 	char *path;
 
 	if (ceph_snap(inode) == CEPH_NOSNAP) {
-		*pino = ceph_ino(inode);
-		*ppathlen = 0;
+		path_info->vino.ino = ceph_ino(inode);
+		path_info->vino.snap = ceph_snap(inode);
+		path_info->pathlen = 0;
+		path_info->freepath = false;
 		return 0;
 	}
 	dentry = d_find_alias(inode);
-	path = ceph_mdsc_build_path(mdsc, dentry, ppathlen, pino, 1);
+	path = ceph_mdsc_build_path(mdsc, dentry, path_info, 1);
 	dput(dentry);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
-	*ppath = path;
-	*pfreepath = true;
+	/*
+	 * ceph_mdsc_build_path already fills path_info, including snap from dentry.
+	 * Override with inode's snap since that's what this function is for.
+	 */
+	path_info->vino.snap = ceph_snap(inode);
 	return 0;
 }
 
@@ -2877,26 +2894,32 @@ static int build_inode_path(struct inode *inode,
  */
 static int set_request_path_attr(struct ceph_mds_client *mdsc, struct inode *rinode,
 				 struct dentry *rdentry, struct inode *rdiri,
-				 const char *rpath, u64 rino, const char **ppath,
-				 int *pathlen, u64 *ino, bool *freepath,
+				 const char *rpath, u64 rino,
+				 struct ceph_path_info *path_info,
 				 bool parent_locked)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	int r = 0;
 
+	/* Initialize the output structure */
+	memset(path_info, 0, sizeof(*path_info));
+
 	if (rinode) {
-		r = build_inode_path(rinode, ppath, pathlen, ino, freepath);
+		r = build_inode_path(rinode, path_info);
 		doutc(cl, " inode %p %llx.%llx\n", rinode, ceph_ino(rinode),
 		      ceph_snap(rinode));
 	} else if (rdentry) {
-		r = build_dentry_path(mdsc, rdentry, rdiri, ppath, pathlen, ino,
-					freepath, parent_locked);
-		doutc(cl, " dentry %p %llx/%.*s\n", rdentry, *ino, *pathlen, *ppath);
+		r = build_dentry_path(mdsc, rdentry, rdiri, path_info, parent_locked);
+		doutc(cl, " dentry %p %llx/%.*s\n", rdentry, path_info->vino.ino,
+		      path_info->pathlen, path_info->path);
 	} else if (rpath || rino) {
-		*ino = rino;
-		*ppath = rpath;
-		*pathlen = rpath ? strlen(rpath) : 0;
-		doutc(cl, " path %.*s\n", *pathlen, rpath);
+		path_info->vino.ino = rino;
+		path_info->vino.snap = CEPH_NOSNAP;
+		path_info->path = rpath;
+		path_info->pathlen = rpath ? strlen(rpath) : 0;
+		path_info->freepath = false;
+
+		doutc(cl, " path %.*s\n", path_info->pathlen, rpath);
 	}
 
 	return r;
@@ -2973,11 +2996,8 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *msg;
 	struct ceph_mds_request_head_legacy *lhead;
-	const char *path1 = NULL;
-	const char *path2 = NULL;
-	u64 ino1 = 0, ino2 = 0;
-	int pathlen1 = 0, pathlen2 = 0;
-	bool freepath1 = false, freepath2 = false;
+	struct ceph_path_info path_info1 = {0};
+	struct ceph_path_info path_info2 = {0};
 	struct dentry *old_dentry = NULL;
 	int len;
 	u16 releases;
@@ -2987,25 +3007,49 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	u16 request_head_version = mds_supported_head_version(session);
 	kuid_t caller_fsuid = req->r_cred->fsuid;
 	kgid_t caller_fsgid = req->r_cred->fsgid;
+	bool parent_locked = test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
 
 	ret = set_request_path_attr(mdsc, req->r_inode, req->r_dentry,
-			      req->r_parent, req->r_path1, req->r_ino1.ino,
-			      &path1, &pathlen1, &ino1, &freepath1,
-			      test_bit(CEPH_MDS_R_PARENT_LOCKED,
-					&req->r_req_flags));
+				    req->r_parent, req->r_path1, req->r_ino1.ino,
+				    &path_info1, parent_locked);
 	if (ret < 0) {
 		msg = ERR_PTR(ret);
 		goto out;
 	}
 
+	/*
+	 * When the parent directory's i_rwsem is *not* locked, req->r_parent may
+	 * have become stale (e.g. after a concurrent rename) between the time the
+	 * dentry was looked up and now.  If we detect that the stored r_parent
+	 * does not match the inode number we just encoded for the request, switch
+	 * to the correct inode so that the MDS receives a valid parent reference.
+	 */
+	if (!parent_locked && req->r_parent && path_info1.vino.ino &&
+	    ceph_ino(req->r_parent) != path_info1.vino.ino) {
+		struct inode *old_parent = req->r_parent;
+		struct inode *correct_dir = ceph_get_inode(mdsc->fsc->sb, path_info1.vino, NULL);
+		if (!IS_ERR(correct_dir)) {
+			WARN_ONCE(1, "ceph: r_parent mismatch (had %llx wanted %llx) - updating\n",
+			          ceph_ino(old_parent), path_info1.vino.ino);
+			/*
+			 * Transfer CEPH_CAP_PIN from the old parent to the new one.
+			 * The pin was taken earlier in ceph_mdsc_submit_request().
+			 */
+			ceph_put_cap_refs(ceph_inode(old_parent), CEPH_CAP_PIN);
+			iput(old_parent);
+			req->r_parent = correct_dir;
+			ceph_get_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
+		}
+	}
+
 	/* If r_old_dentry is set, then assume that its parent is locked */
 	if (req->r_old_dentry &&
 	    !(req->r_old_dentry->d_flags & DCACHE_DISCONNECTED))
 		old_dentry = req->r_old_dentry;
 	ret = set_request_path_attr(mdsc, NULL, old_dentry,
-			      req->r_old_dentry_dir,
-			      req->r_path2, req->r_ino2.ino,
-			      &path2, &pathlen2, &ino2, &freepath2, true);
+				    req->r_old_dentry_dir,
+				    req->r_path2, req->r_ino2.ino,
+				    &path_info2, true);
 	if (ret < 0) {
 		msg = ERR_PTR(ret);
 		goto out_free1;
@@ -3036,7 +3080,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 
 	/* filepaths */
 	len += 2 * (1 + sizeof(u32) + sizeof(u64));
-	len += pathlen1 + pathlen2;
+	len += path_info1.pathlen + path_info2.pathlen;
 
 	/* cap releases */
 	len += sizeof(struct ceph_mds_request_release) *
@@ -3044,9 +3088,9 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 		 !!req->r_old_inode_drop + !!req->r_old_dentry_drop);
 
 	if (req->r_dentry_drop)
-		len += pathlen1;
+		len += path_info1.pathlen;
 	if (req->r_old_dentry_drop)
-		len += pathlen2;
+		len += path_info2.pathlen;
 
 	/* MClientRequest tail */
 
@@ -3159,8 +3203,8 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	lhead->ino = cpu_to_le64(req->r_deleg_ino);
 	lhead->args = req->r_args;
 
-	ceph_encode_filepath(&p, end, ino1, path1);
-	ceph_encode_filepath(&p, end, ino2, path2);
+	ceph_encode_filepath(&p, end, path_info1.vino.ino, path_info1.path);
+	ceph_encode_filepath(&p, end, path_info2.vino.ino, path_info2.path);
 
 	/* make note of release offset, in case we need to replay */
 	req->r_request_release_offset = p - msg->front.iov_base;
@@ -3223,11 +3267,9 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	msg->hdr.data_off = cpu_to_le16(0);
 
 out_free2:
-	if (freepath2)
-		ceph_mdsc_free_path((char *)path2, pathlen2);
+	ceph_mdsc_free_path_info(&path_info2);
 out_free1:
-	if (freepath1)
-		ceph_mdsc_free_path((char *)path1, pathlen1);
+	ceph_mdsc_free_path_info(&path_info1);
 out:
 	return msg;
 out_err:
@@ -4584,24 +4626,20 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 	struct ceph_pagelist *pagelist = recon_state->pagelist;
 	struct dentry *dentry;
 	struct ceph_cap *cap;
-	char *path;
-	int pathlen = 0, err;
-	u64 pathbase;
+	struct ceph_path_info path_info = {0};
+	int err;
 	u64 snap_follows;
 
 	dentry = d_find_primary(inode);
 	if (dentry) {
 		/* set pathbase to parent dir when msg_version >= 2 */
-		path = ceph_mdsc_build_path(mdsc, dentry, &pathlen, &pathbase,
+		char *path = ceph_mdsc_build_path(mdsc, dentry, &path_info,
 					    recon_state->msg_version >= 2);
 		dput(dentry);
 		if (IS_ERR(path)) {
 			err = PTR_ERR(path);
 			goto out_err;
 		}
-	} else {
-		path = NULL;
-		pathbase = 0;
 	}
 
 	spin_lock(&ci->i_ceph_lock);
@@ -4634,7 +4672,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		rec.v2.wanted = cpu_to_le32(__ceph_caps_wanted(ci));
 		rec.v2.issued = cpu_to_le32(cap->issued);
 		rec.v2.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
-		rec.v2.pathbase = cpu_to_le64(pathbase);
+		rec.v2.pathbase = cpu_to_le64(path_info.vino.ino);
 		rec.v2.flock_len = (__force __le32)
 			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
 	} else {
@@ -4649,7 +4687,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		ts = inode_get_atime(inode);
 		ceph_encode_timespec64(&rec.v1.atime, &ts);
 		rec.v1.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
-		rec.v1.pathbase = cpu_to_le64(pathbase);
+		rec.v1.pathbase = cpu_to_le64(path_info.vino.ino);
 	}
 
 	if (list_empty(&ci->i_cap_snaps)) {
@@ -4711,7 +4749,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 			    sizeof(struct ceph_filelock);
 		rec.v2.flock_len = cpu_to_le32(struct_len);
 
-		struct_len += sizeof(u32) + pathlen + sizeof(rec.v2);
+		struct_len += sizeof(u32) + path_info.pathlen + sizeof(rec.v2);
 
 		if (struct_v >= 2)
 			struct_len += sizeof(u64); /* snap_follows */
@@ -4735,7 +4773,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 			ceph_pagelist_encode_8(pagelist, 1);
 			ceph_pagelist_encode_32(pagelist, struct_len);
 		}
-		ceph_pagelist_encode_string(pagelist, path, pathlen);
+		ceph_pagelist_encode_string(pagelist, (char *)path_info.path, path_info.pathlen);
 		ceph_pagelist_append(pagelist, &rec, sizeof(rec.v2));
 		ceph_locks_to_pagelist(flocks, pagelist,
 				       num_fcntl_locks, num_flock_locks);
@@ -4746,17 +4784,17 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 	} else {
 		err = ceph_pagelist_reserve(pagelist,
 					    sizeof(u64) + sizeof(u32) +
-					    pathlen + sizeof(rec.v1));
+					    path_info.pathlen + sizeof(rec.v1));
 		if (err)
 			goto out_err;
 
 		ceph_pagelist_encode_64(pagelist, ceph_ino(inode));
-		ceph_pagelist_encode_string(pagelist, path, pathlen);
+		ceph_pagelist_encode_string(pagelist, (char *)path_info.path, path_info.pathlen);
 		ceph_pagelist_append(pagelist, &rec, sizeof(rec.v1));
 	}
 
 out_err:
-	ceph_mdsc_free_path(path, pathlen);
+	ceph_mdsc_free_path_info(&path_info);
 	if (!err)
 		recon_state->nr_caps++;
 	return err;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 3dd54587944a..0a602080d8ef 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -612,14 +612,24 @@ extern int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath,
 
 extern void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc);
 
-static inline void ceph_mdsc_free_path(char *path, int len)
+/*
+ * Structure to group path-related output parameters for build_*_path functions
+ */
+struct ceph_path_info {
+	const char *path;
+	int pathlen;
+	struct ceph_vino vino;
+	bool freepath;
+};
+
+static inline void ceph_mdsc_free_path_info(const struct ceph_path_info *path_info)
 {
-	if (!IS_ERR_OR_NULL(path))
-		__putname(path - (PATH_MAX - 1 - len));
+	if (path_info && path_info->freepath && !IS_ERR_OR_NULL(path_info->path))
+		__putname((char *)path_info->path - (PATH_MAX - 1 - path_info->pathlen));
 }
 
 extern char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc,
-				  struct dentry *dentry, int *plen, u64 *base,
+				  struct dentry *dentry, struct ceph_path_info *path_info,
 				  int for_wire);
 
 extern void __ceph_mdsc_drop_dentry_lease(struct dentry *dentry);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 286f8fcb74cc..29c7c0b8295f 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1462,7 +1462,8 @@ static bool ext4_match(struct inode *parent,
 		 * sure cf_name was properly initialized before
 		 * considering the calculated hash.
 		 */
-		if (IS_ENCRYPTED(parent) && fname->cf_name.name &&
+		if (sb_no_casefold_compat_fallback(parent->i_sb) &&
+		    IS_ENCRYPTED(parent) && fname->cf_name.name &&
 		    (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
 		     fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de)))
 			return false;
@@ -1595,10 +1596,15 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		 * return.  Otherwise, fall back to doing a search the
 		 * old fashioned way.
 		 */
-		if (!IS_ERR(ret) || PTR_ERR(ret) != ERR_BAD_DX_DIR)
+		if (IS_ERR(ret) && PTR_ERR(ret) == ERR_BAD_DX_DIR)
+			dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx failed, "
+				       "falling back\n"));
+		else if (!sb_no_casefold_compat_fallback(dir->i_sb) &&
+			 *res_dir == NULL && IS_CASEFOLDED(dir))
+			dxtrace(printk(KERN_DEBUG "ext4_find_entry: casefold "
+				       "failed, falling back\n"));
+		else
 			goto cleanup_and_exit;
-		dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx failed, "
-			       "falling back\n"));
 		ret = NULL;
 	}
 	nblocks = dir->i_size >> EXT4_BLOCK_SIZE_BITS(sb);
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 82df28d45cd7..ff90f8203015 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -176,6 +176,14 @@ static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
 	if (!ctx->flags)
 		return 1;
 
+	/*
+	 * Verify that the decoded dentry itself has a valid id mapping.
+	 * In case the decoded dentry is the mountfd root itself, this
+	 * verifies that the mountfd inode itself has a valid id mapping.
+	 */
+	if (!privileged_wrt_inode_uidgid(user_ns, idmap, d_inode(dentry)))
+		return 0;
+
 	/*
 	 * It's racy as we're not taking rename_lock but we're able to ignore
 	 * permissions and we just need an approximation whether we were able
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f597f7e68e50..49659d1b2932 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3229,7 +3229,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		.nodeid_out = ff_out->nodeid,
 		.fh_out = ff_out->fh,
 		.off_out = pos_out,
-		.len = len,
+		.len = min_t(size_t, len, UINT_MAX & PAGE_MASK),
 		.flags = flags
 	};
 	struct fuse_write_out outarg;
@@ -3295,6 +3295,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		fc->no_copy_file_range = 1;
 		err = -EOPNOTSUPP;
 	}
+	if (!err && outarg.size > len)
+		err = -EIO;
+
 	if (err)
 		goto out;
 
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index bbac547dfcb3..6bfd09dda9e3 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -233,6 +233,11 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	if (!file)
 		goto out;
 
+	/* read/write/splice/mmap passthrough only relevant for regular files */
+	res = d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
+	if (!d_is_reg(file->f_path.dentry))
+		goto out_fput;
+
 	backing_sb = file_inode(file)->i_sb;
 	res = -ELOOP;
 	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 2d9d5dfa19b8..c81cffa72b1c 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -70,6 +70,24 @@ static struct kernfs_open_node *of_on(struct kernfs_open_file *of)
 					 !list_empty(&of->list));
 }
 
+/* Get active reference to kernfs node for an open file */
+static struct kernfs_open_file *kernfs_get_active_of(struct kernfs_open_file *of)
+{
+	/* Skip if file was already released */
+	if (unlikely(of->released))
+		return NULL;
+
+	if (!kernfs_get_active(of->kn))
+		return NULL;
+
+	return of;
+}
+
+static void kernfs_put_active_of(struct kernfs_open_file *of)
+{
+	return kernfs_put_active(of->kn);
+}
+
 /**
  * kernfs_deref_open_node_locked - Get kernfs_open_node corresponding to @kn
  *
@@ -139,7 +157,7 @@ static void kernfs_seq_stop_active(struct seq_file *sf, void *v)
 
 	if (ops->seq_stop)
 		ops->seq_stop(sf, v);
-	kernfs_put_active(of->kn);
+	kernfs_put_active_of(of);
 }
 
 static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
@@ -152,7 +170,7 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
 	 * the ops aren't called concurrently for the same open file.
 	 */
 	mutex_lock(&of->mutex);
-	if (!kernfs_get_active(of->kn))
+	if (!kernfs_get_active_of(of))
 		return ERR_PTR(-ENODEV);
 
 	ops = kernfs_ops(of->kn);
@@ -238,7 +256,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * the ops aren't called concurrently for the same open file.
 	 */
 	mutex_lock(&of->mutex);
-	if (!kernfs_get_active(of->kn)) {
+	if (!kernfs_get_active_of(of)) {
 		len = -ENODEV;
 		mutex_unlock(&of->mutex);
 		goto out_free;
@@ -252,7 +270,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	else
 		len = -EINVAL;
 
-	kernfs_put_active(of->kn);
+	kernfs_put_active_of(of);
 	mutex_unlock(&of->mutex);
 
 	if (len < 0)
@@ -323,7 +341,7 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * the ops aren't called concurrently for the same open file.
 	 */
 	mutex_lock(&of->mutex);
-	if (!kernfs_get_active(of->kn)) {
+	if (!kernfs_get_active_of(of)) {
 		mutex_unlock(&of->mutex);
 		len = -ENODEV;
 		goto out_free;
@@ -335,7 +353,7 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	else
 		len = -EINVAL;
 
-	kernfs_put_active(of->kn);
+	kernfs_put_active_of(of);
 	mutex_unlock(&of->mutex);
 
 	if (len > 0)
@@ -357,13 +375,13 @@ static void kernfs_vma_open(struct vm_area_struct *vma)
 	if (!of->vm_ops)
 		return;
 
-	if (!kernfs_get_active(of->kn))
+	if (!kernfs_get_active_of(of))
 		return;
 
 	if (of->vm_ops->open)
 		of->vm_ops->open(vma);
 
-	kernfs_put_active(of->kn);
+	kernfs_put_active_of(of);
 }
 
 static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
@@ -375,14 +393,14 @@ static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
 	if (!of->vm_ops)
 		return VM_FAULT_SIGBUS;
 
-	if (!kernfs_get_active(of->kn))
+	if (!kernfs_get_active_of(of))
 		return VM_FAULT_SIGBUS;
 
 	ret = VM_FAULT_SIGBUS;
 	if (of->vm_ops->fault)
 		ret = of->vm_ops->fault(vmf);
 
-	kernfs_put_active(of->kn);
+	kernfs_put_active_of(of);
 	return ret;
 }
 
@@ -395,7 +413,7 @@ static vm_fault_t kernfs_vma_page_mkwrite(struct vm_fault *vmf)
 	if (!of->vm_ops)
 		return VM_FAULT_SIGBUS;
 
-	if (!kernfs_get_active(of->kn))
+	if (!kernfs_get_active_of(of))
 		return VM_FAULT_SIGBUS;
 
 	ret = 0;
@@ -404,7 +422,7 @@ static vm_fault_t kernfs_vma_page_mkwrite(struct vm_fault *vmf)
 	else
 		file_update_time(file);
 
-	kernfs_put_active(of->kn);
+	kernfs_put_active_of(of);
 	return ret;
 }
 
@@ -418,14 +436,14 @@ static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
 	if (!of->vm_ops)
 		return -EINVAL;
 
-	if (!kernfs_get_active(of->kn))
+	if (!kernfs_get_active_of(of))
 		return -EINVAL;
 
 	ret = -EINVAL;
 	if (of->vm_ops->access)
 		ret = of->vm_ops->access(vma, addr, buf, len, write);
 
-	kernfs_put_active(of->kn);
+	kernfs_put_active_of(of);
 	return ret;
 }
 
@@ -455,7 +473,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 	mutex_lock(&of->mutex);
 
 	rc = -ENODEV;
-	if (!kernfs_get_active(of->kn))
+	if (!kernfs_get_active_of(of))
 		goto out_unlock;
 
 	ops = kernfs_ops(of->kn);
@@ -490,7 +508,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 	}
 	vma->vm_ops = &kernfs_vm_ops;
 out_put:
-	kernfs_put_active(of->kn);
+	kernfs_put_active_of(of);
 out_unlock:
 	mutex_unlock(&of->mutex);
 
@@ -852,7 +870,7 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
 	struct kernfs_node *kn = kernfs_dentry_node(filp->f_path.dentry);
 	__poll_t ret;
 
-	if (!kernfs_get_active(kn))
+	if (!kernfs_get_active_of(of))
 		return DEFAULT_POLLMASK|EPOLLERR|EPOLLPRI;
 
 	if (kn->attr.ops->poll)
@@ -860,7 +878,7 @@ static __poll_t kernfs_fop_poll(struct file *filp, poll_table *wait)
 	else
 		ret = kernfs_generic_poll(of, wait);
 
-	kernfs_put_active(kn);
+	kernfs_put_active_of(of);
 	return ret;
 }
 
@@ -875,7 +893,7 @@ static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
 	 * the ops aren't called concurrently for the same open file.
 	 */
 	mutex_lock(&of->mutex);
-	if (!kernfs_get_active(of->kn)) {
+	if (!kernfs_get_active_of(of)) {
 		mutex_unlock(&of->mutex);
 		return -ENODEV;
 	}
@@ -886,7 +904,7 @@ static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
 	else
 		ret = generic_file_llseek(file, offset, whence);
 
-	kernfs_put_active(of->kn);
+	kernfs_put_active_of(of);
 	mutex_unlock(&of->mutex);
 	return ret;
 }
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 17edc124d03f..035474f3fb8f 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -881,6 +881,8 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 
 	if (fsinfo->xattr_support)
 		server->caps |= NFS_CAP_XATTR;
+	else
+		server->caps &= ~NFS_CAP_XATTR;
 #endif
 }
 
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index c1f1b826888c..f32f8d7c9122 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -320,6 +320,7 @@ static void nfs_read_sync_pgio_error(struct list_head *head, int error)
 static void nfs_direct_pgio_init(struct nfs_pgio_header *hdr)
 {
 	get_dreq(hdr->dreq);
+	set_bit(NFS_IOHDR_ODIRECT, &hdr->flags);
 }
 
 static const struct nfs_pgio_completion_ops nfs_direct_read_completion_ops = {
@@ -471,8 +472,16 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	if (user_backed_iter(iter))
 		dreq->flags = NFS_ODIRECT_SHOULD_DIRTY;
 
-	if (!swap)
-		nfs_start_io_direct(inode);
+	if (!swap) {
+		result = nfs_start_io_direct(inode);
+		if (result) {
+			/* release the reference that would usually be
+			 * consumed by nfs_direct_read_schedule_iovec()
+			 */
+			nfs_direct_req_release(dreq);
+			goto out_release;
+		}
+	}
 
 	NFS_I(inode)->read_io += count;
 	requested = nfs_direct_read_schedule_iovec(dreq, iter, iocb->ki_pos);
@@ -1030,7 +1039,14 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 		requested = nfs_direct_write_schedule_iovec(dreq, iter, pos,
 							    FLUSH_STABLE);
 	} else {
-		nfs_start_io_direct(inode);
+		result = nfs_start_io_direct(inode);
+		if (result) {
+			/* release the reference that would usually be
+			 * consumed by nfs_direct_write_schedule_iovec()
+			 */
+			nfs_direct_req_release(dreq);
+			goto out_release;
+		}
 
 		requested = nfs_direct_write_schedule_iovec(dreq, iter, pos,
 							    FLUSH_COND_STABLE);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 153d25d4b810..a16a619fb8c3 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -167,7 +167,10 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 		iocb->ki_filp,
 		iov_iter_count(to), (unsigned long) iocb->ki_pos);
 
-	nfs_start_io_read(inode);
+	result = nfs_start_io_read(inode);
+	if (result)
+		return result;
+
 	result = nfs_revalidate_mapping(inode, iocb->ki_filp->f_mapping);
 	if (!result) {
 		result = generic_file_read_iter(iocb, to);
@@ -188,7 +191,10 @@ nfs_file_splice_read(struct file *in, loff_t *ppos, struct pipe_inode_info *pipe
 
 	dprintk("NFS: splice_read(%pD2, %zu@%llu)\n", in, len, *ppos);
 
-	nfs_start_io_read(inode);
+	result = nfs_start_io_read(inode);
+	if (result)
+		return result;
+
 	result = nfs_revalidate_mapping(inode, in->f_mapping);
 	if (!result) {
 		result = filemap_splice_read(in, ppos, pipe, len, flags);
@@ -431,10 +437,11 @@ static void nfs_invalidate_folio(struct folio *folio, size_t offset,
 	dfprintk(PAGECACHE, "NFS: invalidate_folio(%lu, %zu, %zu)\n",
 		 folio->index, offset, length);
 
-	if (offset != 0 || length < folio_size(folio))
-		return;
 	/* Cancel any unstarted writes on this page */
-	nfs_wb_folio_cancel(inode, folio);
+	if (offset != 0 || length < folio_size(folio))
+		nfs_wb_folio(inode, folio);
+	else
+		nfs_wb_folio_cancel(inode, folio);
 	folio_wait_private_2(folio); /* [DEPRECATED] */
 	trace_nfs_invalidate_folio(inode, folio_pos(folio) + offset, length);
 }
@@ -669,7 +676,9 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	nfs_clear_invalid_mapping(file->f_mapping);
 
 	since = filemap_sample_wb_err(file->f_mapping);
-	nfs_start_io_write(inode);
+	error = nfs_start_io_write(inode);
+	if (error)
+		return error;
 	result = generic_write_checks(iocb, from);
 	if (result > 0)
 		result = generic_perform_write(iocb, from);
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index b685e763ef11..646984697196 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -292,7 +292,7 @@ ff_lseg_match_mirrors(struct pnfs_layout_segment *l1,
 		struct pnfs_layout_segment *l2)
 {
 	const struct nfs4_ff_layout_segment *fl1 = FF_LAYOUT_LSEG(l1);
-	const struct nfs4_ff_layout_segment *fl2 = FF_LAYOUT_LSEG(l1);
+	const struct nfs4_ff_layout_segment *fl2 = FF_LAYOUT_LSEG(l2);
 	u32 i;
 
 	if (fl1->mirror_array_cnt != fl2->mirror_array_cnt)
@@ -772,8 +772,11 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
 			continue;
 
 		if (check_device &&
-		    nfs4_test_deviceid_unavailable(&mirror->mirror_ds->id_node))
+		    nfs4_test_deviceid_unavailable(&mirror->mirror_ds->id_node)) {
+			// reinitialize the error state in case if this is the last iteration
+			ds = ERR_PTR(-EINVAL);
 			continue;
+		}
 
 		*best_idx = idx;
 		break;
@@ -803,7 +806,7 @@ ff_layout_choose_best_ds_for_read(struct pnfs_layout_segment *lseg,
 	struct nfs4_pnfs_ds *ds;
 
 	ds = ff_layout_choose_valid_ds_for_read(lseg, start_idx, best_idx);
-	if (ds)
+	if (!IS_ERR(ds))
 		return ds;
 	return ff_layout_choose_any_ds_for_read(lseg, start_idx, best_idx);
 }
@@ -817,7 +820,7 @@ ff_layout_get_ds_for_read(struct nfs_pageio_descriptor *pgio,
 
 	ds = ff_layout_choose_best_ds_for_read(lseg, pgio->pg_mirror_idx,
 					       best_idx);
-	if (ds || !pgio->pg_mirror_idx)
+	if (!IS_ERR(ds) || !pgio->pg_mirror_idx)
 		return ds;
 	return ff_layout_choose_best_ds_for_read(lseg, 0, best_idx);
 }
@@ -867,7 +870,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	req->wb_nio = 0;
 
 	ds = ff_layout_get_ds_for_read(pgio, &ds_idx);
-	if (!ds) {
+	if (IS_ERR(ds)) {
 		if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
 			goto out_mds;
 		pnfs_generic_pg_cleanup(pgio);
@@ -1071,11 +1074,13 @@ static void ff_layout_resend_pnfs_read(struct nfs_pgio_header *hdr)
 {
 	u32 idx = hdr->pgio_mirror_idx + 1;
 	u32 new_idx = 0;
+	struct nfs4_pnfs_ds *ds;
 
-	if (ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx))
-		ff_layout_send_layouterror(hdr->lseg);
-	else
+	ds = ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx);
+	if (IS_ERR(ds))
 		pnfs_error_mark_layout_for_return(hdr->inode, hdr->lseg);
+	else
+		ff_layout_send_layouterror(hdr->lseg);
 	pnfs_read_resend_pnfs(hdr, new_idx);
 }
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 8827cb00f86d..5bf5fb5ddd34 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -761,8 +761,10 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	trace_nfs_setattr_enter(inode);
 
 	/* Write all dirty data */
-	if (S_ISREG(inode->i_mode))
+	if (S_ISREG(inode->i_mode)) {
+		nfs_file_block_o_direct(NFS_I(inode));
 		nfs_sync_inode(inode);
+	}
 
 	fattr = nfs_alloc_fattr_with_label(NFS_SERVER(inode));
 	if (fattr == NULL) {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 882d804089ad..456b42340281 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -6,6 +6,7 @@
 #include "nfs4_fs.h"
 #include <linux/fs_context.h>
 #include <linux/security.h>
+#include <linux/compiler_attributes.h>
 #include <linux/crc32.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_page.h>
@@ -516,11 +517,11 @@ extern const struct netfs_request_ops nfs_netfs_ops;
 #endif
 
 /* io.c */
-extern void nfs_start_io_read(struct inode *inode);
+extern __must_check int nfs_start_io_read(struct inode *inode);
 extern void nfs_end_io_read(struct inode *inode);
-extern void nfs_start_io_write(struct inode *inode);
+extern  __must_check int nfs_start_io_write(struct inode *inode);
 extern void nfs_end_io_write(struct inode *inode);
-extern void nfs_start_io_direct(struct inode *inode);
+extern __must_check int nfs_start_io_direct(struct inode *inode);
 extern void nfs_end_io_direct(struct inode *inode);
 
 static inline bool nfs_file_io_is_buffered(struct nfs_inode *nfsi)
@@ -528,6 +529,16 @@ static inline bool nfs_file_io_is_buffered(struct nfs_inode *nfsi)
 	return test_bit(NFS_INO_ODIRECT, &nfsi->flags) == 0;
 }
 
+/* Must be called with exclusively locked inode->i_rwsem */
+static inline void nfs_file_block_o_direct(struct nfs_inode *nfsi)
+{
+	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags)) {
+		clear_bit(NFS_INO_ODIRECT, &nfsi->flags);
+		inode_dio_wait(&nfsi->vfs_inode);
+	}
+}
+
+
 /* namespace.c */
 #define NFS_PATH_CANONICAL 1
 extern char *nfs_path(char **p, struct dentry *dentry,
diff --git a/fs/nfs/io.c b/fs/nfs/io.c
index b5551ed8f648..d275b0a250bf 100644
--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -14,15 +14,6 @@
 
 #include "internal.h"
 
-/* Call with exclusively locked inode->i_rwsem */
-static void nfs_block_o_direct(struct nfs_inode *nfsi, struct inode *inode)
-{
-	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags)) {
-		clear_bit(NFS_INO_ODIRECT, &nfsi->flags);
-		inode_dio_wait(inode);
-	}
-}
-
 /**
  * nfs_start_io_read - declare the file is being used for buffered reads
  * @inode: file inode
@@ -39,19 +30,28 @@ static void nfs_block_o_direct(struct nfs_inode *nfsi, struct inode *inode)
  * Note that buffered writes and truncates both take a write lock on
  * inode->i_rwsem, meaning that those are serialised w.r.t. the reads.
  */
-void
+int
 nfs_start_io_read(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
+	int err;
+
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	err = down_read_killable(&inode->i_rwsem);
+	if (err)
+		return err;
 	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags) == 0)
-		return;
+		return 0;
 	up_read(&inode->i_rwsem);
+
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
-	nfs_block_o_direct(nfsi, inode);
+	err = down_write_killable(&inode->i_rwsem);
+	if (err)
+		return err;
+	nfs_file_block_o_direct(nfsi);
 	downgrade_write(&inode->i_rwsem);
+
+	return 0;
 }
 
 /**
@@ -74,11 +74,15 @@ nfs_end_io_read(struct inode *inode)
  * Declare that a buffered read operation is about to start, and ensure
  * that we block all direct I/O.
  */
-void
+int
 nfs_start_io_write(struct inode *inode)
 {
-	down_write(&inode->i_rwsem);
-	nfs_block_o_direct(NFS_I(inode), inode);
+	int err;
+
+	err = down_write_killable(&inode->i_rwsem);
+	if (!err)
+		nfs_file_block_o_direct(NFS_I(inode));
+	return err;
 }
 
 /**
@@ -119,19 +123,28 @@ static void nfs_block_buffered(struct nfs_inode *nfsi, struct inode *inode)
  * Note that buffered writes and truncates both take a write lock on
  * inode->i_rwsem, meaning that those are serialised w.r.t. O_DIRECT.
  */
-void
+int
 nfs_start_io_direct(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
+	int err;
+
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	err = down_read_killable(&inode->i_rwsem);
+	if (err)
+		return err;
 	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags) != 0)
-		return;
+		return 0;
 	up_read(&inode->i_rwsem);
+
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	err = down_write_killable(&inode->i_rwsem);
+	if (err)
+		return err;
 	nfs_block_buffered(nfsi, inode);
 	downgrade_write(&inode->i_rwsem);
+
+	return 0;
 }
 
 /**
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 21b2b38fae9f..82a053304ad5 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -35,6 +35,7 @@ struct nfs_local_kiocb {
 	struct bio_vec		*bvec;
 	struct nfs_pgio_header	*hdr;
 	struct work_struct	work;
+	void (*aio_complete_work)(struct work_struct *);
 	struct nfsd_file	*localio;
 };
 
@@ -50,6 +51,11 @@ static void nfs_local_fsync_work(struct work_struct *work);
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
+static bool localio_O_DIRECT_semantics __read_mostly = false;
+module_param(localio_O_DIRECT_semantics, bool, 0644);
+MODULE_PARM_DESC(localio_O_DIRECT_semantics,
+		 "LOCALIO will use O_DIRECT semantics to filesystem.");
+
 static inline bool nfs_client_is_local(const struct nfs_client *clp)
 {
 	return !!test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
@@ -274,7 +280,7 @@ nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
 
 static struct nfs_local_kiocb *
 nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
-		     struct nfsd_file *localio, gfp_t flags)
+		     struct file *file, gfp_t flags)
 {
 	struct nfs_local_kiocb *iocb;
 
@@ -287,11 +293,19 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 		kfree(iocb);
 		return NULL;
 	}
-	init_sync_kiocb(&iocb->kiocb, nfs_to->nfsd_file_file(localio));
+
+	if (localio_O_DIRECT_semantics &&
+	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
+		iocb->kiocb.ki_filp = file;
+		iocb->kiocb.ki_flags = IOCB_DIRECT;
+	} else
+		init_sync_kiocb(&iocb->kiocb, file);
+
 	iocb->kiocb.ki_pos = hdr->args.offset;
-	iocb->localio = localio;
 	iocb->hdr = hdr;
 	iocb->kiocb.ki_flags &= ~IOCB_APPEND;
+	iocb->aio_complete_work = NULL;
+
 	return iocb;
 }
 
@@ -346,6 +360,18 @@ nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
 	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
 }
 
+/*
+ * Complete the I/O from iocb->kiocb.ki_complete()
+ *
+ * Note that this function can be called from a bottom half context,
+ * hence we need to queue the rpc_call_done() etc to a workqueue
+ */
+static inline void nfs_local_pgio_aio_complete(struct nfs_local_kiocb *iocb)
+{
+	INIT_WORK(&iocb->work, iocb->aio_complete_work);
+	queue_work(nfsiod_workqueue, &iocb->work);
+}
+
 static void
 nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
 {
@@ -368,6 +394,23 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
 			status > 0 ? status : 0, hdr->res.eof);
 }
 
+static void nfs_local_read_aio_complete_work(struct work_struct *work)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(work, struct nfs_local_kiocb, work);
+
+	nfs_local_pgio_release(iocb);
+}
+
+static void nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(kiocb, struct nfs_local_kiocb, kiocb);
+
+	nfs_local_read_done(iocb, ret);
+	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_read_aio_complete_work */
+}
+
 static void nfs_local_call_read(struct work_struct *work)
 {
 	struct nfs_local_kiocb *iocb =
@@ -382,12 +425,13 @@ static void nfs_local_call_read(struct work_struct *work)
 	nfs_local_iter_init(&iter, iocb, READ);
 
 	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
-	WARN_ON_ONCE(status == -EIOCBQUEUED);
-
-	nfs_local_read_done(iocb, status);
-	nfs_local_pgio_release(iocb);
 
 	revert_creds(save_cred);
+
+	if (status != -EIOCBQUEUED) {
+		nfs_local_read_done(iocb, status);
+		nfs_local_pgio_release(iocb);
+	}
 }
 
 static int
@@ -396,17 +440,28 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
 		  const struct rpc_call_ops *call_ops)
 {
 	struct nfs_local_kiocb *iocb;
+	struct file *file = nfs_to->nfsd_file_file(localio);
+
+	/* Don't support filesystems without read_iter */
+	if (!file->f_op->read_iter)
+		return -EAGAIN;
 
 	dprintk("%s: vfs_read count=%u pos=%llu\n",
 		__func__, hdr->args.count, hdr->args.offset);
 
-	iocb = nfs_local_iocb_alloc(hdr, localio, GFP_KERNEL);
+	iocb = nfs_local_iocb_alloc(hdr, file, GFP_KERNEL);
 	if (iocb == NULL)
 		return -ENOMEM;
+	iocb->localio = localio;
 
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
 
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+	}
+
 	INIT_WORK(&iocb->work, nfs_local_call_read);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
 
@@ -536,6 +591,24 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
 	nfs_local_pgio_done(hdr, status);
 }
 
+static void nfs_local_write_aio_complete_work(struct work_struct *work)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(work, struct nfs_local_kiocb, work);
+
+	nfs_local_vfs_getattr(iocb);
+	nfs_local_pgio_release(iocb);
+}
+
+static void nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(kiocb, struct nfs_local_kiocb, kiocb);
+
+	nfs_local_write_done(iocb, ret);
+	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_write_aio_complete_work */
+}
+
 static void nfs_local_call_write(struct work_struct *work)
 {
 	struct nfs_local_kiocb *iocb =
@@ -554,14 +627,15 @@ static void nfs_local_call_write(struct work_struct *work)
 	file_start_write(filp);
 	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
 	file_end_write(filp);
-	WARN_ON_ONCE(status == -EIOCBQUEUED);
-
-	nfs_local_write_done(iocb, status);
-	nfs_local_vfs_getattr(iocb);
-	nfs_local_pgio_release(iocb);
 
 	revert_creds(save_cred);
 	current->flags = old_flags;
+
+	if (status != -EIOCBQUEUED) {
+		nfs_local_write_done(iocb, status);
+		nfs_local_vfs_getattr(iocb);
+		nfs_local_pgio_release(iocb);
+	}
 }
 
 static int
@@ -570,14 +644,20 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 		   const struct rpc_call_ops *call_ops)
 {
 	struct nfs_local_kiocb *iocb;
+	struct file *file = nfs_to->nfsd_file_file(localio);
+
+	/* Don't support filesystems without write_iter */
+	if (!file->f_op->write_iter)
+		return -EAGAIN;
 
 	dprintk("%s: vfs_write count=%u pos=%llu %s\n",
 		__func__, hdr->args.count, hdr->args.offset,
 		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
 
-	iocb = nfs_local_iocb_alloc(hdr, localio, GFP_NOIO);
+	iocb = nfs_local_iocb_alloc(hdr, file, GFP_NOIO);
 	if (iocb == NULL)
 		return -ENOMEM;
+	iocb->localio = localio;
 
 	switch (hdr->args.stable) {
 	default:
@@ -588,10 +668,16 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 	case NFS_FILE_SYNC:
 		iocb->kiocb.ki_flags |= IOCB_DSYNC|IOCB_SYNC;
 	}
+
 	nfs_local_pgio_init(hdr, call_ops);
 
 	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
 
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
+		iocb->aio_complete_work = nfs_local_write_aio_complete_work;
+	}
+
 	INIT_WORK(&iocb->work, nfs_local_call_write);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
 
@@ -603,16 +689,9 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 		   const struct rpc_call_ops *call_ops)
 {
 	int status = 0;
-	struct file *filp = nfs_to->nfsd_file_file(localio);
 
 	if (!hdr->args.count)
 		return 0;
-	/* Don't support filesystems without read_iter/write_iter */
-	if (!filp->f_op->read_iter || !filp->f_op->write_iter) {
-		nfs_local_disable(clp);
-		status = -EAGAIN;
-		goto out;
-	}
 
 	switch (hdr->rw_mode) {
 	case FMODE_READ:
@@ -626,8 +705,10 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 			hdr->rw_mode);
 		status = -EINVAL;
 	}
-out:
+
 	if (status != 0) {
+		if (status == -EAGAIN)
+			nfs_local_disable(clp);
 		nfs_to_nfsd_file_put_local(localio);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, call_ops);
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 9f0d69e65264..582cf8a46956 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -112,6 +112,7 @@ static int nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 	exception.inode = inode;
 	exception.state = lock->open_context->state;
 
+	nfs_file_block_o_direct(NFS_I(inode));
 	err = nfs_sync_inode(inode);
 	if (err)
 		goto out;
@@ -355,6 +356,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 		return status;
 	}
 
+	nfs_file_block_o_direct(NFS_I(dst_inode));
 	status = nfs_sync_inode(dst_inode);
 	if (status)
 		return status;
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 1cd9652f3c28..453d08a9c4b4 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -283,9 +283,11 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
 
 	/* flush all pending writes on both src and dst so that server
 	 * has the latest data */
+	nfs_file_block_o_direct(NFS_I(src_inode));
 	ret = nfs_sync_inode(src_inode);
 	if (ret)
 		goto out_unlock;
+	nfs_file_block_o_direct(NFS_I(dst_inode));
 	ret = nfs_sync_inode(dst_inode);
 	if (ret)
 		goto out_unlock;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e6b7cbc06c9c..ea92483d5e71 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3989,8 +3989,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 				     res.attr_bitmask[2];
 		}
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
-		server->caps &= ~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS |
-				  NFS_CAP_SYMLINKS| NFS_CAP_SECURITY_LABEL);
+		server->caps &=
+			~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS |
+			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS |
+			  NFS_CAP_OPEN_XOR | NFS_CAP_DELEGTIME);
 		server->fattr_valid = NFS_ATTR_FATTR_V4;
 		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
 				res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
@@ -4064,7 +4066,6 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 	};
 	int err;
 
-	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2b6b3542405c..fd86546fafd3 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2058,6 +2058,7 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
 		 * release it */
 		nfs_inode_remove_request(req);
 		nfs_unlock_and_release_request(req);
+		folio_cancel_dirty(folio);
 	}
 
 	return ret;
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index f7672472fa82..5e86c7e2c821 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -696,6 +696,8 @@ int ocfs2_extent_map_get_blocks(struct inode *inode, u64 v_blkno, u64 *p_blkno,
  * it not only handles the fiemap for inlined files, but also deals
  * with the fast symlink, cause they have no difference for extent
  * mapping per se.
+ *
+ * Must be called with ip_alloc_sem semaphore held.
  */
 static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 			       struct fiemap_extent_info *fieinfo,
@@ -707,6 +709,7 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 	u64 phys;
 	u32 flags = FIEMAP_EXTENT_DATA_INLINE|FIEMAP_EXTENT_LAST;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
+	lockdep_assert_held_read(&oi->ip_alloc_sem);
 
 	di = (struct ocfs2_dinode *)di_bh->b_data;
 	if (ocfs2_inode_is_fast_symlink(inode))
@@ -722,8 +725,11 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 			phys += offsetof(struct ocfs2_dinode,
 					 id2.i_data.id_data);
 
+		/* Release the ip_alloc_sem to prevent deadlock on page fault */
+		up_read(&OCFS2_I(inode)->ip_alloc_sem);
 		ret = fiemap_fill_next_extent(fieinfo, 0, phys, id_count,
 					      flags);
+		down_read(&OCFS2_I(inode)->ip_alloc_sem);
 		if (ret < 0)
 			return ret;
 	}
@@ -792,9 +798,11 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		len_bytes = (u64)le16_to_cpu(rec.e_leaf_clusters) << osb->s_clustersize_bits;
 		phys_bytes = le64_to_cpu(rec.e_blkno) << osb->sb->s_blocksize_bits;
 		virt_bytes = (u64)le32_to_cpu(rec.e_cpos) << osb->s_clustersize_bits;
-
+		/* Release the ip_alloc_sem to prevent deadlock on page fault */
+		up_read(&OCFS2_I(inode)->ip_alloc_sem);
 		ret = fiemap_fill_next_extent(fieinfo, virt_bytes, phys_bytes,
 					      len_bytes, fe_flags);
+		down_read(&OCFS2_I(inode)->ip_alloc_sem);
 		if (ret)
 			break;
 
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index a87a9404e0d0..eb49beff69bc 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -388,7 +388,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 	if (proc_alloc_inum(&dp->low_ino))
 		goto out_free_entry;
 
-	pde_set_flags(dp);
+	if (!S_ISDIR(dp->mode))
+		pde_set_flags(dp);
 
 	write_lock(&proc_subdir_lock);
 	dp->parent = dir;
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 4c1a39dcb624..c4e705b794c5 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -18,23 +18,42 @@
 #define KASAN_ABI_VERSION 5
 
 /*
+ * Clang 22 added preprocessor macros to match GCC, in hopes of eventually
+ * dropping __has_feature support for sanitizers:
+ * https://github.com/llvm/llvm-project/commit/568c23bbd3303518c5056d7f03444dae4fdc8a9c
+ * Create these macros for older versions of clang so that it is easy to clean
+ * up once the minimum supported version of LLVM for building the kernel always
+ * creates these macros.
+ *
  * Note: Checking __has_feature(*_sanitizer) is only true if the feature is
  * enabled. Therefore it is not required to additionally check defined(CONFIG_*)
  * to avoid adding redundant attributes in other configurations.
  */
+#if __has_feature(address_sanitizer) && !defined(__SANITIZE_ADDRESS__)
+#define __SANITIZE_ADDRESS__
+#endif
+#if __has_feature(hwaddress_sanitizer) && !defined(__SANITIZE_HWADDRESS__)
+#define __SANITIZE_HWADDRESS__
+#endif
+#if __has_feature(thread_sanitizer) && !defined(__SANITIZE_THREAD__)
+#define __SANITIZE_THREAD__
+#endif
 
-#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
-/* Emulate GCC's __SANITIZE_ADDRESS__ flag */
+/*
+ * Treat __SANITIZE_HWADDRESS__ the same as __SANITIZE_ADDRESS__ in the kernel.
+ */
+#ifdef __SANITIZE_HWADDRESS__
 #define __SANITIZE_ADDRESS__
+#endif
+
+#ifdef __SANITIZE_ADDRESS__
 #define __no_sanitize_address \
 		__attribute__((no_sanitize("address", "hwaddress")))
 #else
 #define __no_sanitize_address
 #endif
 
-#if __has_feature(thread_sanitizer)
-/* emulate gcc's __SANITIZE_THREAD__ flag */
-#define __SANITIZE_THREAD__
+#ifdef __SANITIZE_THREAD__
 #define __no_sanitize_thread \
 		__attribute__((no_sanitize("thread")))
 #else
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a6de8d93838d..37a01c9d9658 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1197,11 +1197,19 @@ extern int send_sigurg(struct file *file);
 #define SB_NOUSER       BIT(31)
 
 /* These flags relate to encoding and casefolding */
-#define SB_ENC_STRICT_MODE_FL	(1 << 0)
+#define SB_ENC_STRICT_MODE_FL		(1 << 0)
+#define SB_ENC_NO_COMPAT_FALLBACK_FL	(1 << 1)
 
 #define sb_has_strict_encoding(sb) \
 	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
 
+#if IS_ENABLED(CONFIG_UNICODE)
+#define sb_no_casefold_compat_fallback(sb) \
+	(sb->s_encoding_flags & SB_ENC_NO_COMPAT_FALLBACK_FL)
+#else
+#define sb_no_casefold_compat_fallback(sb) (1)
+#endif
+
 /*
  *	Umount options
  */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 12d8e47bc5a3..b48d94f09965 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1637,6 +1637,7 @@ enum {
 	NFS_IOHDR_RESEND_PNFS,
 	NFS_IOHDR_RESEND_MDS,
 	NFS_IOHDR_UNSTABLE_WRITES,
+	NFS_IOHDR_ODIRECT,
 };
 
 struct nfs_io_completion;
diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
new file mode 100644
index 000000000000..9174fa59bbc5
--- /dev/null
+++ b/include/linux/pgalloc.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PGALLOC_H
+#define _LINUX_PGALLOC_H
+
+#include <linux/pgtable.h>
+#include <asm/pgalloc.h>
+
+/*
+ * {pgd,p4d}_populate_kernel() are defined as macros to allow
+ * compile-time optimization based on the configured page table levels.
+ * Without this, linking may fail because callers (e.g., KASAN) may rely
+ * on calls to these functions being optimized away when passing symbols
+ * that exist only for certain page table levels.
+ */
+#define pgd_populate_kernel(addr, pgd, p4d)				\
+	do {								\
+		pgd_populate(&init_mm, pgd, p4d);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
+
+#define p4d_populate_kernel(addr, p4d, pud)				\
+	do {								\
+		p4d_populate(&init_mm, p4d, pud);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
+
+#endif /* _LINUX_PGALLOC_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1ba6e32909f8..d2ae79f7c552 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1699,8 +1699,8 @@ static inline int pmd_protnone(pmd_t pmd)
 
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
  */
 #ifndef ARCH_PAGE_TABLE_SYNC_MASK
 #define ARCH_PAGE_TABLE_SYNC_MASK 0
@@ -1833,10 +1833,11 @@ static inline bool arch_has_pfn_modify_check(void)
 /*
  * Page Table Modification bits for pgtbl_mod_mask.
  *
- * These are used by the p?d_alloc_track*() set of functions an in the generic
- * vmalloc/ioremap code to track at which page-table levels entries have been
- * modified. Based on that the code can better decide when vmalloc and ioremap
- * mapping changes need to be synchronized to other page-tables in the system.
+ * These are used by the p?d_alloc_track*() and p*d_populate_kernel()
+ * functions in the generic vmalloc, ioremap and page table update code
+ * to track at which page-table levels entries have been modified.
+ * Based on that the code can better decide when page table changes need
+ * to be synchronized to other page-tables in the system.
  */
 #define		__PGTBL_PGD_MODIFIED	0
 #define		__PGTBL_P4D_MODIFIED	1
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 757abcb54d11..ee550229d4ff 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -459,19 +459,17 @@ struct nft_set_ext;
  *	control plane functions.
  */
 struct nft_set_ops {
-	bool				(*lookup)(const struct net *net,
+	const struct nft_set_ext *	(*lookup)(const struct net *net,
 						  const struct nft_set *set,
-						  const u32 *key,
-						  const struct nft_set_ext **ext);
-	bool				(*update)(struct nft_set *set,
+						  const u32 *key);
+	const struct nft_set_ext *	(*update)(struct nft_set *set,
 						  const u32 *key,
 						  struct nft_elem_priv *
 							(*new)(struct nft_set *,
 							       const struct nft_expr *,
 							       struct nft_regs *),
 						  const struct nft_expr *expr,
-						  struct nft_regs *regs,
-						  const struct nft_set_ext **ext);
+						  struct nft_regs *regs);
 	bool				(*delete)(const struct nft_set *set,
 						  const u32 *key);
 
@@ -1911,7 +1909,6 @@ struct nftables_pernet {
 	struct mutex		commit_mutex;
 	u64			table_handle;
 	u64			tstamp;
-	unsigned int		base_seq;
 	unsigned int		gc_seq;
 	u8			validate_state;
 	struct work_struct	destroy_work;
diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 03b6165756fc..04699eac5b52 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -94,34 +94,35 @@ extern const struct nft_set_type nft_set_pipapo_type;
 extern const struct nft_set_type nft_set_pipapo_avx2_type;
 
 #ifdef CONFIG_MITIGATION_RETPOLINE
-bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
-		      const u32 *key, const struct nft_set_ext **ext);
-bool nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext);
-bool nft_bitmap_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext);
-bool nft_hash_lookup_fast(const struct net *net,
-			  const struct nft_set *set,
-			  const u32 *key, const struct nft_set_ext **ext);
-bool nft_hash_lookup(const struct net *net, const struct nft_set *set,
-		     const u32 *key, const struct nft_set_ext **ext);
-bool nft_set_do_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext);
-#else
-static inline bool
-nft_set_do_lookup(const struct net *net, const struct nft_set *set,
-		  const u32 *key, const struct nft_set_ext **ext)
-{
-	return set->ops->lookup(net, set, key, ext);
-}
+const struct nft_set_ext *
+nft_rhash_lookup(const struct net *net, const struct nft_set *set,
+		 const u32 *key);
+const struct nft_set_ext *
+nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key);
+const struct nft_set_ext *
+nft_bitmap_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key);
+const struct nft_set_ext *
+nft_hash_lookup_fast(const struct net *net, const struct nft_set *set,
+		     const u32 *key);
+const struct nft_set_ext *
+nft_hash_lookup(const struct net *net, const struct nft_set *set,
+		const u32 *key);
 #endif
 
+const struct nft_set_ext *
+nft_set_do_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key);
+
 /* called from nft_pipapo_avx2.c */
-bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext);
+const struct nft_set_ext *
+nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key);
 /* called from nft_set_pipapo.c */
-bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
-			    const u32 *key, const struct nft_set_ext **ext);
+const struct nft_set_ext *
+nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
+			const u32 *key);
 
 void nft_counter_init_seqcount(void);
 
diff --git a/include/net/netns/nftables.h b/include/net/netns/nftables.h
index cc8060c017d5..99dd166c5d07 100644
--- a/include/net/netns/nftables.h
+++ b/include/net/netns/nftables.h
@@ -3,6 +3,7 @@
 #define _NETNS_NFTABLES_H_
 
 struct netns_nftables {
+	unsigned int		base_seq;
 	u8			gencursor;
 };
 
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index b0f41265191c..63b55ccc4f00 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -114,10 +114,11 @@ DEFINE_EVENT(dma_unmap, dma_unmap_resource,
 		 enum dma_data_direction dir, unsigned long attrs),
 	TP_ARGS(dev, addr, size, dir, attrs));
 
-TRACE_EVENT(dma_alloc,
+DECLARE_EVENT_CLASS(dma_alloc_class,
 	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
-		 size_t size, gfp_t flags, unsigned long attrs),
-	TP_ARGS(dev, virt_addr, dma_addr, size, flags, attrs),
+		 size_t size, enum dma_data_direction dir, gfp_t flags,
+		 unsigned long attrs),
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, flags, attrs),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
@@ -125,6 +126,7 @@ TRACE_EVENT(dma_alloc,
 		__field(u64, dma_addr)
 		__field(size_t, size)
 		__field(gfp_t, flags)
+		__field(enum dma_data_direction, dir)
 		__field(unsigned long, attrs)
 	),
 
@@ -137,8 +139,9 @@ TRACE_EVENT(dma_alloc,
 		__entry->attrs = attrs;
 	),
 
-	TP_printk("%s dma_addr=%llx size=%zu virt_addr=%p flags=%s attrs=%s",
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu virt_addr=%p flags=%s attrs=%s",
 		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
 		__entry->dma_addr,
 		__entry->size,
 		__entry->virt_addr,
@@ -146,16 +149,69 @@ TRACE_EVENT(dma_alloc,
 		decode_dma_attrs(__entry->attrs))
 );
 
-TRACE_EVENT(dma_free,
+#define DEFINE_ALLOC_EVENT(name) \
+DEFINE_EVENT(dma_alloc_class, name, \
+	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr, \
+		 size_t size, enum dma_data_direction dir, gfp_t flags, \
+		 unsigned long attrs), \
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, flags, attrs))
+
+DEFINE_ALLOC_EVENT(dma_alloc);
+DEFINE_ALLOC_EVENT(dma_alloc_pages);
+DEFINE_ALLOC_EVENT(dma_alloc_sgt_err);
+
+TRACE_EVENT(dma_alloc_sgt,
+	TP_PROTO(struct device *dev, struct sg_table *sgt, size_t size,
+		 enum dma_data_direction dir, gfp_t flags, unsigned long attrs),
+	TP_ARGS(dev, sgt, size, dir, flags, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(u64, phys_addrs, sgt->orig_nents)
+		__field(u64, dma_addr)
+		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
+		__field(gfp_t, flags)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		struct scatterlist *sg;
+		int i;
+
+		__assign_str(device);
+		for_each_sg(sgt->sgl, sg, sgt->orig_nents, i)
+			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
+		__entry->dma_addr = sg_dma_address(sgt->sgl);
+		__entry->size = size;
+		__entry->dir = dir;
+		__entry->flags = flags;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu phys_addrs=%s flags=%s attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__entry->dma_addr,
+		__entry->size,
+		__print_array(__get_dynamic_array(phys_addrs),
+			      __get_dynamic_array_len(phys_addrs) /
+				sizeof(u64), sizeof(u64)),
+		show_gfp_flags(__entry->flags),
+		decode_dma_attrs(__entry->attrs))
+);
+
+DECLARE_EVENT_CLASS(dma_free_class,
 	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
-		 size_t size, unsigned long attrs),
-	TP_ARGS(dev, virt_addr, dma_addr, size, attrs),
+		 size_t size, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, attrs),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
 		__field(void *, virt_addr)
 		__field(u64, dma_addr)
 		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
 		__field(unsigned long, attrs)
 	),
 
@@ -164,17 +220,63 @@ TRACE_EVENT(dma_free,
 		__entry->virt_addr = virt_addr;
 		__entry->dma_addr = dma_addr;
 		__entry->size = size;
+		__entry->dir = dir;
 		__entry->attrs = attrs;
 	),
 
-	TP_printk("%s dma_addr=%llx size=%zu virt_addr=%p attrs=%s",
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu virt_addr=%p attrs=%s",
 		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
 		__entry->dma_addr,
 		__entry->size,
 		__entry->virt_addr,
 		decode_dma_attrs(__entry->attrs))
 );
 
+#define DEFINE_FREE_EVENT(name) \
+DEFINE_EVENT(dma_free_class, name, \
+	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr, \
+		 size_t size, enum dma_data_direction dir, unsigned long attrs), \
+	TP_ARGS(dev, virt_addr, dma_addr, size, dir, attrs))
+
+DEFINE_FREE_EVENT(dma_free);
+DEFINE_FREE_EVENT(dma_free_pages);
+
+TRACE_EVENT(dma_free_sgt,
+	TP_PROTO(struct device *dev, struct sg_table *sgt, size_t size,
+		 enum dma_data_direction dir),
+	TP_ARGS(dev, sgt, size, dir),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(u64, phys_addrs, sgt->orig_nents)
+		__field(u64, dma_addr)
+		__field(size_t, size)
+		__field(enum dma_data_direction, dir)
+	),
+
+	TP_fast_assign(
+		struct scatterlist *sg;
+		int i;
+
+		__assign_str(device);
+		for_each_sg(sgt->sgl, sg, sgt->orig_nents, i)
+			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
+		__entry->dma_addr = sg_dma_address(sgt->sgl);
+		__entry->size = size;
+		__entry->dir = dir;
+	),
+
+	TP_printk("%s dir=%s dma_addr=%llx size=%zu phys_addrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__entry->dma_addr,
+		__entry->size,
+		__print_array(__get_dynamic_array(phys_addrs),
+			      __get_dynamic_array_len(phys_addrs) /
+				sizeof(u64), sizeof(u64)))
+);
+
 TRACE_EVENT(dma_map_sg,
 	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
 		 int ents, enum dma_data_direction dir, unsigned long attrs),
@@ -221,6 +323,41 @@ TRACE_EVENT(dma_map_sg,
 		decode_dma_attrs(__entry->attrs))
 );
 
+TRACE_EVENT(dma_map_sg_err,
+	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
+		 int err, enum dma_data_direction dir, unsigned long attrs),
+	TP_ARGS(dev, sgl, nents, err, dir, attrs),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__dynamic_array(u64, phys_addrs, nents)
+		__field(int, err)
+		__field(enum dma_data_direction, dir)
+		__field(unsigned long, attrs)
+	),
+
+	TP_fast_assign(
+		struct scatterlist *sg;
+		int i;
+
+		__assign_str(device);
+		for_each_sg(sgl, sg, nents, i)
+			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
+		__entry->err = err;
+		__entry->dir = dir;
+		__entry->attrs = attrs;
+	),
+
+	TP_printk("%s dir=%s dma_addrs=%s err=%d attrs=%s",
+		__get_str(device),
+		decode_dma_data_direction(__entry->dir),
+		__print_array(__get_dynamic_array(phys_addrs),
+			      __get_dynamic_array_len(phys_addrs) /
+				sizeof(u64), sizeof(u64)),
+		__entry->err,
+		decode_dma_attrs(__entry->attrs))
+);
+
 TRACE_EVENT(dma_unmap_sg,
 	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
 		 enum dma_data_direction dir, unsigned long attrs),
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 50589e5dd6a3..6ac84b2f636c 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -12,31 +12,33 @@
 /**
  * enum mptcp_event_type
  * @MPTCP_EVENT_UNSPEC: unused event
- * @MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport A new MPTCP connection has been created. It is the good time
- *   to allocate memory and send ADD_ADDR if needed. Depending on the
+ * @MPTCP_EVENT_CREATED: A new MPTCP connection has been created. It is the
+ *   good time to allocate memory and send ADD_ADDR if needed. Depending on the
  *   traffic-patterns it can take a long time until the MPTCP_EVENT_ESTABLISHED
- *   is sent.
- * @MPTCP_EVENT_ESTABLISHED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport A MPTCP connection is established (can start new subflows).
- * @MPTCP_EVENT_CLOSED: token A MPTCP connection has stopped.
- * @MPTCP_EVENT_ANNOUNCED: token, rem_id, family, daddr4 | daddr6 [, dport] A
- *   new address has been announced by the peer.
- * @MPTCP_EVENT_REMOVED: token, rem_id An address has been lost by the peer.
- * @MPTCP_EVENT_SUB_ESTABLISHED: token, family, loc_id, rem_id, saddr4 |
- *   saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error] A new
- *   subflow has been established. 'error' should not be set.
- * @MPTCP_EVENT_SUB_CLOSED: token, family, loc_id, rem_id, saddr4 | saddr6,
- *   daddr4 | daddr6, sport, dport, backup, if_idx [, error] A subflow has been
- *   closed. An error (copy of sk_err) could be set if an error has been
- *   detected for this subflow.
- * @MPTCP_EVENT_SUB_PRIORITY: token, family, loc_id, rem_id, saddr4 | saddr6,
- *   daddr4 | daddr6, sport, dport, backup, if_idx [, error] The priority of a
- *   subflow has changed. 'error' should not be set.
- * @MPTCP_EVENT_LISTENER_CREATED: family, sport, saddr4 | saddr6 A new PM
- *   listener is created.
- * @MPTCP_EVENT_LISTENER_CLOSED: family, sport, saddr4 | saddr6 A PM listener
- *   is closed.
+ *   is sent. Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
+ *   sport, dport, server-side.
+ * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is established (can start new
+ *   subflows). Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
+ *   sport, dport, server-side.
+ * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped. Attribute: token.
+ * @MPTCP_EVENT_ANNOUNCED: A new address has been announced by the peer.
+ *   Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
+ * @MPTCP_EVENT_REMOVED: An address has been lost by the peer. Attributes:
+ *   token, rem_id.
+ * @MPTCP_EVENT_SUB_ESTABLISHED: A new subflow has been established. 'error'
+ *   should not be set. Attributes: token, family, loc_id, rem_id, saddr4 |
+ *   saddr6, daddr4 | daddr6, sport, dport, backup, if-idx [, error].
+ * @MPTCP_EVENT_SUB_CLOSED: A subflow has been closed. An error (copy of
+ *   sk_err) could be set if an error has been detected for this subflow.
+ *   Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+ *   daddr6, sport, dport, backup, if-idx [, error].
+ * @MPTCP_EVENT_SUB_PRIORITY: The priority of a subflow has changed. 'error'
+ *   should not be set. Attributes: token, family, loc_id, rem_id, saddr4 |
+ *   saddr6, daddr4 | daddr6, sport, dport, backup, if-idx [, error].
+ * @MPTCP_EVENT_LISTENER_CREATED: A new PM listener is created. Attributes:
+ *   family, sport, saddr4 | saddr6.
+ * @MPTCP_EVENT_LISTENER_CLOSED: A PM listener is closed. Attributes: family,
+ *   sport, saddr4 | saddr6.
  */
 enum mptcp_event_type {
 	MPTCP_EVENT_UNSPEC,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6f91e3a123e5..9380e0fd5e4a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2299,8 +2299,7 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 					 const struct bpf_insn *insn)
 {
 	/* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
-	 * is not working properly, or interpreter is being used when
-	 * prog->jit_requested is not 0, so warn about it!
+	 * is not working properly, so warn about it!
 	 */
 	WARN_ON_ONCE(1);
 	return 0;
@@ -2401,8 +2400,9 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
 	return ret;
 }
 
-static void bpf_prog_select_func(struct bpf_prog *fp)
+static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 {
+	bool select_interpreter = false;
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
 	u32 idx = (round_up(stack_depth, 32) / 32) - 1;
@@ -2411,15 +2411,16 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
 	 * But for non-JITed programs, we don't need bpf_func, so no bounds
 	 * check needed.
 	 */
-	if (!fp->jit_requested &&
-	    !WARN_ON_ONCE(idx >= ARRAY_SIZE(interpreters))) {
+	if (idx < ARRAY_SIZE(interpreters)) {
 		fp->bpf_func = interpreters[idx];
+		select_interpreter = true;
 	} else {
 		fp->bpf_func = __bpf_prog_ret0_warn;
 	}
 #else
 	fp->bpf_func = __bpf_prog_ret0_warn;
 #endif
+	return select_interpreter;
 }
 
 /**
@@ -2438,7 +2439,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	/* In case of BPF to BPF calls, verifier did all the prep
 	 * work with regards to JITing, etc.
 	 */
-	bool jit_needed = fp->jit_requested;
+	bool jit_needed = false;
 
 	if (fp->bpf_func)
 		goto finalize;
@@ -2447,7 +2448,8 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	    bpf_prog_has_kfunc_call(fp))
 		jit_needed = true;
 
-	bpf_prog_select_func(fp);
+	if (!bpf_prog_select_interpreter(fp))
+		jit_needed = true;
 
 	/* eBPF JITs can rewrite the program in case constant
 	 * blinding is active. However, in case of error during
diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 94854cd9c4cc..83c4d9943084 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -278,7 +278,7 @@ static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
 	siv_len = siv ? __bpf_dynptr_size(siv) : 0;
 	src_len = __bpf_dynptr_size(src);
 	dst_len = __bpf_dynptr_size(dst);
-	if (!src_len || !dst_len)
+	if (!src_len || !dst_len || src_len > dst_len)
 		return -EINVAL;
 
 	if (siv_len != ctx->siv_len)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index be4429463599..a0bf39b7359a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1276,8 +1276,11 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		goto out;
 	}
 
-	/* allocate hrtimer via map_kmalloc to use memcg accounting */
-	cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
+	/* Allocate via bpf_map_kmalloc_node() for memcg accounting. Until
+	 * kmalloc_nolock() is available, avoid locking issues by using
+	 * __GFP_HIGH (GFP_ATOMIC & ~__GFP_RECLAIM).
+	 */
+	cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);
 	if (!cb) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index f6f0387761d0..39972e834e7a 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -39,6 +39,7 @@ enum {
 	dma_debug_sg,
 	dma_debug_coherent,
 	dma_debug_resource,
+	dma_debug_noncoherent,
 };
 
 enum map_err_types {
@@ -59,8 +60,7 @@ enum map_err_types {
  * @direction: enum dma_data_direction
  * @sg_call_ents: 'nents' from dma_map_sg
  * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
- * @pfn: page frame of the start address
- * @offset: offset of mapping relative to pfn
+ * @paddr: physical start address of the mapping
  * @map_err_type: track whether dma_mapping_error() was checked
  * @stack_len: number of backtrace entries in @stack_entries
  * @stack_entries: stack of backtrace history
@@ -74,8 +74,7 @@ struct dma_debug_entry {
 	int              direction;
 	int		 sg_call_ents;
 	int		 sg_mapped_ents;
-	unsigned long	 pfn;
-	size_t		 offset;
+	phys_addr_t	 paddr;
 	enum map_err_types  map_err_type;
 #ifdef CONFIG_STACKTRACE
 	unsigned int	stack_len;
@@ -143,6 +142,7 @@ static const char *type2name[] = {
 	[dma_debug_sg] = "scatter-gather",
 	[dma_debug_coherent] = "coherent",
 	[dma_debug_resource] = "resource",
+	[dma_debug_noncoherent] = "noncoherent",
 };
 
 static const char *dir2name[] = {
@@ -389,14 +389,6 @@ static void hash_bucket_del(struct dma_debug_entry *entry)
 	list_del(&entry->list);
 }
 
-static unsigned long long phys_addr(struct dma_debug_entry *entry)
-{
-	if (entry->type == dma_debug_resource)
-		return __pfn_to_phys(entry->pfn) + entry->offset;
-
-	return page_to_phys(pfn_to_page(entry->pfn)) + entry->offset;
-}
-
 /*
  * For each mapping (initial cacheline in the case of
  * dma_alloc_coherent/dma_map_page, initial cacheline in each page of a
@@ -428,8 +420,8 @@ static DEFINE_SPINLOCK(radix_lock);
 
 static phys_addr_t to_cacheline_number(struct dma_debug_entry *entry)
 {
-	return (entry->pfn << CACHELINE_PER_PAGE_SHIFT) +
-		(entry->offset >> L1_CACHE_SHIFT);
+	return ((entry->paddr >> PAGE_SHIFT) << CACHELINE_PER_PAGE_SHIFT) +
+		(offset_in_page(entry->paddr) >> L1_CACHE_SHIFT);
 }
 
 static int active_cacheline_read_overlap(phys_addr_t cln)
@@ -538,11 +530,11 @@ void debug_dma_dump_mappings(struct device *dev)
 			if (!dev || dev == entry->dev) {
 				cln = to_cacheline_number(entry);
 				dev_info(entry->dev,
-					 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
+					 "%s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s\n",
 					 type2name[entry->type], idx,
-					 phys_addr(entry), entry->pfn,
-					 entry->dev_addr, entry->size,
-					 &cln, dir2name[entry->direction],
+					 &entry->paddr, entry->dev_addr,
+					 entry->size, &cln,
+					 dir2name[entry->direction],
 					 maperr2str[entry->map_err_type]);
 			}
 		}
@@ -569,13 +561,13 @@ static int dump_show(struct seq_file *seq, void *v)
 		list_for_each_entry(entry, &bucket->list, list) {
 			cln = to_cacheline_number(entry);
 			seq_printf(seq,
-				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
+				   "%s %s %s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s\n",
 				   dev_driver_string(entry->dev),
 				   dev_name(entry->dev),
 				   type2name[entry->type], idx,
-				   phys_addr(entry), entry->pfn,
-				   entry->dev_addr, entry->size,
-				   &cln, dir2name[entry->direction],
+				   &entry->paddr, entry->dev_addr,
+				   entry->size, &cln,
+				   dir2name[entry->direction],
 				   maperr2str[entry->map_err_type]);
 		}
 		spin_unlock_irqrestore(&bucket->lock, flags);
@@ -1003,16 +995,17 @@ static void check_unmap(struct dma_debug_entry *ref)
 			   "[mapped as %s] [unmapped as %s]\n",
 			   ref->dev_addr, ref->size,
 			   type2name[entry->type], type2name[ref->type]);
-	} else if ((entry->type == dma_debug_coherent) &&
-		   (phys_addr(ref) != phys_addr(entry))) {
+	} else if ((entry->type == dma_debug_coherent ||
+		    entry->type == dma_debug_noncoherent) &&
+		   ref->paddr != entry->paddr) {
 		err_printk(ref->dev, entry, "device driver frees "
 			   "DMA memory with different CPU address "
 			   "[device address=0x%016llx] [size=%llu bytes] "
-			   "[cpu alloc address=0x%016llx] "
-			   "[cpu free address=0x%016llx]",
+			   "[cpu alloc address=0x%pa] "
+			   "[cpu free address=0x%pa]",
 			   ref->dev_addr, ref->size,
-			   phys_addr(entry),
-			   phys_addr(ref));
+			   &entry->paddr,
+			   &ref->paddr);
 	}
 
 	if (ref->sg_call_ents && ref->type == dma_debug_sg &&
@@ -1231,8 +1224,7 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 
 	entry->dev       = dev;
 	entry->type      = dma_debug_single;
-	entry->pfn	 = page_to_pfn(page);
-	entry->offset	 = offset;
+	entry->paddr	 = page_to_phys(page) + offset;
 	entry->dev_addr  = dma_addr;
 	entry->size      = size;
 	entry->direction = direction;
@@ -1327,8 +1319,7 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 
 		entry->type           = dma_debug_sg;
 		entry->dev            = dev;
-		entry->pfn	      = page_to_pfn(sg_page(s));
-		entry->offset	      = s->offset;
+		entry->paddr	      = sg_phys(s);
 		entry->size           = sg_dma_len(s);
 		entry->dev_addr       = sg_dma_address(s);
 		entry->direction      = direction;
@@ -1374,8 +1365,7 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.pfn		= page_to_pfn(sg_page(s)),
-			.offset		= s->offset,
+			.paddr		= sg_phys(s),
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
 			.direction      = dir,
@@ -1392,6 +1382,18 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	}
 }
 
+static phys_addr_t virt_to_paddr(void *virt)
+{
+	struct page *page;
+
+	if (is_vmalloc_addr(virt))
+		page = vmalloc_to_page(virt);
+	else
+		page = virt_to_page(virt);
+
+	return page_to_phys(page) + offset_in_page(virt);
+}
+
 void debug_dma_alloc_coherent(struct device *dev, size_t size,
 			      dma_addr_t dma_addr, void *virt,
 			      unsigned long attrs)
@@ -1414,16 +1416,11 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 
 	entry->type      = dma_debug_coherent;
 	entry->dev       = dev;
-	entry->offset	 = offset_in_page(virt);
+	entry->paddr	 = virt_to_paddr(virt);
 	entry->size      = size;
 	entry->dev_addr  = dma_addr;
 	entry->direction = DMA_BIDIRECTIONAL;
 
-	if (is_vmalloc_addr(virt))
-		entry->pfn = vmalloc_to_pfn(virt);
-	else
-		entry->pfn = page_to_pfn(virt_to_page(virt));
-
 	add_dma_entry(entry, attrs);
 }
 
@@ -1433,7 +1430,6 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 	struct dma_debug_entry ref = {
 		.type           = dma_debug_coherent,
 		.dev            = dev,
-		.offset		= offset_in_page(virt),
 		.dev_addr       = dma_addr,
 		.size           = size,
 		.direction      = DMA_BIDIRECTIONAL,
@@ -1443,10 +1439,7 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
 		return;
 
-	if (is_vmalloc_addr(virt))
-		ref.pfn = vmalloc_to_pfn(virt);
-	else
-		ref.pfn = page_to_pfn(virt_to_page(virt));
+	ref.paddr = virt_to_paddr(virt);
 
 	if (unlikely(dma_debug_disabled()))
 		return;
@@ -1469,8 +1462,7 @@ void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
 
 	entry->type		= dma_debug_resource;
 	entry->dev		= dev;
-	entry->pfn		= PHYS_PFN(addr);
-	entry->offset		= offset_in_page(addr);
+	entry->paddr		= addr;
 	entry->size		= size;
 	entry->dev_addr		= dma_addr;
 	entry->direction	= direction;
@@ -1547,8 +1539,7 @@ void debug_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.pfn		= page_to_pfn(sg_page(s)),
-			.offset		= s->offset,
+			.paddr		= sg_phys(s),
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
 			.direction      = direction,
@@ -1579,8 +1570,7 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.pfn		= page_to_pfn(sg_page(s)),
-			.offset		= s->offset,
+			.paddr		= sg_phys(sg),
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
 			.direction      = direction,
@@ -1596,6 +1586,49 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	}
 }
 
+void debug_dma_alloc_pages(struct device *dev, struct page *page,
+			   size_t size, int direction,
+			   dma_addr_t dma_addr,
+			   unsigned long attrs)
+{
+	struct dma_debug_entry *entry;
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	entry = dma_entry_alloc();
+	if (!entry)
+		return;
+
+	entry->type      = dma_debug_noncoherent;
+	entry->dev       = dev;
+	entry->paddr	 = page_to_phys(page);
+	entry->size      = size;
+	entry->dev_addr  = dma_addr;
+	entry->direction = direction;
+
+	add_dma_entry(entry, attrs);
+}
+
+void debug_dma_free_pages(struct device *dev, struct page *page,
+			  size_t size, int direction,
+			  dma_addr_t dma_addr)
+{
+	struct dma_debug_entry ref = {
+		.type           = dma_debug_noncoherent,
+		.dev            = dev,
+		.paddr		= page_to_phys(page),
+		.dev_addr       = dma_addr,
+		.size           = size,
+		.direction      = direction,
+	};
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	check_unmap(&ref);
+}
+
 static int __init dma_debug_driver_setup(char *str)
 {
 	int i;
diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
index f525197d3cae..48757ca13f31 100644
--- a/kernel/dma/debug.h
+++ b/kernel/dma/debug.h
@@ -54,6 +54,13 @@ extern void debug_dma_sync_sg_for_cpu(struct device *dev,
 extern void debug_dma_sync_sg_for_device(struct device *dev,
 					 struct scatterlist *sg,
 					 int nelems, int direction);
+extern void debug_dma_alloc_pages(struct device *dev, struct page *page,
+				  size_t size, int direction,
+				  dma_addr_t dma_addr,
+				  unsigned long attrs);
+extern void debug_dma_free_pages(struct device *dev, struct page *page,
+				 size_t size, int direction,
+				 dma_addr_t dma_addr);
 #else /* CONFIG_DMA_API_DEBUG */
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
@@ -126,5 +133,18 @@ static inline void debug_dma_sync_sg_for_device(struct device *dev,
 						int nelems, int direction)
 {
 }
+
+static inline void debug_dma_alloc_pages(struct device *dev, struct page *page,
+					 size_t size, int direction,
+					 dma_addr_t dma_addr,
+					 unsigned long attrs)
+{
+}
+
+static inline void debug_dma_free_pages(struct device *dev, struct page *page,
+					size_t size, int direction,
+					dma_addr_t dma_addr)
+{
+}
 #endif /* CONFIG_DMA_API_DEBUG */
 #endif /* _KERNEL_DMA_DEBUG_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 74d453ec750a..c7cc4e33ec6e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -223,6 +223,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
 	} else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
 				ents != -EIO && ents != -EREMOTEIO)) {
+		trace_dma_map_sg_err(dev, sg, nents, ents, dir, attrs);
 		return -EIO;
 	}
 
@@ -604,22 +605,29 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	if (WARN_ON_ONCE(flag & __GFP_COMP))
 		return NULL;
 
-	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
+	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr)) {
+		trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
+				DMA_BIDIRECTIONAL, flag, attrs);
 		return cpu_addr;
+	}
 
 	/* let the implementation decide on the zone to allocate from: */
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
-	if (dma_alloc_direct(dev, ops))
+	if (dma_alloc_direct(dev, ops)) {
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
-	else if (use_dma_iommu(dev))
+	} else if (use_dma_iommu(dev)) {
 		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
-	else if (ops->alloc)
+	} else if (ops->alloc) {
 		cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
-	else
+	} else {
+		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
+				attrs);
 		return NULL;
+	}
 
-	trace_dma_alloc(dev, cpu_addr, *dma_handle, size, flag, attrs);
+	trace_dma_alloc(dev, cpu_addr, *dma_handle, size, DMA_BIDIRECTIONAL,
+			flag, attrs);
 	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
 	return cpu_addr;
 }
@@ -641,10 +649,11 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	 */
 	WARN_ON(irqs_disabled());
 
+	trace_dma_free(dev, cpu_addr, dma_handle, size, DMA_BIDIRECTIONAL,
+		       attrs);
 	if (!cpu_addr)
 		return;
 
-	trace_dma_free(dev, cpu_addr, dma_handle, size, attrs);
 	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
 	if (dma_alloc_direct(dev, ops))
 		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
@@ -683,9 +692,11 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 	struct page *page = __dma_alloc_pages(dev, size, dma_handle, dir, gfp);
 
 	if (page) {
-		trace_dma_map_page(dev, page_to_phys(page), *dma_handle, size,
-				   dir, 0);
-		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle, 0);
+		trace_dma_alloc_pages(dev, page_to_virt(page), *dma_handle,
+				      size, dir, gfp, 0);
+		debug_dma_alloc_pages(dev, page, size, dir, *dma_handle, 0);
+	} else {
+		trace_dma_alloc_pages(dev, NULL, 0, size, dir, gfp, 0);
 	}
 	return page;
 }
@@ -708,8 +719,8 @@ static void __dma_free_pages(struct device *dev, size_t size, struct page *page,
 void dma_free_pages(struct device *dev, size_t size, struct page *page,
 		dma_addr_t dma_handle, enum dma_data_direction dir)
 {
-	trace_dma_unmap_page(dev, dma_handle, size, dir, 0);
-	debug_dma_unmap_page(dev, dma_handle, size, dir);
+	trace_dma_free_pages(dev, page_to_virt(page), dma_handle, size, dir, 0);
+	debug_dma_free_pages(dev, page, size, dir, dma_handle);
 	__dma_free_pages(dev, size, page, dma_handle, dir);
 }
 EXPORT_SYMBOL_GPL(dma_free_pages);
@@ -768,8 +779,10 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 
 	if (sgt) {
 		sgt->nents = 1;
-		trace_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
+		trace_dma_alloc_sgt(dev, sgt, size, dir, gfp, attrs);
 		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
+	} else {
+		trace_dma_alloc_sgt_err(dev, NULL, 0, size, dir, gfp, attrs);
 	}
 	return sgt;
 }
@@ -787,7 +800,7 @@ static void free_single_sgt(struct device *dev, size_t size,
 void dma_free_noncontiguous(struct device *dev, size_t size,
 		struct sg_table *sgt, enum dma_data_direction dir)
 {
-	trace_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir, 0);
+	trace_dma_free_sgt(dev, sgt, size, dir);
 	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
 
 	if (use_dma_iommu(dev))
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 06fbc226341f..cd9cb7ccb540 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -798,10 +798,10 @@ static void retrigger_next_event(void *arg)
 	 * of the next expiring timer is enough. The return from the SMP
 	 * function call will take care of the reprogramming in case the
 	 * CPU was in a NOHZ idle sleep.
+	 *
+	 * In periodic low resolution mode, the next softirq expiration
+	 * must also be updated.
 	 */
-	if (!hrtimer_hres_active(base) && !tick_nohz_active)
-		return;
-
 	raw_spin_lock(&base->lock);
 	hrtimer_update_base(base);
 	if (hrtimer_hres_active(base))
@@ -2286,11 +2286,6 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 				     &new_base->clock_base[i]);
 	}
 
-	/*
-	 * The migration might have changed the first expiring softirq
-	 * timer on this CPU. Update it.
-	 */
-	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
 	/* Tell the other CPU to retrigger the next event */
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 2eed8bc672f9..988a4c4ba97b 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1316,7 +1316,8 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
-		unregister_pm_notifier(&ftrace_suspend_notifier);
+		if (!ftrace_graph_active)
+			unregister_pm_notifier(&ftrace_suspend_notifier);
 	}
 	return ret;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ba3358eef34b..91e6bf1b101a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -787,7 +787,10 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		/* copy the current bits to the new max */
 		ret = trace_pid_list_first(filtered_pids, &pid);
 		while (!ret) {
-			trace_pid_list_set(pid_list, pid);
+			ret = trace_pid_list_set(pid_list, pid);
+			if (ret < 0)
+				goto out;
+
 			ret = trace_pid_list_next(filtered_pids, pid + 1, &pid);
 			nr_pids++;
 		}
@@ -824,6 +827,7 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		trace_parser_clear(&parser);
 		ret = 0;
 	}
+ out:
 	trace_parser_put(&parser);
 
 	if (ret < 0) {
@@ -6949,7 +6953,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	entry = ring_buffer_event_data(event);
 	entry->ip = _THIS_IP_;
 
-	len = __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
+	len = copy_from_user_nofault(&entry->buf, ubuf, cnt);
 	if (len) {
 		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
 		cnt = FAULTED_SIZE;
@@ -7020,7 +7024,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 
 	entry = ring_buffer_event_data(event);
 
-	len = __copy_from_user_inatomic(&entry->id, ubuf, cnt);
+	len = copy_from_user_nofault(&entry->id, ubuf, cnt);
 	if (len) {
 		entry->id = -1;
 		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
diff --git a/mm/Kconfig b/mm/Kconfig
index 33fa51d608dc..59c36bb9ce6b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -244,7 +244,7 @@ config SLUB
 
 config SLUB_TINY
 	bool "Configure for minimal memory footprint"
-	depends on EXPERT
+	depends on EXPERT && !COMPILE_TEST
 	select SLAB_MERGE_DEFAULT
 	help
 	   Configures the slab allocator in a way to achieve minimal memory
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9689f5425238..ed2b75023181 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1596,6 +1596,10 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
 		return;
 
+	/* First charge window */
+	if (!quota->total_charged_sz && !quota->charged_from)
+		quota->charged_from = jiffies;
+
 	/* New charge window starts */
 	if (time_after_eq(jiffies, quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 4af8fd4a390b..c2b4f0b07147 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -198,6 +198,11 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		return err;
 
+	if (!damon_lru_sort_mon_attrs.sample_interval) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
 	if (err)
 		goto out;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 9e0077a9404e..65842e6854fd 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -194,6 +194,11 @@ static int damon_reclaim_apply_parameters(void)
 	if (err)
 		return err;
 
+	if (!damon_reclaim_mon_attrs.aggr_interval) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
 	if (err)
 		goto out;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 58145d59881d..9ce2abc64de4 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1067,14 +1067,18 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
-	struct damon_ctx *ctx = kdamond->damon_ctx;
-	bool running;
+	struct damon_ctx *ctx;
+	bool running = false;
 
-	if (!ctx)
-		running = false;
-	else
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+
+	ctx = kdamond->damon_ctx;
+	if (ctx)
 		running = damon_sysfs_ctx_running(ctx);
 
+	mutex_unlock(&damon_sysfs_lock);
+
 	return sysfs_emit(buf, "%s\n", running ?
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_OFF]);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9c6a4e855481..f116af53a939 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5512,7 +5512,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	struct page *page;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
-	bool adjust_reservation = false;
+	bool adjust_reservation;
 	unsigned long last_addr_mask;
 	bool force_flush = false;
 
@@ -5604,6 +5604,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 					sz);
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		hugetlb_remove_rmap(page_folio(page));
+		spin_unlock(ptl);
 
 		/*
 		 * Restore the reservation for anonymous page, otherwise the
@@ -5611,14 +5612,16 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * If there we are freeing a surplus, do not set the restore
 		 * reservation bit.
 		 */
+		adjust_reservation = false;
+
+		spin_lock_irq(&hugetlb_lock);
 		if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
 		    folio_test_anon(page_folio(page))) {
 			folio_set_hugetlb_restore_reserve(page_folio(page));
 			/* Reservation to be adjusted after the spin lock */
 			adjust_reservation = true;
 		}
-
-		spin_unlock(ptl);
+		spin_unlock_irq(&hugetlb_lock);
 
 		/*
 		 * Adjust the reservation for the region that will have the
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ac607c306292..d1810e624cfc 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -13,9 +13,9 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/slab.h>
+#include <linux/pgalloc.h>
 
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 
 #include "kasan.h"
 
@@ -203,7 +203,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -224,7 +224,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			} else {
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				pud_init(p);
-				p4d_populate(&init_mm, p4d, p);
+				p4d_populate_kernel(addr, p4d, p);
 			}
 		}
 		zero_pud_populate(p4d, addr, next);
@@ -263,10 +263,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			 * puds,pmds, so pgd_populate(), pud_populate()
 			 * is noops.
 			 */
-			pgd_populate(&init_mm, pgd,
+			pgd_populate_kernel(addr, pgd,
 					lm_alias(kasan_early_shadow_p4d));
 			p4d = p4d_offset(pgd, addr);
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -285,7 +285,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index d4ac26ad1d3e..ed41987a34cc 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1500,6 +1500,7 @@ static void kasan_memchr(struct kunit *test)
 
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);
 
 	OPTIMIZER_HIDE_VAR(ptr);
 	OPTIMIZER_HIDE_VAR(size);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index abd5764e4864..a97b20617869 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1403,8 +1403,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 */
 		if (cc->is_khugepaged &&
 		    (pte_young(pteval) || folio_test_young(folio) ||
-		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
-								     address)))
+		     folio_test_referenced(folio) ||
+		     mmu_notifier_test_young(vma->vm_mm, _address)))
 			referenced++;
 	}
 	if (!writable) {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8c8d78d6d306..a51122a220fc 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -948,7 +948,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
-	[MF_MSG_ALREADY_POISONED]	= "already poisoned",
+	[MF_MSG_ALREADY_POISONED]	= "already poisoned page",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1341,9 +1341,10 @@ static int action_result(unsigned long pfn, enum mf_action_page_type type,
 {
 	trace_memory_failure_event(pfn, type, result);
 
-	num_poisoned_pages_inc(pfn);
-
-	update_per_node_mf_stats(pfn, result);
+	if (type != MF_MSG_ALREADY_POISONED) {
+		num_poisoned_pages_inc(pfn);
+		update_per_node_mf_stats(pfn, result);
+	}
 
 	pr_err("%#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
@@ -2086,12 +2087,11 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		*hugetlb = 0;
 		return 0;
 	} else if (res == -EHWPOISON) {
-		pr_err("%#lx: already hardware poisoned\n", pfn);
 		if (flags & MF_ACTION_REQUIRED) {
 			folio = page_folio(p);
 			res = kill_accessing_process(current, folio_pfn(folio), flags);
-			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		}
+		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
 		return res;
 	} else if (res == -EBUSY) {
 		if (!(flags & MF_NO_RETRY)) {
@@ -2273,7 +2273,6 @@ int memory_failure(unsigned long pfn, int flags)
 		goto unlock_mutex;
 
 	if (TestSetPageHWPoison(p)) {
-		pr_err("%#lx: already hardware poisoned\n", pfn);
 		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED)
 			res = kill_accessing_process(current, pfn, flags);
@@ -2570,10 +2569,9 @@ int unpoison_memory(unsigned long pfn)
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
-	if (!pfn_valid(pfn))
-		return -ENXIO;
-
-	p = pfn_to_page(pfn);
+	p = pfn_to_online_page(pfn);
+	if (!p)
+		return -EIO;
 	folio = page_folio(p);
 
 	mutex_lock(&mf_mutex);
diff --git a/mm/percpu.c b/mm/percpu.c
index da21680ff294..fb0307723da6 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3129,7 +3129,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 #endif /* BUILD_EMBED_FIRST_CHUNK */
 
 #ifdef BUILD_PAGE_FIRST_CHUNK
-#include <asm/pgalloc.h>
+#include <linux/pgalloc.h>
 
 #ifndef P4D_TABLE_SIZE
 #define P4D_TABLE_SIZE PAGE_SIZE
@@ -3157,7 +3157,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 		p4d = memblock_alloc(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
 		if (!p4d)
 			goto err_alloc;
-		pgd_populate(&init_mm, pgd, p4d);
+		pgd_populate_kernel(addr, pgd, p4d);
 	}
 
 	p4d = p4d_offset(pgd, addr);
@@ -3165,7 +3165,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 		pud = memblock_alloc(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
 		if (!pud)
 			goto err_alloc;
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_kernel(addr, p4d, pud);
 	}
 
 	pud = pud_offset(p4d, addr);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 2628fc02be08..c3353cd442a5 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -27,9 +27,9 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
+#include <linux/pgalloc.h>
 
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 
 /*
  * Allocate a block of memory to be used to back the virtual memory map
@@ -230,7 +230,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		if (!p)
 			return NULL;
 		pud_init(p);
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -242,7 +242,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 	return pgd;
 }
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 2cab878e0a39..ed08717541fe 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -312,6 +312,13 @@ int br_boolopt_multi_toggle(struct net_bridge *br,
 	int err = 0;
 	int opt_id;
 
+	opt_id = find_next_bit(&bitmap, BITS_PER_LONG, BR_BOOLOPT_MAX);
+	if (opt_id != BITS_PER_LONG) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Unknown boolean option %d",
+				       opt_id);
+		return -EINVAL;
+	}
+
 	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
 		bool on = !!(bm->optval & BIT(opt_id));
 
diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 486687901602..e0b966c2517c 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -290,8 +290,11 @@ int j1939_local_ecu_get(struct j1939_priv *priv, name_t name, u8 sa)
 	if (!ecu)
 		ecu = j1939_ecu_create_locked(priv, name);
 	err = PTR_ERR_OR_ZERO(ecu);
-	if (err)
+	if (err) {
+		if (j1939_address_is_unicast(sa))
+			priv->ents[sa].nusers--;
 		goto done;
+	}
 
 	ecu->nusers++;
 	/* TODO: do we care if ecu->addr != sa? */
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 17226b2341d0..75c2b9b23390 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -520,6 +520,9 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	ret = j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
 	if (ret) {
 		j1939_netdev_stop(priv);
+		jsk->priv = NULL;
+		synchronize_rcu();
+		j1939_priv_put(priv);
 		goto out_release_sock;
 	}
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d1b5705dc0c6..9f6d860411cb 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1524,7 +1524,7 @@ static void con_fault_finish(struct ceph_connection *con)
 	 * in case we faulted due to authentication, invalidate our
 	 * current tickets so that we can get new ones.
 	 */
-	if (con->v1.auth_retry) {
+	if (!ceph_msgr2(from_msgr(con->msgr)) && con->v1.auth_retry) {
 		dout("auth_retry %d, invalidating\n", con->v1.auth_retry);
 		if (con->ops->invalidate_authorizer)
 			con->ops->invalidate_authorizer(con);
@@ -1714,9 +1714,10 @@ static void clear_standby(struct ceph_connection *con)
 {
 	/* come back from STANDBY? */
 	if (con->state == CEPH_CON_S_STANDBY) {
-		dout("clear_standby %p and ++connect_seq\n", con);
+		dout("clear_standby %p\n", con);
 		con->state = CEPH_CON_S_PREOPEN;
-		con->v1.connect_seq++;
+		if (!ceph_msgr2(from_msgr(con->msgr)))
+			con->v1.connect_seq++;
 		WARN_ON(ceph_con_flag_test(con, CEPH_CON_F_WRITE_PENDING));
 		WARN_ON(ceph_con_flag_test(con, CEPH_CON_F_KEEPALIVE_PENDING));
 	}
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 9d0754b3642f..d2ae9fbed9e3 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -49,7 +49,7 @@ static bool hsr_check_carrier(struct hsr_port *master)
 
 	ASSERT_RTNL();
 
-	hsr_for_each_port(master->hsr, port) {
+	hsr_for_each_port_rtnl(master->hsr, port) {
 		if (port->type != HSR_PT_MASTER && is_slave_up(port->dev)) {
 			netif_carrier_on(master->dev);
 			return true;
@@ -105,7 +105,7 @@ int hsr_get_max_mtu(struct hsr_priv *hsr)
 	struct hsr_port *port;
 
 	mtu_max = ETH_DATA_LEN;
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		if (port->type != HSR_PT_MASTER)
 			mtu_max = min(port->dev->mtu, mtu_max);
 
@@ -139,7 +139,7 @@ static int hsr_dev_open(struct net_device *dev)
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -172,7 +172,7 @@ static int hsr_dev_close(struct net_device *dev)
 	struct hsr_priv *hsr;
 
 	hsr = netdev_priv(dev);
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -205,7 +205,7 @@ static netdev_features_t hsr_features_recompute(struct hsr_priv *hsr,
 	 * may become enabled.
 	 */
 	features &= ~NETIF_F_ONE_FOR_ALL;
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		features = netdev_increment_features(features,
 						     port->dev->features,
 						     mask);
@@ -226,6 +226,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct hsr_priv *hsr = netdev_priv(dev);
 	struct hsr_port *master;
 
+	rcu_read_lock();
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	if (master) {
 		skb->dev = master->dev;
@@ -238,6 +239,8 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		dev_core_stats_tx_dropped_inc(dev);
 		dev_kfree_skb_any(skb);
 	}
+	rcu_read_unlock();
+
 	return NETDEV_TX_OK;
 }
 
@@ -483,7 +486,7 @@ static void hsr_set_rx_mode(struct net_device *dev)
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -505,7 +508,7 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -522,6 +525,77 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
 	}
 }
 
+static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
+				   __be16 proto, u16 vid)
+{
+	bool is_slave_a_added = false;
+	bool is_slave_b_added = false;
+	struct hsr_port *port;
+	struct hsr_priv *hsr;
+	int ret = 0;
+
+	hsr = netdev_priv(dev);
+
+	hsr_for_each_port_rtnl(hsr, port) {
+		if (port->type == HSR_PT_MASTER ||
+		    port->type == HSR_PT_INTERLINK)
+			continue;
+
+		ret = vlan_vid_add(port->dev, proto, vid);
+		switch (port->type) {
+		case HSR_PT_SLAVE_A:
+			if (ret) {
+				/* clean up Slave-B */
+				netdev_err(dev, "add vid failed for Slave-A\n");
+				if (is_slave_b_added)
+					vlan_vid_del(port->dev, proto, vid);
+				return ret;
+			}
+
+			is_slave_a_added = true;
+			break;
+
+		case HSR_PT_SLAVE_B:
+			if (ret) {
+				/* clean up Slave-A */
+				netdev_err(dev, "add vid failed for Slave-B\n");
+				if (is_slave_a_added)
+					vlan_vid_del(port->dev, proto, vid);
+				return ret;
+			}
+
+			is_slave_b_added = true;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int hsr_ndo_vlan_rx_kill_vid(struct net_device *dev,
+				    __be16 proto, u16 vid)
+{
+	struct hsr_port *port;
+	struct hsr_priv *hsr;
+
+	hsr = netdev_priv(dev);
+
+	hsr_for_each_port_rtnl(hsr, port) {
+		switch (port->type) {
+		case HSR_PT_SLAVE_A:
+		case HSR_PT_SLAVE_B:
+			vlan_vid_del(port->dev, proto, vid);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops hsr_device_ops = {
 	.ndo_change_mtu = hsr_dev_change_mtu,
 	.ndo_open = hsr_dev_open,
@@ -530,6 +604,8 @@ static const struct net_device_ops hsr_device_ops = {
 	.ndo_change_rx_flags = hsr_change_rx_flags,
 	.ndo_fix_features = hsr_fix_features,
 	.ndo_set_rx_mode = hsr_set_rx_mode,
+	.ndo_vlan_rx_add_vid = hsr_ndo_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = hsr_ndo_vlan_rx_kill_vid,
 };
 
 static const struct device_type hsr_type = {
@@ -578,7 +654,8 @@ void hsr_dev_setup(struct net_device *dev)
 
 	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
 			   NETIF_F_GSO_MASK | NETIF_F_HW_CSUM |
-			   NETIF_F_HW_VLAN_CTAG_TX;
+			   NETIF_F_HW_VLAN_CTAG_TX |
+			   NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	dev->features = dev->hw_features;
 
@@ -661,6 +738,10 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	    (slave[1]->features & NETIF_F_HW_HSR_FWD))
 		hsr->fwd_offloaded = true;
 
+	if ((slave[0]->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+	    (slave[1]->features & NETIF_F_HW_VLAN_CTAG_FILTER))
+		hsr_dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
 	res = register_netdevice(hsr_dev);
 	if (res)
 		goto err_unregister;
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index d7ae32473c41..9e4ce1ccc022 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -22,7 +22,7 @@ static bool hsr_slave_empty(struct hsr_priv *hsr)
 {
 	struct hsr_port *port;
 
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		if (port->type != HSR_PT_MASTER)
 			return false;
 	return true;
@@ -125,7 +125,7 @@ struct hsr_port *hsr_port_get_hsr(struct hsr_priv *hsr, enum hsr_port_type pt)
 {
 	struct hsr_port *port;
 
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		if (port->type == pt)
 			return port;
 	return NULL;
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index e26244456f63..f066c9c401c6 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -231,6 +231,9 @@ struct hsr_priv {
 #define hsr_for_each_port(hsr, port) \
 	list_for_each_entry_rcu((port), &(hsr)->ports, port_list)
 
+#define hsr_for_each_port_rtnl(hsr, port) \
+	list_for_each_entry_rcu((port), &(hsr)->ports, port_list, lockdep_rtnl_is_held())
+
 struct hsr_port *hsr_port_get_hsr(struct hsr_priv *hsr, enum hsr_port_type pt);
 
 /* Caller must ensure skb is a valid HSR frame */
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index f65d2f727381..8392d304a72e 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -204,6 +204,9 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 	if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct iphdr)))
 		return -EINVAL;
 
+	if (skb_is_gso(skb))
+		skb_gso_reset(skb);
+
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
 	skb_reset_network_header(skb);
@@ -298,6 +301,9 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct ipv6hdr)))
 		return -EINVAL;
 
+	if (skb_is_gso(skb))
+		skb_gso_reset(skb);
+
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
 	skb_reset_network_header(skb);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 22e8a2af5dd8..8372ca512a75 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -408,8 +408,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		if (!psock->cork) {
 			psock->cork = kzalloc(sizeof(*psock->cork),
 					      GFP_ATOMIC | __GFP_NOWARN);
-			if (!psock->cork)
+			if (!psock->cork) {
+				sk_msg_free(sk, msg);
+				*copied = 0;
 				return -ENOMEM;
+			}
 		}
 		memcpy(psock->cork, msg, sizeof(*msg));
 		return 0;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 3caa0a9d3b38..25d2b65653cd 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1508,13 +1508,12 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	bool keep_open;
 
-	if (ssk->sk_prot->keepalive) {
-		if (sock_flag(sk, SOCK_KEEPOPEN))
-			ssk->sk_prot->keepalive(ssk, 1);
-		else
-			ssk->sk_prot->keepalive(ssk, 0);
-	}
+	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
+	if (ssk->sk_prot->keepalive)
+		ssk->sk_prot->keepalive(ssk, keep_open);
+	sock_valbool_flag(ssk, SOCK_KEEPOPEN, keep_open);
 
 	ssk->sk_priority = sk->sk_priority;
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3743e4249dc8..3028d388b293 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -995,11 +995,14 @@ nf_tables_chain_type_lookup(struct net *net, const struct nlattr *nla,
 	return ERR_PTR(-ENOENT);
 }
 
-static __be16 nft_base_seq(const struct net *net)
+static unsigned int nft_base_seq(const struct net *net)
 {
-	struct nftables_pernet *nft_net = nft_pernet(net);
+	return READ_ONCE(net->nft.base_seq);
+}
 
-	return htons(nft_net->base_seq & 0xffff);
+static __be16 nft_base_seq_be16(const struct net *net)
+{
+	return htons(nft_base_seq(net) & 0xffff);
 }
 
 static const struct nla_policy nft_table_policy[NFTA_TABLE_MAX + 1] = {
@@ -1017,9 +1020,9 @@ static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
 {
 	struct nlmsghdr *nlh;
 
-	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+	nlh = nfnl_msg_put(skb, portid, seq,
+			   nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event),
+			   flags, family, NFNETLINK_V0, nft_base_seq_be16(net));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -1029,6 +1032,12 @@ static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
 			 NFTA_TABLE_PAD))
 		goto nla_put_failure;
 
+	if (event == NFT_MSG_DELTABLE ||
+	    event == NFT_MSG_DESTROYTABLE) {
+		nlmsg_end(skb, nlh);
+		return 0;
+	}
+
 	if (nla_put_be32(skb, NFTA_TABLE_FLAGS,
 			 htonl(table->flags & NFT_TABLE_F_MASK)))
 		goto nla_put_failure;
@@ -1106,7 +1115,7 @@ static int nf_tables_dump_tables(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -1872,9 +1881,9 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 {
 	struct nlmsghdr *nlh;
 
-	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+	nlh = nfnl_msg_put(skb, portid, seq,
+			   nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event),
+			   flags, family, NFNETLINK_V0, nft_base_seq_be16(net));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -1884,6 +1893,13 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 			 NFTA_CHAIN_PAD))
 		goto nla_put_failure;
 
+	if (!hook_list &&
+	    (event == NFT_MSG_DELCHAIN ||
+	     event == NFT_MSG_DESTROYCHAIN)) {
+		nlmsg_end(skb, nlh);
+		return 0;
+	}
+
 	if (nft_is_base_chain(chain)) {
 		const struct nft_base_chain *basechain = nft_base_chain(chain);
 		struct nft_stats __percpu *stats;
@@ -1970,7 +1986,7 @@ static int nf_tables_dump_chains(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -3467,7 +3483,7 @@ static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
 	u16 type = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 
 	nlh = nfnl_msg_put(skb, portid, seq, type, flags, family, NFNETLINK_V0,
-			   nft_base_seq(net));
+			   nft_base_seq_be16(net));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -3635,7 +3651,7 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -3846,7 +3862,7 @@ static int nf_tables_getrule_reset(struct sk_buff *skb,
 	buf = kasprintf(GFP_ATOMIC, "%.*s:%u",
 			nla_len(nla[NFTA_RULE_TABLE]),
 			(char *)nla_data(nla[NFTA_RULE_TABLE]),
-			nft_net->base_seq);
+			nft_base_seq(net));
 	audit_log_nfcfg(buf, info->nfmsg->nfgen_family, 1,
 			AUDIT_NFT_OP_RULE_RESET, GFP_ATOMIC);
 	kfree(buf);
@@ -4654,9 +4670,10 @@ static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 	u32 seq = ctx->seq;
 	int i;
 
-	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
-			   NFNETLINK_V0, nft_base_seq(ctx->net));
+	nlh = nfnl_msg_put(skb, portid, seq,
+			   nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event),
+			   flags, ctx->family, NFNETLINK_V0,
+			   nft_base_seq_be16(ctx->net));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -4668,6 +4685,12 @@ static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 			 NFTA_SET_PAD))
 		goto nla_put_failure;
 
+	if (event == NFT_MSG_DELSET ||
+	    event == NFT_MSG_DESTROYSET) {
+		nlmsg_end(skb, nlh);
+		return 0;
+	}
+
 	if (set->flags != 0)
 		if (nla_put_be32(skb, NFTA_SET_FLAGS, htonl(set->flags)))
 			goto nla_put_failure;
@@ -4792,7 +4815,7 @@ static int nf_tables_dump_sets(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (ctx->family != NFPROTO_UNSPEC &&
@@ -5968,7 +5991,7 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (dump_ctx->ctx.family != NFPROTO_UNSPEC &&
@@ -5997,7 +6020,7 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	seq    = cb->nlh->nlmsg_seq;
 
 	nlh = nfnl_msg_put(skb, portid, seq, event, NLM_F_MULTI,
-			   table->family, NFNETLINK_V0, nft_base_seq(net));
+			   table->family, NFNETLINK_V0, nft_base_seq_be16(net));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -6090,7 +6113,7 @@ static int nf_tables_fill_setelem_info(struct sk_buff *skb,
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
-			   NFNETLINK_V0, nft_base_seq(ctx->net));
+			   NFNETLINK_V0, nft_base_seq_be16(ctx->net));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -6389,7 +6412,7 @@ static int nf_tables_getsetelem_reset(struct sk_buff *skb,
 		}
 		nelems++;
 	}
-	audit_log_nft_set_reset(dump_ctx.ctx.table, nft_net->base_seq, nelems);
+	audit_log_nft_set_reset(dump_ctx.ctx.table, nft_base_seq(info->net), nelems);
 
 out_unlock:
 	rcu_read_unlock();
@@ -7990,20 +8013,26 @@ static int nf_tables_fill_obj_info(struct sk_buff *skb, struct net *net,
 {
 	struct nlmsghdr *nlh;
 
-	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+	nlh = nfnl_msg_put(skb, portid, seq,
+			   nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event),
+			   flags, family, NFNETLINK_V0, nft_base_seq_be16(net));
 	if (!nlh)
 		goto nla_put_failure;
 
 	if (nla_put_string(skb, NFTA_OBJ_TABLE, table->name) ||
 	    nla_put_string(skb, NFTA_OBJ_NAME, obj->key.name) ||
+	    nla_put_be32(skb, NFTA_OBJ_TYPE, htonl(obj->ops->type->type)) ||
 	    nla_put_be64(skb, NFTA_OBJ_HANDLE, cpu_to_be64(obj->handle),
 			 NFTA_OBJ_PAD))
 		goto nla_put_failure;
 
-	if (nla_put_be32(skb, NFTA_OBJ_TYPE, htonl(obj->ops->type->type)) ||
-	    nla_put_be32(skb, NFTA_OBJ_USE, htonl(obj->use)) ||
+	if (event == NFT_MSG_DELOBJ ||
+	    event == NFT_MSG_DESTROYOBJ) {
+		nlmsg_end(skb, nlh);
+		return 0;
+	}
+
+	if (nla_put_be32(skb, NFTA_OBJ_USE, htonl(obj->use)) ||
 	    nft_object_dump(skb, NFTA_OBJ_DATA, obj, reset))
 		goto nla_put_failure;
 
@@ -8051,7 +8080,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -8085,7 +8114,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 			idx++;
 		}
 		if (ctx->reset && entries)
-			audit_log_obj_reset(table, nft_net->base_seq, entries);
+			audit_log_obj_reset(table, nft_base_seq(net), entries);
 		if (rc < 0)
 			break;
 	}
@@ -8254,7 +8283,7 @@ static int nf_tables_getobj_reset(struct sk_buff *skb,
 	buf = kasprintf(GFP_ATOMIC, "%.*s:%u",
 			nla_len(nla[NFTA_OBJ_TABLE]),
 			(char *)nla_data(nla[NFTA_OBJ_TABLE]),
-			nft_net->base_seq);
+			nft_base_seq(net));
 	audit_log_nfcfg(buf, info->nfmsg->nfgen_family, 1,
 			AUDIT_NFT_OP_OBJ_RESET, GFP_ATOMIC);
 	kfree(buf);
@@ -8359,9 +8388,8 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 		    struct nft_object *obj, u32 portid, u32 seq, int event,
 		    u16 flags, int family, int report, gfp_t gfp)
 {
-	struct nftables_pernet *nft_net = nft_pernet(net);
 	char *buf = kasprintf(gfp, "%s:%u",
-			      table->name, nft_net->base_seq);
+			      table->name, nft_base_seq(net));
 
 	audit_log_nfcfg(buf,
 			family,
@@ -9008,9 +9036,9 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 	struct nft_hook *hook;
 	struct nlmsghdr *nlh;
 
-	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
-			   NFNETLINK_V0, nft_base_seq(net));
+	nlh = nfnl_msg_put(skb, portid, seq,
+			   nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event),
+			   flags, family, NFNETLINK_V0, nft_base_seq_be16(net));
 	if (!nlh)
 		goto nla_put_failure;
 
@@ -9020,6 +9048,13 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 			 NFTA_FLOWTABLE_PAD))
 		goto nla_put_failure;
 
+	if (!hook_list &&
+	    (event == NFT_MSG_DELFLOWTABLE ||
+	     event == NFT_MSG_DESTROYFLOWTABLE)) {
+		nlmsg_end(skb, nlh);
+		return 0;
+	}
+
 	if (nla_put_be32(skb, NFTA_FLOWTABLE_USE, htonl(flowtable->use)) ||
 	    nla_put_be32(skb, NFTA_FLOWTABLE_FLAGS, htonl(flowtable->data.flags)))
 		goto nla_put_failure;
@@ -9071,7 +9106,7 @@ static int nf_tables_dump_flowtable(struct sk_buff *skb,
 
 	rcu_read_lock();
 	nft_net = nft_pernet(net);
-	cb->seq = READ_ONCE(nft_net->base_seq);
+	cb->seq = nft_base_seq(net);
 
 	list_for_each_entry_rcu(table, &nft_net->tables, list) {
 		if (family != NFPROTO_UNSPEC && family != table->family)
@@ -9256,17 +9291,16 @@ static void nf_tables_flowtable_destroy(struct nft_flowtable *flowtable)
 static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 				   u32 portid, u32 seq)
 {
-	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct nlmsghdr *nlh;
 	char buf[TASK_COMM_LEN];
 	int event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, NFT_MSG_NEWGEN);
 
 	nlh = nfnl_msg_put(skb, portid, seq, event, 0, AF_UNSPEC,
-			   NFNETLINK_V0, nft_base_seq(net));
+			   NFNETLINK_V0, nft_base_seq_be16(net));
 	if (!nlh)
 		goto nla_put_failure;
 
-	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_net->base_seq)) ||
+	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_base_seq(net))) ||
 	    nla_put_be32(skb, NFTA_GEN_PROC_PID, htonl(task_pid_nr(current))) ||
 	    nla_put_string(skb, NFTA_GEN_PROC_NAME, get_task_comm(buf, current)))
 		goto nla_put_failure;
@@ -10429,11 +10463,12 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	 * Bump generation counter, invalidate any dump in progress.
 	 * Cannot fail after this point.
 	 */
-	base_seq = READ_ONCE(nft_net->base_seq);
+	base_seq = nft_base_seq(net);
 	while (++base_seq == 0)
 		;
 
-	WRITE_ONCE(nft_net->base_seq, base_seq);
+	/* pairs with smp_load_acquire in nft_lookup_eval */
+	smp_store_release(&net->nft.base_seq, base_seq);
 
 	gc_seq = nft_gc_seq_begin(nft_net);
 
@@ -10665,7 +10700,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 
 	nft_commit_notify(net, NETLINK_CB(skb).portid);
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
-	nf_tables_commit_audit_log(&adl, nft_net->base_seq);
+	nf_tables_commit_audit_log(&adl, nft_base_seq(net));
 
 	nft_gc_seq_end(nft_net, gc_seq);
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
@@ -10999,7 +11034,7 @@ static bool nf_tables_valid_genid(struct net *net, u32 genid)
 	mutex_lock(&nft_net->commit_mutex);
 	nft_net->tstamp = get_jiffies_64();
 
-	genid_ok = genid == 0 || nft_net->base_seq == genid;
+	genid_ok = genid == 0 || nft_base_seq(net) == genid;
 	if (!genid_ok)
 		mutex_unlock(&nft_net->commit_mutex);
 
@@ -11677,7 +11712,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 	INIT_LIST_HEAD(&nft_net->module_list);
 	INIT_LIST_HEAD(&nft_net->notify_list);
 	mutex_init(&nft_net->commit_mutex);
-	nft_net->base_seq = 1;
+	net->nft.base_seq = 1;
 	nft_net->gc_seq = 0;
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
 	INIT_WORK(&nft_net->destroy_work, nf_tables_trans_destroy_work);
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 88922e0e8e83..e24493d9e776 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -91,8 +91,9 @@ void nft_dynset_eval(const struct nft_expr *expr,
 		return;
 	}
 
-	if (set->ops->update(set, &regs->data[priv->sreg_key], nft_dynset_new,
-			     expr, regs, &ext)) {
+	ext = set->ops->update(set, &regs->data[priv->sreg_key], nft_dynset_new,
+			     expr, regs);
+	if (ext) {
 		if (priv->op == NFT_DYNSET_OP_UPDATE &&
 		    nft_set_ext_exists(ext, NFT_SET_EXT_TIMEOUT) &&
 		    READ_ONCE(nft_set_ext_timeout(ext)->timeout) != 0) {
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 63ef832b8aa7..58c5b14889c4 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -24,36 +24,73 @@ struct nft_lookup {
 	struct nft_set_binding		binding;
 };
 
-#ifdef CONFIG_MITIGATION_RETPOLINE
-bool nft_set_do_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext)
+static const struct nft_set_ext *
+__nft_set_do_lookup(const struct net *net, const struct nft_set *set,
+		    const u32 *key)
 {
+#ifdef CONFIG_MITIGATION_RETPOLINE
 	if (set->ops == &nft_set_hash_fast_type.ops)
-		return nft_hash_lookup_fast(net, set, key, ext);
+		return nft_hash_lookup_fast(net, set, key);
 	if (set->ops == &nft_set_hash_type.ops)
-		return nft_hash_lookup(net, set, key, ext);
+		return nft_hash_lookup(net, set, key);
 
 	if (set->ops == &nft_set_rhash_type.ops)
-		return nft_rhash_lookup(net, set, key, ext);
+		return nft_rhash_lookup(net, set, key);
 
 	if (set->ops == &nft_set_bitmap_type.ops)
-		return nft_bitmap_lookup(net, set, key, ext);
+		return nft_bitmap_lookup(net, set, key);
 
 	if (set->ops == &nft_set_pipapo_type.ops)
-		return nft_pipapo_lookup(net, set, key, ext);
+		return nft_pipapo_lookup(net, set, key);
 #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 	if (set->ops == &nft_set_pipapo_avx2_type.ops)
-		return nft_pipapo_avx2_lookup(net, set, key, ext);
+		return nft_pipapo_avx2_lookup(net, set, key);
 #endif
 
 	if (set->ops == &nft_set_rbtree_type.ops)
-		return nft_rbtree_lookup(net, set, key, ext);
+		return nft_rbtree_lookup(net, set, key);
 
 	WARN_ON_ONCE(1);
-	return set->ops->lookup(net, set, key, ext);
+#endif
+	return set->ops->lookup(net, set, key);
+}
+
+static unsigned int nft_base_seq(const struct net *net)
+{
+	/* pairs with smp_store_release() in nf_tables_commit() */
+	return smp_load_acquire(&net->nft.base_seq);
+}
+
+static bool nft_lookup_should_retry(const struct net *net, unsigned int seq)
+{
+	return unlikely(seq != nft_base_seq(net));
+}
+
+const struct nft_set_ext *
+nft_set_do_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key)
+{
+	const struct nft_set_ext *ext;
+	unsigned int base_seq;
+
+	do {
+		base_seq = nft_base_seq(net);
+
+		ext = __nft_set_do_lookup(net, set, key);
+		if (ext)
+			break;
+		/* No match?  There is a small chance that lookup was
+		 * performed in the old generation, but nf_tables_commit()
+		 * already unlinked a (matching) element.
+		 *
+		 * We need to repeat the lookup to make sure that we didn't
+		 * miss a matching element in the new generation.
+		 */
+	} while (nft_lookup_should_retry(net, base_seq));
+
+	return ext;
 }
 EXPORT_SYMBOL_GPL(nft_set_do_lookup);
-#endif
 
 void nft_lookup_eval(const struct nft_expr *expr,
 		     struct nft_regs *regs,
@@ -61,12 +98,12 @@ void nft_lookup_eval(const struct nft_expr *expr,
 {
 	const struct nft_lookup *priv = nft_expr_priv(expr);
 	const struct nft_set *set = priv->set;
-	const struct nft_set_ext *ext = NULL;
 	const struct net *net = nft_net(pkt);
+	const struct nft_set_ext *ext;
 	bool found;
 
-	found =	nft_set_do_lookup(net, set, &regs->data[priv->sreg], &ext) ^
-				  priv->invert;
+	ext = nft_set_do_lookup(net, set, &regs->data[priv->sreg]);
+	found = !!ext ^ priv->invert;
 	if (!found) {
 		ext = nft_set_catchall_lookup(net, set);
 		if (!ext) {
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 09da7a3f9f96..8ee66a86c3bc 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -111,10 +111,9 @@ void nft_objref_map_eval(const struct nft_expr *expr,
 	struct net *net = nft_net(pkt);
 	const struct nft_set_ext *ext;
 	struct nft_object *obj;
-	bool found;
 
-	found = nft_set_do_lookup(net, set, &regs->data[priv->sreg], &ext);
-	if (!found) {
+	ext = nft_set_do_lookup(net, set, &regs->data[priv->sreg]);
+	if (!ext) {
 		ext = nft_set_catchall_lookup(net, set);
 		if (!ext) {
 			regs->verdict.code = NFT_BREAK;
diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
index 1caa04619dc6..b4765fb92d72 100644
--- a/net/netfilter/nft_set_bitmap.c
+++ b/net/netfilter/nft_set_bitmap.c
@@ -75,16 +75,21 @@ nft_bitmap_active(const u8 *bitmap, u32 idx, u32 off, u8 genmask)
 }
 
 INDIRECT_CALLABLE_SCOPE
-bool nft_bitmap_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_bitmap_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key)
 {
 	const struct nft_bitmap *priv = nft_set_priv(set);
+	static const struct nft_set_ext found;
 	u8 genmask = nft_genmask_cur(net);
 	u32 idx, off;
 
 	nft_bitmap_location(set, key, &idx, &off);
 
-	return nft_bitmap_active(priv->bitmap, idx, off, genmask);
+	if (nft_bitmap_active(priv->bitmap, idx, off, genmask))
+		return &found;
+
+	return NULL;
 }
 
 static struct nft_bitmap_elem *
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 4b3452dff2ec..900eddb93dcc 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -81,8 +81,9 @@ static const struct rhashtable_params nft_rhash_params = {
 };
 
 INDIRECT_CALLABLE_SCOPE
-bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
-		      const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_rhash_lookup(const struct net *net, const struct nft_set *set,
+		 const u32 *key)
 {
 	struct nft_rhash *priv = nft_set_priv(set);
 	const struct nft_rhash_elem *he;
@@ -95,9 +96,9 @@ bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
 	if (he != NULL)
-		*ext = &he->ext;
+		return &he->ext;
 
-	return !!he;
+	return NULL;
 }
 
 static struct nft_elem_priv *
@@ -120,14 +121,11 @@ nft_rhash_get(const struct net *net, const struct nft_set *set,
 	return ERR_PTR(-ENOENT);
 }
 
-static bool nft_rhash_update(struct nft_set *set, const u32 *key,
-			     struct nft_elem_priv *
-				   (*new)(struct nft_set *,
-					  const struct nft_expr *,
-					  struct nft_regs *regs),
-			     const struct nft_expr *expr,
-			     struct nft_regs *regs,
-			     const struct nft_set_ext **ext)
+static const struct nft_set_ext *
+nft_rhash_update(struct nft_set *set, const u32 *key,
+		 struct nft_elem_priv *(*new)(struct nft_set *, const struct nft_expr *,
+		 struct nft_regs *regs),
+		 const struct nft_expr *expr, struct nft_regs *regs)
 {
 	struct nft_rhash *priv = nft_set_priv(set);
 	struct nft_rhash_elem *he, *prev;
@@ -161,14 +159,13 @@ static bool nft_rhash_update(struct nft_set *set, const u32 *key,
 	}
 
 out:
-	*ext = &he->ext;
-	return true;
+	return &he->ext;
 
 err2:
 	nft_set_elem_destroy(set, &he->priv, true);
 	atomic_dec(&set->nelems);
 err1:
-	return false;
+	return NULL;
 }
 
 static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
@@ -507,8 +504,9 @@ struct nft_hash_elem {
 };
 
 INDIRECT_CALLABLE_SCOPE
-bool nft_hash_lookup(const struct net *net, const struct nft_set *set,
-		     const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_hash_lookup(const struct net *net, const struct nft_set *set,
+		const u32 *key)
 {
 	struct nft_hash *priv = nft_set_priv(set);
 	u8 genmask = nft_genmask_cur(net);
@@ -519,12 +517,10 @@ bool nft_hash_lookup(const struct net *net, const struct nft_set *set,
 	hash = reciprocal_scale(hash, priv->buckets);
 	hlist_for_each_entry_rcu(he, &priv->table[hash], node) {
 		if (!memcmp(nft_set_ext_key(&he->ext), key, set->klen) &&
-		    nft_set_elem_active(&he->ext, genmask)) {
-			*ext = &he->ext;
-			return true;
-		}
+		    nft_set_elem_active(&he->ext, genmask))
+			return &he->ext;
 	}
-	return false;
+	return NULL;
 }
 
 static struct nft_elem_priv *
@@ -547,9 +543,9 @@ nft_hash_get(const struct net *net, const struct nft_set *set,
 }
 
 INDIRECT_CALLABLE_SCOPE
-bool nft_hash_lookup_fast(const struct net *net,
-			  const struct nft_set *set,
-			  const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_hash_lookup_fast(const struct net *net, const struct nft_set *set,
+		     const u32 *key)
 {
 	struct nft_hash *priv = nft_set_priv(set);
 	u8 genmask = nft_genmask_cur(net);
@@ -562,12 +558,10 @@ bool nft_hash_lookup_fast(const struct net *net,
 	hlist_for_each_entry_rcu(he, &priv->table[hash], node) {
 		k2 = *(u32 *)nft_set_ext_key(&he->ext)->data;
 		if (k1 == k2 &&
-		    nft_set_elem_active(&he->ext, genmask)) {
-			*ext = &he->ext;
-			return true;
-		}
+		    nft_set_elem_active(&he->ext, genmask))
+			return &he->ext;
 	}
-	return false;
+	return NULL;
 }
 
 static u32 nft_jhash(const struct nft_set *set, const struct nft_hash *priv,
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 9e4e25f2458f..793790d79d13 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -397,37 +397,38 @@ int pipapo_refill(unsigned long *map, unsigned int len, unsigned int rules,
 }
 
 /**
- * nft_pipapo_lookup() - Lookup function
- * @net:	Network namespace
- * @set:	nftables API set representation
- * @key:	nftables API element representation containing key data
- * @ext:	nftables API extension pointer, filled with matching reference
+ * pipapo_get() - Get matching element reference given key data
+ * @m:		storage containing the set elements
+ * @data:	Key data to be matched against existing elements
+ * @genmask:	If set, check that element is active in given genmask
+ * @tstamp:	timestamp to check for expired elements
  *
  * For more details, see DOC: Theory of Operation.
  *
- * Return: true on match, false otherwise.
+ * This is the main lookup function.  It matches key data against either
+ * the working match set or the uncommitted copy, depending on what the
+ * caller passed to us.
+ * nft_pipapo_get (lookup from userspace/control plane) and nft_pipapo_lookup
+ * (datapath lookup) pass the active copy.
+ * The insertion path will pass the uncommitted working copy.
+ *
+ * Return: pointer to &struct nft_pipapo_elem on match, NULL otherwise.
  */
-bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext)
+static struct nft_pipapo_elem *pipapo_get(const struct nft_pipapo_match *m,
+					  const u8 *data, u8 genmask,
+					  u64 tstamp)
 {
-	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_scratch *scratch;
 	unsigned long *res_map, *fill_map;
-	u8 genmask = nft_genmask_cur(net);
-	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
-	const u8 *rp = (const u8 *)key;
 	bool map_index;
 	int i;
 
 	local_bh_disable();
 
-	m = rcu_dereference(priv->match);
-
-	if (unlikely(!m || !*raw_cpu_ptr(m->scratch)))
-		goto out;
-
 	scratch = *raw_cpu_ptr(m->scratch);
+	if (unlikely(!scratch))
+		goto out;
 
 	map_index = scratch->map_index;
 
@@ -444,12 +445,12 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		 * packet bytes value, then AND bucket value
 		 */
 		if (likely(f->bb == 8))
-			pipapo_and_field_buckets_8bit(f, res_map, rp);
+			pipapo_and_field_buckets_8bit(f, res_map, data);
 		else
-			pipapo_and_field_buckets_4bit(f, res_map, rp);
+			pipapo_and_field_buckets_4bit(f, res_map, data);
 		NFT_PIPAPO_GROUP_BITS_ARE_8_OR_4;
 
-		rp += f->groups / NFT_PIPAPO_GROUPS_PER_BYTE(f);
+		data += f->groups / NFT_PIPAPO_GROUPS_PER_BYTE(f);
 
 		/* Now populate the bitmap for the next field, unless this is
 		 * the last field, in which case return the matched 'ext'
@@ -465,13 +466,15 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 			scratch->map_index = map_index;
 			local_bh_enable();
 
-			return false;
+			return NULL;
 		}
 
 		if (last) {
-			*ext = &f->mt[b].e->ext;
-			if (unlikely(nft_set_elem_expired(*ext) ||
-				     !nft_set_elem_active(*ext, genmask)))
+			struct nft_pipapo_elem *e;
+
+			e = f->mt[b].e;
+			if (unlikely(__nft_set_elem_expired(&e->ext, tstamp) ||
+				     !nft_set_elem_active(&e->ext, genmask)))
 				goto next_match;
 
 			/* Last field: we're just returning the key without
@@ -481,8 +484,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 			 */
 			scratch->map_index = map_index;
 			local_bh_enable();
-
-			return true;
+			return e;
 		}
 
 		/* Swap bitmap indices: res_map is the initial bitmap for the
@@ -492,112 +494,54 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		map_index = !map_index;
 		swap(res_map, fill_map);
 
-		rp += NFT_PIPAPO_GROUPS_PADDING(f);
+		data += NFT_PIPAPO_GROUPS_PADDING(f);
 	}
 
 out:
 	local_bh_enable();
-	return false;
+	return NULL;
 }
 
 /**
- * pipapo_get() - Get matching element reference given key data
+ * nft_pipapo_lookup() - Dataplane fronted for main lookup function
  * @net:	Network namespace
  * @set:	nftables API set representation
- * @m:		storage containing active/existing elements
- * @data:	Key data to be matched against existing elements
- * @genmask:	If set, check that element is active in given genmask
- * @tstamp:	timestamp to check for expired elements
- * @gfp:	the type of memory to allocate (see kmalloc).
+ * @key:	pointer to nft registers containing key data
+ *
+ * This function is called from the data path.  It will search for
+ * an element matching the given key in the current active copy.
+ * Unlike other set types, this uses NFT_GENMASK_ANY instead of
+ * nft_genmask_cur().
  *
- * This is essentially the same as the lookup function, except that it matches
- * key data against the uncommitted copy and doesn't use preallocated maps for
- * bitmap results.
+ * This is because new (future) elements are not reachable from
+ * priv->match, they get added to priv->clone instead.
+ * When the commit phase flips the generation bitmask, the
+ * 'now old' entries are skipped but without the 'now current'
+ * elements becoming visible. Using nft_genmask_cur() thus creates
+ * inconsistent state: matching old entries get skipped but thew
+ * newly matching entries are unreachable.
  *
- * Return: pointer to &struct nft_pipapo_elem on match, error pointer otherwise.
+ * GENMASK will still find the 'now old' entries which ensures consistent
+ * priv->match view.
+ *
+ * nft_pipapo_commit swaps ->clone and ->match shortly after the
+ * genbit flip.  As ->clone doesn't contain the old entries in the first
+ * place, lookup will only find the now-current ones.
+ *
+ * Return: ntables API extension pointer or NULL if no match.
  */
-static struct nft_pipapo_elem *pipapo_get(const struct net *net,
-					  const struct nft_set *set,
-					  const struct nft_pipapo_match *m,
-					  const u8 *data, u8 genmask,
-					  u64 tstamp, gfp_t gfp)
+const struct nft_set_ext *
+nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key)
 {
-	struct nft_pipapo_elem *ret = ERR_PTR(-ENOENT);
-	unsigned long *res_map, *fill_map = NULL;
-	const struct nft_pipapo_field *f;
-	int i;
-
-	if (m->bsize_max == 0)
-		return ret;
-
-	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), gfp);
-	if (!res_map) {
-		ret = ERR_PTR(-ENOMEM);
-		goto out;
-	}
-
-	fill_map = kcalloc(m->bsize_max, sizeof(*res_map), gfp);
-	if (!fill_map) {
-		ret = ERR_PTR(-ENOMEM);
-		goto out;
-	}
-
-	pipapo_resmap_init(m, res_map);
-
-	nft_pipapo_for_each_field(f, i, m) {
-		bool last = i == m->field_count - 1;
-		int b;
-
-		/* For each bit group: select lookup table bucket depending on
-		 * packet bytes value, then AND bucket value
-		 */
-		if (f->bb == 8)
-			pipapo_and_field_buckets_8bit(f, res_map, data);
-		else if (f->bb == 4)
-			pipapo_and_field_buckets_4bit(f, res_map, data);
-		else
-			BUG();
-
-		data += f->groups / NFT_PIPAPO_GROUPS_PER_BYTE(f);
-
-		/* Now populate the bitmap for the next field, unless this is
-		 * the last field, in which case return the matched 'ext'
-		 * pointer if any.
-		 *
-		 * Now res_map contains the matching bitmap, and fill_map is the
-		 * bitmap for the next field.
-		 */
-next_match:
-		b = pipapo_refill(res_map, f->bsize, f->rules, fill_map, f->mt,
-				  last);
-		if (b < 0)
-			goto out;
-
-		if (last) {
-			if (__nft_set_elem_expired(&f->mt[b].e->ext, tstamp))
-				goto next_match;
-			if ((genmask &&
-			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
-				goto next_match;
-
-			ret = f->mt[b].e;
-			goto out;
-		}
-
-		data += NFT_PIPAPO_GROUPS_PADDING(f);
+	struct nft_pipapo *priv = nft_set_priv(set);
+	const struct nft_pipapo_match *m;
+	const struct nft_pipapo_elem *e;
 
-		/* Swap bitmap indices: fill_map will be the initial bitmap for
-		 * the next field (i.e. the new res_map), and res_map is
-		 * guaranteed to be all-zeroes at this point, ready to be filled
-		 * according to the next mapping table.
-		 */
-		swap(res_map, fill_map);
-	}
+	m = rcu_dereference(priv->match);
+	e = pipapo_get(m, (const u8 *)key, NFT_GENMASK_ANY, get_jiffies_64());
 
-out:
-	kfree(fill_map);
-	kfree(res_map);
-	return ret;
+	return e ? &e->ext : NULL;
 }
 
 /**
@@ -606,6 +550,11 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
  * @set:	nftables API set representation
  * @elem:	nftables API element representation containing key data
  * @flags:	Unused
+ *
+ * This function is called from the control plane path under
+ * RCU read lock.
+ *
+ * Return: set element private pointer or ERR_PTR(-ENOENT).
  */
 static struct nft_elem_priv *
 nft_pipapo_get(const struct net *net, const struct nft_set *set,
@@ -615,11 +564,10 @@ nft_pipapo_get(const struct net *net, const struct nft_set *set,
 	struct nft_pipapo_match *m = rcu_dereference(priv->match);
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, m, (const u8 *)elem->key.val.data,
-		       nft_genmask_cur(net), get_jiffies_64(),
-		       GFP_ATOMIC);
-	if (IS_ERR(e))
-		return ERR_CAST(e);
+	e = pipapo_get(m, (const u8 *)elem->key.val.data,
+		       nft_genmask_cur(net), get_jiffies_64());
+	if (!e)
+		return ERR_PTR(-ENOENT);
 
 	return &e->priv;
 }
@@ -1344,8 +1292,8 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	else
 		end = start;
 
-	dup = pipapo_get(net, set, m, start, genmask, tstamp, GFP_KERNEL);
-	if (!IS_ERR(dup)) {
+	dup = pipapo_get(m, start, genmask, tstamp);
+	if (dup) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
 
@@ -1364,15 +1312,9 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 		return -ENOTEMPTY;
 	}
 
-	if (PTR_ERR(dup) == -ENOENT) {
-		/* Look for partially overlapping entries */
-		dup = pipapo_get(net, set, m, end, nft_genmask_next(net), tstamp,
-				 GFP_KERNEL);
-	}
-
-	if (PTR_ERR(dup) != -ENOENT) {
-		if (IS_ERR(dup))
-			return PTR_ERR(dup);
+	/* Look for partially overlapping entries */
+	dup = pipapo_get(m, end, nft_genmask_next(net), tstamp);
+	if (dup) {
 		*elem_priv = &dup->priv;
 		return -ENOTEMPTY;
 	}
@@ -1913,9 +1855,9 @@ nft_pipapo_deactivate(const struct net *net, const struct nft_set *set,
 	if (!m)
 		return NULL;
 
-	e = pipapo_get(net, set, m, (const u8 *)elem->key.val.data,
-		       nft_genmask_next(net), nft_net_tstamp(net), GFP_KERNEL);
-	if (IS_ERR(e))
+	e = pipapo_get(m, (const u8 *)elem->key.val.data,
+		       nft_genmask_next(net), nft_net_tstamp(net));
+	if (!e)
 		return NULL;
 
 	nft_set_elem_change_active(net, set, &e->ext);
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index be7c16c79f71..39e356c9687a 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1146,26 +1146,27 @@ static inline void pipapo_resmap_init_avx2(const struct nft_pipapo_match *m, uns
  *
  * Return: true on match, false otherwise.
  */
-bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
-			    const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
+		       const u32 *key)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
+	const struct nft_set_ext *ext = NULL;
 	struct nft_pipapo_scratch *scratch;
-	u8 genmask = nft_genmask_cur(net);
 	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
 	const u8 *rp = (const u8 *)key;
 	unsigned long *res, *fill;
 	bool map_index;
-	int i, ret = 0;
+	int i;
 
 	local_bh_disable();
 
 	if (unlikely(!irq_fpu_usable())) {
-		bool fallback_res = nft_pipapo_lookup(net, set, key, ext);
+		ext = nft_pipapo_lookup(net, set, key);
 
 		local_bh_enable();
-		return fallback_res;
+		return ext;
 	}
 
 	m = rcu_dereference(priv->match);
@@ -1182,7 +1183,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	if (unlikely(!scratch)) {
 		kernel_fpu_end();
 		local_bh_enable();
-		return false;
+		return NULL;
 	}
 
 	map_index = scratch->map_index;
@@ -1197,6 +1198,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 next_match:
 	nft_pipapo_for_each_field(f, i, m) {
 		bool last = i == m->field_count - 1, first = !i;
+		int ret = 0;
 
 #define NFT_SET_PIPAPO_AVX2_LOOKUP(b, n)				\
 		(ret = nft_pipapo_avx2_lookup_##b##b_##n(res, fill, f,	\
@@ -1244,13 +1246,12 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 			goto out;
 
 		if (last) {
-			*ext = &f->mt[ret].e->ext;
-			if (unlikely(nft_set_elem_expired(*ext) ||
-				     !nft_set_elem_active(*ext, genmask))) {
-				ret = 0;
+			const struct nft_set_ext *e = &f->mt[ret].e->ext;
+
+			if (unlikely(nft_set_elem_expired(e)))
 				goto next_match;
-			}
 
+			ext = e;
 			goto out;
 		}
 
@@ -1264,5 +1265,5 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	kernel_fpu_end();
 	local_bh_enable();
 
-	return ret >= 0;
+	return ext;
 }
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 2e8ef16ff191..b1f04168ec93 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -52,9 +52,9 @@ static bool nft_rbtree_elem_expired(const struct nft_rbtree_elem *rbe)
 	return nft_set_elem_expired(&rbe->ext);
 }
 
-static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
-				const u32 *key, const struct nft_set_ext **ext,
-				unsigned int seq)
+static const struct nft_set_ext *
+__nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
+		    const u32 *key, unsigned int seq)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	const struct nft_rbtree_elem *rbe, *interval = NULL;
@@ -65,7 +65,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 	parent = rcu_dereference_raw(priv->root.rb_node);
 	while (parent != NULL) {
 		if (read_seqcount_retry(&priv->count, seq))
-			return false;
+			return NULL;
 
 		rbe = rb_entry(parent, struct nft_rbtree_elem, node);
 
@@ -77,7 +77,9 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 			    nft_rbtree_interval_end(rbe) &&
 			    nft_rbtree_interval_start(interval))
 				continue;
-			interval = rbe;
+			if (nft_set_elem_active(&rbe->ext, genmask) &&
+			    !nft_rbtree_elem_expired(rbe))
+				interval = rbe;
 		} else if (d > 0)
 			parent = rcu_dereference_raw(parent->rb_right);
 		else {
@@ -87,50 +89,46 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 			}
 
 			if (nft_rbtree_elem_expired(rbe))
-				return false;
+				return NULL;
 
 			if (nft_rbtree_interval_end(rbe)) {
 				if (nft_set_is_anonymous(set))
-					return false;
+					return NULL;
 				parent = rcu_dereference_raw(parent->rb_left);
 				interval = NULL;
 				continue;
 			}
 
-			*ext = &rbe->ext;
-			return true;
+			return &rbe->ext;
 		}
 	}
 
 	if (set->flags & NFT_SET_INTERVAL && interval != NULL &&
-	    nft_set_elem_active(&interval->ext, genmask) &&
-	    !nft_rbtree_elem_expired(interval) &&
-	    nft_rbtree_interval_start(interval)) {
-		*ext = &interval->ext;
-		return true;
-	}
+	    nft_rbtree_interval_start(interval))
+		return &interval->ext;
 
-	return false;
+	return NULL;
 }
 
 INDIRECT_CALLABLE_SCOPE
-bool nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	unsigned int seq = read_seqcount_begin(&priv->count);
-	bool ret;
+	const struct nft_set_ext *ext;
 
-	ret = __nft_rbtree_lookup(net, set, key, ext, seq);
-	if (ret || !read_seqcount_retry(&priv->count, seq))
-		return ret;
+	ext = __nft_rbtree_lookup(net, set, key, seq);
+	if (ext || !read_seqcount_retry(&priv->count, seq))
+		return ext;
 
 	read_lock_bh(&priv->lock);
 	seq = read_seqcount_begin(&priv->count);
-	ret = __nft_rbtree_lookup(net, set, key, ext, seq);
+	ext = __nft_rbtree_lookup(net, set, key, seq);
 	read_unlock_bh(&priv->lock);
 
-	return ret;
+	return ext;
 }
 
 static bool __nft_rbtree_get(const struct net *net, const struct nft_set *set,
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 07ad65774fe2..3327d8451814 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1836,6 +1836,9 @@ static int genl_bind(struct net *net, int group)
 		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
 			ret = -EPERM;
 
+		if (ret)
+			break;
+
 		if (family->bind)
 			family->bind(i);
 
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 73bc39281ef5..9b45fbdc90ca 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -276,8 +276,6 @@ EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
 
 static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
-	if (unlikely(current->flags & PF_EXITING))
-		return -EINTR;
 	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 92cec227215a..b78f1aae9e80 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -407,9 +407,9 @@ xs_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags, int flags)
 	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
 		      alert_kvec.iov_len);
 	ret = sock_recvmsg(sock, &msg, flags);
-	if (ret > 0 &&
-	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
-		iov_iter_revert(&msg.msg_iter, ret);
+	if (ret > 0) {
+		if (tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT)
+			iov_iter_revert(&msg.msg_iter, ret);
 		ret = xs_sock_process_cmsg(sock, &msg, msg_flags, &u.cmsg,
 					   -EAGAIN);
 	}
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 81220390851a..328c6e60f024 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -75,8 +75,8 @@ asm (
 	CALL_DEPTH_ACCOUNT
 "	call my_direct_func1\n"
 "	leave\n"
-"	.size		my_tramp1, .-my_tramp1\n"
 	ASM_RET
+"	.size		my_tramp1, .-my_tramp1\n"
 
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a28a59926ada..eb0e404c1784 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10857,6 +10857,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x1054, "ASUS G614FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x1043, 0x106f, "ASUS VivoBook X515UA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1074, "ASUS G614PH/PM/PP", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x10a1, "ASUS UX391UA", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x10a4, "ASUS TP3407SA", ALC287_FIXUP_TAS2781_I2C),


Return-Path: <stable+bounces-189131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 598D7C01D26
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAD9A508960
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA69232D439;
	Thu, 23 Oct 2025 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ILHfLQ6S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1532D42E;
	Thu, 23 Oct 2025 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230150; cv=none; b=RXwPsBDw8ycH/zAeNBEuq8/SzEsOOYQ/JtUSWSRm/PuSHZ+qhlQHtx7YFO7YSXwa+ViN+wvFQeu3QDDY9jA3IpedCWBy7av26TrYJLZH2yegOW/j68+pYF0Wykan6jf/c+Mbdb0BxQMDSk6NZRr7RJl7AenhFOx2wOpM2iMg+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230150; c=relaxed/simple;
	bh=do/eavLY8mcOktH+OJ64GOQ9+CxQUvRFnWQ7NzNZFkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJIFUP874wCHEufjZ2hiYW5z2rMor0CwbDLbabrKijuO+DfZArbNXp81bHsuvJIqMCMtKrTHStHHzRZH7RhfBCEwQsS4uxghZRTQe3/nQypA2SIfWZGUBb7n+ust/YBWpDK5h57pe/yfL2C3+7lTei9/Sd6qMPY0+FJkkaqk1cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ILHfLQ6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64E3C4CEF7;
	Thu, 23 Oct 2025 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761230149;
	bh=do/eavLY8mcOktH+OJ64GOQ9+CxQUvRFnWQ7NzNZFkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILHfLQ6SEaWl7uTk+kTY0iUHOVrJAWoJ5zJ/vpjb8KwiDVurwD+ryV4NDZI0kDUc0
	 3iSzc0e0bCcab1IKP8sz6h//JJCZfP+bUr7VbMH2tTIqCdgp0nCcfXEfX+omxxhKBP
	 pS8OgWxl0PnYh/+dAlBNsToyF8DXeVEgiAbfzd7U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.114
Date: Thu, 23 Oct 2025 16:35:38 +0200
Message-ID: <2025102338-purse-selector-7174@gregkh>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <2025102338-kick-avatar-03ef@gregkh>
References: <2025102338-kick-avatar-03ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 8209c7a7c397..fbc833841bef 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -187,6 +187,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-600         | #1076982,1209401| N/A                         |
diff --git a/Documentation/networking/seg6-sysctl.rst b/Documentation/networking/seg6-sysctl.rst
index 07c20e470baf..1b6af4779be1 100644
--- a/Documentation/networking/seg6-sysctl.rst
+++ b/Documentation/networking/seg6-sysctl.rst
@@ -25,6 +25,9 @@ seg6_require_hmac - INTEGER
 
 	Default is 0.
 
+/proc/sys/net/ipv6/seg6_* variables:
+====================================
+
 seg6_flowlabel - INTEGER
 	Controls the behaviour of computing the flowlabel of outer
 	IPv6 header in case of SR T.encaps
diff --git a/Makefile b/Makefile
index ab277ff87643..ad3952fb542d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 113
+SUBLEVEL = 114
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4ecba0690938..1be9f1f6b320 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1094,6 +1094,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Neoverse-V1 erratum 3324341
 	  * ARM Neoverse V2 erratum 3324336
 	  * ARM Neoverse-V3 erratum 3312417
+	  * ARM Neoverse-V3AE erratum 3312417
 
 	  On affected cores "MSR SSBS, #0" instructions may not affect
 	  subsequent speculative instructions, which may permit unexepected
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index d92a0203e5a9..c279a0a9b366 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -93,6 +93,7 @@
 #define ARM_CPU_PART_NEOVERSE_V2	0xD4F
 #define ARM_CPU_PART_CORTEX_A720	0xD81
 #define ARM_CPU_PART_CORTEX_X4		0xD82
+#define ARM_CPU_PART_NEOVERSE_V3AE	0xD83
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
 #define ARM_CPU_PART_CORTEX_X925	0xD85
 #define ARM_CPU_PART_CORTEX_A725	0xD87
@@ -180,6 +181,7 @@
 #define MIDR_NEOVERSE_V2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V2)
 #define MIDR_CORTEX_A720 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720)
 #define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
+#define MIDR_NEOVERSE_V3AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3AE)
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
 #define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 463b48d0f925..23dcd0c4aad3 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -471,6 +471,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
 	{}
 };
 #endif
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 297427ffc4e0..8a6ea7d27018 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -48,10 +48,15 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 	post_kprobe_handler(p, kcb, regs);
 }
 
-static bool __kprobes arch_check_kprobe(struct kprobe *p)
+static bool __kprobes arch_check_kprobe(unsigned long addr)
 {
-	unsigned long tmp  = (unsigned long)p->addr - p->offset;
-	unsigned long addr = (unsigned long)p->addr;
+	unsigned long tmp, offset;
+
+	/* start iterating at the closest preceding symbol */
+	if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
+		return false;
+
+	tmp = addr - offset;
 
 	while (tmp <= addr) {
 		if (tmp == addr)
@@ -70,7 +75,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if ((unsigned long)insn & 0x1)
 		return -EILSEQ;
 
-	if (!arch_check_kprobe(p))
+	if (!arch_check_kprobe((unsigned long)p->addr))
 		return -EILSEQ;
 
 	/* copy instruction */
diff --git a/block/bdev.c b/block/bdev.c
index 5a54977518ee..a8357b72a27b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -147,9 +147,26 @@ int set_blocksize(struct block_device *bdev, int size)
 
 	/* Don't change the size if it is same as current */
 	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
+		/*
+		 * Flush and truncate the pagecache before we reconfigure the
+		 * mapping geometry because folio sizes are variable now.  If a
+		 * reader has already allocated a folio whose size is smaller
+		 * than the new min_order but invokes readahead after the new
+		 * min_order becomes visible, readahead will think there are
+		 * "zero" blocks per folio and crash.  Take the inode and
+		 * invalidation locks to avoid racing with
+		 * read/write/fallocate.
+		 */
+		inode_lock(bdev->bd_inode);
+		filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+
 		sync_blockdev(bdev);
+		kill_bdev(bdev);
+
 		bdev->bd_inode->i_blkbits = blksize_bits(size);
 		kill_bdev(bdev);
+		filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+		inode_unlock(bdev->bd_inode);
 	}
 	return 0;
 }
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 619ee41a51cc..644bfa1f6753 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -401,6 +401,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		op = REQ_OP_ZONE_RESET;
 
 		/* Invalidate the page cache, including dirty pages. */
+		inode_lock(bdev->bd_inode);
 		filemap_invalidate_lock(bdev->bd_inode->i_mapping);
 		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
 		if (ret)
@@ -423,8 +424,10 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 			       GFP_KERNEL);
 
 fail:
-	if (cmd == BLKRESETZONE)
+	if (cmd == BLKRESETZONE) {
 		filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+		inode_unlock(bdev->bd_inode);
+	}
 
 	return ret;
 }
diff --git a/block/fops.c b/block/fops.c
index 7c257eb3564d..088143fa9ac9 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -681,7 +681,14 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 	} else {
+		/*
+		 * Take i_rwsem and invalidate_lock to avoid racing with
+		 * set_blocksize changing i_blkbits/folio order and punching
+		 * out the pagecache.
+		 */
+		inode_lock_shared(bd_inode);
 		ret = blkdev_buffered_write(iocb, from);
+		inode_unlock_shared(bd_inode);
 	}
 
 	if (ret > 0)
@@ -693,6 +700,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
+	struct inode *bd_inode = bdev->bd_inode;
 	loff_t size = bdev_nr_bytes(bdev);
 	loff_t pos = iocb->ki_pos;
 	size_t shorted = 0;
@@ -728,7 +736,13 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			goto reexpand;
 	}
 
+	/*
+	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
+	 * changing i_blkbits/folio order and punching out the pagecache.
+	 */
+	inode_lock_shared(bd_inode);
 	ret = filemap_read(iocb, to, ret);
+	inode_unlock_shared(bd_inode);
 
 reexpand:
 	if (unlikely(shorted))
@@ -771,6 +785,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
+	inode_lock(inode);
 	filemap_invalidate_lock(inode->i_mapping);
 
 	/*
@@ -811,6 +826,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
  fail:
 	filemap_invalidate_unlock(inode->i_mapping);
+	inode_unlock(inode);
 	return error;
 }
 
diff --git a/block/ioctl.c b/block/ioctl.c
index 231537f79a8c..024767fa1e52 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -114,6 +114,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
+	inode_lock(inode);
 	filemap_invalidate_lock(inode->i_mapping);
 	err = truncate_bdev_range(bdev, mode, start, end - 1);
 	if (err)
@@ -121,6 +122,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	err = blkdev_issue_discard(bdev, start >> 9, len >> 9, GFP_KERNEL);
 fail:
 	filemap_invalidate_unlock(inode->i_mapping);
+	inode_unlock(inode);
 	return err;
 }
 
@@ -146,12 +148,14 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
+	inode_lock(bdev->bd_inode);
 	filemap_invalidate_lock(bdev->bd_inode->i_mapping);
 	err = truncate_bdev_range(bdev, mode, start, end - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
 	filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+	inode_unlock(bdev->bd_inode);
 	return err;
 }
 
@@ -184,6 +188,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		return -EINVAL;
 
 	/* Invalidate the page cache, including dirty pages */
+	inode_lock(inode);
 	filemap_invalidate_lock(inode->i_mapping);
 	err = truncate_bdev_range(bdev, mode, start, end);
 	if (err)
@@ -194,6 +199,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 
 fail:
 	filemap_invalidate_unlock(inode->i_mapping);
+	inode_unlock(inode);
 	return err;
 }
 
diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_control.c
index f3db3fa91dd5..08b78f567853 100644
--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -407,7 +407,7 @@ static int find_and_map_user_pages(struct qaic_device *qdev,
 		return -EINVAL;
 	remaining = in_trans->size - resources->xferred_dma_size;
 	if (remaining == 0)
-		return 0;
+		return -EINVAL;
 
 	if (check_add_overflow(xfer_start_addr, remaining, &end))
 		return -EINVAL;
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index f53c14fb74fd..5a33cee9a394 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1552,6 +1552,32 @@ void pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+static void pm_runtime_set_suspended_action(void *data)
+{
+	pm_runtime_set_suspended(data);
+}
+
+/**
+ * devm_pm_runtime_set_active_enabled - set_active version of devm_pm_runtime_enable.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_set_active_enabled(struct device *dev)
+{
+	int err;
+
+	err = pm_runtime_set_active(dev);
+	if (err)
+		return err;
+
+	err = devm_add_action_or_reset(dev, pm_runtime_set_suspended_action, dev);
+	if (err)
+		return err;
+
+	return devm_pm_runtime_enable(dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_set_active_enabled);
+
 static void pm_runtime_disable_action(void *data)
 {
 	pm_runtime_dont_use_autosuspend(data);
@@ -1574,6 +1600,24 @@ int devm_pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
 
+static void pm_runtime_put_noidle_action(void *data)
+{
+	pm_runtime_put_noidle(data);
+}
+
+/**
+ * devm_pm_runtime_get_noresume - devres-enabled version of pm_runtime_get_noresume.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_get_noresume(struct device *dev)
+{
+	pm_runtime_get_noresume(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_put_noidle_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_get_noresume);
+
 /**
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1a2d227b7b7b..4c21230aee46 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -511,6 +511,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8851BU Bluetooth devices */
 	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2001, 0x332a), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index ea32bdf7cc24..4d96eed64fe0 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -344,6 +344,16 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
+static unsigned int __cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
+{
+	unsigned int transition_latency_ns = cppc_get_transition_latency(cpu);
+
+	if (transition_latency_ns == CPUFREQ_ETERNAL)
+		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
+
+	return transition_latency_ns / NSEC_PER_USEC;
+}
+
 /*
  * The PCC subspace describes the rate at which platform can accept commands
  * on the shared PCC channel (including READs which do not count towards freq
@@ -366,12 +376,12 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 			return 10000;
 		}
 	}
-	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+	return __cppc_cpufreq_get_transition_delay_us(cpu);
 }
 #else
 static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 {
-	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+	return __cppc_cpufreq_get_transition_delay_us(cpu);
 }
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a1f35510d539..c94e1cc7e3a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2285,10 +2285,9 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 					  struct kfd_vm_fault_info *mem)
 {
-	if (atomic_read(&adev->gmc.vm_fault_info_updated) == 1) {
+	if (atomic_read_acquire(&adev->gmc.vm_fault_info_updated) == 1) {
 		*mem = *adev->gmc.vm_fault_info;
-		mb(); /* make sure read happened */
-		atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c83445c2e37f..d358a08b5e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2012,7 +2012,7 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	}
 
 	ret = psp_ta_load(psp, &psp->securedisplay_context.context);
-	if (!ret) {
+	if (!ret && !psp->securedisplay_context.context.resp_status) {
 		psp->securedisplay_context.context.initialized = true;
 		mutex_init(&psp->securedisplay_context.mutex);
 	} else
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index fd905889a4c6..e2ee10a98640 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1061,7 +1061,7 @@ static int gmc_v7_0_sw_init(void *handle)
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1290,7 +1290,7 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1306,8 +1306,7 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 0bebcdbb2658..ed268c5739eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1174,7 +1174,7 @@ static int gmc_v8_0_sw_init(void *handle)
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1465,7 +1465,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1481,8 +1481,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 53849fd3615f..965ffcac17f8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5437,8 +5437,7 @@ static int smu7_get_thermal_temperature_range(struct pp_hwmgr *hwmgr,
 		thermal_data->max = table_info->cac_dtp_table->usSoftwareShutdownTemp *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	else if (hwmgr->pp_table_version == PP_TABLE_V0)
-		thermal_data->max = data->thermal_temp_setting.temperature_shutdown *
-			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		thermal_data->max = data->thermal_temp_setting.temperature_shutdown;
 
 	thermal_data->sw_ctf_threshold = thermal_data->max;
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index 4d404f5ef87e..ea192c90b543 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -120,8 +120,7 @@ static int lt9211_read_chipid(struct lt9211 *ctx)
 	}
 
 	/* Test for known Chip ID. */
-	if (chipid[0] != REG_CHIPID0_VALUE || chipid[1] != REG_CHIPID1_VALUE ||
-	    chipid[2] != REG_CHIPID2_VALUE) {
+	if (chipid[0] != REG_CHIPID0_VALUE || chipid[1] != REG_CHIPID1_VALUE) {
 		dev_err(ctx->dev, "Unknown Chip ID: 0x%02x 0x%02x 0x%02x\n",
 			chipid[0], chipid[1], chipid[2]);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 5f8e5e87d7cd..0ed62cd51fb5 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -51,7 +51,6 @@ struct decon_context {
 	void __iomem			*regs;
 	unsigned long			irq_flags;
 	bool				i80_if;
-	bool				suspended;
 	wait_queue_head_t		wait_vsync_queue;
 	atomic_t			wait_vsync_event;
 
@@ -81,13 +80,30 @@ static const enum drm_plane_type decon_win_types[WINDOWS_NR] = {
 	DRM_PLANE_TYPE_CURSOR,
 };
 
-static void decon_wait_for_vblank(struct exynos_drm_crtc *crtc)
+/**
+ * decon_shadow_protect_win() - disable updating values from shadow registers at vsync
+ *
+ * @ctx: display and enhancement controller context
+ * @win: window to protect registers for
+ * @protect: 1 to protect (disable updates)
+ */
+static void decon_shadow_protect_win(struct decon_context *ctx,
+				     unsigned int win, bool protect)
 {
-	struct decon_context *ctx = crtc->ctx;
+	u32 bits, val;
 
-	if (ctx->suspended)
-		return;
+	bits = SHADOWCON_WINx_PROTECT(win);
+
+	val = readl(ctx->regs + SHADOWCON);
+	if (protect)
+		val |= bits;
+	else
+		val &= ~bits;
+	writel(val, ctx->regs + SHADOWCON);
+}
 
+static void decon_wait_for_vblank(struct decon_context *ctx)
+{
 	atomic_set(&ctx->wait_vsync_event, 1);
 
 	/*
@@ -100,25 +116,33 @@ static void decon_wait_for_vblank(struct exynos_drm_crtc *crtc)
 		DRM_DEV_DEBUG_KMS(ctx->dev, "vblank wait timed out.\n");
 }
 
-static void decon_clear_channels(struct exynos_drm_crtc *crtc)
+static void decon_clear_channels(struct decon_context *ctx)
 {
-	struct decon_context *ctx = crtc->ctx;
 	unsigned int win, ch_enabled = 0;
+	u32 val;
 
 	/* Check if any channel is enabled. */
 	for (win = 0; win < WINDOWS_NR; win++) {
-		u32 val = readl(ctx->regs + WINCON(win));
+		val = readl(ctx->regs + WINCON(win));
 
 		if (val & WINCONx_ENWIN) {
+			decon_shadow_protect_win(ctx, win, true);
+
 			val &= ~WINCONx_ENWIN;
 			writel(val, ctx->regs + WINCON(win));
 			ch_enabled = 1;
+
+			decon_shadow_protect_win(ctx, win, false);
 		}
 	}
 
+	val = readl(ctx->regs + DECON_UPDATE);
+	val |= DECON_UPDATE_STANDALONE_F;
+	writel(val, ctx->regs + DECON_UPDATE);
+
 	/* Wait for vsync, as disable channel takes effect at next vsync */
 	if (ch_enabled)
-		decon_wait_for_vblank(ctx->crtc);
+		decon_wait_for_vblank(ctx);
 }
 
 static int decon_ctx_initialize(struct decon_context *ctx,
@@ -126,7 +150,7 @@ static int decon_ctx_initialize(struct decon_context *ctx,
 {
 	ctx->drm_dev = drm_dev;
 
-	decon_clear_channels(ctx->crtc);
+	decon_clear_channels(ctx);
 
 	return exynos_drm_register_dma(drm_dev, ctx->dev, &ctx->dma_priv);
 }
@@ -155,9 +179,6 @@ static void decon_commit(struct exynos_drm_crtc *crtc)
 	struct drm_display_mode *mode = &crtc->base.state->adjusted_mode;
 	u32 val, clkdiv;
 
-	if (ctx->suspended)
-		return;
-
 	/* nothing to do if we haven't set the mode yet */
 	if (mode->htotal == 0 || mode->vtotal == 0)
 		return;
@@ -219,9 +240,6 @@ static int decon_enable_vblank(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	u32 val;
 
-	if (ctx->suspended)
-		return -EPERM;
-
 	if (!test_and_set_bit(0, &ctx->irq_flags)) {
 		val = readl(ctx->regs + VIDINTCON0);
 
@@ -244,9 +262,6 @@ static void decon_disable_vblank(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	u32 val;
 
-	if (ctx->suspended)
-		return;
-
 	if (test_and_clear_bit(0, &ctx->irq_flags)) {
 		val = readl(ctx->regs + VIDINTCON0);
 
@@ -343,36 +358,11 @@ static void decon_win_set_colkey(struct decon_context *ctx, unsigned int win)
 	writel(keycon1, ctx->regs + WKEYCON1_BASE(win));
 }
 
-/**
- * decon_shadow_protect_win() - disable updating values from shadow registers at vsync
- *
- * @ctx: display and enhancement controller context
- * @win: window to protect registers for
- * @protect: 1 to protect (disable updates)
- */
-static void decon_shadow_protect_win(struct decon_context *ctx,
-				     unsigned int win, bool protect)
-{
-	u32 bits, val;
-
-	bits = SHADOWCON_WINx_PROTECT(win);
-
-	val = readl(ctx->regs + SHADOWCON);
-	if (protect)
-		val |= bits;
-	else
-		val &= ~bits;
-	writel(val, ctx->regs + SHADOWCON);
-}
-
 static void decon_atomic_begin(struct exynos_drm_crtc *crtc)
 {
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	for (i = 0; i < WINDOWS_NR; i++)
 		decon_shadow_protect_win(ctx, i, true);
 }
@@ -392,9 +382,6 @@ static void decon_update_plane(struct exynos_drm_crtc *crtc,
 	unsigned int cpp = fb->format->cpp[0];
 	unsigned int pitch = fb->pitches[0];
 
-	if (ctx->suspended)
-		return;
-
 	/*
 	 * SHADOWCON/PRTCON register is used for enabling timing.
 	 *
@@ -482,9 +469,6 @@ static void decon_disable_plane(struct exynos_drm_crtc *crtc,
 	unsigned int win = plane->index;
 	u32 val;
 
-	if (ctx->suspended)
-		return;
-
 	/* protect windows */
 	decon_shadow_protect_win(ctx, win, true);
 
@@ -503,9 +487,6 @@ static void decon_atomic_flush(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	for (i = 0; i < WINDOWS_NR; i++)
 		decon_shadow_protect_win(ctx, i, false);
 	exynos_crtc_handle_event(crtc);
@@ -533,9 +514,6 @@ static void decon_atomic_enable(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int ret;
 
-	if (!ctx->suspended)
-		return;
-
 	ret = pm_runtime_resume_and_get(ctx->dev);
 	if (ret < 0) {
 		DRM_DEV_ERROR(ctx->dev, "failed to enable DECON device.\n");
@@ -549,8 +527,6 @@ static void decon_atomic_enable(struct exynos_drm_crtc *crtc)
 		decon_enable_vblank(ctx->crtc);
 
 	decon_commit(ctx->crtc);
-
-	ctx->suspended = false;
 }
 
 static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
@@ -558,9 +534,6 @@ static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
 	struct decon_context *ctx = crtc->ctx;
 	int i;
 
-	if (ctx->suspended)
-		return;
-
 	/*
 	 * We need to make sure that all windows are disabled before we
 	 * suspend that connector. Otherwise we might try to scan from
@@ -570,8 +543,6 @@ static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
 		decon_disable_plane(crtc, &ctx->planes[i]);
 
 	pm_runtime_put_sync(ctx->dev);
-
-	ctx->suspended = true;
 }
 
 static const struct exynos_drm_crtc_ops decon_crtc_ops = {
@@ -692,7 +663,6 @@ static int decon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctx->dev = dev;
-	ctx->suspended = true;
 
 	i80_if_timings = of_get_child_by_name(dev->of_node, "i80-if-timings");
 	if (i80_if_timings)
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
index 97eadd08181d..38fad14ffd43 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
@@ -1281,9 +1281,16 @@ static int ct_receive(struct intel_guc_ct *ct)
 
 static void ct_try_receive_message(struct intel_guc_ct *ct)
 {
+	struct intel_guc *guc = ct_to_guc(ct);
 	int ret;
 
-	if (GEM_WARN_ON(!ct->enabled))
+	if (!ct->enabled) {
+		GEM_WARN_ON(!guc_to_gt(guc)->uc.reset_in_progress);
+		return;
+	}
+
+	/* When interrupt disabled, message handling is not expected */
+	if (!guc->interrupts.enabled)
 		return;
 
 	ret = ct_receive(ct);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index e7136b7759cb..c50aafa0ecdb 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -230,6 +230,8 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
 	if (ret)
 		DRM_DEV_ERROR(gmu->dev, "GMU firmware initialization timed out\n");
 
+	set_bit(GMU_STATUS_FW_START, &gmu->status);
+
 	return ret;
 }
 
@@ -460,9 +462,10 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
 	int ret;
 	u32 val;
 
-	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1 << 1);
-	/* Wait for the register to finish posting */
-	wmb();
+	if (!test_and_clear_bit(GMU_STATUS_PDC_SLEEP, &gmu->status))
+		return 0;
+
+	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
 
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
 		val & (1 << 1), 100, 10000);
@@ -489,6 +492,9 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
 	int ret;
 	u32 val;
 
+	if (test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
+		return;
+
 	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1);
 
 	ret = gmu_poll_timeout_rscc(gmu, REG_A6XX_GPU_RSCC_RSC_STATUS0_DRV0,
@@ -497,6 +503,8 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
 		DRM_DEV_ERROR(gmu->dev, "Unable to power off the GPU RSC\n");
 
 	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 0);
+
+	set_bit(GMU_STATUS_PDC_SLEEP, &gmu->status);
 }
 
 static inline void pdc_write(void __iomem *ptr, u32 offset, u32 value)
@@ -617,8 +625,6 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	/* ensure no writes happen before the uCode is fully written */
 	wmb();
 
-	a6xx_rpmh_stop(gmu);
-
 err:
 	if (!IS_ERR_OR_NULL(pdcptr))
 		iounmap(pdcptr);
@@ -755,22 +761,18 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FAL_INTF, 1);
 	}
 
-	if (state == GMU_WARM_BOOT) {
-		ret = a6xx_rpmh_start(gmu);
-		if (ret)
-			return ret;
-	} else {
+	/* Turn on register retention */
+	gmu_write(gmu, REG_A6XX_GMU_GENERAL_7, 1);
+
+	ret = a6xx_rpmh_start(gmu);
+	if (ret)
+		return ret;
+
+	if (state == GMU_COLD_BOOT) {
 		if (WARN(!adreno_gpu->fw[ADRENO_FW_GMU],
 			"GMU firmware is not loaded\n"))
 			return -ENOENT;
 
-		/* Turn on register retention */
-		gmu_write(gmu, REG_A6XX_GMU_GENERAL_7, 1);
-
-		ret = a6xx_rpmh_start(gmu);
-		if (ret)
-			return ret;
-
 		ret = a6xx_gmu_fw_load(gmu);
 		if (ret)
 			return ret;
@@ -909,6 +911,8 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 
 	/* Reset GPU core blocks */
 	a6xx_gpu_sw_reset(gpu, true);
+
+	a6xx_rpmh_stop(gmu);
 }
 
 static void a6xx_gmu_set_initial_freq(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 236f81a43caa..6a28ecaf8594 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -96,6 +96,12 @@ struct a6xx_gmu {
 	/* For power domain callback */
 	struct notifier_block pd_nb;
 	struct completion pd_gate;
+
+/* To check if we can trigger sleep seq at PDC. Cleared in a6xx_rpmh_stop() */
+#define GMU_STATUS_FW_START	0
+/* To track if PDC sleep seq was done */
+#define GMU_STATUS_PDC_SLEEP	1
+	unsigned long status;
 };
 
 static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 3664c1476a83..00bfc6f38f45 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1209,14 +1209,16 @@ static int hw_init(struct msm_gpu *gpu)
 	/* Clear GBIF halt in case GX domain was not collapsed */
 	if (adreno_is_a619_holi(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
+		gpu_read(gpu, REG_A6XX_GBIF_HALT);
+
 		gpu_write(gpu, REG_A6XX_RBBM_GPR0_CNTL, 0);
-		/* Let's make extra sure that the GPU can access the memory.. */
-		mb();
+		gpu_read(gpu, REG_A6XX_RBBM_GPR0_CNTL);
 	} else if (a6xx_has_gbif(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
+		gpu_read(gpu, REG_A6XX_GBIF_HALT);
+
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
-		/* Let's make extra sure that the GPU can access the memory.. */
-		mb();
+		gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT);
 	}
 
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 0193d10867dd..97486eba01b7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -984,7 +984,7 @@ static int vop2_plane_atomic_check(struct drm_plane *plane,
 		return format;
 
 	if (drm_rect_width(src) >> 16 < 4 || drm_rect_height(src) >> 16 < 4 ||
-	    drm_rect_width(dest) < 4 || drm_rect_width(dest) < 4) {
+	    drm_rect_width(dest) < 4 || drm_rect_height(dest) < 4) {
 		drm_err(vop2->drm, "Invalid size: %dx%d->%dx%d, min size is 4x4\n",
 			drm_rect_width(src) >> 16, drm_rect_height(src) >> 16,
 			drm_rect_width(dest), drm_rect_height(dest));
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index fa4652f23471..4faa2108c0a7 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -783,13 +783,14 @@ int drm_sched_job_add_resv_dependencies(struct drm_sched_job *job,
 	dma_resv_assert_held(resv);
 
 	dma_resv_for_each_fence(&cursor, resv, usage, fence) {
-		/* Make sure to grab an additional ref on the added fence */
-		dma_fence_get(fence);
-		ret = drm_sched_job_add_dependency(job, fence);
-		if (ret) {
-			dma_fence_put(fence);
+		/*
+		 * As drm_sched_job_add_dependency always consumes the fence
+		 * reference (even when it fails), and dma_resv_for_each_fence
+		 * is not obtaining one, we need to grab one before calling.
+		 */
+		ret = drm_sched_job_add_dependency(job, dma_fence_get(fence));
+		if (ret)
 			return ret;
-		}
 	}
 	return 0;
 }
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index f5c217ac4bfa..f073d5621050 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -622,7 +622,10 @@ static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
 		return;
 	}
 
-	if (value == 0 || value < dev->battery_min || value > dev->battery_max)
+	if ((usage & HID_USAGE_PAGE) == HID_UP_DIGITIZER && value == 0)
+		return;
+
+	if (value < dev->battery_min || value > dev->battery_max)
 		return;
 
 	capacity = hidinput_scale_battery_capacity(dev, value);
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index a85581cd511f..b9e67b408a4b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -83,9 +83,8 @@ enum latency_mode {
 	HID_LATENCY_HIGH = 1,
 };
 
-#define MT_IO_FLAGS_RUNNING		0
-#define MT_IO_FLAGS_ACTIVE_SLOTS	1
-#define MT_IO_FLAGS_PENDING_SLOTS	2
+#define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
+#define MT_IO_FLAGS_RUNNING		32
 
 static const bool mtrue = true;		/* default for true */
 static const bool mfalse;		/* default for false */
@@ -161,7 +160,11 @@ struct mt_device {
 	struct mt_class mtclass;	/* our mt device class */
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_device *hdev;	/* hid_device we're attached to */
-	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
+	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING)
+					 * first 8 bits are reserved for keeping the slot
+					 * states, this is fine because we only support up
+					 * to 250 slots (MT_MAX_MAXCONTACT)
+					 */
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
 	bool is_buttonpad;	/* is this device a button pad? */
@@ -936,6 +939,7 @@ static void mt_release_pending_palms(struct mt_device *td,
 
 	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
 		clear_bit(slotnum, app->pending_palm_slots);
+		clear_bit(slotnum, &td->mt_io_flags);
 
 		input_mt_slot(input, slotnum);
 		input_mt_report_slot_inactive(input);
@@ -967,12 +971,6 @@ static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
 
 	app->num_received = 0;
 	app->left_button_state = 0;
-
-	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
-		set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
-	else
-		clear_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
-	clear_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
 }
 
 static int mt_compute_timestamp(struct mt_application *app, __s32 value)
@@ -1147,7 +1145,9 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 
-		set_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
+		set_bit(slotnum, &td->mt_io_flags);
+	} else {
+		clear_bit(slotnum, &td->mt_io_flags);
 	}
 
 	return 0;
@@ -1282,7 +1282,7 @@ static void mt_touch_report(struct hid_device *hid,
 	 * defect.
 	 */
 	if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
-		if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+		if (td->mt_io_flags & MT_IO_SLOTS_MASK)
 			mod_timer(&td->release_timer,
 				  jiffies + msecs_to_jiffies(100));
 		else
@@ -1658,6 +1658,7 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	case HID_CP_CONSUMER_CONTROL:
 	case HID_GD_WIRELESS_RADIO_CTLS:
 	case HID_GD_SYSTEM_MULTIAXIS:
+	case HID_DG_PEN:
 		/* already handled by hid core */
 		break;
 	case HID_DG_TOUCHSCREEN:
@@ -1729,6 +1730,7 @@ static void mt_release_contacts(struct hid_device *hid)
 			for (i = 0; i < mt->num_slots; i++) {
 				input_mt_slot(input_dev, i);
 				input_mt_report_slot_inactive(input_dev);
+				clear_bit(i, &td->mt_io_flags);
 			}
 			input_mt_sync_frame(input_dev);
 			input_sync(input_dev);
@@ -1751,7 +1753,7 @@ static void mt_expired_timeout(struct timer_list *t)
 	 */
 	if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
-	if (test_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags))
+	if (td->mt_io_flags & MT_IO_SLOTS_MASK)
 		mt_release_contacts(hdev);
 	clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
 }
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 809734e566e3..e289afcb43e3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -126,9 +126,9 @@ struct inv_icm42600_suspended {
  *  @suspended:		suspended sensors configuration.
  *  @indio_gyro:	gyroscope IIO device.
  *  @indio_accel:	accelerometer IIO device.
- *  @buffer:		data transfer buffer aligned for DMA.
- *  @fifo:		FIFO management structure.
  *  @timestamp:		interrupt timestamps.
+ *  @fifo:		FIFO management structure.
+ *  @buffer:		data transfer buffer aligned for DMA.
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -142,12 +142,12 @@ struct inv_icm42600_state {
 	struct inv_icm42600_suspended suspended;
 	struct iio_dev *indio_gyro;
 	struct iio_dev *indio_accel;
-	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
-	struct inv_icm42600_fifo fifo;
 	struct {
 		s64 gyro;
 		s64 accel;
 	} timestamp;
+	struct inv_icm42600_fifo fifo;
+	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a1f055014cc6..99eb651743f8 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -567,20 +567,12 @@ static void inv_icm42600_disable_vdd_reg(void *_data)
 static void inv_icm42600_disable_vddio_reg(void *_data)
 {
 	struct inv_icm42600_state *st = _data;
-	const struct device *dev = regmap_get_device(st->map);
-	int ret;
-
-	ret = regulator_disable(st->vddio_supply);
-	if (ret)
-		dev_err(dev, "failed to disable vddio error %d\n", ret);
-}
+	struct device *dev = regmap_get_device(st->map);
 
-static void inv_icm42600_disable_pm(void *_data)
-{
-	struct device *dev = _data;
+	if (pm_runtime_status_suspended(dev))
+		return;
 
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
+	regulator_disable(st->vddio_supply);
 }
 
 int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
@@ -677,16 +669,14 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 		return ret;
 
 	/* setup runtime power management */
-	ret = pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret)
 		return ret;
-	pm_runtime_get_noresume(dev);
-	pm_runtime_enable(dev);
+
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42600_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_put(dev);
 
-	return devm_add_action_or_reset(dev, inv_icm42600_disable_pm, dev);
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, IIO_ICM42600);
 
@@ -697,17 +687,15 @@ EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, IIO_ICM42600);
 static int inv_icm42600_suspend(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
 	st->suspended.gyro = st->conf.gyro.mode;
 	st->suspended.accel = st->conf.accel.mode;
 	st->suspended.temp = st->conf.temp_en;
-	if (pm_runtime_suspended(dev)) {
-		ret = 0;
+	if (pm_runtime_suspended(dev))
 		goto out_unlock;
-	}
 
 	/* disable FIFO data streaming */
 	if (st->fifo.on) {
@@ -739,10 +727,13 @@ static int inv_icm42600_resume(struct device *dev)
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
 	struct inv_sensors_timestamp *gyro_ts = iio_priv(st->indio_gyro);
 	struct inv_sensors_timestamp *accel_ts = iio_priv(st->indio_accel);
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
+	if (pm_runtime_suspended(dev))
+		goto out_unlock;
+
 	ret = inv_icm42600_enable_regulator_vddio(st);
 	if (ret)
 		goto out_unlock;
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
index 2810ebe9b5f7..5a4676d52079 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
@@ -361,7 +361,7 @@ void mxc_isi_channel_get(struct mxc_isi_pipe *pipe);
 void mxc_isi_channel_put(struct mxc_isi_pipe *pipe);
 void mxc_isi_channel_enable(struct mxc_isi_pipe *pipe);
 void mxc_isi_channel_disable(struct mxc_isi_pipe *pipe);
-int mxc_isi_channel_chain(struct mxc_isi_pipe *pipe, bool bypass);
+int mxc_isi_channel_chain(struct mxc_isi_pipe *pipe);
 void mxc_isi_channel_unchain(struct mxc_isi_pipe *pipe);
 
 void mxc_isi_channel_config(struct mxc_isi_pipe *pipe,
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
index 19e80b95ffea..ece352171b93 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
@@ -589,7 +589,7 @@ void mxc_isi_channel_release(struct mxc_isi_pipe *pipe)
  *
  * TODO: Support secondary line buffer for downscaling YUV420 images.
  */
-int mxc_isi_channel_chain(struct mxc_isi_pipe *pipe, bool bypass)
+int mxc_isi_channel_chain(struct mxc_isi_pipe *pipe)
 {
 	/* Channel chaining requires both line and output buffer. */
 	const u8 resources = MXC_ISI_CHANNEL_RES_OUTPUT_BUF
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
index cd6c52e9d158..81223d28ee56 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
@@ -43,7 +43,6 @@ struct mxc_isi_m2m_ctx_queue_data {
 	struct v4l2_pix_format_mplane format;
 	const struct mxc_isi_format_info *info;
 	u32 sequence;
-	bool streaming;
 };
 
 struct mxc_isi_m2m_ctx {
@@ -236,6 +235,65 @@ static void mxc_isi_m2m_vb2_buffer_queue(struct vb2_buffer *vb2)
 	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
 }
 
+static int mxc_isi_m2m_vb2_prepare_streaming(struct vb2_queue *q)
+{
+	struct mxc_isi_m2m_ctx *ctx = vb2_get_drv_priv(q);
+	const struct v4l2_pix_format_mplane *out_pix = &ctx->queues.out.format;
+	const struct v4l2_pix_format_mplane *cap_pix = &ctx->queues.cap.format;
+	const struct mxc_isi_format_info *cap_info = ctx->queues.cap.info;
+	const struct mxc_isi_format_info *out_info = ctx->queues.out.info;
+	struct mxc_isi_m2m *m2m = ctx->m2m;
+	int ret;
+
+	guard(mutex)(&m2m->lock);
+
+	if (m2m->usage_count == INT_MAX)
+		return -EOVERFLOW;
+
+	/*
+	 * Acquire the pipe and initialize the channel with the first user of
+	 * the M2M device.
+	 */
+	if (m2m->usage_count == 0) {
+		bool bypass = cap_pix->width == out_pix->width &&
+			      cap_pix->height == out_pix->height &&
+			      cap_info->encoding == out_info->encoding;
+
+		ret = mxc_isi_channel_acquire(m2m->pipe,
+					      &mxc_isi_m2m_frame_write_done,
+					      bypass);
+		if (ret)
+			return ret;
+
+		mxc_isi_channel_get(m2m->pipe);
+	}
+
+	m2m->usage_count++;
+
+	/*
+	 * Allocate resources for the channel, counting how many users require
+	 * buffer chaining.
+	 */
+	if (!ctx->chained && out_pix->width > MXC_ISI_MAX_WIDTH_UNCHAINED) {
+		ret = mxc_isi_channel_chain(m2m->pipe);
+		if (ret)
+			goto err_deinit;
+
+		m2m->chained_count++;
+		ctx->chained = true;
+	}
+
+	return 0;
+
+err_deinit:
+	if (--m2m->usage_count == 0) {
+		mxc_isi_channel_put(m2m->pipe);
+		mxc_isi_channel_release(m2m->pipe);
+	}
+
+	return ret;
+}
+
 static int mxc_isi_m2m_vb2_start_streaming(struct vb2_queue *q,
 					   unsigned int count)
 {
@@ -265,6 +323,35 @@ static void mxc_isi_m2m_vb2_stop_streaming(struct vb2_queue *q)
 	}
 }
 
+static void mxc_isi_m2m_vb2_unprepare_streaming(struct vb2_queue *q)
+{
+	struct mxc_isi_m2m_ctx *ctx = vb2_get_drv_priv(q);
+	struct mxc_isi_m2m *m2m = ctx->m2m;
+
+	guard(mutex)(&m2m->lock);
+
+	/*
+	 * If the last context is this one, reset it to make sure the device
+	 * will be reconfigured when streaming is restarted.
+	 */
+	if (m2m->last_ctx == ctx)
+		m2m->last_ctx = NULL;
+
+	/* Free the channel resources if this is the last chained context. */
+	if (ctx->chained && --m2m->chained_count == 0)
+		mxc_isi_channel_unchain(m2m->pipe);
+	ctx->chained = false;
+
+	/* Turn off the light with the last user. */
+	if (--m2m->usage_count == 0) {
+		mxc_isi_channel_disable(m2m->pipe);
+		mxc_isi_channel_put(m2m->pipe);
+		mxc_isi_channel_release(m2m->pipe);
+	}
+
+	WARN_ON(m2m->usage_count < 0);
+}
+
 static const struct vb2_ops mxc_isi_m2m_vb2_qops = {
 	.queue_setup		= mxc_isi_m2m_vb2_queue_setup,
 	.buf_init		= mxc_isi_m2m_vb2_buffer_init,
@@ -272,8 +359,10 @@ static const struct vb2_ops mxc_isi_m2m_vb2_qops = {
 	.buf_queue		= mxc_isi_m2m_vb2_buffer_queue,
 	.wait_prepare		= vb2_ops_wait_prepare,
 	.wait_finish		= vb2_ops_wait_finish,
+	.prepare_streaming	= mxc_isi_m2m_vb2_prepare_streaming,
 	.start_streaming	= mxc_isi_m2m_vb2_start_streaming,
 	.stop_streaming		= mxc_isi_m2m_vb2_stop_streaming,
+	.unprepare_streaming	= mxc_isi_m2m_vb2_unprepare_streaming,
 };
 
 static int mxc_isi_m2m_queue_init(void *priv, struct vb2_queue *src_vq,
@@ -483,136 +572,6 @@ static int mxc_isi_m2m_s_fmt_vid(struct file *file, void *fh,
 	return 0;
 }
 
-static int mxc_isi_m2m_streamon(struct file *file, void *fh,
-				enum v4l2_buf_type type)
-{
-	struct mxc_isi_m2m_ctx *ctx = to_isi_m2m_ctx(fh);
-	struct mxc_isi_m2m_ctx_queue_data *q = mxc_isi_m2m_ctx_qdata(ctx, type);
-	const struct v4l2_pix_format_mplane *out_pix = &ctx->queues.out.format;
-	const struct v4l2_pix_format_mplane *cap_pix = &ctx->queues.cap.format;
-	const struct mxc_isi_format_info *cap_info = ctx->queues.cap.info;
-	const struct mxc_isi_format_info *out_info = ctx->queues.out.info;
-	struct mxc_isi_m2m *m2m = ctx->m2m;
-	bool bypass;
-	int ret;
-
-	if (q->streaming)
-		return 0;
-
-	mutex_lock(&m2m->lock);
-
-	if (m2m->usage_count == INT_MAX) {
-		ret = -EOVERFLOW;
-		goto unlock;
-	}
-
-	bypass = cap_pix->width == out_pix->width &&
-		 cap_pix->height == out_pix->height &&
-		 cap_info->encoding == out_info->encoding;
-
-	/*
-	 * Acquire the pipe and initialize the channel with the first user of
-	 * the M2M device.
-	 */
-	if (m2m->usage_count == 0) {
-		ret = mxc_isi_channel_acquire(m2m->pipe,
-					      &mxc_isi_m2m_frame_write_done,
-					      bypass);
-		if (ret)
-			goto unlock;
-
-		mxc_isi_channel_get(m2m->pipe);
-	}
-
-	m2m->usage_count++;
-
-	/*
-	 * Allocate resources for the channel, counting how many users require
-	 * buffer chaining.
-	 */
-	if (!ctx->chained && out_pix->width > MXC_ISI_MAX_WIDTH_UNCHAINED) {
-		ret = mxc_isi_channel_chain(m2m->pipe, bypass);
-		if (ret)
-			goto deinit;
-
-		m2m->chained_count++;
-		ctx->chained = true;
-	}
-
-	/*
-	 * Drop the lock to start the stream, as the .device_run() operation
-	 * needs to acquire it.
-	 */
-	mutex_unlock(&m2m->lock);
-	ret = v4l2_m2m_ioctl_streamon(file, fh, type);
-	if (ret) {
-		/* Reacquire the lock for the cleanup path. */
-		mutex_lock(&m2m->lock);
-		goto unchain;
-	}
-
-	q->streaming = true;
-
-	return 0;
-
-unchain:
-	if (ctx->chained && --m2m->chained_count == 0)
-		mxc_isi_channel_unchain(m2m->pipe);
-	ctx->chained = false;
-
-deinit:
-	if (--m2m->usage_count == 0) {
-		mxc_isi_channel_put(m2m->pipe);
-		mxc_isi_channel_release(m2m->pipe);
-	}
-
-unlock:
-	mutex_unlock(&m2m->lock);
-	return ret;
-}
-
-static int mxc_isi_m2m_streamoff(struct file *file, void *fh,
-				 enum v4l2_buf_type type)
-{
-	struct mxc_isi_m2m_ctx *ctx = to_isi_m2m_ctx(fh);
-	struct mxc_isi_m2m_ctx_queue_data *q = mxc_isi_m2m_ctx_qdata(ctx, type);
-	struct mxc_isi_m2m *m2m = ctx->m2m;
-
-	v4l2_m2m_ioctl_streamoff(file, fh, type);
-
-	if (!q->streaming)
-		return 0;
-
-	mutex_lock(&m2m->lock);
-
-	/*
-	 * If the last context is this one, reset it to make sure the device
-	 * will be reconfigured when streaming is restarted.
-	 */
-	if (m2m->last_ctx == ctx)
-		m2m->last_ctx = NULL;
-
-	/* Free the channel resources if this is the last chained context. */
-	if (ctx->chained && --m2m->chained_count == 0)
-		mxc_isi_channel_unchain(m2m->pipe);
-	ctx->chained = false;
-
-	/* Turn off the light with the last user. */
-	if (--m2m->usage_count == 0) {
-		mxc_isi_channel_disable(m2m->pipe);
-		mxc_isi_channel_put(m2m->pipe);
-		mxc_isi_channel_release(m2m->pipe);
-	}
-
-	WARN_ON(m2m->usage_count < 0);
-
-	mutex_unlock(&m2m->lock);
-
-	q->streaming = false;
-
-	return 0;
-}
-
 static const struct v4l2_ioctl_ops mxc_isi_m2m_ioctl_ops = {
 	.vidioc_querycap		= mxc_isi_m2m_querycap,
 
@@ -633,8 +592,8 @@ static const struct v4l2_ioctl_ops mxc_isi_m2m_ioctl_ops = {
 	.vidioc_prepare_buf		= v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs		= v4l2_m2m_ioctl_create_bufs,
 
-	.vidioc_streamon		= mxc_isi_m2m_streamon,
-	.vidioc_streamoff		= mxc_isi_m2m_streamoff,
+	.vidioc_streamon		= v4l2_m2m_ioctl_streamon,
+	.vidioc_streamoff		= v4l2_m2m_ioctl_streamoff,
 
 	.vidioc_subscribe_event		= v4l2_ctrl_subscribe_event,
 	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
index 65d20e9bae69..483523327c02 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
@@ -851,7 +851,7 @@ int mxc_isi_pipe_acquire(struct mxc_isi_pipe *pipe,
 
 	/* Chain the channel if needed for wide resolutions. */
 	if (sink_fmt->width > MXC_ISI_MAX_WIDTH_UNCHAINED) {
-		ret = mxc_isi_channel_chain(pipe, bypass);
+		ret = mxc_isi_channel_chain(pipe);
 		if (ret)
 			mxc_isi_channel_release(pipe);
 	}
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index cdb28d6a092c..e5477775992e 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -183,7 +183,7 @@ static void m_can_plat_remove(struct platform_device *pdev)
 	struct m_can_classdev *mcan_class = &priv->cdev;
 
 	m_can_class_unregister(mcan_class);
-
+	pm_runtime_disable(mcan_class->dev);
 	m_can_class_free_dev(mcan_class->net);
 }
 
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index de616d6589c0..9bd61fd8e501 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -286,11 +286,6 @@ struct gs_host_frame {
 #define GS_MAX_RX_URBS 30
 #define GS_NAPI_WEIGHT 32
 
-/* Maximum number of interfaces the driver supports per device.
- * Current hardware only supports 3 interfaces. The future may vary.
- */
-#define GS_MAX_INTF 3
-
 struct gs_tx_context {
 	struct gs_can *dev;
 	unsigned int echo_id;
@@ -321,7 +316,6 @@ struct gs_can {
 
 /* usb interface struct */
 struct gs_usb {
-	struct gs_can *canch[GS_MAX_INTF];
 	struct usb_anchor rx_submitted;
 	struct usb_device *udev;
 
@@ -333,9 +327,11 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 channel_cnt;
 
 	unsigned int pipe_in;
 	unsigned int pipe_out;
+	struct gs_can *canch[] __counted_by(channel_cnt);
 };
 
 /* 'allocate' a tx context.
@@ -596,7 +592,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	/* device reports out of range channel id */
-	if (hf->channel >= GS_MAX_INTF)
+	if (hf->channel >= parent->channel_cnt)
 		goto device_detach;
 
 	dev = parent->canch[hf->channel];
@@ -696,7 +692,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
 device_detach:
-		for (rc = 0; rc < GS_MAX_INTF; rc++) {
+		for (rc = 0; rc < parent->channel_cnt; rc++) {
 			if (parent->canch[rc])
 				netif_device_detach(parent->canch[rc]->netdev);
 		}
@@ -1246,6 +1242,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */
 	netdev->dev_id = channel;
+	netdev->dev_port = channel;
 
 	/* dev setup */
 	strcpy(dev->bt_const.name, KBUILD_MODNAME);
@@ -1457,17 +1454,19 @@ static int gs_usb_probe(struct usb_interface *intf,
 	icount = dconf.icount + 1;
 	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
 
-	if (icount > GS_MAX_INTF) {
+	if (icount > type_max(parent->channel_cnt)) {
 		dev_err(&intf->dev,
 			"Driver cannot handle more that %u CAN interfaces\n",
-			GS_MAX_INTF);
+			type_max(parent->channel_cnt));
 		return -EINVAL;
 	}
 
-	parent = kzalloc(sizeof(*parent), GFP_KERNEL);
+	parent = kzalloc(struct_size(parent, canch, icount), GFP_KERNEL);
 	if (!parent)
 		return -ENOMEM;
 
+	parent->channel_cnt = icount;
+
 	init_usb_anchor(&parent->rx_submitted);
 
 	usb_set_intfdata(intf, parent);
@@ -1528,7 +1527,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		return;
 	}
 
-	for (i = 0; i < GS_MAX_INTF; i++)
+	for (i = 0; i < parent->channel_cnt; i++)
 		if (parent->canch[i])
 			gs_destroy_candev(parent->canch[i]);
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 34d45cebefb5..b4d57da71de2 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1172,7 +1172,6 @@ static void xgbe_free_rx_data(struct xgbe_prv_data *pdata)
 
 static int xgbe_phy_reset(struct xgbe_prv_data *pdata)
 {
-	pdata->phy_link = -1;
 	pdata->phy_speed = SPEED_UNKNOWN;
 
 	return pdata->phy_if.phy_reset(pdata);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 8345d439184e..63012119f2c8 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1664,6 +1664,7 @@ static int xgbe_phy_init(struct xgbe_prv_data *pdata)
 		pdata->phy.duplex = DUPLEX_FULL;
 	}
 
+	pdata->phy_link = 0;
 	pdata->phy.link = 0;
 
 	pdata->phy.pause_autoneg = pdata->pause_autoneg;
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index b3878975bd9c..ea4973096aa2 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -5814,7 +5814,7 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, bool force_reset)
 	u32 current_speed = SPEED_UNKNOWN;
 	u8 current_duplex = DUPLEX_UNKNOWN;
 	bool current_link_up = false;
-	u32 local_adv, remote_adv, sgsr;
+	u32 local_adv = 0, remote_adv = 0, sgsr;
 
 	if ((tg3_asic_rev(tp) == ASIC_REV_5719 ||
 	     tg3_asic_rev(tp) == ASIC_REV_5720) &&
@@ -5955,9 +5955,6 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, bool force_reset)
 		else
 			current_duplex = DUPLEX_HALF;
 
-		local_adv = 0;
-		remote_adv = 0;
-
 		if (bmcr & BMCR_ANENABLE) {
 			u32 common;
 
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 1c3a5cf379cd..72c97dcd0fee 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -498,25 +498,34 @@ static int alloc_list(struct net_device *dev)
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		/* Allocated fixed size of skbuff */
 		struct sk_buff *skb;
+		dma_addr_t addr;
 
 		skb = netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
 		np->rx_skbuff[i] = skb;
-		if (!skb) {
-			free_list(dev);
-			return -ENOMEM;
-		}
+		if (!skb)
+			goto err_free_list;
+
+		addr = dma_map_single(&np->pdev->dev, skb->data,
+				      np->rx_buf_sz, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&np->pdev->dev, addr))
+			goto err_kfree_skb;
 
 		np->rx_ring[i].next_desc = cpu_to_le64(np->rx_ring_dma +
 						((i + 1) % RX_RING_SIZE) *
 						sizeof(struct netdev_desc));
 		/* Rubicon now supports 40 bits of addressing space. */
-		np->rx_ring[i].fraginfo =
-		    cpu_to_le64(dma_map_single(&np->pdev->dev, skb->data,
-					       np->rx_buf_sz, DMA_FROM_DEVICE));
+		np->rx_ring[i].fraginfo = cpu_to_le64(addr);
 		np->rx_ring[i].fraginfo |= cpu_to_le64((u64)np->rx_buf_sz << 48);
 	}
 
 	return 0;
+
+err_kfree_skb:
+	dev_kfree_skb(np->rx_skbuff[i]);
+	np->rx_skbuff[i] = NULL;
+err_free_list:
+	free_list(dev);
+	return -ENOMEM;
 }
 
 static void rio_hw_init(struct net_device *dev)
diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index 5f08779c0e4e..e177d1d58696 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef _IXGBEVF_DEFINES_H_
 #define _IXGBEVF_DEFINES_H_
@@ -16,6 +16,9 @@
 #define IXGBE_DEV_ID_X550_VF_HV		0x1564
 #define IXGBE_DEV_ID_X550EM_X_VF_HV	0x15A9
 
+#define IXGBE_DEV_ID_E610_VF		0x57AD
+#define IXGBE_SUBDEV_ID_E610_VF_HV	0x00FF
+
 #define IXGBE_VF_IRQ_CLEAR_MASK		7
 #define IXGBE_VF_MAX_TX_QUEUES		8
 #define IXGBE_VF_MAX_RX_QUEUES		8
@@ -25,6 +28,7 @@
 
 /* Link speed */
 typedef u32 ixgbe_link_speed;
+#define IXGBE_LINK_SPEED_UNKNOWN	0
 #define IXGBE_LINK_SPEED_1GB_FULL	0x0020
 #define IXGBE_LINK_SPEED_10GB_FULL	0x0080
 #define IXGBE_LINK_SPEED_100_FULL	0x0008
diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index f804b35d79c7..83b3243f172c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -271,6 +271,9 @@ static int ixgbevf_ipsec_add_sa(struct xfrm_state *xs,
 	adapter = netdev_priv(dev);
 	ipsec = adapter->ipsec;
 
+	if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+		return -EOPNOTSUPP;
+
 	if (xs->id.proto != IPPROTO_ESP && xs->id.proto != IPPROTO_AH) {
 		NL_SET_ERR_MSG_MOD(extack, "Unsupported protocol for IPsec offload");
 		return -EINVAL;
@@ -400,6 +403,9 @@ static void ixgbevf_ipsec_del_sa(struct xfrm_state *xs)
 	adapter = netdev_priv(dev);
 	ipsec = adapter->ipsec;
 
+	if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+		return;
+
 	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN) {
 		sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_RX_INDEX;
 
@@ -628,6 +634,10 @@ void ixgbevf_init_ipsec_offload(struct ixgbevf_adapter *adapter)
 	size_t size;
 
 	switch (adapter->hw.api_version) {
+	case ixgbe_mbox_api_17:
+		if (!(adapter->pf_features & IXGBEVF_PF_SUP_IPSEC))
+			return;
+		break;
 	case ixgbe_mbox_api_14:
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 130cb868774c..f31068e24e86 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef _IXGBEVF_H_
 #define _IXGBEVF_H_
@@ -366,6 +366,13 @@ struct ixgbevf_adapter {
 	/* Interrupt Throttle Rate */
 	u32 eitr_param;
 
+	u32 pf_features;
+#define IXGBEVF_PF_SUP_IPSEC		BIT(0)
+#define IXGBEVF_PF_SUP_ESX_MBX		BIT(1)
+
+#define IXGBEVF_SUPPORTED_FEATURES	(IXGBEVF_PF_SUP_IPSEC | \
+					IXGBEVF_PF_SUP_ESX_MBX)
+
 	struct ixgbevf_hw_stats stats;
 
 	unsigned long state;
@@ -418,6 +425,8 @@ enum ixgbevf_boards {
 	board_X550EM_x_vf,
 	board_X550EM_x_vf_hv,
 	board_x550em_a_vf,
+	board_e610_vf,
+	board_e610_vf_hv,
 };
 
 enum ixgbevf_xcast_modes {
@@ -434,11 +443,13 @@ extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_info;
 extern const struct ixgbe_mbx_operations ixgbevf_mbx_ops;
 extern const struct ixgbe_mbx_operations ixgbevf_mbx_ops_legacy;
 extern const struct ixgbevf_info ixgbevf_x550em_a_vf_info;
+extern const struct ixgbevf_info ixgbevf_e610_vf_info;
 
 extern const struct ixgbevf_info ixgbevf_82599_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X540_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_hv_info;
+extern const struct ixgbevf_info ixgbevf_e610_vf_hv_info;
 extern const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops;
 
 /* needed by ethtool.c */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index a44e4bd56142..72b17a0f052c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 /******************************************************************************
  Copyright (c)2006 - 2007 Myricom, Inc. for some LRO specific code
@@ -39,7 +39,7 @@ static const char ixgbevf_driver_string[] =
 	"Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver";
 
 static char ixgbevf_copyright[] =
-	"Copyright (c) 2009 - 2018 Intel Corporation.";
+	"Copyright (c) 2009 - 2024 Intel Corporation.";
 
 static const struct ixgbevf_info *ixgbevf_info_tbl[] = {
 	[board_82599_vf]	= &ixgbevf_82599_vf_info,
@@ -51,6 +51,8 @@ static const struct ixgbevf_info *ixgbevf_info_tbl[] = {
 	[board_X550EM_x_vf]	= &ixgbevf_X550EM_x_vf_info,
 	[board_X550EM_x_vf_hv]	= &ixgbevf_X550EM_x_vf_hv_info,
 	[board_x550em_a_vf]	= &ixgbevf_x550em_a_vf_info,
+	[board_e610_vf]         = &ixgbevf_e610_vf_info,
+	[board_e610_vf_hv]      = &ixgbevf_e610_vf_hv_info,
 };
 
 /* ixgbevf_pci_tbl - PCI Device ID Table
@@ -71,6 +73,9 @@ static const struct pci_device_id ixgbevf_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF), board_X550EM_x_vf },
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF_HV), board_X550EM_x_vf_hv},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_VF), board_x550em_a_vf },
+	{PCI_VDEVICE_SUB(INTEL, IXGBE_DEV_ID_E610_VF, PCI_ANY_ID,
+			 IXGBE_SUBDEV_ID_E610_VF_HV), board_e610_vf_hv},
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_VF), board_e610_vf},
 	/* required last entry */
 	{0, }
 };
@@ -2270,10 +2275,36 @@ static void ixgbevf_init_last_counter_stats(struct ixgbevf_adapter *adapter)
 	adapter->stats.base_vfmprc = adapter->stats.last_vfmprc;
 }
 
+/**
+ * ixgbevf_set_features - Set features supported by PF
+ * @adapter: pointer to the adapter struct
+ *
+ * Negotiate with PF supported features and then set pf_features accordingly.
+ */
+static void ixgbevf_set_features(struct ixgbevf_adapter *adapter)
+{
+	u32 *pf_features = &adapter->pf_features;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int err;
+
+	err = hw->mac.ops.negotiate_features(hw, pf_features);
+	if (err && err != -EOPNOTSUPP)
+		netdev_dbg(adapter->netdev,
+			   "PF feature negotiation failed.\n");
+
+	/* Address also pre API 1.7 cases */
+	if (hw->api_version == ixgbe_mbox_api_14)
+		*pf_features |= IXGBEVF_PF_SUP_IPSEC;
+	else if (hw->api_version == ixgbe_mbox_api_15)
+		*pf_features |= IXGBEVF_PF_SUP_ESX_MBX;
+}
+
 static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	static const int api[] = {
+		ixgbe_mbox_api_17,
+		ixgbe_mbox_api_16,
 		ixgbe_mbox_api_15,
 		ixgbe_mbox_api_14,
 		ixgbe_mbox_api_13,
@@ -2293,7 +2324,9 @@ static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 		idx++;
 	}
 
-	if (hw->api_version >= ixgbe_mbox_api_15) {
+	ixgbevf_set_features(adapter);
+
+	if (adapter->pf_features & IXGBEVF_PF_SUP_ESX_MBX) {
 		hw->mbx.ops.init_params(hw);
 		memcpy(&hw->mbx.ops, &ixgbevf_mbx_ops,
 		       sizeof(struct ixgbe_mbx_operations));
@@ -2650,6 +2683,8 @@ static void ixgbevf_set_num_queues(struct ixgbevf_adapter *adapter)
 		case ixgbe_mbox_api_13:
 		case ixgbe_mbox_api_14:
 		case ixgbe_mbox_api_15:
+		case ixgbe_mbox_api_16:
+		case ixgbe_mbox_api_17:
 			if (adapter->xdp_prog &&
 			    hw->mac.max_tx_queues == rss)
 				rss = rss > 3 ? 2 : 1;
@@ -4644,6 +4679,8 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE -
 				  (ETH_HLEN + ETH_FCS_LEN);
 		break;
@@ -4694,6 +4731,9 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mac_X540_vf:
 		dev_info(&pdev->dev, "Intel(R) X540 Virtual Function\n");
 		break;
+	case ixgbe_mac_e610_vf:
+		dev_info(&pdev->dev, "Intel(R) E610 Virtual Function\n");
+		break;
 	case ixgbe_mac_82599_vf:
 	default:
 		dev_info(&pdev->dev, "Intel(R) 82599 Virtual Function\n");
diff --git a/drivers/net/ethernet/intel/ixgbevf/mbx.h b/drivers/net/ethernet/intel/ixgbevf/mbx.h
index 835bbcc5cc8e..a8ed23ee66aa 100644
--- a/drivers/net/ethernet/intel/ixgbevf/mbx.h
+++ b/drivers/net/ethernet/intel/ixgbevf/mbx.h
@@ -66,6 +66,8 @@ enum ixgbe_pfvf_api_rev {
 	ixgbe_mbox_api_13,	/* API version 1.3, linux/freebsd VF driver */
 	ixgbe_mbox_api_14,	/* API version 1.4, linux/freebsd VF driver */
 	ixgbe_mbox_api_15,	/* API version 1.5, linux/freebsd VF driver */
+	ixgbe_mbox_api_16,      /* API version 1.6, linux/freebsd VF driver */
+	ixgbe_mbox_api_17,	/* API version 1.7, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -102,6 +104,12 @@ enum ixgbe_pfvf_api_rev {
 
 #define IXGBE_VF_GET_LINK_STATE 0x10 /* get vf link state */
 
+/* mailbox API, version 1.6 VF requests */
+#define IXGBE_VF_GET_PF_LINK_STATE	0x11 /* request PF to send link info */
+
+/* mailbox API, version 1.7 VF requests */
+#define IXGBE_VF_FEATURES_NEGOTIATE	0x12 /* get features supported by PF*/
+
 /* length of permanent address message returned from PF */
 #define IXGBE_VF_PERMADDR_MSG_LEN	4
 /* word in permanent address message with the current multicast type */
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 1641d00d8ed3..65257107dfc8 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #include "vf.h"
 #include "ixgbevf.h"
@@ -313,6 +313,8 @@ int ixgbevf_get_reta_locked(struct ixgbe_hw *hw, u32 *reta, int num_rx_queues)
 	 * is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_17:
+	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
@@ -382,6 +384,8 @@ int ixgbevf_get_rss_key_locked(struct ixgbe_hw *hw, u8 *rss_key)
 	 * or if the operation is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_17:
+	case ixgbe_mbox_api_16:
 	case ixgbe_mbox_api_15:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
@@ -552,6 +556,8 @@ static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw, int xcast_mode)
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -624,6 +630,85 @@ static s32 ixgbevf_hv_get_link_state_vf(struct ixgbe_hw *hw, bool *link_state)
 	return -EOPNOTSUPP;
 }
 
+/**
+ * ixgbevf_get_pf_link_state - Get PF's link status
+ * @hw: pointer to the HW structure
+ * @speed: link speed
+ * @link_up: indicate if link is up/down
+ *
+ * Ask PF to provide link_up state and speed of the link.
+ *
+ * Return: IXGBE_ERR_MBX in the case of mailbox error,
+ * -EOPNOTSUPP if the op is not supported or 0 on success.
+ */
+static int ixgbevf_get_pf_link_state(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
+				     bool *link_up)
+{
+	u32 msgbuf[3] = {};
+	int err;
+
+	switch (hw->api_version) {
+	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	msgbuf[0] = IXGBE_VF_GET_PF_LINK_STATE;
+
+	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
+					 ARRAY_SIZE(msgbuf));
+	if (err || (msgbuf[0] & IXGBE_VT_MSGTYPE_FAILURE)) {
+		err = IXGBE_ERR_MBX;
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+		/* No need to set @link_up to false as it will be done by
+		 * ixgbe_check_mac_link_vf().
+		 */
+	} else {
+		*speed = msgbuf[1];
+		*link_up = msgbuf[2];
+	}
+
+	return err;
+}
+
+/**
+ * ixgbevf_negotiate_features_vf - negotiate supported features with PF driver
+ * @hw: pointer to the HW structure
+ * @pf_features: bitmask of features supported by PF
+ *
+ * Return: IXGBE_ERR_MBX in the  case of mailbox error,
+ * -EOPNOTSUPP if the op is not supported or 0 on success.
+ */
+static int ixgbevf_negotiate_features_vf(struct ixgbe_hw *hw, u32 *pf_features)
+{
+	u32 msgbuf[2] = {};
+	int err;
+
+	switch (hw->api_version) {
+	case ixgbe_mbox_api_17:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	msgbuf[0] = IXGBE_VF_FEATURES_NEGOTIATE;
+	msgbuf[1] = IXGBEVF_SUPPORTED_FEATURES;
+
+	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
+					 ARRAY_SIZE(msgbuf));
+
+	if (err || (msgbuf[0] & IXGBE_VT_MSGTYPE_FAILURE)) {
+		err = IXGBE_ERR_MBX;
+		*pf_features = 0x0;
+	} else {
+		*pf_features = msgbuf[1];
+	}
+
+	return err;
+}
+
 /**
  *  ixgbevf_set_vfta_vf - Set/Unset VLAN filter table address
  *  @hw: pointer to the HW structure
@@ -658,6 +743,58 @@ static s32 ixgbevf_set_vfta_vf(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 	return err;
 }
 
+/**
+ * ixgbe_read_vflinks - Read VFLINKS register
+ * @hw: pointer to the HW structure
+ * @speed: link speed
+ * @link_up: indicate if link is up/down
+ *
+ * Get linkup status and link speed from the VFLINKS register.
+ */
+static void ixgbe_read_vflinks(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
+			       bool *link_up)
+{
+	u32 vflinks = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+
+	/* if link status is down no point in checking to see if PF is up */
+	if (!(vflinks & IXGBE_LINKS_UP)) {
+		*link_up = false;
+		return;
+	}
+
+	/* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
+	 * before the link status is correct
+	 */
+	if (hw->mac.type == ixgbe_mac_82599_vf) {
+		for (int i = 0; i < 5; i++) {
+			udelay(100);
+			vflinks = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+
+			if (!(vflinks & IXGBE_LINKS_UP)) {
+				*link_up = false;
+				return;
+			}
+		}
+	}
+
+	/* We reached this point so there's link */
+	*link_up = true;
+
+	switch (vflinks & IXGBE_LINKS_SPEED_82599) {
+	case IXGBE_LINKS_SPEED_10G_82599:
+		*speed = IXGBE_LINK_SPEED_10GB_FULL;
+		break;
+	case IXGBE_LINKS_SPEED_1G_82599:
+		*speed = IXGBE_LINK_SPEED_1GB_FULL;
+		break;
+	case IXGBE_LINKS_SPEED_100_82599:
+		*speed = IXGBE_LINK_SPEED_100_FULL;
+		break;
+	default:
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+	}
+}
+
 /**
  * ixgbevf_hv_set_vfta_vf - * Hyper-V variant - just a stub.
  * @hw: unused
@@ -702,10 +839,10 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 				     bool *link_up,
 				     bool autoneg_wait_to_complete)
 {
+	struct ixgbevf_adapter *adapter = hw->back;
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 	struct ixgbe_mac_info *mac = &hw->mac;
 	s32 ret_val = 0;
-	u32 links_reg;
 	u32 in_msg = 0;
 
 	/* If we were hit with a reset drop the link */
@@ -715,43 +852,21 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 	if (!mac->get_link_status)
 		goto out;
 
-	/* if link status is down no point in checking to see if pf is up */
-	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
-	if (!(links_reg & IXGBE_LINKS_UP))
-		goto out;
-
-	/* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
-	 * before the link status is correct
-	 */
-	if (mac->type == ixgbe_mac_82599_vf) {
-		int i;
-
-		for (i = 0; i < 5; i++) {
-			udelay(100);
-			links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
-
-			if (!(links_reg & IXGBE_LINKS_UP))
-				goto out;
-		}
-	}
-
-	switch (links_reg & IXGBE_LINKS_SPEED_82599) {
-	case IXGBE_LINKS_SPEED_10G_82599:
-		*speed = IXGBE_LINK_SPEED_10GB_FULL;
-		break;
-	case IXGBE_LINKS_SPEED_1G_82599:
-		*speed = IXGBE_LINK_SPEED_1GB_FULL;
-		break;
-	case IXGBE_LINKS_SPEED_100_82599:
-		*speed = IXGBE_LINK_SPEED_100_FULL;
-		break;
+	if (hw->mac.type == ixgbe_mac_e610_vf) {
+		ret_val = ixgbevf_get_pf_link_state(hw, speed, link_up);
+		if (ret_val)
+			goto out;
+	} else {
+		ixgbe_read_vflinks(hw, speed, link_up);
+		if (*link_up == false)
+			goto out;
 	}
 
 	/* if the read failed it could just be a mailbox collision, best wait
 	 * until we are called again and don't report an error
 	 */
 	if (mbx->ops.read(hw, &in_msg, 1)) {
-		if (hw->api_version >= ixgbe_mbox_api_15)
+		if (adapter->pf_features & IXGBEVF_PF_SUP_ESX_MBX)
 			mac->get_link_status = false;
 		goto out;
 	}
@@ -951,6 +1066,8 @@ int ixgbevf_get_queues(struct ixgbe_hw *hw, unsigned int *num_tcs,
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
+	case ixgbe_mbox_api_17:
 		break;
 	default:
 		return 0;
@@ -1005,6 +1122,7 @@ static const struct ixgbe_mac_operations ixgbevf_mac_ops = {
 	.setup_link		= ixgbevf_setup_mac_link_vf,
 	.check_link		= ixgbevf_check_mac_link_vf,
 	.negotiate_api_version	= ixgbevf_negotiate_api_version_vf,
+	.negotiate_features	= ixgbevf_negotiate_features_vf,
 	.set_rar		= ixgbevf_set_rar_vf,
 	.update_mc_addr_list	= ixgbevf_update_mc_addr_list_vf,
 	.update_xcast_mode	= ixgbevf_update_xcast_mode,
@@ -1076,3 +1194,13 @@ const struct ixgbevf_info ixgbevf_x550em_a_vf_info = {
 	.mac = ixgbe_mac_x550em_a_vf,
 	.mac_ops = &ixgbevf_mac_ops,
 };
+
+const struct ixgbevf_info ixgbevf_e610_vf_info = {
+	.mac                    = ixgbe_mac_e610_vf,
+	.mac_ops                = &ixgbevf_mac_ops,
+};
+
+const struct ixgbevf_info ixgbevf_e610_vf_hv_info = {
+	.mac            = ixgbe_mac_e610_vf,
+	.mac_ops        = &ixgbevf_hv_mac_ops,
+};
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.h b/drivers/net/ethernet/intel/ixgbevf/vf.h
index b4eef5b6c172..4f19b8900c29 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef __IXGBE_VF_H__
 #define __IXGBE_VF_H__
@@ -26,6 +26,7 @@ struct ixgbe_mac_operations {
 	s32 (*stop_adapter)(struct ixgbe_hw *);
 	s32 (*get_bus_info)(struct ixgbe_hw *);
 	s32 (*negotiate_api_version)(struct ixgbe_hw *hw, int api);
+	int (*negotiate_features)(struct ixgbe_hw *hw, u32 *pf_features);
 
 	/* Link */
 	s32 (*setup_link)(struct ixgbe_hw *, ixgbe_link_speed, bool, bool);
@@ -54,6 +55,8 @@ enum ixgbe_mac_type {
 	ixgbe_mac_X550_vf,
 	ixgbe_mac_X550EM_x_vf,
 	ixgbe_mac_x550em_a_vf,
+	ixgbe_mac_e610,
+	ixgbe_mac_e610_vf,
 	ixgbe_num_macs
 };
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5af932a5e70c..3b90f257e94f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4919,8 +4919,9 @@ static int rtl8169_resume(struct device *device)
 	if (!device_may_wakeup(tp_to_dev(tp)))
 		clk_prepare_enable(tp->clk);
 
-	/* Reportedly at least Asus X453MA truncates packets otherwise */
-	if (tp->mac_version == RTL_GIGA_MAC_VER_37)
+	/* Some chip versions may truncate packets without this initialization */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_37 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_46)
 		rtl_init_rxcfg(tp);
 
 	return rtl8169_runtime_resume(device);
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index ec5689cd240a..121f1c15c679 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1940,13 +1940,19 @@ static const struct ethtool_ops lan78xx_ethtool_ops = {
 	.get_regs	= lan78xx_get_regs,
 };
 
-static void lan78xx_init_mac_address(struct lan78xx_net *dev)
+static int lan78xx_init_mac_address(struct lan78xx_net *dev)
 {
 	u32 addr_lo, addr_hi;
 	u8 addr[6];
+	int ret;
+
+	ret = lan78xx_read_reg(dev, RX_ADDRL, &addr_lo);
+	if (ret < 0)
+		return ret;
 
-	lan78xx_read_reg(dev, RX_ADDRL, &addr_lo);
-	lan78xx_read_reg(dev, RX_ADDRH, &addr_hi);
+	ret = lan78xx_read_reg(dev, RX_ADDRH, &addr_hi);
+	if (ret < 0)
+		return ret;
 
 	addr[0] = addr_lo & 0xFF;
 	addr[1] = (addr_lo >> 8) & 0xFF;
@@ -1979,14 +1985,26 @@ static void lan78xx_init_mac_address(struct lan78xx_net *dev)
 			  (addr[2] << 16) | (addr[3] << 24);
 		addr_hi = addr[4] | (addr[5] << 8);
 
-		lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
-		lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+		ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+		if (ret < 0)
+			return ret;
 	}
 
-	lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
-	lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
+	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
+	if (ret < 0)
+		return ret;
 
 	eth_hw_addr_set(dev->net, addr);
+
+	return 0;
 }
 
 /* MDIO read and write wrappers for phylib */
@@ -2910,8 +2928,6 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		}
 	} while (buf & HW_CFG_LRST_);
 
-	lan78xx_init_mac_address(dev);
-
 	/* save DEVID for later usage */
 	ret = lan78xx_read_reg(dev, ID_REV, &buf);
 	if (ret < 0)
@@ -2920,6 +2936,10 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	dev->chipid = (buf & ID_REV_CHIP_ID_MASK_) >> 16;
 	dev->chiprev = buf & ID_REV_CHIP_REV_MASK_;
 
+	ret = lan78xx_init_mac_address(dev);
+	if (ret < 0)
+		return ret;
+
 	/* Respond to the IN token with a NAK */
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
 	if (ret < 0)
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 1e85cfe524e8..386376ceeda2 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10104,7 +10104,12 @@ static int __init rtl8152_driver_init(void)
 	ret = usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
 	if (ret)
 		return ret;
-	return usb_register(&rtl8152_driver);
+
+	ret = usb_register(&rtl8152_driver);
+	if (ret)
+		usb_deregister_device_driver(&rtl8152_cfgselector_driver);
+
+	return ret;
 }
 
 static void __exit rtl8152_driver_exit(void)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 119afdfe4b91..57416bbf9344 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -131,12 +131,14 @@ void nvme_mpath_start_request(struct request *rq)
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns->head->disk;
 
-	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
+	if ((READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) &&
+	    !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
 		atomic_inc(&ns->ctrl->nr_active);
 		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
 	}
 
-	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
+	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
+	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index f76a358e2b5b..753a4c615781 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -48,6 +48,7 @@ enum link_status {
 #define J721E_MODE_RC			BIT(7)
 #define LANE_COUNT(n)			((n) << 8)
 
+#define ACSPCIE_PAD_DISABLE_MASK	GENMASK(1, 0)
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
 
 struct j721e_pcie {
@@ -225,6 +226,36 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 	return ret;
 }
 
+static int j721e_enable_acspcie_refclk(struct j721e_pcie *pcie,
+				       struct regmap *syscon)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+	struct device_node *node = dev->of_node;
+	u32 mask = ACSPCIE_PAD_DISABLE_MASK;
+	struct of_phandle_args args;
+	u32 val;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(node,
+					       "ti,syscon-acspcie-proxy-ctrl",
+					       1, 0, &args);
+	if (ret) {
+		dev_err(dev,
+			"ti,syscon-acspcie-proxy-ctrl has invalid arguments\n");
+		return ret;
+	}
+
+	/* Clear PAD IO disable bits to enable refclk output */
+	val = ~(args.args[0]);
+	ret = regmap_update_bits(syscon, 0, mask, val);
+	if (ret) {
+		dev_err(dev, "failed to enable ACSPCIE refclk: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 {
 	struct device *dev = pcie->cdns_pcie->dev;
@@ -246,6 +277,25 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 	if (!ret)
 		offset = args.args[0];
 
+	/*
+	 * The PCIe Controller's registers have different "reset-values"
+	 * depending on the "strap" settings programmed into the PCIEn_CTRL
+	 * register within the CTRL_MMR memory-mapped register space.
+	 * The registers latch onto a "reset-value" based on the "strap"
+	 * settings sampled after the PCIe Controller is powered on.
+	 * To ensure that the "reset-values" are sampled accurately, power
+	 * off the PCIe Controller before programming the "strap" settings
+	 * and power it on after that. The runtime PM APIs namely
+	 * pm_runtime_put_sync() and pm_runtime_get_sync() will decrement and
+	 * increment the usage counter respectively, causing GENPD to power off
+	 * and power on the PCIe Controller.
+	 */
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power off PCIe Controller\n");
+		return ret;
+	}
+
 	ret = j721e_pcie_set_mode(pcie, syscon, offset);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set pci mode\n");
@@ -264,7 +314,19 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return ret;
 	}
 
-	return 0;
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power on PCIe Controller\n");
+		return ret;
+	}
+
+	/* Enable ACSPCIE refclk output if the optional property exists */
+	syscon = syscon_regmap_lookup_by_phandle_optional(node,
+						"ti,syscon-acspcie-proxy-ctrl");
+	if (!syscon)
+		return 0;
+
+	return j721e_enable_acspcie_refclk(pcie, syscon);
 }
 
 static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index c7d3e248a59a..ce2a7a6dab90 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1963,6 +1963,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void tegra_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+};
+
 static int tegra_pcie_ep_raise_legacy_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
 	/* Tegra194 supports only INTA */
@@ -2036,6 +2045,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.ep_init = tegra_pcie_ep_init,
 	.raise_irq = tegra_pcie_ep_raise_irq,
 	.get_features = tegra_pcie_ep_get_features,
 };
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 449d42744d33..300caafcfa10 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -186,9 +186,15 @@ static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
+
+	/* We read PCI_EXP_LNKCAP, so we need the device to be accessible. */
+	pci_config_pm_runtime_get(pdev);
+	ret = sysfs_emit(buf, "%s\n",
+			 pci_speed_string(pcie_get_speed_cap(pdev)));
+	pci_config_pm_runtime_put(pdev);
 
-	return sysfs_emit(buf, "%s\n",
-			  pci_speed_string(pcie_get_speed_cap(pdev)));
+	return ret;
 }
 static DEVICE_ATTR_RO(max_link_speed);
 
diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index dddb66de6dba..8d93a830ab8b 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -30,6 +30,7 @@
 
 #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
 #define DPHY_CMN_SSM_EN			BIT(0)
+#define DPHY_CMN_SSM_CAL_WAIT_TIME	GENMASK(8, 1)
 #define DPHY_CMN_TX_MODE_EN		BIT(9)
 
 #define DPHY_CMN_PWM			DPHY_PMA_CMN(0x40)
@@ -79,6 +80,7 @@ struct cdns_dphy_cfg {
 	u8 pll_ipdiv;
 	u8 pll_opdiv;
 	u16 pll_fbdiv;
+	u32 hs_clk_rate;
 	unsigned int nlanes;
 };
 
@@ -99,6 +101,8 @@ struct cdns_dphy_ops {
 	void (*set_pll_cfg)(struct cdns_dphy *dphy,
 			    const struct cdns_dphy_cfg *cfg);
 	unsigned long (*get_wakeup_time_ns)(struct cdns_dphy *dphy);
+	int (*wait_for_pll_lock)(struct cdns_dphy *dphy);
+	int (*wait_for_cmn_ready)(struct cdns_dphy *dphy);
 };
 
 struct cdns_dphy {
@@ -108,6 +112,8 @@ struct cdns_dphy {
 	struct clk *pll_ref_clk;
 	const struct cdns_dphy_ops *ops;
 	struct phy *phy;
+	bool is_configured;
+	bool is_powered;
 };
 
 /* Order of bands is important since the index is the band number. */
@@ -154,6 +160,9 @@ static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
 					  cfg->pll_ipdiv,
 					  pll_ref_hz);
 
+	cfg->hs_clk_rate = div_u64((u64)pll_ref_hz * cfg->pll_fbdiv,
+				   2 * cfg->pll_opdiv * cfg->pll_ipdiv);
+
 	return 0;
 }
 
@@ -191,6 +200,16 @@ static unsigned long cdns_dphy_get_wakeup_time_ns(struct cdns_dphy *dphy)
 	return dphy->ops->get_wakeup_time_ns(dphy);
 }
 
+static int cdns_dphy_wait_for_pll_lock(struct cdns_dphy *dphy)
+{
+	return dphy->ops->wait_for_pll_lock ? dphy->ops->wait_for_pll_lock(dphy) : 0;
+}
+
+static int cdns_dphy_wait_for_cmn_ready(struct cdns_dphy *dphy)
+{
+	return  dphy->ops->wait_for_cmn_ready ? dphy->ops->wait_for_cmn_ready(dphy) : 0;
+}
+
 static unsigned long cdns_dphy_ref_get_wakeup_time_ns(struct cdns_dphy *dphy)
 {
 	/* Default wakeup time is 800 ns (in a simulated environment). */
@@ -232,7 +251,6 @@ static unsigned long cdns_dphy_j721e_get_wakeup_time_ns(struct cdns_dphy *dphy)
 static void cdns_dphy_j721e_set_pll_cfg(struct cdns_dphy *dphy,
 					const struct cdns_dphy_cfg *cfg)
 {
-	u32 status;
 
 	/*
 	 * set the PWM and PLL Byteclk divider settings to recommended values
@@ -249,13 +267,6 @@ static void cdns_dphy_j721e_set_pll_cfg(struct cdns_dphy *dphy,
 
 	writel(DPHY_TX_J721E_WIZ_LANE_RSTB,
 	       dphy->regs + DPHY_TX_J721E_WIZ_RST_CTRL);
-
-	readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_PLL_CTRL, status,
-			   (status & DPHY_TX_WIZ_PLL_LOCK), 0, POLL_TIMEOUT_US);
-
-	readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_STATUS, status,
-			   (status & DPHY_TX_WIZ_O_CMN_READY), 0,
-			   POLL_TIMEOUT_US);
 }
 
 static void cdns_dphy_j721e_set_psm_div(struct cdns_dphy *dphy, u8 div)
@@ -263,6 +274,23 @@ static void cdns_dphy_j721e_set_psm_div(struct cdns_dphy *dphy, u8 div)
 	writel(div, dphy->regs + DPHY_TX_J721E_WIZ_PSM_FREQ);
 }
 
+static int cdns_dphy_j721e_wait_for_pll_lock(struct cdns_dphy *dphy)
+{
+	u32 status;
+
+	return readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_PLL_CTRL, status,
+			       status & DPHY_TX_WIZ_PLL_LOCK, 0, POLL_TIMEOUT_US);
+}
+
+static int cdns_dphy_j721e_wait_for_cmn_ready(struct cdns_dphy *dphy)
+{
+	u32 status;
+
+	return readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_STATUS, status,
+			       status & DPHY_TX_WIZ_O_CMN_READY, 0,
+			       POLL_TIMEOUT_US);
+}
+
 /*
  * This is the reference implementation of DPHY hooks. Specific integration of
  * this IP may have to re-implement some of them depending on how they decided
@@ -278,6 +306,8 @@ static const struct cdns_dphy_ops j721e_dphy_ops = {
 	.get_wakeup_time_ns = cdns_dphy_j721e_get_wakeup_time_ns,
 	.set_pll_cfg = cdns_dphy_j721e_set_pll_cfg,
 	.set_psm_div = cdns_dphy_j721e_set_psm_div,
+	.wait_for_pll_lock = cdns_dphy_j721e_wait_for_pll_lock,
+	.wait_for_cmn_ready = cdns_dphy_j721e_wait_for_cmn_ready,
 };
 
 static int cdns_dphy_config_from_opts(struct phy *phy,
@@ -297,6 +327,7 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
 	if (ret)
 		return ret;
 
+	opts->hs_clk_rate = cfg->hs_clk_rate;
 	opts->wakeup = cdns_dphy_get_wakeup_time_ns(dphy) / 1000;
 
 	return 0;
@@ -334,21 +365,36 @@ static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
 static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
-	struct cdns_dphy_cfg cfg = { 0 };
-	int ret, band_ctrl;
-	unsigned int reg;
+	int ret;
 
-	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
-	if (ret)
-		return ret;
+	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &dphy->cfg);
+	if (!ret)
+		dphy->is_configured = true;
+
+	return ret;
+}
+
+static int cdns_dphy_power_on(struct phy *phy)
+{
+	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	int ret;
+	u32 reg;
+
+	if (!dphy->is_configured || dphy->is_powered)
+		return -EINVAL;
+
+	clk_prepare_enable(dphy->psm_clk);
+	clk_prepare_enable(dphy->pll_ref_clk);
 
 	/*
 	 * Configure the internal PSM clk divider so that the DPHY has a
 	 * 1MHz clk (or something close).
 	 */
 	ret = cdns_dphy_setup_psm(dphy);
-	if (ret)
-		return ret;
+	if (ret) {
+		dev_err(&dphy->phy->dev, "Failed to setup PSM with error %d\n", ret);
+		goto err_power_on;
+	}
 
 	/*
 	 * Configure attach clk lanes to data lanes: the DPHY has 2 clk lanes
@@ -363,40 +409,61 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	 * Configure the DPHY PLL that will be used to generate the TX byte
 	 * clk.
 	 */
-	cdns_dphy_set_pll_cfg(dphy, &cfg);
+	cdns_dphy_set_pll_cfg(dphy, &dphy->cfg);
 
-	band_ctrl = cdns_dphy_tx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
-	if (band_ctrl < 0)
-		return band_ctrl;
+	ret = cdns_dphy_tx_get_band_ctrl(dphy->cfg.hs_clk_rate);
+	if (ret < 0) {
+		dev_err(&dphy->phy->dev, "Failed to get band control value with error %d\n", ret);
+		goto err_power_on;
+	}
 
-	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, band_ctrl) |
-	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
+	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, ret) |
+	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, ret);
 	writel(reg, dphy->regs + DPHY_BAND_CFG);
 
-	return 0;
-}
+	/* Start TX state machine. */
+	reg = readl(dphy->regs + DPHY_CMN_SSM);
+	writel((reg & DPHY_CMN_SSM_CAL_WAIT_TIME) | DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
+	       dphy->regs + DPHY_CMN_SSM);
 
-static int cdns_dphy_power_on(struct phy *phy)
-{
-	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	ret = cdns_dphy_wait_for_pll_lock(dphy);
+	if (ret) {
+		dev_err(&dphy->phy->dev, "Failed to lock PLL with error %d\n", ret);
+		goto err_power_on;
+	}
 
-	clk_prepare_enable(dphy->psm_clk);
-	clk_prepare_enable(dphy->pll_ref_clk);
+	ret = cdns_dphy_wait_for_cmn_ready(dphy);
+	if (ret) {
+		dev_err(&dphy->phy->dev, "O_CMN_READY signal failed to assert with error %d\n",
+			ret);
+		goto err_power_on;
+	}
 
-	/* Start TX state machine. */
-	writel(DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
-	       dphy->regs + DPHY_CMN_SSM);
+	dphy->is_powered = true;
 
 	return 0;
+
+err_power_on:
+	clk_disable_unprepare(dphy->pll_ref_clk);
+	clk_disable_unprepare(dphy->psm_clk);
+
+	return ret;
 }
 
 static int cdns_dphy_power_off(struct phy *phy)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	u32 reg;
 
 	clk_disable_unprepare(dphy->pll_ref_clk);
 	clk_disable_unprepare(dphy->psm_clk);
 
+	/* Stop TX state machine. */
+	reg = readl(dphy->regs + DPHY_CMN_SSM);
+	writel(reg & ~DPHY_CMN_SSM_EN, dphy->regs + DPHY_CMN_SSM);
+
+	dphy->is_powered = false;
+
 	return 0;
 }
 
diff --git a/drivers/usb/gadget/function/f_acm.c b/drivers/usb/gadget/function/f_acm.c
index f616059c5e1e..a1adfd077c15 100644
--- a/drivers/usb/gadget/function/f_acm.c
+++ b/drivers/usb/gadget/function/f_acm.c
@@ -11,12 +11,15 @@
 
 /* #define VERBOSE_DEBUG */
 
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/err.h>
 
+#include <linux/usb/gadget.h>
+
 #include "u_serial.h"
 
 
@@ -612,6 +615,7 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_string	*us;
 	int			status;
 	struct usb_ep		*ep;
+	struct usb_request	*request __free(free_usb_request) = NULL;
 
 	/* REVISIT might want instance-specific strings to help
 	 * distinguish instances ...
@@ -629,7 +633,7 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs, and patch descriptors */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	acm->ctrl_id = status;
 	acm_iad_descriptor.bFirstInterface = status;
 
@@ -638,40 +642,38 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	acm->data_id = status;
 
 	acm_data_interface_desc.bInterfaceNumber = status;
 	acm_union_desc.bSlaveInterface0 = status;
 	acm_call_mgmt_descriptor.bDataInterface = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &acm_fs_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	acm->port.in = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &acm_fs_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	acm->port.out = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &acm_fs_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	acm->notify = ep;
 
 	/* allocate notification */
-	acm->notify_req = gs_alloc_req(ep,
-			sizeof(struct usb_cdc_notification) + 2,
-			GFP_KERNEL);
-	if (!acm->notify_req)
-		goto fail;
+	request = gs_alloc_req(ep,
+			       sizeof(struct usb_cdc_notification) + 2,
+			       GFP_KERNEL);
+	if (!request)
+		return -ENODEV;
 
-	acm->notify_req->complete = acm_cdc_notify_complete;
-	acm->notify_req->context = acm;
+	request->complete = acm_cdc_notify_complete;
+	request->context = acm;
 
 	/* support all relevant hardware speeds... we expect that when
 	 * hardware is dual speed, all bulk-capable endpoints work at
@@ -688,7 +690,9 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, acm_fs_function, acm_hs_function,
 			acm_ss_function, acm_ss_function);
 	if (status)
-		goto fail;
+		return status;
+
+	acm->notify_req = no_free_ptr(request);
 
 	dev_dbg(&cdev->gadget->dev,
 		"acm ttyGS%d: IN/%s OUT/%s NOTIFY/%s\n",
@@ -696,14 +700,6 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 		acm->port.in->name, acm->port.out->name,
 		acm->notify->name);
 	return 0;
-
-fail:
-	if (acm->notify_req)
-		gs_free_req(acm->notify, acm->notify_req);
-
-	ERROR(cdev, "%s/%p: can't bind, err %d\n", f->name, f, status);
-
-	return status;
 }
 
 static void acm_unbind(struct usb_configuration *c, struct usb_function *f)
diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index 2afc30de54ce..7bb63b9e3f78 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -8,12 +8,15 @@
 
 /* #define VERBOSE_DEBUG */
 
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/etherdevice.h>
 
+#include <linux/usb/gadget.h>
+
 #include "u_ether.h"
 #include "u_ether_configfs.h"
 #include "u_ecm.h"
@@ -678,6 +681,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 
 	struct f_ecm_opts	*ecm_opts;
+	struct usb_request	*request __free(free_usb_request) = NULL;
 
 	if (!can_support_ecm(cdev->gadget))
 		return -EINVAL;
@@ -711,7 +715,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ecm->ctrl_id = status;
 	ecm_iad_descriptor.bFirstInterface = status;
 
@@ -720,24 +724,22 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ecm->data_id = status;
 
 	ecm_data_nop_intf.bInterfaceNumber = status;
 	ecm_data_intf.bInterfaceNumber = status;
 	ecm_union_desc.bSlaveInterface0 = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ecm_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ecm->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ecm_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ecm->port.out_ep = ep;
 
 	/* NOTE:  a status/notification endpoint is *OPTIONAL* but we
@@ -746,20 +748,18 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	 */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ecm_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ecm->notify = ep;
 
-	status = -ENOMEM;
-
 	/* allocate notification request and buffer */
-	ecm->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
-	if (!ecm->notify_req)
-		goto fail;
-	ecm->notify_req->buf = kmalloc(ECM_STATUS_BYTECOUNT, GFP_KERNEL);
-	if (!ecm->notify_req->buf)
-		goto fail;
-	ecm->notify_req->context = ecm;
-	ecm->notify_req->complete = ecm_notify_complete;
+	request = usb_ep_alloc_request(ep, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	request->buf = kmalloc(ECM_STATUS_BYTECOUNT, GFP_KERNEL);
+	if (!request->buf)
+		return -ENOMEM;
+	request->context = ecm;
+	request->complete = ecm_notify_complete;
 
 	/* support all relevant hardware speeds... we expect that when
 	 * hardware is dual speed, all bulk-capable endpoints work at
@@ -778,7 +778,7 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, ecm_fs_function, ecm_hs_function,
 			ecm_ss_function, ecm_ss_function);
 	if (status)
-		goto fail;
+		return status;
 
 	/* NOTE:  all that is done without knowing or caring about
 	 * the network link ... which is unavailable to this code
@@ -788,20 +788,12 @@ ecm_bind(struct usb_configuration *c, struct usb_function *f)
 	ecm->port.open = ecm_open;
 	ecm->port.close = ecm_close;
 
+	ecm->notify_req = no_free_ptr(request);
+
 	DBG(cdev, "CDC Ethernet: IN/%s OUT/%s NOTIFY/%s\n",
 			ecm->port.in_ep->name, ecm->port.out_ep->name,
 			ecm->notify->name);
 	return 0;
-
-fail:
-	if (ecm->notify_req) {
-		kfree(ecm->notify_req->buf);
-		usb_ep_free_request(ecm->notify, ecm->notify_req);
-	}
-
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 static inline struct f_ecm_opts *to_f_ecm_opts(struct config_item *item)
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index f5731d465cd7..7aad737901e8 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2008 Nokia Corporation
  */
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -19,6 +20,7 @@
 #include <linux/crc32.h>
 
 #include <linux/usb/cdc.h>
+#include <linux/usb/gadget.h>
 
 #include "u_ether.h"
 #include "u_ether_configfs.h"
@@ -1422,18 +1424,18 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 	struct f_ncm_opts	*ncm_opts;
 
+	struct usb_os_desc_table	*os_desc_table __free(kfree) = NULL;
+	struct usb_request		*request __free(free_usb_request) = NULL;
+
 	if (!can_support_ecm(cdev->gadget))
 		return -EINVAL;
 
 	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
 
 	if (cdev->use_os_string) {
-		f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
-					   GFP_KERNEL);
-		if (!f->os_desc_table)
+		os_desc_table = kzalloc(sizeof(*os_desc_table), GFP_KERNEL);
+		if (!os_desc_table)
 			return -ENOMEM;
-		f->os_desc_n = 1;
-		f->os_desc_table[0].os_desc = &ncm_opts->ncm_os_desc;
 	}
 
 	mutex_lock(&ncm_opts->lock);
@@ -1443,16 +1445,15 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	mutex_unlock(&ncm_opts->lock);
 
 	if (status)
-		goto fail;
+		return status;
 
 	ncm_opts->bound = true;
 
 	us = usb_gstrings_attach(cdev, ncm_strings,
 				 ARRAY_SIZE(ncm_string_defs));
-	if (IS_ERR(us)) {
-		status = PTR_ERR(us);
-		goto fail;
-	}
+	if (IS_ERR(us))
+		return PTR_ERR(us);
+
 	ncm_control_intf.iInterface = us[STRING_CTRL_IDX].id;
 	ncm_data_nop_intf.iInterface = us[STRING_DATA_IDX].id;
 	ncm_data_intf.iInterface = us[STRING_DATA_IDX].id;
@@ -1462,55 +1463,47 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ncm->ctrl_id = status;
 	ncm_iad_desc.bFirstInterface = status;
 
 	ncm_control_intf.bInterfaceNumber = status;
 	ncm_union_desc.bMasterInterface0 = status;
 
-	if (cdev->use_os_string)
-		f->os_desc_table[0].if_id =
-			ncm_iad_desc.bFirstInterface;
-
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	ncm->data_id = status;
 
 	ncm_data_nop_intf.bInterfaceNumber = status;
 	ncm_data_intf.bInterfaceNumber = status;
 	ncm_union_desc.bSlaveInterface0 = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ncm->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ncm->port.out_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	ncm->notify = ep;
 
-	status = -ENOMEM;
-
 	/* allocate notification request and buffer */
-	ncm->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
-	if (!ncm->notify_req)
-		goto fail;
-	ncm->notify_req->buf = kmalloc(NCM_STATUS_BYTECOUNT, GFP_KERNEL);
-	if (!ncm->notify_req->buf)
-		goto fail;
-	ncm->notify_req->context = ncm;
-	ncm->notify_req->complete = ncm_notify_complete;
+	request = usb_ep_alloc_request(ep, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	request->buf = kmalloc(NCM_STATUS_BYTECOUNT, GFP_KERNEL);
+	if (!request->buf)
+		return -ENOMEM;
+	request->context = ncm;
+	request->complete = ncm_notify_complete;
 
 	/*
 	 * support all relevant hardware speeds... we expect that when
@@ -1530,7 +1523,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, ncm_fs_function, ncm_hs_function,
 			ncm_ss_function, ncm_ss_function);
 	if (status)
-		goto fail;
+		return status;
 
 	/*
 	 * NOTE:  all that is done without knowing or caring about
@@ -1544,23 +1537,18 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	hrtimer_init(&ncm->task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	ncm->task_timer.function = ncm_tx_timeout;
 
+	if (cdev->use_os_string) {
+		os_desc_table[0].os_desc = &ncm_opts->ncm_os_desc;
+		os_desc_table[0].if_id = ncm_iad_desc.bFirstInterface;
+		f->os_desc_table = no_free_ptr(os_desc_table);
+		f->os_desc_n = 1;
+	}
+	ncm->notify_req = no_free_ptr(request);
+
 	DBG(cdev, "CDC Network: IN/%s OUT/%s NOTIFY/%s\n",
 			ncm->port.in_ep->name, ncm->port.out_ep->name,
 			ncm->notify->name);
 	return 0;
-
-fail:
-	kfree(f->os_desc_table);
-	f->os_desc_n = 0;
-
-	if (ncm->notify_req) {
-		kfree(ncm->notify_req->buf);
-		usb_ep_free_request(ncm->notify, ncm->notify_req);
-	}
-
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 static inline struct f_ncm_opts *to_f_ncm_opts(struct config_item *item)
diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index b47f99d17ee9..ef7e734511ab 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -19,6 +19,8 @@
 
 #include <linux/atomic.h>
 
+#include <linux/usb/gadget.h>
+
 #include "u_ether.h"
 #include "u_ether_configfs.h"
 #include "u_rndis.h"
@@ -662,6 +664,8 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 
 	struct f_rndis_opts *rndis_opts;
+	struct usb_os_desc_table        *os_desc_table __free(kfree) = NULL;
+	struct usb_request		*request __free(free_usb_request) = NULL;
 
 	if (!can_support_rndis(c))
 		return -EINVAL;
@@ -669,12 +673,9 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	rndis_opts = container_of(f->fi, struct f_rndis_opts, func_inst);
 
 	if (cdev->use_os_string) {
-		f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
-					   GFP_KERNEL);
-		if (!f->os_desc_table)
+		os_desc_table = kzalloc(sizeof(*os_desc_table), GFP_KERNEL);
+		if (!os_desc_table)
 			return -ENOMEM;
-		f->os_desc_n = 1;
-		f->os_desc_table[0].os_desc = &rndis_opts->rndis_os_desc;
 	}
 
 	rndis_iad_descriptor.bFunctionClass = rndis_opts->class;
@@ -692,16 +693,14 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 		gether_set_gadget(rndis_opts->net, cdev->gadget);
 		status = gether_register_netdev(rndis_opts->net);
 		if (status)
-			goto fail;
+			return status;
 		rndis_opts->bound = true;
 	}
 
 	us = usb_gstrings_attach(cdev, rndis_strings,
 				 ARRAY_SIZE(rndis_string_defs));
-	if (IS_ERR(us)) {
-		status = PTR_ERR(us);
-		goto fail;
-	}
+	if (IS_ERR(us))
+		return PTR_ERR(us);
 	rndis_control_intf.iInterface = us[0].id;
 	rndis_data_intf.iInterface = us[1].id;
 	rndis_iad_descriptor.iFunction = us[2].id;
@@ -709,36 +708,30 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific interface IDs */
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	rndis->ctrl_id = status;
 	rndis_iad_descriptor.bFirstInterface = status;
 
 	rndis_control_intf.bInterfaceNumber = status;
 	rndis_union_desc.bMasterInterface0 = status;
 
-	if (cdev->use_os_string)
-		f->os_desc_table[0].if_id =
-			rndis_iad_descriptor.bFirstInterface;
-
 	status = usb_interface_id(c, f);
 	if (status < 0)
-		goto fail;
+		return status;
 	rndis->data_id = status;
 
 	rndis_data_intf.bInterfaceNumber = status;
 	rndis_union_desc.bSlaveInterface0 = status;
 
-	status = -ENODEV;
-
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_in_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	rndis->port.in_ep = ep;
 
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_out_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	rndis->port.out_ep = ep;
 
 	/* NOTE:  a status/notification endpoint is, strictly speaking,
@@ -747,21 +740,19 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	 */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_notify_desc);
 	if (!ep)
-		goto fail;
+		return -ENODEV;
 	rndis->notify = ep;
 
-	status = -ENOMEM;
-
 	/* allocate notification request and buffer */
-	rndis->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
-	if (!rndis->notify_req)
-		goto fail;
-	rndis->notify_req->buf = kmalloc(STATUS_BYTECOUNT, GFP_KERNEL);
-	if (!rndis->notify_req->buf)
-		goto fail;
-	rndis->notify_req->length = STATUS_BYTECOUNT;
-	rndis->notify_req->context = rndis;
-	rndis->notify_req->complete = rndis_response_complete;
+	request = usb_ep_alloc_request(ep, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	request->buf = kmalloc(STATUS_BYTECOUNT, GFP_KERNEL);
+	if (!request->buf)
+		return -ENOMEM;
+	request->length = STATUS_BYTECOUNT;
+	request->context = rndis;
+	request->complete = rndis_response_complete;
 
 	/* support all relevant hardware speeds... we expect that when
 	 * hardware is dual speed, all bulk-capable endpoints work at
@@ -778,7 +769,7 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_assign_descriptors(f, eth_fs_function, eth_hs_function,
 			eth_ss_function, eth_ss_function);
 	if (status)
-		goto fail;
+		return status;
 
 	rndis->port.open = rndis_open;
 	rndis->port.close = rndis_close;
@@ -789,9 +780,18 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 	if (rndis->manufacturer && rndis->vendorID &&
 			rndis_set_param_vendor(rndis->params, rndis->vendorID,
 					       rndis->manufacturer)) {
-		status = -EINVAL;
-		goto fail_free_descs;
+		usb_free_all_descriptors(f);
+		return -EINVAL;
+	}
+
+	if (cdev->use_os_string) {
+		os_desc_table[0].os_desc = &rndis_opts->rndis_os_desc;
+		os_desc_table[0].if_id = rndis_iad_descriptor.bFirstInterface;
+		f->os_desc_table = no_free_ptr(os_desc_table);
+		f->os_desc_n = 1;
+
 	}
+	rndis->notify_req = no_free_ptr(request);
 
 	/* NOTE:  all that is done without knowing or caring about
 	 * the network link ... which is unavailable to this code
@@ -802,21 +802,6 @@ rndis_bind(struct usb_configuration *c, struct usb_function *f)
 			rndis->port.in_ep->name, rndis->port.out_ep->name,
 			rndis->notify->name);
 	return 0;
-
-fail_free_descs:
-	usb_free_all_descriptors(f);
-fail:
-	kfree(f->os_desc_table);
-	f->os_desc_n = 0;
-
-	if (rndis->notify_req) {
-		kfree(rndis->notify_req->buf);
-		usb_ep_free_request(rndis->notify, rndis->notify_req);
-	}
-
-	ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
-
-	return status;
 }
 
 void rndis_borrow_net(struct usb_function_instance *f, struct net_device *net)
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index a4120a25428e..25bbb7a440ce 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -194,6 +194,9 @@ struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
 
 	req = ep->ops->alloc_request(ep, gfp_flags);
 
+	if (req)
+		req->ep = ep;
+
 	trace_usb_ep_alloc_request(ep, req, req ? 0 : -ENOMEM);
 
 	return req;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 88ba277bc3a7..2d6ccc21a822 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -985,7 +985,7 @@ static void btrfs_readahead_expand(struct readahead_control *ractl,
 {
 	const u64 ra_pos = readahead_pos(ractl);
 	const u64 ra_end = ra_pos + readahead_length(ractl);
-	const u64 em_end = em->start + em->ram_bytes;
+	const u64 em_end = em->start + em->len;
 
 	/* No expansion for holes and inline extents. */
 	if (em->block_start > EXTENT_MAP_LAST_BYTE)
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 8efe3a9369df..1fb635a99976 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1108,14 +1108,15 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	 * If ret is 1 (no key found), it means this is an empty block group,
 	 * without any extents allocated from it and there's no block group
 	 * item (key BTRFS_BLOCK_GROUP_ITEM_KEY) located in the extent tree
-	 * because we are using the block group tree feature, so block group
-	 * items are stored in the block group tree. It also means there are no
-	 * extents allocated for block groups with a start offset beyond this
-	 * block group's end offset (this is the last, highest, block group).
+	 * because we are using the block group tree feature (so block group
+	 * items are stored in the block group tree) or this is a new block
+	 * group created in the current transaction and its block group item
+	 * was not yet inserted in the extent tree (that happens in
+	 * btrfs_create_pending_block_groups() -> insert_block_group_item()).
+	 * It also means there are no extents allocated for block groups with a
+	 * start offset beyond this block group's end offset (this is the last,
+	 * highest, block group).
 	 */
-	if (!btrfs_fs_compat_ro(trans->fs_info, BLOCK_GROUP_TREE))
-		ASSERT(ret == 0);
-
 	start = block_group->start;
 	end = block_group->start + block_group->length;
 	while (ret == 0) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8cc1f4b83277..b21b5e0f8905 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3877,6 +3877,7 @@ static noinline_for_stack struct inode *create_reloc_inode(
 /*
  * Mark start of chunk relocation that is cancellable. Check if the cancellation
  * has been requested meanwhile and don't start in that case.
+ * NOTE: if this returns an error, reloc_chunk_end() must not be called.
  *
  * Return:
  *   0             success
@@ -3893,10 +3894,8 @@ static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
 
 	if (atomic_read(&fs_info->reloc_cancel_req) > 0) {
 		btrfs_info(fs_info, "chunk relocation canceled on start");
-		/*
-		 * On cancel, clear all requests but let the caller mark
-		 * the end after cleanup operations.
-		 */
+		/* On cancel, clear all requests. */
+		clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags);
 		atomic_set(&fs_info->reloc_cancel_req, 0);
 		return -ECANCELED;
 	}
@@ -3905,9 +3904,11 @@ static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
 
 /*
  * Mark end of chunk relocation that is cancellable and wake any waiters.
+ * NOTE: call only if a previous call to reloc_chunk_start() succeeded.
  */
 static void reloc_chunk_end(struct btrfs_fs_info *fs_info)
 {
+	ASSERT(test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags));
 	/* Requested after start, clear bit first so any waiters can continue */
 	if (atomic_read(&fs_info->reloc_cancel_req) > 0)
 		btrfs_info(fs_info, "chunk relocation canceled during operation");
@@ -4119,9 +4120,9 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 	if (err && rw)
 		btrfs_dec_block_group_ro(rc->block_group);
 	iput(rc->data_inode);
+	reloc_chunk_end(fs_info);
 out_put_bg:
 	btrfs_put_block_group(bg);
-	reloc_chunk_end(fs_info);
 	free_reloc_control(rc);
 	return err;
 }
@@ -4311,8 +4312,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		err = ret;
 out_unset:
 	unset_reloc_control(rc);
-out_end:
 	reloc_chunk_end(fs_info);
+out_end:
 	free_reloc_control(rc);
 out:
 	free_reloc_roots(&reloc_roots);
diff --git a/fs/dax.c b/fs/dax.c
index 8c09578fa035..e1451efaab14 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1578,7 +1578,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iov_iter_rw(iter) == WRITE) {
 		lockdep_assert_held_write(&iomi.inode->i_rwsem);
 		iomi.flags |= IOMAP_WRITE;
-	} else {
+	} else if (!sb_rdonly(iomi.inode->i_sb)) {
 		lockdep_assert_held(&iomi.inode->i_rwsem);
 	}
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 4030c010a768..74d49b2b3b6e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1861,6 +1861,8 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	__dget_dlock(parent);
 	dentry->d_parent = parent;
 	list_add(&dentry->d_child, &parent->d_subdirs);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		dentry->d_flags |= DCACHE_DISCONNECTED;
 	spin_unlock(&parent->d_lock);
 
 	return dentry;
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 6b2d655c1cef..1e80a9b1d126 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -45,10 +45,10 @@
  *
  * 1) epnested_mutex (mutex)
  * 2) ep->mtx (mutex)
- * 3) ep->lock (rwlock)
+ * 3) ep->lock (spinlock)
  *
  * The acquire order is the one listed above, from 1 to 3.
- * We need a rwlock (ep->lock) because we manipulate objects
+ * We need a spinlock (ep->lock) because we manipulate objects
  * from inside the poll callback, that might be triggered from
  * a wake_up() that in turn might be called from IRQ context.
  * So we can't sleep inside the poll callback and hence we need
@@ -194,7 +194,7 @@ struct eventpoll {
 	struct list_head rdllist;
 
 	/* Lock which protects rdllist and ovflist */
-	rwlock_t lock;
+	spinlock_t lock;
 
 	/* RB tree root used to store monitored fd structs */
 	struct rb_root_cached rbr;
@@ -206,7 +206,7 @@ struct eventpoll {
 	 */
 	struct epitem *ovflist;
 
-	/* wakeup_source used when ep_scan_ready_list is running */
+	/* wakeup_source used when ep_send_events or __ep_eventpoll_poll is running */
 	struct wakeup_source *ws;
 
 	/* The user that created the eventpoll descriptor */
@@ -625,10 +625,10 @@ static void ep_start_scan(struct eventpoll *ep, struct list_head *txlist)
 	 * in a lockless way.
 	 */
 	lockdep_assert_irqs_enabled();
-	write_lock_irq(&ep->lock);
+	spin_lock_irq(&ep->lock);
 	list_splice_init(&ep->rdllist, txlist);
 	WRITE_ONCE(ep->ovflist, NULL);
-	write_unlock_irq(&ep->lock);
+	spin_unlock_irq(&ep->lock);
 }
 
 static void ep_done_scan(struct eventpoll *ep,
@@ -636,7 +636,7 @@ static void ep_done_scan(struct eventpoll *ep,
 {
 	struct epitem *epi, *nepi;
 
-	write_lock_irq(&ep->lock);
+	spin_lock_irq(&ep->lock);
 	/*
 	 * During the time we spent inside the "sproc" callback, some
 	 * other events might have been queued by the poll callback.
@@ -677,7 +677,7 @@ static void ep_done_scan(struct eventpoll *ep,
 			wake_up(&ep->wq);
 	}
 
-	write_unlock_irq(&ep->lock);
+	spin_unlock_irq(&ep->lock);
 }
 
 static void epi_rcu_free(struct rcu_head *head)
@@ -757,10 +757,10 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
-	write_lock_irq(&ep->lock);
+	spin_lock_irq(&ep->lock);
 	if (ep_is_linked(epi))
 		list_del_init(&epi->rdllink);
-	write_unlock_irq(&ep->lock);
+	spin_unlock_irq(&ep->lock);
 
 	wakeup_source_unregister(ep_wakeup_source(epi));
 	/*
@@ -1018,7 +1018,7 @@ static int ep_alloc(struct eventpoll **pep)
 		return -ENOMEM;
 
 	mutex_init(&ep->mtx);
-	rwlock_init(&ep->lock);
+	spin_lock_init(&ep->lock);
 	init_waitqueue_head(&ep->wq);
 	init_waitqueue_head(&ep->poll_wait);
 	INIT_LIST_HEAD(&ep->rdllist);
@@ -1105,100 +1105,10 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
 }
 #endif /* CONFIG_KCMP */
 
-/*
- * Adds a new entry to the tail of the list in a lockless way, i.e.
- * multiple CPUs are allowed to call this function concurrently.
- *
- * Beware: it is necessary to prevent any other modifications of the
- *         existing list until all changes are completed, in other words
- *         concurrent list_add_tail_lockless() calls should be protected
- *         with a read lock, where write lock acts as a barrier which
- *         makes sure all list_add_tail_lockless() calls are fully
- *         completed.
- *
- *        Also an element can be locklessly added to the list only in one
- *        direction i.e. either to the tail or to the head, otherwise
- *        concurrent access will corrupt the list.
- *
- * Return: %false if element has been already added to the list, %true
- * otherwise.
- */
-static inline bool list_add_tail_lockless(struct list_head *new,
-					  struct list_head *head)
-{
-	struct list_head *prev;
-
-	/*
-	 * This is simple 'new->next = head' operation, but cmpxchg()
-	 * is used in order to detect that same element has been just
-	 * added to the list from another CPU: the winner observes
-	 * new->next == new.
-	 */
-	if (!try_cmpxchg(&new->next, &new, head))
-		return false;
-
-	/*
-	 * Initially ->next of a new element must be updated with the head
-	 * (we are inserting to the tail) and only then pointers are atomically
-	 * exchanged.  XCHG guarantees memory ordering, thus ->next should be
-	 * updated before pointers are actually swapped and pointers are
-	 * swapped before prev->next is updated.
-	 */
-
-	prev = xchg(&head->prev, new);
-
-	/*
-	 * It is safe to modify prev->next and new->prev, because a new element
-	 * is added only to the tail and new->next is updated before XCHG.
-	 */
-
-	prev->next = new;
-	new->prev = prev;
-
-	return true;
-}
-
-/*
- * Chains a new epi entry to the tail of the ep->ovflist in a lockless way,
- * i.e. multiple CPUs are allowed to call this function concurrently.
- *
- * Return: %false if epi element has been already chained, %true otherwise.
- */
-static inline bool chain_epi_lockless(struct epitem *epi)
-{
-	struct eventpoll *ep = epi->ep;
-
-	/* Fast preliminary check */
-	if (epi->next != EP_UNACTIVE_PTR)
-		return false;
-
-	/* Check that the same epi has not been just chained from another CPU */
-	if (cmpxchg(&epi->next, EP_UNACTIVE_PTR, NULL) != EP_UNACTIVE_PTR)
-		return false;
-
-	/* Atomically exchange tail */
-	epi->next = xchg(&ep->ovflist, epi);
-
-	return true;
-}
-
 /*
  * This is the callback that is passed to the wait queue wakeup
  * mechanism. It is called by the stored file descriptors when they
  * have events to report.
- *
- * This callback takes a read lock in order not to contend with concurrent
- * events from another file descriptor, thus all modifications to ->rdllist
- * or ->ovflist are lockless.  Read lock is paired with the write lock from
- * ep_scan_ready_list(), which stops all list modifications and guarantees
- * that lists state is seen correctly.
- *
- * Another thing worth to mention is that ep_poll_callback() can be called
- * concurrently for the same @epi from different CPUs if poll table was inited
- * with several wait queues entries.  Plural wakeup from different CPUs of a
- * single wait queue is serialized by wq.lock, but the case when multiple wait
- * queues are used should be detected accordingly.  This is detected using
- * cmpxchg() operation.
  */
 static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
 {
@@ -1209,7 +1119,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	unsigned long flags;
 	int ewake = 0;
 
-	read_lock_irqsave(&ep->lock, flags);
+	spin_lock_irqsave(&ep->lock, flags);
 
 	ep_set_busy_poll_napi_id(epi);
 
@@ -1238,12 +1148,15 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	 * chained in ep->ovflist and requeued later on.
 	 */
 	if (READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR) {
-		if (chain_epi_lockless(epi))
+		if (epi->next == EP_UNACTIVE_PTR) {
+			epi->next = READ_ONCE(ep->ovflist);
+			WRITE_ONCE(ep->ovflist, epi);
 			ep_pm_stay_awake_rcu(epi);
+		}
 	} else if (!ep_is_linked(epi)) {
 		/* In the usual case, add event to ready list. */
-		if (list_add_tail_lockless(&epi->rdllink, &ep->rdllist))
-			ep_pm_stay_awake_rcu(epi);
+		list_add_tail(&epi->rdllink, &ep->rdllist);
+		ep_pm_stay_awake_rcu(epi);
 	}
 
 	/*
@@ -1276,7 +1189,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 		pwake++;
 
 out_unlock:
-	read_unlock_irqrestore(&ep->lock, flags);
+	spin_unlock_irqrestore(&ep->lock, flags);
 
 	/* We have to call this outside the lock */
 	if (pwake)
@@ -1611,7 +1524,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	}
 
 	/* We have to drop the new item inside our item list to keep track of it */
-	write_lock_irq(&ep->lock);
+	spin_lock_irq(&ep->lock);
 
 	/* record NAPI ID of new item if present */
 	ep_set_busy_poll_napi_id(epi);
@@ -1628,7 +1541,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 			pwake++;
 	}
 
-	write_unlock_irq(&ep->lock);
+	spin_unlock_irq(&ep->lock);
 
 	/* We have to call this outside the lock */
 	if (pwake)
@@ -1692,7 +1605,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 * list, push it inside.
 	 */
 	if (ep_item_poll(epi, &pt, 1)) {
-		write_lock_irq(&ep->lock);
+		spin_lock_irq(&ep->lock);
 		if (!ep_is_linked(epi)) {
 			list_add_tail(&epi->rdllink, &ep->rdllist);
 			ep_pm_stay_awake(epi);
@@ -1703,7 +1616,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 			if (waitqueue_active(&ep->poll_wait))
 				pwake++;
 		}
-		write_unlock_irq(&ep->lock);
+		spin_unlock_irq(&ep->lock);
 	}
 
 	/* We have to call this outside the lock */
@@ -1792,7 +1705,7 @@ static int ep_send_events(struct eventpoll *ep,
 			 * availability. At this point, no one can insert
 			 * into ep->rdllist besides us. The epoll_ctl()
 			 * callers are locked out by
-			 * ep_scan_ready_list() holding "mtx" and the
+			 * ep_send_events() holding "mtx" and the
 			 * poll callback will queue them in ep->ovflist.
 			 */
 			list_add_tail(&epi->rdllink, &ep->rdllist);
@@ -1936,7 +1849,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		init_wait(&wait);
 		wait.func = ep_autoremove_wake_function;
 
-		write_lock_irq(&ep->lock);
+		spin_lock_irq(&ep->lock);
 		/*
 		 * Barrierless variant, waitqueue_active() is called under
 		 * the same lock on wakeup ep_poll_callback() side, so it
@@ -1945,7 +1858,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		__set_current_state(TASK_INTERRUPTIBLE);
 
 		/*
-		 * Do the final check under the lock. ep_scan_ready_list()
+		 * Do the final check under the lock. ep_start/done_scan()
 		 * plays with two lists (->rdllist and ->ovflist) and there
 		 * is always a race when both lists are empty for short
 		 * period of time although events are pending, so lock is
@@ -1955,7 +1868,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		if (!eavail)
 			__add_wait_queue_exclusive(&ep->wq, &wait);
 
-		write_unlock_irq(&ep->lock);
+		spin_unlock_irq(&ep->lock);
 
 		if (!eavail)
 			timed_out = !schedule_hrtimeout_range(to, slack,
@@ -1970,7 +1883,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		eavail = 1;
 
 		if (!list_empty_careful(&wait.entry)) {
-			write_lock_irq(&ep->lock);
+			spin_lock_irq(&ep->lock);
 			/*
 			 * If the thread timed out and is not on the wait queue,
 			 * it means that the thread was woken up after its
@@ -1981,7 +1894,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			if (timed_out)
 				eavail = list_empty(&wait.entry);
 			__remove_wait_queue(&ep->wq, &wait);
-			write_unlock_irq(&ep->lock);
+			spin_unlock_irq(&ep->lock);
 		}
 	}
 }
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index d1a2e6624401..32f59295cfa0 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -277,9 +277,16 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 		  bh, is_metadata, inode->i_mode,
 		  test_opt(inode->i_sb, DATA_FLAGS));
 
-	/* In the no journal case, we can just do a bforget and return */
+	/*
+	 * In the no journal case, we should wait for the ongoing buffer
+	 * to complete and do a forget.
+	 */
 	if (!ext4_handle_valid(handle)) {
-		bforget(bh);
+		if (bh) {
+			clear_buffer_dirty(bh);
+			wait_on_buffer(bh);
+			__bforget(bh);
+		}
 		return 0;
 	}
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 91a9fa6f1ad4..563cd0726424 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4944,6 +4944,14 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 	ext4_set_inode_flags(inode, true);
+	/* Detect invalid flag combination - can't have both inline data and extents */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
+	    ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_error_inode(inode, function, line, 0,
+			"inode has both inline data and extents flags");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
 	inode->i_blocks = ext4_inode_blocks(raw_inode, ei);
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl_lo);
 	if (ext4_has_feature_64bit(sb))
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 527f53bfe1b1..16a6c249580e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2506,7 +2506,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 					struct ext4_fs_context *m_ctx)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *s_mount_opts = NULL;
+	char s_mount_opts[65];
 	struct ext4_fs_context *s_ctx = NULL;
 	struct fs_context *fc = NULL;
 	int ret = -ENOMEM;
@@ -2514,15 +2514,11 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
-	s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
-				sizeof(sbi->s_es->s_mount_opts),
-				GFP_KERNEL);
-	if (!s_mount_opts)
-		return ret;
+	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts, sizeof(s_mount_opts));
 
 	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-		goto out_free;
+		return -ENOMEM;
 
 	s_ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
 	if (!s_ctx)
@@ -2554,11 +2550,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	ret = 0;
 
 out_free:
-	if (fc) {
-		ext4_fc_free(fc);
-		kfree(fc);
-	}
-	kfree(s_mount_opts);
+	ext4_fc_free(fc);
+	kfree(fc);
 	return ret;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fe23ebfc88ea..f5252f3e840a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1506,8 +1506,8 @@ static bool f2fs_map_blocks_cached(struct inode *inode,
 		struct f2fs_dev_info *dev = &sbi->devs[bidx];
 
 		map->m_bdev = dev->bdev;
-		map->m_pblk -= dev->start_blk;
 		map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);
+		map->m_pblk -= dev->start_blk;
 	} else {
 		map->m_bdev = inode->i_sb->s_bdev;
 	}
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 36b6cf2a3abb..ebd326799f35 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -40,6 +40,18 @@ int hfsplus_strcasecmp(const struct hfsplus_unistr *s1,
 	p1 = s1->unicode;
 	p2 = s2->unicode;
 
+	if (len1 > HFSPLUS_MAX_STRLEN) {
+		len1 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s1->length), len1);
+	}
+
+	if (len2 > HFSPLUS_MAX_STRLEN) {
+		len2 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s2->length), len2);
+	}
+
 	while (1) {
 		c1 = c2 = 0;
 
@@ -74,6 +86,18 @@ int hfsplus_strcmp(const struct hfsplus_unistr *s1,
 	p1 = s1->unicode;
 	p2 = s2->unicode;
 
+	if (len1 > HFSPLUS_MAX_STRLEN) {
+		len1 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s1->length), len1);
+	}
+
+	if (len2 > HFSPLUS_MAX_STRLEN) {
+		len2 = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(s2->length), len2);
+	}
+
 	for (len = min(len1, len2); len > 0; len--) {
 		c1 = be16_to_cpu(*p1);
 		c2 = be16_to_cpu(*p2);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index c2b8ad0b24c4..82bd29c17085 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1649,6 +1649,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 	int drop_reserve = 0;
 	int err = 0;
 	int was_modified = 0;
+	int wait_for_writeback = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -1772,18 +1773,22 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 		}
 
 		/*
-		 * The buffer is still not written to disk, we should
-		 * attach this buffer to current transaction so that the
-		 * buffer can be checkpointed only after the current
-		 * transaction commits.
+		 * The buffer has not yet been written to disk. We should
+		 * either clear the buffer or ensure that the ongoing I/O
+		 * is completed, and attach this buffer to current
+		 * transaction so that the buffer can be checkpointed only
+		 * after the current transaction commits.
 		 */
 		clear_buffer_dirty(bh);
+		wait_for_writeback = 1;
 		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
 		spin_unlock(&journal->j_list_lock);
 	}
 drop:
 	__brelse(bh);
 	spin_unlock(&jh->b_state_lock);
+	if (wait_for_writeback)
+		wait_on_buffer(bh);
 	jbd2_journal_put_journal_head(jh);
 	if (drop_reserve) {
 		/* no need to reserve log space for this block -bzzz */
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 01d7fd108cf3..59f119cce3dc 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -117,7 +117,6 @@ static __be32
 nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct iattr iattr = { .ia_valid = 0 };
 	int error;
 
@@ -127,9 +126,9 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
 	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
 
-	if (new_size > i_size_read(inode)) {
+	if (lcp->lc_size_chg) {
 		iattr.ia_valid |= ATTR_SIZE;
-		iattr.ia_size = new_size;
+		iattr.ia_size = lcp->lc_newsize;
 	}
 
 	error = inode->i_sb->s_export_op->commit_blocks(inode, iomaps,
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 1ed2f691ebb9..dd35c472eb37 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -29,8 +29,7 @@ nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(len);
 	*p++ = cpu_to_be32(1);		/* we always return a single extent */
 
-	p = xdr_encode_opaque_fixed(p, &b->vol_id,
-			sizeof(struct nfsd4_deviceid));
+	p = svcxdr_encode_deviceid4(p, &b->vol_id);
 	p = xdr_encode_hyper(p, b->foff);
 	p = xdr_encode_hyper(p, b->len);
 	p = xdr_encode_hyper(p, b->soff);
@@ -145,9 +144,7 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
 
-		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
-		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
-
+		p = svcxdr_decode_deviceid4(p, &bex.vol_id);
 		p = xdr_decode_hyper(p, &bex.foff);
 		if (bex.foff & (block_size - 1)) {
 			dprintk("%s: unaligned offset 0x%llx\n",
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 4b5d998cbc2f..f4e77859aa85 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1071,28 +1071,62 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 	return exp;
 }
 
-__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
+/**
+ * check_xprtsec_policy - check if access to export is allowed by the
+ * 			  xprtsec policy
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp.
+ *
+ * Helper function for check_nfsd_access().  Note that callers should be
+ * using check_nfsd_access() instead of calling this function directly.  The
+ * one exception is fh_verify() since it has logic that may result in one
+ * or both of the helpers being skipped.
+ *
+ * Return values:
+ *   %nfs_ok if access is granted, or
+ *   %nfserr_acces or %nfserr_wrongsec if access is denied
+ */
+__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
 {
-	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
 	struct svc_xprt *xprt = rqstp->rq_xprt;
 
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
 		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
-			goto ok;
+			return nfs_ok;
 	}
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_TLS) {
 		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
 		    !test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
-			goto ok;
+			return nfs_ok;
 	}
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_MTLS) {
 		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
 		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
-			goto ok;
+			return nfs_ok;
 	}
-	goto denied;
 
-ok:
+	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
+}
+
+/**
+ * check_security_flavor - check if access to export is allowed by the
+ * 			  xprtsec policy
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp.
+ *
+ * Helper function for check_nfsd_access().  Note that callers should be
+ * using check_nfsd_access() instead of calling this function directly.  The
+ * one exception is fh_verify() since it has logic that may result in one
+ * or both of the helpers being skipped.
+ *
+ * Return values:
+ *   %nfs_ok if access is granted, or
+ *   %nfserr_acces or %nfserr_wrongsec if access is denied
+ */
+__be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp)
+{
+	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
+
 	/* legacy gss-only clients are always OK: */
 	if (exp->ex_client == rqstp->rq_gssclient)
 		return 0;
@@ -1117,10 +1151,20 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 	if (nfsd4_spo_must_allow(rqstp))
 		return 0;
 
-denied:
 	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
 }
 
+__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
+{
+	__be32 status;
+
+	status = check_xprtsec_policy(exp, rqstp);
+	if (status != nfs_ok)
+		return status;
+
+	return check_security_flavor(exp, rqstp);
+}
+
 /*
  * Uses rq_client and rq_gssclient to find an export; uses rq_client (an
  * auth_unix client) if it's available and has secinfo information;
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index ca9dc230ae3d..4a48b2ad5606 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -100,6 +100,8 @@ struct svc_expkey {
 #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
 
 int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
+__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp);
+__be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp);
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
 
 /*
diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 3ca5304440ff..0bc52e6bec39 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -125,6 +125,13 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, struct svc_rqst *rqstp,
 	return 0;
 }
 
+static __be32
+nfsd4_ff_proc_layoutcommit(struct inode *inode,
+		struct nfsd4_layoutcommit *lcp)
+{
+	return nfs_ok;
+}
+
 const struct nfsd4_layout_ops ff_layout_ops = {
 	.notify_types		=
 			NOTIFY_DEVICEID4_DELETE | NOTIFY_DEVICEID4_CHANGE,
@@ -133,4 +140,5 @@ const struct nfsd4_layout_ops ff_layout_ops = {
 	.encode_getdeviceinfo	= nfsd4_ff_encode_getdeviceinfo,
 	.proc_layoutget		= nfsd4_ff_proc_layoutget,
 	.encode_layoutget	= nfsd4_ff_encode_layoutget,
+	.proc_layoutcommit	= nfsd4_ff_proc_layoutcommit,
 };
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index bb205328e043..223a10f37898 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -54,8 +54,7 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(1);			/* single mirror */
 	*p++ = cpu_to_be32(1);			/* single data server */
 
-	p = xdr_encode_opaque_fixed(p, &fl->deviceid,
-			sizeof(struct nfsd4_deviceid));
+	p = svcxdr_encode_deviceid4(p, &fl->deviceid);
 
 	*p++ = cpu_to_be32(1);			/* efficiency */
 
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index e8a80052cb1b..308214378fd3 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -120,7 +120,6 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 	id->fsid_idx = fhp->fh_export->ex_devid_map->idx;
 	id->generation = device_generation;
-	id->pad = 0;
 	return 0;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e9c1271b7ecc..836367d839bd 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2308,7 +2308,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_seg *seg = &lcp->lc_seg;
 	struct svc_fh *current_fh = &cstate->current_fh;
 	const struct nfsd4_layout_ops *ops;
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct inode *inode;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
@@ -2324,18 +2323,20 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		goto out;
 	inode = d_inode(current_fh->fh_dentry);
 
-	nfserr = nfserr_inval;
-	if (new_size <= seg->offset) {
-		dprintk("pnfsd: last write before layout segment\n");
-		goto out;
-	}
-	if (new_size > seg->offset + seg->length) {
-		dprintk("pnfsd: last write beyond layout segment\n");
-		goto out;
-	}
-	if (!lcp->lc_newoffset && new_size > i_size_read(inode)) {
-		dprintk("pnfsd: layoutcommit beyond EOF\n");
-		goto out;
+	lcp->lc_size_chg = false;
+	if (lcp->lc_newoffset) {
+		loff_t new_size = lcp->lc_last_wr + 1;
+
+		nfserr = nfserr_inval;
+		if (new_size <= seg->offset)
+			goto out;
+		if (new_size > seg->offset + seg->length)
+			goto out;
+
+		if (new_size > i_size_read(inode)) {
+			lcp->lc_size_chg = true;
+			lcp->lc_newsize = new_size;
+		}
 	}
 
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
@@ -2352,13 +2353,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	/* LAYOUTCOMMIT does not require any serialization */
 	mutex_unlock(&ls->ls_mutex);
 
-	if (new_size > i_size_read(inode)) {
-		lcp->lc_size_chg = 1;
-		lcp->lc_newsize = new_size;
-	} else {
-		lcp->lc_size_chg = 0;
-	}
-
 	nfserr = ops->proc_layoutcommit(inode, lcp);
 	nfs4_put_stid(&ls->ls_stid);
 out:
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 76dfbb99277f..3eff780fd8da 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -566,18 +566,6 @@ nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
 }
 
 #ifdef CONFIG_NFSD_PNFS
-static __be32
-nfsd4_decode_deviceid4(struct nfsd4_compoundargs *argp,
-		       struct nfsd4_deviceid *devid)
-{
-	__be32 *p;
-
-	p = xdr_inline_decode(argp->xdr, NFS4_DEVICEID4_SIZE);
-	if (!p)
-		return nfserr_bad_xdr;
-	memcpy(devid, p, sizeof(*devid));
-	return nfs_ok;
-}
 
 static __be32
 nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
@@ -1733,7 +1721,7 @@ nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 	__be32 status;
 
 	memset(gdev, 0, sizeof(*gdev));
-	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
+	status = nfsd4_decode_deviceid4(argp->xdr, &gdev->gd_devid);
 	if (status)
 		return status;
 	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_layout_type) < 0)
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c2495d98c189..283c1a60c846 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -370,6 +370,16 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	if (error)
 		goto out;
 
+	/*
+	 * NLM is allowed to bypass the xprtsec policy check because lockd
+	 * doesn't support xprtsec.
+	 */
+	if (!(access & NFSD_MAY_LOCK)) {
+		error = check_xprtsec_policy(exp, rqstp);
+		if (error)
+			goto out;
+	}
+
 	/*
 	 * pseudoflavor restrictions are not enforced on NLM,
 	 * which clients virtually always use auth_sys for,
@@ -386,7 +396,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 			&& exp->ex_path.dentry == dentry)
 		goto skip_pseudoflavor_check;
 
-	error = check_nfsd_access(exp, rqstp);
+	error = check_security_flavor(exp, rqstp);
 	if (error)
 		goto out;
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 144e05efd14c..a83a52b0f518 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -459,9 +459,43 @@ struct nfsd4_reclaim_complete {
 struct nfsd4_deviceid {
 	u64			fsid_idx;
 	u32			generation;
-	u32			pad;
 };
 
+static inline __be32 *
+svcxdr_encode_deviceid4(__be32 *p, const struct nfsd4_deviceid *devid)
+{
+	__be64 *q = (__be64 *)p;
+
+	*q = (__force __be64)devid->fsid_idx;
+	p += 2;
+	*p++ = (__force __be32)devid->generation;
+	*p++ = xdr_zero;
+	return p;
+}
+
+static inline __be32 *
+svcxdr_decode_deviceid4(__be32 *p, struct nfsd4_deviceid *devid)
+{
+	__be64 *q = (__be64 *)p;
+
+	devid->fsid_idx = (__force u64)(*q);
+	p += 2;
+	devid->generation = (__force u32)(*p++);
+	p++; /* NFSD does not use the remaining octets */
+	return p;
+}
+
+static inline __be32
+nfsd4_decode_deviceid4(struct xdr_stream *xdr, struct nfsd4_deviceid *devid)
+{
+	__be32 *p = xdr_inline_decode(xdr, NFS4_DEVICEID4_SIZE);
+
+	if (unlikely(!p))
+		return nfserr_bad_xdr;
+	svcxdr_decode_deviceid4(p, devid);
+	return nfs_ok;
+}
+
 struct nfsd4_layout_seg {
 	u32			iomode;
 	u64			offset;
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index be41e26b7824..05fdbbc63e1f 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -680,8 +680,6 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 	int blocksize;
 	int err;
 
-	down_write(&nilfs->ns_sem);
-
 	blocksize = sb_min_blocksize(sb, NILFS_MIN_BLOCK_SIZE);
 	if (!blocksize) {
 		nilfs_err(sb, "unable to set blocksize");
@@ -757,7 +755,6 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 	set_nilfs_init(nilfs);
 	err = 0;
  out:
-	up_write(&nilfs->ns_sem);
 	return err;
 
  failed_sbh:
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index e585e77cdc88..18dba873a163 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1571,15 +1571,13 @@ static int __init ocfs2_init(void)
 
 	ocfs2_set_locking_protocol();
 
-	status = register_quota_format(&ocfs2_quota_format);
-	if (status < 0)
-		goto out3;
+	register_quota_format(&ocfs2_quota_format);
+
 	status = register_filesystem(&ocfs2_fs_type);
 	if (!status)
 		return 0;
 
 	unregister_quota_format(&ocfs2_quota_format);
-out3:
 	debugfs_remove(ocfs2_debugfs_root);
 	ocfs2_free_mem_caches();
 out2:
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 67562c78e57d..42a7d0a71b22 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -163,13 +163,15 @@ static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
 /* SLAB cache for dquot structures */
 static struct kmem_cache *dquot_cachep;
 
-int register_quota_format(struct quota_format_type *fmt)
+/* workqueue for work quota_release_work*/
+static struct workqueue_struct *quota_unbound_wq;
+
+void register_quota_format(struct quota_format_type *fmt)
 {
 	spin_lock(&dq_list_lock);
 	fmt->qf_next = quota_formats;
 	quota_formats = fmt;
 	spin_unlock(&dq_list_lock);
-	return 0;
 }
 EXPORT_SYMBOL(register_quota_format);
 
@@ -892,7 +894,7 @@ void dqput(struct dquot *dquot)
 	put_releasing_dquots(dquot);
 	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
-	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
+	queue_delayed_work(quota_unbound_wq, &quota_release_work, 1);
 }
 EXPORT_SYMBOL(dqput);
 
@@ -3047,6 +3049,11 @@ static int __init dquot_init(void)
 	if (register_shrinker(&dqcache_shrinker, "dquota-cache"))
 		panic("Cannot register dquot shrinker");
 
+	quota_unbound_wq = alloc_workqueue("quota_events_unbound",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
+	if (!quota_unbound_wq)
+		panic("Cannot create quota_unbound_wq\n");
+
 	return 0;
 }
 fs_initcall(dquot_init);
diff --git a/fs/quota/quota_v1.c b/fs/quota/quota_v1.c
index a0db3f195e95..8aaf4a501fc0 100644
--- a/fs/quota/quota_v1.c
+++ b/fs/quota/quota_v1.c
@@ -229,7 +229,8 @@ static struct quota_format_type v1_quota_format = {
 
 static int __init init_v1_quota_format(void)
 {
-        return register_quota_format(&v1_quota_format);
+	register_quota_format(&v1_quota_format);
+	return 0;
 }
 
 static void __exit exit_v1_quota_format(void)
diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index 7978ab671e0c..d73f44329277 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -422,12 +422,9 @@ static struct quota_format_type v2r1_quota_format = {
 
 static int __init init_v2_quota_format(void)
 {
-	int ret;
-
-	ret = register_quota_format(&v2r0_quota_format);
-	if (ret)
-		return ret;
-	return register_quota_format(&v2r1_quota_format);
+	register_quota_format(&v2r0_quota_format);
+	register_quota_format(&v2r1_quota_format);
+	return 0;
 }
 
 static void __exit exit_v2_quota_format(void)
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 6c16c4f34d88..e55852aa49f9 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2319,8 +2319,10 @@ cifs_do_rename(const unsigned int xid, struct dentry *from_dentry,
 	tcon = tlink_tcon(tlink);
 	server = tcon->ses->server;
 
-	if (!server->ops->rename)
-		return -ENOSYS;
+	if (!server->ops->rename) {
+		rc = -ENOSYS;
+		goto do_rename_exit;
+	}
 
 	/* try path-based rename first */
 	rc = server->ops->rename(xid, tcon, from_dentry,
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index ad77952f6d81..9b5aeafe220b 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -922,6 +922,14 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 	char *data_end;
 	struct dfs_referral_level_3 *ref;
 
+	if (rsp_size < sizeof(*rsp)) {
+		cifs_dbg(VFS | ONCE,
+			 "%s: header is malformed (size is %u, must be %zu)\n",
+			 __func__, rsp_size, sizeof(*rsp));
+		rc = -EINVAL;
+		goto parse_DFS_referrals_exit;
+	}
+
 	*num_of_nodes = le16_to_cpu(rsp->NumberOfReferrals);
 
 	if (*num_of_nodes < 1) {
@@ -931,6 +939,15 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		goto parse_DFS_referrals_exit;
 	}
 
+	if (sizeof(*rsp) + *num_of_nodes * sizeof(REFERRAL3) > rsp_size) {
+		cifs_dbg(VFS | ONCE,
+			 "%s: malformed buffer (size is %u, must be at least %zu)\n",
+			 __func__, rsp_size,
+			 sizeof(*rsp) + *num_of_nodes * sizeof(REFERRAL3));
+		rc = -EINVAL;
+		goto parse_DFS_referrals_exit;
+	}
+
 	ref = (struct dfs_referral_level_3 *) &(rsp->referrals);
 	if (ref->VersionNumber != cpu_to_le16(3)) {
 		cifs_dbg(VFS, "Referrals of V%d version are not supported, should be V3\n",
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index ee6a6ba13f89..b02114b734dc 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3072,8 +3072,7 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
 	if (!utf16_path) {
 		rc = -ENOMEM;
-		free_xid(xid);
-		return ERR_PTR(rc);
+		goto put_tlink;
 	}
 
 	oparms = (struct cifs_open_parms) {
@@ -3105,6 +3104,7 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	}
 
+put_tlink:
 	cifs_put_tlink(tlink);
 	free_xid(xid);
 
@@ -3145,8 +3145,7 @@ set_smb2_acl(struct smb_ntsd *pnntsd, __u32 acllen,
 	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
 	if (!utf16_path) {
 		rc = -ENOMEM;
-		free_xid(xid);
-		return rc;
+		goto put_tlink;
 	}
 
 	oparms = (struct cifs_open_parms) {
@@ -3167,6 +3166,7 @@ set_smb2_acl(struct smb_ntsd *pnntsd, __u32 acllen,
 		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	}
 
+put_tlink:
 	cifs_put_tlink(tlink);
 	free_xid(xid);
 	return rc;
diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index c6c1844d4448..363501fc308a 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -108,8 +108,9 @@ struct ksmbd_startup_request {
 	__u32	smb2_max_credits;	/* MAX credits */
 	__u32	smbd_max_io_size;	/* smbd read write size */
 	__u32	max_connections;	/* Number of maximum simultaneous connections */
+	__s8	bind_interfaces_only;
 	__u32	max_ip_connections;	/* Number of maximum connection per ip address */
-	__u32	reserved[125];		/* Reserved room */
+	__s8	reserved[499];		/* Reserved room */
 	__u32	ifc_list_sz;		/* interfaces list size */
 	__s8	____payload[];
 } __packed;
diff --git a/fs/smb/server/server.h b/fs/smb/server/server.h
index d0744498ceed..48bd203abb44 100644
--- a/fs/smb/server/server.h
+++ b/fs/smb/server/server.h
@@ -46,6 +46,7 @@ struct ksmbd_server_config {
 	unsigned int		max_ip_connections;
 
 	char			*conf[SERVER_CONF_WORK_GROUP + 1];
+	bool			bind_interfaces_only;
 };
 
 extern struct ksmbd_server_config server_conf;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 93c31feab356..9a58c5a6f986 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -38,6 +38,7 @@
 #include "mgmt/user_session.h"
 #include "mgmt/ksmbd_ida.h"
 #include "ndr.h"
+#include "transport_tcp.h"
 
 static void __wbuf(struct ksmbd_work *work, void **req, void **rsp)
 {
@@ -7790,6 +7791,9 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 		if (netdev->type == ARPHRD_LOOPBACK)
 			continue;
 
+		if (!ksmbd_find_netdev_name_iface_list(netdev->name))
+			continue;
+
 		flags = dev_get_flags(netdev);
 		if (!(flags & IFF_RUNNING))
 			continue;
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 80581a7bc1bc..354f7144c590 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -327,6 +327,7 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	ret = ksmbd_set_netbios_name(req->netbios_name);
 	ret |= ksmbd_set_server_string(req->server_string);
 	ret |= ksmbd_set_work_group(req->work_group);
+	server_conf.bind_interfaces_only = req->bind_interfaces_only;
 	ret |= ksmbd_tcp_set_interfaces(KSMBD_STARTUP_CONFIG_INTERFACES(req),
 					req->ifc_list_sz);
 out:
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index c43a46511428..665d21d40e7a 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -551,30 +551,37 @@ static int create_socket(struct interface *iface)
 	return ret;
 }
 
+struct interface *ksmbd_find_netdev_name_iface_list(char *netdev_name)
+{
+	struct interface *iface;
+
+	list_for_each_entry(iface, &iface_list, entry)
+		if (!strcmp(iface->name, netdev_name))
+			return iface;
+	return NULL;
+}
+
 static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 			      void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
 	struct interface *iface;
-	int ret, found = 0;
+	int ret;
 
 	switch (event) {
 	case NETDEV_UP:
 		if (netif_is_bridge_port(netdev))
 			return NOTIFY_OK;
 
-		list_for_each_entry(iface, &iface_list, entry) {
-			if (!strcmp(iface->name, netdev->name)) {
-				found = 1;
-				if (iface->state != IFACE_STATE_DOWN)
-					break;
-				ret = create_socket(iface);
-				if (ret)
-					return NOTIFY_OK;
-				break;
-			}
+		iface = ksmbd_find_netdev_name_iface_list(netdev->name);
+		if (iface && iface->state == IFACE_STATE_DOWN) {
+			ksmbd_debug(CONN, "netdev-up event: netdev(%s) is going up\n",
+					iface->name);
+			ret = create_socket(iface);
+			if (ret)
+				return NOTIFY_OK;
 		}
-		if (!found && bind_additional_ifaces) {
+		if (!iface && bind_additional_ifaces) {
 			iface = alloc_iface(kstrdup(netdev->name, GFP_KERNEL));
 			if (!iface)
 				return NOTIFY_OK;
@@ -584,19 +591,19 @@ static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 		}
 		break;
 	case NETDEV_DOWN:
-		list_for_each_entry(iface, &iface_list, entry) {
-			if (!strcmp(iface->name, netdev->name) &&
-			    iface->state == IFACE_STATE_CONFIGURED) {
-				tcp_stop_kthread(iface->ksmbd_kthread);
-				iface->ksmbd_kthread = NULL;
-				mutex_lock(&iface->sock_release_lock);
-				tcp_destroy_socket(iface->ksmbd_socket);
-				iface->ksmbd_socket = NULL;
-				mutex_unlock(&iface->sock_release_lock);
-
-				iface->state = IFACE_STATE_DOWN;
-				break;
-			}
+		iface = ksmbd_find_netdev_name_iface_list(netdev->name);
+		if (iface && iface->state == IFACE_STATE_CONFIGURED) {
+			ksmbd_debug(CONN, "netdev-down event: netdev(%s) is going down\n",
+					iface->name);
+			tcp_stop_kthread(iface->ksmbd_kthread);
+			iface->ksmbd_kthread = NULL;
+			mutex_lock(&iface->sock_release_lock);
+			tcp_destroy_socket(iface->ksmbd_socket);
+			iface->ksmbd_socket = NULL;
+			mutex_unlock(&iface->sock_release_lock);
+
+			iface->state = IFACE_STATE_DOWN;
+			break;
 		}
 		break;
 	}
@@ -665,18 +672,6 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
 	int sz = 0;
 
 	if (!ifc_list_sz) {
-		struct net_device *netdev;
-
-		rtnl_lock();
-		for_each_netdev(&init_net, netdev) {
-			if (netif_is_bridge_port(netdev))
-				continue;
-			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL))) {
-				rtnl_unlock();
-				return -ENOMEM;
-			}
-		}
-		rtnl_unlock();
 		bind_additional_ifaces = 1;
 		return 0;
 	}
diff --git a/fs/smb/server/transport_tcp.h b/fs/smb/server/transport_tcp.h
index 5925ec5df475..bf6a3d71f7a0 100644
--- a/fs/smb/server/transport_tcp.h
+++ b/fs/smb/server/transport_tcp.h
@@ -8,6 +8,7 @@
 
 int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz);
 void ksmbd_free_transport(struct ksmbd_transport *kt);
+struct interface *ksmbd_find_netdev_name_iface_list(char *netdev_name);
 int ksmbd_tcp_init(void);
 void ksmbd_tcp_destroy(void);
 
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 269573c82808..e267fc9d3108 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -171,12 +171,40 @@ typedef struct xlog_rec_header {
 	__be32	  h_prev_block; /* block number to previous LR		:  4 */
 	__be32	  h_num_logops;	/* number of log operations in this LR	:  4 */
 	__be32	  h_cycle_data[XLOG_HEADER_CYCLE_SIZE / BBSIZE];
-	/* new fields */
+
+	/* fields added by the Linux port: */
 	__be32    h_fmt;        /* format of log record                 :  4 */
 	uuid_t	  h_fs_uuid;    /* uuid of FS                           : 16 */
+
+	/* fields added for log v2: */
 	__be32	  h_size;	/* iclog size				:  4 */
+
+	/*
+	 * When h_size added for log v2 support, it caused structure to have
+	 * a different size on i386 vs all other architectures because the
+	 * sum of the size ofthe  member is not aligned by that of the largest
+	 * __be64-sized member, and i386 has really odd struct alignment rules.
+	 *
+	 * Due to the way the log headers are placed out on-disk that alone is
+	 * not a problem becaue the xlog_rec_header always sits alone in a
+	 * BBSIZEs area, and the rest of that area is padded with zeroes.
+	 * But xlog_cksum used to calculate the checksum based on the structure
+	 * size, and thus gives different checksums for i386 vs the rest.
+	 * We now do two checksum validation passes for both sizes to allow
+	 * moving v5 file systems with unclean logs between i386 and other
+	 * (little-endian) architectures.
+	 */
+	__u32	  h_pad0;
 } xlog_rec_header_t;
 
+#ifdef __i386__
+#define XLOG_REC_SIZE		offsetofend(struct xlog_rec_header, h_size)
+#define XLOG_REC_SIZE_OTHER	sizeof(struct xlog_rec_header)
+#else
+#define XLOG_REC_SIZE		sizeof(struct xlog_rec_header)
+#define XLOG_REC_SIZE_OTHER	offsetofend(struct xlog_rec_header, h_size)
+#endif /* __i386__ */
+
 typedef struct xlog_rec_ext_header {
 	__be32	  xh_cycle;	/* write cycle of log			: 4 */
 	__be32	  xh_cycle_data[XLOG_HEADER_CYCLE_SIZE / BBSIZE]; /*	: 256 */
diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
index 822f5adf7f7c..b968f7bc202c 100644
--- a/fs/xfs/scrub/reap.c
+++ b/fs/xfs/scrub/reap.c
@@ -20,6 +20,7 @@
 #include "xfs_ialloc_btree.h"
 #include "xfs_rmap.h"
 #include "xfs_rmap_btree.h"
+#include "xfs_refcount.h"
 #include "xfs_refcount_btree.h"
 #include "xfs_extent_busy.h"
 #include "xfs_ag.h"
@@ -376,9 +377,21 @@ xreap_agextent_iter(
 	if (crosslinked) {
 		trace_xreap_dispose_unmap_extent(sc->sa.pag, agbno, *aglenp);
 
-		rs->force_roll = true;
-		return xfs_rmap_free(sc->tp, sc->sa.agf_bp, sc->sa.pag, agbno,
-				*aglenp, rs->oinfo);
+		if (rs->oinfo == &XFS_RMAP_OINFO_COW) {
+			/*
+			 * If we're unmapping CoW staging extents, remove the
+			 * records from the refcountbt, which will remove the
+			 * rmap record as well.
+			 */
+			xfs_refcount_free_cow_extent(sc->tp, fsbno, *aglenp);
+			rs->force_roll = true;
+			return 0;
+		}
+
+		xfs_rmap_free_extent(sc->tp, sc->sa.pag->pag_agno, agbno,
+				*aglenp, rs->oinfo->oi_owner);
+		rs->deferred++;
+		return 0;
 	}
 
 	trace_xreap_dispose_free_extent(sc->sa.pag, agbno, *aglenp);
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index a1650fc81382..d03976b82180 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1807,13 +1807,13 @@ xlog_cksum(
 	struct xlog		*log,
 	struct xlog_rec_header	*rhead,
 	char			*dp,
-	int			size)
+	unsigned int		hdrsize,
+	unsigned int		size)
 {
 	uint32_t		crc;
 
 	/* first generate the crc for the record header ... */
-	crc = xfs_start_cksum_update((char *)rhead,
-			      sizeof(struct xlog_rec_header),
+	crc = xfs_start_cksum_update((char *)rhead, hdrsize,
 			      offsetof(struct xlog_rec_header, h_crc));
 
 	/* ... then for additional cycle data for v2 logs ... */
@@ -2077,7 +2077,7 @@ xlog_sync(
 
 	/* calculcate the checksum */
 	iclog->ic_header.h_crc = xlog_cksum(log, &iclog->ic_header,
-					    iclog->ic_datap, size);
+			iclog->ic_datap, XLOG_REC_SIZE, size);
 	/*
 	 * Intentionally corrupt the log record CRC based on the error injection
 	 * frequency, if defined. This facilitates testing log recovery in the
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index e30c06ec20e3..a183bfb36470 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -503,8 +503,8 @@ xlog_recover_finish(
 extern void
 xlog_recover_cancel(struct xlog *);
 
-extern __le32	 xlog_cksum(struct xlog *log, struct xlog_rec_header *rhead,
-			    char *dp, int size);
+__le32	 xlog_cksum(struct xlog *log, struct xlog_rec_header *rhead,
+		char *dp, unsigned int hdrsize, unsigned int size);
 
 extern struct kmem_cache *xfs_log_ticket_cache;
 struct xlog_ticket *xlog_ticket_alloc(struct xlog *log, int unit_bytes,
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 60382eb49961..f708bf4104b1 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2860,20 +2860,34 @@ xlog_recover_process(
 	int			pass,
 	struct list_head	*buffer_list)
 {
-	__le32			old_crc = rhead->h_crc;
-	__le32			crc;
+	__le32			expected_crc = rhead->h_crc, crc, other_crc;
 
-	crc = xlog_cksum(log, rhead, dp, be32_to_cpu(rhead->h_len));
+	crc = xlog_cksum(log, rhead, dp, XLOG_REC_SIZE,
+			be32_to_cpu(rhead->h_len));
+
+	/*
+	 * Look at the end of the struct xlog_rec_header definition in
+	 * xfs_log_format.h for the glory details.
+	 */
+	if (expected_crc && crc != expected_crc) {
+		other_crc = xlog_cksum(log, rhead, dp, XLOG_REC_SIZE_OTHER,
+				be32_to_cpu(rhead->h_len));
+		if (other_crc == expected_crc) {
+			xfs_notice_once(log->l_mp,
+	"Fixing up incorrect CRC due to padding.");
+			crc = other_crc;
+		}
+	}
 
 	/*
 	 * Nothing else to do if this is a CRC verification pass. Just return
 	 * if this a record with a non-zero crc. Unfortunately, mkfs always
-	 * sets old_crc to 0 so we must consider this valid even on v5 supers.
-	 * Otherwise, return EFSBADCRC on failure so the callers up the stack
-	 * know precisely what failed.
+	 * sets expected_crc to 0 so we must consider this valid even on v5
+	 * supers.  Otherwise, return EFSBADCRC on failure so the callers up the
+	 * stack know precisely what failed.
 	 */
 	if (pass == XLOG_RECOVER_CRCPASS) {
-		if (old_crc && crc != old_crc)
+		if (expected_crc && crc != expected_crc)
 			return -EFSBADCRC;
 		return 0;
 	}
@@ -2884,11 +2898,11 @@ xlog_recover_process(
 	 * zero CRC check prevents warnings from being emitted when upgrading
 	 * the kernel from one that does not add CRCs by default.
 	 */
-	if (crc != old_crc) {
-		if (old_crc || xfs_has_crc(log->l_mp)) {
+	if (crc != expected_crc) {
+		if (expected_crc || xfs_has_crc(log->l_mp)) {
 			xfs_alert(log->l_mp,
 		"log record CRC mismatch: found 0x%x, expected 0x%x.",
-					le32_to_cpu(old_crc),
+					le32_to_cpu(expected_crc),
 					le32_to_cpu(crc));
 			xfs_hex_dump(dp, 32);
 		}
diff --git a/fs/xfs/xfs_ondisk.h b/fs/xfs/xfs_ondisk.h
index c4cc99b70dd3..618bf4f03f28 100644
--- a/fs/xfs/xfs_ondisk.h
+++ b/fs/xfs/xfs_ondisk.h
@@ -143,6 +143,8 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_STRUCT_SIZE(struct xfs_rud_log_format,	16);
 	XFS_CHECK_STRUCT_SIZE(struct xfs_map_extent,		32);
 	XFS_CHECK_STRUCT_SIZE(struct xfs_phys_extent,		16);
+	XFS_CHECK_STRUCT_SIZE(struct xlog_rec_header,		328);
+	XFS_CHECK_STRUCT_SIZE(struct xlog_rec_ext_header,	260);
 
 	XFS_CHECK_OFFSET(struct xfs_bui_log_format, bui_extents,	16);
 	XFS_CHECK_OFFSET(struct xfs_cui_log_format, cui_extents,	16);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index bfecd9dcb552..1f94fe8559a9 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -32,6 +32,9 @@
  */
 
 #define CPUFREQ_ETERNAL			(-1)
+
+#define CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS	NSEC_PER_MSEC
+
 #define CPUFREQ_NAME_LEN		16
 /* Print length for names. Extra 1 space for accommodating '\n' in prints */
 #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ba77f08900ca..fa5b11452ae6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -315,7 +315,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
 #define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
 #define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
-#define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
+#define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
 
 #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
 #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0511f6f9a4e6..e4338237a054 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1034,6 +1034,20 @@ static inline struct pci_driver *to_pci_driver(struct device_driver *drv)
 	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0
 
+/**
+ * PCI_VDEVICE_SUB - describe a specific PCI device/subdevice in a short form
+ * @vend: the vendor name
+ * @dev: the 16 bit PCI Device ID
+ * @subvend: the 16 bit PCI Subvendor ID
+ * @subdev: the 16 bit PCI Subdevice ID
+ *
+ * Generate the pci_device_id struct layout for the specific PCI
+ * device/subdevice. Private data may follow the output.
+ */
+#define PCI_VDEVICE_SUB(vend, dev, subvend, subdev) \
+	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
+	.subvendor = (subvend), .subdevice = (subdev), 0, 0
+
 /**
  * PCI_DEVICE_DATA - macro used to describe a specific PCI device in very short form
  * @vend: the vendor name (without PCI_VENDOR_ID_ prefix)
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 4b74f0f012a5..c3a462ff1206 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -94,7 +94,9 @@ extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 extern void pm_runtime_release_supplier(struct device_link *link);
 
+int devm_pm_runtime_set_active_enabled(struct device *dev);
 extern int devm_pm_runtime_enable(struct device *dev);
+int devm_pm_runtime_get_noresume(struct device *dev);
 
 /**
  * pm_suspend_ignore_children - Set runtime PM behavior regarding children.
@@ -278,7 +280,9 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
+static inline int devm_pm_runtime_set_active_enabled(struct device *dev) { return 0; }
 static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
+static inline int devm_pm_runtime_get_noresume(struct device *dev) { return 0; }
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline void pm_runtime_get_noresume(struct device *dev) {}
diff --git a/include/linux/quota.h b/include/linux/quota.h
index 07071e64abf3..89a0d83ddad0 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -526,7 +526,7 @@ struct quota_info {
 	const struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
 };
 
-int register_quota_format(struct quota_format_type *fmt);
+void register_quota_format(struct quota_format_type *fmt);
 void unregister_quota_format(struct quota_format_type *fmt);
 
 struct quota_module_name {
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 75bda0783395..aa831e16c3d3 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -15,6 +15,7 @@
 #ifndef __LINUX_USB_GADGET_H
 #define __LINUX_USB_GADGET_H
 
+#include <linux/cleanup.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -32,6 +33,7 @@ struct usb_ep;
 
 /**
  * struct usb_request - describes one i/o request
+ * @ep: The associated endpoint set by usb_ep_alloc_request().
  * @buf: Buffer used for data.  Always provide this; some controllers
  *	only use PIO, or don't use DMA for some endpoints.
  * @dma: DMA address corresponding to 'buf'.  If you don't set this
@@ -97,6 +99,7 @@ struct usb_ep;
  */
 
 struct usb_request {
+	struct usb_ep		*ep;
 	void			*buf;
 	unsigned		length;
 	dma_addr_t		dma;
@@ -289,6 +292,28 @@ static inline void usb_ep_fifo_flush(struct usb_ep *ep)
 
 /*-------------------------------------------------------------------------*/
 
+/**
+ * free_usb_request - frees a usb_request object and its buffer
+ * @req: the request being freed
+ *
+ * This helper function frees both the request's buffer and the request object
+ * itself by calling usb_ep_free_request(). Its signature is designed to be used
+ * with DEFINE_FREE() to enable automatic, scope-based cleanup for usb_request
+ * pointers.
+ */
+static inline void free_usb_request(struct usb_request *req)
+{
+	if (!req)
+		return;
+
+	kfree(req->buf);
+	usb_ep_free_request(req->ep, req);
+}
+
+DEFINE_FREE(free_usb_request, struct usb_request *, free_usb_request(_T))
+
+/*-------------------------------------------------------------------------*/
+
 struct usb_dcd_config_params {
 	__u8  bU1devExitLat;	/* U1 Device exit Latency */
 #define USB_DEFAULT_U1_DEV_EXIT_LAT	0x01	/* Less then 1 microsec */
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 006a61ddd36f..3d36794cb189 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -489,6 +489,21 @@ struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
 int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
 			  int headroom, bool reply);
 
+static inline void ip_tunnel_adj_headroom(struct net_device *dev,
+					  unsigned int headroom)
+{
+	/* we must cap headroom to some upperlimit, else pskb_expand_head
+	 * will overflow header offsets in skb_headers_offset_update().
+	 */
+	const unsigned int max_allowed = 512;
+
+	if (headroom > max_allowed)
+		headroom = max_allowed;
+
+	if (headroom > READ_ONCE(dev->needed_headroom))
+		WRITE_ONCE(dev->needed_headroom, headroom);
+}
+
 int iptunnel_handle_offloads(struct sk_buff *skb, int gso_type_mask);
 
 static inline int iptunnel_pull_offloads(struct sk_buff *skb)
diff --git a/kernel/padata.c b/kernel/padata.c
index 93cd7704ab63..9260ab0b39eb 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -290,7 +290,11 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
 	if (remove_object) {
 		list_del_init(&padata->list);
 		++pd->processed;
-		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
+		/* When sequence wraps around, reset to the first CPU. */
+		if (unlikely(pd->processed == 0))
+			pd->cpu = cpumask_first(pd->cpumask.pcpu);
+		else
+			pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
 	}
 
 	spin_unlock(&reorder->lock);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1cf43e91ae9d..58231999d929 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4829,7 +4829,7 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 	return cfs_rq->avg.load_avg;
 }
 
-static int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
+static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf);
 
 static inline unsigned long task_util(struct task_struct *p)
 {
@@ -5158,7 +5158,7 @@ attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void
 detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 
-static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
+static inline int sched_balance_newidle(struct rq *rq, struct rq_flags *rf)
 {
 	return 0;
 }
@@ -8281,7 +8281,7 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	if (rq->nr_running)
 		return 1;
 
-	return newidle_balance(rq, rf) != 0;
+	return sched_balance_newidle(rq, rf) != 0;
 }
 #endif /* CONFIG_SMP */
 
@@ -8528,21 +8528,21 @@ done: __maybe_unused;
 	return p;
 
 idle:
-	if (!rf)
-		return NULL;
-
-	new_tasks = newidle_balance(rq, rf);
+	if (rf) {
+		new_tasks = sched_balance_newidle(rq, rf);
 
-	/*
-	 * Because newidle_balance() releases (and re-acquires) rq->lock, it is
-	 * possible for any higher priority task to appear. In that case we
-	 * must re-start the pick_next_entity() loop.
-	 */
-	if (new_tasks < 0)
-		return RETRY_TASK;
+		/*
+		 * Because sched_balance_newidle() releases (and re-acquires)
+		 * rq->lock, it is possible for any higher priority task to
+		 * appear. In that case we must re-start the pick_next_entity()
+		 * loop.
+		 */
+		if (new_tasks < 0)
+			return RETRY_TASK;
 
-	if (new_tasks > 0)
-		goto again;
+		if (new_tasks > 0)
+			goto again;
+	}
 
 	/*
 	 * rq is about to be idle, check if we need to update the
@@ -11542,7 +11542,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	ld_moved = 0;
 
 	/*
-	 * newidle_balance() disregards balance intervals, so we could
+	 * sched_balance_newidle() disregards balance intervals, so we could
 	 * repeatedly reach this code, which would lead to balance_interval
 	 * skyrocketing in a short amount of time. Skip the balance_interval
 	 * increase logic to avoid that.
@@ -12308,7 +12308,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
- * newidle_balance is called by schedule() if this_cpu is about to become
+ * sched_balance_newidle is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  *
  * Returns:
@@ -12316,7 +12316,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
  *     0 - failed, no new tasks
  *   > 0 - success, new (fair) tasks present
  */
-static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
+static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
diff --git a/mm/shmem.c b/mm/shmem.c
index ecf1011cc3e2..2260def68090 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4617,11 +4617,7 @@ void __init shmem_init(void)
 	shmem_init_inodecache();
 
 #ifdef CONFIG_TMPFS_QUOTA
-	error = register_quota_format(&shmem_quota_format);
-	if (error < 0) {
-		pr_err("Could not register quota format\n");
-		goto out3;
-	}
+	register_quota_format(&shmem_quota_format);
 #endif
 
 	error = register_filesystem(&shmem_fs_type);
@@ -4650,7 +4646,6 @@ void __init shmem_init(void)
 out2:
 #ifdef CONFIG_TMPFS_QUOTA
 	unregister_quota_format(&shmem_quota_format);
-out3:
 #endif
 	shmem_destroy_inodecache();
 	shm_mnt = ERR_PTR(error);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index b5d64cd3ab0a..090403c8cc6c 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -567,20 +567,6 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
-static void ip_tunnel_adj_headroom(struct net_device *dev, unsigned int headroom)
-{
-	/* we must cap headroom to some upperlimit, else pskb_expand_head
-	 * will overflow header offsets in skb_headers_offset_update().
-	 */
-	static const unsigned int max_allowed = 512;
-
-	if (headroom > max_allowed)
-		headroom = max_allowed;
-
-	if (headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, headroom);
-}
-
 void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		       u8 proto, int tunnel_hlen)
 {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 560273e7f773..88551db62ca2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2189,7 +2189,8 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 				 u32 max_segs)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	u32 send_win, cong_win, limit, in_flight;
+	u32 send_win, cong_win, limit, in_flight, threshold;
+	u64 srtt_in_ns, expected_ack, how_far_is_the_ack;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct sk_buff *head;
 	int win_divisor;
@@ -2251,9 +2252,19 @@ static bool tcp_tso_should_defer(struct sock *sk, struct sk_buff *skb,
 	head = tcp_rtx_queue_head(sk);
 	if (!head)
 		goto send_now;
-	delta = tp->tcp_clock_cache - head->tstamp;
-	/* If next ACK is likely to come too late (half srtt), do not defer */
-	if ((s64)(delta - (u64)NSEC_PER_USEC * (tp->srtt_us >> 4)) < 0)
+
+	srtt_in_ns = (u64)(NSEC_PER_USEC >> 3) * tp->srtt_us;
+	/* When is the ACK expected ? */
+	expected_ack = head->tstamp + srtt_in_ns;
+	/* How far from now is the ACK expected ? */
+	how_far_is_the_ack = expected_ack - tp->tcp_clock_cache;
+
+	/* If next ACK is likely to come too late,
+	 * ie in more than min(1ms, half srtt), do not defer.
+	 */
+	threshold = min(srtt_in_ns >> 1, NSEC_PER_MSEC);
+
+	if ((s64)(how_far_is_the_ack - threshold) > 0)
 		goto send_now;
 
 	/* Ok, it looks like it is advisable to defer.
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index d645d022ce77..e635ddd41aba 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1255,8 +1255,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	 */
 	max_headroom = LL_RESERVED_SPACE(dst->dev) + sizeof(struct ipv6hdr)
 			+ dst->header_len + t->hlen;
-	if (max_headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, max_headroom);
+	ip_tunnel_adj_headroom(dev, max_headroom);
 
 	err = ip6_tnl_encap(skb, t, &proto, fl6);
 	if (err)
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index d7dea82bcf56..c7ee44bd3206 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -254,12 +254,9 @@ int tls_process_cmsg(struct sock *sk, struct msghdr *msg,
 			if (msg->msg_flags & MSG_MORE)
 				return -EINVAL;
 
-			rc = tls_handle_open_record(sk, msg->msg_flags);
-			if (rc)
-				return rc;
-
 			*record_type = *(unsigned char *)CMSG_DATA(cmsg);
-			rc = 0;
+
+			rc = tls_handle_open_record(sk, msg->msg_flags);
 			break;
 		default:
 			return -EINVAL;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 435235a351e2..410e39e4b79f 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1054,7 +1054,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 			if (ret == -EINPROGRESS)
 				num_async++;
 			else if (ret != -EAGAIN)
-				goto send_end;
+				goto end;
 		}
 	}
 
@@ -1112,8 +1112,11 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 				goto send_end;
 			tls_ctx->pending_open_record_frags = true;
 
-			if (sk_msg_full(msg_pl))
+			if (sk_msg_full(msg_pl)) {
 				full_record = true;
+				sk_msg_trim(sk, msg_en,
+					    msg_pl->sg.size + prot->overhead_size);
+			}
 
 			if (full_record || eor)
 				goto copied;
@@ -1149,6 +1152,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 				} else if (ret != -EAGAIN)
 					goto send_end;
 			}
+
+			/* Transmit if any encryptions have completed */
+			if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
+				cancel_delayed_work(&ctx->tx_work.work);
+				tls_tx_records(sk, msg->msg_flags);
+			}
+
 			continue;
 rollback_iter:
 			copied -= try_to_copy;
@@ -1204,6 +1214,12 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 					goto send_end;
 				}
 			}
+
+			/* Transmit if any encryptions have completed */
+			if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
+				cancel_delayed_work(&ctx->tx_work.work);
+				tls_tx_records(sk, msg->msg_flags);
+			}
 		}
 
 		continue;
@@ -1223,9 +1239,10 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 			goto alloc_encrypted;
 	}
 
+send_end:
 	if (!num_async) {
-		goto send_end;
-	} else if (num_zc) {
+		goto end;
+	} else if (num_zc || eor) {
 		int err;
 
 		/* Wait for pending encryptions to get completed */
@@ -1242,7 +1259,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		tls_tx_records(sk, msg->msg_flags);
 	}
 
-send_end:
+end:
 	ret = sk_stream_error(sk, msg->msg_flags, ret);
 	return copied > 0 ? copied : ret;
 }
@@ -1633,8 +1650,10 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 
 	if (unlikely(darg->async)) {
 		err = tls_strp_msg_hold(&ctx->strp, &ctx->async_hold);
-		if (err)
-			__skb_queue_tail(&ctx->async_hold, darg->skb);
+		if (err) {
+			err = tls_decrypt_async_wait(ctx);
+			darg->async = false;
+		}
 		return err;
 	}
 
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index c91a3c24f607..5416f21918e0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,8 +12,10 @@
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
 const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
+const vm_flags_t BINDINGS_VM_MERGEABLE = VM_MERGEABLE;
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 9bcbea04dac3..7d9078b94a8f 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -51,3 +51,4 @@ mod bindings_helper {
 
 pub const GFP_KERNEL: gfp_t = BINDINGS_GFP_KERNEL;
 pub const __GFP_ZERO: gfp_t = BINDINGS___GFP_ZERO;
+pub const VM_MERGEABLE: vm_flags_t = BINDINGS_VM_MERGEABLE;
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 775db3fc4959..ec10270c2cce 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -32,7 +32,7 @@
  *	allows 5 times as large as IEC 61883-6 defines.
  * @CIP_HEADER_WITHOUT_EOH: Only for in-stream. CIP Header doesn't include
  *	valid EOH.
- * @CIP_NO_HEADERS: a lack of headers in packets
+ * @CIP_NO_HEADER: a lack of headers in packets
  * @CIP_UNALIGHED_DBC: Only for in-stream. The value of dbc is not alighed to
  *	the value of current SYT_INTERVAL; e.g. initial value is not zero.
  * @CIP_UNAWARE_SYT: For outgoing packet, the value in SYT field of CIP is 0xffff.
diff --git a/sound/soc/codecs/idt821034.c b/sound/soc/codecs/idt821034.c
index 2cc7b9166e69..068a5448e273 100644
--- a/sound/soc/codecs/idt821034.c
+++ b/sound/soc/codecs/idt821034.c
@@ -548,14 +548,14 @@ static int idt821034_kctrl_mute_put(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
-static const DECLARE_TLV_DB_LINEAR(idt821034_gain_in, -6520, 1306);
-#define IDT821034_GAIN_IN_MIN_RAW	1 /* -65.20 dB -> 10^(-65.2/20.0) * 1820 = 1 */
-#define IDT821034_GAIN_IN_MAX_RAW	8191 /* 13.06 dB -> 10^(13.06/20.0) * 1820 = 8191 */
+static const DECLARE_TLV_DB_LINEAR(idt821034_gain_in, -300, 1300);
+#define IDT821034_GAIN_IN_MIN_RAW	1288 /* -3.0 dB -> 10^(-3.0/20.0) * 1820 = 1288 */
+#define IDT821034_GAIN_IN_MAX_RAW	8130 /* 13.0 dB -> 10^(13.0/20.0) * 1820 = 8130 */
 #define IDT821034_GAIN_IN_INIT_RAW	1820 /* 0dB -> 10^(0/20) * 1820 = 1820 */
 
-static const DECLARE_TLV_DB_LINEAR(idt821034_gain_out, -6798, 1029);
-#define IDT821034_GAIN_OUT_MIN_RAW	1 /* -67.98 dB -> 10^(-67.98/20.0) * 2506 = 1*/
-#define IDT821034_GAIN_OUT_MAX_RAW	8191 /* 10.29 dB -> 10^(10.29/20.0) * 2506 = 8191 */
+static const DECLARE_TLV_DB_LINEAR(idt821034_gain_out, -1300, 300);
+#define IDT821034_GAIN_OUT_MIN_RAW	561 /* -13.0 dB -> 10^(-13.0/20.0) * 2506 = 561 */
+#define IDT821034_GAIN_OUT_MAX_RAW	3540 /* 3.0 dB -> 10^(3.0/20.0) * 2506 = 3540 */
 #define IDT821034_GAIN_OUT_INIT_RAW	2506 /* 0dB -> 10^(0/20) * 2506 = 2506 */
 
 static const struct snd_kcontrol_new idt821034_controls[] = {
diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index f307374834b5..48ed75c3a7db 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -26,7 +26,8 @@
 #include <sound/tlv.h>
 #include "nau8821.h"
 
-#define NAU8821_JD_ACTIVE_HIGH			BIT(0)
+#define NAU8821_QUIRK_JD_ACTIVE_HIGH			BIT(0)
+#define NAU8821_QUIRK_JD_DB_BYPASS			BIT(1)
 
 static int nau8821_quirk;
 static int quirk_override = -1;
@@ -1030,12 +1031,17 @@ static bool nau8821_is_jack_inserted(struct regmap *regmap)
 	return active_high == is_high;
 }
 
-static void nau8821_int_status_clear_all(struct regmap *regmap)
+static void nau8821_irq_status_clear(struct regmap *regmap, int active_irq)
 {
-	int active_irq, clear_irq, i;
+	int clear_irq, i;
 
-	/* Reset the intrruption status from rightmost bit if the corres-
-	 * ponding irq event occurs.
+	if (active_irq) {
+		regmap_write(regmap, NAU8821_R11_INT_CLR_KEY_STATUS, active_irq);
+		return;
+	}
+
+	/* Reset the interruption status from rightmost bit if the
+	 * corresponding irq event occurs.
 	 */
 	regmap_read(regmap, NAU8821_R10_IRQ_STATUS, &active_irq);
 	for (i = 0; i < NAU8821_REG_DATA_LEN; i++) {
@@ -1062,7 +1068,7 @@ static void nau8821_eject_jack(struct nau8821 *nau8821)
 	snd_soc_dapm_sync(dapm);
 
 	/* Clear all interruption status */
-	nau8821_int_status_clear_all(regmap);
+	nau8821_irq_status_clear(regmap, 0);
 
 	/* Enable the insertion interruption, disable the ejection inter-
 	 * ruption, and then bypass de-bounce circuit.
@@ -1166,9 +1172,10 @@ static void nau8821_setup_inserted_irq(struct nau8821 *nau8821)
 	regmap_update_bits(regmap, NAU8821_R1D_I2S_PCM_CTRL2,
 		NAU8821_I2S_MS_MASK, NAU8821_I2S_MS_SLAVE);
 
-	/* Not bypass de-bounce circuit */
-	regmap_update_bits(regmap, NAU8821_R0D_JACK_DET_CTRL,
-		NAU8821_JACK_DET_DB_BYPASS, 0);
+	/* Do not bypass de-bounce circuit */
+	if (!(nau8821_quirk & NAU8821_QUIRK_JD_DB_BYPASS))
+		regmap_update_bits(regmap, NAU8821_R0D_JACK_DET_CTRL,
+				   NAU8821_JACK_DET_DB_BYPASS, 0);
 
 	regmap_update_bits(regmap, NAU8821_R0F_INTERRUPT_MASK,
 		NAU8821_IRQ_EJECT_EN, 0);
@@ -1191,6 +1198,7 @@ static irqreturn_t nau8821_interrupt(int irq, void *data)
 
 	if ((active_irq & NAU8821_JACK_EJECT_IRQ_MASK) ==
 		NAU8821_JACK_EJECT_DETECTED) {
+		cancel_work_sync(&nau8821->jdet_work);
 		regmap_update_bits(regmap, NAU8821_R71_ANALOG_ADC_1,
 			NAU8821_MICDET_MASK, NAU8821_MICDET_DIS);
 		nau8821_eject_jack(nau8821);
@@ -1205,11 +1213,11 @@ static irqreturn_t nau8821_interrupt(int irq, void *data)
 		clear_irq = NAU8821_KEY_RELEASE_IRQ;
 	} else if ((active_irq & NAU8821_JACK_INSERT_IRQ_MASK) ==
 		NAU8821_JACK_INSERT_DETECTED) {
+		cancel_work_sync(&nau8821->jdet_work);
 		regmap_update_bits(regmap, NAU8821_R71_ANALOG_ADC_1,
 			NAU8821_MICDET_MASK, NAU8821_MICDET_EN);
 		if (nau8821_is_jack_inserted(regmap)) {
 			/* detect microphone and jack type */
-			cancel_work_sync(&nau8821->jdet_work);
 			schedule_work(&nau8821->jdet_work);
 			/* Turn off insertion interruption at manual mode */
 			regmap_update_bits(regmap,
@@ -1527,7 +1535,7 @@ static int nau8821_resume_setup(struct nau8821 *nau8821)
 	nau8821_configure_sysclk(nau8821, NAU8821_CLK_DIS, 0);
 	if (nau8821->irq) {
 		/* Clear all interruption status */
-		nau8821_int_status_clear_all(regmap);
+		nau8821_irq_status_clear(regmap, 0);
 
 		/* Enable both insertion and ejection interruptions, and then
 		 * bypass de-bounce circuit.
@@ -1848,7 +1856,23 @@ static const struct dmi_system_id nau8821_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
 			DMI_MATCH(DMI_BOARD_NAME, "CW14Q01P-V2"),
 		},
-		.driver_data = (void *)(NAU8821_JD_ACTIVE_HIGH),
+		.driver_data = (void *)(NAU8821_QUIRK_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Valve Steam Deck LCD */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
+		},
+		.driver_data = (void *)(NAU8821_QUIRK_JD_DB_BYPASS),
+	},
+	{
+		/* Valve Steam Deck OLED */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
+		},
+		.driver_data = (void *)(NAU8821_QUIRK_JD_DB_BYPASS),
 	},
 	{}
 };
@@ -1890,9 +1914,12 @@ static int nau8821_i2c_probe(struct i2c_client *i2c)
 
 	nau8821_check_quirks();
 
-	if (nau8821_quirk & NAU8821_JD_ACTIVE_HIGH)
+	if (nau8821_quirk & NAU8821_QUIRK_JD_ACTIVE_HIGH)
 		nau8821->jkdet_polarity = 0;
 
+	if (nau8821_quirk & NAU8821_QUIRK_JD_DB_BYPASS)
+		dev_dbg(dev, "Force bypassing jack detection debounce circuit\n");
+
 	nau8821_print_device_properties(nau8821);
 
 	nau8821_reset_chip(nau8821->regmap);
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 7743ea983b1a..9335bc20c56d 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -754,10 +754,16 @@ get_alias_quirk(struct usb_device *dev, unsigned int id)
  */
 static int try_to_register_card(struct snd_usb_audio *chip, int ifnum)
 {
+	struct usb_interface *iface;
+
 	if (check_delayed_register_option(chip) == ifnum ||
-	    chip->last_iface == ifnum ||
-	    usb_interface_claimed(usb_ifnum_to_if(chip->dev, chip->last_iface)))
+	    chip->last_iface == ifnum)
+		return snd_card_register(chip->card);
+
+	iface = usb_ifnum_to_if(chip->dev, chip->last_iface);
+	if (iface && usb_interface_claimed(iface))
 		return snd_card_register(chip->card);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index bb143de68875..e27d66b75fb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -144,11 +144,17 @@ static void test_parse_test_list_file(void)
 	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
 		goto out_fclose;
 
+	if (!ASSERT_OK(fsync(fileno(fp)), "fsync tmp"))
+		goto out_fclose;
+
 	init_test_filter_set(&set);
 
-	ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file");
+	if (!ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file"))
+		goto out_fclose;
+
+	if (!ASSERT_EQ(set.cnt, 4, "test  count"))
+		goto out_free_set;
 
-	ASSERT_EQ(set.cnt, 4, "test  count");
 	ASSERT_OK(strcmp("test_with_spaces", set.tests[0].name), "test 0 name");
 	ASSERT_EQ(set.tests[0].subtest_cnt, 0, "test 0 subtest count");
 	ASSERT_OK(strcmp("testA", set.tests[1].name), "test 1 name");
@@ -158,8 +164,8 @@ static void test_parse_test_list_file(void)
 	ASSERT_OK(strcmp("testB", set.tests[2].name), "test 2 name");
 	ASSERT_OK(strcmp("testC_no_eof_newline", set.tests[3].name), "test 3 name");
 
+out_free_set:
 	free_test_filter_set(&set);
-
 out_fclose:
 	fclose(fp);
 out_remove:


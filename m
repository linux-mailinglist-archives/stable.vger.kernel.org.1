Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25599775AD1
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjHILMD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjHILLu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:11:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D8ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CE176237C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7ABC433C9;
        Wed,  9 Aug 2023 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579506;
        bh=+/8bry9tSAI8+yrLRlxSztnIRn2SmQmouel174CbZUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L34ghHAuLGYWahVWFTHdv8n2gfQNoFvRIFb3qTz43Djw4wH/vik3L1bRbxOztIthU
         l4aCdq5DHnLrbs+YY5ZR2/sf8P3aNdFf6y7AR32eJjlqU6WAU7oNR+O6ktrnsVTi35
         Ifzxg58nMdk+vvDlMsYaHMjKqUQM2qsn4gWRvmyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Kalle Valo <kvalo@codeaurora.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4.19 008/323] treewide: Remove uninitialized_var() usage
Date:   Wed,  9 Aug 2023 12:37:26 +0200
Message-ID: <20230809103658.479826788@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit 3f649ab728cda8038259d8f14492fe400fbab911 upstream.

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings
(e.g. "unused variable"). If the compiler thinks it is uninitialized,
either simply initialize the variable or make compiler changes.

In preparation for removing[2] the[3] macro[4], remove all remaining
needless uses with the following script:

git grep '\buninitialized_var\b' | cut -d: -f1 | sort -u | \
	xargs perl -pi -e \
		's/\buninitialized_var\(([^\)]+)\)/\1/g;
		 s:\s*/\* (GCC be quiet|to make compiler happy) \*/$::g;'

drivers/video/fbdev/riva/riva_hw.c was manually tweaked to avoid
pathological white-space.

No outstanding warnings were found building allmodconfig with GCC 9.3.0
for x86_64, i386, arm64, arm, powerpc, powerpc64le, s390x, mips, sparc64,
alpha, and m68k.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Reviewed-by: Leon Romanovsky <leonro@mellanox.com> # drivers/infiniband and mlx4/mlx5
Acked-by: Jason Gunthorpe <jgg@mellanox.com> # IB
Acked-by: Kalle Valo <kvalo@codeaurora.org> # wireless drivers
Reviewed-by: Chao Yu <yuchao0@huawei.com> # erofs
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-sa1100/assabet.c                      |    2 +-
 arch/ia64/kernel/process.c                          |    2 +-
 arch/ia64/mm/discontig.c                            |    2 +-
 arch/ia64/mm/tlb.c                                  |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c           |    2 +-
 arch/s390/kernel/smp.c                              |    2 +-
 arch/x86/kernel/quirks.c                            |   10 +++++-----
 drivers/acpi/acpi_pad.c                             |    2 +-
 drivers/ata/libata-scsi.c                           |    2 +-
 drivers/atm/zatm.c                                  |    2 +-
 drivers/block/drbd/drbd_nl.c                        |    6 +++---
 drivers/clk/clk-gate.c                              |    2 +-
 drivers/firewire/ohci.c                             |   14 +++++++-------
 drivers/gpu/drm/bridge/sil-sii8620.c                |    2 +-
 drivers/gpu/drm/drm_edid.c                          |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c             |    6 +++---
 drivers/i2c/busses/i2c-rk3x.c                       |    2 +-
 drivers/ide/ide-acpi.c                              |    2 +-
 drivers/ide/ide-atapi.c                             |    2 +-
 drivers/ide/ide-io-std.c                            |    4 ++--
 drivers/ide/ide-io.c                                |    8 ++++----
 drivers/ide/ide-sysfs.c                             |    2 +-
 drivers/ide/umc8672.c                               |    2 +-
 drivers/infiniband/core/uverbs_cmd.c                |    4 ++--
 drivers/infiniband/hw/cxgb4/cm.c                    |    2 +-
 drivers/infiniband/hw/cxgb4/cq.c                    |    2 +-
 drivers/infiniband/hw/mlx4/qp.c                     |    6 +++---
 drivers/infiniband/hw/mlx5/cq.c                     |    2 +-
 drivers/infiniband/hw/mthca/mthca_qp.c              |   10 +++++-----
 drivers/input/serio/serio_raw.c                     |    2 +-
 drivers/md/dm-io.c                                  |    2 +-
 drivers/md/dm-ioctl.c                               |    2 +-
 drivers/md/dm-snap-persistent.c                     |    2 +-
 drivers/md/dm-table.c                               |    2 +-
 drivers/md/raid5.c                                  |    2 +-
 drivers/media/dvb-frontends/rtl2832.c               |    2 +-
 drivers/media/tuners/qt1010.c                       |    4 ++--
 drivers/media/usb/gspca/vicam.c                     |    2 +-
 drivers/media/usb/uvc/uvc_video.c                   |    8 ++++----
 drivers/memstick/host/jmb38x_ms.c                   |    2 +-
 drivers/memstick/host/tifm_ms.c                     |    2 +-
 drivers/mmc/host/sdhci.c                            |    2 +-
 drivers/mtd/nand/raw/nand_ecc.c                     |    2 +-
 drivers/mtd/nand/raw/s3c2410.c                      |    2 +-
 drivers/mtd/ubi/eba.c                               |    2 +-
 drivers/net/can/janz-ican3.c                        |    2 +-
 drivers/net/ethernet/broadcom/bnx2.c                |    4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c |    4 ++--
 drivers/net/ethernet/neterion/s2io.c                |    2 +-
 drivers/net/ethernet/qlogic/qla3xxx.c               |    2 +-
 drivers/net/ethernet/sun/cassini.c                  |    2 +-
 drivers/net/ethernet/sun/niu.c                      |    6 +++---
 drivers/net/wan/z85230.c                            |    2 +-
 drivers/net/wireless/ath/ath10k/core.c              |    2 +-
 drivers/net/wireless/ath/ath6kl/init.c              |    2 +-
 drivers/net/wireless/ath/ath9k/init.c               |    2 +-
 drivers/net/wireless/broadcom/b43/debugfs.c         |    2 +-
 drivers/net/wireless/broadcom/b43/dma.c             |    2 +-
 drivers/net/wireless/broadcom/b43/lo.c              |    2 +-
 drivers/net/wireless/broadcom/b43/phy_n.c           |    2 +-
 drivers/net/wireless/broadcom/b43/xmit.c            |   12 ++++++------
 drivers/net/wireless/broadcom/b43legacy/debugfs.c   |    2 +-
 drivers/net/wireless/broadcom/b43legacy/main.c      |    2 +-
 drivers/net/wireless/intel/iwlegacy/3945.c          |    2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c      |    2 +-
 drivers/platform/x86/hdaps.c                        |    4 ++--
 drivers/scsi/dc395x.c                               |    2 +-
 drivers/scsi/pm8001/pm8001_hwi.c                    |    2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c                    |    2 +-
 drivers/ssb/driver_chipcommon.c                     |    4 ++--
 drivers/tty/cyclades.c                              |    2 +-
 drivers/tty/isicom.c                                |    2 +-
 drivers/usb/musb/cppi_dma.c                         |    2 +-
 drivers/usb/storage/sddr55.c                        |    4 ++--
 drivers/vhost/net.c                                 |    4 ++--
 drivers/video/fbdev/matrox/matroxfb_maven.c         |    6 +++---
 drivers/video/fbdev/pm3fb.c                         |    6 +++---
 drivers/video/fbdev/riva/riva_hw.c                  |    3 +--
 drivers/virtio/virtio_ring.c                        |    2 +-
 fs/afs/dir.c                                        |    2 +-
 fs/afs/security.c                                   |    2 +-
 fs/dlm/netlink.c                                    |    2 +-
 fs/fat/dir.c                                        |    2 +-
 fs/fuse/control.c                                   |    2 +-
 fs/fuse/cuse.c                                      |    2 +-
 fs/fuse/file.c                                      |    2 +-
 fs/gfs2/aops.c                                      |    2 +-
 fs/gfs2/bmap.c                                      |    2 +-
 fs/hfsplus/unicode.c                                |    2 +-
 fs/isofs/namei.c                                    |    4 ++--
 fs/jffs2/erase.c                                    |    2 +-
 fs/nfsd/nfsctl.c                                    |    2 +-
 fs/ocfs2/alloc.c                                    |    4 ++--
 fs/ocfs2/dir.c                                      |   14 +++++++-------
 fs/ocfs2/extent_map.c                               |    4 ++--
 fs/ocfs2/namei.c                                    |    2 +-
 fs/ocfs2/refcounttree.c                             |    2 +-
 fs/ocfs2/xattr.c                                    |    2 +-
 fs/omfs/file.c                                      |    2 +-
 fs/overlayfs/copy_up.c                              |    2 +-
 fs/ubifs/commit.c                                   |    6 +++---
 fs/ubifs/dir.c                                      |    2 +-
 fs/ubifs/file.c                                     |    4 ++--
 fs/ubifs/journal.c                                  |    2 +-
 fs/ubifs/lpt.c                                      |    2 +-
 fs/ubifs/tnc.c                                      |    6 +++---
 fs/ubifs/tnc_misc.c                                 |    4 ++--
 fs/udf/balloc.c                                     |    2 +-
 fs/xfs/xfs_bmap_util.c                              |    2 +-
 kernel/async.c                                      |    4 ++--
 kernel/audit.c                                      |    2 +-
 kernel/dma/debug.c                                  |    2 +-
 kernel/events/core.c                                |    2 +-
 kernel/events/uprobes.c                             |    2 +-
 kernel/exit.c                                       |    2 +-
 kernel/futex.c                                      |   12 ++++++------
 kernel/locking/lockdep.c                            |    6 +++---
 kernel/trace/ring_buffer.c                          |    2 +-
 lib/radix-tree.c                                    |    2 +-
 mm/frontswap.c                                      |    2 +-
 mm/ksm.c                                            |    2 +-
 mm/memcontrol.c                                     |    2 +-
 mm/mempolicy.c                                      |    4 ++--
 mm/percpu.c                                         |    2 +-
 mm/slub.c                                           |    4 ++--
 mm/swap.c                                           |    4 ++--
 net/dccp/options.c                                  |    2 +-
 net/ipv4/netfilter/nf_socket_ipv4.c                 |    6 +++---
 net/ipv6/ip6_flowlabel.c                            |    2 +-
 net/ipv6/netfilter/nf_socket_ipv6.c                 |    2 +-
 net/netfilter/nf_conntrack_ftp.c                    |    2 +-
 net/netfilter/nfnetlink_log.c                       |    2 +-
 net/netfilter/nfnetlink_queue.c                     |    4 ++--
 net/sched/cls_flow.c                                |    2 +-
 net/sched/sch_cake.c                                |    2 +-
 net/sched/sch_cbq.c                                 |    2 +-
 net/sched/sch_fq_codel.c                            |    2 +-
 net/sched/sch_sfq.c                                 |    2 +-
 sound/core/control_compat.c                         |    2 +-
 sound/isa/sb/sb16_csp.c                             |    2 +-
 sound/usb/endpoint.c                                |    2 +-
 141 files changed, 216 insertions(+), 217 deletions(-)

--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -570,7 +570,7 @@ static void __init map_sa1100_gpio_regs(
  */
 static void __init get_assabet_scr(void)
 {
-	unsigned long uninitialized_var(scr), i;
+	unsigned long scr, i;
 
 	GPDR |= 0x3fc;			/* Configure GPIO 9:2 as outputs */
 	GPSR = 0x3fc;			/* Write 0xFF to GPIO 9:2 */
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -444,7 +444,7 @@ static void
 do_copy_task_regs (struct task_struct *task, struct unw_frame_info *info, void *arg)
 {
 	unsigned long mask, sp, nat_bits = 0, ar_rnat, urbs_end, cfm;
-	unsigned long uninitialized_var(ip);	/* GCC be quiet */
+	unsigned long ip;
 	elf_greg_t *dst = arg;
 	struct pt_regs *pt;
 	char nat;
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -181,7 +181,7 @@ static void *per_cpu_node_setup(void *cp
 void __init setup_per_cpu_areas(void)
 {
 	struct pcpu_alloc_info *ai;
-	struct pcpu_group_info *uninitialized_var(gi);
+	struct pcpu_group_info *gi;
 	unsigned int *cpu_map;
 	void *base;
 	unsigned long base_offset;
--- a/arch/ia64/mm/tlb.c
+++ b/arch/ia64/mm/tlb.c
@@ -339,7 +339,7 @@ EXPORT_SYMBOL(flush_tlb_range);
 
 void ia64_tlb_init(void)
 {
-	ia64_ptce_info_t uninitialized_var(ptce_info); /* GCC be quiet */
+	ia64_ptce_info_t ptce_info;
 	u64 tr_pgbits;
 	long status;
 	pal_vm_info_1_u_t vm_info_1;
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -340,7 +340,7 @@ static int mpc52xx_irqhost_map(struct ir
 {
 	int l1irq;
 	int l2irq;
-	struct irq_chip *uninitialized_var(irqchip);
+	struct irq_chip *irqchip;
 	void *hndlr;
 	int type;
 	u32 reg;
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -145,7 +145,7 @@ static int pcpu_sigp_retry(struct pcpu *
 
 static inline int pcpu_stopped(struct pcpu *pcpu)
 {
-	u32 uninitialized_var(status);
+	u32 status;
 
 	if (__pcpu_sigp(pcpu->address, SIGP_SENSE,
 			0, &status) != SIGP_CC_STATUS_STORED)
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -96,7 +96,7 @@ static void ich_force_hpet_resume(void)
 static void ich_force_enable_hpet(struct pci_dev *dev)
 {
 	u32 val;
-	u32 uninitialized_var(rcba);
+	u32 rcba;
 	int err = 0;
 
 	if (hpet_address || force_hpet_address)
@@ -186,7 +186,7 @@ static void hpet_print_force_info(void)
 static void old_ich_force_hpet_resume(void)
 {
 	u32 val;
-	u32 uninitialized_var(gen_cntl);
+	u32 gen_cntl;
 
 	if (!force_hpet_address || !cached_dev)
 		return;
@@ -208,7 +208,7 @@ static void old_ich_force_hpet_resume(vo
 static void old_ich_force_enable_hpet(struct pci_dev *dev)
 {
 	u32 val;
-	u32 uninitialized_var(gen_cntl);
+	u32 gen_cntl;
 
 	if (hpet_address || force_hpet_address)
 		return;
@@ -299,7 +299,7 @@ static void vt8237_force_hpet_resume(voi
 
 static void vt8237_force_enable_hpet(struct pci_dev *dev)
 {
-	u32 uninitialized_var(val);
+	u32 val;
 
 	if (hpet_address || force_hpet_address)
 		return;
@@ -430,7 +430,7 @@ static void nvidia_force_hpet_resume(voi
 
 static void nvidia_force_enable_hpet(struct pci_dev *dev)
 {
-	u32 uninitialized_var(val);
+	u32 val;
 
 	if (hpet_address || force_hpet_address)
 		return;
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -95,7 +95,7 @@ static void round_robin_cpu(unsigned int
 	cpumask_var_t tmp;
 	int cpu;
 	unsigned long min_weight = -1;
-	unsigned long uninitialized_var(preferred_cpu);
+	unsigned long preferred_cpu;
 
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return;
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -178,7 +178,7 @@ static ssize_t ata_scsi_park_show(struct
 	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned long now;
-	unsigned int uninitialized_var(msecs);
+	unsigned int msecs;
 	int rc = 0;
 
 	ap = ata_shost_to_port(sdev->host);
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -939,7 +939,7 @@ static int open_tx_first(struct atm_vcc
 	    vcc->qos.txtp.max_pcr >= ATM_OC3_PCR);
 	if (unlimited && zatm_dev->ubr != -1) zatm_vcc->shaper = zatm_dev->ubr;
 	else {
-		int uninitialized_var(pcr);
+		int pcr;
 
 		if (unlimited) vcc->qos.txtp.max_sdu = ATM_MAX_AAL5_PDU;
 		if ((zatm_vcc->shaper = alloc_shaper(vcc->dev,&pcr,
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3394,7 +3394,7 @@ int drbd_adm_dump_devices(struct sk_buff
 {
 	struct nlattr *resource_filter;
 	struct drbd_resource *resource;
-	struct drbd_device *uninitialized_var(device);
+	struct drbd_device *device;
 	int minor, err, retcode;
 	struct drbd_genlmsghdr *dh;
 	struct device_info device_info;
@@ -3483,7 +3483,7 @@ int drbd_adm_dump_connections(struct sk_
 {
 	struct nlattr *resource_filter;
 	struct drbd_resource *resource = NULL, *next_resource;
-	struct drbd_connection *uninitialized_var(connection);
+	struct drbd_connection *connection;
 	int err = 0, retcode;
 	struct drbd_genlmsghdr *dh;
 	struct connection_info connection_info;
@@ -3645,7 +3645,7 @@ int drbd_adm_dump_peer_devices(struct sk
 {
 	struct nlattr *resource_filter;
 	struct drbd_resource *resource;
-	struct drbd_device *uninitialized_var(device);
+	struct drbd_device *device;
 	struct drbd_peer_device *peer_device = NULL;
 	int minor, err, retcode;
 	struct drbd_genlmsghdr *dh;
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -43,7 +43,7 @@ static void clk_gate_endisable(struct cl
 {
 	struct clk_gate *gate = to_clk_gate(hw);
 	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 	u32 reg;
 
 	set ^= enable;
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1112,7 +1112,7 @@ static void context_tasklet(unsigned lon
 static int context_add_buffer(struct context *ctx)
 {
 	struct descriptor_buffer *desc;
-	dma_addr_t uninitialized_var(bus_addr);
+	dma_addr_t bus_addr;
 	int offset;
 
 	/*
@@ -1302,7 +1302,7 @@ static int at_context_queue_packet(struc
 				   struct fw_packet *packet)
 {
 	struct fw_ohci *ohci = ctx->ohci;
-	dma_addr_t d_bus, uninitialized_var(payload_bus);
+	dma_addr_t d_bus, payload_bus;
 	struct driver_data *driver_data;
 	struct descriptor *d, *last;
 	__le32 *header;
@@ -2458,7 +2458,7 @@ static int ohci_set_config_rom(struct fw
 {
 	struct fw_ohci *ohci;
 	__be32 *next_config_rom;
-	dma_addr_t uninitialized_var(next_config_rom_bus);
+	dma_addr_t next_config_rom_bus;
 
 	ohci = fw_ohci(card);
 
@@ -2947,10 +2947,10 @@ static struct fw_iso_context *ohci_alloc
 				int type, int channel, size_t header_size)
 {
 	struct fw_ohci *ohci = fw_ohci(card);
-	struct iso_context *uninitialized_var(ctx);
-	descriptor_callback_t uninitialized_var(callback);
-	u64 *uninitialized_var(channels);
-	u32 *uninitialized_var(mask), uninitialized_var(regs);
+	struct iso_context *ctx;
+	descriptor_callback_t callback;
+	u64 *channels;
+	u32 *mask, regs;
 	int index, ret = -EBUSY;
 
 	spin_lock_irq(&ohci->lock);
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -988,7 +988,7 @@ static void sii8620_set_auto_zone(struct
 
 static void sii8620_stop_video(struct sii8620 *ctx)
 {
-	u8 uninitialized_var(val);
+	u8 val;
 
 	sii8620_write_seq_static(ctx,
 		REG_TPI_INTR_EN, 0,
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2778,7 +2778,7 @@ static int drm_cvt_modes(struct drm_conn
 	const u8 empty[3] = { 0, 0, 0 };
 
 	for (i = 0; i < 4; i++) {
-		int uninitialized_var(width), height;
+		int width, height;
 		cvt = &(timing->data.other_data.data.cvt[i]);
 
 		if (!memcmp(cvt->code, empty, 3))
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -544,9 +544,9 @@ static unsigned long exynos_dsi_pll_find
 	unsigned long best_freq = 0;
 	u32 min_delta = 0xffffffff;
 	u8 p_min, p_max;
-	u8 _p, uninitialized_var(best_p);
-	u16 _m, uninitialized_var(best_m);
-	u8 _s, uninitialized_var(best_s);
+	u8 _p, best_p;
+	u16 _m, best_m;
+	u8 _s, best_s;
 
 	p_min = DIV_ROUND_UP(fin, (12 * MHZ));
 	p_max = fin / (6 * MHZ);
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -421,7 +421,7 @@ static void rk3x_i2c_handle_read(struct
 {
 	unsigned int i;
 	unsigned int len = i2c->msg->len - i2c->processed;
-	u32 uninitialized_var(val);
+	u32 val;
 	u8 byte;
 
 	/* we only care for MBRF here. */
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -180,7 +180,7 @@ err:
 static acpi_handle ide_acpi_hwif_get_handle(ide_hwif_t *hwif)
 {
 	struct device		*dev = hwif->gendev.parent;
-	acpi_handle		uninitialized_var(dev_handle);
+	acpi_handle		dev_handle;
 	u64			pcidevfn;
 	acpi_handle		chan_handle;
 	int			err;
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -591,7 +591,7 @@ static int ide_delayed_transfer_pc(ide_d
 
 static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 {
-	struct ide_atapi_pc *uninitialized_var(pc);
+	struct ide_atapi_pc *pc;
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = hwif->rq;
 	ide_expiry_t *expiry;
--- a/drivers/ide/ide-io-std.c
+++ b/drivers/ide/ide-io-std.c
@@ -172,7 +172,7 @@ void ide_input_data(ide_drive_t *drive,
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
 	if (io_32bit) {
-		unsigned long uninitialized_var(flags);
+		unsigned long flags;
 
 		if ((io_32bit & 2) && !mmio) {
 			local_irq_save(flags);
@@ -216,7 +216,7 @@ void ide_output_data(ide_drive_t *drive,
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
 	if (io_32bit) {
-		unsigned long uninitialized_var(flags);
+		unsigned long flags;
 
 		if ((io_32bit & 2) && !mmio) {
 			local_irq_save(flags);
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -605,12 +605,12 @@ static int drive_is_ready(ide_drive_t *d
 void ide_timer_expiry (struct timer_list *t)
 {
 	ide_hwif_t	*hwif = from_timer(hwif, t, timer);
-	ide_drive_t	*uninitialized_var(drive);
+	ide_drive_t	*drive;
 	ide_handler_t	*handler;
 	unsigned long	flags;
 	int		wait = -1;
 	int		plug_device = 0;
-	struct request	*uninitialized_var(rq_in_flight);
+	struct request	*rq_in_flight;
 
 	spin_lock_irqsave(&hwif->lock, flags);
 
@@ -763,13 +763,13 @@ irqreturn_t ide_intr (int irq, void *dev
 {
 	ide_hwif_t *hwif = (ide_hwif_t *)dev_id;
 	struct ide_host *host = hwif->host;
-	ide_drive_t *uninitialized_var(drive);
+	ide_drive_t *drive;
 	ide_handler_t *handler;
 	unsigned long flags;
 	ide_startstop_t startstop;
 	irqreturn_t irq_ret = IRQ_NONE;
 	int plug_device = 0;
-	struct request *uninitialized_var(rq_in_flight);
+	struct request *rq_in_flight;
 
 	if (host->host_flags & IDE_HFLAG_SERIALIZE) {
 		if (hwif != host->cur_port)
--- a/drivers/ide/ide-sysfs.c
+++ b/drivers/ide/ide-sysfs.c
@@ -131,7 +131,7 @@ static struct device_attribute *ide_port
 
 int ide_sysfs_register_port(ide_hwif_t *hwif)
 {
-	int i, uninitialized_var(rc);
+	int i, rc;
 
 	for (i = 0; ide_port_attrs[i]; i++) {
 		rc = device_create_file(hwif->portdev, ide_port_attrs[i]);
--- a/drivers/ide/umc8672.c
+++ b/drivers/ide/umc8672.c
@@ -107,7 +107,7 @@ static void umc_set_speeds(u8 speeds[])
 static void umc_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 {
 	ide_hwif_t *mate = hwif->mate;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 	const u8 pio = drive->pio_mode - XFER_PIO_0;
 
 	printk("%s: setting umc8672 to PIO mode%d (speed %d)\n",
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1726,7 +1726,7 @@ ssize_t ib_uverbs_open_qp(struct ib_uver
 	struct ib_udata                 udata;
 	struct ib_uqp_object           *obj;
 	struct ib_xrcd		       *xrcd;
-	struct ib_uobject	       *uninitialized_var(xrcd_uobj);
+	struct ib_uobject	       *xrcd_uobj;
 	struct ib_qp                   *qp;
 	struct ib_qp_open_attr          attr;
 	int ret;
@@ -3694,7 +3694,7 @@ static int __uverbs_create_xsrq(struct i
 	struct ib_usrq_object           *obj;
 	struct ib_pd                    *pd;
 	struct ib_srq                   *srq;
-	struct ib_uobject               *uninitialized_var(xrcd_uobj);
+	struct ib_uobject               *xrcd_uobj;
 	struct ib_srq_init_attr          attr;
 	int ret;
 	struct ib_device *ib_dev;
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -3195,7 +3195,7 @@ static int get_lladdr(struct net_device
 
 static int pick_local_ip6addrs(struct c4iw_dev *dev, struct iw_cm_id *cm_id)
 {
-	struct in6_addr uninitialized_var(addr);
+	struct in6_addr addr;
 	struct sockaddr_in6 *la6 = (struct sockaddr_in6 *)&cm_id->m_local_addr;
 	struct sockaddr_in6 *ra6 = (struct sockaddr_in6 *)&cm_id->m_remote_addr;
 
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -755,7 +755,7 @@ skip_cqe:
 static int __c4iw_poll_cq_one(struct c4iw_cq *chp, struct c4iw_qp *qhp,
 			      struct ib_wc *wc, struct c4iw_srq *srq)
 {
-	struct t4_cqe uninitialized_var(cqe);
+	struct t4_cqe cqe;
 	struct t4_wq *wq = qhp ? &qhp->wq : NULL;
 	u32 credit = 0;
 	u8 cqe_flushed;
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -3463,11 +3463,11 @@ static int _mlx4_ib_post_send(struct ib_
 	int nreq;
 	int err = 0;
 	unsigned ind;
-	int uninitialized_var(size);
-	unsigned uninitialized_var(seglen);
+	int size;
+	unsigned seglen;
 	__be32 dummy;
 	__be32 *lso_wqe;
-	__be32 uninitialized_var(lso_hdr_sz);
+	__be32 lso_hdr_sz;
 	__be32 blh;
 	int i;
 	struct mlx4_ib_dev *mdev = to_mdev(ibqp->device);
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1333,7 +1333,7 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq
 	__be64 *pas;
 	int page_shift;
 	int inlen;
-	int uninitialized_var(cqe_size);
+	int cqe_size;
 	unsigned long flags;
 
 	if (!MLX5_CAP_GEN(dev->mdev, cq_resize)) {
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1630,8 +1630,8 @@ int mthca_tavor_post_send(struct ib_qp *
 	 * without initializing f0 and size0, and they are in fact
 	 * never used uninitialized.
 	 */
-	int uninitialized_var(size0);
-	u32 uninitialized_var(f0);
+	int size0;
+	u32 f0;
 	int ind;
 	u8 op0 = 0;
 
@@ -1831,7 +1831,7 @@ int mthca_tavor_post_receive(struct ib_q
 	 * without initializing size0, and it is in fact never used
 	 * uninitialized.
 	 */
-	int uninitialized_var(size0);
+	int size0;
 	int ind;
 	void *wqe;
 	void *prev_wqe;
@@ -1945,8 +1945,8 @@ int mthca_arbel_post_send(struct ib_qp *
 	 * without initializing f0 and size0, and they are in fact
 	 * never used uninitialized.
 	 */
-	int uninitialized_var(size0);
-	u32 uninitialized_var(f0);
+	int size0;
+	u32 f0;
 	int ind;
 	u8 op0 = 0;
 
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -162,7 +162,7 @@ static ssize_t serio_raw_read(struct fil
 {
 	struct serio_raw_client *client = file->private_data;
 	struct serio_raw *serio_raw = client->serio_raw;
-	char uninitialized_var(c);
+	char c;
 	ssize_t read = 0;
 	int error;
 
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -306,7 +306,7 @@ static void do_region(int op, int op_fla
 	struct request_queue *q = bdev_get_queue(where->bdev);
 	unsigned short logical_block_size = queue_logical_block_size(q);
 	sector_t num_sectors;
-	unsigned int uninitialized_var(special_cmd_max_sectors);
+	unsigned int special_cmd_max_sectors;
 
 	/*
 	 * Reject unsupported discard and write same requests.
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1822,7 +1822,7 @@ static int ctl_ioctl(struct file *file,
 	int ioctl_flags;
 	int param_flags;
 	unsigned int cmd;
-	struct dm_ioctl *uninitialized_var(param);
+	struct dm_ioctl *param;
 	ioctl_fn fn = NULL;
 	size_t input_param_size;
 	struct dm_ioctl param_kernel;
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -613,7 +613,7 @@ static int persistent_read_metadata(stru
 						    chunk_t old, chunk_t new),
 				    void *callback_context)
 {
-	int r, uninitialized_var(new_snapshot);
+	int r, new_snapshot;
 	struct pstore *ps = get_info(store);
 
 	/*
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -671,7 +671,7 @@ static int validate_hardware_logical_blo
 	 */
 	unsigned short remaining = 0;
 
-	struct dm_target *uninitialized_var(ti);
+	struct dm_target *ti;
 	struct queue_limits ti_limits;
 	unsigned i;
 
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2603,7 +2603,7 @@ static void raid5_end_write_request(stru
 	struct stripe_head *sh = bi->bi_private;
 	struct r5conf *conf = sh->raid_conf;
 	int disks = sh->disks, i;
-	struct md_rdev *uninitialized_var(rdev);
+	struct md_rdev *rdev;
 	sector_t first_bad;
 	int bad_sectors;
 	int replacement = 0;
--- a/drivers/media/dvb-frontends/rtl2832.c
+++ b/drivers/media/dvb-frontends/rtl2832.c
@@ -653,7 +653,7 @@ static int rtl2832_read_status(struct dv
 	struct i2c_client *client = dev->client;
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
 	int ret;
-	u32 uninitialized_var(tmp);
+	u32 tmp;
 	u8 u8tmp, buf[2];
 	u16 u16tmp;
 
--- a/drivers/media/tuners/qt1010.c
+++ b/drivers/media/tuners/qt1010.c
@@ -224,7 +224,7 @@ static int qt1010_set_params(struct dvb_
 static int qt1010_init_meas1(struct qt1010_priv *priv,
 			     u8 oper, u8 reg, u8 reg_init_val, u8 *retval)
 {
-	u8 i, val1, uninitialized_var(val2);
+	u8 i, val1, val2;
 	int err;
 
 	qt1010_i2c_oper_t i2c_data[] = {
@@ -259,7 +259,7 @@ static int qt1010_init_meas1(struct qt10
 static int qt1010_init_meas2(struct qt1010_priv *priv,
 			    u8 reg_init_val, u8 *retval)
 {
-	u8 i, uninitialized_var(val);
+	u8 i, val;
 	int err;
 	qt1010_i2c_oper_t i2c_data[] = {
 		{ QT1010_WR, 0x07, reg_init_val },
--- a/drivers/media/usb/gspca/vicam.c
+++ b/drivers/media/usb/gspca/vicam.c
@@ -234,7 +234,7 @@ static int sd_init(struct gspca_dev *gsp
 {
 	int ret;
 	const struct ihex_binrec *rec;
-	const struct firmware *uninitialized_var(fw);
+	const struct firmware *fw;
 	u8 *firmware_buf;
 
 	ret = request_ihex_firmware(&fw, VICAM_FIRMWARE,
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -802,9 +802,9 @@ static void uvc_video_stats_decode(struc
 	unsigned int header_size;
 	bool has_pts = false;
 	bool has_scr = false;
-	u16 uninitialized_var(scr_sof);
-	u32 uninitialized_var(scr_stc);
-	u32 uninitialized_var(pts);
+	u16 scr_sof;
+	u32 scr_stc;
+	u32 pts;
 
 	if (stream->stats.stream.nb_frames == 0 &&
 	    stream->stats.frame.nb_packets == 0)
@@ -1801,7 +1801,7 @@ static int uvc_init_video(struct uvc_str
 		struct usb_host_endpoint *best_ep = NULL;
 		unsigned int best_psize = UINT_MAX;
 		unsigned int bandwidth;
-		unsigned int uninitialized_var(altsetting);
+		unsigned int altsetting;
 		int intfnum = stream->intfnum;
 
 		/* Isochronous endpoint, select the alternate setting. */
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -316,7 +316,7 @@ static int jmb38x_ms_transfer_data(struc
 	}
 
 	while (length) {
-		unsigned int uninitialized_var(p_off);
+		unsigned int p_off;
 
 		if (host->req->long_data) {
 			pg = nth_page(sg_page(&host->req->sg),
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -200,7 +200,7 @@ static unsigned int tifm_ms_transfer_dat
 		host->block_pos);
 
 	while (length) {
-		unsigned int uninitialized_var(p_off);
+		unsigned int p_off;
 
 		if (host->req->long_data) {
 			pg = nth_page(sg_page(&host->req->sg),
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -374,7 +374,7 @@ static void sdhci_read_block_pio(struct
 {
 	unsigned long flags;
 	size_t blksize, len, chunk;
-	u32 uninitialized_var(scratch);
+	u32 scratch;
 	u8 *buf;
 
 	DBG("PIO reading\n");
--- a/drivers/mtd/nand/raw/nand_ecc.c
+++ b/drivers/mtd/nand/raw/nand_ecc.c
@@ -144,7 +144,7 @@ void __nand_calculate_ecc(const unsigned
 	/* rp0..rp15..rp17 are the various accumulated parities (per byte) */
 	uint32_t rp0, rp1, rp2, rp3, rp4, rp5, rp6, rp7;
 	uint32_t rp8, rp9, rp10, rp11, rp12, rp13, rp14, rp15, rp16;
-	uint32_t uninitialized_var(rp17);	/* to make compiler happy */
+	uint32_t rp17;
 	uint32_t par;		/* the cumulative parity for all data */
 	uint32_t tmppar;	/* the cumulative parity for this iteration;
 				   for rp12, rp14 and rp16 at the end of the
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -304,7 +304,7 @@ static int s3c2410_nand_setrate(struct s
 	int tacls_max = (info->cpu_type == TYPE_S3C2412) ? 8 : 4;
 	int tacls, twrph0, twrph1;
 	unsigned long clkrate = clk_get_rate(info->clk);
-	unsigned long uninitialized_var(set), cfg, uninitialized_var(mask);
+	unsigned long set, cfg, mask;
 	unsigned long flags;
 
 	/* calculate the timing information for the controller */
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -612,7 +612,7 @@ int ubi_eba_read_leb(struct ubi_device *
 	int err, pnum, scrub = 0, vol_id = vol->vol_id;
 	struct ubi_vid_io_buf *vidb;
 	struct ubi_vid_hdr *vid_hdr;
-	uint32_t uninitialized_var(crc);
+	uint32_t crc;
 
 	err = leb_read_lock(ubi, vol_id, lnum);
 	if (err)
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1455,7 +1455,7 @@ static int ican3_napi(struct napi_struct
 
 	/* process all communication messages */
 	while (true) {
-		struct ican3_msg uninitialized_var(msg);
+		struct ican3_msg msg;
 		ret = ican3_recv_msg(mod, &msg);
 		if (ret)
 			break;
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -1461,7 +1461,7 @@ bnx2_test_and_disable_2g5(struct bnx2 *b
 static void
 bnx2_enable_forced_2g5(struct bnx2 *bp)
 {
-	u32 uninitialized_var(bmcr);
+	u32 bmcr;
 	int err;
 
 	if (!(bp->phy_flags & BNX2_PHY_FLAG_2_5G_CAPABLE))
@@ -1505,7 +1505,7 @@ bnx2_enable_forced_2g5(struct bnx2 *bp)
 static void
 bnx2_disable_forced_2g5(struct bnx2 *bp)
 {
-	u32 uninitialized_var(bmcr);
+	u32 bmcr;
 	int err;
 
 	if (!(bp->phy_flags & BNX2_PHY_FLAG_2_5G_CAPABLE))
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -471,8 +471,8 @@ void mlx5_core_req_pages_handler(struct
 
 int mlx5_satisfy_startup_pages(struct mlx5_core_dev *dev, int boot)
 {
-	u16 uninitialized_var(func_id);
-	s32 uninitialized_var(npages);
+	u16 func_id;
+	s32 npages;
 	int err;
 
 	err = mlx5_cmd_query_pages(dev, &func_id, &npages, boot);
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -7291,7 +7291,7 @@ static int rx_osm_handler(struct ring_in
 	int ring_no = ring_data->ring_no;
 	u16 l3_csum, l4_csum;
 	unsigned long long err = rxdp->Control_1 & RXD_T_CODE;
-	struct lro *uninitialized_var(lro);
+	struct lro *lro;
 	u8 err_mask;
 	struct swStat *swstats = &sp->mac_control.stats_info->sw_stat;
 
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3771,7 +3771,7 @@ static int ql3xxx_probe(struct pci_dev *
 	struct net_device *ndev = NULL;
 	struct ql3_adapter *qdev = NULL;
 	static int cards_found;
-	int uninitialized_var(pci_using_dac), err;
+	int pci_using_dac, err;
 
 	err = pci_enable_device(pdev);
 	if (err) {
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -2291,7 +2291,7 @@ static int cas_rx_ringN(struct cas *cp,
 	drops = 0;
 	while (1) {
 		struct cas_rx_comp *rxc = rxcs + entry;
-		struct sk_buff *uninitialized_var(skb);
+		struct sk_buff *skb;
 		int type, len;
 		u64 words[4];
 		int i, dring;
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -429,7 +429,7 @@ static int serdes_init_niu_1g_serdes(str
 	struct niu_link_config *lp = &np->link_config;
 	u16 pll_cfg, pll_sts;
 	int max_retry = 100;
-	u64 uninitialized_var(sig), mask, val;
+	u64 sig, mask, val;
 	u32 tx_cfg, rx_cfg;
 	unsigned long i;
 	int err;
@@ -526,7 +526,7 @@ static int serdes_init_niu_10g_serdes(st
 	struct niu_link_config *lp = &np->link_config;
 	u32 tx_cfg, rx_cfg, pll_cfg, pll_sts;
 	int max_retry = 100;
-	u64 uninitialized_var(sig), mask, val;
+	u64 sig, mask, val;
 	unsigned long i;
 	int err;
 
@@ -714,7 +714,7 @@ static int esr_write_glue0(struct niu *n
 
 static int esr_reset(struct niu *np)
 {
-	u32 uninitialized_var(reset);
+	u32 reset;
 	int err;
 
 	err = mdio_write(np, np->port, NIU_ESR_DEV_ADDR,
--- a/drivers/net/wan/z85230.c
+++ b/drivers/net/wan/z85230.c
@@ -705,7 +705,7 @@ EXPORT_SYMBOL(z8530_nop);
 irqreturn_t z8530_interrupt(int irq, void *dev_id)
 {
 	struct z8530_dev *dev=dev_id;
-	u8 uninitialized_var(intr);
+	u8 intr;
 	static volatile int locker=0;
 	int work=0;
 	struct z8530_irqhandler *irqs;
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1891,7 +1891,7 @@ static int ath10k_init_uart(struct ath10
 
 static int ath10k_init_hw_params(struct ath10k *ar)
 {
-	const struct ath10k_hw_params *uninitialized_var(hw_params);
+	const struct ath10k_hw_params *hw_params;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(ath10k_hw_params_list); i++) {
--- a/drivers/net/wireless/ath/ath6kl/init.c
+++ b/drivers/net/wireless/ath/ath6kl/init.c
@@ -1575,7 +1575,7 @@ static int ath6kl_init_upload(struct ath
 
 int ath6kl_init_hw_params(struct ath6kl *ar)
 {
-	const struct ath6kl_hw *uninitialized_var(hw);
+	const struct ath6kl_hw *hw;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(hw_list); i++) {
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -230,7 +230,7 @@ static unsigned int ath9k_reg_rmw(void *
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
 	struct ath_softc *sc = (struct ath_softc *) common->priv;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 	u32 val;
 
 	if (NR_CPUS > 1 && ah->config.serialize_regmode == SER_REG_MODE_ON) {
--- a/drivers/net/wireless/broadcom/b43/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43/debugfs.c
@@ -506,7 +506,7 @@ static ssize_t b43_debugfs_read(struct f
 	struct b43_wldev *dev;
 	struct b43_debugfs_fops *dfops;
 	struct b43_dfs_file *dfile;
-	ssize_t uninitialized_var(ret);
+	ssize_t ret;
 	char *buf;
 	const size_t bufsize = 1024 * 16; /* 16 kiB buffer */
 	const size_t buforder = get_order(bufsize);
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -50,7 +50,7 @@
 static u32 b43_dma_address(struct b43_dma *dma, dma_addr_t dmaaddr,
 			   enum b43_addrtype addrtype)
 {
-	u32 uninitialized_var(addr);
+	u32 addr;
 
 	switch (addrtype) {
 	case B43_DMA_ADDR_LOW:
--- a/drivers/net/wireless/broadcom/b43/lo.c
+++ b/drivers/net/wireless/broadcom/b43/lo.c
@@ -742,7 +742,7 @@ struct b43_lo_calib *b43_calibrate_lo_se
 	};
 	int max_rx_gain;
 	struct b43_lo_calib *cal;
-	struct lo_g_saved_values uninitialized_var(saved_regs);
+	struct lo_g_saved_values saved_regs;
 	/* Values from the "TXCTL Register and Value Table" */
 	u16 txctl_reg;
 	u16 txctl_value;
--- a/drivers/net/wireless/broadcom/b43/phy_n.c
+++ b/drivers/net/wireless/broadcom/b43/phy_n.c
@@ -5655,7 +5655,7 @@ static int b43_nphy_rev2_cal_rx_iq(struc
 	u8 rfctl[2];
 	u8 afectl_core;
 	u16 tmp[6];
-	u16 uninitialized_var(cur_hpf1), uninitialized_var(cur_hpf2), cur_lna;
+	u16 cur_hpf1, cur_hpf2, cur_lna;
 	u32 real, imag;
 	enum nl80211_band band;
 
--- a/drivers/net/wireless/broadcom/b43/xmit.c
+++ b/drivers/net/wireless/broadcom/b43/xmit.c
@@ -435,10 +435,10 @@ int b43_generate_txhdr(struct b43_wldev
 	if ((rates[0].flags & IEEE80211_TX_RC_USE_RTS_CTS) ||
 	    (rates[0].flags & IEEE80211_TX_RC_USE_CTS_PROTECT)) {
 		unsigned int len;
-		struct ieee80211_hdr *uninitialized_var(hdr);
+		struct ieee80211_hdr *hdr;
 		int rts_rate, rts_rate_fb;
 		int rts_rate_ofdm, rts_rate_fb_ofdm;
-		struct b43_plcp_hdr6 *uninitialized_var(plcp);
+		struct b43_plcp_hdr6 *plcp;
 		struct ieee80211_rate *rts_cts_rate;
 
 		rts_cts_rate = ieee80211_get_rts_cts_rate(dev->wl->hw, info);
@@ -449,7 +449,7 @@ int b43_generate_txhdr(struct b43_wldev
 		rts_rate_fb_ofdm = b43_is_ofdm_rate(rts_rate_fb);
 
 		if (rates[0].flags & IEEE80211_TX_RC_USE_CTS_PROTECT) {
-			struct ieee80211_cts *uninitialized_var(cts);
+			struct ieee80211_cts *cts;
 
 			switch (dev->fw.hdr_format) {
 			case B43_FW_HDR_598:
@@ -471,7 +471,7 @@ int b43_generate_txhdr(struct b43_wldev
 			mac_ctl |= B43_TXH_MAC_SENDCTS;
 			len = sizeof(struct ieee80211_cts);
 		} else {
-			struct ieee80211_rts *uninitialized_var(rts);
+			struct ieee80211_rts *rts;
 
 			switch (dev->fw.hdr_format) {
 			case B43_FW_HDR_598:
@@ -663,8 +663,8 @@ void b43_rx(struct b43_wldev *dev, struc
 	const struct b43_rxhdr_fw4 *rxhdr = _rxhdr;
 	__le16 fctl;
 	u16 phystat0, phystat3;
-	u16 uninitialized_var(chanstat), uninitialized_var(mactime);
-	u32 uninitialized_var(macstat);
+	u16 chanstat, mactime;
+	u32 macstat;
 	u16 chanid;
 	int padding, rate_idx;
 
--- a/drivers/net/wireless/broadcom/b43legacy/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
@@ -203,7 +203,7 @@ static ssize_t b43legacy_debugfs_read(st
 	struct b43legacy_wldev *dev;
 	struct b43legacy_debugfs_fops *dfops;
 	struct b43legacy_dfs_file *dfile;
-	ssize_t uninitialized_var(ret);
+	ssize_t ret;
 	char *buf;
 	const size_t bufsize = 1024 * 16; /* 16 KiB buffer */
 	const size_t buforder = get_order(bufsize);
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -2612,7 +2612,7 @@ static void b43legacy_put_phy_into_reset
 static int b43legacy_switch_phymode(struct b43legacy_wl *wl,
 				      unsigned int new_mode)
 {
-	struct b43legacy_wldev *uninitialized_var(up_dev);
+	struct b43legacy_wldev *up_dev;
 	struct b43legacy_wldev *down_dev;
 	int err;
 	bool gmode = false;
--- a/drivers/net/wireless/intel/iwlegacy/3945.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945.c
@@ -2115,7 +2115,7 @@ il3945_txpower_set_from_eeprom(struct il
 
 		/* set tx power value for all OFDM rates */
 		for (rate_idx = 0; rate_idx < IL_OFDM_RATES; rate_idx++) {
-			s32 uninitialized_var(power_idx);
+			s32 power_idx;
 			int rc;
 
 			/* use channel group's clip-power table,
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -2784,7 +2784,7 @@ il4965_hdl_tx(struct il_priv *il, struct
 	struct ieee80211_tx_info *info;
 	struct il4965_tx_resp *tx_resp = (void *)&pkt->u.raw[0];
 	u32 status = le32_to_cpu(tx_resp->u.status);
-	int uninitialized_var(tid);
+	int tid;
 	int sta_id;
 	int freed;
 	u8 *qc = NULL;
--- a/drivers/platform/x86/hdaps.c
+++ b/drivers/platform/x86/hdaps.c
@@ -378,7 +378,7 @@ static ssize_t hdaps_variance_show(struc
 static ssize_t hdaps_temp1_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	u8 uninitialized_var(temp);
+	u8 temp;
 	int ret;
 
 	ret = hdaps_readb_one(HDAPS_PORT_TEMP1, &temp);
@@ -391,7 +391,7 @@ static ssize_t hdaps_temp1_show(struct d
 static ssize_t hdaps_temp2_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	u8 uninitialized_var(temp);
+	u8 temp;
 	int ret;
 
 	ret = hdaps_readb_one(HDAPS_PORT_TEMP2, &temp);
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -4275,7 +4275,7 @@ static int adapter_sg_tables_alloc(struc
 	const unsigned srbs_per_page = PAGE_SIZE/SEGMENTX_LEN;
 	int srb_idx = 0;
 	unsigned i = 0;
-	struct SGentry *uninitialized_var(ptr);
+	struct SGentry *ptr;
 
 	for (i = 0; i < DC395x_MAX_SRB_CNT; i++)
 		acb->srb_array[i].segment_x = NULL;
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4174,7 +4174,7 @@ static int process_oq(struct pm8001_hba_
 {
 	struct outbound_queue_table *circularQ;
 	void *pMsg1 = NULL;
-	u8 uninitialized_var(bc);
+	u8 bc;
 	u32 ret = MPI_IO_STATUS_FAIL;
 	unsigned long flags;
 
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3811,7 +3811,7 @@ static int process_oq(struct pm8001_hba_
 {
 	struct outbound_queue_table *circularQ;
 	void *pMsg1 = NULL;
-	u8 uninitialized_var(bc);
+	u8 bc;
 	u32 ret = MPI_IO_STATUS_FAIL;
 	unsigned long flags;
 	u32 regval;
--- a/drivers/ssb/driver_chipcommon.c
+++ b/drivers/ssb/driver_chipcommon.c
@@ -119,7 +119,7 @@ void ssb_chipco_set_clockmode(struct ssb
 static enum ssb_clksrc chipco_pctl_get_slowclksrc(struct ssb_chipcommon *cc)
 {
 	struct ssb_bus *bus = cc->dev->bus;
-	u32 uninitialized_var(tmp);
+	u32 tmp;
 
 	if (cc->dev->id.revision < 6) {
 		if (bus->bustype == SSB_BUSTYPE_SSB ||
@@ -149,7 +149,7 @@ static enum ssb_clksrc chipco_pctl_get_s
 /* Get maximum or minimum (depending on get_max flag) slowclock frequency. */
 static int chipco_pctl_clockfreqlimit(struct ssb_chipcommon *cc, int get_max)
 {
-	int uninitialized_var(limit);
+	int limit;
 	enum ssb_clksrc clocksrc;
 	int divisor = 1;
 	u32 tmp;
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -3648,7 +3648,7 @@ static int cy_pci_probe(struct pci_dev *
 	struct cyclades_card *card;
 	void __iomem *addr0 = NULL, *addr2 = NULL;
 	char *card_name = NULL;
-	u32 uninitialized_var(mailbox);
+	u32 mailbox;
 	unsigned int device_id, nchan = 0, card_no, i, j;
 	unsigned char plx_ver;
 	int retval, irq;
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -1537,7 +1537,7 @@ static unsigned int card_count;
 static int isicom_probe(struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
-	unsigned int uninitialized_var(signature), index;
+	unsigned int signature, index;
 	int retval = -EPERM;
 	struct isi_board *board = NULL;
 
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -1146,7 +1146,7 @@ irqreturn_t cppi_interrupt(int irq, void
 	struct musb_hw_ep	*hw_ep = NULL;
 	u32			rx, tx;
 	int			i, index;
-	unsigned long		uninitialized_var(flags);
+	unsigned long		flags;
 
 	cppi = container_of(musb->dma_controller, struct cppi, controller);
 	if (cppi->irq)
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -553,8 +553,8 @@ static int sddr55_reset(struct us_data *
 
 static unsigned long sddr55_get_capacity(struct us_data *us) {
 
-	unsigned char uninitialized_var(manufacturerID);
-	unsigned char uninitialized_var(deviceID);
+	unsigned char manufacturerID;
+	unsigned char deviceID;
 	int result;
 	struct sddr55_card_info *info = (struct sddr55_card_info *)us->extra;
 
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -828,7 +828,7 @@ static int get_rx_bufs(struct vhost_virt
 	/* len is always initialized before use since we are always called with
 	 * datalen > 0.
 	 */
-	u32 uninitialized_var(len);
+	u32 len;
 
 	while (datalen > 0 && headcount < quota) {
 		if (unlikely(seg >= UIO_MAXIOV)) {
@@ -885,7 +885,7 @@ static void handle_rx(struct vhost_net *
 {
 	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_RX];
 	struct vhost_virtqueue *vq = &nvq->vq;
-	unsigned uninitialized_var(in), log;
+	unsigned in, log;
 	struct vhost_log *vq_log;
 	struct msghdr msg = {
 		.msg_name = NULL,
--- a/drivers/video/fbdev/matrox/matroxfb_maven.c
+++ b/drivers/video/fbdev/matrox/matroxfb_maven.c
@@ -299,7 +299,7 @@ static int matroxfb_mavenclock(const str
 		unsigned int* in, unsigned int* feed, unsigned int* post,
 		unsigned int* htotal2) {
 	unsigned int fvco;
-	unsigned int uninitialized_var(p);
+	unsigned int p;
 
 	fvco = matroxfb_PLL_mavenclock(&maven1000_pll, ctl, htotal, vtotal, in, feed, &p, htotal2);
 	if (!fvco)
@@ -731,8 +731,8 @@ static int maven_find_exact_clocks(unsig
 
 	for (x = 0; x < 8; x++) {
 		unsigned int c;
-		unsigned int uninitialized_var(a), uninitialized_var(b),
-			     uninitialized_var(h2);
+		unsigned int a, b,
+			     h2;
 		unsigned int h = ht + 2 + x;
 
 		if (!matroxfb_mavenclock((m->mode == MATROXFB_OUTPUT_MODE_PAL) ? &maven_PAL : &maven_NTSC, h, vt, &a, &b, &c, &h2)) {
--- a/drivers/video/fbdev/pm3fb.c
+++ b/drivers/video/fbdev/pm3fb.c
@@ -821,9 +821,9 @@ static void pm3fb_write_mode(struct fb_i
 
 	wmb();
 	{
-		unsigned char uninitialized_var(m);	/* ClkPreScale */
-		unsigned char uninitialized_var(n);	/* ClkFeedBackScale */
-		unsigned char uninitialized_var(p);	/* ClkPostScale */
+		unsigned char m;	/* ClkPreScale */
+		unsigned char n;	/* ClkFeedBackScale */
+		unsigned char p;	/* ClkPostScale */
 		unsigned long pixclock = PICOS2KHZ(info->var.pixclock);
 
 		(void)pm3fb_calculate_clock(pixclock, &m, &n, &p);
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -1245,8 +1245,7 @@ int CalcStateExt
 )
 {
     int pixelDepth;
-    int uninitialized_var(VClk),uninitialized_var(m),
-        uninitialized_var(n),	uninitialized_var(p);
+    int VClk, m, n, p;
 
     /*
      * Save mode parameters.
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -268,7 +268,7 @@ static inline int virtqueue_add(struct v
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, uninitialized_var(prev), err_idx;
+	unsigned int i, n, avail, descs_used, prev, err_idx;
 	int head;
 	bool indirect;
 
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -887,7 +887,7 @@ static struct dentry *afs_lookup(struct
 static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct afs_vnode *vnode, *dir;
-	struct afs_fid uninitialized_var(fid);
+	struct afs_fid fid;
 	struct dentry *parent;
 	struct inode *inode;
 	struct key *key;
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -340,7 +340,7 @@ int afs_check_permit(struct afs_vnode *v
 int afs_permission(struct inode *inode, int mask)
 {
 	struct afs_vnode *vnode = AFS_FS_I(inode);
-	afs_access_t uninitialized_var(access);
+	afs_access_t access;
 	struct key *key;
 	int ret;
 
--- a/fs/dlm/netlink.c
+++ b/fs/dlm/netlink.c
@@ -115,7 +115,7 @@ static void fill_data(struct dlm_lock_da
 
 void dlm_timeout_warn(struct dlm_lkb *lkb)
 {
-	struct sk_buff *uninitialized_var(send_skb);
+	struct sk_buff *send_skb;
 	struct dlm_lock_data *data;
 	size_t size;
 	int rv;
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1287,7 +1287,7 @@ int fat_add_entries(struct inode *dir, v
 	struct super_block *sb = dir->i_sb;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh, *prev, *bhs[3]; /* 32*slots (672bytes) */
-	struct msdos_dir_entry *uninitialized_var(de);
+	struct msdos_dir_entry *de;
 	int err, free_slots, i, nr_bhs;
 	loff_t pos, i_pos;
 
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -117,7 +117,7 @@ static ssize_t fuse_conn_max_background_
 					      const char __user *buf,
 					      size_t count, loff_t *ppos)
 {
-	unsigned uninitialized_var(val);
+	unsigned val;
 	ssize_t ret;
 
 	ret = fuse_conn_limit_write(file, buf, count, ppos, &val,
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -269,7 +269,7 @@ static int cuse_parse_one(char **pp, cha
 static int cuse_parse_devinfo(char *p, size_t len, struct cuse_devinfo *devinfo)
 {
 	char *end = p + len;
-	char *uninitialized_var(key), *uninitialized_var(val);
+	char *key, *val;
 	int rc;
 
 	while (true) {
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2774,7 +2774,7 @@ static void fuse_register_polled_file(st
 {
 	spin_lock(&fc->lock);
 	if (RB_EMPTY_NODE(&ff->polled_node)) {
-		struct rb_node **link, *uninitialized_var(parent);
+		struct rb_node **link, *parent;
 
 		link = fuse_find_polled_node(fc, ff->kh, &parent);
 		BUG_ON(*link);
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -359,7 +359,7 @@ static int gfs2_write_cache_jdata(struct
 	int done = 0;
 	struct pagevec pvec;
 	int nr_pages;
-	pgoff_t uninitialized_var(writeback_index);
+	pgoff_t writeback_index;
 	pgoff_t index;
 	pgoff_t end;
 	pgoff_t done_index;
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1754,7 +1754,7 @@ static int punch_hole(struct gfs2_inode
 	u64 lblock = (offset + (1 << bsize_shift) - 1) >> bsize_shift;
 	__u16 start_list[GFS2_MAX_META_HEIGHT];
 	__u16 __end_list[GFS2_MAX_META_HEIGHT], *end_list = NULL;
-	unsigned int start_aligned, uninitialized_var(end_aligned);
+	unsigned int start_aligned, end_aligned;
 	unsigned int strip_h = ip->i_height - 1;
 	u32 btotal = 0;
 	int ret, state;
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -398,7 +398,7 @@ int hfsplus_hash_dentry(const struct den
 	astr = str->name;
 	len = str->len;
 	while (len > 0) {
-		int uninitialized_var(dsize);
+		int dsize;
 		size = asc2unichar(sb, astr, len, &c);
 		astr += size;
 		len -= size;
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -153,8 +153,8 @@ isofs_find_entry(struct inode *dir, stru
 struct dentry *isofs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
 	int found;
-	unsigned long uninitialized_var(block);
-	unsigned long uninitialized_var(offset);
+	unsigned long block;
+	unsigned long offset;
 	struct inode *inode;
 	struct page *page;
 
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -401,7 +401,7 @@ static void jffs2_mark_erased_block(stru
 {
 	size_t retlen;
 	int ret;
-	uint32_t uninitialized_var(bad_offset);
+	uint32_t bad_offset;
 
 	switch (jffs2_block_check_erase(c, jeb, &bad_offset)) {
 	case -EAGAIN:	goto refile;
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -347,7 +347,7 @@ static ssize_t write_unlock_fs(struct fi
 static ssize_t write_filehandle(struct file *file, char *buf, size_t size)
 {
 	char *dname, *path;
-	int uninitialized_var(maxsize);
+	int maxsize;
 	char *mesg = buf;
 	int len;
 	struct auth_domain *dom;
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -4722,7 +4722,7 @@ int ocfs2_insert_extent(handle_t *handle
 			struct ocfs2_alloc_context *meta_ac)
 {
 	int status;
-	int uninitialized_var(free_records);
+	int free_records;
 	struct buffer_head *last_eb_bh = NULL;
 	struct ocfs2_insert_type insert = {0, };
 	struct ocfs2_extent_rec rec;
@@ -7052,7 +7052,7 @@ int ocfs2_convert_inline_data_to_extents
 	int need_free = 0;
 	u32 bit_off, num;
 	handle_t *handle;
-	u64 uninitialized_var(block);
+	u64 block;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -866,9 +866,9 @@ static int ocfs2_dx_dir_lookup(struct in
 			       u64 *ret_phys_blkno)
 {
 	int ret = 0;
-	unsigned int cend, uninitialized_var(clen);
-	u32 uninitialized_var(cpos);
-	u64 uninitialized_var(blkno);
+	unsigned int cend, clen;
+	u32 cpos;
+	u64 blkno;
 	u32 name_hash = hinfo->major_hash;
 
 	ret = ocfs2_dx_dir_lookup_rec(inode, el, name_hash, &cpos, &blkno,
@@ -912,7 +912,7 @@ static int ocfs2_dx_dir_search(const cha
 			       struct ocfs2_dir_lookup_result *res)
 {
 	int ret, i, found;
-	u64 uninitialized_var(phys);
+	u64 phys;
 	struct buffer_head *dx_leaf_bh = NULL;
 	struct ocfs2_dx_leaf *dx_leaf;
 	struct ocfs2_dx_entry *dx_entry = NULL;
@@ -4420,9 +4420,9 @@ out:
 int ocfs2_dx_dir_truncate(struct inode *dir, struct buffer_head *di_bh)
 {
 	int ret;
-	unsigned int uninitialized_var(clen);
-	u32 major_hash = UINT_MAX, p_cpos, uninitialized_var(cpos);
-	u64 uninitialized_var(blkno);
+	unsigned int clen;
+	u32 major_hash = UINT_MAX, p_cpos, cpos;
+	u64 blkno;
 	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
 	struct buffer_head *dx_root_bh = NULL;
 	struct ocfs2_dx_root_block *dx_root;
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -416,7 +416,7 @@ static int ocfs2_get_clusters_nocache(st
 {
 	int i, ret, tree_height, len;
 	struct ocfs2_dinode *di;
-	struct ocfs2_extent_block *uninitialized_var(eb);
+	struct ocfs2_extent_block *eb;
 	struct ocfs2_extent_list *el;
 	struct ocfs2_extent_rec *rec;
 	struct buffer_head *eb_bh = NULL;
@@ -613,7 +613,7 @@ int ocfs2_get_clusters(struct inode *ino
 		       unsigned int *extent_flags)
 {
 	int ret;
-	unsigned int uninitialized_var(hole_len), flags = 0;
+	unsigned int hole_len, flags = 0;
 	struct buffer_head *di_bh = NULL;
 	struct ocfs2_extent_rec rec;
 
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -2506,7 +2506,7 @@ int ocfs2_create_inode_in_orphan(struct
 	struct buffer_head *new_di_bh = NULL;
 	struct ocfs2_alloc_context *inode_ac = NULL;
 	struct ocfs2_dir_lookup_result orphan_insert = { NULL, };
-	u64 uninitialized_var(di_blkno), suballoc_loc;
+	u64 di_blkno, suballoc_loc;
 	u16 suballoc_bit;
 
 	status = ocfs2_inode_lock(dir, &parent_di_bh, 1);
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -1069,7 +1069,7 @@ static int ocfs2_get_refcount_rec(struct
 				  struct buffer_head **ret_bh)
 {
 	int ret = 0, i, found;
-	u32 low_cpos, uninitialized_var(cpos_end);
+	u32 low_cpos, cpos_end;
 	struct ocfs2_extent_list *el;
 	struct ocfs2_extent_rec *rec = NULL;
 	struct ocfs2_extent_block *eb = NULL;
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1219,7 +1219,7 @@ static int ocfs2_xattr_block_get(struct
 	struct ocfs2_xattr_value_root *xv;
 	size_t size;
 	int ret = -ENODATA, name_offset, name_len, i;
-	int uninitialized_var(block_off);
+	int block_off;
 
 	xs->bucket = ocfs2_xattr_bucket_new(inode);
 	if (!xs->bucket) {
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -220,7 +220,7 @@ static int omfs_get_block(struct inode *
 	struct buffer_head *bh;
 	sector_t next, offset;
 	int ret;
-	u64 uninitialized_var(new_block);
+	u64 new_block;
 	u32 max_extents;
 	int extent_count;
 	struct omfs_extent *oe;
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -713,7 +713,7 @@ static int ovl_copy_up_meta_inode_data(s
 	struct path upperpath, datapath;
 	int err;
 	char *capability = NULL;
-	ssize_t uninitialized_var(cap_size);
+	ssize_t cap_size;
 
 	ovl_path_upper(c->dentry, &upperpath);
 	if (WARN_ON(upperpath.dentry == NULL))
--- a/fs/ubifs/commit.c
+++ b/fs/ubifs/commit.c
@@ -564,11 +564,11 @@ out:
  */
 int dbg_check_old_index(struct ubifs_info *c, struct ubifs_zbranch *zroot)
 {
-	int lnum, offs, len, err = 0, uninitialized_var(last_level), child_cnt;
+	int lnum, offs, len, err = 0, last_level, child_cnt;
 	int first = 1, iip;
 	struct ubifs_debug_info *d = c->dbg;
-	union ubifs_key uninitialized_var(lower_key), upper_key, l_key, u_key;
-	unsigned long long uninitialized_var(last_sqnum);
+	union ubifs_key lower_key, upper_key, l_key, u_key;
+	unsigned long long last_sqnum;
 	struct ubifs_idx_node *idx;
 	struct list_head list;
 	struct idx_node *i;
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1294,7 +1294,7 @@ static int do_rename(struct inode *old_d
 	struct ubifs_budget_req ino_req = { .dirtied_ino = 1,
 			.dirtied_ino_d = ALIGN(old_inode_ui->data_len, 8) };
 	struct timespec64 time;
-	unsigned int uninitialized_var(saved_nlink);
+	unsigned int saved_nlink;
 	struct fscrypt_name old_nm, new_nm;
 
 	/*
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -234,7 +234,7 @@ static int write_begin_slow(struct addre
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct ubifs_budget_req req = { .new_page = 1 };
-	int uninitialized_var(err), appending = !!(pos + len > inode->i_size);
+	int err, appending = !!(pos + len > inode->i_size);
 	struct page *page;
 
 	dbg_gen("ino %lu, pos %llu, len %u, i_size %lld",
@@ -438,7 +438,7 @@ static int ubifs_write_begin(struct file
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	pgoff_t index = pos >> PAGE_SHIFT;
-	int uninitialized_var(err), appending = !!(pos + len > inode->i_size);
+	int err, appending = !!(pos + len > inode->i_size);
 	int skipped_read = 0;
 	struct page *page;
 
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1355,7 +1355,7 @@ int ubifs_jnl_truncate(struct ubifs_info
 	union ubifs_key key, to_key;
 	struct ubifs_ino_node *ino;
 	struct ubifs_trun_node *trun;
-	struct ubifs_data_node *uninitialized_var(dn);
+	struct ubifs_data_node *dn;
 	int err, dlen, len, lnum, offs, bit, sz, sync = IS_SYNC(inode);
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	ino_t inum = inode->i_ino;
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -287,7 +287,7 @@ uint32_t ubifs_unpack_bits(const struct
 	const int k = 32 - nrbits;
 	uint8_t *p = *addr;
 	int b = *pos;
-	uint32_t uninitialized_var(val);
+	uint32_t val;
 	const int bytes = (nrbits + b + 7) >> 3;
 
 	ubifs_assert(c, nrbits > 0);
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -936,7 +936,7 @@ static int fallible_resolve_collision(st
 				      int adding)
 {
 	struct ubifs_znode *o_znode = NULL, *znode = *zn;
-	int uninitialized_var(o_n), err, cmp, unsure = 0, nn = *n;
+	int o_n, err, cmp, unsure = 0, nn = *n;
 
 	cmp = fallible_matches_name(c, &znode->zbranch[nn], nm);
 	if (unlikely(cmp < 0))
@@ -1558,8 +1558,8 @@ out:
  */
 int ubifs_tnc_get_bu_keys(struct ubifs_info *c, struct bu_info *bu)
 {
-	int n, err = 0, lnum = -1, uninitialized_var(offs);
-	int uninitialized_var(len);
+	int n, err = 0, lnum = -1, offs;
+	int len;
 	unsigned int block = key_block(c, &bu->key);
 	struct ubifs_znode *znode;
 
--- a/fs/ubifs/tnc_misc.c
+++ b/fs/ubifs/tnc_misc.c
@@ -138,8 +138,8 @@ int ubifs_search_zbranch(const struct ub
 			 const struct ubifs_znode *znode,
 			 const union ubifs_key *key, int *n)
 {
-	int beg = 0, end = znode->child_cnt, uninitialized_var(mid);
-	int uninitialized_var(cmp);
+	int beg = 0, end = znode->child_cnt, mid;
+	int cmp;
 	const struct ubifs_zbranch *zbr = &znode->zbranch[0];
 
 	ubifs_assert(c, end > beg);
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -555,7 +555,7 @@ static udf_pblk_t udf_table_new_block(st
 	udf_pblk_t newblock = 0;
 	uint32_t adsize;
 	uint32_t elen, goal_elen = 0;
-	struct kernel_lb_addr eloc, uninitialized_var(goal_eloc);
+	struct kernel_lb_addr eloc, goal_eloc;
 	struct extent_position epos, goal_epos;
 	int8_t etype;
 	struct udf_inode_info *iinfo = UDF_I(table);
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -130,7 +130,7 @@ xfs_bmap_rtalloc(
 	 * pick an extent that will space things out in the rt area.
 	 */
 	if (ap->eof && ap->offset == 0) {
-		xfs_rtblock_t uninitialized_var(rtx); /* realtime extent no */
+		xfs_rtblock_t rtx; /* realtime extent no */
 
 		error = xfs_rtpick_extent(mp, ap->tp, ralen, &rtx);
 		if (error)
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -115,7 +115,7 @@ static void async_run_entry_fn(struct wo
 	struct async_entry *entry =
 		container_of(work, struct async_entry, work);
 	unsigned long flags;
-	ktime_t uninitialized_var(calltime), delta, rettime;
+	ktime_t calltime, delta, rettime;
 
 	/* 1) run (and print duration) */
 	if (initcall_debug && system_state < SYSTEM_RUNNING) {
@@ -283,7 +283,7 @@ EXPORT_SYMBOL_GPL(async_synchronize_full
  */
 void async_synchronize_cookie_domain(async_cookie_t cookie, struct async_domain *domain)
 {
-	ktime_t uninitialized_var(starttime), delta, endtime;
+	ktime_t starttime, delta, endtime;
 
 	if (initcall_debug && system_state < SYSTEM_RUNNING) {
 		pr_debug("async_waiting @ %i\n", task_pid_nr(current));
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1796,7 +1796,7 @@ struct audit_buffer *audit_log_start(str
 {
 	struct audit_buffer *ab;
 	struct timespec64 t;
-	unsigned int uninitialized_var(serial);
+	unsigned int serial;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -963,7 +963,7 @@ static int device_dma_allocations(struct
 static int dma_debug_device_change(struct notifier_block *nb, unsigned long action, void *data)
 {
 	struct device *dev = data;
-	struct dma_debug_entry *uninitialized_var(entry);
+	struct dma_debug_entry *entry;
 	int count;
 
 	if (dma_debug_disabled())
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10575,7 +10575,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	struct perf_event *group_leader = NULL, *output_event = NULL;
 	struct perf_event *event, *sibling;
 	struct perf_event_attr attr;
-	struct perf_event_context *ctx, *uninitialized_var(gctx);
+	struct perf_event_context *ctx, *gctx;
 	struct file *event_file = NULL;
 	struct fd group = {NULL, 0};
 	struct task_struct *task = NULL;
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1887,7 +1887,7 @@ static void handle_swbp(struct pt_regs *
 {
 	struct uprobe *uprobe;
 	unsigned long bp_vaddr;
-	int uninitialized_var(is_swbp);
+	int is_swbp;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
 	if (bp_vaddr == get_trampoline_vaddr())
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -140,7 +140,7 @@ static void __exit_signal(struct task_st
 	struct signal_struct *sig = tsk->signal;
 	bool group_dead = thread_group_leader(tsk);
 	struct sighand_struct *sighand;
-	struct tty_struct *uninitialized_var(tty);
+	struct tty_struct *tty;
 	u64 utime, stime;
 
 	sighand = rcu_dereference_check(tsk->sighand,
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1398,7 +1398,7 @@ static int lookup_pi_state(u32 __user *u
 static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
 {
 	int err;
-	u32 uninitialized_var(curval);
+	u32 curval;
 
 	if (unlikely(should_fail_futex(true)))
 		return -EFAULT;
@@ -1569,7 +1569,7 @@ static void mark_wake_futex(struct wake_
  */
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
 {
-	u32 uninitialized_var(curval), newval;
+	u32 curval, newval;
 	struct task_struct *new_owner;
 	bool postunlock = false;
 	DEFINE_WAKE_Q(wake_q);
@@ -3083,7 +3083,7 @@ uaddr_faulted:
  */
 static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 {
-	u32 uninitialized_var(curval), uval, vpid = task_pid_vnr(current);
+	u32 curval, uval, vpid = task_pid_vnr(current);
 	union futex_key key = FUTEX_KEY_INIT;
 	struct futex_hash_bucket *hb;
 	struct futex_q *top_waiter;
@@ -3558,7 +3558,7 @@ err_unlock:
 static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 			      bool pi, bool pending_op)
 {
-	u32 uval, uninitialized_var(nval), mval;
+	u32 uval, nval, mval;
 	int err;
 
 	/* Futex address must be 32bit aligned */
@@ -3688,7 +3688,7 @@ static void exit_robust_list(struct task
 	struct robust_list_head __user *head = curr->robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
-	unsigned int uninitialized_var(next_pi);
+	unsigned int next_pi;
 	unsigned long futex_offset;
 	int rc;
 
@@ -3987,7 +3987,7 @@ static void compat_exit_robust_list(stru
 	struct compat_robust_list_head __user *head = curr->compat_robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
-	unsigned int uninitialized_var(next_pi);
+	unsigned int next_pi;
 	compat_uptr_t uentry, next_uentry, upending;
 	compat_long_t futex_offset;
 	int rc;
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1246,7 +1246,7 @@ static int noop_count(struct lock_list *
 static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
 {
 	unsigned long  count = 0;
-	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list *target_entry;
 
 	__bfs_forwards(this, (void *)&count, noop_count, &target_entry);
 
@@ -1274,7 +1274,7 @@ unsigned long lockdep_count_forward_deps
 static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
 {
 	unsigned long  count = 0;
-	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list *target_entry;
 
 	__bfs_backwards(this, (void *)&count, noop_count, &target_entry);
 
@@ -2662,7 +2662,7 @@ check_usage_backwards(struct task_struct
 {
 	int ret;
 	struct lock_list root;
-	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list *target_entry;
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -561,7 +561,7 @@ static void rb_wake_up_waiters(struct ir
  */
 int ring_buffer_wait(struct ring_buffer *buffer, int cpu, bool full)
 {
-	struct ring_buffer_per_cpu *uninitialized_var(cpu_buffer);
+	struct ring_buffer_per_cpu *cpu_buffer;
 	DEFINE_WAIT(wait);
 	struct rb_irq_work *work;
 	int ret = 0;
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1498,7 +1498,7 @@ void *radix_tree_tag_clear(struct radix_
 {
 	struct radix_tree_node *node, *parent;
 	unsigned long maxindex;
-	int uninitialized_var(offset);
+	int offset;
 
 	radix_tree_load_root(root, &node, &maxindex);
 	if (index > maxindex)
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -447,7 +447,7 @@ static int __frontswap_shrink(unsigned l
 void frontswap_shrink(unsigned long target_pages)
 {
 	unsigned long pages_to_unuse = 0;
-	int uninitialized_var(type), ret;
+	int type, ret;
 
 	/*
 	 * we don't want to hold swap_lock while doing a very
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2381,7 +2381,7 @@ next_mm:
 static void ksm_do_scan(unsigned int scan_npages)
 {
 	struct rmap_item *rmap_item;
-	struct page *uninitialized_var(page);
+	struct page *page;
 
 	while (scan_npages-- && likely(!freezing(current))) {
 		cond_resched();
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -919,7 +919,7 @@ struct mem_cgroup *mem_cgroup_iter(struc
 				   struct mem_cgroup *prev,
 				   struct mem_cgroup_reclaim_cookie *reclaim)
 {
-	struct mem_cgroup_reclaim_iter *uninitialized_var(iter);
+	struct mem_cgroup_reclaim_iter *iter;
 	struct cgroup_subsys_state *css = NULL;
 	struct mem_cgroup *memcg = NULL;
 	struct mem_cgroup *pos = NULL;
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1147,7 +1147,7 @@ int do_migrate_pages(struct mm_struct *m
 static struct page *new_page(struct page *page, unsigned long start)
 {
 	struct vm_area_struct *vma;
-	unsigned long uninitialized_var(address);
+	unsigned long address;
 
 	vma = find_vma(current->mm, start);
 	while (vma) {
@@ -1545,7 +1545,7 @@ static int kernel_get_mempolicy(int __us
 				unsigned long flags)
 {
 	int err;
-	int uninitialized_var(pval);
+	int pval;
 	nodemask_t nodes;
 
 	if (nmask != NULL && maxnode < nr_node_ids)
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2283,7 +2283,7 @@ static struct pcpu_alloc_info * __init p
 	const size_t static_size = __per_cpu_end - __per_cpu_start;
 	int nr_groups = 1, nr_units = 0;
 	size_t size_sum, min_unit_size, alloc_size;
-	int upa, max_upa, uninitialized_var(best_upa);	/* units_per_alloc */
+	int upa, max_upa, best_upa;	/* units_per_alloc */
 	int last_allocs, group, unit;
 	unsigned int cpu, tcpu;
 	struct pcpu_alloc_info *ai;
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1179,7 +1179,7 @@ static noinline int free_debug_processin
 	struct kmem_cache_node *n = get_node(s, page_to_nid(page));
 	void *object = head;
 	int cnt = 0;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 	int ret = 0;
 
 	spin_lock_irqsave(&n->list_lock, flags);
@@ -2826,7 +2826,7 @@ static void __slab_free(struct kmem_cach
 	struct page new;
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
-	unsigned long uninitialized_var(flags);
+	unsigned long flags;
 
 	stat(s, FREE_SLOWPATH);
 
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -721,8 +721,8 @@ void release_pages(struct page **pages,
 	LIST_HEAD(pages_to_free);
 	struct pglist_data *locked_pgdat = NULL;
 	struct lruvec *lruvec;
-	unsigned long uninitialized_var(flags);
-	unsigned int uninitialized_var(lock_batch);
+	unsigned long flags;
+	unsigned int lock_batch;
 
 	for (i = 0; i < nr; i++) {
 		struct page *page = pages[i];
--- a/net/dccp/options.c
+++ b/net/dccp/options.c
@@ -60,7 +60,7 @@ int dccp_parse_options(struct sock *sk,
 					(dh->dccph_doff * 4);
 	struct dccp_options_received *opt_recv = &dp->dccps_options_received;
 	unsigned char opt, len;
-	unsigned char *uninitialized_var(value);
+	unsigned char *value;
 	u32 elapsed_time;
 	__be32 opt_val;
 	int rc;
--- a/net/ipv4/netfilter/nf_socket_ipv4.c
+++ b/net/ipv4/netfilter/nf_socket_ipv4.c
@@ -96,11 +96,11 @@ nf_socket_get_sock_v4(struct net *net, s
 struct sock *nf_sk_lookup_slow_v4(struct net *net, const struct sk_buff *skb,
 				  const struct net_device *indev)
 {
-	__be32 uninitialized_var(daddr), uninitialized_var(saddr);
-	__be16 uninitialized_var(dport), uninitialized_var(sport);
+	__be32 daddr, saddr;
+	__be16 dport, sport;
 	const struct iphdr *iph = ip_hdr(skb);
 	struct sk_buff *data_skb = NULL;
-	u8 uninitialized_var(protocol);
+	u8 protocol;
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn const *ct;
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -518,7 +518,7 @@ int ipv6_flowlabel_opt_get(struct sock *
 
 int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optlen)
 {
-	int uninitialized_var(err);
+	int err;
 	struct net *net = sock_net(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_flowlabel_req freq;
--- a/net/ipv6/netfilter/nf_socket_ipv6.c
+++ b/net/ipv6/netfilter/nf_socket_ipv6.c
@@ -102,7 +102,7 @@ nf_socket_get_sock_v6(struct net *net, s
 struct sock *nf_sk_lookup_slow_v6(struct net *net, const struct sk_buff *skb,
 				  const struct net_device *indev)
 {
-	__be16 uninitialized_var(dport), uninitialized_var(sport);
+	__be16 dport, sport;
 	const struct in6_addr *daddr = NULL, *saddr = NULL;
 	struct ipv6hdr *iph = ipv6_hdr(skb), ipv6_var;
 	struct sk_buff *data_skb = NULL;
--- a/net/netfilter/nf_conntrack_ftp.c
+++ b/net/netfilter/nf_conntrack_ftp.c
@@ -383,7 +383,7 @@ static int help(struct sk_buff *skb,
 	int ret;
 	u32 seq;
 	int dir = CTINFO2DIR(ctinfo);
-	unsigned int uninitialized_var(matchlen), uninitialized_var(matchoff);
+	unsigned int matchlen, matchoff;
 	struct nf_ct_ftp_master *ct_ftp_info = nfct_help_data(ct);
 	struct nf_conntrack_expect *exp;
 	union nf_inet_addr *daddr;
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -637,7 +637,7 @@ nfulnl_log_packet(struct net *net,
 	struct nfnl_log_net *log = nfnl_log_pernet(net);
 	const struct nfnl_ct_hook *nfnl_ct = NULL;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info uninitialized_var(ctinfo);
+	enum ip_conntrack_info ctinfo;
 
 	if (li_user && li_user->type == NF_LOG_TYPE_ULOG)
 		li = li_user;
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -392,7 +392,7 @@ nfqnl_build_packet_message(struct net *n
 	struct net_device *indev;
 	struct net_device *outdev;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info uninitialized_var(ctinfo);
+	enum ip_conntrack_info ctinfo;
 	struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
 	char *secdata = NULL;
@@ -1191,7 +1191,7 @@ static int nfqnl_recv_verdict(struct net
 	struct nfqnl_instance *queue;
 	unsigned int verdict;
 	struct nf_queue_entry *entry;
-	enum ip_conntrack_info uninitialized_var(ctinfo);
+	enum ip_conntrack_info ctinfo;
 	struct nfnl_ct_hook *nfnl_ct;
 	struct nf_conn *ct = NULL;
 	struct nfnl_queue_net *q = nfnl_queue_pernet(net);
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -229,7 +229,7 @@ static u32 flow_get_skgid(const struct s
 
 static u32 flow_get_vlan_tag(const struct sk_buff *skb)
 {
-	u16 uninitialized_var(tag);
+	u16 tag;
 
 	if (vlan_get_tag(skb, &tag) < 0)
 		return 0;
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1649,7 +1649,7 @@ static s32 cake_enqueue(struct sk_buff *
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	int len = qdisc_pkt_len(skb);
-	int uninitialized_var(ret);
+	int ret;
 	struct sk_buff *ack = NULL;
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
--- a/net/sched/sch_cbq.c
+++ b/net/sched/sch_cbq.c
@@ -365,7 +365,7 @@ cbq_enqueue(struct sk_buff *skb, struct
 	    struct sk_buff **to_free)
 {
 	struct cbq_sched_data *q = qdisc_priv(sch);
-	int uninitialized_var(ret);
+	int ret;
 	struct cbq_class *cl = cbq_classify(skb, sch, &ret);
 
 #ifdef CONFIG_NET_CLS_ACT
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -192,7 +192,7 @@ static int fq_codel_enqueue(struct sk_bu
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 	unsigned int idx, prev_backlog, prev_qlen;
 	struct fq_codel_flow *flow;
-	int uninitialized_var(ret);
+	int ret;
 	unsigned int pkt_len;
 	bool memory_limited;
 
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -353,7 +353,7 @@ sfq_enqueue(struct sk_buff *skb, struct
 	unsigned int hash, dropped;
 	sfq_index x, qlen;
 	struct sfq_slot *slot;
-	int uninitialized_var(ret);
+	int ret;
 	struct sk_buff *head;
 	int delta;
 
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -236,7 +236,7 @@ static int copy_ctl_value_from_user(stru
 {
 	struct snd_ctl_elem_value32 __user *data32 = userdata;
 	int i, type, size;
-	int uninitialized_var(count);
+	int count;
 	unsigned int indirect;
 
 	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)))
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -116,7 +116,7 @@ static void info_read(struct snd_info_en
 int snd_sb_csp_new(struct snd_sb *chip, int device, struct snd_hwdep ** rhwdep)
 {
 	struct snd_sb_csp *p;
-	int uninitialized_var(version);
+	int version;
 	int err;
 	struct snd_hwdep *hw;
 
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -324,7 +324,7 @@ static void queue_pending_output_urbs(st
 	while (test_bit(EP_FLAG_RUNNING, &ep->flags)) {
 
 		unsigned long flags;
-		struct snd_usb_packet_info *uninitialized_var(packet);
+		struct snd_usb_packet_info *packet;
 		struct snd_urb_ctx *ctx = NULL;
 		int err, i;
 



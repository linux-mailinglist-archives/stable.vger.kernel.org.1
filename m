Return-Path: <stable+bounces-244504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OmnDMsa/GlALgAAu9opvQ
	(envelope-from <stable+bounces-244504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 06:53:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BB74E2EF8
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 06:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FFBE300B8E8
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 04:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50CC3264E7;
	Thu,  7 May 2026 04:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xWRGuaSM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79CF3254B2;
	Thu,  7 May 2026 04:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778129601; cv=none; b=fpsYEOhewnMnGXgs7IOgFa6AXUJ7531lfXiSObSHoGFzqQt+KhP5DZ8OwvgXiAJezhiVgoSaOp1wd3ZztFueTR5yzfA35AzN9GHHpEX/XrXDJBxecjMcnb90c+P/h0qWMNzcIruFAHtAiGiGAmHNXkcyBGCvPsi7VxFDPPHMZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778129601; c=relaxed/simple;
	bh=lyyTtc9pBik+/yH5nj8s1uQL9uAr+jYPA8rXKfxJTmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KM8poin9khm3Mg0U4SIZfl2u8wVBVvEL+zK7FNTG5JieeR+0DnnnDHqmijMKxpQPNudwn+FGu89kDL1bMOXhbM1xX35afxET+aqSzHotA6ner0rTl968Mua+LJgxudNDeo2XKbhde8sx3O1abLsjSCyLLR2YYa/T7a88amZfLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xWRGuaSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160A0C2BCB8;
	Thu,  7 May 2026 04:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778129601;
	bh=lyyTtc9pBik+/yH5nj8s1uQL9uAr+jYPA8rXKfxJTmg=;
	h=From:To:Cc:Subject:Date:From;
	b=xWRGuaSMEIW3Mmlklcc61rY4S9ORAZYasa7kBuWoWSTesmr0qronD4Rb8/ev/Au36
	 sOFBpXM6+r932fKRQ93U3i31qoQ8+Pb1H69xgcq0+oCGArBnjQGVPqEJQTX6sZbuko
	 u/9mS8e8w2KGZAxLqxePa91BRnjkeJ/JhnK3dX/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.27
Date: Thu,  7 May 2026 06:53:06 +0200
Message-ID: <2026050707-getup-manly-d5f7@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E6BB74E2EF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244504-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I'm announcing the release of the 6.18.27 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml |   70 ++
 Documentation/scheduler/sched-ext.rst                          |   12 
 Makefile                                                       |    3 
 arch/arm/mm/flush.c                                            |    4 
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi              |    5 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                     |   20 
 arch/arm64/crypto/aes-modes.S                                  |    4 
 arch/arm64/include/asm/mmu.h                                   |    2 
 arch/arm64/mm/init.c                                           |    9 
 arch/arm64/mm/mmu.c                                            |   92 ++-
 arch/loongarch/kernel/cpu-probe.c                              |    7 
 arch/loongarch/kernel/syscall.c                                |    3 
 arch/loongarch/kvm/vcpu.c                                      |    2 
 arch/parisc/Kconfig                                            |    3 
 arch/parisc/include/asm/checksum.h                             |   89 ---
 arch/parisc/kernel/syscalls/syscall.tbl                        |    2 
 arch/parisc/lib/Makefile                                       |    2 
 arch/parisc/lib/checksum.c                                     |   99 ---
 arch/um/drivers/cow_user.c                                     |    8 
 arch/x86/Kconfig                                               |    1 
 arch/x86/kernel/shstk.c                                        |   44 -
 arch/x86/kvm/hyperv.h                                          |    8 
 arch/x86/kvm/svm/hyperv.h                                      |    9 
 arch/x86/kvm/svm/nested.c                                      |  195 ++++---
 arch/x86/kvm/svm/svm.c                                         |  139 ++++-
 arch/x86/kvm/svm/svm.h                                         |   11 
 arch/x86/kvm/x86.c                                             |   65 +-
 arch/x86/mm/pti.c                                              |    5 
 block/bio-integrity.c                                          |    6 
 block/bio.c                                                    |    6 
 block/blk-zoned.c                                              |   12 
 block/blk.h                                                    |   19 
 certs/extract-cert.c                                           |    6 
 crypto/acompress.c                                             |    8 
 crypto/algif_aead.c                                            |   10 
 crypto/authencesn.c                                            |    5 
 crypto/pcrypt.c                                                |    7 
 drivers/base/core.c                                            |   39 +
 drivers/base/dd.c                                              |   20 
 drivers/block/rbd.c                                            |    6 
 drivers/block/zram/zram_drv.c                                  |    3 
 drivers/bus/imx-weim.c                                         |    2 
 drivers/bus/mhi/host/pci_generic.c                             |    2 
 drivers/char/ipmi/ipmi_ssif.c                                  |   42 -
 drivers/char/tpm/tpm-chip.c                                    |    2 
 drivers/char/tpm/tpm2-cmd.c                                    |    6 
 drivers/char/tpm/tpm2-sessions.c                               |    5 
 drivers/char/tpm/tpm_tis_core.c                                |   11 
 drivers/crypto/atmel-aes.c                                     |    2 
 drivers/crypto/atmel-ecc.c                                     |    1 
 drivers/crypto/atmel-i2c.c                                     |    4 
 drivers/crypto/atmel-sha204a.c                                 |   37 -
 drivers/crypto/atmel-tdes.c                                    |    8 
 drivers/crypto/ccree/cc_hash.c                                 |    1 
 drivers/crypto/hisilicon/sec/sec_algs.c                        |    2 
 drivers/crypto/intel/qat/qat_6xxx/adf_drv.c                    |    4 
 drivers/crypto/nx/nx-842.c                                     |   10 
 drivers/crypto/nx/nx-842.h                                     |    4 
 drivers/crypto/talitos.c                                       |  254 ++++++----
 drivers/edac/versalnet_edac.c                                  |    6 
 drivers/firmware/google/framebuffer-coreboot.c                 |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c                       |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h                        |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                       |   52 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                   |    9 
 drivers/gpu/drm/nouveau/nouveau_drm.c                          |    2 
 drivers/gpu/drm/nouveau/nouveau_gem.c                          |    2 
 drivers/gpu/drm/tiny/arcpgu.c                                  |    3 
 drivers/greybus/gb-beagleplay.c                                |  112 +++-
 drivers/hid/hid-apple.c                                        |    2 
 drivers/hwmon/isl28022.c                                       |    5 
 drivers/hwmon/powerz.c                                         |   11 
 drivers/hwmon/pt5161l.c                                        |    4 
 drivers/i2c/i2c-core-of.c                                      |    2 
 drivers/iio/adc/ad7768-1.c                                     |   16 
 drivers/iio/adc/ti-ads7950.c                                   |   11 
 drivers/iio/frequency/admv1013.c                               |   90 +--
 drivers/infiniband/core/addr.c                                 |    3 
 drivers/infiniband/hw/mana/qp.c                                |   15 
 drivers/infiniband/sw/rxe/rxe_recv.c                           |    3 
 drivers/input/touchscreen/edt-ft5x06.c                         |    3 
 drivers/leds/rgb/leds-qcom-lpg.c                               |    7 
 drivers/md/dm-raid1.c                                          |    6 
 drivers/md/md-llbitmap.c                                       |   11 
 drivers/md/raid10.c                                            |    4 
 drivers/md/raid5-cache.c                                       |   48 +
 drivers/md/raid5.c                                             |    8 
 drivers/media/i2c/imx219.c                                     |    3 
 drivers/media/platform/amphion/vpu_v4l2.c                      |    9 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c           |    1 
 drivers/media/rc/igorplugusb.c                                 |   16 
 drivers/media/rc/ttusbir.c                                     |   13 
 drivers/mfd/mfd-core.c                                         |   12 
 drivers/mfd/stpmic1.c                                          |   20 
 drivers/misc/ibmasm/ibmasmfs.c                                 |    7 
 drivers/misc/ibmasm/lowlevel.c                                 |   12 
 drivers/misc/ibmasm/remote.c                                   |    5 
 drivers/misc/mei/bus-fixup.c                                   |    6 
 drivers/misc/mei/hw-me-regs.h                                  |  163 +++---
 drivers/misc/mei/hw-me.h                                       |    6 
 drivers/misc/mei/pci-me.c                                      |  209 ++++----
 drivers/mmc/core/block.c                                       |   12 
 drivers/mmc/core/queue.h                                       |    3 
 drivers/mmc/host/sdhci-of-dwcmshc.c                            |   19 
 drivers/mtd/devices/docg3.c                                    |    3 
 drivers/mtd/nand/spi/winbond.c                                 |    4 
 drivers/mtd/spi-nor/sst.c                                      |   13 
 drivers/net/can/usb/ucan.c                                     |    2 
 drivers/net/ethernet/micrel/ks8851.h                           |    6 
 drivers/net/ethernet/micrel/ks8851_common.c                    |   69 +-
 drivers/net/ethernet/micrel/ks8851_par.c                       |   15 
 drivers/net/ethernet/micrel/ks8851_spi.c                       |   11 
 drivers/net/ethernet/microsoft/mana/mana_en.c                  |   11 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c                |    3 
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c                 |    2 
 drivers/net/gtp.c                                              |    2 
 drivers/net/netconsole.c                                       |    2 
 drivers/net/phy/mdio_bus_provider.c                            |    4 
 drivers/net/wireless/marvell/mwifiex/init.c                    |    2 
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h               |    4 
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c                |   51 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c                   |   28 -
 drivers/net/wireless/realtek/rtw88/pci.c                       |    3 
 drivers/nvme/host/core.c                                       |    2 
 drivers/nvme/host/pci.c                                        |    2 
 drivers/of/base.c                                              |    2 
 drivers/of/dynamic.c                                           |    2 
 drivers/of/platform.c                                          |    2 
 drivers/of/unittest.c                                          |    4 
 drivers/pci/controller/cadence/pcie-cadence.h                  |   56 --
 drivers/pci/controller/dwc/pci-imx6.c                          |    1 
 drivers/pci/endpoint/functions/pci-epf-mhi.c                   |    4 
 drivers/pci/endpoint/functions/pci-epf-ntb.c                   |   56 --
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c                      |    4 
 drivers/power/supply/axp288_charger.c                          |   19 
 drivers/pwm/pwm-imx-tpm.c                                      |    9 
 drivers/remoteproc/xlnx_r5_remoteproc.c                        |   20 
 drivers/reset/reset-rzv2h-usb2phy.c                            |   64 --
 drivers/rtc/rtc-ntxec.c                                        |    2 
 drivers/scsi/sd.c                                              |    1 
 drivers/spi/spi-ch341.c                                        |   36 -
 drivers/spi/spi-imx.c                                          |    4 
 drivers/spi/spi.c                                              |   63 +-
 drivers/thermal/thermal_core.c                                 |    7 
 drivers/usb/chipidea/core.c                                    |   45 -
 drivers/usb/chipidea/otg.c                                     |    7 
 drivers/usb/host/xhci.c                                        |    1 
 drivers/vfio/cdx/intr.c                                        |   13 
 drivers/vfio/cdx/main.c                                        |   19 
 drivers/vfio/cdx/private.h                                     |    3 
 drivers/vfio/pci/virtio/common.h                               |    2 
 drivers/vfio/pci/virtio/migrate.c                              |   33 -
 fs/afs/file.c                                                  |   12 
 fs/ceph/dir.c                                                  |    6 
 fs/erofs/dir.c                                                 |   28 -
 fs/ext2/inode.c                                                |   14 
 fs/ext4/xattr.c                                                |    6 
 fs/file_table.c                                                |   22 
 fs/jbd2/revoke.c                                               |    8 
 fs/nfs/internal.h                                              |    2 
 fs/nfs/nfs4client.c                                            |    4 
 fs/nfs/nfs4proc.c                                              |    3 
 fs/notify/inotify/inotify_user.c                               |    1 
 fs/ntfs3/run.c                                                 |   18 
 fs/ocfs2/aops.c                                                |   74 +-
 fs/userfaultfd.c                                               |    2 
 fs/xfs/xfs_buf.c                                               |    1 
 fs/xfs/xfs_sysfs.c                                             |    7 
 fs/xfs/xfs_zone_alloc.h                                        |    4 
 fs/xfs/xfs_zone_gc.c                                           |   17 
 include/linux/alloc_tag.h                                      |    2 
 include/linux/damon.h                                          |    1 
 include/linux/device.h                                         |   45 +
 include/linux/fwnode.h                                         |   44 +
 include/linux/hugetlb_inline.h                                 |    4 
 include/linux/pgalloc_tag.h                                    |    2 
 include/linux/randomize_kstack.h                               |   26 -
 include/linux/sched.h                                          |    4 
 include/linux/tpm_eventlog.h                                   |    9 
 include/linux/usb.h                                            |    3 
 include/net/mana/mana.h                                        |    1 
 include/net/mctp.h                                             |    3 
 include/trace/events/rxrpc.h                                   |    6 
 init/main.c                                                    |    1 
 io_uring/poll.c                                                |    6 
 io_uring/register.c                                            |   36 +
 io_uring/timeout.c                                             |    4 
 kernel/fork.c                                                  |    2 
 kernel/locking/rtmutex.c                                       |   13 
 kernel/sched/core.c                                            |    2 
 kernel/sched/rt.c                                              |    2 
 kernel/sched/sched.h                                           |    2 
 kernel/taskstats.c                                             |    1 
 kernel/trace/fprobe.c                                          |   21 
 kernel/trace/ring_buffer.c                                     |   13 
 lib/alloc_tag.c                                                |  109 ++++
 lib/test_hmm.c                                                 |   86 +--
 lib/ts_kmp.c                                                   |   18 
 mm/damon/core.c                                                |   60 +-
 mm/damon/stat.c                                                |    5 
 mm/filemap.c                                                   |    3 
 mm/hugetlb.c                                                   |    3 
 mm/internal.h                                                  |   11 
 mm/mempolicy.c                                                 |   23 
 mm/migrate.c                                                   |   17 
 mm/mlock.c                                                     |   10 
 mm/page_alloc.c                                                |   15 
 mm/slub.c                                                      |   29 -
 mm/truncate.c                                                  |    6 
 mm/vma.c                                                       |    4 
 mm/vmalloc.c                                                   |    3 
 mm/zsmalloc.c                                                  |    1 
 net/bluetooth/hci_event.c                                      |   18 
 net/bridge/br_arp_nd_proxy.c                                   |    8 
 net/bridge/br_fdb.c                                            |   28 -
 net/caif/cfsrvl.c                                              |   14 
 net/ceph/auth.c                                                |    2 
 net/ipv4/icmp.c                                                |    5 
 net/ipv4/inet_connection_sock.c                                |    3 
 net/ipv6/exthdrs.c                                             |    9 
 net/ipv6/rpl_iptunnel.c                                        |    9 
 net/ipv6/seg6_iptunnel.c                                       |   12 
 net/mctp/route.c                                               |    8 
 net/netfilter/nft_bitwise.c                                    |    3 
 net/qrtr/ns.c                                                  |   86 ++-
 net/rds/rdma.c                                                 |    4 
 net/rxrpc/ar-internal.h                                        |    1 
 net/rxrpc/call_event.c                                         |   20 
 net/rxrpc/conn_event.c                                         |   43 +
 net/rxrpc/io_thread.c                                          |   24 
 net/rxrpc/rxgk_app.c                                           |    3 
 net/rxrpc/rxgk_common.h                                        |    1 
 net/rxrpc/rxkad.c                                              |  112 +---
 net/rxrpc/skbuff.c                                             |    9 
 net/smc/smc_clc.c                                              |    4 
 net/strparser/strparser.c                                      |    8 
 rust/kernel/dma.rs                                             |    3 
 scripts/check-uapi.sh                                          |    7 
 security/apparmor/lsm.c                                        |   16 
 security/landlock/cred.c                                       |    6 
 sound/aoa/soundbus/i2sbus/core.c                               |   12 
 sound/aoa/soundbus/i2sbus/pcm.c                                |   71 +-
 sound/core/control.c                                           |    4 
 sound/core/misc.c                                              |   13 
 sound/core/seq/oss/seq_oss_rw.c                                |    6 
 sound/drivers/aloop.c                                          |   43 +
 sound/drivers/pcmtest.c                                        |   19 
 sound/hda/codecs/realtek/alc269.c                              |    1 
 sound/pci/ctxfi/ctatc.c                                        |    3 
 sound/soc/intel/avs/path.c                                     |    2 
 sound/usb/6fire/control.c                                      |   10 
 sound/usb/caiaq/control.c                                      |   52 +-
 sound/usb/caiaq/device.c                                       |   35 -
 sound/usb/caiaq/input.c                                        |    2 
 sound/usb/endpoint.c                                           |    6 
 sound/usb/format.c                                             |    2 
 sound/usb/mixer.c                                              |    7 
 sound/usb/mixer_quirks.c                                       |   12 
 tools/accounting/getdelays.c                                   |   41 +
 tools/accounting/procacct.c                                    |   40 +
 tools/perf/arch/loongarch/annotate/instructions.c              |    1 
 tools/perf/util/disasm.c                                       |    1 
 tools/testing/ktest/ktest.pl                                   |    2 
 tools/testing/selftests/kvm/x86/msrs_test.c                    |    2 
 tools/testing/selftests/landlock/audit.h                       |  107 +++-
 tools/testing/selftests/landlock/audit_test.c                  |  124 ++++
 tools/testing/selftests/landlock/net_test.c                    |    2 
 tools/testing/selftests/landlock/ptrace_test.c                 |    1 
 tools/testing/selftests/landlock/scoped_abstract_unix_test.c   |    1 
 tools/testing/selftests/mqueue/setting                         |    1 
 tools/testing/selftests/mqueue/settings                        |    1 
 tools/testing/selftests/vfio/lib/vfio_pci_device.c             |    4 
 tools/testing/vma/vma_internal.h                               |    7 
 274 files changed, 3262 insertions(+), 1875 deletions(-)

Aditya Garg (1):
      HID: apple: ensure the keyboard backlight is off if suspending

Aksh Garg (1):
      PCI: cadence: Use cdns_pcie_read_sz() for byte or word read access

Alex Williamson (2):
      vfio/virtio: Convert list_lock from spinlock to mutex
      vfio/cdx: Serialize VFIO_DEVICE_SET_IRQS with a per-device mutex

Alexander Usyskin (2):
      mei: me: use PCI_DEVICE_DATA macro
      mei: me: add nova lake point H DID

Alistair Popple (1):
      lib: test_hmm: evict device pages on file close to avoid use-after-free

Amir Goldstein (1):
      fs: prepare for adding LSM blob to backing_file

Andrea Mayer (2):
      seg6: fix seg6 lwtunnel output redirect for L2 reduced encap mode
      net: ipv6: fix NOREF dst use in seg6 and rpl lwtunnels

Andrea Righi (1):
      sched_ext: Documentation: Clarify ops.dispatch() role in task lifecycle

Anshuman Khandual (1):
      arm64/mm: Enable batched TLB flush in unmap_hotplug_range()

Anthony Yznaga (1):
      mm: prevent droppable mappings from being locked

Antoniu Miclaus (2):
      iio: frequency: admv1013: add dev variable
      iio: frequency: admv1013: fix NULL pointer dereference on str

Ao Zhou (1):
      net: rds: fix MR cleanup on copy error

Arjan van de Ven (1):
      drm/amdgpu: fix zero-size GDS range init on RDNA4

Arnd Bergmann (2):
      tpm: avoid -Wunused-but-set-variable
      check-uapi: link into shared objects

Ben Levinsky (1):
      remoteproc: xlnx: Only access buffer information if IPI is buffered

Bin Liu (1):
      mmc: block: use single block write in retry

Brahmajit Das (1):
      ASoC: Intel: avs: replace strcmp with sysfs_streq

Breno Leitao (1):
      netconsole: avoid out-of-bounds access on empty string in trim_newline()

Brian Mak (1):
      mfd: core: Preserve OF node when ACPI handle is present

Brian Ruley (1):
      ARM: 9472/1: fix race condition on PG_dcache_clean in __sync_icache_dcache()

Cengiz Can (1):
      apparmor: use target task's context in apparmor_getprocattr()

Chen Ni (1):
      media: i2c: imx219: Check return value of devm_gpiod_get_optional() in imx219_probe()

Chen Zhao (1):
      IB/core: Fix zero dmac race in neighbor resolution

Chia-Ming Chang (2):
      md/raid5: fix soft lockup in retry_aligned_read()
      inotify: fix watch count leak when fsnotify_add_inode_mark_locked() fails

Corey Minyard (3):
      ipmi:ssif: Clean up kthread on errors
      ipmi:ssif: Remove unnecessary indention
      ipmi:ssif: NULL thread on error

Cássio Gabriel (10):
      ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RATES
      ALSA: usb-audio: Avoid false E-MU sample-rate notifications
      ALSA: usb-audio: Fix Audio Advantage Micro II SPDIF switch
      ALSA: aoa: i2sbus: clear stale prepared state
      ALSA: aoa: i2sbus: fix OF node lifetime handling
      ALSA: seq_oss: return full count for successful SEQ_FULLSIZE writes
      ALSA: caiaq: Fix control_put() result and cache rollback
      ALSA: 6fire: Fix input volume change detection
      ALSA: pcmtest: Fix resource leaks in module init error paths
      ALSA: aloop: Fix peer runtime UAF during format-change stop

Damien Le Moal (1):
      block: fix zone write plugs refcount handling in disk_zone_wplug_schedule_bio_work()

Daniel Hodges (2):
      wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()
      PCI: epf-mhi: Return 0, not remaining timeout, when eDMA ops complete

Danilo Krummrich (1):
      rust: dma: remove DMA_ATTR_NO_KERNEL_MAPPING from public attrs

Dave Hansen (1):
      x86/cpu: Disable FRED when PTI is forced on

David (Ming Qiang) Wu (1):
      amdgpu/jpeg: fix deepsleep register for jpeg 5_0_0 and 5_0_2

David Carlier (2):
      drm/nouveau: fix nvkm_device leak on aperture removal failure
      gtp: disable BH before calling udp_tunnel_xmit_skb()

David Howells (8):
      rxrpc: Fix potential UAF after skb_unshare() failure
      rxrpc: Fix memory leaks in rxkad_verify_response()
      rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
      rxrpc: Fix rxkad crypto unalignment handling
      rxrpc: Fix error handling in rxgk_extract_token()
      rxrpc: Fix re-decryption of RESPONSE packets
      rxrpc: Fix rxrpc_input_call_event() to only unshare DATA packets
      rxgk: Fix potential integer overflow in length check

David Lechner (1):
      iio: adc: ti-ads7950: use iio_push_to_buffers_with_ts_unaligned()

Dawei Feng (1):
      rbd: fix null-ptr-deref when device_add_disk() fails

Deepanshu Kartikey (2):
      ext4: fix bounds check in check_xattrs() to prevent out-of-bounds access
      ALSA: caiaq: fix usb_dev refcount leak on probe failure

Denis M. Karpov (1):
      userfaultfd: allow registration of ranges below mmap_min_addr

Dmitry Torokhov (1):
      Input: edt-ft5x06 - fix use-after-free in debugfs teardown

Douglas Anderson (3):
      driver core: Don't let a device probe until it's ready
      device property: Make modifications of fwnode "flags" thread safe
      driver core: Add kernel-doc for DEV_FLAG_COUNT enum value

Douya Le (1):
      crypto: algif_aead - snapshot IV for async AEAD requests

Elson Serrao (1):
      phy: qcom: m31-eusb2: clear PLL_EN during init

Eric Biggers (1):
      crypto: arm64/aes - Fix 32-bit aes_mac_update() arg treated as 64-bit

Fan Wu (1):
      media: mtk-jpeg: fix use-after-free in release path due to uncancelled work

Fedor Pchelkin (1):
      wifi: rtw88: check for PCI upstream bridge existence

Felix Gu (1):
      EDAC/versalnet: Fix device_node leak in mc_probe()

Francesco Dolcini (1):
      arm64: dts: ti: am62-verdin: Enable pullup for eMMC data pins

Gao Xiang (1):
      erofs: fix the out-of-bounds nameoff handling for trailing dirents

Giovanni Cabiddu (2):
      crypto: qat - fix IRQ cleanup on 6xxx probe failure
      crypto: acomp - fix wrong pointer stored by acomp_save_req()

Greg Kroah-Hartman (5):
      LoongArch: Add spectre boundry for syscall dispatch table
      drm/nouveau: fix u32 overflow in pushbuf reloc bounds check
      leds: qcom-lpg: Check for array overflow when selecting the high resolution
      ipv6: rpl: reserve mac_len headroom when recompressed SRH grows
      Linux 6.18.27

Guangshuo Li (1):
      ALSA: pcmtest: fix reference leak on failed device registration

Gunnar Kudrjavets (3):
      tpm2-sessions: Fix missing tpm_buf_destroy() in tpm2_read_public()
      tpm: Fix auth session leak in tpm2_get_random() error path
      tpm: Use kfree_sensitive() to free auth session in tpm_dev_release()

Gustavo A. R. Silva (1):
      crypto: nx - Fix packed layout in struct nx842_crypto_header

Hans Holmberg (1):
      xfs: start gc on zonegc_low_space attribute updates

Hao Ge (1):
      mm/alloc_tag: clear codetag for pages allocated before page_ext initialization

Haoxiang Li (2):
      xfs: fix a resource leak in xfs_alloc_buftarg()
      crypto: ccree - fix a memory leak in cc_mac_digest()

Harin Lee (1):
      ALSA: ctxfi: Add fallback to default RSR for S/PDIF

Harry Yoo (Oracle) (2):
      mm/page_alloc: return NULL early from alloc_frozen_pages_nolock() in NMI on UP
      mm/slab: return NULL early from kmalloc_nolock() in NMI on UP

Helge Deller (2):
      parisc: _llseek syscall is only available for 32-bit userspace
      parisc: Drop ip_fast_csum() inline assembly implementation

Heming Zhao (1):
      ocfs2: split transactions in dio completion to avoid credit exhaustion

Herbert Xu (1):
      crypto: pcrypt - Fix handling of MAY_BACKLOG requests

Huacai Chen (1):
      LoongArch: Show CPU vulnerabilites correctly

Jackie Liu (2):
      mm/mempolicy: fix memory leaks in weighted_interleave_auto_store()
      mm/damon/stat: fix memory leak on damon_start() failure in damon_stat_start()

Jacqueline Wong (2):
      tpm: tpm_tis: add error logging for data transfer
      tpm: tpm_tis: stop transmit if retries are exhausted

James Kim (1):
      mtd: docg3: fix use-after-free in docg3_release()

Jens Axboe (2):
      io_uring/register: fix ring resizing with mixed/large SQEs/CQEs
      io_uring/poll: ensure EPOLL_ONESHOT is propagated for EPOLL_URING_WAKE

Jiawen Wu (2):
      net: txgbe: fix RTNL assertion warning when remove module
      net: txgbe: fix firmware version check

Johan Hovold (5):
      spi: imx: fix use-after-free on unbind
      spi: ch341: fix memory leaks on probe failures
      spi: fix resource leaks on device setup failure
      rtc: ntxec: fix OF node reference imbalance
      can: ucan: fix devres lifetime

Jonathan Santos (2):
      iio: adc: ad7768-1: fix one-shot mode data acquisition
      iio: adc: ad7768-1: remove switch to one-shot mode

Joseph Salisbury (1):
      sched: Use u64 for bandwidth ratio calculations

Josh Hunt (1):
      md/raid10: fix deadlock with check operation and nowait requests

Josh Law (1):
      lib/ts_kmp: fix integer overflow in pattern length calculation

Junrui Luo (2):
      md/raid5: validate payload size before accessing journal metadata
      dm mirror: fix integer overflow in create_dirty_log()

Kai Ma (1):
      netfilter: reject zero shift in nft_bitwise

Keenan Dong (1):
      rtmutex: Use waiter::task instead of current in remove_waiter()

Kevin Brodsky (1):
      arm64: mm: Simplify check in arch_kfence_init_pool()

Kevin Cheng (2):
      KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=0
      KVM: nSVM: Raise #UD if unhandled VMMCALL isn't intercepted by L1

Koichiro Den (1):
      PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown

Krzysztof Kozlowski (1):
      power: supply: axp288_charger: Do not cancel work before initializing it

Long Li (1):
      RDMA/mana_ib: Disable RX steering on RSS QP destroy

Longxuan Yu (1):
      io_uring/poll: fix signed comparison in io_poll_get_ownership()

Lorenzo Stoakes (Oracle) (1):
      fs: afs: revert mmap_prepare() change

Luca Ceresoli (1):
      drm/arcpgu: fix device node leak

Luxiao Xu (1):
      net: strparser: fix skb_head leak in strp_abort_strp()

Manish Honap (1):
      vfio: selftests: Fix VLA initialisation in vfio_pci_irq_set()

Manivannan Sadhasivam (5):
      net: qrtr: ns: Fix use-after-free in driver remove()
      net: qrtr: ns: Free the node during ctrl_cmd_bye()
      net: qrtr: ns: Limit the maximum server registration per node
      net: qrtr: ns: Limit the maximum number of lookups
      net: qrtr: ns: Limit the total number of nodes

Marco Elver (2):
      slub: fix data loss and overflow in krealloc()
      vmalloc: fix buffer overflow in vrealloc_node_align()

Marek Vasut (3):
      mfd: stpmic1: Attempt system shutdown twice in case PMIC is confused
      net: ks8851: Reinstate disabling of BHs around IRQ handler
      net: ks8851: Avoid excess softirq scheduling

Masami Hiramatsu (Google) (2):
      tracing/fprobe: Reject registration of a registered fprobe before init
      ring-buffer: Do not double count the reader_page

Matthew Wilcox (Oracle) (1):
      mm: call ->free_folio() directly in folio_unmap_invalidate()

Max Kellermann (1):
      ceph: only d_add() negative dentries when they are unhashed

Michael Bommarito (1):
      um: drivers: call kernel_strrchr() explicitly in cow_user.c

Michal Pecio (1):
      usb: xhci: Make usb_host_endpoint.hcpriv survive endpoint_disable()

Mickaël Salaün (5):
      landlock: Fix LOG_SUBDOMAINS_OFF inheritance across fork()
      selftests/landlock: Drain stale audit records on init
      selftests/landlock: Fix format warning for __u64 in net_test
      selftests/landlock: Fix snprintf truncation checks in audit helpers
      selftests/landlock: Skip stale records in audit_match_record()

Miguel Ojeda (1):
      kbuild: rust: allow `clippy::uninlined_format_args`

Ming Qian (1):
      media: amphion: Fix race between m2m job_abort and device_run

Miquel Raynal (1):
      mtd: spinand: winbond: Declare the QE bit on W25NxxJW

Naman Jain (1):
      block: relax pgmap check in bio_add_page for compatible zone device pages

Nathan Chancellor (1):
      extract-cert: Wrap key_pass with '#ifdef USE_PKCS11_ENGINE'

Oliver Neukum (2):
      media: rc: ttusbir: respect DMA coherency rules
      media: rc: igorplugusb: heed coherency rules

Paul Louvel (2):
      crypto: talitos - fix SEC1 32k ahash request limitation
      crypto: talitos - rename first/last to first_desc/last_desc

Pavel Begunkov (1):
      io_uring/timeout: check unused sqe fields

Pengpeng Hou (1):
      greybus: gb-beagleplay: bound bootloader receive buffering

Prasanna Kumar T S M (2):
      vfio/cdx: Fix NULL pointer dereference in interrupt trigger path
      EDAC/versalnet: Fix memory leak in remove and probe error paths

Qiang Yu (1):
      bus: mhi: host: pci_generic: Switch to async power up to avoid boot delays

Rafael J. Wysocki (1):
      thermal: core: Fix thermal zone governor cleanup issues

Raphael Zimmer (1):
      libceph: Prevent potential null-ptr-deref in ceph_handle_auth_reply()

Richard Zhu (1):
      PCI: imx6: Skip waiting for L2/L3 Ready on i.MX6SX

Rick Edgecombe (1):
      x86/shstk: Prevent deadlock during shstk sigreturn

Robert Beckett (2):
      nvme-pci: add NVME_QUIRK_DISABLE_WRITE_ZEROES for Kingston OM3SGP4
      nvme: respect NVME_QUIRK_DISABLE_WRITE_ZEROES when wzsl is set

Robert Marko (1):
      arm64: dts: marvell: uDPU: add ethernet aliases

Ronak Raheja (1):
      phy: qcom: m31-eusb2: Update init sequence to set PHY_ENABLE

Rong Bao (1):
      perf annotate: Use jump__delete when freeing LoongArch jumps

Rong Zhang (1):
      Revert "ALSA: usb: Increase volume range that triggers a warning"

Ruide Cao (1):
      ipv4: icmp: validate reply type before using icmp_pointers

Ruijie Li (1):
      net/smc: avoid early lgr access in smc_clc_wait_msg

Ryan Roberts (2):
      randomize_kstack: Maintain kstack_offset per task
      arm64: mm: Fix rodata=full block mapping support for realm guests

Sanjaikumar V S (1):
      mtd: spi-nor: sst: Fix write enable before AAI sequence

Sanman Pradhan (3):
      hwmon: (powerz) Fix missing usb_kill_urb() on signal interrupt
      hwmon: (isl28022) Fix integer overflow in power calculation on 32-bit
      hwmon: (pt5161l) Fix bugs in pt5161l_read_block_data()

Sean Christopherson (5):
      KVM: selftests: Fix reserved value WRMSR testcase for multi-feature MSRs
      KVM: x86: Defer non-architectural deliver of exception payload to userspace read
      KVM: SVM: Explicitly mark vmcb01 dirty after modifying VMCB intercepts
      KVM: nSVM: Delay setting soft IRQ RIP tracking fields until vCPU run
      KVM: nSVM: Always intercept VMMCALL when L2 is active

Sean Wang (2):
      wifi: mt76: mt792x: describe USB WFSYS reset with a descriptor
      wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling

SeongJae Park (3):
      mm/damon/core: fix damon_call() vs kdamond_fn() exit race
      mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
      mm/damon/core: use time_in_range_open() for damos quota window start

Sergey Senozhatsky (1):
      zram: do not forget to endio for partial discard requests

Shawn Lin (1):
      mmc: sdhci-of-dwcmshc: Disable clock before DLL configuration

Shigeru Yoshida (1):
      mm/zsmalloc: copy KMSAN metadata in zs_page_migrate()

Shuvam Pandey (1):
      Bluetooth: hci_event: fix potential UAF in SSP passkey handlers

Simon Liebold (1):
      selftests/mqueue: Fix incorrectly named file

Sohei Koyama (1):
      ext4: fix missing brelse() in ext4_xattr_inode_dec_ref_all()

Spencer Payton (1):
      ALSA: hda/realtek - Add mute LED support for HP Victus 15-fa2xxx

Steven Rostedt (1):
      ktest: Fix the month in the name of the failure directory

Swamil Jain (1):
      dt-bindings: display: ti, am65x-dss: Fix AM62L DSS reg and clock constraints

Takashi Iwai (5):
      ALSA: usb-audio: Evaluate packsize caps at the right place
      ALSA: core: Fix potential data race at fasync handling
      ALSA: caiaq: Handle probe errors properly
      ALSA: caiaq: Fix potentially leftover ep1_in_urb at error path
      ALSA: caiaq: Don't abort when no input device is available

Tao Cui (1):
      LoongArch: KVM: Use CSR_CRMD_PLV in kvm_arch_vcpu_in_kernel()

Thomas Fourier (1):
      crypto: hisilicon - Fix dma_unmap_single() direction

Thomas Zimmermann (2):
      firmware: google: framebuffer: Do not mark framebuffer as busy
      firmware: google: framebuffer: Do not unregister platform device

Thorsten Blum (11):
      crypto: atmel-sha204a - Fix OTP sysfs read and error handling
      ALSA: aoa: Skip devices with no codecs in i2sbus_resume()
      mm/hugetlb: fix early boot crash on parameters without '=' separator
      crypto: atmel-aes - Fix 3-page memory leak in atmel_aes_buff_cleanup
      crypto: atmel-ecc - Release client on allocation failure
      crypto: atmel-tdes - fix DMA sync direction
      crypto: atmel-sha204a - Fix error codes in OTP reads
      crypto: atmel-sha204a - Fix potential UAF and memory leak in remove path
      crypto: atmel-sha204a - Fix uninitialized data access on OTP read error
      crypto: nx - fix bounce buffer leaks in nx842_crypto_{alloc,free}_ctx
      crypto: nx - fix context leak in nx842_crypto_free_ctx

Tiezhu Yang (1):
      drm/amd: Fix set but not used warnings

Tobias Gaertner (2):
      ntfs3: add buffer boundary checks to run_unpack()
      ntfs3: fix integer overflow in run_unpack() volume boundary check

Tommaso Merciai (1):
      reset: rzv2h-usb2phy: Keep PHY clock enabled for entire device lifetime

Tushar Sariya (1):
      NFSv4.1: Apply session size limits on clone path

Tyllis Xu (3):
      misc: ibmasm: fix OOB MMIO read in ibmasm_handle_mouse_interrupt()
      ibmasm: fix OOB reads in command_file_write due to missing size checks
      ibmasm: fix heap over-read in ibmasm_send_i2o_message()

Uladzislau Rezki (Sony) (1):
      mm/vmalloc: take vmap_purge_lock in shrinker

Usama Arif (1):
      mm: migrate: requeue destination folio on deferred split queue

Vasiliy Kovalev (1):
      ext2: reject inodes with zero i_nlink and valid mode in ext2_iget()

Viorel Suman (OSS) (1):
      pwm: imx-tpm: Count the number of enabled channels in probe

Weigang He (1):
      greybus: gb-beagleplay: fix sleep in atomic context in hdlc_tx_frames()

Wentao Liang (2):
      of: unittest: fix use-after-free in of_unittest_changeset()
      of: unittest: fix use-after-free in testdrv_probe()

Xu Yang (2):
      usb: chipidea: otg: not wait vbus drop if use role_switch
      usb: chipidea: core: allow ci_irq_handler() handle both ID and VBUS change

Yang Xiuwei (1):
      scsi: sd: fix missing put_disk() when device_add(&disk_dev) fails

Yi Cong (1):
      wifi: rtl8xxxu: fix potential use of uninitialized value

Yiyang Chen (2):
      tools/accounting: handle truncated taskstats netlink messages
      taskstats: set version in TGID exit notifications

Yosry Ahmed (20):
      KVM: nSVM: Mark all of vmcb02 dirty when restoring nested state
      KVM: nSVM: Sync NextRIP to cached vmcb12 after VMRUN of L2
      KVM: nSVM: Sync interrupt shadow to cached vmcb12 after VMRUN of L2
      KVM: nSVM: Ensure AVIC is inhibited when restoring a vCPU to guest mode
      KVM: nSVM: Always use NextRIP as vmcb02's NextRIP after first L2 VMRUN
      KVM: nSVM: Delay stuffing L2's current RIP into NextRIP until vCPU run
      KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on nested #VMEXIT
      KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12
      KVM: SVM: Switch svm_copy_lbrs() to a macro
      KVM: SVM: Add missing save/restore handling of LBR MSRs
      KVM: nSVM: Always inject a #GP if mapping VMCB12 fails on nested VMRUN
      KVM: nSVM: Refactor checking LBRV enablement in vmcb12 into a helper
      KVM: nSVM: Refactor writing vmcb12 on nested #VMEXIT as a helper
      KVM: nSVM: Triple fault if mapping VMCB12 fails on nested #VMEXIT
      KVM: nSVM: Clear GIF on nested #VMEXIT(INVALID)
      KVM: nSVM: Clear EVENTINJ fields in vmcb12 on nested #VMEXIT
      KVM: nSVM: Clear tracking of L1->L2 NMI and soft IRQ on nested #VMEXIT
      KVM: nSVM: Add missing consistency check for EFER, CR0, CR4, and CS
      KVM: nSVM: Drop the non-architectural consistency check for NP_ENABLE
      KVM: nSVM: Add missing consistency check for nCR3 validity

Yu Kuai (2):
      md/md-llbitmap: skip reading rdevs that are not in_sync
      md/md-llbitmap: raise barrier before state machine transition

Yuan Zhaoming (1):
      net: mctp: fix don't require received header reserved bits to be zero

Yucheng Lu (1):
      crypto: authencesn - reject short ahash digests during instance creation

Zhang Yi (1):
      jbd2: fix deadlock in jbd2_journal_cancel_revoke()

Zhengchuan Liang (2):
      net: caif: clear client service pointer on teardown
      net: bridge: use a stable FDB dst snapshot in RCU readers

Zhenzhong Wu (1):
      tcp: call sk_data_ready() after listener migration

Ziqing Chen (1):
      ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()

hkbinbin (1):
      RDMA/rxe: Validate pad and ICRC before payload_size() in rxe_rcv



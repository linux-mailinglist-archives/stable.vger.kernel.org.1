Return-Path: <stable+bounces-244501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Cf2LrUa/GlALgAAu9opvQ
	(envelope-from <stable+bounces-244501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 06:53:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B3C4E2EE3
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 06:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFF923009CEA
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 04:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D34D325483;
	Thu,  7 May 2026 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dclTi9Vk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3405031F992;
	Thu,  7 May 2026 04:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778129583; cv=none; b=DmHI0qwMdt5Y6DnYI5w00s7F/q+z2pU7KbhVmHq5nuFlneLLn+gQIcxceBmEg11VvuEUFrQQwHhmVKQrxmhoeuyOKXhCiPBvWMLHZ9yCjUWROUrKXA9N4Ejm4y0LKDh6e/Rhd0kosOrM0SfNvmXOUq3ZaBQBIXDPA6JeKqPYrzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778129583; c=relaxed/simple;
	bh=uzTxD0gxcJrk3jTj1n5Wfgams9VpyhQ4y09N1yRUrOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=utw1oZ69H75xtszb3wM+4QOTykiUVr9sXR5i6yWEghm4KjmdbjPubMD+n8Z+QXFtwKFW0bhBZwsHZcTjeZDRwh3y3scp06e5Aiy9LCXKpFghrvtRgx0HnjUzhAYTlyf/6PcyavYaSzeUEl/TKbsPMUbA2TM/wF+8a+XV92Yzz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dclTi9Vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ACFC2BCB8;
	Thu,  7 May 2026 04:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778129582;
	bh=uzTxD0gxcJrk3jTj1n5Wfgams9VpyhQ4y09N1yRUrOw=;
	h=From:To:Cc:Subject:Date:From;
	b=dclTi9VkRKTgEdkkY+zkqCFI2IdXoSTcKwQGGutodjB/t/UCjbieJ+R45prbgttFL
	 cR/RTCByfCe92kh884c4Osx2tflmsaZvKartqP9Cs6C3g3FfeyGe1tYxzQK43kWltX
	 fvht0LaHySkQTjh/p+GNtJHTmRLvCdVXuo+STT/o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.86
Date: Thu,  7 May 2026 06:52:58 +0200
Message-ID: <2026050759-overcast-muscular-ff7d@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 47B3C4E2EE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244501-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I'm announcing the release of the 6.12.86 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    3 
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi    |    5 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi           |   20 -
 arch/arm64/crypto/aes-modes.S                        |    4 
 arch/arm64/mm/mmu.c                                  |   36 +-
 arch/loongarch/kernel/cpu-probe.c                    |    7 
 arch/loongarch/kernel/syscall.c                      |    3 
 arch/parisc/kernel/syscalls/syscall.tbl              |    2 
 arch/um/drivers/cow_user.c                           |    8 
 arch/x86/kvm/hyperv.h                                |    8 
 arch/x86/kvm/svm/hyperv.h                            |    9 
 arch/x86/kvm/svm/nested.c                            |   55 ++--
 arch/x86/kvm/svm/svm.c                               |   32 ++
 arch/x86/kvm/svm/svm.h                               |    1 
 arch/x86/kvm/x86.c                                   |   62 ++--
 arch/x86/mm/pti.c                                    |    5 
 block/bio-integrity.c                                |    2 
 block/bio.c                                          |   14 -
 block/blk-zoned.c                                    |   12 
 block/blk.h                                          |   19 +
 certs/extract-cert.c                                 |    6 
 crypto/authencesn.c                                  |    5 
 crypto/pcrypt.c                                      |    7 
 drivers/base/core.c                                  |   39 ++
 drivers/base/dd.c                                    |   20 +
 drivers/block/rbd.c                                  |    6 
 drivers/block/zram/zram_drv.c                        |    3 
 drivers/bus/imx-weim.c                               |    2 
 drivers/bus/mhi/host/pci_generic.c                   |    2 
 drivers/char/tpm/tpm-chip.c                          |    2 
 drivers/char/tpm/tpm2-cmd.c                          |    6 
 drivers/char/tpm/tpm_tis_core.c                      |   11 
 drivers/crypto/atmel-aes.c                           |    2 
 drivers/crypto/atmel-ecc.c                           |    1 
 drivers/crypto/atmel-i2c.c                           |    4 
 drivers/crypto/atmel-sha204a.c                       |   37 +-
 drivers/crypto/atmel-tdes.c                          |    8 
 drivers/crypto/ccree/cc_hash.c                       |    1 
 drivers/crypto/hisilicon/sec/sec_algs.c              |    2 
 drivers/crypto/nx/nx-842.h                           |    4 
 drivers/crypto/talitos.c                             |  254 ++++++++++++-------
 drivers/firmware/google/framebuffer-coreboot.c       |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c          |   43 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c              |    3 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c             |   52 +++
 drivers/gpu/drm/nouveau/nouveau_drm.c                |    2 
 drivers/gpu/drm/nouveau/nouveau_gem.c                |    2 
 drivers/gpu/drm/tiny/arcpgu.c                        |    3 
 drivers/greybus/gb-beagleplay.c                      |  112 +++++++-
 drivers/hid/hid-apple.c                              |    2 
 drivers/hwmon/powerz.c                               |   11 
 drivers/hwmon/pt5161l.c                              |    4 
 drivers/i2c/i2c-core-of.c                            |    2 
 drivers/iio/adc/ad7768-1.c                           |    9 
 drivers/iio/adc/ti-ads7950.c                         |   11 
 drivers/iio/frequency/admv1013.c                     |   90 +++---
 drivers/infiniband/core/addr.c                       |    3 
 drivers/infiniband/hw/mana/qp.c                      |   15 +
 drivers/infiniband/sw/rxe/rxe_recv.c                 |    3 
 drivers/leds/rgb/leds-qcom-lpg.c                     |    7 
 drivers/md/dm-raid1.c                                |    6 
 drivers/md/raid10.c                                  |    4 
 drivers/md/raid5-cache.c                             |   48 ++-
 drivers/md/raid5.c                                   |    8 
 drivers/media/i2c/imx219.c                           |    3 
 drivers/media/platform/amphion/vpu_v4l2.c            |    9 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c |    1 
 drivers/media/rc/igorplugusb.c                       |   16 -
 drivers/media/rc/ttusbir.c                           |   13 
 drivers/mfd/mfd-core.c                               |   12 
 drivers/mfd/stpmic1.c                                |   20 +
 drivers/misc/ibmasm/ibmasmfs.c                       |    7 
 drivers/misc/ibmasm/lowlevel.c                       |   12 
 drivers/misc/ibmasm/remote.c                         |    5 
 drivers/mmc/core/block.c                             |   12 
 drivers/mmc/core/queue.h                             |    3 
 drivers/mmc/host/sdhci-of-dwcmshc.c                  |   19 +
 drivers/mtd/devices/docg3.c                          |    3 
 drivers/mtd/spi-nor/sst.c                            |   13 
 drivers/net/bonding/bond_main.c                      |   12 
 drivers/net/can/usb/ucan.c                           |    2 
 drivers/net/ethernet/micrel/ks8851.h                 |    6 
 drivers/net/ethernet/micrel/ks8851_common.c          |   69 ++---
 drivers/net/ethernet/micrel/ks8851_par.c             |   15 -
 drivers/net/ethernet/micrel/ks8851_spi.c             |   11 
 drivers/net/ethernet/microsoft/mana/mana_en.c        |   11 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c      |    3 
 drivers/net/netconsole.c                             |    2 
 drivers/net/phy/mdio_bus.c                           |    4 
 drivers/net/wireless/marvell/mwifiex/init.c          |    2 
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h     |    4 
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c      |   51 +++
 drivers/net/wireless/realtek/rtl8xxxu/core.c         |   28 --
 drivers/net/wireless/realtek/rtw88/pci.c             |    3 
 drivers/nvme/host/core.c                             |    2 
 drivers/nvme/host/pci.c                              |    2 
 drivers/of/base.c                                    |    2 
 drivers/of/dynamic.c                                 |    2 
 drivers/of/platform.c                                |    2 
 drivers/of/unittest.c                                |    4 
 drivers/pci/endpoint/functions/pci-epf-mhi.c         |    4 
 drivers/pci/endpoint/functions/pci-epf-ntb.c         |   56 ----
 drivers/power/supply/axp288_charger.c                |   19 -
 drivers/pwm/pwm-imx-tpm.c                            |    9 
 drivers/remoteproc/xlnx_r5_remoteproc.c              |   20 -
 drivers/rtc/rtc-ntxec.c                              |    2 
 drivers/scsi/sd.c                                    |    1 
 drivers/spi/spi-ch341.c                              |   36 +-
 drivers/spi/spi-imx.c                                |    4 
 drivers/spi/spi.c                                    |   63 ++--
 drivers/thermal/thermal_core.c                       |    7 
 drivers/usb/chipidea/core.c                          |   45 +--
 drivers/usb/chipidea/otg.c                           |    7 
 drivers/usb/host/xhci.c                              |    1 
 drivers/vfio/cdx/intr.c                              |   13 
 drivers/vfio/cdx/main.c                              |   19 +
 drivers/vfio/cdx/private.h                           |    3 
 fs/ceph/dir.c                                        |    6 
 fs/erofs/dir.c                                       |   28 +-
 fs/ext2/inode.c                                      |   14 -
 fs/ext4/xattr.c                                      |    6 
 fs/f2fs/data.c                                       |    4 
 fs/f2fs/f2fs.h                                       |    2 
 fs/f2fs/segment.c                                    |    6 
 fs/f2fs/super.c                                      |   11 
 fs/jbd2/revoke.c                                     |    8 
 fs/notify/inotify/inotify_user.c                     |    1 
 fs/ntfs3/run.c                                       |   18 +
 fs/ocfs2/aops.c                                      |   74 +++--
 fs/smb/client/cifsacl.c                              |  116 ++++++--
 fs/smb/server/connection.c                           |   28 --
 fs/smb/server/connection.h                           |    6 
 fs/smb/server/smb2pdu.c                              |    4 
 fs/smb/server/transport_rdma.c                       |    5 
 fs/smb/server/transport_tcp.c                        |   25 +
 fs/userfaultfd.c                                     |    2 
 fs/xfs/xfs_buf.c                                     |    1 
 include/linux/device.h                               |   45 +++
 include/linux/fwnode.h                               |   44 ++-
 include/linux/hugetlb_inline.h                       |    4 
 include/linux/padata.h                               |    4 
 include/linux/randomize_kstack.h                     |   26 +
 include/linux/sched.h                                |    4 
 include/linux/tpm_eventlog.h                         |    9 
 include/linux/usb.h                                  |    3 
 include/net/mana/mana.h                              |    1 
 include/net/mctp.h                                   |    3 
 include/trace/events/rxrpc.h                         |    6 
 init/main.c                                          |    1 
 io_uring/poll.c                                      |   15 -
 io_uring/timeout.c                                   |    4 
 kernel/fork.c                                        |    2 
 kernel/locking/rtmutex.c                             |   13 
 kernel/padata.c                                      |  136 ++--------
 kernel/sched/core.c                                  |    2 
 kernel/sched/rt.c                                    |    2 
 kernel/sched/sched.h                                 |    2 
 kernel/taskstats.c                                   |    1 
 lib/test_hmm.c                                       |   86 +++---
 lib/ts_kmp.c                                         |   18 +
 mm/damon/core.c                                      |    3 
 mm/internal.h                                        |   10 
 mm/memory_hotplug.c                                  |   10 
 mm/migrate.c                                         |  152 ++++++-----
 mm/mlock.c                                           |   10 
 mm/mmap.c                                            |    4 
 mm/zsmalloc.c                                        |    1 
 net/bluetooth/hci_event.c                            |   18 +
 net/bridge/br_arp_nd_proxy.c                         |    8 
 net/bridge/br_fdb.c                                  |   28 +-
 net/caif/cfsrvl.c                                    |   14 -
 net/ceph/auth.c                                      |    2 
 net/ipv4/icmp.c                                      |    5 
 net/ipv4/inet_connection_sock.c                      |    3 
 net/ipv6/exthdrs.c                                   |    9 
 net/ipv6/rpl_iptunnel.c                              |    9 
 net/ipv6/seg6_iptunnel.c                             |   12 
 net/mctp/route.c                                     |    8 
 net/netfilter/nft_bitwise.c                          |    3 
 net/qrtr/ns.c                                        |   86 +++++-
 net/rds/rdma.c                                       |    4 
 net/rxrpc/ar-internal.h                              |    1 
 net/rxrpc/call_event.c                               |   25 +
 net/rxrpc/conn_event.c                               |   14 -
 net/rxrpc/io_thread.c                                |   24 -
 net/rxrpc/rxkad.c                                    |  112 +++-----
 net/rxrpc/skbuff.c                                   |    9 
 net/smc/smc_clc.c                                    |    4 
 net/strparser/strparser.c                            |    8 
 rust/kernel/init/macros.rs                           |    7 
 scripts/check-uapi.sh                                |    7 
 security/apparmor/lsm.c                              |   16 -
 sound/aoa/codecs/onyx.c                              |  104 ++-----
 sound/aoa/codecs/tas.c                               |  113 ++------
 sound/aoa/core/gpio-feature.c                        |   20 -
 sound/aoa/core/gpio-pmf.c                            |   26 -
 sound/aoa/soundbus/i2sbus/core.c                     |   12 
 sound/aoa/soundbus/i2sbus/pcm.c                      |  143 +++++-----
 sound/core/control.c                                 |    4 
 sound/core/misc.c                                    |   13 
 sound/core/seq/oss/seq_oss_rw.c                      |    6 
 sound/drivers/pcmtest.c                              |   19 +
 sound/pci/ctxfi/ctatc.c                              |    3 
 sound/usb/6fire/control.c                            |   10 
 sound/usb/caiaq/control.c                            |   52 ++-
 sound/usb/caiaq/device.c                             |   35 +-
 sound/usb/caiaq/input.c                              |    2 
 sound/usb/endpoint.c                                 |    6 
 sound/usb/format.c                                   |    2 
 sound/usb/mixer.c                                    |    7 
 sound/usb/mixer_quirks.c                             |   12 
 tools/accounting/getdelays.c                         |   41 ++-
 tools/accounting/procacct.c                          |   40 ++
 tools/perf/arch/loongarch/annotate/instructions.c    |    1 
 tools/perf/util/disasm.c                             |    1 
 tools/testing/ktest/ktest.pl                         |    2 
 tools/testing/selftests/landlock/net_test.c          |    2 
 tools/testing/selftests/mqueue/setting               |    1 
 tools/testing/selftests/mqueue/settings              |    1 
 219 files changed, 2463 insertions(+), 1512 deletions(-)

Aditya Garg (1):
      HID: apple: ensure the keyboard backlight is off if suspending

Alex Williamson (1):
      vfio/cdx: Serialize VFIO_DEVICE_SET_IRQS with a per-device mutex

Alistair Popple (1):
      lib: test_hmm: evict device pages on file close to avoid use-after-free

Andrea Mayer (2):
      seg6: fix seg6 lwtunnel output redirect for L2 reduced encap mode
      net: ipv6: fix NOREF dst use in seg6 and rpl lwtunnels

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

Breno Leitao (1):
      netconsole: avoid out-of-bounds access on empty string in trim_newline()

Brian Mak (1):
      mfd: core: Preserve OF node when ACPI handle is present

Cengiz Can (1):
      apparmor: use target task's context in apparmor_getprocattr()

Chao Yu (1):
      f2fs: fix to do sanity check on dcc->discard_cmd_cnt conditionally

Chen Ni (1):
      media: i2c: imx219: Check return value of devm_gpiod_get_optional() in imx219_probe()

Chen Zhao (1):
      IB/core: Fix zero dmac race in neighbor resolution

Chia-Ming Chang (2):
      md/raid5: fix soft lockup in retry_aligned_read()
      inotify: fix watch count leak when fsnotify_add_inode_mark_locked() fails

Cássio Gabriel (9):
      ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RATES
      ALSA: usb-audio: Avoid false E-MU sample-rate notifications
      ALSA: usb-audio: Fix Audio Advantage Micro II SPDIF switch
      ALSA: aoa: i2sbus: fix OF node lifetime handling
      ALSA: seq_oss: return full count for successful SEQ_FULLSIZE writes
      ALSA: caiaq: Fix control_put() result and cache rollback
      ALSA: 6fire: Fix input volume change detection
      ALSA: pcmtest: Fix resource leaks in module init error paths
      ALSA: aoa: i2sbus: clear stale prepared state

DaeMyung Kang (1):
      ksmbd: reset rcount per connection in ksmbd_conn_wait_idle_sess_id()

Damien Le Moal (1):
      block: fix zone write plugs refcount handling in disk_zone_wplug_schedule_bio_work()

Daniel Hodges (2):
      PCI: epf-mhi: Return 0, not remaining timeout, when eDMA ops complete
      wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()

Dave Hansen (1):
      x86/cpu: Disable FRED when PTI is forced on

David (Ming Qiang) Wu (1):
      amdgpu/jpeg: fix deepsleep register for jpeg 5_0_0 and 5_0_2

David Carlier (1):
      drm/nouveau: fix nvkm_device leak on aperture removal failure

David Hildenbrand (2):
      mm/migrate: factor out movable_ops page handling into migrate_movable_ops_page()
      mm/migrate: move movable_ops page handling out of move_to_new_folio()

David Howells (5):
      rxrpc: Fix memory leaks in rxkad_verify_response()
      rxrpc: Fix rxkad crypto unalignment handling
      rxrpc: Fix re-decryption of RESPONSE packets
      rxrpc: Fix potential UAF after skb_unshare() failure
      rxrpc: Fix rxrpc_input_call_event() to only unshare DATA packets

David Lechner (1):
      iio: adc: ti-ads7950: use iio_push_to_buffers_with_ts_unaligned()

Dawei Feng (1):
      rbd: fix null-ptr-deref when device_add_disk() fails

Deepanshu Kartikey (2):
      ext4: fix bounds check in check_xattrs() to prevent out-of-bounds access
      ALSA: caiaq: fix usb_dev refcount leak on probe failure

Denis M. Karpov (1):
      userfaultfd: allow registration of ranges below mmap_min_addr

Douglas Anderson (3):
      driver core: Don't let a device probe until it's ready
      device property: Make modifications of fwnode "flags" thread safe
      driver core: Add kernel-doc for DEV_FLAG_COUNT enum value

Eric Biggers (1):
      crypto: arm64/aes - Fix 32-bit aes_mac_update() arg treated as 64-bit

Fan Wu (1):
      media: mtk-jpeg: fix use-after-free in release path due to uncancelled work

Fedor Pchelkin (1):
      wifi: rtw88: check for PCI upstream bridge existence

Francesco Dolcini (1):
      arm64: dts: ti: am62-verdin: Enable pullup for eMMC data pins

Gao Xiang (1):
      erofs: fix the out-of-bounds nameoff handling for trailing dirents

Greg Kroah-Hartman (5):
      LoongArch: Add spectre boundry for syscall dispatch table
      drm/nouveau: fix u32 overflow in pushbuf reloc bounds check
      leds: qcom-lpg: Check for array overflow when selecting the high resolution
      ipv6: rpl: reserve mac_len headroom when recompressed SRH grows
      Linux 6.12.86

Guangshuo Li (1):
      ALSA: pcmtest: fix reference leak on failed device registration

Gunnar Kudrjavets (2):
      tpm: Fix auth session leak in tpm2_get_random() error path
      tpm: Use kfree_sensitive() to free auth session in tpm_dev_release()

Gustavo A. R. Silva (1):
      crypto: nx - Fix packed layout in struct nx842_crypto_header

Haoxiang Li (2):
      xfs: fix a resource leak in xfs_alloc_buftarg()
      crypto: ccree - fix a memory leak in cc_mac_digest()

Harin Lee (1):
      ALSA: ctxfi: Add fallback to default RSR for S/PDIF

Helge Deller (1):
      parisc: _llseek syscall is only available for 32-bit userspace

Heming Zhao (1):
      ocfs2: split transactions in dio completion to avoid credit exhaustion

Herbert Xu (3):
      padata: Fix pd UAF once and for all
      padata: Remove comment for reorder_work
      crypto: pcrypt - Fix handling of MAY_BACKLOG requests

Huacai Chen (1):
      LoongArch: Show CPU vulnerabilites correctly

Jacqueline Wong (2):
      tpm: tpm_tis: add error logging for data transfer
      tpm: tpm_tis: stop transmit if retries are exhausted

James Kim (1):
      mtd: docg3: fix use-after-free in docg3_release()

Jens Axboe (2):
      io_uring/poll: ensure EPOLL_ONESHOT is propagated for EPOLL_URING_WAKE
      io_uring/poll: fix multishot recv missing EOF on wakeup race

Jesse.Zhang (1):
      drm/amdgpu: Limit BO list entry count to prevent resource exhaustion

Jiawen Wu (1):
      net: txgbe: fix firmware version check

Jinjiang Tu (1):
      mm/memory_hotplug: fix hwpoisoned large folio handling in do_migrate_range()

Johan Hovold (5):
      spi: imx: fix use-after-free on unbind
      spi: ch341: fix memory leaks on probe failures
      rtc: ntxec: fix OF node reference imbalance
      can: ucan: fix devres lifetime
      spi: fix resource leaks on device setup failure

Jonathan Santos (1):
      iio: adc: ad7768-1: fix one-shot mode data acquisition

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

Luca Ceresoli (1):
      drm/arcpgu: fix device node leak

Luxiao Xu (1):
      net: strparser: fix skb_head leak in strp_abort_strp()

Manivannan Sadhasivam (5):
      net: qrtr: ns: Fix use-after-free in driver remove()
      net: qrtr: ns: Free the node during ctrl_cmd_bye()
      net: qrtr: ns: Limit the maximum server registration per node
      net: qrtr: ns: Limit the maximum number of lookups
      net: qrtr: ns: Limit the total number of nodes

Marek Vasut (3):
      mfd: stpmic1: Attempt system shutdown twice in case PMIC is confused
      net: ks8851: Reinstate disabling of BHs around IRQ handler
      net: ks8851: Avoid excess softirq scheduling

Max Kellermann (1):
      ceph: only d_add() negative dentries when they are unhashed

Michael Bommarito (2):
      um: drivers: call kernel_strrchr() explicitly in cow_user.c
      smb: client: validate the whole DACL before rewriting it in cifsacl

Michal Pecio (1):
      usb: xhci: Make usb_host_endpoint.hcpriv survive endpoint_disable()

Mickaël Salaün (1):
      selftests/landlock: Fix format warning for __u64 in net_test

Miguel Ojeda (2):
      kbuild: rust: allow `clippy::uninlined_format_args`
      rust: init: fix `clippy::undocumented_unsafe_blocks` warnings

Ming Qian (1):
      media: amphion: Fix race between m2m job_abort and device_run

Naman Jain (1):
      block: relax pgmap check in bio_add_page for compatible zone device pages

Namjae Jeon (2):
      ksmbd: use msleep instaed of schedule_timeout_interruptible()
      ksmbd: replace connection list with hash table

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

Prasanna Kumar T S M (1):
      vfio/cdx: Fix NULL pointer dereference in interrupt trigger path

Qiang Yu (1):
      bus: mhi: host: pci_generic: Switch to async power up to avoid boot delays

Rafael J. Wysocki (1):
      thermal: core: Fix thermal zone governor cleanup issues

Raphael Zimmer (1):
      libceph: Prevent potential null-ptr-deref in ceph_handle_auth_reply()

Robert Beckett (2):
      nvme-pci: add NVME_QUIRK_DISABLE_WRITE_ZEROES for Kingston OM3SGP4
      nvme: respect NVME_QUIRK_DISABLE_WRITE_ZEROES when wzsl is set

Robert Marko (1):
      arm64: dts: marvell: uDPU: add ethernet aliases

Rong Bao (1):
      perf annotate: Use jump__delete when freeing LoongArch jumps

Rong Zhang (1):
      Revert "ALSA: usb: Increase volume range that triggers a warning"

Ruide Cao (1):
      ipv4: icmp: validate reply type before using icmp_pointers

Ruijie Li (1):
      net/smc: avoid early lgr access in smc_clc_wait_msg

Ryan Roberts (1):
      randomize_kstack: Maintain kstack_offset per task

Sanjaikumar V S (1):
      mtd: spi-nor: sst: Fix write enable before AAI sequence

Sanman Pradhan (2):
      hwmon: (powerz) Fix missing usb_kill_urb() on signal interrupt
      hwmon: (pt5161l) Fix bugs in pt5161l_read_block_data()

Sean Christopherson (3):
      KVM: x86: Defer non-architectural deliver of exception payload to userspace read
      KVM: SVM: Explicitly mark vmcb01 dirty after modifying VMCB intercepts
      KVM: nSVM: Always intercept VMMCALL when L2 is active

Sean Wang (2):
      wifi: mt76: mt792x: describe USB WFSYS reset with a descriptor
      wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling

SeongJae Park (1):
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

Steven Rostedt (1):
      ktest: Fix the month in the name of the failure directory

Takashi Iwai (6):
      ALSA: usb-audio: Evaluate packsize caps at the right place
      ALSA: core: Fix potential data race at fasync handling
      ALSA: caiaq: Handle probe errors properly
      ALSA: aoa: Use guard() for mutex locks
      ALSA: caiaq: Fix potentially leftover ep1_in_urb at error path
      ALSA: caiaq: Don't abort when no input device is available

Thomas Fourier (1):
      crypto: hisilicon - Fix dma_unmap_single() direction

Thomas Zimmermann (2):
      firmware: google: framebuffer: Do not mark framebuffer as busy
      firmware: google: framebuffer: Do not unregister platform device

Thorsten Blum (8):
      crypto: atmel-sha204a - Fix OTP sysfs read and error handling
      crypto: atmel-aes - Fix 3-page memory leak in atmel_aes_buff_cleanup
      crypto: atmel-ecc - Release client on allocation failure
      crypto: atmel-tdes - fix DMA sync direction
      crypto: atmel-sha204a - Fix error codes in OTP reads
      crypto: atmel-sha204a - Fix potential UAF and memory leak in remove path
      crypto: atmel-sha204a - Fix uninitialized data access on OTP read error
      ALSA: aoa: Skip devices with no codecs in i2sbus_resume()

Tobias Gaertner (2):
      ntfs3: add buffer boundary checks to run_unpack()
      ntfs3: fix integer overflow in run_unpack() volume boundary check

Tvrtko Ursulin (1):
      drm/amdgpu: Use vmemdup_array_user in amdgpu_bo_create_list_entry_array

Tyllis Xu (3):
      misc: ibmasm: fix OOB MMIO read in ibmasm_handle_mouse_interrupt()
      ibmasm: fix OOB reads in command_file_write due to missing size checks
      ibmasm: fix heap over-read in ibmasm_send_i2o_message()

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

Xiang Mei (1):
      net: bonding: fix use-after-free in bond_xmit_broadcast()

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

Yongpeng Yang (1):
      f2fs: fix UAF caused by decrementing sbi->nr_pages[] in f2fs_write_end_io()

Yosry Ahmed (11):
      KVM: nSVM: Mark all of vmcb02 dirty when restoring nested state
      KVM: nSVM: Sync NextRIP to cached vmcb12 after VMRUN of L2
      KVM: nSVM: Sync interrupt shadow to cached vmcb12 after VMRUN of L2
      KVM: nSVM: Ensure AVIC is inhibited when restoring a vCPU to guest mode
      KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on nested #VMEXIT
      KVM: nSVM: Always inject a #GP if mapping VMCB12 fails on nested VMRUN
      KVM: nSVM: Clear GIF on nested #VMEXIT(INVALID)
      KVM: nSVM: Clear EVENTINJ fields in vmcb12 on nested #VMEXIT
      KVM: nSVM: Clear tracking of L1->L2 NMI and soft IRQ on nested #VMEXIT
      KVM: nSVM: Add missing consistency check for EFER, CR0, CR4, and CS
      KVM: nSVM: Add missing consistency check for nCR3 validity

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



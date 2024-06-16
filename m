Return-Path: <stable+bounces-52310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081EA909D44
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 14:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34565B210EE
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D0A188CC5;
	Sun, 16 Jun 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nnEVzdje"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E0187565;
	Sun, 16 Jun 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718539441; cv=none; b=TLAfxvYDDrlUeJ18n4iCQx4KgGx0Lbkn5mUzl1j+daDGImG1aPm8TDg5JKSuvRy8CHUuA0AzVoSqg4aP7LRA88uujN4ubGs20i2FKHotL4qWWPAUsWU9QouSdq2zva/x++RRsr8JKFld0uKdOuP2SN+othg1By5c6fVoMpij8CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718539441; c=relaxed/simple;
	bh=/F4y0fBpH+x8+1a8CvJfkgBI5+eEsjs5l9OxWzHJ5zY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AcHkOZQgRJu9/gFz31AQOe/ZFNygBM7nioIy0h0NQgkdzLKv0DQxqhM9JEGYLN5b6uaI7mKLWDk9mFMvAEs+rPE9mwxXMG5NZdK8UVPDKkK+Mm72qhSWSStsO18miTCAfxafBW+jDSIK7M5IECw3lYnnvdliEsdpEv9QwdUjK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nnEVzdje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA9FC2BD10;
	Sun, 16 Jun 2024 12:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718539440;
	bh=/F4y0fBpH+x8+1a8CvJfkgBI5+eEsjs5l9OxWzHJ5zY=;
	h=From:To:Cc:Subject:Date:From;
	b=nnEVzdje27NFrIwweEXAgndojgVhMBZHonvss28iZegYPeMwmoAFPhZ+Dp5/brtsJ
	 p1nnXBU9JfvKrEI0i+Il8lVHdQFlsEDJWWY6MVtDiocTp4welKocbFGbeV6/bL4rM3
	 mhd4361lsTAgnLL/9wv6qVTreQABxFZsIv5ejPKo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.278
Date: Sun, 16 Jun 2024 14:03:52 +0200
Message-ID: <2024061653-rockband-blah-deb9@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.278 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/sound/rt5645.txt     |    6 
 Makefile                                               |    2 
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi         |    2 
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts         |    4 
 arch/arm64/boot/dts/nvidia/tegra132.dtsi               |    2 
 arch/arm64/include/asm/asm-bug.h                       |    1 
 arch/arm64/kvm/guest.c                                 |    1 
 arch/m68k/kernel/entry.S                               |    4 
 arch/m68k/mac/misc.c                                   |   36 +--
 arch/microblaze/kernel/Makefile                        |    1 
 arch/microblaze/kernel/cpu/cpuinfo-static.c            |    2 
 arch/parisc/kernel/parisc_ksyms.c                      |    1 
 arch/powerpc/include/asm/hvcall.h                      |    2 
 arch/powerpc/platforms/pseries/lpar.c                  |    6 
 arch/powerpc/platforms/pseries/lparcfg.c               |    6 
 arch/powerpc/sysdev/fsl_msi.c                          |    2 
 arch/sh/kernel/kprobes.c                               |    7 
 arch/sh/lib/checksum.S                                 |   67 +------
 arch/sparc/include/asm/smp_64.h                        |    2 
 arch/sparc/include/uapi/asm/termbits.h                 |   10 -
 arch/sparc/include/uapi/asm/termios.h                  |    9 
 arch/sparc/kernel/prom_64.c                            |    4 
 arch/sparc/kernel/setup_64.c                           |    1 
 arch/sparc/kernel/smp_64.c                             |   14 -
 arch/um/drivers/line.c                                 |   14 -
 arch/um/drivers/ubd_kern.c                             |    4 
 arch/um/include/asm/mmu.h                              |    2 
 arch/um/include/shared/skas/mm_id.h                    |    2 
 arch/x86/Kconfig.debug                                 |    5 
 arch/x86/entry/vsyscall/vsyscall_64.c                  |   28 ---
 arch/x86/include/asm/processor.h                       |    1 
 arch/x86/kernel/apic/vector.c                          |    9 
 arch/x86/kernel/tsc_sync.c                             |    6 
 arch/x86/lib/x86-opcode-map.txt                        |    2 
 arch/x86/mm/fault.c                                    |   27 --
 arch/x86/purgatory/Makefile                            |    3 
 arch/x86/tools/relocs.c                                |    9 
 crypto/ecrdsa.c                                        |    1 
 drivers/acpi/acpica/Makefile                           |    1 
 drivers/acpi/resource.c                                |   12 +
 drivers/android/binder.c                               |    4 
 drivers/ata/pata_legacy.c                              |    8 
 drivers/block/null_blk_main.c                          |    3 
 drivers/char/ppdev.c                                   |   21 +-
 drivers/cpufreq/cpufreq.c                              |   83 +++++---
 drivers/crypto/bcm/spu2.c                              |    2 
 drivers/crypto/ccp/sp-platform.c                       |   14 -
 drivers/crypto/qat/qat_common/adf_aer.c                |   19 --
 drivers/dma-buf/sync_debug.c                           |    4 
 drivers/dma/idma64.c                                   |    4 
 drivers/extcon/Kconfig                                 |    3 
 drivers/firmware/dmi-id.c                              |    7 
 drivers/firmware/raspberrypi.c                         |    7 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                 |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c               |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |    1 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |    5 
 drivers/gpu/drm/arm/malidp_mw.c                        |    5 
 drivers/gpu/drm/mediatek/mtk_drm_gem.c                 |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |    3 
 drivers/gpu/drm/panel/panel-simple.c                   |    3 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                |    5 
 drivers/hwtracing/intel_th/pci.c                       |    5 
 drivers/hwtracing/stm/core.c                           |   11 -
 drivers/iio/pressure/dps310.c                          |   11 -
 drivers/infiniband/hw/hns/hns_roce_hem.h               |   12 -
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c              |    8 
 drivers/input/misc/ims-pcu.c                           |    4 
 drivers/input/misc/pm8xxx-vibrator.c                   |    7 
 drivers/irqchip/irq-alpine-msi.c                       |    2 
 drivers/macintosh/via-macii.c                          |   11 -
 drivers/md/md-bitmap.c                                 |    6 
 drivers/md/raid5.c                                     |   15 -
 drivers/media/cec/cec-adap.c                           |    3 
 drivers/media/cec/cec-api.c                            |    3 
 drivers/media/dvb-frontends/lgdt3306a.c                |    5 
 drivers/media/dvb-frontends/mxl5xx.c                   |   22 +-
 drivers/media/mc/mc-devnode.c                          |    5 
 drivers/media/pci/ngene/ngene-core.c                   |    4 
 drivers/media/radio/radio-shark2.c                     |    2 
 drivers/media/usb/stk1160/stk1160-video.c              |   20 +-
 drivers/media/v4l2-core/v4l2-dev.c                     |    3 
 drivers/mmc/core/host.c                                |    3 
 drivers/mtd/nand/raw/nand_hynix.c                      |    2 
 drivers/net/ethernet/cisco/enic/enic_main.c            |   12 +
 drivers/net/ethernet/cortina/gemini.c                  |   12 +
 drivers/net/ethernet/freescale/fec_main.c              |   10 +
 drivers/net/ethernet/freescale/fec_ptp.c               |   14 -
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c      |    2 
 drivers/net/ethernet/qlogic/qed/qed_main.c             |    9 
 drivers/net/ethernet/smsc/smc91x.h                     |    4 
 drivers/net/ipvlan/ipvlan_core.c                       |    4 
 drivers/net/usb/aqc111.c                               |    8 
 drivers/net/usb/qmi_wwan.c                             |    3 
 drivers/net/usb/smsc95xx.c                             |  122 ++++++-------
 drivers/net/usb/sr9700.c                               |   10 -
 drivers/net/vxlan.c                                    |    4 
 drivers/net/wireless/ath/ar5523/ar5523.c               |   14 +
 drivers/net/wireless/ath/ath10k/core.c                 |    3 
 drivers/net/wireless/ath/ath10k/debugfs_sta.c          |    2 
 drivers/net/wireless/ath/ath10k/hw.h                   |    1 
 drivers/net/wireless/ath/ath10k/targaddrs.h            |    3 
 drivers/net/wireless/ath/ath10k/wmi.c                  |   26 ++
 drivers/net/wireless/ath/carl9170/usb.c                |   32 +++
 drivers/net/wireless/marvell/mwl8k.c                   |    2 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   26 +-
 drivers/nvme/host/multipath.c                          |    3 
 drivers/nvme/target/configfs.c                         |    8 
 drivers/platform/x86/xiaomi-wmi.c                      |    4 
 drivers/s390/cio/trace.h                               |    2 
 drivers/s390/crypto/ap_bus.c                           |    2 
 drivers/scsi/bfa/bfad_debugfs.c                        |    4 
 drivers/scsi/hpsa.c                                    |    2 
 drivers/scsi/libsas/sas_expander.c                     |    3 
 drivers/scsi/qedf/qedf_debugfs.c                       |    2 
 drivers/scsi/qla2xxx/qla_init.c                        |    8 
 drivers/scsi/qla2xxx/qla_mr.c                          |   20 +-
 drivers/scsi/ufs/cdns-pltfrm.c                         |    2 
 drivers/scsi/ufs/ufs-qcom.h                            |   12 -
 drivers/scsi/ufs/ufshcd.c                              |    4 
 drivers/soundwire/cadence_master.c                     |  158 +++--------------
 drivers/soundwire/cadence_master.h                     |   34 ---
 drivers/soundwire/intel.c                              |  132 ++------------
 drivers/spi/spi-stm32.c                                |    2 
 drivers/spi/spi.c                                      |    4 
 drivers/staging/greybus/arche-apb-ctrl.c               |    1 
 drivers/staging/greybus/arche-platform.c               |    9 
 drivers/staging/greybus/light.c                        |    8 
 drivers/staging/speakup/main.c                         |    2 
 drivers/tty/n_gsm.c                                    |    8 
 drivers/tty/serial/max3100.c                           |   22 ++
 drivers/tty/serial/sh-sci.c                            |    5 
 drivers/usb/gadget/function/u_audio.c                  |    2 
 drivers/video/fbdev/Kconfig                            |    4 
 drivers/video/fbdev/savage/savagefb_driver.c           |    5 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                 |    2 
 drivers/video/fbdev/sis/init301.c                      |    3 
 drivers/virtio/virtio_pci_common.c                     |    4 
 fs/afs/mntpt.c                                         |    5 
 fs/ecryptfs/keystore.c                                 |    4 
 fs/ext4/namei.c                                        |    2 
 fs/ext4/xattr.c                                        |    4 
 fs/f2fs/inode.c                                        |    6 
 fs/f2fs/node.c                                         |    2 
 fs/io_uring.c                                          |    2 
 fs/jffs2/xattr.c                                       |    3 
 fs/nfs/internal.h                                      |    4 
 fs/nilfs2/ioctl.c                                      |    2 
 fs/nilfs2/segment.c                                    |   63 +++++-
 fs/openpromfs/inode.c                                  |    8 
 include/linux/moduleparam.h                            |    2 
 include/net/dst_ops.h                                  |    2 
 include/net/sock.h                                     |   13 -
 include/trace/events/asoc.h                            |    2 
 kernel/cgroup/cpuset.c                                 |    2 
 kernel/debug/kdb/kdb_io.c                              |   99 ++++++----
 kernel/irq/cpuhotplug.c                                |   16 -
 kernel/params.c                                        |   18 +
 kernel/sched/topology.c                                |    9 
 kernel/trace/ring_buffer.c                             |    9 
 net/9p/client.c                                        |    2 
 net/ipv4/netfilter/nf_tproxy_ipv4.c                    |    2 
 net/ipv4/route.c                                       |   22 --
 net/ipv4/tcp_dctcp.c                                   |   13 +
 net/ipv4/tcp_ipv4.c                                    |   14 +
 net/ipv6/route.c                                       |   34 ++-
 net/ipv6/seg6.c                                        |    5 
 net/ipv6/seg6_hmac.c                                   |   42 +++-
 net/netfilter/nfnetlink_queue.c                        |    2 
 net/netrom/nr_route.c                                  |   19 --
 net/nfc/nci/core.c                                     |   17 +
 net/openvswitch/actions.c                              |    6 
 net/openvswitch/flow.c                                 |    3 
 net/packet/af_packet.c                                 |    3 
 net/sunrpc/auth_gss/svcauth_gss.c                      |   12 -
 net/sunrpc/clnt.c                                      |    1 
 net/sunrpc/svc.c                                       |    2 
 net/sunrpc/xprtsock.c                                  |   18 -
 net/unix/af_unix.c                                     |    2 
 net/wireless/trace.h                                   |    4 
 net/xdp/xsk.c                                          |    2 
 net/xfrm/xfrm_policy.c                                 |   11 -
 scripts/kconfig/symbol.c                               |    6 
 sound/core/timer.c                                     |   10 +
 sound/soc/codecs/da7219-aad.c                          |    6 
 sound/soc/codecs/rt5645.c                              |   25 ++
 tools/arch/x86/lib/x86-opcode-map.txt                  |    2 
 tools/lib/subcmd/parse-options.c                       |    8 
 tools/testing/selftests/kcmp/kcmp_test.c               |    8 
 189 files changed, 1094 insertions(+), 985 deletions(-)

Aaron Conole (1):
      openvswitch: Set the skbuff pkt_type for proper pmtud support.

Adrian Hunter (1):
      x86/insn: Fix PUSH instruction in x86 instruction decoder opcode map

Al Viro (1):
      parisc: add missing export of __cmpxchg_u8()

Aleksandr Aprelkov (1):
      sunrpc: removed redundant procp check

Aleksandr Burakov (1):
      media: ngene: Add dvb_ca_en50221_init return value check

Aleksandr Mishin (1):
      crypto: bcm - Fix pointer arithmetic

Alexander Shishkin (1):
      intel_th: pci: Add Meteor Lake-S CPU support

Andre Edich (2):
      smsc95xx: remove redundant function arguments
      smsc95xx: use usbnet->driver_priv

Andrew Halaney (4):
      scsi: ufs: qcom: Perform read back after writing reset bit
      scsi: ufs: cdns-pltfrm: Perform read back after writing HCLKDIV
      scsi: ufs: core: Perform read back after disabling interrupts
      scsi: ufs: core: Perform read back after disabling UIC_COMMAND_COMPL

Andy Shevchenko (4):
      serial: max3100: Lock port->lock when calling uart_handle_cts_change()
      serial: max3100: Update uart_driver_registered on driver removal
      serial: max3100: Fix bitwise types
      spi: Don't mark message DMA mapped when no transfer in it is

Ard Biesheuvel (1):
      x86/purgatory: Switch to the position-independent small code model

Arnd Bergmann (10):
      nilfs2: fix out-of-range warning
      crypto: ccp - drop platform ifdef checks
      qed: avoid truncating work queue length
      ACPI: disable -Wstringop-truncation
      fbdev: shmobile: fix snprintf truncation
      powerpc/fsl-soc: hide unused const variable
      fbdev: sisfb: hide unused variables
      firmware: dmi-id: add a release callback function
      greybus: arche-ctrl: move device table to its right location
      Input: ims-pcu - fix printf string overflow

Azeem Shaikh (1):
      scsi: qla2xxx: Replace all non-returning strlcpy() with strscpy()

Baochen Qiang (1):
      wifi: ath10k: poll service ready message before failing

Baokun Li (1):
      ext4: fix mb_cache_entry's e_refcnt leak in ext4_xattr_block_cache_find()

Bard Liao (1):
      soundwire: cadence_master: improve PDI allocation

Bitterblue Smith (1):
      wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU

Bob Zhou (1):
      drm/amdgpu: add error handle to avoid out-of-bounds

Breno Leitao (1):
      af_unix: Fix data races in unix_release_sock/unix_stream_sendmsg

Brian Kubisiak (1):
      ecryptfs: Fix buffer size for tag 66 packet

Bui Quang Minh (2):
      scsi: bfa: Ensure the copied buf is NUL terminated
      scsi: qedf: Ensure the copied buf is NUL terminated

Cai Xinchen (1):
      fbdev: savage: Handle err return when savagefb_check_var failed

Carlos Llamas (1):
      binder: fix max_thread type inconsistency

Carolina Jubran (1):
      net/mlx5e: Use rx_missed_errors instead of rx_dropped for reporting buffer exhaustion

Chao Yu (2):
      f2fs: fix to release node block count in error path of f2fs_new_node_page()
      f2fs: fix to do sanity check on i_xattr_nid in sanity_check_inode()

Chen Ni (2):
      HID: intel-ish-hid: ipc: Add check for pci_alloc_irq_vectors
      dmaengine: idma64: Add check for dma_set_max_seg_size

Chengchang Tang (1):
      RDMA/hns: Use complete parentheses in macros

Chris Wulff (1):
      usb: gadget: u_audio: Clear uac pointer when freed.

Christoffer Sandberg (1):
      ACPI: resource: Do IRQ override on TongFang GXxHRXx and GMxHGxx

Christophe JAILLET (1):
      ppdev: Remove usage of the deprecated ida_simple_xx() API

Chuck Lever (2):
      SUNRPC: Fix gss_free_in_token_pages()
      SUNRPC: Fix loop termination condition in gss_free_in_token_pages()

Dan Aloni (1):
      sunrpc: fix NFSACL RPC retry on soft mount

Dan Carpenter (4):
      speakup: Fix sizeof() vs ARRAY_SIZE() bug
      wifi: mwl8k: initialize cmd->addr[] properly
      stm class: Fix a double free in stm_register_device()
      media: stk1160: fix bounds checking in stk1160_copy_video()

Daniel Borkmann (1):
      vxlan: Fix regression when dropping packets due to invalid src addresses

Daniel J Blueman (1):
      x86/tsc: Trust initial offset in architectural TSC-adjust MSRs

Daniel Starke (1):
      tty: n_gsm: fix possible out-of-bounds in gsm0_receive()

Daniel Thompson (5):
      kdb: Fix buffer overflow during tab-complete
      kdb: Use format-strings rather than '\0' injection in kdb_read()
      kdb: Fix console handling when editing and tab-completing commands
      kdb: Merge identical case statements in kdb_read()
      kdb: Use format-specifiers rather than memset() for padding in kdb_read()

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FN920C04 compositions

Derek Fang (2):
      ASoC: rt5645: Fix the electric noise due to the CBJ contacts floating
      ASoC: dt-bindings: rt5645: add cbj sleeve gpio property

Dmitry Baryshkov (1):
      wifi: ath10k: populate board data for WCN3990

Dongli Zhang (1):
      genirq/cpuhotplug, x86/vector: Prevent vector leak during CPU offline

Duoming Zhou (1):
      um: Fix return value in ubd_init()

Edward Liaw (1):
      selftests/kcmp: remove unused open mode

Eric Dumazet (10):
      tcp: minor optimization in tcp_add_backlog()
      tcp: avoid premature drops in tcp_add_backlog()
      usb: aqc111: stop lying about skb->truesize
      net: usb: sr9700: stop lying about skb->truesize
      net: usb: smsc95xx: stop lying about skb->truesize
      netrom: fix possible dead-lock in nr_rt_ioctl()
      af_packet: do not call packet_read_pending() from tpacket_destruct_skb()
      netfilter: nfnetlink_queue: acquire rcu_read_lock() in instance_destroy_rcu()
      net: fix __dst_negative_advice() race
      xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING

Eric Sandeen (1):
      openpromfs: finish conversion to the new mount API

Fenglin Wu (1):
      Input: pm8xxx-vibrator - correct VIB_MAX_LEVELS calculation

Finn Thain (2):
      macintosh/via-macii: Fix "BUG: sleeping function called from invalid context"
      m68k: mac: Fix reboot hang on Mac IIci

Florian Westphal (1):
      netfilter: tproxy: bail out if IP has been disabled on the device

Gautam Menghani (1):
      selftests/kcmp: Make the test output consistent and clear

Geert Uytterhoeven (1):
      sh: kprobes: Merge arch_copy_kprobe() into arch_prepare_kprobe()

Greg Kroah-Hartman (1):
      Linux 5.4.278

Guenter Roeck (1):
      Revert "sh: Handle calling csum_partial with misaligned data"

Guixiong Wei (1):
      x86/boot: Ignore relocations in .notes sections in walk_relocs() too

Hangbin Liu (4):
      ipv6: sr: add missing seg6_local_exit
      ipv6: sr: fix incorrect unregister order
      ipv6: sr: fix invalid unregister error path
      ipv6: sr: fix memleak in seg6_hmac_init_algo

Hans Verkuil (4):
      media: cec: cec-adap: always cancel work in cec_transmit_msg_fh
      media: cec: cec-api: add locking in cec_release()
      media: mc: mark the media devnode as registered from the, start
      media: v4l2-core: hold videodev_lock until dev reg, finishes

Harald Freudenberger (1):
      s390/ap: Fix crash in AP internal function modify_bitmap()

Herbert Xu (1):
      crypto: qat - Fix ADF_DEV_RESET_SYNC memory leak

Huai-Yuan Liu (2):
      drm/arm/malidp: fix a possible null pointer dereference
      ppdev: Add an error check in register_device

Ian Rogers (1):
      libsubcmd: Fix parse-options memory leak

Igor Artemiev (1):
      wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class

Ilya Denisyev (1):
      jffs2: prevent xattr node from overflowing the eraseblock

Ilya Maximets (1):
      net: openvswitch: fix overwriting ct original tuple for ICMPv6

Jan Kara (1):
      ext4: avoid excessive credit estimate in ext4_tmpfile()

Jiangfeng Xiao (1):
      arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY

Jiri Pirko (1):
      virtio: delete vq in vp_find_vqs_msix() when request_irq() fails

Jorge Ramirez-Ortiz (1):
      mmc: core: Do not force a retune before RPMB switch

Joshua Ashton (1):
      drm/amd/display: Set color_mgmt_changed to true on unsuspend

Justin Green (1):
      drm/mediatek: Add 0 size check to mtk_drm_gem_obj

Krzysztof Kozlowski (1):
      arm64: tegra: Correct Tegra132 I2C alias

Kuniyuki Iwashima (1):
      tcp: Fix shift-out-of-bounds in dctcp_update_alpha().

Lancelot SIX (1):
      drm/amdkfd: Flush the process wq before creating a kfd_process

Laurent Pinchart (1):
      firmware: raspberrypi: Use correct device for DMA mappings

Leon Romanovsky (1):
      RDMA/IPoIB: Fix format truncation compilation errors

Linus Torvalds (1):
      x86/mm: Remove broken vsyscall emulation code from the page fault code

Linus Walleij (1):
      net: ethernet: cortina: Locking fixes

Lu Wei (1):
      tcp: fix a signed-integer-overflow bug in tcp_add_backlog()

Marc Dionne (1):
      afs: Don't cross .backup mountpoint from backup volume

Marc Zyngier (1):
      KVM: arm64: Allow AArch32 PSTATE.M to be restored as System mode

Marek Vasut (1):
      drm/panel: simple: Add missing Innolux G121X1-L03 format, flags, connector

Marijn Suijten (1):
      drm/msm/dpu: Always flush the slave INTF on the CTL

Masahiro Yamada (2):
      x86/kconfig: Select ARCH_WANT_FRAME_POINTERS again when UNWINDER_FRAME_POINTER=y
      kconfig: fix comparison to constant symbols, 'm', 'n'

Maxim Korotkov (1):
      mtd: rawnand: hynix: fixed typo

Michael Schmitz (1):
      m68k: Fix spinlock race in kernel thread creation

Michal Simek (2):
      microblaze: Remove gcc flag for non existing early_printk.c file
      microblaze: Remove early printk call from cpuinfo-static.c

Mike Gilbert (1):
      sparc: move struct termio to asm/termios.h

Ming Lei (1):
      io_uring: fail NOP if non-zero op flags is passed in

Nathan Chancellor (1):
      media: mxl5xx: Move xpt structures off stack

Nikita Zhandarovich (3):
      wifi: carl9170: add a proper sanity check for endpoints
      wifi: ar5523: enable proper endpoint verification
      net/9p: fix uninit-value in p9_client_rpc()

Nilay Shroff (1):
      nvme: find numa distance only if controller has valid numa id

Parthiban Veerasooran (1):
      net: usb: smsc95xx: fix changing LED_SEL bit value updated from EEPROM

Peter Oberparleiter (1):
      s390/cio: fix tracepoint subchannel type field

Petr Pavlu (1):
      ring-buffer: Fix a race between readers and resize checks

Pierre-Louis Bossart (4):
      ASoC: da7219-aad: fix usage of device_get_named_child_node()
      soundwire: cadence/intel: simplify PDI/port mapping
      soundwire: intel: don't filter out PDI0/1
      soundwire: cadence: fix invalid PDI offset

Rafael J. Wysocki (3):
      cpufreq: Reorganize checks in cpufreq_offline()
      cpufreq: Split cpufreq_offline()
      cpufreq: Rearrange locking in cpufreq_remove_dev()

Randy Dunlap (2):
      fbdev: sh7760fb: allow modular build
      extcon: max8997: select IRQ_DOMAIN instead of depending on it

Ricardo Ribalda (1):
      media: radio-shark2: Avoid led_names truncations

Roberto Sassu (1):
      um: Add winch to winch_handlers before registering winch IRQ

Roded Zats (1):
      enic: Validate length of nl attributes in enic_set_vf_port

Rui Miguel Silva (1):
      greybus: lights: check return of get_channel_from_mode

Ryosuke Yasuoka (2):
      nfc: nci: Fix uninit-value in nci_rx_work
      nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()

Ryusuke Konishi (3):
      nilfs2: fix unexpected freezing of nilfs_segctor_sync()
      nilfs2: fix potential hang in nilfs_detach_log_writer()
      nilfs2: fix use-after-free of timer for log writer thread

Sagi Grimberg (2):
      params: lift param_set_uint_minmax to common code
      nvmet: fix ns enable/disable possible hang

Sam Ravnborg (1):
      sparc64: Fix number of online CPUs

Sergey Shtylyov (2):
      ata: pata_legacy: make legacy_exit() work again
      nfs: fix undefined behavior in nfs_block_bits()

Shrikanth Hegde (1):
      powerpc/pseries: Add failure related checks for h_get_mpp and h_get_ppp

Srinivasan Shanmugam (1):
      drm/amd/display: Fix potential index out of bounds in color transformation function

Steven Rostedt (1):
      ASoC: tracing: Export SND_SOC_DAPM_DIR_OUT to its value

Su Hui (1):
      wifi: ath10k: Fix an error code problem in ath10k_dbg_sta_write_peer_debug_trigger()

Takashi Iwai (1):
      ALSA: timer: Set lower bound of start tick time

Tetsuo Handa (2):
      nfc: nci: Fix kcov check in nci_rx_work()
      dma-buf/sw-sync: don't enable IRQ from sync_print_obj()

Thomas Haemmerle (1):
      iio: pressure: dps310: support negative temperature values

Thorsten Blum (1):
      net: smc91x: Fix m68k kernel compilation for ColdFire CPU

Tiwei Bie (1):
      um: Fix the -Wmissing-prototypes warning for __switch_mm

Uwe Kleine-König (1):
      spi: stm32: Don't warn about spurious interrupts

Valentin Schneider (1):
      sched/topology: Don't set SD_BALANCE_WAKE on cpuset domain relax

Viresh Kumar (1):
      cpufreq: exit() callback is optional

Vitalii Bursov (1):
      sched/fair: Allow disabling sched_balance_newidle with sched_relax_domain_level

Vitaly Chikunov (1):
      crypto: ecrdsa - Fix module auto-load on add_key

Wei Fang (1):
      net: fec: avoid lock evasion when reading pps_enable

Wolfram Sang (1):
      serial: sh-sci: protect invalidating RXDMA on shutdown

Xiaolei Wang (1):
      net:fec: Add fec_enet_deinit()

Xingui Yang (1):
      scsi: libsas: Fix the failure of adding phy with zero-address to port

Yang Xiwen (1):
      arm64: dts: hi3798cv200: fix the size of GICR

Yu Kuai (2):
      md: fix resync softlockup when bitmap size is less than array size
      md/raid5: fix deadlock that raid5d() wait for itself to clear MD_SB_CHANGE_PENDING

Yue Haibing (1):
      ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound

YueHaibing (1):
      platform/x86: wmi: Make two functions static

Yuri Karpov (1):
      scsi: hpsa: Fix allocation size for Scsi_Host private data

Zenghui Yu (1):
      irqchip/alpine-msi: Fix off-by-one in allocation error path

Zheyu Ma (1):
      media: lgdt3306a: Add a check against null-pointer-def

Zhu Yanjun (2):
      null_blk: Fix missing mutex_destroy() at module removal
      null_blk: Fix the WARNING: modpost: missing MODULE_DESCRIPTION()

xu xin (1):
      net/ipv6: Fix route deleting failure when metric equals 0



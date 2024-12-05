Return-Path: <stable+bounces-98789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712519E542F
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D32E2835AD
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B3420ADD2;
	Thu,  5 Dec 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/SKhYx3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5C20A5EB;
	Thu,  5 Dec 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398932; cv=none; b=KisUZrNftLP6PnHIPJppiyX/X3+/GGH1s7FtySVPc4QVvNyPLb1i8Ktqi4rxJ/yJx2JWnJVSxUZnShv6ytHR01mAWvTEb0z0BVKIlCLcqHBMqtfHPlKaTwQX8GTxX8o0LocjWH/p8qYuyKkuKg/yg9WQZUm8eG8zEEpaTUTq8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398932; c=relaxed/simple;
	bh=J2uPYy+L2A+U6N+731lSH+FQ1rahxFgvlyGWV+/AWqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dW42nXAgKza9XNviiSZAqzuAY/FZD3x7EhtNU/CtB4GoVRYWg1A1qm3IIkodvcMx+w68cnijhf9WIWFhucFTopn7pEhn+IZo8hZHmsbP1c3BRp74Rq3Kiu9ZvuxjRIaRyZJlR3pYsvZykrn+/NhbHg9EJQBqJsMNlgqshGfoszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/SKhYx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930B8C4CED1;
	Thu,  5 Dec 2024 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733398932;
	bh=J2uPYy+L2A+U6N+731lSH+FQ1rahxFgvlyGWV+/AWqg=;
	h=From:To:Cc:Subject:Date:From;
	b=T/SKhYx3zzrhmo25aSgK+mx1ISQ+n0aPO9qCk61AtKjgfv7UrzGGVoRWvuJSUvLN2
	 HDzkJpSBOJvxMDijz/eYfyuWvX7NYyG3pS1VaexJ39AlBNiAysiPEO08D32cVt0+5q
	 NLHAYYRHXXxSBZ6ff8yBFz+YcOvUSm0+MO0gRIJY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.325
Date: Thu,  5 Dec 2024 12:41:59 +0100
Message-ID: <2024120520-mashing-facing-6776@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.325 kernel.

It's the last 4.19.y release, please move off to a newer kernel version.
This one is finished, it is end-of-life as of right now.

It had a good life, despite being born out of internal strife.  The
community has proven that it can change and move forward which is great
to see, as again, the only thing that is going to stop Linux, is us, the
Linux community.  Let's always try to work together to make sure that
doesn't happen.

As a "fun" proof that this one is finished (and that any company saying
they care about it really should have their statements validated with
facts), I looked at the "unfixed" CVEs from this kernel release.
Currently it is a list 983 CVEs long, too long to list here.

You can verify it yourself by cloning the vulns.git repo at
git.kernel.org and running:
	./scripts/strak v4.19.325
Note, this does NOT count the hardware CVEs which kernel.org does not
track, and many are sill unfixed in this kernel branch.

Yes, CVE counts don't mean much these days, but hey, it's a signal of
something, right?  I take it to mean that no one is caring enough to
backport the needed fixes to this branch, which means that you shouldn't
be using it anymore.

Anyway, please move off to a more modern kernel if you were using this
one for some reason.  Like 6.12.y, the next LTS kernel we will be
supporting for multiple years.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml |   67 ++++
 Documentation/devicetree/bindings/clock/axi-clkgen.txt      |   25 -
 Makefile                                                    |    2 
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts                 |    4 
 arch/arm64/kernel/process.c                                 |    2 
 arch/m68k/coldfire/device.c                                 |    8 
 arch/m68k/include/asm/mcfgpio.h                             |    2 
 arch/m68k/include/asm/mvme147hw.h                           |    4 
 arch/m68k/kernel/early_printk.c                             |    9 
 arch/m68k/mvme147/config.c                                  |   30 ++
 arch/m68k/mvme147/mvme147.h                                 |    6 
 arch/m68k/mvme16x/config.c                                  |    2 
 arch/m68k/mvme16x/mvme16x.h                                 |    6 
 arch/powerpc/include/asm/sstep.h                            |    5 
 arch/powerpc/include/asm/vdso.h                             |    1 
 arch/powerpc/lib/sstep.c                                    |   12 
 arch/s390/kernel/syscalls/Makefile                          |    2 
 arch/sh/kernel/cpu/proc.c                                   |    2 
 arch/um/drivers/net_kern.c                                  |    2 
 arch/um/drivers/ubd_kern.c                                  |    2 
 arch/um/drivers/vector_kern.c                               |    3 
 arch/um/kernel/process.c                                    |    2 
 arch/x86/include/asm/amd_nb.h                               |    5 
 block/blk-mq.c                                              |    6 
 block/blk-mq.h                                              |   13 
 crypto/pcrypt.c                                             |   12 
 drivers/acpi/arm64/gtdt.c                                   |    2 
 drivers/base/regmap/regmap-irq.c                            |    4 
 drivers/clk/clk-axi-clkgen.c                                |   26 +
 drivers/cpufreq/loongson2_cpufreq.c                         |    4 
 drivers/crypto/bcm/cipher.c                                 |    5 
 drivers/crypto/cavium/cpt/cptpf_main.c                      |    6 
 drivers/edac/fsl_ddr_edac.c                                 |   22 -
 drivers/firmware/arm_scpi.c                                 |    3 
 drivers/gpu/drm/drm_mm.c                                    |    2 
 drivers/gpu/drm/etnaviv/etnaviv_drv.h                       |   11 
 drivers/gpu/drm/etnaviv/etnaviv_dump.c                      |   13 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                       |   48 ++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h                       |   20 +
 drivers/gpu/drm/omapdrm/omap_gem.c                          |   10 
 drivers/hid/wacom_wac.c                                     |    4 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                    |    7 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                    |    2 
 drivers/media/dvb-core/dvbdev.c                             |   15 -
 drivers/media/radio/wl128x/fmdrv_common.c                   |    3 
 drivers/message/fusion/mptsas.c                             |    4 
 drivers/mfd/da9052-spi.c                                    |    2 
 drivers/mfd/rt5033.c                                        |    4 
 drivers/misc/apds990x.c                                     |   12 
 drivers/mmc/host/dw_mmc.c                                   |    4 
 drivers/mmc/host/mmc_spi.c                                  |    9 
 drivers/mtd/nand/raw/atmel/pmecc.c                          |    8 
 drivers/mtd/nand/raw/atmel/pmecc.h                          |    2 
 drivers/mtd/ubi/attach.c                                    |   12 
 drivers/mtd/ubi/wl.c                                        |    9 
 drivers/net/ethernet/broadcom/tg3.c                         |    3 
 drivers/net/ethernet/marvell/pxa168_eth.c                   |   13 
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c         |    2 
 drivers/net/usb/lan78xx.c                                   |   11 
 drivers/net/usb/qmi_wwan.c                                  |    1 
 drivers/net/wireless/ath/ath9k/htc_hst.c                    |    3 
 drivers/net/wireless/marvell/mwifiex/fw.h                   |    2 
 drivers/nvme/host/core.c                                    |    7 
 drivers/pci/hotplug/cpqphp_pci.c                            |   19 -
 drivers/pci/slot.c                                          |    4 
 drivers/power/supply/power_supply_core.c                    |    2 
 drivers/rpmsg/qcom_glink_native.c                           |  175 ++++++++----
 drivers/rtc/interface.c                                     |    7 
 drivers/scsi/bfa/bfad.c                                     |    3 
 drivers/scsi/qedi/qedi_main.c                               |    1 
 drivers/sh/intc/core.c                                      |    2 
 drivers/soc/qcom/qcom-geni-se.c                             |    3 
 drivers/spi/spi.c                                           |   13 
 drivers/tty/serial/8250/8250_omap.c                         |    4 
 drivers/tty/tty_ldisc.c                                     |    2 
 drivers/usb/dwc3/gadget.c                                   |    9 
 drivers/usb/gadget/composite.c                              |   18 +
 drivers/usb/host/ehci-spear.c                               |    7 
 drivers/usb/misc/chaoskey.c                                 |   35 +-
 drivers/usb/misc/iowarrior.c                                |   46 ++-
 drivers/vfio/pci/vfio_pci_config.c                          |   16 -
 drivers/video/fbdev/sh7760fb.c                              |   11 
 fs/ext4/fsmap.c                                             |   54 +++
 fs/ext4/mballoc.c                                           |   18 -
 fs/ext4/mballoc.h                                           |    1 
 fs/ext4/super.c                                             |    8 
 fs/hfsplus/hfsplus_fs.h                                     |    3 
 fs/hfsplus/wrapper.c                                        |    2 
 fs/jffs2/erase.c                                            |    7 
 fs/jfs/xattr.c                                              |    2 
 fs/nfs/nfs4proc.c                                           |    8 
 fs/nfsd/nfs4callback.c                                      |   16 -
 fs/nfsd/nfs4recover.c                                       |    3 
 fs/nilfs2/btnode.c                                          |    2 
 fs/nilfs2/gcinode.c                                         |    4 
 fs/nilfs2/mdt.c                                             |    1 
 fs/nilfs2/page.c                                            |    2 
 fs/ocfs2/aops.h                                             |    2 
 fs/ocfs2/file.c                                             |    4 
 fs/ocfs2/resize.c                                           |    2 
 fs/ocfs2/super.c                                            |   13 
 fs/proc/softirqs.c                                          |    2 
 fs/ubifs/super.c                                            |    6 
 include/linux/blkdev.h                                      |    2 
 include/linux/jiffies.h                                     |    2 
 include/linux/netpoll.h                                     |    2 
 init/initramfs.c                                            |   15 +
 kernel/time/time.c                                          |    2 
 kernel/trace/trace_event_perf.c                             |    6 
 lib/string_helpers.c                                        |    2 
 mm/shmem.c                                                  |    2 
 net/9p/trans_xen.c                                          |    9 
 net/bluetooth/rfcomm/sock.c                                 |   10 
 net/mac80211/main.c                                         |    2 
 net/netfilter/ipset/ip_set_bitmap_ip.c                      |    7 
 net/netlink/af_netlink.c                                    |   31 --
 net/netlink/af_netlink.h                                    |    2 
 net/rfkill/rfkill-gpio.c                                    |    8 
 samples/bpf/xdp_adjust_tail_kern.c                          |    1 
 scripts/mkcompile_h                                         |    2 
 scripts/mod/file2alias.c                                    |    5 
 security/apparmor/capability.c                              |    2 
 sound/soc/codecs/da7219.c                                   |    9 
 sound/soc/intel/boards/bytcr_rt5640.c                       |   15 +
 sound/usb/6fire/chip.c                                      |   10 
 sound/usb/caiaq/audio.c                                     |   10 
 sound/usb/caiaq/audio.h                                     |    1 
 sound/usb/caiaq/device.c                                    |   19 +
 sound/usb/caiaq/input.c                                     |   12 
 sound/usb/caiaq/input.h                                     |    1 
 sound/usb/quirks.c                                          |   18 -
 sound/usb/usx2y/us122l.c                                    |    5 
 tools/perf/util/probe-finder.c                              |   17 +
 tools/testing/selftests/vDSO/parse_vdso.c                   |    3 
 tools/testing/selftests/watchdog/watchdog-test.c            |    6 
 135 files changed, 898 insertions(+), 426 deletions(-)

Aleksandr Mishin (1):
      acpi/arm64: Adjust error handling procedure in gtdt_parse_timer_block()

Alex Zenla (2):
      9p/xen: fix init sequence
      9p/xen: fix release of IRQ

Alexandru Ardelean (2):
      dt-bindings: clock: adi,axi-clkgen: convert old binding to yaml format
      clk: axi-clkgen: use devm_platform_ioremap_resource() short-hand

Alper Nebi Yasak (1):
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_config_scan()

Andre Przywara (1):
      ARM: dts: cubieboard4: Fix DCDC5 regulator constraints

Andrej Shadura (1):
      Bluetooth: Fix type of len in rfcomm_sock_getsockopt{,_old}()

Andrew Morton (1):
      mm: revert "mm: shmem: fix data-race in shmem_getattr()"

Andy Shevchenko (2):
      regmap: irq: Set lockdep class for hierarchical IRQ domains
      drm/mm: Mark drm_mm_interval_tree*() functions with __maybe_unused

Antonio Quartulli (1):
      m68k: coldfire/device.c: only build FEC when HW macros are defined

Arnd Bergmann (1):
      x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB

Artem Sadovnikov (1):
      jfs: xattr: check invalid xattr size more strictly

Arun Kumar Neelakantam (2):
      rpmsg: glink: Add TX_DATA_CONT command while sending
      rpmsg: glink: Send READ_NOTIFY command in FIFO full case

Aurelien Jarno (1):
      Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K"

Avihai Horon (1):
      vfio/pci: Properly hide first-in-list PCIe extended capability

Bart Van Assche (1):
      power: supply: core: Remove might_sleep() from power_supply_put()

Bartosz Golaszewski (2):
      mmc: mmc_spi: drop buggy snprintf()
      lib: string_helpers: silence snprintf() output truncation warning

Ben Greear (1):
      mac80211: fix user-power when emulating chanctx

Benoît Monin (1):
      net: usb: qmi_wwan: add Quectel RG650V

Benoît Sevens (1):
      ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices

Bin Liu (1):
      serial: 8250: omap: Move pm_runtime_get_sync

Bjorn Andersson (2):
      rpmsg: glink: Fix GLINK command prefix
      rpmsg: glink: Propagate TX failures in intentless mode as well

Breno Leitao (1):
      netpoll: Use rcu_access_pointer() in netpoll_poll_lock

Chen Ridong (1):
      crypto: bcm - add error check in the ahash_hmac_init function

Chris Down (1):
      kbuild: Use uname for LINUX_COMPILE_HOST detection

Christoph Hellwig (1):
      block: return unsigned int from bdev_io_min

Christophe JAILLET (1):
      crypto: cavium - Fix an error handling path in cpt_ucode_load_fw()

Christophe Leroy (1):
      powerpc/vdso: Flag VDSO64 entry points as functions

Chuck Lever (3):
      NFSD: Prevent NULL dereference in nfsd4_process_cb_update()
      NFSD: Cap the number of bytes copied by nfs4_reset_recoverydir()
      NFSD: Prevent a potential integer overflow

Claudiu Beznea (1):
      serial: sh-sci: Clean sci_ports[0] after at earlycon exit

Dan Carpenter (2):
      soc: qcom: geni-se: fix array underflow in geni_se_clk_tbl_get()
      sh: intc: Fix use-after-free bug in register_intc_controller()

Daniel Palmer (2):
      m68k: mvme147: Fix SCSI controller IRQ numbers
      m68k: mvme147: Reinstate early console

David Disseldorp (1):
      initramfs: avoid filename buffer overrun

David Wang (1):
      proc/softirqs: replace seq_printf with seq_put_decimal_ull_width

Dmitry Antipov (3):
      ocfs2: uncache inode which has failed entering the group
      ocfs2: fix UBSAN warning in ocfs2_verify_volume()
      ocfs2: fix uninitialized value in ocfs2_file_read_iter()

Doug Brown (1):
      drm/etnaviv: fix power register offset on GC300

Edward Adam Davis (1):
      USB: chaoskey: Fix possible deadlock chaoskey_list_lock

Everest K.C (1):
      crypto: cavium - Fix the if condition to exit loop after timeout

Geert Uytterhoeven (1):
      m68k: mvme16x: Add and use "mvme16x.h"

Greg Kroah-Hartman (2):
      Revert "serial: sh-sci: Clean sci_ports[0] after at earlycon exit"
      Linux 4.19.325

Hans de Goede (1):
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet

Huacai Chen (1):
      sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Ilpo Järvinen (1):
      PCI: cpqphp: Fix PCIBIOS_* return value confusion

Jakub Kicinski (1):
      netlink: terminate outstanding dump on socket close

Jason Gerecke (1):
      HID: wacom: Interpret tilt data from Intuos Pro BT as signed values

Jean-Michel Hautbois (1):
      m68k: mcfgpio: Fix incorrect register offset for CONFIG_M5441x

Jeongjun Park (4):
      wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()
      usb: using mutex lock and supporting O_NONBLOCK flag in iowarrior_read()
      ext4: supress data-race warnings in ext4_free_inodes_{count,set}()
      netfilter: ipset: add missing range check in bitmap_ip_uadt

Jinjie Ruan (1):
      misc: apds990x: Fix missing pm_runtime_disable()

Jonathan Marek (1):
      rpmsg: glink: use only lower 16-bits of param2 for CMD_OPEN name length

Kashyap Desai (1):
      RDMA/bnxt_re: Check cqe flags to know imm_data vs inv_irkey

Leo Yan (1):
      perf probe: Correct demangled symbols in C++ program

Levi Yun (1):
      trace/trace_event_perf: remove duplicate samples on the first tracepoint event

Li Zhijian (1):
      selftests/watchdog-test: Fix system accidentally reset after watchdog-test

Lucas Stach (2):
      drm/etnaviv: consolidate hardware fence handling in etnaviv_gpu
      drm/etnaviv: hold GPU lock across perfmon sampling

Lukas Wunner (1):
      PCI: Fix use-after-free of slot->bus on hot remove

Luo Qiu (1):
      firmware: arm_scpi: Check the DVFS OPP count returned by the firmware

Marc Kleine-Budde (1):
      drm/etnaviv: dump: fix sparse warnings

Marcus Folkesson (1):
      mfd: da9052-spi: Change read-mask to write-mask

Masahiro Yamada (2):
      s390/syscalls: Avoid creation of arch/arch/ directory
      modpost: remove incorrect code in do_eisa_entry()

Mauro Carvalho Chehab (1):
      media: dvbdev: fix the logic when DVB_DYNAMIC_MINORS is not set

Maxime Chevallier (1):
      net: stmmac: dwmac-socfpga: Set RX watchdog interrupt as broken

Michal Suchanek (1):
      powerpc/sstep: make emulate_vsx_load and emulate_vsx_store static

Michal Vrastil (1):
      Revert "usb: gadget: composite: fix OS descriptors w_value logic"

Miguel Ojeda (1):
      time: Fix references to _msecs_to_jiffies() handling of values

Mingwei Zheng (1):
      net: rfkill: gpio: Add check for clk_enable()

Miquel Raynal (1):
      mtd: rawnand: atmel: Fix possible memory leak

Muchun Song (1):
      block: fix ordering between checking BLK_MQ_S_STOPPED request adding

Nicolas Bouchinet (1):
      tty: ldsic: fix tty_ldisc_autoload sysctl's proc_handler

Nuno Sa (2):
      dt-bindings: clock: axi-clkgen: include AXI clk
      clk: clk-axi-clkgen: make sure to enable the AXI bus clock

Oleksij Rempel (2):
      net: usb: lan78xx: Fix memory leak on device unplug by freeing PHY device
      net: usb: lan78xx: Fix refcounting and autosuspend on invalid WoL configuration

Oliver Neukum (1):
      USB: chaoskey: fail open after removal

Pavan Chebbi (1):
      tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets

Priyanka Singh (1):
      EDAC/fsl_ddr: Fix bad bit shift operations

Puranjay Mohan (1):
      nvme: fix metadata handling in nvme-passthrough

Qingfang Deng (1):
      jffs2: fix use of uninitialized variable

Qiu-ji Chen (2):
      ASoC: codecs: Fix atomicity violation in snd_soc_component_get_drvdata()
      media: wl128x: Fix atomicity violation in fmc_send_cmd()

Ryusuke Konishi (2):
      nilfs2: fix null-ptr-deref in block_touch_buffer tracepoint
      nilfs2: fix null-ptr-deref in block_dirty_buffer tracepoint

Stanislaw Gruszka (1):
      spi: Fix acpi deferred irq probe

Takashi Iwai (3):
      ALSA: us122l: Use snd_card_free_when_closed() at disconnection
      ALSA: caiaq: Use snd_card_free_when_closed() at disconnection
      ALSA: 6fire: Release resources at card release

Thadeu Lima de Souza Cascardo (1):
      hfsplus: don't query the device logical block size multiple times

Theodore Ts'o (1):
      ext4: fix FS_IOC_GETFSMAP handling

Thinh Nguyen (1):
      usb: dwc3: gadget: Fix checking for number of TRBs left

Thomas Zimmermann (1):
      fbdev/sh7760fb: Alloc DMA memory from hardware device

Tiwei Bie (4):
      um: ubd: Do not use drvdata in release
      um: net: Do not use drvdata in release
      um: vector: Do not use drvdata in release
      um: Fix the return value of elf_core_copy_task_fpregs

Tomi Valkeinen (1):
      drm/omap: Fix locking in omap_gem_new_dmabuf()

Trond Myklebust (1):
      NFSv4.0: Fix a use-after-free problem in the asynchronous open()

Vitalii Mordan (2):
      marvell: pxa168_eth: fix call balance of pep->clk handling routines
      usb: ehci-spear: fix call balance of sehci clk handling routines

Will Deacon (1):
      arm64: tls: Fix context-switching of tpidrro_el0 when kpti is enabled

Ye Bin (1):
      scsi: bfa: Fix use-after-free in bfad_im_module_exit()

Yi Yang (1):
      crypto: pcrypt - Call crypto layer directly when padata_do_parallel() return -EBUSY

Yongliang Gao (1):
      rtc: check if __rtc_read_time was successful in rtc_timer_do_work()

Yuan Can (1):
      cpufreq: loongson2: Unregister platform_driver on failure

Yuan Chen (1):
      bpf: Fix the xdp_adjust_tail sample prog issue

Zeng Heng (1):
      scsi: fusion: Remove unused variable 'rc'

Zhang Changzhong (1):
      mfd: rt5033: Fix missing regmap_del_irq_chip()

Zhen Lei (2):
      scsi: qedi: Fix a possible memory leak in qedi_alloc_and_init_sb()
      fbdev: sh7760fb: Fix a possible memory leak in sh7760fb_alloc_mem()

Zhihao Cheng (3):
      ubi: wl: Put source PEB into correct list if trying locking LEB failed
      ubifs: Correct the total block count by deducting journal reservation
      ubi: fastmap: Fix duplicate slab cache names while attaching

chao liu (1):
      apparmor: fix 'Do simple duplicate message elimination'

weiyufeng (1):
      PCI: cpqphp: Use PCI_POSSIBLE_ERROR() to check config reads



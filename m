Return-Path: <stable+bounces-91944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 471519C2150
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8024CB212F9
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438471F9414;
	Fri,  8 Nov 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iOW1QFIY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7D45023;
	Fri,  8 Nov 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081571; cv=none; b=YsIjv5jBW8LWDF/+QlgI+W9nYVrFB6MuEdFAC2hKsc0Plu5oe9RlYPSSHPnV2cK4Ln0b+qBxw0miiEf0st56cbXACaqb7FCA/YYm6faRogy/OhItfKwle50X5J6BsrVrvNoC2oCmgG7H3F9/8nODs7w5LS1bJ+PLMrwwBiddLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081571; c=relaxed/simple;
	bh=8xmxU082O9fN1ssKg3Cnkl3hbEkha8955yRwuEoD+PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S5LVj9n4vLDuoor3D8WXVS17xN0BYUiU3Ia0iAHeGA+y/bqafES950p/SAQ3zzzXXsDJ321wTN2Tdru22+zlitsiwhFEOTsA33bgItKDX4ePbaFkSIjTYemx7YF1GRPabM1UCJy+wqYkRAfS4yR67qG9zoyWXOXJsZ2H+w6ecdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iOW1QFIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9691C4CECD;
	Fri,  8 Nov 2024 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081570;
	bh=8xmxU082O9fN1ssKg3Cnkl3hbEkha8955yRwuEoD+PA=;
	h=From:To:Cc:Subject:Date:From;
	b=iOW1QFIY88XYPZxyTdWhCSee5ZrYAMhnDzQLoyk/hFYS2pSAwMiuVJ0KGFCIjCcRZ
	 Jf0K4B2uaFVOuqJNHxv15NPXjdtr0exTpICv+J4EHYYz6YhrVmC90+28KtoGu0GvGh
	 820t8ktapRqzQtUzQb3JgGFRj/4v5ltlXSVzBKV8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.323
Date: Fri,  8 Nov 2024 16:59:08 +0100
Message-ID: <2024110809-unbalance-erupt-8ba5@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.323 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                    |    1 
 Documentation/IPMI.txt                                        |    2 
 Documentation/arm64/silicon-errata.txt                        |    2 
 Documentation/driver-model/devres.txt                         |    1 
 Makefile                                                      |    2 
 arch/arm/mach-realview/platsmp-dt.c                           |    1 
 arch/arm64/Kconfig                                            |    2 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                 |   23 
 arch/arm64/include/asm/cputype.h                              |    4 
 arch/arm64/include/asm/uprobes.h                              |   12 
 arch/arm64/kernel/cpu_errata.c                                |    2 
 arch/arm64/kernel/probes/decode-insn.c                        |   16 
 arch/arm64/kernel/probes/simulate-insn.c                      |   18 
 arch/arm64/kernel/probes/uprobes.c                            |    4 
 arch/microblaze/mm/init.c                                     |    5 
 arch/parisc/kernel/entry.S                                    |    6 
 arch/parisc/kernel/syscall.S                                  |   14 
 arch/riscv/Kconfig                                            |    5 
 arch/s390/include/asm/facility.h                              |    6 
 arch/s390/kernel/perf_cpum_sf.c                               |   12 
 arch/s390/kvm/diag.c                                          |    2 
 arch/s390/kvm/gaccess.c                                       |  162 ++-
 arch/s390/kvm/gaccess.h                                       |   14 
 arch/s390/mm/cmm.c                                            |   18 
 arch/x86/include/asm/cpufeatures.h                            |    3 
 arch/x86/kernel/apic/apic.c                                   |   14 
 arch/x86/kernel/cpu/mshyperv.c                                |    1 
 arch/x86/xen/setup.c                                          |    2 
 block/bfq-iosched.c                                           |   13 
 crypto/aead.c                                                 |    3 
 crypto/cipher.c                                               |    3 
 drivers/acpi/acpica/dbconvert.c                               |    2 
 drivers/acpi/acpica/exprep.c                                  |    3 
 drivers/acpi/acpica/psargs.c                                  |   47 +
 drivers/acpi/battery.c                                        |   28 
 drivers/acpi/button.c                                         |   11 
 drivers/acpi/device_sysfs.c                                   |    5 
 drivers/acpi/ec.c                                             |   55 +
 drivers/acpi/pmic/tps68470_pmic.c                             |    6 
 drivers/ata/sata_sil.c                                        |   12 
 drivers/base/bus.c                                            |    6 
 drivers/base/core.c                                           |   13 
 drivers/base/firmware_loader/main.c                           |   30 
 drivers/base/module.c                                         |    4 
 drivers/block/aoe/aoecmd.c                                    |   13 
 drivers/block/drbd/drbd_main.c                                |    6 
 drivers/block/drbd/drbd_state.c                               |    2 
 drivers/bluetooth/btusb.c                                     |   10 
 drivers/char/virtio_console.c                                 |   18 
 drivers/clk/bcm/clk-bcm53573-ilp.c                            |    2 
 drivers/clk/clk-devres.c                                      |  105 +-
 drivers/clk/rockchip/clk-rk3228.c                             |    2 
 drivers/clk/rockchip/clk.c                                    |    3 
 drivers/clk/ti/clk-dra7-atl.c                                 |    1 
 drivers/clocksource/timer-qcom.c                              |    7 
 drivers/firmware/arm_sdei.c                                   |    2 
 drivers/gpio/gpio-aspeed.c                                    |    4 
 drivers/gpio/gpio-davinci.c                                   |    8 
 drivers/gpio/gpiolib.c                                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                      |   15 
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c                |   26 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c             |    2 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c        |    2 
 drivers/gpu/drm/amd/include/atombios.h                        |    4 
 drivers/gpu/drm/drm_crtc.c                                    |   17 
 drivers/gpu/drm/drm_print.c                                   |   13 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h                         |    1 
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c                     |   26 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c                      |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c                            |    2 
 drivers/gpu/drm/radeon/atombios.h                             |    2 
 drivers/gpu/drm/radeon/evergreen_cs.c                         |   62 -
 drivers/gpu/drm/radeon/r100.c                                 |   70 -
 drivers/gpu/drm/radeon/radeon_atombios.c                      |   26 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                   |    4 
 drivers/gpu/drm/stm/drv.c                                     |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                           |    1 
 drivers/hid/hid-ids.h                                         |    2 
 drivers/hid/hid-plantronics.c                                 |   23 
 drivers/hwmon/max16065.c                                      |    5 
 drivers/hwmon/ntc_thermistor.c                                |    1 
 drivers/hwtracing/coresight/coresight-tmc-etr.c               |    2 
 drivers/i2c/busses/i2c-aspeed.c                               |   16 
 drivers/i2c/busses/i2c-i801.c                                 |    9 
 drivers/i2c/busses/i2c-isch.c                                 |    3 
 drivers/i2c/busses/i2c-xiic.c                                 |   19 
 drivers/iio/adc/Kconfig                                       |    2 
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c           |    2 
 drivers/iio/dac/Kconfig                                       |    1 
 drivers/iio/light/opt3001.c                                   |    4 
 drivers/iio/magnetometer/ak8975.c                             |   32 
 drivers/infiniband/core/iwcm.c                                |    2 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                      |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                    |    2 
 drivers/infiniband/hw/cxgb4/cm.c                              |   14 
 drivers/input/keyboard/adp5589-keys.c                         |   13 
 drivers/input/rmi4/rmi_driver.c                               |    6 
 drivers/mailbox/bcm2835-mailbox.c                             |    3 
 drivers/mailbox/rockchip-mailbox.c                            |    2 
 drivers/media/common/videobuf2/videobuf2-core.c               |    8 
 drivers/media/dvb-frontends/rtl2830.c                         |    2 
 drivers/media/dvb-frontends/rtl2832.c                         |    2 
 drivers/media/platform/qcom/venus/core.c                      |    1 
 drivers/misc/sgi-gru/grukservices.c                           |    2 
 drivers/misc/sgi-gru/grumain.c                                |    4 
 drivers/misc/sgi-gru/grutlbpurge.c                            |    2 
 drivers/mtd/devices/slram.c                                   |    2 
 drivers/net/dsa/mv88e6xxx/global1_atu.c                       |    3 
 drivers/net/ethernet/aeroflex/greth.c                         |    3 
 drivers/net/ethernet/amd/mvme147.c                            |    7 
 drivers/net/ethernet/broadcom/bcmsysport.c                    |    1 
 drivers/net/ethernet/cortina/gemini.c                         |   15 
 drivers/net/ethernet/emulex/benet/be_main.c                   |   10 
 drivers/net/ethernet/faraday/ftgmac100.c                      |   26 
 drivers/net/ethernet/faraday/ftgmac100.h                      |    2 
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                |    9 
 drivers/net/ethernet/hisilicon/hip04_eth.c                    |    1 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c             |    1 
 drivers/net/ethernet/hisilicon/hns_mdio.c                     |    1 
 drivers/net/ethernet/i825xx/sun3_82586.c                      |    1 
 drivers/net/ethernet/ibm/emac/mal.c                           |    2 
 drivers/net/ethernet/intel/igb/igb_main.c                     |    4 
 drivers/net/ethernet/jme.c                                    |   10 
 drivers/net/ethernet/lantiq_etop.c                            |    4 
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                |    2 
 drivers/net/ethernet/seeq/ether3.c                            |    2 
 drivers/net/gtp.c                                             |   27 
 drivers/net/hyperv/netvsc_drv.c                               |   30 
 drivers/net/macsec.c                                          |   18 
 drivers/net/phy/vitesse.c                                     |   14 
 drivers/net/ppp/ppp_async.c                                   |    2 
 drivers/net/usb/cdc_ncm.c                                     |    8 
 drivers/net/usb/ipheth.c                                      |    5 
 drivers/net/usb/r8152.c                                       |   73 -
 drivers/net/usb/usbnet.c                                      |    3 
 drivers/net/wireless/ath/ath10k/wmi-tlv.c                     |    7 
 drivers/net/wireless/ath/ath10k/wmi.c                         |    2 
 drivers/net/wireless/ath/ath9k/debug.c                        |    6 
 drivers/net/wireless/ath/ath9k/hif_usb.c                      |    6 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c                |    2 
 drivers/net/wireless/intel/iwlegacy/common.c                  |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c             |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                 |    8 
 drivers/net/wireless/marvell/mwifiex/fw.h                     |    2 
 drivers/net/wireless/marvell/mwifiex/scan.c                   |    3 
 drivers/ntb/hw/intel/ntb_hw_gen1.c                            |    2 
 drivers/of/irq.c                                              |   38 
 drivers/parport/procfs.c                                      |   22 
 drivers/pci/controller/pcie-xilinx-nwl.c                      |   24 
 drivers/pci/quirks.c                                          |    6 
 drivers/pinctrl/mvebu/pinctrl-dove.c                          |   42 
 drivers/pinctrl/pinctrl-at91.c                                |    5 
 drivers/pinctrl/pinctrl-single.c                              |    3 
 drivers/power/reset/brcmstb-reboot.c                          |    3 
 drivers/power/supply/max17042_battery.c                       |    5 
 drivers/pps/clients/pps_parport.c                             |   14 
 drivers/reset/reset-berlin.c                                  |    3 
 drivers/rtc/Kconfig                                           |    2 
 drivers/rtc/rtc-at91sam9.c                                    |   45 
 drivers/s390/char/sclp_vt220.c                                |    4 
 drivers/scsi/aacraid/aacraid.h                                |    2 
 drivers/soc/versatile/soc-integrator.c                        |    1 
 drivers/soc/versatile/soc-realview.c                          |   20 
 drivers/soundwire/stream.c                                    |    8 
 drivers/spi/spi-bcm63xx.c                                     |    2 
 drivers/spi/spi-ppc4xx.c                                      |    7 
 drivers/spi/spi-s3c64xx.c                                     |    4 
 drivers/staging/iio/frequency/ad9834.c                        |   54 -
 drivers/staging/iio/frequency/ad9834.h                        |   28 
 drivers/tty/serial/rp2.c                                      |    2 
 drivers/tty/vt/vt.c                                           |    2 
 drivers/usb/chipidea/udc.c                                    |    8 
 drivers/usb/dwc3/core.c                                       |   49 -
 drivers/usb/dwc3/core.h                                       |   11 
 drivers/usb/dwc3/gadget.c                                     |   11 
 drivers/usb/host/xhci-pci.c                                   |    5 
 drivers/usb/host/xhci-ring.c                                  |   16 
 drivers/usb/host/xhci.h                                       |    2 
 drivers/usb/misc/appledisplay.c                               |   15 
 drivers/usb/misc/cypress_cy7c63.c                             |    4 
 drivers/usb/misc/yurex.c                                      |    5 
 drivers/usb/phy/phy.c                                         |    2 
 drivers/usb/serial/option.c                                   |    8 
 drivers/usb/serial/pl2303.c                                   |    1 
 drivers/usb/serial/pl2303.h                                   |    4 
 drivers/usb/storage/unusual_devs.h                            |   11 
 drivers/usb/typec/class.c                                     |    3 
 drivers/video/fbdev/hpfb.c                                    |    1 
 drivers/video/fbdev/pxafb.c                                   |    1 
 drivers/video/fbdev/sis/sis_main.c                            |    2 
 drivers/xen/swiotlb-xen.c                                     |   34 
 fs/btrfs/disk-io.c                                            |   11 
 fs/ceph/addr.c                                                |    1 
 fs/ext4/ext4.h                                                |    1 
 fs/ext4/extents.c                                             |   70 +
 fs/ext4/ialloc.c                                              |    2 
 fs/ext4/inline.c                                              |   35 
 fs/ext4/inode.c                                               |   11 
 fs/ext4/mballoc.c                                             |   10 
 fs/ext4/migrate.c                                             |    2 
 fs/ext4/move_extent.c                                         |    1 
 fs/ext4/namei.c                                               |   14 
 fs/ext4/xattr.c                                               |    4 
 fs/f2fs/acl.c                                                 |   23 
 fs/f2fs/dir.c                                                 |    3 
 fs/f2fs/f2fs.h                                                |    4 
 fs/f2fs/file.c                                                |   24 
 fs/f2fs/super.c                                               |    4 
 fs/f2fs/xattr.c                                               |   27 
 fs/fat/namei_vfat.c                                           |    2 
 fs/fcntl.c                                                    |   14 
 fs/inode.c                                                    |    4 
 fs/jbd2/checkpoint.c                                          |   14 
 fs/jbd2/commit.c                                              |   36 
 fs/jbd2/journal.c                                             |    2 
 fs/jfs/jfs_discard.c                                          |   11 
 fs/jfs/jfs_dmap.c                                             |   11 
 fs/jfs/jfs_imap.c                                             |    2 
 fs/jfs/xattr.c                                                |    2 
 fs/lockd/clnt4xdr.c                                           |   14 
 fs/lockd/clntxdr.c                                            |   14 
 fs/nfs/callback_xdr.c                                         |   61 -
 fs/nfs/nfs2xdr.c                                              |   84 -
 fs/nfs/nfs3xdr.c                                              |  163 +--
 fs/nfs/nfs42xdr.c                                             |   21 
 fs/nfs/nfs4state.c                                            |    1 
 fs/nfs/nfs4xdr.c                                              |  451 ++--------
 fs/nfsd/nfs4callback.c                                        |   13 
 fs/nfsd/nfs4idmap.c                                           |   13 
 fs/nfsd/nfs4state.c                                           |   15 
 fs/nilfs2/btree.c                                             |   12 
 fs/nilfs2/dir.c                                               |   50 -
 fs/nilfs2/namei.c                                             |   42 
 fs/nilfs2/nilfs.h                                             |    2 
 fs/nilfs2/page.c                                              |    7 
 fs/ocfs2/aops.c                                               |    5 
 fs/ocfs2/buffer_head_io.c                                     |    4 
 fs/ocfs2/file.c                                               |    8 
 fs/ocfs2/journal.c                                            |    7 
 fs/ocfs2/localalloc.c                                         |   19 
 fs/ocfs2/quota_local.c                                        |    8 
 fs/ocfs2/refcounttree.c                                       |   26 
 fs/ocfs2/xattr.c                                              |   38 
 fs/udf/inode.c                                                |    9 
 include/drm/drm_print.h                                       |   54 +
 include/linux/clk.h                                           |  145 +++
 include/linux/jbd2.h                                          |    4 
 include/linux/pci_ids.h                                       |    2 
 include/net/sock.h                                            |    2 
 include/net/tcp.h                                             |   27 
 include/trace/events/f2fs.h                                   |    3 
 include/trace/events/sched.h                                  |   84 +
 include/uapi/linux/cec.h                                      |    6 
 include/uapi/linux/netfilter/nf_tables.h                      |    2 
 kernel/bpf/arraymap.c                                         |    3 
 kernel/bpf/hashtab.c                                          |    3 
 kernel/bpf/lpm_trie.c                                         |    2 
 kernel/cgroup/cgroup.c                                        |    4 
 kernel/events/core.c                                          |    6 
 kernel/events/uprobes.c                                       |    2 
 kernel/kthread.c                                              |   19 
 kernel/signal.c                                               |   11 
 kernel/time/posix-clock.c                                     |    3 
 kernel/trace/trace_output.c                                   |    6 
 lib/xz/xz_crc32.c                                             |    2 
 lib/xz/xz_private.h                                           |    4 
 mm/shmem.c                                                    |    2 
 net/bluetooth/af_bluetooth.c                                  |    1 
 net/bluetooth/bnep/core.c                                     |    3 
 net/bluetooth/rfcomm/sock.c                                   |    2 
 net/bridge/br_netfilter_hooks.c                               |    5 
 net/can/bcm.c                                                 |    4 
 net/core/dev.c                                                |   29 
 net/ipv4/devinet.c                                            |    6 
 net/ipv4/fib_frontend.c                                       |    2 
 net/ipv4/ip_gre.c                                             |    6 
 net/ipv4/netfilter/nf_dup_ipv4.c                              |    7 
 net/ipv4/tcp_input.c                                          |   24 
 net/ipv4/tcp_ipv4.c                                           |    5 
 net/ipv4/tcp_output.c                                         |    2 
 net/ipv4/tcp_rate.c                                           |   15 
 net/ipv4/tcp_recovery.c                                       |    5 
 net/ipv6/addrconf.c                                           |    8 
 net/ipv6/netfilter/nf_dup_ipv6.c                              |    7 
 net/ipv6/netfilter/nf_reject_ipv6.c                           |   14 
 net/mac80211/cfg.c                                            |    3 
 net/mac80211/iface.c                                          |   17 
 net/mac80211/key.c                                            |   42 
 net/netfilter/nf_conntrack_netlink.c                          |    7 
 net/netfilter/nf_tables_api.c                                 |    2 
 net/netfilter/nft_payload.c                                   |    3 
 net/netlink/af_netlink.c                                      |    3 
 net/qrtr/qrtr.c                                               |    2 
 net/sched/sch_api.c                                           |    2 
 net/sctp/socket.c                                             |    4 
 net/tipc/bearer.c                                             |    8 
 net/wireless/nl80211.c                                        |    3 
 net/wireless/scan.c                                           |    6 
 net/wireless/sme.c                                            |    3 
 net/xfrm/xfrm_user.c                                          |    6 
 scripts/kconfig/merge_config.sh                               |    2 
 security/selinux/selinuxfs.c                                  |   31 
 security/smack/smackfs.c                                      |    2 
 security/tomoyo/domain.c                                      |    9 
 sound/core/init.c                                             |   14 
 sound/pci/asihpi/hpimsgx.c                                    |    2 
 sound/pci/hda/hda_generic.c                                   |    4 
 sound/pci/hda/patch_conexant.c                                |   24 
 sound/pci/hda/patch_realtek.c                                 |   38 
 sound/pci/rme9652/hdsp.c                                      |    6 
 sound/pci/rme9652/hdspm.c                                     |    6 
 sound/soc/au1x/db1200.c                                       |    1 
 sound/soc/codecs/tda7419.c                                    |    1 
 tools/iio/iio_generic_buffer.c                                |    4 
 tools/perf/builtin-sched.c                                    |    8 
 tools/perf/util/time-utils.c                                  |    4 
 tools/testing/ktest/ktest.pl                                  |    2 
 tools/testing/selftests/bpf/test_lru_map.c                    |    3 
 tools/testing/selftests/breakpoints/step_after_suspend_test.c |    5 
 tools/testing/selftests/kcmp/kcmp_test.c                      |    1 
 tools/testing/selftests/vDSO/parse_vdso.c                     |    3 
 tools/testing/selftests/vm/compaction_test.c                  |    2 
 tools/usb/usbip/src/usbip_detach.c                            |    1 
 virt/kvm/kvm_main.c                                           |    5 
 325 files changed, 2608 insertions(+), 1776 deletions(-)

Aaron Thompson (1):
      Bluetooth: Remove debugfs directory on module init failure

Aleksander Jan Bajkowski (1):
      net: ethernet: lantiq_etop: fix memory disclosure

Aleksandr Mishin (2):
      staging: iio: frequency: ad9834: Validate frequency parameter value
      ACPI: PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()

Aleksandrs Vinarskis (1):
      ACPICA: iasl: handle empty connection_node

Alex Bee (1):
      drm/rockchip: vop: Allow 4096px width scaling

Alex Deucher (2):
      drm/amdgpu: properly handle vbios fake edid sizing
      drm/radeon: properly handle vbios fake edid sizing

Alex Hung (1):
      drm/amd/display: Check stream before comparing them

Alex Williamson (1):
      PCI: Mark Creative Labs EMU20k2 INTx masking as broken

Alexandre Belloni (1):
      rtc: at91sam9: drop platform_data support

Anastasia Kovaleva (1):
      net: Fix an unsafe loop on the list

Anders Roxell (1):
      scripts: kconfig: merge_config: config files: add a trailing newline

Andrew Davis (1):
      power: reset: brcmstb: Do not go into infinite loop if reset fails

Andrew Jones (1):
      of/irq: Support #msi-cells=<0> in of_msi_get_domain

Andrey Shumilin (1):
      fbdev: sisfb: Fix strbuf array overflow

Andrey Skvortsov (1):
      clk: Fix slab-out-of-bounds error in devm_clk_release()

Andy Roulin (1):
      netfilter: br_netfilter: fix panic with metadata_dst skb

Andy Shevchenko (2):
      spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ
      i2c: isch: Add missed 'else'

Ankit Agrawal (1):
      clocksource/drivers/qcom: Add missing iounmap() on errors in msm_dt_timer_init()

Anshuman Khandual (1):
      arm64: Add Cortex-715 CPU part definition

Anton Danilov (1):
      ipv4: ip_gre: Fix drops of small packets in ipgre_xmit

Anumula Murali Mohan Reddy (1):
      RDMA/cxgb4: Fix RDMA_CM_EVENT_UNREACHABLE error for iWARP

Armin Wolf (4):
      ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails
      ACPICA: Fix memory leak if acpi_ps_get_next_field() fails
      ACPI: battery: Simplify battery hook locking
      ACPI: battery: Fix possible crash when unregistering a battery hook

Arnd Bergmann (1):
      nfsd: use ktime_get_seconds() for timestamps

Artem Sadovnikov (1):
      ext4: fix i_data_sem unlock order in ext4_ind_migrate()

Artur Weber (1):
      power: supply: max17042_battery: Fix SOC threshold calc w/ no current sense

Baokun Li (6):
      ext4: propagate errors from ext4_find_extent() in ext4_insert_range()
      ext4: aovid use-after-free in ext4_ext_insert_extent()
      ext4: fix double brelse() the buffer of the extents path
      jbd2: stop waiting for space when jbd2_cleanup_journal_tail() returns error
      ext4: fix slab-use-after-free in ext4_split_extent_at()
      ext4: update orig_path in ext4_find_extent()

Barnabás Czémán (1):
      iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Ben Dooks (1):
      spi: s3c64xx: fix timeout counters in flush_fifo

Beniamin Bia (2):
      staging: iio: frequency: ad9833: Get frequency value statically
      staging: iio: frequency: ad9833: Load clock using clock framework

Benjamin B. Frost (1):
      USB: serial: option: add support for Quectel EG916Q-GL

Benoît Monin (1):
      net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension

Billy Tsai (2):
      gpio: aspeed: Add the flush write to ensure the write complete.
      gpio: aspeed: Use devm_clk api to manage clock source

Breno Leitao (1):
      KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()

Byeonguk Jeong (1):
      bpf: Fix out-of-bounds write in trie_get_next_key()

Chao Yu (4):
      f2fs: enhance to update i_mode and acl atomically in f2fs_setattr()
      f2fs: fix to update i_ctime in __f2fs_setxattr()
      f2fs: remove unneeded check condition in __f2fs_setxattr()
      f2fs: reduce expensive checkpoint trigger frequency

Chen Yu (1):
      kthread: fix task state in kthread worker if being frozen

Christophe JAILLET (5):
      fbdev: hpfb: Fix an error handling path in hpfb_dio_probe()
      drm/stm: Fix an error handling path in stm_drm_platform_probe()
      pps: remove usage of the deprecated ida_simple_xx() API
      iio: hid-sensors: Fix an error handling path in _hid_sensor_set_report_latency()
      gtp: simplify error handling code in 'gtp_encap_enable()'

Christophe Leroy (1):
      selftests: vDSO: fix vDSO symbols lookup for powerpc64

Chuck Lever (1):
      NFS: Remove print_overflow_msg()

Chun-Yi Lee (1):
      aoe: fix the potential use-after-free problem in more places

Damien Le Moal (1):
      ata: sata_sil: Rename sil_blacklist to sil_quirks

Dan Carpenter (1):
      SUNRPC: Fix integer overflow in decode_rc_list()

Daniel Gabay (1):
      wifi: iwlwifi: mvm: fix iwl_mvm_max_scan_ie_fw_cmd_room()

Daniel Jordan (1):
      ktest.pl: Avoid false positives with grub2 skip regex

Daniel Palmer (1):
      net: amd: mvme147: Fix probe banner message

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 MBIM compositions

Dave Kleikamp (1):
      jfs: Fix sanity check in dbMount

David Lechner (1):
      clk: ti: dra7-atl: Fix leak of of_nodes

Dimitri Sivanich (1):
      misc: sgi-gru: Don't disable preemption in GRU driver

Dmitry Antipov (3):
      wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()
      wifi: cfg80211: fix two more possible UBSAN-detected off-by-one errors
      wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()

Dmitry Kandybka (1):
      wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()

Edward Adam Davis (4):
      jfs: Fix uaf in dbFreeBits
      jfs: check if leafidx greater than num leaves per dmap tree
      ext4: no need to continue when the number of entries is 1
      ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow

Emanuele Ghidoli (1):
      gpio: davinci: fix lazy disable

Emil Gedenryd (1):
      iio: light: opt3001: add missing full-scale range value

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead

Eran Ben Elisha (1):
      net/mlx5: Update the list of the PCI supported devices

Eric Dumazet (6):
      netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()
      tcp: introduce tcp_skb_timestamp_us() helper
      netfilter: nf_tables: prevent nf_skb_duplicated corruption
      net: avoid potential underflow in qdisc_pkt_len_init() with UFO
      net: add more sanity checks to qdisc_pkt_len_init()
      ppp: fix ppp_async_encode() illegal access

Faisal Hassan (1):
      xhci: Fix Link TRB DMA in command ring stopped completion event

Felix Fietkau (2):
      wifi: mac80211: skip non-uploaded keys in ieee80211_iter_keys
      wifi: mac80211: do not pass a stopped vif to the driver in .get_txpower

Ferry Meng (2):
      ocfs2: add bounds checking to ocfs2_xattr_find_entry()
      ocfs2: strict bound check before memcmp in ocfs2_xattr_find_entry()

Filipe Manana (1):
      btrfs: wait for fixup workers before stopping cleaner kthread during umount

Florian Fainelli (1):
      tty: rp2: Fix reset with non forgiving PCIe host bridges

Foster Snowhill (1):
      usbnet: ipheth: fix carrier detection in modes 1 and 4

Gautham Ananthakrishna (1):
      ocfs2: reserve space for inline xattr before attaching reflink tree

Geert Uytterhoeven (2):
      drm/radeon/r100: Handle unknown family in r100_cp_init_microcode()
      of/irq: Refer to actual buffer size in of_irq_parse_one()

Gerald Schaefer (1):
      s390/mm: Add cond_resched() to cmm_alloc/free_pages()

Gianfranco Trad (1):
      udf: fix uninit-value use in udf_get_fileshortad

Greg Kroah-Hartman (2):
      Revert "driver core: Fix uevent_show() vs driver detach race"
      Linux 4.19.323

Guenter Roeck (1):
      hwmon: (max16065) Fix overflows seen when writing limits

Guoqing Jiang (1):
      nfsd: call cache_put if xdr_reserve_space returns NULL

Gustavo A. R. Silva (1):
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_cmd_802_11_scan_ext()

Hagar Hemdan (1):
      gpio: prevent potential speculation leaks in gpio_device_get_desc()

Hailey Mothershead (1):
      crypto: aead,cipher - zeroize key buffer after use

Haiyang Zhang (1):
      hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event

Hans Verkuil (1):
      media: uapi/linux/cec.h: cec_msg_set_reply_to: zero flags

Hans de Goede (1):
      i2c: i801: Use a different adapter-name for IDF adapters

Harshit Mogalapalli (1):
      usb: yurex: Fix inconsistent locking bug in yurex_read()

Heiko Carstens (1):
      s390/facility: Disable compile time optimization for decompressor code

Helge Deller (2):
      parisc: Fix itlb miss handler for 64-bit programs
      parisc: Fix 64-bit userspace syscall path

Heming Zhao (1):
      ocfs2: fix the la space leak when unmounting an ocfs2 volume

Hongbo Li (1):
      ASoC: allow module autoloading for table db1200_pids

Ian Rogers (1):
      perf time-utils: Fix 32-bit nsec parsing

Icenowy Zheng (1):
      usb: storage: ignore bogus device raised by JieLi BR21 USB sound chip

Ido Schimmel (1):
      ipv4: Mask upper DSCP bits and ECN bits in NETLINK_FIB_LOOKUP family

Jacky Chou (2):
      net: ftgmac100: Enable TX interrupt to avoid TX timeout
      net: ftgmac100: Ensure tx descriptor updates are visible

Janis Schoetterl-Glausch (3):
      KVM: s390: gaccess: Refactor gpa and length calculation
      KVM: s390: gaccess: Refactor access address range check
      KVM: s390: gaccess: Cleanup access to guest pages

Jann Horn (2):
      firmware_loader: Block path traversal
      f2fs: Require FMODE_WRITE for atomic write ioctls

Jaroslav Kysela (1):
      ALSA: core: add isascii() check to card ID generator

Jason Xing (1):
      tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process

Javier Carrasco (2):
      iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig
      iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig

Jeongjun Park (3):
      jfs: fix out-of-bounds in dbNextAG() and diAlloc()
      mm: shmem: fix data-race in shmem_getattr()
      vt: prevent kernel-infoleak in con_font_get()

Jiawei Ye (1):
      smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso

Jim Mattson (1):
      x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET

Jinjie Ruan (4):
      ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
      spi: bcm63xx: Fix module autoloading
      posix-clock: Fix missing timespec64 check in pc_clock_settime()
      posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()

Jisheng Zhang (1):
      riscv: define ILLEGAL_POINTER_VALUE for 64bit

Jonas Karlman (1):
      clk: rockchip: Set parent rate for DCLK_VOP clock on RK3228

Jonathan Marek (1):
      drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calculation

Jose Alberto Reguero (1):
      usb: xhci: Fix problem with xhci resume from suspend

Joseph Huang (1):
      net: dsa: mv88e6xxx: Fix out-of-bound access

Joseph Qi (2):
      ocfs2: fix uninit-value in ocfs2_get_block()
      ocfs2: cancel dqi_sync_work before freeing oinfo

Josh Hunt (1):
      tcp: check skb is non-NULL in tcp_rto_delta_us()

Juergen Gross (3):
      xen: use correct end address of kernel for conflict checking
      xen/swiotlb: simplify range_straddles_page_boundary()
      xen/swiotlb: add alignment check for dma buffers

Julian Sun (2):
      vfs: fix race between evice_inodes() and find_inode()&iput()
      ocfs2: fix null-ptr-deref when journal load failed.

Junhao Xie (1):
      USB: serial: pl2303: add device id for Macrosilicon MS3020

Junlin Li (2):
      drivers: media: dvb-frontends/rtl2832: fix an out-of-bounds write error
      drivers: media: dvb-frontends/rtl2830: fix an out-of-bounds write error

Kailang Yang (1):
      ALSA: hda/realtek: Update default depop procedure

Kaixin Wang (2):
      net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition
      fbdev: pxafb: Fix possible use after free in pxafb_task()

Kalesh AP (1):
      RDMA/bnxt_re: Return more meaningful error

Kees Cook (1):
      scsi: aacraid: Rearrange order of struct aac_srb_unit

Kemeng Shi (1):
      ext4: avoid negative min_clusters in find_group_orlov()

Krzysztof Kozlowski (11):
      soundwire: stream: Revert "soundwire: stream: fix programming slave ports for non-continous port maps"
      ARM: versatile: fix OF node leak in CPUs prepare
      reset: berlin: fix OF node leak in probe() error path
      soc: versatile: integrator: fix OF node leak in probe() error path
      soc: versatile: realview: fix memory leak during device remove
      soc: versatile: realview: fix soc_dev leak during device remove
      net: hisilicon: hip04: fix OF node leak in probe()
      net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
      net: hisilicon: hns_mdio: fix OF node leak in probe()
      rtc: at91sam9: fix OF node leak in probe() error path
      clk: bcm: bcm53573: fix OF node leak in init

Kuniyuki Iwashima (2):
      can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().
      ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).

Lasse Collin (1):
      xz: cleanup CRC32 edits from 2018

Laurent Pinchart (1):
      Remove *.orig pattern from .gitignore

Lee Jones (1):
      usb: yurex: Replace snprintf() with the safer scnprintf() variant

Li Lingfeng (1):
      nfs: fix memory leak in error path of nfs4_do_reclaim

Liao Chen (3):
      ASoC: tda7419: fix module autoloading
      spi: bcm63xx: Enable module autoloading
      mailbox: rockchip: fix a typo in module autoloading

Linus Walleij (1):
      net: ethernet: cortina: Drop TSO support

Lizhi Xu (2):
      ocfs2: remove unreasonable unlock in ocfs2_read_blocks
      ocfs2: fix possible null-ptr-deref in ocfs2_set_buffer_uptodate

Luis Henriques (SUSE) (2):
      ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()
      ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()

Luiz Augusto von Dentz (3):
      Bluetooth: btusb: Fix not handling ZPL/short-transfer
      Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
      Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001

Luo Gengkun (1):
      perf/core: Fix small negative period being ignored

Ma Ke (2):
      spi: ppc4xx: handle irq_of_parse_and_map() errors
      pps: add an error check in parport_attach

Manikanta Pubbisetty (1):
      wifi: ath10k: Fix memory leak in management tx

Marek Szyprowski (1):
      usb: dwc3: remove generic PHY calibrate() calls

Mario Limonciello (1):
      drm/amd: Guard against bad data for ATIF ACPI method

Mark Rutland (5):
      arm64: cputype: Add Neoverse-N3 definitions
      arm64: errata: Expand speculative SSBS workaround once more
      arm64: probes: Remove broken LDR (literal) uprobe support
      arm64: probes: Fix simulate_ldr*_literal()
      arm64: probes: Fix uprobes for big-endian kernels

Mathias Krause (1):
      Input: synaptics-rmi4 - fix UAF of IRQ domain on driver removal

Mathias Nyman (1):
      xhci: Fix incorrect stream context type macro

Matteo Croce (1):
      drm/amd: fix typo

Matthew Brost (1):
      drm/printer: Allow NULL data in devcoredump printer

Mauricio Faria de Oliveira (1):
      jbd2: introduce/export functions jbd2_journal_submit|finish_inode_data_buffers()

Michael Kelley (1):
      x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency

Michael Mueller (1):
      KVM: s390: Change virtual to physical address access in diag 0x258 handler

Michael S. Tsirkin (1):
      virtio_console: fix misc probe bugs

Mickaël Salaün (1):
      fs: Fix file_set_fowner LSM hook inconsistencies

Mike Rapoport (1):
      microblaze: don't treat zero reserved memory regions as error

Mikhail Lobanov (2):
      RDMA/cxgb4: Added NULL check for lookup_atid
      drbd: Add NULL check for net_conf to prevent dereference in state validation

Minjie Du (1):
      wifi: ath9k: fix parameter check in ath9k_init_debug()

Mirsad Todorovac (1):
      mtd: slram: insert break after errors in parsing the map

Mohamed Khalfella (1):
      igb: Do not bring the device up after non-fatal error

Moon Yeounsu (1):
      net: ethernet: use ip_hdrlen() instead of bit shift

Neal Cardwell (1):
      tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe

NeilBrown (1):
      nfsd: fix delegation_blocked() to block correctly for at least 30 seconds

Nico Boehr (1):
      KVM: s390: gaccess: Check if guest address is in memslot

Nikita Zhandarovich (3):
      drm/radeon/evergreen_cs: fix int overflow errors in cs track offsets
      f2fs: prevent possible int overflow in dir_block_index()
      f2fs: avoid potential int overflow in sanity_check_area_boundary()

Nikolay Kuratov (1):
      drm/vmwgfx: Handle surface check failure correctly

Nuno Sa (1):
      Input: adp5589-keys - fix adp5589_gpio_get_value()

OGAWA Hirofumi (1):
      fat: fix uninitialized variable

Oleg Nesterov (1):
      uprobes: fix kernel info leak via "[uprobes]" vma

Oliver Neukum (6):
      USB: appledisplay: close race between probe and completion handler
      USB: misc: cypress_cy7c63: check for short transfer
      USB: misc: yurex: fix race between read and write
      CDC-NCM: avoid overflow in sanity checking
      Revert "usb: yurex: Replace snprintf() with the safer scnprintf() variant"
      net: usb: usbnet: fix name regression

Pablo Neira Ayuso (3):
      netfilter: nf_tables: elements with timeout below CONFIG_HZ never expire
      gtp: allow -1 to be specified as file description from userspace
      netfilter: nft_payload: sanitize offset and length before calling skb_checksum()

Paul Moore (1):
      selinux: improve error checking in sel_write_load()

Paulo Miguel Almeida (2):
      drm/amdgpu: Replace one-element array with flexible-array member
      drm/radeon: Replace one-element array with flexible-array member

Pawel Dembicki (1):
      net: phy: vitesse: repair vsc73xx autonegotiation

Pedro Tammela (1):
      net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT

Pei Xiao (1):
      ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()

Phil Edworthy (1):
      clk: Add (devm_)clk_get_optional() functions

Phil Sutter (1):
      netfilter: uapi: NFTA_FLOWTABLE_HOOK is NLA_NESTED

Prashant Malani (1):
      r8152: Factor out OOB link list waits

Qiu-ji Chen (1):
      drbd: Fix atomicity violation in drbd_uuid_set_bm()

Quentin Schulz (1):
      arm64: dts: rockchip: override BIOS_DISABLE signal via GPIO hog on RK3399 Puma

Rafael J. Wysocki (1):
      ACPI: EC: Do not release locks during operation region accesses

Remington Brasga (1):
      jfs: UBSAN: shift-out-of-bounds in dbFindBits

Rob Clark (2):
      kthread: add kthread_work tracepoints
      drm/crtc: fix uninitialized variable use even harder

Robert Hancock (1):
      i2c: xiic: Wait for TX empty to avoid missed TX NAKs

Rosen Penev (1):
      net: ibm: emac: mal: fix wrong goto

Ryusuke Konishi (7):
      nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()
      nilfs2: determine empty node blocks as corrupted
      nilfs2: fix potential oob read in nilfs_btree_check_delete()
      nilfs2: propagate directory read errors from nilfs_find_entry()
      nilfs2: fix kernel bug due to missing clearing of buffer delay flag
      nilfs2: fix potential deadlock with newly created symlinks
      nilfs2: fix kernel bug due to missing clearing of checked flag

Sabrina Dubroca (2):
      macsec: don't increment counters for an unrelated SA
      xfrm: validate new SA's prefixlen using SA family when sel.family is unset

Samasth Norway Ananda (2):
      selftests/vm: remove call to ksft_set_plan()
      selftests/kcmp: remove call to ksft_set_plan()

Saravanan Vajravel (1):
      RDMA/bnxt_re: Fix incorrect AVID type in WQE structure

Sean Anderson (3):
      net: dpaa: Pad packets to ETH_ZLEN
      PCI: xilinx-nwl: Fix register misspelling
      PCI: xilinx-nwl: Fix off-by-one in INTx IRQ handler

Sean Paul (1):
      drm: Move drm_mode_setcrtc() local re-init to failure path

Sebastian Reichel (1):
      clk: rockchip: fix error for unknown clocks

Selvarasu Ganesan (1):
      usb: dwc3: core: Stop processing of pending events if controller is halted

Sherry Yang (1):
      drm/msm: fix %s null argument error

Shubham Panwar (1):
      ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix initial lid detection issue

Simon Horman (3):
      netfilter: ctnetlink: compile ctnetlink_label_size with CONFIG_NF_CONNTRACK_EVENTS
      tipc: guard against string buffer overrun
      net: mvpp2: Increase size of queue_name buffer

Srinivasan Shanmugam (1):
      drm/amd/display: Fix index out of bounds in degamma hardware format translation

Stefan Wahren (1):
      mailbox: bcm2835: Fix timeout during suspend mode

Steven Rostedt (Google) (1):
      tracing: Remove precision vsnprintf() check from print event

Suzuki K Poulose (1):
      coresight: tmc: sg: Do not leak sg_table

Takashi Iwai (5):
      ALSA: hda/generic: Unconditionally prefer preferred_dacs pairs
      ALSA: hda/conexant: Fix conflicting quirk for System76 Pangolin
      ALSA: asihpi: Fix potential OOB array access
      ALSA: hdsp: Break infinite MIDI input flush loop
      parport: Proper fix for array out-of-bounds access

Tao Chen (1):
      bpf: Check percpu map value size first

Tetsuo Handa (1):
      tomoyo: fallback to realpath if symlink's pathname does not exist

Thadeu Lima de Souza Cascardo (4):
      ext4: return error on ext4_find_inline_entry
      ext4: avoid OOB when system.data xattr changes underneath the filesystem
      ext4: ext4_search_dir should return a proper error
      usb: typec: altmode should keep reference to parent

Theodore Ts'o (1):
      ext4: avoid ext4_error()'s caused by ENOMEM in the truncate path

Thomas Blocher (1):
      pinctrl: at91: make it work with current gpiolib

Thomas Gleixner (2):
      PCI: xilinx-nwl: Use irq_data_get_irq_chip_data()
      signal: Replace BUG_ON()s

Thomas Richter (1):
      s390/cpum_sf: Remove WARN_ON_ONCE statements

Thomas Weißschuh (2):
      ACPI: sysfs: validate return type of _STR method
      s390/sclp_vt220: Convert newlines to CRLF instead of LFCR

Toke Høiland-Jørgensen (2):
      wifi: ath9k: Remove error checks when creating debugfs entries
      wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit

Tommy Huang (1):
      i2c: aspeed: Update the stop sw state when the bus recovery occurs

Tony Ambardar (1):
      selftests/bpf: Fix error compiling test_lru_map.c

Uwe Kleine-König (3):
      clk: generalize devm_clk_get() a bit
      clk: Provide new devm_clk helpers for prepared and enabled clocks
      clk: Fix pointer casting to prevent oops in devm_clk_release()

Ville Syrjälä (1):
      wifi: iwlegacy: Clear stale interrupts before resuming device

Vladimir Lypak (2):
      drm/msm/a5xx: properly clear preemption records on resume
      drm/msm/a5xx: fix races in preemption evaluation stage

Wade Wang (1):
      HID: plantronics: Workaround for an unexcepted opposite volume key

Wang Hai (4):
      net: ethernet: aeroflex: fix potential memory leak in greth_start_xmit_gbit()
      net: systemport: fix potential memory leak in bcm_sysport_xmit()
      net/sun3_82586: fix potential memory leak in sun3_82586_send_packet()
      be2net: fix potential memory leak in be_xmit()

Wang Jianzheng (1):
      pinctrl: mvebu: Fix devinit_dove_pinctrl_probe function

WangYuli (1):
      PCI: Add function 0 DMA alias quirk for Glenfly Arise chip

Wojciech Gładysz (1):
      ext4: nested locking for xattr inode

Wolfram Sang (1):
      ipmi: docs: don't advertise deprecated sysfs entries

Xin Long (2):
      sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start
      net: support ip generic csum processing in skb_csum_hwoffload_help

Xiongfeng Wang (1):
      firmware: arm_sdei: Fix the input parameter of cpuhp_remove_state()

Xiu Jianfeng (1):
      cgroup: Fix potential overflow issue when checking max_depth

Xiubo Li (1):
      ceph: remove the incorrect Fw reference check when dirtying pages

Xu Yang (1):
      usb: chipidea: udc: enable suspend interrupt after usb reset

Yang Jihong (2):
      perf sched timehist: Fix missing free of session in perf_sched__timehist()
      perf sched timehist: Fixed timestamp error when unable to confirm event sched_in time

Yang Yingliang (1):
      pinctrl: single: fix missing error code in pcs_probe()

Ye Bin (1):
      Bluetooth: bnep: fix wild-memory-access in proto_unregister

Yifei Liu (1):
      selftests: breakpoints: use remaining time to check if suspend succeed

Yonggil Song (1):
      f2fs: fix typo

Youssef Samir (1):
      net: qrtr: Update packets cloning when broadcasting

Yu Chen (1):
      usb: dwc3: Add splitdisable quirk for Hisilicon Kirin Soc

Yu Kuai (3):
      block, bfq: fix possible UAF for bfqq->bic with merge chain
      block, bfq: choose the last bfqq from merge chain in bfq_setup_cooperator()
      block, bfq: don't break merge chain in bfq_split_bfqq()

Yunke Cao (1):
      media: videobuf2-core: clear memory related fields in __vb2_plane_dmabuf_put()

Yuntao Liu (1):
      hwmon: (ntc_thermistor) fix module autoloading

Zhang Rui (1):
      x86/apic: Always explicitly disarm TSC-deadline timer

Zhao Mengmeng (1):
      jfs: Fix uninit-value access of new_ea in ea_buffer

Zheng Wang (1):
      media: venus: fix use after free bug in venus_remove due to race condition

Zhu Jun (1):
      tools/iio: Add memory allocation failure check for trigger_name

Zhu Yanjun (1):
      RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency

Zijun Hu (2):
      driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute
      usb: phy: Fix API devm_usb_put_phy() can not release the phy

Zongmin Zhou (1):
      usbip: tools: Fix detach_port() invalid port error path

j.nixdorf@avm.de (1):
      net: ipv6: ensure we call ipv6_mc_down() at most once

junhua huang (2):
      arm64:uprobe fix the uprobe SWBP_INSN in big-endian
      arm64/uprobes: change the uprobe_opcode_t typedef to fix the sparse warning

yangerkun (1):
      ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard

zhanchengbin (1):
      ext4: fix inode tree inconsistency caused by ENOMEM



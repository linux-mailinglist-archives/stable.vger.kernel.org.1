Return-Path: <stable+bounces-215852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFwlMQ+RjGlQrAAAu9opvQ
	(envelope-from <stable+bounces-215852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:24:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA06125309
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9665308A86D
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E4923817E;
	Wed, 11 Feb 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TnNtnuvp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9474027467E;
	Wed, 11 Feb 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819710; cv=none; b=ZqiLOjbf/pmGMsnYVsnyij/kuc+DPJJ7GoFivJ0nwzFkeMtb2DT4xtEThDPyAPog/zInhdAaNeHbx00bcKZc4V2/CyljSIloFFGLg66gvFHLbKnuhTAN2BEV98t6wfVYnskQ3NRvnndayCaG/srFyXe7elAsZctzZBqkCs1+v7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819710; c=relaxed/simple;
	bh=HLxcesQM6Z4Mb7Svs0fiRVLP5HJFUft34mCTP+btf7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ddr0MRy9qEHKaoojYx6i9wfhbRtm/EHoQdAxKA6AUZrp5Nu0UfFf1nJiHAgG/oAjxaev/KzomRW+JiD19XsOLBnySPt8RqIhwGtOcNVLKUotVD6f3jA/0C3Yu5VcLd79fVHhResHajIEANXJzMfr3MzIxkoOLwaed+RIlNee1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TnNtnuvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198C2C19421;
	Wed, 11 Feb 2026 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770819710;
	bh=HLxcesQM6Z4Mb7Svs0fiRVLP5HJFUft34mCTP+btf7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=TnNtnuvplRArklDLMVWzOK+o8tmKsOP6H6IlG6egAJG6YLgFluBu1S+YDiEzLKAPq
	 lQ0vrkXzuJuaUAJVO6+5HI0Px3GA9s7gKk2RpbV0svET8L/6idkrhWieVQZnMnq2xs
	 DobIpGaOcPUXxoo+Y4zS2UVezUMQowHe5dBzGKws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.70
Date: Wed, 11 Feb 2026 15:21:35 +0100
Message-ID: <2026021136-unmoved-headway-3f66@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215852-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CA06125309
X-Rspamd-Action: no action

I'm announcing the release of the 6.12.70 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/driver-api/gpio/index.rst                    |    2 
 Documentation/translations/zh_CN/driver-api/gpio/index.rst |    2 
 MAINTAINERS                                                |    2 
 Makefile                                                   |    2 
 arch/arm/include/asm/string.h                              |    5 
 arch/loongarch/kernel/traps.c                              |    5 
 arch/loongarch/mm/cache.c                                  |    8 -
 arch/riscv/kernel/traps.c                                  |    4 
 arch/x86/include/asm/kfence.h                              |    7 -
 arch/x86/include/asm/vmware.h                              |    4 
 block/bfq-cgroup.c                                         |    2 
 drivers/android/binder.c                                   |    5 
 drivers/android/binderfs.c                                 |    8 -
 drivers/base/regmap/regcache-maple.c                       |   11 -
 drivers/block/rbd.c                                        |   33 +++--
 drivers/block/ublk_drv.c                                   |   30 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                 |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                    |    3 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c     |    7 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c       |    7 -
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c       |    9 +
 drivers/gpu/drm/mgag200/mgag200_bmc.c                      |   31 +----
 drivers/gpu/drm/mgag200/mgag200_drv.h                      |    6 
 drivers/gpu/drm/xe/xe_pm.c                                 |   17 ++
 drivers/gpu/drm/xe/xe_query.c                              |    2 
 drivers/hid/hid-ids.h                                      |    4 
 drivers/hid/hid-logitech-hidpp.c                           |    2 
 drivers/hid/hid-multitouch.c                               |    1 
 drivers/hid/hid-playstation.c                              |    5 
 drivers/hid/hid-quirks.c                                   |    2 
 drivers/hid/i2c-hid/i2c-hid-core.c                         |    1 
 drivers/hid/intel-ish-hid/ishtp-hid-client.c               |    1 
 drivers/hid/intel-ish-hid/ishtp/bus.c                      |   12 +
 drivers/hwmon/occ/common.c                                 |    1 
 drivers/md/md.c                                            |    4 
 drivers/net/ethernet/adi/adin1110.c                        |    3 
 drivers/net/ethernet/cavium/liquidio/lio_main.c            |   39 +++---
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c         |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c        |   10 +
 drivers/net/ethernet/google/gve/gve_ethtool.c              |   77 ++++++++----
 drivers/net/ethernet/google/gve/gve_main.c                 |    4 
 drivers/net/macvlan.c                                      |    5 
 drivers/net/phy/sfp-bus.c                                  |   79 ++++++++-----
 drivers/net/phy/sfp.c                                      |   51 ++++----
 drivers/net/phy/sfp.h                                      |    4 
 drivers/net/usb/r8152.c                                    |   29 ++--
 drivers/net/usb/sr9700.c                                   |    5 
 drivers/net/wireless/ti/wlcore/tx.c                        |    5 
 drivers/nvme/host/fc.c                                     |    2 
 drivers/nvme/target/tcp.c                                  |   26 +++-
 drivers/pci/bus.c                                          |    3 
 drivers/pci/controller/dwc/pcie-qcom.c                     |    4 
 drivers/pci/pci.c                                          |    3 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c               |    5 
 drivers/platform/x86/intel/int0002_vgpio.c                 |    2 
 drivers/platform/x86/intel/intel_plr_tpmi.c                |    2 
 drivers/platform/x86/intel/telemetry/debugfs.c             |    4 
 drivers/platform/x86/intel/telemetry/pltdrv.c              |    2 
 drivers/platform/x86/toshiba_haps.c                        |    2 
 drivers/pmdomain/imx/gpcv2.c                               |    8 -
 drivers/pmdomain/imx/imx8m-blk-ctrl.c                      |    2 
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c                     |   30 ++++
 drivers/pmdomain/qcom/rpmpd.c                              |    2 
 drivers/spi/spi-hisi-kunpeng.c                             |    4 
 drivers/spi/spi-tegra114.c                                 |    3 
 drivers/spi/spi-tegra20-slink.c                            |    6 
 drivers/spi/spi-tegra210-quad.c                            |   36 +++++
 drivers/target/iscsi/iscsi_target_util.c                   |   10 +
 fs/btrfs/disk-io.c                                         |   13 ++
 fs/btrfs/fs.h                                              |    8 +
 fs/btrfs/inode.c                                           |   16 +-
 fs/ceph/crypto.c                                           |    9 -
 fs/ceph/mds_client.c                                       |    5 
 fs/ceph/mdsmap.c                                           |   26 +++-
 fs/ceph/mdsmap.h                                           |    1 
 fs/ceph/super.h                                            |   16 ++
 fs/hfsplus/dir.c                                           |    2 
 fs/hfsplus/hfsplus_fs.h                                    |    8 -
 fs/hfsplus/unicode.c                                       |   24 +++
 fs/hfsplus/xattr.c                                         |    6 
 fs/proc/task_mmu.c                                         |   42 ++++--
 fs/smb/client/smb2file.c                                   |    1 
 fs/smb/server/smb2pdu.c                                    |    8 -
 include/linux/buildid.h                                    |    3 
 include/linux/ceph/ceph_fs.h                               |    6 
 include/linux/phy.h                                        |   10 +
 include/linux/sfp.h                                        |   22 +++
 include/linux/skbuff.h                                     |   12 +
 kernel/trace/ring_buffer.c                                 |    2 
 kernel/trace/trace.h                                       |    7 -
 kernel/trace/trace_entries.h                               |   26 ++--
 kernel/trace/trace_export.c                                |   21 ++-
 lib/buildid.c                                              |   42 ++++--
 mm/shmem.c                                                 |   23 ++-
 mm/slub.c                                                  |    6 
 net/bridge/netfilter/ebtables.c                            |    2 
 net/core/filter.c                                          |    8 -
 net/core/gro.c                                             |    2 
 net/ipv6/ip6_fib.c                                         |    3 
 net/mac80211/iface.c                                       |    8 -
 net/mac80211/key.c                                         |    3 
 net/mac80211/ocb.c                                         |    3 
 net/mac80211/sta_info.c                                    |    7 -
 net/netfilter/nf_log.c                                     |    4 
 net/netfilter/nf_tables_api.c                              |    2 
 net/netfilter/x_tables.c                                   |    2 
 net/sched/cls_u32.c                                        |   13 --
 net/tipc/crypto.c                                          |    4 
 net/wireless/util.c                                        |    8 -
 sound/drivers/aloop.c                                      |   62 +++++-----
 sound/pci/hda/patch_realtek.c                              |   27 ++++
 sound/soc/amd/renoir/acp3x-pdm-dma.c                       |    2 
 sound/soc/amd/yc/acp6x-mach.c                              |    7 +
 sound/soc/codecs/tlv320adcx140.c                           |    3 
 sound/soc/generic/simple-card-utils.c                      |    4 
 sound/soc/ti/davinci-evm.c                                 |   39 +++++-
 sound/usb/mixer_quirks.c                                   |    9 -
 tools/power/x86/turbostat/turbostat.c                      |   15 --
 tools/testing/selftests/kvm/Makefile                       |    1 
 virt/kvm/eventfd.c                                         |   44 +++----
 120 files changed, 944 insertions(+), 422 deletions(-)

Andrew Cooper (1):
      x86/kfence: fix booting on 32bit non-PAE systems

Andrew Fasano (1):
      netfilter: nf_tables: fix inverted genmask check in nft_map_catchall_activate()

Andrii Nakryiko (1):
      procfs: avoid fetching build ID while holding VMA lock

Andy Shevchenko (1):
      gpiolib-acpi: Update file references in the Documentation and MAINTAINERS

Arnd Bergmann (1):
      hwmon: (occ) Mark occ_init_attribute() as __printf

Baochen Qiang (1):
      wifi: mac80211: collect station statistics earlier when disconnect

Bert Karwatzki (1):
      Revert "drm/amd: Check if ASPM is enabled from PCIe subsystem"

Breno Leitao (5):
      spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed transfer
      spi: tegra210-quad: Move curr_xfer read inside spinlock
      spi: tegra210-quad: Protect curr_xfer assignment in tegra_qspi_setup_transfer_one
      spi: tegra210-quad: Protect curr_xfer in tegra_qspi_combined_seq_xfer
      spi: tegra210-quad: Protect curr_xfer clearing in tegra_qspi_non_combined_seq_xfer

Carlos Llamas (2):
      binder: fix BR_FROZEN_REPLY error log
      binderfs: fix ida_alloc_max() upper bound

Chaitanya Kulkarni (1):
      nvme-fc: release admin tagset if init fails

Chen Ni (1):
      net: ethernet: adi: adin1110: Check return value of devm_gpiod_get_optional() in adin1110_check_spi()

ChenXiaoSong (1):
      smb/client: fix memory leak in smb2_open_file()

Chenghao Duan (1):
      LoongArch: Enable exception fixup for specific ADE subcode

Chris Bainbridge (1):
      ASoC: amd: fix memory leak in acp3x pdm dma ops

Chris Chiu (1):
      HID: quirks: Add another Chicony HP 5MP Cameras to hid_ignore_list

Daniel Gomez (1):
      netfilter: replace -EEXIST with -EBUSY

Daniel Hodges (1):
      tipc: use kfree_sensitive() for session key material

Daniel Vogelbacher (1):
      ceph: fix oops due to invalid pointer for kfree() in parse_longname()

DaytonCL (1):
      HID: multitouch: add MT_QUIRK_STICKY_FINGERS to MT_CLS_VTL

Debarghya Kundu (1):
      gve: Fix stats report corruption on queue count change

Dennis Marttinen (1):
      HID: logitech: add HID++ support for Logitech MX Anywhere 3S

Devyn Liu (1):
      spi: hisi-kunpeng: Fixed the wrong debugfs node name in hisi_spi debugfs initialization

Dimitrios Katsaros (1):
      ASoC: tlv320adcx140: Propagate error codes during probe

Eric Dumazet (3):
      net: add skb_header_pointer_careful() helper
      net/sched: cls_u32: use skb_header_pointer_careful()
      macvlan: fix error recovery in macvlan_common_newlink()

Ethan Nelson-Moore (1):
      net: usb: sr9700: support devices with virtual driver CD

Felix Gu (1):
      spi: tegra: Fix a memory leak in tegra_slink_probe()

FengWei Shih (1):
      md: suspend array while updating raid_disks via sysfs

Filipe Manana (1):
      btrfs: fix reservation leak in some error paths when inserting inline extent

Gabor Juhos (1):
      pmdomain: qcom: rpmpd: fix off-by-one error in clamping to the highest state

Greg Kroah-Hartman (1):
      Linux 6.12.70

Hannes Reinecke (1):
      nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()

Hao Ge (1):
      mm/slab: Add alloc_tagging_slab_free_hook for memcg_alloc_abort_single

Huacai Chen (1):
      LoongArch: Set correct protection_map[] for VM_NONE/VM_SHARED

Ilya Dryomov (1):
      rbd: check for EOD after exclusive lock is ensured to be held

Jacky Bai (1):
      pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to wrong adb400 reset

Jacob Keller (1):
      drm/mgag200: fix mgag200_bmc_stop_scanout()

Jakub Kicinski (1):
      net: don't touch dev->stats in BPF redirect paths

Josh Poimboeuf (1):
      x86/vmware: Fix hypercall clobbers

Junrui Luo (2):
      dpaa2-switch: prevent ZERO_SIZE_PTR dereference when num_ifs is zero
      dpaa2-switch: add bounds check for if_id in IRQ handler

Kairui Song (1):
      mm, shmem: prevent infinite loop on truncate race

Kang Chen (1):
      hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()

Karthik Poosa (1):
      drm/xe/pm: Disable D3Cold for BMG only on specific platforms

Kaushlendra Kumar (3):
      platform/x86: intel_telemetry: Fix swapped arrays in PSS output
      regmap: maple: free entry on mas_store_gfp() failure
      platform/x86: intel_telemetry: Fix PSS event register mask

Kery Qi (1):
      ASoC: davinci-evm: Fix reference leak in davinci_evm_probe

Kwok Kin Ming (1):
      HID: i2c-hid: fix potential buffer overflow in i2c_hid_get_report()

Lukas Gerlach (1):
      riscv: Sanitize syscall table indexing under speculation

Lukas Wunner (1):
      PCI/ERR: Ensure error recoverability at all times

Manivannan Sadhasivam (1):
      PCI: qcom: Remove ASPM L0s support for MSM8996 SoC

Marek Behún (1):
      net: sfp: Fix quirk for Ubiquiti U-Fiber Instant SFP module

Mario Limonciello (1):
      platform/x86: hp-bioscfg: Skip empty attribute names

Martin Hamilton (1):
      ALSA: hda/realtek: ALC269 fixup for Lenovo Yoga Book 9i 13IRU8 audio

Matouš Lánský (1):
      ALSA: hda/realtek: Add quirk for Acer Nitro AN517-55

Maurizio Lombardi (2):
      scsi: target: iscsi: Fix use-after-free in iscsit_dec_session_usage_count()
      scsi: target: iscsi: Fix use-after-free in iscsit_dec_conn_usage_count()

Max Yuan (1):
      gve: Correct ethtool rx_dropped calculation

Melissa Wen (1):
      drm/amd/display: fix wrong color value mapping on MCM shaper LUT

Ming Lei (1):
      ublk: fix deadlock when reading partition table

Miri Korenblit (2):
      wifi: mac80211: correctly check if CSA is active
      wifi: mac80211: don't increment crypto_tx_tailroom_needed_cnt twice

Moon Hee Lee (1):
      wifi: mac80211: ocb: skip rx_no_sta when interface is not joined

Paolo Abeni (1):
      net: gro: fix outer network offset

Perry Yuan (1):
      drm/amd/pm: Disable MMIO access during SMU Mode 1 reset

Peter Åstrand (1):
      wifi: wlcore: ensure skb headroom before skb_push

Qu Wenruo (1):
      btrfs: reject new transactions if the fs is fully read-only

Radhi Bajahaw (1):
      ASoC: amd: yc: Fix microphone on ASUS M6500RE

Rafael J. Wysocki (1):
      platform/x86: toshiba_haps: Fix memory leaks in add/remove routines

Ricardo Neri (1):
      platform/x86/intel/tpmi/plr: Make the file domain<n>/status writeable

Rodrigo Lugathe da Conceição Alves (1):
      HID: Apply quirk HID_QUIRK_ALWAYS_POLL to Edifier QR30 (2d99:a101)

Rodrigo Vivi (1):
      drm/xe/pm: Also avoid missing outer rpm warning on system suspend

Ruslan Krupitsa (1):
      ALSA: hda/realtek: add HP Laptop 15s-eq1xxx mute LED quirk

Russell King (Oracle) (4):
      net: phy: add phy_interface_weight()
      net: phy: add phy_interface_copy()
      net: sfp: pre-parse the module support
      net: sfp: convert sfp quirks to modify struct sfp_module_support

Sean Christopherson (1):
      KVM: Don't clobber irqfd routing type when deassigning irqfd

Sergey Senozhatsky (1):
      net: usb: r8152: fix resume reset deadlock

Sergey Shtylyov (1):
      ALSA: usb-audio: fix broken logic in snd_audigy2nx_led_update()

Shengjiu Wang (1):
      ASoC: simple-card-utils: Check device node before overwrite direction

Shigeru Yoshida (1):
      ipv6: Fix ECMP sibling count mismatch when clearing RTF_ADDRCONF

Shuicheng Lin (1):
      drm/xe/query: Fix topology query pointer advance

Siarhei Vishniakou (1):
      HID: playstation: Center initial joystick axes to prevent spurious events

Steven Rostedt (1):
      tracing: Fix ftrace event field alignments

Takashi Iwai (1):
      ALSA: aloop: Fix racy access at PCM trigger

Thomas Weissschuh (1):
      ARM: 9468/1: fix memset64() on big-endian

Tim Guttzeit (1):
      ALSA: hda/realtek: Fix headset mic for TongFang X6AR55xU

Todd Brandt (1):
      tools/power turbostat: fix GCC9 build regression

Veerendranath Jakkam (1):
      wifi: cfg80211: Fix bitrate calculation overflow for HE rates

Viacheslav Dubeyko (1):
      ceph: fix NULL pointer dereference in ceph_mds_auth_match()

Vishwaroop A (1):
      spi: tegra114: Preserve SPI mode bits in def_command1_reg

Werner Sembach (1):
      ALSA: hda/realtek: Really fix headset mic for TongFang X6AR55xU.

Wupeng Ma (1):
      ring-buffer: Avoid softlockup in ring_buffer_resize() during memory free

Xu Yang (3):
      pmdomain: imx8mp-blk-ctrl: Keep gpc power domain on for system wakeup
      pmdomain: imx8mp-blk-ctrl: Keep usb phy power domain on for system wakeup
      pmdomain: imx8m-blk-ctrl: fix out-of-range access of bc->domains

YunJe Shin (1):
      nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec

Zhang Lixu (2):
      HID: intel-ish-hid: Update ishtp bus match to support device ID table
      HID: intel-ish-hid: Reset enum_devices_done before enumeration

ZhangGuoDong (3):
      smb/server: call ksmbd_session_rpc_close() on error path in create_smb2_pipe()
      smb/server: fix refcount leak in smb2_open()
      smb/server: fix refcount leak in parse_durable_handle_context()

Zhiquan Li (1):
      KVM: selftests: Add -U_FORTIFY_SOURCE to avoid some unpredictable test failures

Zilin Guan (3):
      net: liquidio: Initialize netdev pointer before queue setup
      net: liquidio: Fix off-by-one error in PF setup_nic_devices() cleanup
      net: liquidio: Fix off-by-one error in VF setup_nic_devices() cleanup

shechenglong (1):
      block,bfq: fix aux stat accumulation destination



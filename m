Return-Path: <stable+bounces-197705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7B9C96CED
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE5AD4E14FA
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAD23064A6;
	Mon,  1 Dec 2025 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tZ5NpEZK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED02DF14A;
	Mon,  1 Dec 2025 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587350; cv=none; b=XC0Z8bE0NNBpRgbsu916rvtUykpP3+UW/f+y4oxMA2GsP1/vGLE1GFH7+Uw555YzxmpsKwQuNi50PG52c8RYFNaSKclRYpcWP2O2y+w81qCged7pWuWeVAri1rqM/yYg7WBuu/Fmke3viCljVs4474hWYXATuU5HB9zB5Ba9Ofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587350; c=relaxed/simple;
	bh=bMVkt3Wyws0RXSc3tKjcREugImd8qV8NhEw2q4eblO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MwqWtKV40jJud4mQRbCe0OWSZ4rJVM2W5f5V/0makBg0WXsxKu/CadfQK125Ob26Q6v9k7XHvbMFVCnw4YJ/8wzxT8dHlGkAAhrazz+b/DpXQWoO77J1e+URQR+CqliG0emrqOFhbzrWJ+vd6zUycc7R6JKOwKsZC3ywxfVy6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tZ5NpEZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4F8C4CEF1;
	Mon,  1 Dec 2025 11:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764587349;
	bh=bMVkt3Wyws0RXSc3tKjcREugImd8qV8NhEw2q4eblO0=;
	h=From:To:Cc:Subject:Date:From;
	b=tZ5NpEZKVhdcW9c2bOa7i7FY3MvO58M8HyeBFYXRfe9W07jd/GCFLwQF/iop6Pef+
	 8ZDI6S73v9kPw/Yz7UXZgYj/WA6pItWtXDYR7+IHmQeHUI+3xh4IJLDu1k52ovCFea
	 f2sEIqKu5bqdi9NAvyxkpttrcQ1XQr2c6+ztKL74=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.118
Date: Mon,  1 Dec 2025 12:09:04 +0100
Message-ID: <2025120105-eaten-fastness-6bfe@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.118 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml |   26 +--
 Makefile                                                                |    2 
 arch/arm64/kvm/hyp/nvhe/ffa.c                                           |    9 -
 arch/loongarch/include/uapi/asm/ptrace.h                                |   40 ++---
 arch/loongarch/pci/pci.c                                                |    8 -
 arch/mips/mti-malta/malta-init.c                                        |   20 +-
 arch/s390/include/asm/pgtable.h                                         |   12 -
 arch/s390/mm/pgtable.c                                                  |    4 
 arch/x86/kernel/cpu/microcode/amd.c                                     |   20 ++
 drivers/ata/libata-scsi.c                                               |   11 +
 drivers/bcma/main.c                                                     |    6 
 drivers/firmware/arm_scmi/scmi_pm_domain.c                              |   13 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                  |    4 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c      |   11 -
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c                                |    2 
 drivers/gpu/drm/tegra/dc.c                                              |    1 
 drivers/gpu/drm/tegra/dsi.c                                             |    9 -
 drivers/gpu/drm/tegra/uapi.c                                            |    7 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c                           |    2 
 drivers/hid/hid-ids.h                                                   |    4 
 drivers/hid/hid-quirks.c                                                |   13 +
 drivers/input/keyboard/cros_ec_keyb.c                                   |    6 
 drivers/input/keyboard/imx_sc_key.c                                     |    2 
 drivers/input/tablet/pegasus_notetaker.c                                |    9 +
 drivers/input/touchscreen/goodix.c                                      |    1 
 drivers/mtd/mtdchar.c                                                   |    6 
 drivers/mtd/nand/raw/cadence-nand-controller.c                          |    3 
 drivers/net/dsa/hirschmann/hellcreek_ptp.c                              |   14 +
 drivers/net/dsa/microchip/lan937x_main.c                                |    1 
 drivers/net/ethernet/emulex/benet/be_main.c                             |    7 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c                       |    6 
 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c                    |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c                   |    6 
 drivers/net/ethernet/qlogic/qede/qede_fp.c                              |    5 
 drivers/net/ethernet/ti/netcp_core.c                                    |   10 -
 drivers/nvme/host/fc.c                                                  |   15 +-
 drivers/nvme/host/multipath.c                                           |    2 
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c                                |   23 ++-
 drivers/pinctrl/nxp/pinctrl-s32cc.c                                     |    3 
 drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c               |    4 
 drivers/pmdomain/imx/gpc.c                                              |   22 +-
 drivers/s390/net/ctcm_mpc.c                                             |    1 
 drivers/scsi/hosts.c                                                    |    5 
 drivers/scsi/sg.c                                                       |   10 +
 drivers/soc/ti/knav_dma.c                                               |   14 -
 drivers/target/loopback/tcm_loop.c                                      |    3 
 drivers/uio/uio_hv_generic.c                                            |   21 ++
 fs/exfat/super.c                                                        |    5 
 fs/f2fs/compress.c                                                      |   74 +++++-----
 fs/f2fs/f2fs.h                                                          |    2 
 fs/smb/client/cached_dir.c                                              |   43 +++++
 fs/smb/client/cifsfs.c                                                  |    2 
 fs/smb/client/fs_context.c                                              |    4 
 include/linux/array_size.h                                              |   13 +
 include/linux/ata.h                                                     |    1 
 include/linux/kernel.h                                                  |    7 
 include/linux/string.h                                                  |    1 
 include/net/tls.h                                                       |    6 
 include/net/xfrm.h                                                      |    3 
 kernel/bpf/trampoline.c                                                 |    4 
 kernel/kexec_core.c                                                     |    2 
 kernel/time/timer.c                                                     |    7 
 kernel/trace/ftrace.c                                                   |   20 +-
 lib/maple_tree.c                                                        |   32 ++--
 mm/mempool.c                                                            |   32 +++-
 mm/shmem.c                                                              |   15 --
 net/devlink/rate.c                                                      |    4 
 net/ipv4/esp4_offload.c                                                 |    6 
 net/ipv6/esp6_offload.c                                                 |    6 
 net/mptcp/options.c                                                     |   54 +++++++
 net/mptcp/pm_netlink.c                                                  |   20 +-
 net/mptcp/protocol.c                                                    |   48 ++++--
 net/mptcp/protocol.h                                                    |    3 
 net/mptcp/subflow.c                                                     |    8 +
 net/openvswitch/actions.c                                               |   68 ---------
 net/openvswitch/flow_netlink.c                                          |   64 +-------
 net/openvswitch/flow_netlink.h                                          |    2 
 net/tls/tls_device.c                                                    |    4 
 net/vmw_vsock/af_vsock.c                                                |   40 ++++-
 net/wireless/reg.c                                                      |    5 
 net/xfrm/xfrm_output.c                                                  |    6 
 scripts/kconfig/mconf.c                                                 |    3 
 scripts/kconfig/nconf.c                                                 |    3 
 sound/usb/mixer.c                                                       |    2 
 tools/testing/selftests/net/bareudp.sh                                  |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                         |    8 -
 tools/tracing/latency/latency-collector.c                               |    2 
 87 files changed, 650 insertions(+), 406 deletions(-)

Alejandro Colomar (1):
      kernel.h: Move ARRAY_SIZE() to a separate header

Aleksei Nikiforov (1):
      s390/ctcm: Fix double-kfree

Alexander Wetzel (1):
      wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()

Andrey Vatoropin (1):
      be2net: pass wrb_params in case of OS2BMC

Bart Van Assche (2):
      scsi: sg: Do not sleep in atomic context
      scsi: core: Fix a regression triggered by scsi_host_busy()

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Limit Entrysign signature checking to known generations

Dan Carpenter (2):
      mtdchar: fix integer overflow in read/write ioctls
      Input: imx_sc_key - fix memory corruption on unload

Diogo Ivo (1):
      Revert "drm/tegra: dsi: Clear enable register if powered by bootloader"

Eric Dumazet (2):
      mptcp: fix race condition in mptcp_schedule_work()
      mptcp: fix a race in mptcp_pm_del_add_timer()

Ewan D. Milne (2):
      nvme: nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
      nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()

Fabio M. De Francesco (1):
      mm/mempool: replace kmap_atomic() with kmap_local_page()

Greg Kroah-Hartman (1):
      Linux 6.6.118

Hamza Mahfooz (1):
      scsi: target: tcm_loop: Fix segfault in tcm_loop_tpg_address_show()

Hans de Goede (1):
      Input: goodix - add support for ACPI ID GDIX1003

Haotian Zhang (2):
      pinctrl: cirrus: Fix fwnode leak in cs42l43_pin_probe()
      platform/x86/intel/speed_select_if: Convert PCIBIOS_* return codes to errnos

Heiko Carstens (1):
      s390/mm: Fix __ptep_rdp() inline assembly

Henrique Carvalho (2):
      smb: client: introduce close_cached_dir_locked()
      smb: client: fix incomplete backport in cfids_invalidation_worker()

Huacai Chen (1):
      LoongArch: Don't panic if no valid cache info for PCI

Ilya Maximets (1):
      net: openvswitch: remove never-working support for setting nsh fields

Jakub Horký (2):
      kconfig/mconf: Initialize the default locale at startup
      kconfig/nconf: Initialize the default locale at startup

Jared Kangas (2):
      pinctrl: s32cc: fix uninitialized memory in s32_pinctrl_desc
      pinctrl: s32cc: initialize gpio_pin_config::list after kmalloc()

Jianbo Liu (2):
      xfrm: Determine inner GSO type from packet inner protocol
      xfrm: Prevent locally generated packets from direct output in tunnel mode

Jiayuan Chen (2):
      mptcp: Disallow MPTCP subflows from sockmap
      mptcp: Fix proto fallback detection with BPF

Krzysztof Kozlowski (1):
      dt-bindings: pinctrl: toshiba,visconti: Fix number of items in groups

Long Li (1):
      uio_hv_generic: Set event for all channels on the device

Ma Ke (1):
      drm/tegra: dc: Fix reference leak in tegra_dc_couple()

Maciej W. Rozycki (1):
      MIPS: Malta: Fix !EVA SOC-it PCI MMIO

Mario Limonciello (AMD) (3):
      drm/amd/display: Increase DPCD read retries
      drm/amd/display: Move sleep into each retry for retrieve_link_cap()
      HID: amd_sfh: Stop sensor before starting

Martin Kaiser (1):
      maple_tree: fix tracepoint string pointers

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: join: endpoints: longer transfer

Miaoqian Lin (1):
      pmdomain: imx: Fix reference count leak in imx_gpc_remove

Michal Luczaj (1):
      vsock: Ignore signal/timeout on connect() if already established

Mike Yuan (1):
      shmem: fix tmpfs reconfiguration (remount) when noswap is set

Nam Cao (1):
      nouveau/firmware: Add missing kfree() of nvkm_falcon_fw::boot

Niklas Cassel (1):
      ata: libata-scsi: Fix system suspend for a security locked drive

Niravkumar L Rabara (1):
      mtd: rawnand: cadence: fix DMA device NULL pointer dereference

Nishanth Menon (1):
      net: ethernet: ti: netcp: Standardize knav_dma_open_channel to return NULL on error

Oleksij Rempel (1):
      net: dsa: microchip: lan937x: Fix RGMII delay tuning

Paolo Abeni (5):
      mptcp: fix ack generation for fallback msk
      mptcp: fix premature close in case of fallback
      mptcp: avoid unneeded subflow-level drops
      mptcp: decouple mptcp fastclose from tcp close
      mptcp: do not fallback when OoO is present

Pavel Zhigulin (3):
      net: dsa: hellcreek: fix missing error handling in LED registration
      net: mlxsw: linecards: fix missing error check in mlxsw_linecard_devlink_info_get()
      net: qlogic/qede: fix potential out-of-bounds read in qede_tpa_cont() and qede_tpa_end()

Po-Hsu Lin (1):
      selftests: net: use BASH for bareudp testing

Pradyumn Rahar (1):
      net/mlx5: Clean up only new IRQ glue on request_irq() failure

Prateek Agarwal (1):
      drm/tegra: Add call to put_pid()

Rafał Miłecki (1):
      bcma: don't register devices disabled in OF

René Rebe (1):
      ALSA: usb-audio: fix uac2 clock source at terminal parser

Sebastian Ene (1):
      KVM: arm64: Check the untrusted offset in FF-A memory share

Seungjin Bae (1):
      Input: pegasus-notetaker - fix potential out-of-bounds access

Shahar Shitrit (1):
      net: tls: Cancel RX async resync request on rcd_delta overflow

Shaurya Rane (1):
      cifs: fix memory leak in smb3_fs_context_parse_param error path

Shay Drory (1):
      devlink: rate: Unset parent pointer in devl_rate_nodes_destroy

Shin'ichiro Kawasaki (1):
      nvme-multipath: fix lockdep WARN due to partition scan work

Song Liu (1):
      ftrace: Fix BPF fexit with livepatch

Sourabh Jain (1):
      crash: fix crashkernel resource shrink

Steve French (1):
      cifs: fix typo in enable_gcm_256 module parameter

Sudeep Holla (1):
      pmdomain: arm: scmi: Fix genpd leak on provider registration failure

Thomas Weißschuh (1):
      LoongArch: Use UAPI types in ptrace UAPI header

Tzung-Bi Shih (1):
      Input: cros_ec_keyb - fix an invalid memory access

Uwe Kleine-König (1):
      pmdomain: imx-gpc: Convert to platform remove callback returning void

Vlastimil Babka (1):
      mm/mempool: fix poisoning order>0 pages with HIGHMEM

Yifan Zha (1):
      drm/amdgpu: Skip emit de meta data on gfx11 with rs64 enabled

Yihang Li (1):
      ata: libata-scsi: Add missing scsi_device_put() in ata_scsi_dev_rescan()

Yipeng Zou (1):
      timers: Fix NULL function pointer race in timer_shutdown_sync()

Yongpeng Yang (1):
      exfat: check return value of sb_min_blocksize in exfat_read_boot_sector

Zhang Chujun (1):
      tracing/tools: Fix incorrcet short option in usage text for --threads

Zhang Heng (1):
      HID: quirks: work around VID/PID conflict for 0x4c4a/0x4155

Zhiguo Niu (2):
      f2fs: compress: change the first parameter of page_array_{alloc,free} to sbi
      f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic

Zilin Guan (1):
      mlxsw: spectrum: Fix memory leak in mlxsw_sp_flower_stats()



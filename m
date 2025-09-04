Return-Path: <stable+bounces-177753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF62B44016
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37051C84F43
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B13126DB;
	Thu,  4 Sep 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nrGQB3Hv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD033126D1;
	Thu,  4 Sep 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998658; cv=none; b=PXo8HgE2rdG5R3JJ6DNCjgIyqrsxEESSxn6DNirjTT+/lAFK0jAs7SHWADyXtfXrhOw5ukzCOXBLdTnVlVW7XNcDO36dGtuNDgPQiUWZwOnRqDQxJpUDBPg3nemuoq7DARXT9pvgPl0eN1mSsMwXlcQq/bQ0EP5+1f84qhOA6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998658; c=relaxed/simple;
	bh=s6V5DssxxrjBAke7IgsivDDbbaZqczvmKPe8MqV5cgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LVgGQEvsj9AixSFixU6oKjEW+dCR3/6ruWy+FkKgudOnLOgko4CWoRT2ffWb4XITl/lJdPbDdZI78W3XOZSraAUw8t3OTf6prNU1j6eqrVz7EN6r/kAcmavScmsmdECv+A4JnNsXeLoruBuM6xIzvMfVublIeVD5CzNEA7+gt9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nrGQB3Hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24D7C4CEF0;
	Thu,  4 Sep 2025 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756998658;
	bh=s6V5DssxxrjBAke7IgsivDDbbaZqczvmKPe8MqV5cgI=;
	h=From:To:Cc:Subject:Date:From;
	b=nrGQB3HvpUDAgecQPLLvnLbSeq+EbGOaeJhNwzYw6kJerZ0DGrqMtiqFDvfSN4Sxt
	 wVnMA2vki/Hu7lWE4eHEJqJA0WsreU5C36eqvdEhVKCrMUb9aVQ9CS4Z0NCx1IpchC
	 Bw9t7uoiszGAkKGa+IQbBwA2Ii9VRbsUIBI56JJw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.104
Date: Thu,  4 Sep 2025 17:10:41 +0200
Message-ID: <2025090442-rewire-elliptic-52ed@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.104 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml |    1 
 Makefile                                                     |    2 
 arch/mips/boot/dts/lantiq/danube_easy50712.dts               |    5 
 arch/mips/lantiq/xway/sysctrl.c                              |   10 
 arch/powerpc/kernel/kvm.c                                    |    8 
 arch/x86/kernel/cpu/microcode/amd.c                          |   22 +
 arch/x86/kvm/lapic.c                                         |    2 
 arch/x86/kvm/x86.c                                           |    7 
 drivers/acpi/ec.c                                            |    6 
 drivers/atm/atmtcp.c                                         |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                      |    4 
 drivers/gpu/drm/display/drm_dp_helper.c                      |    2 
 drivers/gpu/drm/msm/msm_gem_submit.c                         |   14 
 drivers/gpu/drm/nouveau/dispnv50/wndw.c                      |    4 
 drivers/gpu/drm/nouveau/nvkm/falcon/gm200.c                  |   15 
 drivers/hid/hid-asus.c                                       |    8 
 drivers/hid/hid-ids.h                                        |    3 
 drivers/hid/hid-input-test.c                                 |   10 
 drivers/hid/hid-input.c                                      |   51 +-
 drivers/hid/hid-logitech-dj.c                                |    4 
 drivers/hid/hid-logitech-hidpp.c                             |    2 
 drivers/hid/hid-mcp2221.c                                    |   71 ++--
 drivers/hid/hid-multitouch.c                                 |    8 
 drivers/hid/hid-ntrig.c                                      |    3 
 drivers/hid/hid-quirks.c                                     |    2 
 drivers/hid/wacom_wac.c                                      |    1 
 drivers/net/ethernet/dlink/dl2k.c                            |    2 
 drivers/net/ethernet/intel/ice/ice_txrx.c                    |   94 +++--
 drivers/net/ethernet/intel/ice/ice_txrx.h                    |   19 -
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h                |   53 ---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c     |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h     |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c            |   19 +
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c           |  190 +++++++----
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/main.c               |    3 
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c         |   87 ++---
 drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h              |    6 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c            |    8 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c          |   13 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c           |    9 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                   |    8 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c            |   12 
 drivers/net/phy/mscc/mscc.h                                  |    4 
 drivers/net/phy/mscc/mscc_main.c                             |    4 
 drivers/net/phy/mscc/mscc_ptp.c                              |   34 +
 drivers/net/usb/qmi_wwan.c                                   |    3 
 drivers/of/dynamic.c                                         |   29 -
 drivers/of/of_private.h                                      |    1 
 drivers/of/overlay.c                                         |   11 
 drivers/of/unittest.c                                        |   12 
 drivers/pinctrl/Kconfig                                      |    1 
 drivers/scsi/scsi_sysfs.c                                    |    4 
 drivers/vhost/net.c                                          |    9 
 fs/efivarfs/super.c                                          |    4 
 fs/erofs/zdata.c                                             |   13 
 fs/nfs/pagelist.c                                            |   86 ----
 fs/nfs/write.c                                               |  146 +++++---
 fs/smb/client/cifsfs.c                                       |   14 
 fs/smb/client/inode.c                                        |   34 +
 fs/smb/client/smb2inode.c                                    |    7 
 fs/xfs/libxfs/xfs_attr_remote.c                              |    7 
 fs/xfs/libxfs/xfs_da_btree.c                                 |    6 
 include/linux/atmdev.h                                       |    1 
 include/linux/mlx5/mlx5_ifc.h                                |   11 
 include/linux/nfs_page.h                                     |    2 
 include/net/bluetooth/hci_sync.h                             |    2 
 include/net/rose.h                                           |   18 -
 kernel/dma/pool.c                                            |    4 
 kernel/trace/trace.c                                         |    4 
 net/atm/common.c                                             |   15 
 net/bluetooth/hci_event.c                                    |   20 +
 net/bluetooth/hci_sync.c                                     |    6 
 net/bluetooth/mgmt.c                                         |    5 
 net/ipv4/route.c                                             |   10 
 net/rose/af_rose.c                                           |   13 
 net/rose/rose_in.c                                           |   12 
 net/rose/rose_route.c                                        |   62 ++-
 net/rose/rose_timer.c                                        |    2 
 net/sctp/ipv6.c                                              |    2 
 sound/soc/codecs/lpass-tx-macro.c                            |    2 
 82 files changed, 890 insertions(+), 553 deletions(-)

Aleksander Jan Bajkowski (2):
      mips: dts: lantiq: danube: add missing burst length property
      mips: lantiq: xway: sysctrl: rename the etop node

Alex Deucher (1):
      Revert "drm/amdgpu: fix incorrect vm flags to map bo"

Alexei Lazar (3):
      net/mlx5e: Update and set Xon/Xoff upon MTU set
      net/mlx5e: Update and set Xon/Xoff upon port speed set
      net/mlx5e: Set local Xoff after FW update

Alexey Klimov (1):
      ASoC: codecs: tx-macro: correct tx_macro_component_drv name

Antheas Kapenekakis (1):
      HID: quirks: add support for Legion Go dual dinput modes

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Handle the case of no BIOS microcode

Chris Mi (1):
      net/mlx5: SF, Fix add port error handling

Christoph Hellwig (1):
      nfs: fold nfs_page_group_lock_subrequests into nfs_lock_and_join_requests

Damien Le Moal (1):
      scsi: core: sysfs: Correct sysfs attributes access rights

Dan Carpenter (1):
      of: dynamic: Fix use after free in of_changeset_add_prop_helper()

Dmitry Baryshkov (1):
      dt-bindings: display/msm: qcom,mdp5: drop lut clock

Eric Dumazet (2):
      sctp: initialize more fields in sctp_v6_from_sk()
      net: rose: fix a typo in rose_clear_routes()

Eric Sandeen (1):
      xfs: do not propagate ENODATA disk errors into xattr code

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion LE910C4-WWX new compositions

Greg Kroah-Hartman (1):
      Linux 6.6.104

Hamish Martin (2):
      HID: mcp2221: Don't set bus speed on every transfer
      HID: mcp2221: Handle reads greater than 60 bytes

Horatiu Vultur (1):
      phy: mscc: Fix when PTP clock is register and unregister

Imre Deak (1):
      Revert "drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS"

James Jones (1):
      drm/nouveau/disp: Always accept linear modifier

Jiri Pirko (3):
      net/mlx5: Call mlx5_sf_id_erase() once in mlx5_sf_dealloc()
      net/mlx5: Use devlink port pointer to get the pointer of container SF struct
      net/mlx5: Convert SF port_indices xarray to function_ids xarray

José Expósito (2):
      HID: input: rename hidinput_set_battery_charge_status()
      HID: input: report battery status changes immediately

Junli Liu (1):
      erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC

Kuniyuki Iwashima (1):
      atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().

Larysa Zaremba (1):
      ice: Introduce ice_xdp_buff

Li Nan (1):
      efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare

Lizhi Hou (1):
      of: dynamic: Fix memleak when of_pci_add_properties() failed

Ludovico de Nittis (2):
      Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
      Bluetooth: hci_event: Mark connection as closed during suspend disconnect

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced

Maciej Fijalkowski (2):
      ice: gather page_count()'s of each frag right before XDP prog call
      ice: stop storing XDP verdict within ice_rx_buf

Madhavan Srinivasan (1):
      powerpc/kvm: Fix ifdef to remove build warning

Matt Coffin (1):
      HID: logitech: Add ids for G PRO 2 LIGHTSPEED

Michal Kubiak (1):
      ice: fix incorrect counter for buffer allocation failures

Minjong Kim (1):
      HID: hid-ntrig: fix unable to handle page fault in ntrig_report_version()

Moshe Shemesh (5):
      net/mlx5: Reload auxiliary drivers on fw_activate
      net/mlx5: Add device cap for supporting hot reset in sync reset flow
      net/mlx5: Add support for sync reset using hot reset
      net/mlx5: Fix lockdep assertion on sync reset unload event
      net/mlx5: Nack sync reset when SFs are present

Nikolay Kuratov (1):
      vhost/net: Protect ubufs with rcu read lock in vhost_net_ubuf_put()

Oscar Maes (1):
      net: ipv4: fix regression in local-broadcast routes

Paulo Alcantara (2):
      smb: client: fix race with concurrent opens in unlink(2)
      smb: client: fix race with concurrent opens in rename(2)

Pavel Shpakovskiy (1):
      Bluetooth: hci_sync: fix set_local_name race condition

Ping Cheng (1):
      HID: wacom: Add a new Art Pen 2

Qasim Ijaz (2):
      HID: asus: fix UAF via HID_CLAIMED_INPUT validation
      HID: multitouch: fix slab out-of-bounds access in mt_report_fixup()

Randy Dunlap (1):
      pinctrl: STMFX: add missing HAS_IOMEM dependency

Rob Clark (1):
      drm/msm: Defer fd_install in SUBMIT ioctl

Rob Herring (1):
      of: Add a helper to free property struct

Rohan G Thomas (3):
      net: stmmac: xgmac: Do not enable RX FIFO Overflow interrupts
      net: stmmac: xgmac: Correct supported speed modes
      net: stmmac: Set CIC bit only for TX queues with COE

Serge Semin (1):
      net: stmmac: Rename phylink_get_caps() callback to update_caps()

Shanker Donthineni (1):
      dma/pool: Ensure DMA_DIRECT_REMAP allocations are decrypted

Shuhao Fu (1):
      fs/smb: Fix inconsistent refcnt update

Steve French (1):
      smb3 client: fix return code mapping of remap_file_range

Takamitsu Iwai (3):
      net: rose: split remove and free operations in rose_remove_neigh()
      net: rose: convert 'use' field to refcount_t
      net: rose: include node references in rose_neigh refcount

Tengda Wu (1):
      ftrace: Fix potential warning in trace_printk_seq during ftrace_dump

Thijs Raymakers (1):
      KVM: x86: use array_index_nospec with indices that come from guest

Timur Tabi (2):
      drm/nouveau: remove unused increment in gm200_flcn_pio_imem_wr
      drm/nouveau: remove unused memory target test

Trond Myklebust (1):
      NFS: Fix a race when updating an existing write

Werner Sembach (1):
      ACPI: EC: Add device to acpi_ec_no_wakeup[] qurik list

Yeounsu Moon (1):
      net: dlink: fix multicast stats being counted incorrectly



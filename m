Return-Path: <stable+bounces-177750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5BEB44011
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348DAA06047
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59BD30F557;
	Thu,  4 Sep 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MIw4vDP9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13630F537;
	Thu,  4 Sep 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998646; cv=none; b=WV2dPGNlRvfs9nLHY1G27v+6VE9LJOAccocj4dmFBS4NfnicGjfaRkBD/tsQ0XhOIH0zKbg8+FEkHbRspZ+0ENoySirdx6z4ULim/rNVMY0DI2IheXb0Z/1Jmz7F3xlgK2j8uAKDORDqh6pwEQrlR2qGvi6NUEUIj75fvt5oP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998646; c=relaxed/simple;
	bh=gskEyBL+W5b02fNrcQpL2jySeTw9Y+bq27msTv/LL6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W0gWMOirXenpXUcpmAXMhntbobvIi/hIYyJArVuNQbmYeNKoTTkZl4Fla0T9qd5n7yt7QWNZErfEl8a2r0z55pxMWgnqYKrGD/iZrFpTU0PkuUmgole5n8ctaAdIk0vRwG4K+XNljTTj/aGlbDg1rWGdycTsWkd8h1Rl0OspMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MIw4vDP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E1DC4CEF0;
	Thu,  4 Sep 2025 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756998646;
	bh=gskEyBL+W5b02fNrcQpL2jySeTw9Y+bq27msTv/LL6w=;
	h=From:To:Cc:Subject:Date:From;
	b=MIw4vDP9L1IK2T4OrAZ73V+uL9Hh4hLnQ27dO/VRj2pwTu0QckJNfrVo0829Be3os
	 NLfE+TxDfORlbycO5YTIu6mluQFW68EtafwCTR3VMTerzdBUyE8E+eTLsQkHSeDqwv
	 +kKSFX7n/F/8xQyNbtX7dRWNOzZqiu+vEnpCBffg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.150
Date: Thu,  4 Sep 2025 17:10:33 +0200
Message-ID: <2025090434-prologue-mustiness-829e@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.150 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    2 
 arch/mips/boot/dts/lantiq/danube_easy50712.dts           |    5 
 arch/mips/lantiq/xway/sysctrl.c                          |   10 -
 arch/powerpc/kernel/kvm.c                                |    8 
 arch/x86/kvm/lapic.c                                     |    2 
 arch/x86/kvm/x86.c                                       |    7 
 drivers/acpi/ec.c                                        |    6 
 drivers/atm/atmtcp.c                                     |   17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                  |    4 
 drivers/gpu/drm/display/drm_dp_helper.c                  |    2 
 drivers/gpu/drm/msm/msm_gem_submit.c                     |   14 -
 drivers/gpu/drm/nouveau/dispnv50/wndw.c                  |    4 
 drivers/hid/hid-asus.c                                   |    8 
 drivers/hid/hid-input-test.c                             |   10 -
 drivers/hid/hid-input.c                                  |   51 ++---
 drivers/hid/hid-mcp2221.c                                |   71 +++++--
 drivers/hid/hid-multitouch.c                             |    8 
 drivers/hid/hid-ntrig.c                                  |    3 
 drivers/hid/wacom_wac.c                                  |    1 
 drivers/net/ethernet/dlink/dl2k.c                        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h |   12 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |   19 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c       |    4 
 drivers/net/phy/mscc/mscc.h                              |    4 
 drivers/net/phy/mscc/mscc_main.c                         |    4 
 drivers/net/phy/mscc/mscc_ptp.c                          |   34 ++-
 drivers/net/usb/qmi_wwan.c                               |    3 
 drivers/pinctrl/Kconfig                                  |    1 
 drivers/scsi/scsi_sysfs.c                                |    4 
 drivers/vhost/net.c                                      |    9 
 fs/efivarfs/super.c                                      |    4 
 fs/nfs/pagelist.c                                        |   86 ---------
 fs/nfs/write.c                                           |  140 +++++++++------
 fs/smb/client/cifsfs.c                                   |   14 +
 fs/smb/client/inode.c                                    |   34 +++
 fs/smb/client/smb2inode.c                                |    7 
 fs/xfs/libxfs/xfs_attr_remote.c                          |    7 
 fs/xfs/libxfs/xfs_da_btree.c                             |    6 
 include/linux/atmdev.h                                   |    1 
 include/linux/nfs_page.h                                 |    2 
 include/net/bluetooth/hci_sync.h                         |    2 
 include/net/rose.h                                       |   18 +
 kernel/dma/pool.c                                        |    4 
 kernel/trace/trace.c                                     |    4 
 net/atm/common.c                                         |   15 +
 net/bluetooth/hci_event.c                                |   20 +-
 net/bluetooth/hci_sync.c                                 |    6 
 net/bluetooth/mgmt.c                                     |    5 
 net/ipv4/route.c                                         |   10 -
 net/rose/af_rose.c                                       |   13 -
 net/rose/rose_in.c                                       |   12 -
 net/rose/rose_route.c                                    |   62 ++++--
 net/rose/rose_timer.c                                    |    2 
 net/sctp/ipv6.c                                          |    2 
 sound/soc/codecs/lpass-tx-macro.c                        |    2 
 57 files changed, 512 insertions(+), 300 deletions(-)

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

Christoph Hellwig (1):
      nfs: fold nfs_page_group_lock_subrequests into nfs_lock_and_join_requests

Damien Le Moal (1):
      scsi: core: sysfs: Correct sysfs attributes access rights

Eric Dumazet (2):
      sctp: initialize more fields in sctp_v6_from_sk()
      net: rose: fix a typo in rose_clear_routes()

Eric Sandeen (1):
      xfs: do not propagate ENODATA disk errors into xattr code

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion LE910C4-WWX new compositions

Greg Kroah-Hartman (1):
      Linux 6.1.150

Hamish Martin (2):
      HID: mcp2221: Don't set bus speed on every transfer
      HID: mcp2221: Handle reads greater than 60 bytes

Horatiu Vultur (1):
      phy: mscc: Fix when PTP clock is register and unregister

Imre Deak (1):
      Revert "drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS"

James Jones (1):
      drm/nouveau/disp: Always accept linear modifier

José Expósito (2):
      HID: input: rename hidinput_set_battery_charge_status()
      HID: input: report battery status changes immediately

Kuniyuki Iwashima (1):
      atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().

Li Nan (1):
      efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare

Ludovico de Nittis (2):
      Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
      Bluetooth: hci_event: Mark connection as closed during suspend disconnect

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced

Madhavan Srinivasan (1):
      powerpc/kvm: Fix ifdef to remove build warning

Minjong Kim (1):
      HID: hid-ntrig: fix unable to handle page fault in ntrig_report_version()

Moshe Shemesh (1):
      net/mlx5: Reload auxiliary drivers on fw_activate

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

Rohan G Thomas (1):
      net: stmmac: xgmac: Do not enable RX FIFO Overflow interrupts

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

Trond Myklebust (1):
      NFS: Fix a race when updating an existing write

Werner Sembach (1):
      ACPI: EC: Add device to acpi_ec_no_wakeup[] qurik list

Yeounsu Moon (1):
      net: dlink: fix multicast stats being counted incorrectly



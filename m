Return-Path: <stable+bounces-177748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21253B4400D
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C69F1C83629
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94330CD8C;
	Thu,  4 Sep 2025 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iAetCcFF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535993090F9;
	Thu,  4 Sep 2025 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998638; cv=none; b=coRCzzQs6tTAc270aeru+UGwL/lUfln0BdKszOMwrlK9PTa8eIbSSB0b18mdLceOWBfVGqDFfnwGAs9jAgUIE4xtIU71P4OUQH50F+x9krC5Ybj0n9/aW28VHjgeK8ELPqXghyCQwds21wR28VCC337G/s1QWfVyAmKn+XRg4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998638; c=relaxed/simple;
	bh=FV5lzDWQJWQod1FYi9YgnzR0K+7Bqs+hW2k8qTt8Az4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpbGV8N8RWua5n05FKyD/2RlXDWHKhEPd4bNMvgLl9pDZh7CVN8rPzzhvtZysyw0ibu/M8OGt9qwbqpH2RqnEFc4XHZol35UmZMKP7FhFgZvFqg+mrvRX7OXefMDnNKZYQZpWXPl9FbWVlFdY/slqUqOSgQ5n7mrvBjxnZXJlEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iAetCcFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B8DC4CEF0;
	Thu,  4 Sep 2025 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756998638;
	bh=FV5lzDWQJWQod1FYi9YgnzR0K+7Bqs+hW2k8qTt8Az4=;
	h=From:To:Cc:Subject:Date:From;
	b=iAetCcFFsfV6yzDC78DXTSce+2+e3eC6rKBm6uBPOQYvL+Hmd/v7VCsKF2SoZVxJa
	 oIAJKDsbDuiYJQYxrn+wOFbMCGMvbFpXrq2Wh/nqg0W8t9oGOKAluV0ZUDpkM7l8tX
	 a2T2Tjt8AjnhgsXQ1l7sgndFkFsaUQi8KJjuu3/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.191
Date: Thu,  4 Sep 2025 17:10:25 +0200
Message-ID: <2025090426-lustiness-unsent-2eb1@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.191 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    2 
 arch/powerpc/kernel/kvm.c                                |    8 
 arch/x86/kvm/lapic.c                                     |    2 
 arch/x86/kvm/x86.c                                       |    7 
 drivers/atm/atmtcp.c                                     |   17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                  |    4 
 drivers/gpu/drm/drm_dp_helper.c                          |    2 
 drivers/gpu/drm/nouveau/dispnv50/wndw.c                  |    4 
 drivers/hid/hid-asus.c                                   |    8 
 drivers/hid/hid-mcp2221.c                                |   71 +++++--
 drivers/hid/hid-multitouch.c                             |    8 
 drivers/hid/hid-ntrig.c                                  |    3 
 drivers/hid/wacom_wac.c                                  |    1 
 drivers/net/ethernet/dlink/dl2k.c                        |    2 
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
 fs/udf/directory.c                                       |    2 
 fs/xfs/libxfs/xfs_attr_remote.c                          |    7 
 fs/xfs/libxfs/xfs_da_btree.c                             |    6 
 include/linux/atmdev.h                                   |    1 
 include/linux/nfs_page.h                                 |    2 
 kernel/dma/pool.c                                        |    4 
 kernel/trace/trace.c                                     |    4 
 net/atm/common.c                                         |   15 +
 net/bluetooth/hci_event.c                                |   12 +
 net/ipv4/route.c                                         |   10 -
 net/sctp/ipv6.c                                          |    2 
 sound/soc/codecs/lpass-tx-macro.c                        |    2 
 40 files changed, 326 insertions(+), 207 deletions(-)

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

Eric Dumazet (1):
      sctp: initialize more fields in sctp_v6_from_sk()

Eric Sandeen (1):
      xfs: do not propagate ENODATA disk errors into xattr code

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion LE910C4-WWX new compositions

Greg Kroah-Hartman (1):
      Linux 5.15.191

Hamish Martin (2):
      HID: mcp2221: Don't set bus speed on every transfer
      HID: mcp2221: Handle reads greater than 60 bytes

Horatiu Vultur (1):
      phy: mscc: Fix when PTP clock is register and unregister

Imre Deak (1):
      Revert "drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS"

James Jones (1):
      drm/nouveau/disp: Always accept linear modifier

Jan Kara (1):
      udf: Fix directory iteration for longer tail extents

Kuniyuki Iwashima (1):
      atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().

Li Nan (1):
      efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced

Madhavan Srinivasan (1):
      powerpc/kvm: Fix ifdef to remove build warning

Minjong Kim (1):
      HID: hid-ntrig: fix unable to handle page fault in ntrig_report_version()

Nikolay Kuratov (1):
      vhost/net: Protect ubufs with rcu read lock in vhost_net_ubuf_put()

Oscar Maes (1):
      net: ipv4: fix regression in local-broadcast routes

Ping Cheng (1):
      HID: wacom: Add a new Art Pen 2

Qasim Ijaz (2):
      HID: asus: fix UAF via HID_CLAIMED_INPUT validation
      HID: multitouch: fix slab out-of-bounds access in mt_report_fixup()

Randy Dunlap (1):
      pinctrl: STMFX: add missing HAS_IOMEM dependency

Rohan G Thomas (1):
      net: stmmac: xgmac: Do not enable RX FIFO Overflow interrupts

Shanker Donthineni (1):
      dma/pool: Ensure DMA_DIRECT_REMAP allocations are decrypted

Tengda Wu (1):
      ftrace: Fix potential warning in trace_printk_seq during ftrace_dump

Thijs Raymakers (1):
      KVM: x86: use array_index_nospec with indices that come from guest

Trond Myklebust (1):
      NFS: Fix a race when updating an existing write

Yeounsu Moon (1):
      net: dlink: fix multicast stats being counted incorrectly



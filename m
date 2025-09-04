Return-Path: <stable+bounces-177746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D319DB44007
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC89484291
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C9730AAA5;
	Thu,  4 Sep 2025 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qclJ7de+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129D3093A5;
	Thu,  4 Sep 2025 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998627; cv=none; b=Vp4+k1pNBGwwnXsFY2PeG9KL5k3b9DfIxd+eCTRt9pa213rbMaqEqKgNEVP8329W95xC7R405DSV5oqEynMI60iE/Qd2MH0myTygwJaTRlexpUL1h59Z+IW+SQb4IsMEuGGDU4+clbfYcQ7q92b2DBVHmfduDSAdpJCD0Jjx82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998627; c=relaxed/simple;
	bh=iXuQbcRArkcfscbAJwMKyR+eOeTcIXwqe4tFComZTOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOXSLKPGOCrHtH6/HXlSWBs8HyiYeE+LxTJp5l7kcK8qsO2snWKUVORZZaIjfww0A1PqnRPDIugUAv08Xj3Qq8UymfUeMWAyErnyL6R6Dk6ljiAII0ylW11++1AunTVT9aoIS3Y2zEzo9ljIGd44Ow7yqHpTTUNBt7w74h16MpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qclJ7de+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8ADC4CEF0;
	Thu,  4 Sep 2025 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756998627;
	bh=iXuQbcRArkcfscbAJwMKyR+eOeTcIXwqe4tFComZTOs=;
	h=From:To:Cc:Subject:Date:From;
	b=qclJ7de+xNryJcP5A7L7zWvU6hcXKE9Iu7Rj9hV2JepRgZzfptMbQ1obRslsyWiFC
	 GOoJ4sq4raXOGIiBr3UXm+2PW+KEGr4GMoRwNE8ALNA4dMtsLwzNpd2tDaio17ehb+
	 rR+2KLTZ2cHYvvRNdcJVEiMe+hIerD6Hd8jIPwFw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.242
Date: Thu,  4 Sep 2025 17:10:19 +0200
Message-ID: <2025090420-grunt-purity-99f1@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.242 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    2 
 arch/powerpc/kernel/kvm.c                                |    8 
 arch/x86/kernel/cpu/hygon.c                              |    3 
 arch/x86/kvm/lapic.c                                     |    2 
 arch/x86/kvm/x86.c                                       |    7 
 drivers/atm/atmtcp.c                                     |   17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                  |    4 
 drivers/gpu/drm/drm_dp_helper.c                          |    2 
 drivers/gpu/drm/nouveau/dispnv50/wndw.c                  |    4 
 drivers/hid/hid-asus.c                                   |    8 
 drivers/hid/hid-mcp2221.c                                |   71 +++++--
 drivers/hid/hid-ntrig.c                                  |    3 
 drivers/hid/wacom_wac.c                                  |    1 
 drivers/net/ethernet/dlink/dl2k.c                        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h |   12 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |   19 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c       |    4 
 drivers/net/usb/qmi_wwan.c                               |    3 
 drivers/pinctrl/Kconfig                                  |    1 
 drivers/scsi/scsi_sysfs.c                                |    4 
 drivers/vhost/net.c                                      |    9 
 fs/efivarfs/super.c                                      |    4 
 fs/nfs/pagelist.c                                        |   86 ---------
 fs/nfs/write.c                                           |  140 +++++++++------
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
 sound/soc/intel/boards/bxt_da7219_max98357a.c            |   12 -
 sound/soc/intel/boards/glk_rt5682_max98357a.c            |    4 
 sound/soc/intel/boards/sof_da7219_max98373.c             |   10 -
 sound/soc/intel/boards/sof_rt5682.c                      |   12 -
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c        |    2 
 sound/soc/intel/common/soc-acpi-intel-cml-match.c        |    2 
 sound/soc/intel/common/soc-acpi-intel-glk-match.c        |    4 
 sound/soc/intel/common/soc-acpi-intel-jsl-match.c        |    6 
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c        |    4 
 44 files changed, 321 insertions(+), 217 deletions(-)

Alex Deucher (1):
      Revert "drm/amdgpu: fix incorrect vm flags to map bo"

Alexei Lazar (3):
      net/mlx5e: Update and set Xon/Xoff upon MTU set
      net/mlx5e: Update and set Xon/Xoff upon port speed set
      net/mlx5e: Set local Xoff after FW update

Brent Lu (1):
      ASoC: Intel: sof_da7219_mx98360a: fail to initialize soundcard

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
      Linux 5.10.242

Hamish Martin (2):
      HID: mcp2221: Don't set bus speed on every transfer
      HID: mcp2221: Handle reads greater than 60 bytes

Imre Deak (1):
      Revert "drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS"

James Jones (1):
      drm/nouveau/disp: Always accept linear modifier

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

Pierre-Louis Bossart (4):
      ASoC: Intel: bxt_da7219_max98357a: shrink platform_id below 20 characters
      ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characters
      ASoC: Intel: glk_rt5682_max98357a: shrink platform_id below 20 characters
      ASoC: Intel: sof_da7219_max98373: shrink platform_id below 20 characters

Ping Cheng (1):
      HID: wacom: Add a new Art Pen 2

Qasim Ijaz (1):
      HID: asus: fix UAF via HID_CLAIMED_INPUT validation

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

Tianxiang Peng (1):
      x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper

Trond Myklebust (1):
      NFS: Fix a race when updating an existing write

Yeounsu Moon (1):
      net: dlink: fix multicast stats being counted incorrectly



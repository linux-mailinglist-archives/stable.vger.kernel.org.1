Return-Path: <stable+bounces-4976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5708809D9F
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 08:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1951F20F5F
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 07:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F510944;
	Fri,  8 Dec 2023 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a0boSA+y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6D107B0
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 07:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4064AC433C9;
	Fri,  8 Dec 2023 07:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702022179;
	bh=/l7Lj/1U//FKCU0KtA/eEYLmxK4Hp8KTpSQ6BifUPeU=;
	h=From:To:Cc:Subject:Date:From;
	b=a0boSA+y/+bhXCb7/md/F5JZKlIJB6HCYBLKAFKsQPExItjHzSxq4RlPt6O4ErN6F
	 oHYhuSNP4wlI7ypOyhvkUjEVpqUaOdgt5XlNmqmAWfhJ1im4XvP5jKASqKXqMmZ1hw
	 TCg4fjeOrC3MXpWOmnUPp6KkT7cuNbnP4P9fccYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.332
Date: Fri,  8 Dec 2023 08:56:15 +0100
Message-ID: <2023120815-agony-resize-1fd9@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.14.332 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 -
 arch/arm/xen/enlighten.c                          |    3 +-
 arch/powerpc/kernel/fpu.S                         |   13 +++++++++++
 arch/powerpc/kernel/vector.S                      |    2 +
 drivers/ata/pata_isapnp.c                         |    3 ++
 drivers/base/dd.c                                 |    4 +--
 drivers/firewire/core-device.c                    |   11 +++-------
 drivers/gpu/drm/panel/panel-simple.c              |   12 +++++------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c       |   14 ++++++++++--
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c          |    6 +++++
 drivers/infiniband/hw/i40iw/i40iw_type.h          |    2 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c         |   10 +++++++--
 drivers/md/bcache/btree.c                         |    2 +
 drivers/md/bcache/sysfs.c                         |    2 -
 drivers/md/dm-verity-fec.c                        |    3 +-
 drivers/md/dm-verity-target.c                     |    4 ++-
 drivers/md/dm-verity.h                            |    6 -----
 drivers/mtd/nand/brcmnand/brcmnand.c              |    5 +++-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c      |   11 +++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c         |   14 +++++++++++-
 drivers/net/ethernet/renesas/ravb_main.c          |   15 +++++++++++--
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c |    2 -
 drivers/net/usb/ax88179_178a.c                    |    4 +--
 drivers/pinctrl/core.c                            |    6 ++---
 drivers/s390/block/dasd.c                         |   24 +++++++++++-----------
 drivers/usb/dwc3/core.c                           |    2 +
 drivers/usb/serial/option.c                       |   11 +++++++---
 fs/btrfs/send.c                                   |    2 -
 fs/btrfs/volumes.c                                |    2 -
 net/ipv4/igmp.c                                   |    6 +++--
 net/ipv4/route.c                                  |    2 -
 31 files changed, 141 insertions(+), 64 deletions(-)

Asuna Yang (1):
      USB: serial: option: add Luat Air72*U series products

Chen Ni (1):
      ata: pata_isapnp: Add missing error check for devm_ioport_map()

Christopher Bednarz (1):
      RDMA/irdma: Prevent zero-length STAG registration

Claire Lin (1):
      mtd: rawnand: brcmnand: Fix ecc chunk calculation for erased page bitfips

Claudiu Beznea (1):
      net: ravb: Start TX queues after HW initialization succeeded

Coly Li (1):
      bcache: check return value from btree_node_alloc_replacement()

Filipe Manana (1):
      btrfs: fix off-by-one when checking chunk map includes logical address

Greg Kroah-Hartman (1):
      Linux 4.14.332

Jan Höppner (1):
      s390/dasd: protect device queue against concurrent access

Jann Horn (1):
      btrfs: send: ensure send_fd is writable

Jonas Karlman (1):
      drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: fix failed operations during ax88179_reset

Kunwu Chan (1):
      ipv4: Correct/silence an endian warning in __ip_do_redirect

Lech Perczak (1):
      USB: serial: option: don't claim interface 4 for ZTE MF290

Marek Vasut (1):
      drm/panel: simple: Fix Innolux G101ICE-L01 timings

Maria Yu (1):
      pinctrl: avoid reload of p state in list iteration

Mikulas Patocka (1):
      dm-verity: align struct dm_verity_fec_io properly

Puliang Lu (1):
      USB: serial: option: fix FM101R-GL defines

Raju Rangoju (2):
      amd-xgbe: handle corner-case during sfp hotplug
      amd-xgbe: propagate the correct speed and duplex status

Rand Deeb (1):
      bcache: prevent potential division by zero error

Ricardo Ribalda (1):
      usb: dwc3: set the dma max_seg_size

Samuel Holland (1):
      net: axienet: Fix check for partial TX checksum

Saravana Kannan (1):
      driver core: Release all resources during unbind before updating device links

Stefano Stabellini (1):
      arm/xen: fix xen_vcpu_info allocation alignment

Timothy Pearson (1):
      powerpc: Don't clobber f0/vs0 during fp|altivec register save

Victor Fragoso (1):
      USB: serial: option: add Fibocom L7xx modules

Wu Bo (1):
      dm verity: don't perform FEC for failed readahead IO

Yang Yingliang (1):
      firewire: core: fix possible memory leak in create_units()

Yoshihiro Shimoda (1):
      ravb: Fix races between ravb_tx_timeout_work() and net related ops

Zhengchao Shao (1):
      ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet



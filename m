Return-Path: <stable+bounces-177744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2598B44003
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5844E540715
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C5D3009E4;
	Thu,  4 Sep 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SHxkI3+1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA4303C9E;
	Thu,  4 Sep 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998617; cv=none; b=oCNr4pgAjdZayM0oteuDqUzr5JEku8AN75mMoCWTzy1r/UcCp4Cmn7bdUjzoOjByWI3fDhZqlQNLwCYakyUivPt9r+q9h/lj95vC1jJpLh5HfYBJ04IsdVuXUti9oW56UHVh0Tbr08ENUnJ49V/G/FxZFkh9kvCK9MFqMxIiz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998617; c=relaxed/simple;
	bh=d2u9aclCBwlXX9P/rEtkvHIXq8tbLp+BGnut2pkWYD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZANKG+uJjSOX6qlOsYeKGscZfeuQtlwo6fOxy9Lv6TzYnSlR8zXfqdGWY9cYySCDP50Jyguw/fT2XOl48CCaI3lIezAUZwJF+sWtMIxJeR70CP6VbqGu7tIaI5gJHcUVuf63jPuR9iX6M7nloaJ9c0JJO76Oy3ZXe8HT66UBndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SHxkI3+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBAEC4CEF0;
	Thu,  4 Sep 2025 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756998616;
	bh=d2u9aclCBwlXX9P/rEtkvHIXq8tbLp+BGnut2pkWYD0=;
	h=From:To:Cc:Subject:Date:From;
	b=SHxkI3+1hdbRJzIQGpvEzG4CjJbLG4iW43FTxXEx9u6WX4ZSEvAe4q7GBWN4hpZlq
	 kcHs9q3sXPdf9sSIWEabMR0YZuKXLglRH+zqkOTi0poDO3EoalDfOLQ31IyuOisX+4
	 J0hVBepZib80hNeiywoTKtLcQj6jW45CvQB1Ug1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.298
Date: Thu,  4 Sep 2025 17:10:11 +0200
Message-ID: <2025090412-treat-unleveled-cef8@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.298 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    2 
 arch/powerpc/kernel/kvm.c                                |    8 +--
 arch/x86/kvm/lapic.c                                     |    3 +
 arch/x86/kvm/x86.c                                       |    7 +-
 drivers/atm/atmtcp.c                                     |   17 +++++-
 drivers/atm/eni.c                                        |   17 ------
 drivers/atm/firestream.c                                 |    2 
 drivers/atm/fore200e.c                                   |   27 ----------
 drivers/atm/horizon.c                                    |   40 ---------------
 drivers/atm/iphase.c                                     |   16 ------
 drivers/atm/lanai.c                                      |    2 
 drivers/atm/solos-pci.c                                  |    2 
 drivers/atm/zatm.c                                       |   16 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                  |    4 -
 drivers/gpu/drm/drm_dp_helper.c                          |    2 
 drivers/hid/hid-asus.c                                   |    8 ++-
 drivers/hid/hid-ntrig.c                                  |    3 +
 drivers/hid/wacom_wac.c                                  |    1 
 drivers/net/ethernet/dlink/dl2k.c                        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c |    3 -
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h |   12 ++++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |   19 ++++++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c       |    4 -
 drivers/net/usb/qmi_wwan.c                               |    3 +
 drivers/pinctrl/Kconfig                                  |    1 
 drivers/scsi/scsi_sysfs.c                                |    4 -
 drivers/vhost/net.c                                      |    9 ++-
 fs/efivarfs/super.c                                      |    4 +
 include/linux/atmdev.h                                   |   10 ---
 kernel/trace/trace.c                                     |    4 -
 net/atm/common.c                                         |   29 +++++-----
 net/bluetooth/hci_event.c                                |   12 ++++
 net/ipv4/route.c                                         |   10 ++-
 net/sctp/ipv6.c                                          |    2 
 34 files changed, 128 insertions(+), 177 deletions(-)

Alex Deucher (1):
      Revert "drm/amdgpu: fix incorrect vm flags to map bo"

Alexei Lazar (3):
      net/mlx5e: Update and set Xon/Xoff upon MTU set
      net/mlx5e: Update and set Xon/Xoff upon port speed set
      net/mlx5e: Set local Xoff after FW update

Christoph Hellwig (1):
      net/atm: remove the atmdev_ops {get, set}sockopt methods

Damien Le Moal (1):
      scsi: core: sysfs: Correct sysfs attributes access rights

Eric Dumazet (1):
      sctp: initialize more fields in sctp_v6_from_sk()

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion LE910C4-WWX new compositions

Greg Kroah-Hartman (1):
      Linux 5.4.298

Imre Deak (1):
      Revert "drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS"

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

Qasim Ijaz (1):
      HID: asus: fix UAF via HID_CLAIMED_INPUT validation

Randy Dunlap (1):
      pinctrl: STMFX: add missing HAS_IOMEM dependency

Rohan G Thomas (1):
      net: stmmac: xgmac: Do not enable RX FIFO Overflow interrupts

Tengda Wu (1):
      ftrace: Fix potential warning in trace_printk_seq during ftrace_dump

Thijs Raymakers (1):
      KVM: x86: use array_index_nospec with indices that come from guest

Yeounsu Moon (1):
      net: dlink: fix multicast stats being counted incorrectly



Return-Path: <stable+bounces-46144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D348CEF7C
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CBD1F21534
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BD6A35A;
	Sat, 25 May 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lepr3eTJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6B5A7AB;
	Sat, 25 May 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648694; cv=none; b=Fk7mWKWSRYeUOuW8WjahQakpbK10j2QpVE+gMpTGmG+yLiandDNdBuADJB90MhdxswK3BTlvyvrJV7dpCQ5Nrzof+DMTbde2FvanY7WHx5wuppsyRrO2P4V4FMRpbWB6mlIHVx+3p1l0KF08TUUVOo4UWJpI8xXm/gz74f/FWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648694; c=relaxed/simple;
	bh=5+6JQJHorMeIY11iYs8ZYrjPP6NgtTBTyG9eez/WiFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S4bF8YoDEETd+Z4fMx/5gJ5nMlDZSQYKJTSmNqBdaa867YKuyldM0rhabXg8qGQyFz7lQLz/KehGwYZxZZjytck+UxyvOFQ8NvVAXrXihMvw9174+ZPQxkjr+YSNgq5N56GoXDb7KFHxd8WVNr6PCiIUfshV4czuq7agjSvqm0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lepr3eTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4DAC2BD11;
	Sat, 25 May 2024 14:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716648693;
	bh=5+6JQJHorMeIY11iYs8ZYrjPP6NgtTBTyG9eez/WiFE=;
	h=From:To:Cc:Subject:Date:From;
	b=lepr3eTJY7cySP0/DebtIznDAujG57nJ/Cc+CDW0lvm/UotbBpdJnF/dyjDrGa+4l
	 KXvKq1qQPujRWZfazO5Ml3EbEyF/ERfUYN0Gp/z8JSwrIvxMTSXGndAs8UN6bb18mE
	 U2XJNmJbn31h7G3sZV7+aJ1bJWckJbORj8S6JMwg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.8.11
Date: Sat, 25 May 2024 16:51:20 +0200
Message-ID: <2024052520-riding-silencer-2453@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.8.11 kernel.

All users of the 6.8 kernel series must upgrade.

The updated 6.8.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.8.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/stable/sysfs-block                  |   10 +
 Documentation/admin-guide/hw-vuln/core-scheduling.rst |    4 
 Documentation/admin-guide/mm/damon/usage.rst          |    2 
 Documentation/sphinx/kernel_include.py                |    1 
 Makefile                                              |    2 
 block/genhd.c                                         |   15 +-
 block/partitions/core.c                               |    5 
 drivers/android/binder.c                              |    2 
 drivers/android/binder_internal.h                     |    2 
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c           |    7 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.c         |   22 +--
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c    |    3 
 drivers/net/ethernet/micrel/ks8851_common.c           |   18 --
 drivers/net/usb/ax88179_178a.c                        |   37 +++--
 drivers/remoteproc/mtk_scp.c                          |   10 +
 drivers/tty/serial/kgdboc.c                           |   30 ++++
 drivers/usb/dwc3/gadget.c                             |    4 
 drivers/usb/typec/tipd/core.c                         |   51 +++++--
 drivers/usb/typec/tipd/tps6598x.h                     |   11 +
 drivers/usb/typec/ucsi/displayport.c                  |    4 
 fs/erofs/internal.h                                   |    7 -
 fs/erofs/super.c                                      |  124 +++++++-----------
 include/linux/blkdev.h                                |   13 +
 include/net/bluetooth/hci.h                           |    9 +
 include/net/bluetooth/hci_core.h                      |    1 
 net/bluetooth/hci_conn.c                              |   71 +++++++---
 net/bluetooth/hci_event.c                             |   31 ++--
 net/bluetooth/iso.c                                   |    2 
 net/bluetooth/l2cap_core.c                            |   38 +----
 net/bluetooth/sco.c                                   |    6 
 security/keys/trusted-keys/trusted_tpm2.c             |   25 ++-
 31 files changed, 338 insertions(+), 229 deletions(-)

Akira Yokosawa (1):
      docs: kernel_include.py: Cope with docutils 0.21

AngeloGioacchino Del Regno (1):
      remoteproc: mediatek: Make sure IPI buffer fits in L2TCM

Baokun Li (1):
      erofs: get rid of erofs_fs_context

Carlos Llamas (1):
      binder: fix max_thread type inconsistency

Christian Brauner (1):
      erofs: reliably distinguish block based and fscache mode

Christoph Hellwig (2):
      block: add a disk_has_partscan helper
      block: add a partscan sysfs attribute for disks

Daniel Thompson (1):
      serial: kgdboc: Fix NMI-safety problems from keyboard reset code

Greg Kroah-Hartman (1):
      Linux 6.8.11

Heikki Krogerus (1):
      usb: typec: ucsi: displayport: Fix potential deadlock

Jacob Keller (2):
      ice: pass VSI pointer into ice_vc_isvalid_q_id
      ice: remove unnecessary duplicate checks for VF VSI ID

Jarkko Sakkinen (2):
      KEYS: trusted: Fix memory leak in tpm2_key_encode()
      KEYS: trusted: Do not use WARN when encode fails

Javier Carrasco (2):
      usb: typec: tipd: fix event checking for tps25750
      usb: typec: tipd: fix event checking for tps6598x

Jose Fernandez (1):
      drm/amd/display: Fix division by zero in setup_dsc_config

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: fix link status when link is set to down/up

Prashanth K (1):
      usb: dwc3: Wait unconditionally after issuing EndXfer command

Ronald Wahl (1):
      net: ks8851: Fix another TX stall caused by wrong ISR flag handling

SeongJae Park (1):
      Docs/admin-guide/mm/damon/usage: fix wrong example of DAMOS filter matching sysfs file

Sungwoo Kim (2):
      Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()
      Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()

Thomas Weißschuh (1):
      admin-guide/hw-vuln/core-scheduling: fix return type of PR_SCHED_CORE_GET



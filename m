Return-Path: <stable+bounces-46145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BDD8CEF7F
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16B42819F6
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6682605C6;
	Sat, 25 May 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jH+u4QWj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826DF74437;
	Sat, 25 May 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648699; cv=none; b=Y/Lslzc20HBHsCJRQFFu6iyZ7PGwKK4Q5VUYY5uBJBUdrl2fYksryEd0pLiR4L5upT4HX8YyevpxfzOkrP66Eu0J8tnv5z7138zLvZBNHYR8QYWUqEaYw77cn3ijyM97m6Oh7iYVY7UqEL21jY2W2ug+kSt39PNYH8mMOJ0w7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648699; c=relaxed/simple;
	bh=ifW8QGdZVvx9AYaN1LbEcABYc0cbuoBAVpLKF1KyJso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g6jkBLewxrmRZdfMxvKYNhDvoD2+xlDHoDcuYc1wThFCxZKmMiUcRpfpSdLZYMLQs31M8/vFjzgphcE/glur3xPHlXpViK1DgASKJiugfkfjPvAExwJ4lqbAgxeO7lkZhjey5qPfOybVetdePJoDbTDy4QtCWVx3hAwpDVNcHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jH+u4QWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CB7C2BD11;
	Sat, 25 May 2024 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716648699;
	bh=ifW8QGdZVvx9AYaN1LbEcABYc0cbuoBAVpLKF1KyJso=;
	h=From:To:Cc:Subject:Date:From;
	b=jH+u4QWjfeMrBgd6p0MjmILvLf6vmVDihdyqjM/20W7cWgMdgv3LscK5Msx5T8Gak
	 K476cLKFOWFo5nydbo4P8gnbt95jIX289SFWsb7hvsY0F6m4emLUYHUVT7vna+qdXz
	 UAm3F7uUGbe4V4EcMfcAAbLlZb02U2JB+84HWLdU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.9.2
Date: Sat, 25 May 2024 16:51:27 +0200
Message-ID: <2024052527-panama-playgroup-899a@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.9.2 kernel.

All users of the 6.9 kernel series must upgrade.

The updated 6.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.9.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/stable/sysfs-block                  |   10 ++
 Documentation/admin-guide/hw-vuln/core-scheduling.rst |    4 
 Documentation/admin-guide/mm/damon/usage.rst          |    6 -
 Documentation/sphinx/kernel_include.py                |    1 
 Makefile                                              |    2 
 arch/x86/include/asm/percpu.h                         |    6 -
 block/genhd.c                                         |   15 ++-
 block/partitions/core.c                               |    5 -
 drivers/android/binder.c                              |    2 
 drivers/android/binder_internal.h                     |    2 
 drivers/bluetooth/btusb.c                             |    1 
 drivers/cpufreq/amd-pstate.c                          |   22 ++++-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c           |    7 +
 drivers/media/v4l2-core/v4l2-ctrls-core.c             |   18 +---
 drivers/net/ethernet/micrel/ks8851_common.c           |   18 ----
 drivers/net/usb/ax88179_178a.c                        |   37 ++++++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c          |   10 --
 drivers/remoteproc/mtk_scp.c                          |   10 ++
 drivers/tty/serial/kgdboc.c                           |   30 ++++++-
 drivers/usb/dwc3/gadget.c                             |    4 
 drivers/usb/typec/tipd/core.c                         |   51 ++++++++----
 drivers/usb/typec/tipd/tps6598x.h                     |   11 ++
 drivers/usb/typec/ucsi/displayport.c                  |    4 
 include/linux/blkdev.h                                |   13 +++
 include/net/bluetooth/hci.h                           |    9 ++
 include/net/bluetooth/hci_core.h                      |    1 
 net/bluetooth/hci_conn.c                              |   75 ++++++++++++------
 net/bluetooth/hci_event.c                             |   31 ++++---
 net/bluetooth/iso.c                                   |    2 
 net/bluetooth/l2cap_core.c                            |   17 ----
 net/bluetooth/sco.c                                   |    6 -
 security/keys/trusted-keys/trusted_tpm2.c             |   25 ++++--
 sound/soc/intel/boards/Makefile                       |    1 
 sound/soc/intel/boards/sof_sdw.c                      |   12 +-
 sound/soc/intel/boards/sof_sdw_common.h               |    1 
 sound/soc/intel/boards/sof_sdw_rt_dmic.c              |   52 ++++++++++++
 36 files changed, 356 insertions(+), 165 deletions(-)

Akira Yokosawa (1):
      docs: kernel_include.py: Cope with docutils 0.21

AngeloGioacchino Del Regno (1):
      remoteproc: mediatek: Make sure IPI buffer fits in L2TCM

Bard Liao (1):
      ASoC: Intel: sof_sdw: use generic rtd_init function for Realtek SDW DMICs

Ben Greear (1):
      wifi: iwlwifi: Use request_module_nowait

Carlos Llamas (1):
      binder: fix max_thread type inconsistency

Christoph Hellwig (2):
      block: add a disk_has_partscan helper
      block: add a partscan sysfs attribute for disks

Daniel Thompson (1):
      serial: kgdboc: Fix NMI-safety problems from keyboard reset code

Greg Kroah-Hartman (1):
      Linux 6.9.2

Hans Verkuil (1):
      Revert "media: v4l2-ctrls: show all owned controls in log_status"

Heikki Krogerus (1):
      usb: typec: ucsi: displayport: Fix potential deadlock

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

Perry Yuan (1):
      cpufreq: amd-pstate: fix the highest frequency issue which limits performance

Peter Tsao (1):
      Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921

Prashanth K (1):
      usb: dwc3: Wait unconditionally after issuing EndXfer command

Ronald Wahl (1):
      net: ks8851: Fix another TX stall caused by wrong ISR flag handling

SeongJae Park (2):
      Docs/admin-guide/mm/damon/usage: fix wrong example of DAMOS filter matching sysfs file
      Docs/admin-guide/mm/damon/usage: fix wrong schemes effective quota update command

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()

Thomas Weißschuh (1):
      admin-guide/hw-vuln/core-scheduling: fix return type of PR_SCHED_CORE_GET

Uros Bizjak (1):
      x86/percpu: Use __force to cast from __percpu address space



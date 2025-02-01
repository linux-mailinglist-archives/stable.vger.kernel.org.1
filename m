Return-Path: <stable+bounces-111906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2190DA24B38
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 18:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40101886EAB
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A9C1CDA2F;
	Sat,  1 Feb 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fnbt/UeH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27EC1CAA9C;
	Sat,  1 Feb 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738431959; cv=none; b=kMEikG4w2V0ug0kmlEVrv1gFPZzOz5M8rdY7szlx0/Rt3FDwieixhAW3T2C4sQ6sBXlzLzTRnJoljemg6vI2h/hdeEd79ahHDo3u33GVKG49KZDNVtmlmwNORkNb0hPnckAOUb2WPkJn+bhw3ut8uvOlBbfo8V9uWQ3jpA2NJPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738431959; c=relaxed/simple;
	bh=tOBT7Le2jUFBb9kSgf6XbXUpFrKok67TyDMMpW0TlwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ed7zTgx4TZlSrGCl3wggKCv4+NrkaEYk9OJo7y/7FNSu6vXUHrgZj9H4kZAFIvnloCd5vJSv4Hl8L/kRy2iQF9gKuWf0uNUHXTEZDukk91IbX7ttiJpZQoTt/omUK5CbRBCoHEYRdy4Yt+3m+ncaH4aZZO9ABoWadyYGeq89TVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fnbt/UeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E00C4CED3;
	Sat,  1 Feb 2025 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738431959;
	bh=tOBT7Le2jUFBb9kSgf6XbXUpFrKok67TyDMMpW0TlwI=;
	h=From:To:Cc:Subject:Date:From;
	b=Fnbt/UeH03kekhMxwhwqfpPhTYgX1eSNkq1mjc96qKJ7UcwEukUdqGm3Xqc+sYnjZ
	 2o3j/d6z53zuYbIjvyG5tXjUMxNl8ojZ/dF/ipLcLyJICZ5buzPH3Q7fCzUTltxxO7
	 s+8DRrLkGWzJfc330lDwQ/NWZQXie/b0JA/QVC6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.178
Date: Sat,  1 Feb 2025 18:45:38 +0100
Message-ID: <2025020139-discourse-uncle-d761@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.178 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                     |    2 +-
 drivers/base/regmap/regmap.c                 |   12 ++++++++++++
 drivers/gpu/drm/v3d/v3d_irq.c                |   16 ++++++++++++----
 drivers/input/joystick/xpad.c                |    2 ++
 drivers/input/keyboard/atkbd.c               |    2 +-
 drivers/irqchip/irq-sunxi-nmi.c              |    3 ++-
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c  |    7 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c  |    9 ++++++---
 drivers/platform/chrome/cros_ec_typec.c      |    3 +++
 drivers/scsi/scsi_transport_iscsi.c          |    4 +++-
 drivers/scsi/storvsc_drv.c                   |    8 +++++++-
 drivers/usb/gadget/function/u_serial.c       |    8 ++++----
 drivers/usb/serial/quatech2.c                |    2 +-
 drivers/vfio/platform/vfio_platform_common.c |   10 ++++++++++
 fs/gfs2/file.c                               |    1 +
 fs/ntfs3/file.c                              |   12 ++++++++++--
 include/linux/seccomp.h                      |    2 +-
 include/net/bluetooth/bluetooth.h            |    9 +++++++++
 net/bluetooth/rfcomm/sock.c                  |   14 +++++---------
 net/bluetooth/sco.c                          |   19 ++++++++-----------
 net/ipv4/ip_tunnel.c                         |    2 +-
 net/mptcp/protocol.c                         |   18 +++++++++---------
 net/sched/sch_ets.c                          |    2 ++
 sound/soc/codecs/Kconfig                     |    1 +
 sound/soc/samsung/Kconfig                    |    6 ++++--
 sound/usb/quirks.c                           |    2 ++
 26 files changed, 122 insertions(+), 54 deletions(-)

Akihiko Odaki (1):
      platform/chrome: cros_ec_typec: Check for EC driver

Alex Williamson (1):
      vfio/platform: check the bounds of read/write syscalls

Andreas Gruenbacher (1):
      gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag

Anjaneyulu (1):
      wifi: iwlwifi: add a few rate index validity checks

Charles Keepax (3):
      ASoC: wm8994: Add depends on MFD core
      ASoC: samsung: Add missing selects for MFD_WM8994
      ASoC: samsung: Add missing depends on I2C

Cosmin Tanislav (1):
      regmap: detach regmap from dev on regmap_exit

Easwar Hariharan (1):
      scsi: storvsc: Ratelimit warning logs to prevent VM denial of service

Greg Kroah-Hartman (2):
      Revert "usb: gadget: u_serial: Disable ep before setting port to null to fix the crash caused by port being null"
      Linux 5.15.178

Ido Schimmel (1):
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()

Jack Greiner (1):
      Input: xpad - add support for wooting two he (arm)

Jamal Hadi Salim (1):
      net: sched: fix ets qdisc OOB Indexing

Konstantin Komarov (1):
      fs/ntfs3: Additional check in ntfs_file_release

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for USB Audio Device

Linus Walleij (1):
      seccomp: Stub for !CONFIG_SECCOMP

Luiz Augusto von Dentz (2):
      Bluetooth: SCO: Fix not validating setsockopt user input
      Bluetooth: RFCOMM: Fix not validating setsockopt user input

Mark Pearson (1):
      Input: atkbd - map F23 key to support default copilot shortcut

Maíra Canal (1):
      drm/v3d: Assign job pointer to NULL before signaling the fence

Nilton Perim Neto (1):
      Input: xpad - add unofficial Xbox 360 wireless receiver clone

Paolo Abeni (1):
      mptcp: don't always assume copied data in mptcp_cleanup_rbuf()

Philippe Simons (1):
      irqchip/sunxi-nmi: Add missing SKIP_WAKE flag

Qasim Ijaz (1):
      USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()

Xiang Zhang (1):
      scsi: iscsi: Fix redundant response for ISCSI_UEVENT_GET_HOST_STATS request



Return-Path: <stable+bounces-152284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DA1AD354F
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F401751D4
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C4220F47;
	Tue, 10 Jun 2025 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ExYFjnIT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C99155322;
	Tue, 10 Jun 2025 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749556122; cv=none; b=pni46a4428AZNbHSm+d1KqscBBR2mN8BpMD+UamWidBYplWGN0+BUrVxAjoIbEmqMvcRdYVu1NCfsUaO2KHSLeeyEcgXPBGhj5x/Y11yV3yPpmhpnS7us88/mLG4N7vNmdtG07cxn8P3ZzWATBcWkn2KLbhWDe2sxpmt4fQiygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749556122; c=relaxed/simple;
	bh=vAOn62Uj+SuAl4mo52JouJUDEOXtidvVRmfjR+ysBZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udhtgYnitRKilhtuoHpWzluHn+PnDCtCevzEZQXIh8Q7foaUALyz0fG0EAIVgd+HgTSaImCFYqu0L6AIfYyZnorMLjf93h46VYb+/0HOzo3Wcx73IDfD7urtaL6kbzO+W3zoNdKtqug2mOnu5BV8fyxdES4OLudFOtOaNvRYV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ExYFjnIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605C1C4CEF1;
	Tue, 10 Jun 2025 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749556121;
	bh=vAOn62Uj+SuAl4mo52JouJUDEOXtidvVRmfjR+ysBZg=;
	h=From:To:Cc:Subject:Date:From;
	b=ExYFjnITb9Cnm9ZSglb9hwz/fVxOuyWzhHAtf4ZBOi/ftc6antWkWl2Q0Ao9zEkSl
	 rNszlX0UPQXXZ2OOjeUqCkHyhZ7KdmgVl3cvciYjQkU3hICGqjKfqcWYnrOsbmPMxL
	 W++d3a2wKh9uQLLH/nYM4sNOJ6ou9MDMnDaY6vNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.14.11
Date: Tue, 10 Jun 2025 07:48:38 -0400
Message-ID: <2025061030-latticed-capacity-dc94@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-----------------
Note this is the LAST 6.14.y release.  This kernel branch is now end-of-life.
Please move to the 6.15.y kernel branch at this time.

If you notice, this has happened a bit more "early" than previous
end-of-life announcements.  Normally, after -rc1 is out there is a TON
of stable patches happening due to the changes that come into the
merge-window that were marked for stable backports but didn't get into
Linus's release before -final.  As some people have objected to this
large influx being added to a stable kernel that is just about to go
end-of-life, let's try marking this end-of-life a bit earlier to see how
it goes.

It might also spur maintainers/developers to get fixes into -final a bit
more as well :)
-----------------

I'm announcing the release of the 6.14.11 kernel.

All users of the 6.14 kernel series must upgrade.

The updated 6.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml  |    3 -
 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml      |   13 ++++-
 Documentation/devicetree/bindings/usb/cypress,hx3.yaml         |   19 ++++++-
 Documentation/firmware-guide/acpi/dsd/data-node-references.rst |   26 ++++------
 Documentation/firmware-guide/acpi/dsd/graph.rst                |   11 +---
 Documentation/firmware-guide/acpi/dsd/leds.rst                 |    7 --
 Makefile                                                       |    2 
 drivers/android/binder.c                                       |   16 +++++-
 drivers/android/binder_internal.h                              |    8 ++-
 drivers/android/binderfs.c                                     |    2 
 drivers/bluetooth/hci_qca.c                                    |   14 ++---
 drivers/clk/samsung/clk-exynosautov920.c                       |    2 
 drivers/cpufreq/acpi-cpufreq.c                                 |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |   16 +-----
 drivers/nvmem/Kconfig                                          |    1 
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c                    |   14 +++--
 drivers/rtc/class.c                                            |    2 
 drivers/rtc/lib.c                                              |   24 +++++++--
 drivers/thunderbolt/ctl.c                                      |    5 +
 drivers/tty/serial/jsm/jsm_tty.c                               |    1 
 drivers/usb/class/usbtmc.c                                     |    4 +
 drivers/usb/core/quirks.c                                      |    3 +
 drivers/usb/serial/pl2303.c                                    |    2 
 drivers/usb/storage/unusual_uas.h                              |    7 ++
 drivers/usb/typec/ucsi/ucsi.h                                  |    2 
 fs/orangefs/inode.c                                            |    9 +--
 kernel/trace/trace.c                                           |    2 
 27 files changed, 138 insertions(+), 79 deletions(-)

Alexandre Mergnat (2):
      rtc: Make rtc_time64_to_tm() support dates before 1970
      rtc: Fix offset calculation for .start_secs < 0

Arnd Bergmann (1):
      nvmem: rmem: select CONFIG_CRC32

Aurabindo Pillai (1):
      Revert "drm/amd/display: more liberal vmin/vmax update for freesync"

Bartosz Golaszewski (1):
      Bluetooth: hci_qca: move the SoC type check to the right place

Carlos Llamas (1):
      binder: fix yet another UAF in binder_devices

Charles Yeh (1):
      USB: serial: pl2303: add new chip PL2303GC-Q20 and PL2303GT-2AB

Dave Penkler (1):
      usb: usbtmc: Fix timeout value in get_stb

David Lechner (1):
      dt-bindings: pwm: adi,axi-pwmgen: Fix clocks

Dmitry Antipov (1):
      binder: fix use-after-free in binderfs_evict_inode()

Dustin Lundquist (1):
      serial: jsm: fix NPE during jsm_uart_port_init

Gabor Juhos (2):
      pinctrl: armada-37xx: use correct OUTPUT_VAL register for GPIOs > 31
      pinctrl: armada-37xx: set GPIO output value before setting direction

Gautham R. Shenoy (1):
      acpi-cpufreq: Fix nominal_freq units to KHz in get_max_boost_ratio()

Greg Kroah-Hartman (1):
      Linux 6.14.11

Hongyu Xie (1):
      usb: storage: Ignore UAS driver for SanDisk 3.2 Gen2 storage device

Jiayi Li (1):
      usb: quirks: Add NO_LPM quirk for SanDisk Extreme 55AE

Lukasz Czechowski (1):
      dt-bindings: usb: cypress,hx3: Add support for all variants

Mike Marshall (1):
      orangefs: adjust counting code to recover from 665575cf

Pan Taixi (1):
      tracing: Fix compilation warning on arm32

Pritam Manohar Sutar (1):
      clk: samsung: correct clock summary for hsi1 block

Qasim Ijaz (1):
      usb: typec: ucsi: fix Clang -Wsign-conversion warning

Sakari Ailus (1):
      Documentation: ACPI: Use all-string data node references

Sergey Senozhatsky (1):
      thunderbolt: Do not double dequeue a configuration request

Xu Yang (1):
      dt-bindings: phy: imx8mq-usb: fix fsl,phy-tx-vboost-level-microvolt property



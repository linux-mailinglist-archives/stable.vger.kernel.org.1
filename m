Return-Path: <stable+bounces-152280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B711AAD3522
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080653A9B28
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF46028C850;
	Tue, 10 Jun 2025 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OuCw6agm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996DD1A5BB2;
	Tue, 10 Jun 2025 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555493; cv=none; b=Kq9s7QC/wUHq2SwjATiWf1FXJKVWuUET61IveJ9Etn8L1ANtYrTgSCUfFKqyPS4sgvGD0YkByjk8iGZAA8Uyde+G0yjreMjXtrMEFUkmVLx9Cx2jNa3TS78x5tp32deEhWJQ3MbONLa8W9c+441lwXyLj30rAWAVYR3HoHu67+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555493; c=relaxed/simple;
	bh=SIHYTjuezSbanKT4D3HPERUFNRSZ/lTasSl61iViD6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pimejnmN6cUprUpYlDyHRrrTD0LMnfCYOFZ7v8/334gPjf5ba5FmkDUxq1JYmDrMUe5pgWXN7VxIpGG9fiP88pa/4gaQFKHtBw1j9Nz+JxiDXthgoEZl3o2B1JeeixpTjwASXgIAZ7YIc7Nia3qG1eAGQwlcor1ox5HYKLzQZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OuCw6agm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB370C4CEED;
	Tue, 10 Jun 2025 11:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749555492;
	bh=SIHYTjuezSbanKT4D3HPERUFNRSZ/lTasSl61iViD6o=;
	h=From:To:Cc:Subject:Date:From;
	b=OuCw6agmN8Si/KkcoJxjJApV4owB68PAKhH13obnYwRaexgImxhxMLTnC/HaimiG3
	 0RY9B3fR9IHPbGDDs+xUjI2H1NXwS55GeBpOZsdZ59kzD55/GF9IoKWLYMEDVEHKFo
	 2C9+5+00RjSRJlGdvEvT2V+srxs+IykHbWb7qSJA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.33
Date: Tue, 10 Jun 2025 07:38:08 -0400
Message-ID: <2025061009-unfasten-laurel-6109@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.33 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml  |    3 
 Documentation/devicetree/bindings/usb/cypress,hx3.yaml         |   19 +-
 Documentation/firmware-guide/acpi/dsd/data-node-references.rst |   26 +-
 Documentation/firmware-guide/acpi/dsd/graph.rst                |   11 -
 Documentation/firmware-guide/acpi/dsd/leds.rst                 |    7 
 Makefile                                                       |    2 
 block/bio.c                                                    |   11 -
 drivers/accel/ivpu/ivpu_drv.c                                  |    1 
 drivers/accel/ivpu/ivpu_drv.h                                  |   10 -
 drivers/accel/ivpu/ivpu_fw.c                                   |    3 
 drivers/accel/ivpu/ivpu_hw_40xx_reg.h                          |    2 
 drivers/accel/ivpu/ivpu_hw_ip.c                                |   49 +++--
 drivers/bluetooth/hci_qca.c                                    |   14 -
 drivers/cpufreq/acpi-cpufreq.c                                 |    2 
 drivers/cpufreq/tegra186-cpufreq.c                             |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |   16 -
 drivers/pci/pcie/aspm.c                                        |   92 +++++-----
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c                    |   14 -
 drivers/rtc/class.c                                            |    2 
 drivers/rtc/lib.c                                              |   24 ++
 drivers/thunderbolt/ctl.c                                      |    5 
 drivers/tty/serial/jsm/jsm_tty.c                               |    1 
 drivers/usb/class/usbtmc.c                                     |    4 
 drivers/usb/core/quirks.c                                      |    3 
 drivers/usb/serial/pl2303.c                                    |    2 
 drivers/usb/storage/unusual_uas.h                              |    7 
 drivers/usb/typec/ucsi/ucsi.h                                  |    2 
 fs/f2fs/inode.c                                                |    7 
 fs/f2fs/segment.h                                              |    9 
 kernel/trace/trace.c                                           |    2 
 30 files changed, 216 insertions(+), 141 deletions(-)

Ajay Agarwal (1):
      PCI/ASPM: Disable L1 before disabling L1 PM Substates

Alexandre Mergnat (2):
      rtc: Make rtc_time64_to_tm() support dates before 1970
      rtc: Fix offset calculation for .start_secs < 0

Aurabindo Pillai (1):
      Revert "drm/amd/display: more liberal vmin/vmax update for freesync"

Bartosz Golaszewski (1):
      Bluetooth: hci_qca: move the SoC type check to the right place

Chao Yu (1):
      f2fs: fix to avoid accessing uninitialized curseg

Charles Yeh (1):
      USB: serial: pl2303: add new chip PL2303GC-Q20 and PL2303GT-2AB

Dave Penkler (1):
      usb: usbtmc: Fix timeout value in get_stb

Dustin Lundquist (1):
      serial: jsm: fix NPE during jsm_uart_port_init

Gabor Juhos (2):
      pinctrl: armada-37xx: use correct OUTPUT_VAL register for GPIOs > 31
      pinctrl: armada-37xx: set GPIO output value before setting direction

Gautham R. Shenoy (1):
      acpi-cpufreq: Fix nominal_freq units to KHz in get_max_boost_ratio()

Greg Kroah-Hartman (1):
      Linux 6.12.33

Hongyu Xie (1):
      usb: storage: Ignore UAS driver for SanDisk 3.2 Gen2 storage device

Jiayi Li (1):
      usb: quirks: Add NO_LPM quirk for SanDisk Extreme 55AE

Jon Hunter (1):
      Revert "cpufreq: tegra186: Share policy per cluster"

Karol Wachowski (1):
      accel/ivpu: Update power island delays

Lukasz Czechowski (1):
      dt-bindings: usb: cypress,hx3: Add support for all variants

Maciej Falkowski (1):
      accel/ivpu: Add initial Panther Lake support

Ming Lei (1):
      block: fix adding folio to bio

Pan Taixi (1):
      tracing: Fix compilation warning on arm32

Qasim Ijaz (1):
      usb: typec: ucsi: fix Clang -Wsign-conversion warning

Sakari Ailus (1):
      Documentation: ACPI: Use all-string data node references

Sergey Senozhatsky (1):
      thunderbolt: Do not double dequeue a configuration request

Xu Yang (1):
      dt-bindings: phy: imx8mq-usb: fix fsl,phy-tx-vboost-level-microvolt property



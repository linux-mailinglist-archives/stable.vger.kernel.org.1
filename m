Return-Path: <stable+bounces-152282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32994AD352B
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFAA188CED7
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F843286896;
	Tue, 10 Jun 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJJ5yYhl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C5170A23;
	Tue, 10 Jun 2025 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555682; cv=none; b=am8mHeXsb485xnbR3gr2HyCdsMVIUWO8nCOkrR/EEvqVwn/nM23xT0lP5lYgjw6NJc7dLpvTe4zK3YvmwVk4sTWMjlVMaiwc95VLKpFvQVayoGh0NHl9eZQ8ARgeReFhiBOgk+xPPR7r/2WhPwRx5kXnYRIJKBmUn0H/iXoQ4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555682; c=relaxed/simple;
	bh=biUiOdFf2Huk8TgLEeW+ofnOieYsyJelV3pA1DB10G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ao/oxFCAqTBsH+Vlo11tuzwoxqDGRp3VlSnP8h2cmCfBMKTu7hflAtv1FQHTG1XFAa/Lo8d/NukgxB0W+IpPRgsxgahw47e9LOaf/iUdq9iF6361BYn8c4B00SL7rWXWGEA4JBOGxz7HIpI1N4mPihF9EIF6s2rd09S2Kf26DL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJJ5yYhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D62C4CEED;
	Tue, 10 Jun 2025 11:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749555681;
	bh=biUiOdFf2Huk8TgLEeW+ofnOieYsyJelV3pA1DB10G8=;
	h=From:To:Cc:Subject:Date:From;
	b=RJJ5yYhlMlRTh4J+pIT/1ydV8KiH9NMrnL+/cCYNIncZAfCkxWRKMQ/FIuIqB8S5Y
	 3DJpSsjEz11kh4MVDtfxwQr2Wt/OVxgNbRzWyWZDLZBWkeFDk0ejXGXH6X0WRokM6e
	 /uFb2ZyT/G/fnhn+DDuNBYAZ6JF8BV5LYYjnyTMo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.15.2
Date: Tue, 10 Jun 2025 07:41:18 -0400
Message-ID: <2025061018-coauthor-casualty-2986@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.15.2 kernel.

All users of the 6.15 kernel series must upgrade.

The updated 6.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml     |    3 
 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml         |   13 +
 Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml |    3 
 Documentation/devicetree/bindings/usb/cypress,hx3.yaml            |   19 ++
 Documentation/firmware-guide/acpi/dsd/data-node-references.rst    |   26 +--
 Documentation/firmware-guide/acpi/dsd/graph.rst                   |   11 -
 Documentation/firmware-guide/acpi/dsd/leds.rst                    |    7 
 Makefile                                                          |    2 
 arch/x86/kernel/smpboot.c                                         |   54 ++++++-
 drivers/acpi/acpica/acdebug.h                                     |    2 
 drivers/acpi/acpica/aclocal.h                                     |    4 
 drivers/acpi/acpica/nsnames.c                                     |    2 
 drivers/acpi/acpica/nsrepair2.c                                   |    2 
 drivers/android/binder.c                                          |   16 +-
 drivers/android/binder_internal.h                                 |    8 -
 drivers/android/binderfs.c                                        |    2 
 drivers/bluetooth/hci_qca.c                                       |   14 -
 drivers/clk/samsung/clk-exynosautov920.c                          |    2 
 drivers/cpufreq/acpi-cpufreq.c                                    |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                 |   16 --
 drivers/nvmem/Kconfig                                             |    1 
 drivers/pinctrl/mediatek/mtk-eint.c                               |   26 +--
 drivers/pinctrl/mediatek/mtk-eint.h                               |    5 
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c                  |    2 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c                     |    2 
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c                       |   14 +
 drivers/rtc/class.c                                               |    2 
 drivers/rtc/lib.c                                                 |   24 ++-
 drivers/thunderbolt/ctl.c                                         |    5 
 drivers/tty/serial/jsm/jsm_tty.c                                  |    1 
 drivers/usb/class/usbtmc.c                                        |    4 
 drivers/usb/core/quirks.c                                         |    3 
 drivers/usb/serial/pl2303.c                                       |    2 
 drivers/usb/storage/unusual_uas.h                                 |    7 
 drivers/usb/typec/ucsi/ucsi.h                                     |    2 
 fs/bcachefs/dirent.c                                              |   12 -
 fs/bcachefs/dirent.h                                              |    4 
 fs/bcachefs/errcode.h                                             |    2 
 fs/bcachefs/fs.c                                                  |    8 -
 fs/bcachefs/fsck.c                                                |    8 +
 fs/bcachefs/inode.c                                               |   77 ++++++----
 fs/bcachefs/namei.c                                               |    4 
 fs/bcachefs/sb-errors_format.h                                    |    4 
 fs/bcachefs/subvolume.c                                           |   19 +-
 include/acpi/actbl.h                                              |    6 
 include/acpi/actypes.h                                            |    4 
 include/acpi/platform/acgcc.h                                     |    8 +
 kernel/trace/trace.c                                              |    2 
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c          |    2 
 tools/power/acpi/tools/acpidump/apfiles.c                         |    2 
 50 files changed, 313 insertions(+), 157 deletions(-)

Ahmed Salem (1):
      ACPICA: Apply ACPI_NONSTRING in more places

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
      Linux 6.15.2

Hongyu Xie (1):
      usb: storage: Ignore UAS driver for SanDisk 3.2 Gen2 storage device

Jiayi Li (1):
      usb: quirks: Add NO_LPM quirk for SanDisk Extreme 55AE

Kees Cook (2):
      ACPICA: Introduce ACPI_NONSTRING
      ACPICA: Apply ACPI_NONSTRING

Kent Overstreet (5):
      bcachefs: Kill un-reverted directory i_size code
      bcachefs: Repair code for directory i_size
      bcachefs: delete dead code from may_delete_deleted_inode()
      bcachefs: Run may_delete_deleted_inode() checks in bch2_inode_rm()
      bcachefs: Fix subvol to missing root repair

Krzysztof Kozlowski (1):
      dt-bindings: remoteproc: qcom,sm8150-pas: Add missing SC8180X compatible

Lukasz Czechowski (1):
      dt-bindings: usb: cypress,hx3: Add support for all variants

Nícolas F. R. A. Prado (1):
      pinctrl: mediatek: eint: Fix invalid pointer dereference for v1 platforms

Pan Taixi (1):
      tracing: Fix compilation warning on arm32

Pritam Manohar Sutar (1):
      clk: samsung: correct clock summary for hsi1 block

Qasim Ijaz (1):
      usb: typec: ucsi: fix Clang -Wsign-conversion warning

Rafael J. Wysocki (1):
      Revert "x86/smp: Eliminate mwait_play_dead_cpuid_hint()"

Sakari Ailus (1):
      Documentation: ACPI: Use all-string data node references

Sergey Senozhatsky (1):
      thunderbolt: Do not double dequeue a configuration request

Xu Yang (1):
      dt-bindings: phy: imx8mq-usb: fix fsl,phy-tx-vboost-level-microvolt property



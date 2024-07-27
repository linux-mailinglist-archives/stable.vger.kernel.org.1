Return-Path: <stable+bounces-61950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 744B293DE38
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 11:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFC01F22266
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 09:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E34F88C;
	Sat, 27 Jul 2024 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HiVGgj5D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26106482FA;
	Sat, 27 Jul 2024 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722073288; cv=none; b=WtPDUR20pFHZLtaFbLwy35AT+Oyzh5qQ0Bjg9PJfljk26aWxrqJLOAAuw7f6k5WwQlHY68SLLR5/m6swwC8E1KFWk0W8g/aFjmxmad8kQy7/MRnFYaUAIMk/ZXuxz+BT04LnjNbRITA697aw/RzgR3yphZxdNE4U+vPmAdrX3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722073288; c=relaxed/simple;
	bh=EIZ621YQx4FgW36FHoAJQFfy9WVPXh9H5I4U3OGzVBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OmAhVPKjyuNo8xh/+UYqoZcOVCrjfvdeMwd+LBgrFyCCArO2eYLXnTw+VqV9Zy998MFOXCSoKNX0oFpJfuvjBwLR64RwR0B0s8UTlb6FZVn/kIrKLpeXD89MjKx4MclXCm5lgHnpVNndA6OyJsYHbYVKw9m0eppBt2d8dZUKUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HiVGgj5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4F3C32781;
	Sat, 27 Jul 2024 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722073287;
	bh=EIZ621YQx4FgW36FHoAJQFfy9WVPXh9H5I4U3OGzVBs=;
	h=From:To:Cc:Subject:Date:From;
	b=HiVGgj5DAIFIGPBKWMCQI/iCDQJ7PHpGITYYXWXL2xZw5rdUnlXGo+2XcbT+p2FvA
	 QuZ20y3Gv3EErKMX6h53fd/GiM9PEW5sllRiplI8S4QSCzOU7haa9YY3vJ6jDLANK+
	 z3UjUII8hDXMwQxQuTyS+8H1UywBdCP45oM513No=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.281
Date: Sat, 27 Jul 2024 11:41:22 +0200
Message-ID: <2024072723-smelting-recount-5627@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.281 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/arm/include/asm/uaccess.h                          |   14 ----
 arch/mips/kernel/syscalls/syscall_o32.tbl               |    2 
 arch/powerpc/kernel/eeh_pe.c                            |    7 +-
 arch/powerpc/kvm/book3s_64_vio.c                        |   18 ++++--
 arch/powerpc/platforms/pseries/setup.c                  |    4 -
 drivers/acpi/ec.c                                       |    9 ++-
 drivers/acpi/processor_idle.c                           |   40 +++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                  |    2 
 drivers/input/mouse/elantech.c                          |   31 ++++++++++
 drivers/input/touchscreen/silead.c                      |   19 +-----
 drivers/misc/mei/main.c                                 |    2 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c        |    2 
 drivers/net/tap.c                                       |    5 +
 drivers/net/tun.c                                       |    3 +
 drivers/net/usb/qmi_wwan.c                              |    2 
 drivers/s390/char/sclp.c                                |    1 
 drivers/scsi/libsas/sas_internal.h                      |   14 ++++
 drivers/scsi/qedf/qedf_main.c                           |    1 
 drivers/spi/spi-imx.c                                   |    2 
 fs/dcache.c                                             |   31 ++++------
 fs/file.c                                               |    4 -
 fs/hfsplus/xattr.c                                      |    2 
 fs/jfs/xattr.c                                          |   23 ++++++--
 fs/locks.c                                              |   18 ++----
 fs/ocfs2/dir.c                                          |   46 ++++++++++------
 net/bluetooth/hci_core.c                                |    4 +
 net/ipv4/af_inet.c                                      |    4 +
 net/ipv6/ila/ila_lwt.c                                  |    7 ++
 net/mac80211/mesh.c                                     |    1 
 net/mac80211/scan.c                                     |   14 +++-
 net/mac802154/tx.c                                      |    8 +-
 net/wireless/scan.c                                     |    8 ++
 scripts/gcc-plugins/gcc-common.h                        |    4 +
 scripts/kconfig/expr.c                                  |   29 ----------
 scripts/kconfig/expr.h                                  |    1 
 scripts/kconfig/gconf.c                                 |    3 -
 scripts/kconfig/menu.c                                  |    2 
 sound/core/pcm_dmaengine.c                              |   12 ++++
 sound/pci/hda/patch_realtek.c                           |    5 +
 sound/soc/intel/boards/bytcr_rt5640.c                   |   11 +++
 sound/soc/ti/davinci-mcasp.c                            |    9 ++-
 sound/soc/ti/omap-hdmi.c                                |    6 --
 tools/testing/selftests/vDSO/parse_vdso.c               |   16 +++--
 tools/testing/selftests/vDSO/vdso_standalone_test_x86.c |   18 +++++-
 45 files changed, 289 insertions(+), 177 deletions(-)

Alexander Usyskin (1):
      mei: demote client disconnect warning on suspend to debug

Anjali K (1):
      powerpc/pseries: Whitelist dtl slub object for copying to userspace

Armin Wolf (2):
      ACPI: EC: Abort address space access upon error
      ACPI: EC: Avoid returning AE_OK on errors in address space handler

Arnd Bergmann (1):
      mips: fix compat_sys_lseek syscall

Chen Ni (1):
      can: kvaser_usb: fix return value for hif_usb_send_regout

Christian Brauner (1):
      fs: better handle deep ancestor chains in is_subdir()

Dan Carpenter (1):
      drm/amdgpu: Fix signedness bug in sdma_v4_0_process_trap_irq()

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FN912 compositions

Dmitry Antipov (2):
      wifi: mac80211: fix UBSAN noise in ieee80211_prep_hw_scan()
      wifi: cfg80211: wext: add extra SIOCSIWSCAN data check

Dongli Zhang (1):
      tun: add missing verification for short frame

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Positivo SU C1400

Edward Adam Davis (1):
      hfsplus: fix uninit-value in copy_name

Eric Dumazet (1):
      ila: block BH in ila_output()

Ganesh Goudar (1):
      powerpc/eeh: avoid possible crash when edev->pdev changes

Greg Kroah-Hartman (1):
      Linux 5.4.281

Hans de Goede (1):
      Input: silead - Always support 10 fingers

Heiko Carstens (1):
      s390/sclp: Fix sclp_init() cleanup on failure

Jai Luthra (1):
      ASoC: ti: davinci-mcasp: Set min period size using FIFO config

Jann Horn (2):
      filelock: Remove locks reliably when fcntl/close race is detected
      filelock: Fix fcntl/close race recovery compat path

John Hubbard (1):
      selftests/vDSO: fix clang build errors and warnings

Jonathan Denose (1):
      Input: elantech - fix touchpad state on resume for Lenovo N24

Kailang Yang (1):
      ALSA: hda/realtek: Add more codec ID to no shutup pins list

Kees Cook (1):
      gcc-plugins: Rename last_stmt() for GCC 14+

Kuan-Wei Chiu (1):
      ACPI: processor_idle: Fix invalid comparison with insertion sort for latency

Masahiro Yamada (3):
      kconfig: gconf: give a proper initial state to the Save button
      kconfig: remove wrong expr_trans_bool()
      ARM: 9324/1: fix get_user() broken with veneer

Michael Ellerman (1):
      KVM: PPC: Book3S HV: Prevent UAF in kvm_spapr_tce_attach_iommu_group()

Nicolas Escande (1):
      wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata

Paolo Abeni (1):
      net: relax socket state check at accept time.

Primoz Fiser (1):
      ASoC: ti: omap-hdmi: Fix too long driver name

Saurav Kashyap (1):
      scsi: qedf: Set qed_slowpath_params to zero before use

Shengjiu Wang (1):
      ALSA: dmaengine_pcm: terminate dmaengine before synchronize

Si-Wei Liu (1):
      tap: add missing verification for short frame

Tetsuo Handa (1):
      Bluetooth: hci_core: cancel all works upon hci_unregister_dev()

Thomas GENTY (1):
      bytcr_rt5640 : inverse jack detect for Archos 101 cesium

Uwe Kleine-König (1):
      spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices

Xingui Yang (1):
      scsi: libsas: Fix exp-attached device scan after probe failure scanned in again after probe failed

Yunshui Jiang (1):
      net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()

Yuntao Wang (1):
      fs/file: fix the check in find_next_fd()

lei lu (2):
      ocfs2: add bounds checking to ocfs2_check_dir_entry()
      jfs: don't walk off the end of ealist



Return-Path: <stable+bounces-200931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4689CB97B1
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 18:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A51FD3092060
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BDF2F3C0F;
	Fri, 12 Dec 2025 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ThQh+Z+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC23A2F39AB;
	Fri, 12 Dec 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765561826; cv=none; b=tN4N+/boJ+18QjZjQWdzjC8ogcogRhsIojoTJg5lxRMENLnDz5MKyNNoSbQZHqCHEgwsmT3FsxJoj2JPPp9zTUy9PhvFEhTBn4VWim816ImZEAG8y81hSYo574O274OoRta4OCRQBKl376fr5HtmnAEzoX4RAc7M53KVDsDniXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765561826; c=relaxed/simple;
	bh=J+VAcHCCSkg2VbfN7m1GoaqfDFDGBdaLRmdZKrS9Eo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=stl0oo0ZtPdq6UKXo9wAQczgyt9ZhU/N2PBBtc+2cYhASkw0lp+XyTNB/8dIzkGve8xDsggnc/MP0aUy3388xhKM7Ky+dE7s8qmyP3PcM2zyJaKpTwj2pSxUJ5vjx0Mp4NU5eJqkqVucmzUQErPVEg26Am+aBBazKLL3qaYsdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ThQh+Z+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A1CC116B1;
	Fri, 12 Dec 2025 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765561825;
	bh=J+VAcHCCSkg2VbfN7m1GoaqfDFDGBdaLRmdZKrS9Eo4=;
	h=From:To:Cc:Subject:Date:From;
	b=ThQh+Z+4DCi0NaweTgpmKT4etb4qDzP4tnMj6U8mzfwk3Sx3RlKPItk2wbonLsCv7
	 PG1p/a1o1gVvTVzgzpvcdeyHw9SJaO9vKVBxOJkaVBrhx99w2rsWGRkdxAq7rAFcgm
	 wD8+x9UngkfHoBQ/PHFDPrfVcZDQ8uYlTUrdTJjA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.17.12
Date: Fri, 12 Dec 2025 18:50:17 +0100
Message-ID: <2025121218-tycoon-esophagus-4f22@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.17.12 kernel.

All users of the 6.17 kernel series must upgrade.

The updated 6.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.17.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/renesas,rsci.yaml     |    2 
 Documentation/process/2.Process.rst                            |    6 
 Makefile                                                       |    2 
 arch/arm64/include/asm/alternative.h                           |    7 
 arch/arm64/kernel/alternative.c                                |   19 +-
 arch/arm64/kernel/module.c                                     |    9 -
 arch/loongarch/kernel/machine_kexec.c                          |    2 
 arch/x86/include/asm/kvm_host.h                                |    9 +
 arch/x86/kvm/svm/svm.c                                         |   24 +--
 arch/x86/kvm/x86.c                                             |   21 ++
 crypto/zstd.c                                                  |    7 
 drivers/acpi/acpi_mrrm.c                                       |   43 ++++-
 drivers/bluetooth/btrtl.c                                      |   24 +--
 drivers/comedi/comedi_fops.c                                   |   42 +++++
 drivers/comedi/drivers/c6xdigio.c                              |   46 ++++--
 drivers/comedi/drivers/multiq3.c                               |    9 +
 drivers/comedi/drivers/pcl818.c                                |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                           |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c                     |   12 -
 drivers/hid/hid-apple.c                                        |    1 
 drivers/hid/hid-elecom.c                                       |    6 
 drivers/hid/hid-ids.h                                          |    4 
 drivers/hid/hid-input.c                                        |    5 
 drivers/hid/hid-lenovo.c                                       |   17 ++
 drivers/hid/hid-quirks.c                                       |    3 
 drivers/iio/adc/ad4080.c                                       |    9 -
 drivers/net/wireless/realtek/rtl8xxxu/core.c                   |    3 
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c                 |    2 
 drivers/nvme/host/core.c                                       |    3 
 drivers/pinctrl/qcom/pinctrl-msm.c                             |    2 
 drivers/platform/x86/acer-wmi.c                                |    4 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                      |   25 +++
 drivers/platform/x86/amd/pmc/pmc.c                             |    3 
 drivers/platform/x86/amd/pmc/pmc.h                             |    1 
 drivers/platform/x86/hp/hp-wmi.c                               |    6 
 drivers/platform/x86/huawei-wmi.c                              |    4 
 drivers/platform/x86/intel/hid.c                               |    1 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c |    4 
 drivers/spi/spi-imx.c                                          |   15 +-
 drivers/spi/spi-xilinx.c                                       |    2 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c                 |   14 +
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c                  |   13 +
 drivers/tty/serial/8250/8250_pci.c                             |   37 +++++
 drivers/tty/serial/sh-sci.c                                    |   12 +
 drivers/usb/serial/belkin_sa.c                                 |   28 ++-
 drivers/usb/serial/ftdi_sio.c                                  |   72 +++-------
 drivers/usb/serial/kobil_sct.c                                 |   18 +-
 drivers/usb/serial/option.c                                    |   22 ++-
 fs/bfs/inode.c                                                 |   19 ++
 fs/ext4/inline.c                                               |   14 +
 fs/jbd2/transaction.c                                          |   19 +-
 fs/smb/client/fs_context.c                                     |    2 
 fs/smb/server/transport_ipc.c                                  |    7 
 kernel/locking/spinlock_debug.c                                |    4 
 kernel/sched/ext.c                                             |    4 
 kernel/trace/ftrace.c                                          |   40 ++++-
 samples/vfs/test-statx.c                                       |    6 
 samples/watch_queue/watch_test.c                               |    6 
 sound/hda/codecs/realtek/alc269.c                              |    9 +
 sound/soc/sdca/sdca_functions.c                                |    3 
 sound/usb/quirks.c                                             |    6 
 61 files changed, 559 insertions(+), 207 deletions(-)

Adrian Barnaś (1):
      arm64: Reject modules with internal alternative callbacks

Alexander Sverdlin (1):
      locking/spinlock/debug: Fix data-race in do_raw_write_lock

Alexey Nepomnyashih (1):
      ext4: add i_data_sem protection in ext4_destroy_inline_data_nolock()

Alvaro Gamez Machado (1):
      spi: xilinx: increase number of retries before declaring stall

Antheas Kapenekakis (3):
      platform/x86/amd/pmc: Add support for Van Gogh SoC
      platform/x86/amd: pmc: Add Lenovo Legion Go 2 to pmc quirk list
      platform/x86/amd/pmc: Add spurious_8042 to Xbox Ally

Antoniu Miclaus (1):
      iio: adc: ad4080: fix chip identification

April Grimoire (1):
      HID: apple: Add SONiX AK870 PRO to non_apple_keyboards quirk list

Armin Wolf (1):
      platform/x86: acer-wmi: Ignore backlight event

Bagas Sanjaya (1):
      Documentation: process: Also mention Sasha Levin as stable tree maintainer

Baojun Xu (1):
      ALSA: hda/tas2781: Add new quirk for HP new projects

Biju Das (2):
      dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
      serial: sh-sci: Fix deadlock during RSCI FIFO overrun error

Deepanshu Kartikey (1):
      ext4: refresh inline data size before write operations

Edip Hazuri (1):
      platform/x86: hp-wmi: mark Victus 16-r0 and 16-s0 for victus_s fan and thermal profile support

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FE910C04 new compositions
      USB: serial: option: move Telit 0x10c7 composition in the right place

Giovanni Cabiddu (1):
      crypto: zstd - fix double-free in per-CPU stream cleanup

Greg Kroah-Hartman (1):
      Linux 6.17.12

Harish Kasiviswanathan (1):
      drm/amdkfd: Fix GPU mappings for APU after prefetch

Huacai Chen (1):
      LoongArch: Mask all interrupts during kexec/kdump

Ian Abbott (1):
      comedi: c6xdigio: Fix invalid PNP driver unregistration

Ian Forbes (1):
      drm/vmwgfx: Use kref in vmw_bo_dirty

Jia Ston (1):
      platform/x86: huawei-wmi: add keys for HONOR models

Johan Hovold (3):
      USB: serial: ftdi_sio: match on interface number for jtag
      USB: serial: belkin_sa: fix TIOCMBIS and TIOCMBIC
      USB: serial: kobil_sct: fix TIOCMBIS and TIOCMBIC

Kaushlendra Kumar (1):
      ACPI: MRRM: Fix memory leaks and improve error handling

Keith Busch (1):
      nvme: fix admin request_queue lifetime

Krishna Chomal (1):
      platform/x86: hp-wmi: Add Omen 16-wf1xxx fan support

Kuppuswamy Sathyanarayanan (1):
      platform/x86: intel-uncore-freq: Add additional client processors

Lauri Tirkkonen (1):
      HID: lenovo: fixup Lenovo Yoga Slim 7x Keyboard rdesc

Linus Torvalds (1):
      samples: work around glibc redefining some of our defines wrong

Lushih Hsieh (1):
      ALSA: usb-audio: Add native DSD quirks for PureAudio DAC series

Magne Bruno (1):
      serial: add support of CPCI cards

Marcos Vega (1):
      platform/x86: hp-wmi: Add Omen MAX 16-ah0xx fan support and thermal profile

Mario Limonciello (AMD) (1):
      HID: hid-input: Extend Elan ignore battery quirk to USB

Max Chou (1):
      Bluetooth: btrtl: Avoid loading the config file on security chips

Naoki Ueki (1):
      HID: elecom: Add support for ELECOM M-XT3URBK (018F)

Navaneeth K (3):
      staging: rtl8723bs: fix out-of-bounds read in rtw_get_ie() parser
      staging: rtl8723bs: fix stack buffer overflow in OnAssocReq IE parsing
      staging: rtl8723bs: fix out-of-bounds read in OnBeacon ESR IE parsing

Nikita Zhandarovich (3):
      comedi: pcl818: fix null-ptr-deref in pcl818_ai_cancel()
      comedi: multiq3: sanitize config options in multiq3_attach()
      comedi: check device's attached status in compat ioctls

Niranjan H Y (1):
      ASoC: SDCA: bug fix while parsing mipi-sdca-control-cn-list

Omar Sandoval (1):
      KVM: SVM: Don't skip unrelated instruction if INT3/INTO is replaced

Praveen Talari (1):
      pinctrl: qcom: msm: Fix deadlock in pinmux configuration

Qianchang Zhao (1):
      ksmbd: ipc: fix use-after-free in ipc_msg_send_request

Robin Gong (1):
      spi: imx: keep dma request disabled before dma transfer setup

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W760

Song Liu (1):
      ftrace: bpf: Fix IPMODIFY + DIRECT in modify_ftrace_direct()

Srinivas Pandruvada (1):
      platform/x86/intel/hid: Add Nova Lake support

Tetsuo Handa (1):
      bfs: Reconstruct file type when loading from disk

Ye Bin (1):
      jbd2: avoid bug_on in jbd2_journal_get_create_access() when file system corrupted

Yiqi Sun (1):
      smb: fix invalid username check in smb3_fs_context_parse_param()

Zenm Chen (2):
      wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link AN3U rev. A1
      wifi: rtw88: Add USB ID 2001:3329 for D-Link AC13U rev. A1

Zqiang (2):
      sched_ext: Fix possible deadlock in the deferred_irq_workfn()
      sched_ext: Use IRQ_WORK_INIT_HARD() to initialize rq->scx.kick_cpus_irq_work



Return-Path: <stable+bounces-200933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3E9CB97BA
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 18:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26979304356B
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAE42F39AB;
	Fri, 12 Dec 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JsqItGql"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BE82F2914;
	Fri, 12 Dec 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765561867; cv=none; b=Iy1MFBpVgqd8YHkHuLYTBQY1RmrLiut53KBCbDj+UWfJO8ZMOS4MaDdD5uP4Uf+AwDd8WuvFbDHuq5t6pzH7iny7m4xP4lWXt7QsiG9m7G6Y25IrsNS06VdSz1JiJUkzn3Uccc74XOAaua3BuTFUvemtyCuY49FYkCFkFCqiT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765561867; c=relaxed/simple;
	bh=kZBY40yGcDoLDt+x9x3oglEfgNAfaLaQdxkdn9LBtZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMbqoGxvARdClbYwp/i8qhgpDMAtQPDG61GNo3xqANApdcAlivHM8NnZ25qIXBeim062mVdgjm8Vaj6iHBSjv7Q3jkWfzEnnjfDlKVvgezj9Co1WcVsKN1lQ6l3auSrqrdzkn0cUxKIbDREBWNm9e1OhdsFlbho+7LE1Pz8lR44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JsqItGql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F21C4CEF1;
	Fri, 12 Dec 2025 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765561867;
	bh=kZBY40yGcDoLDt+x9x3oglEfgNAfaLaQdxkdn9LBtZc=;
	h=From:To:Cc:Subject:Date:From;
	b=JsqItGqleijsOSJ9BnG2Lrntgg/5/qf2d/ncVlM9gPpok6a2QPidm8cohPdVntyl8
	 uNyh0PDnrpGqqlmnXWl/reIK3/BWgn+5bwhyrQI8w7Cvm32SDkTiw57Q8FE2sSm7Wm
	 DTiDu58xxjZMjQgEqV8l47crpTcpZAQ13728u5uE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.1
Date: Fri, 12 Dec 2025 18:51:03 +0100
Message-ID: <2025121204-aptly-wages-e33d@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.1 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/renesas,rsci.yaml |    2 
 Documentation/process/2.Process.rst                        |    6 
 Documentation/tools/rtla/common_appendix.rst               |   24 --
 Documentation/tools/rtla/common_appendix.txt               |   24 ++
 Documentation/tools/rtla/common_hist_options.rst           |   23 --
 Documentation/tools/rtla/common_hist_options.txt           |   23 ++
 Documentation/tools/rtla/common_options.rst                |  119 -------------
 Documentation/tools/rtla/common_options.txt                |  119 +++++++++++++
 Documentation/tools/rtla/common_osnoise_description.rst    |    8 
 Documentation/tools/rtla/common_osnoise_description.txt    |    8 
 Documentation/tools/rtla/common_osnoise_options.rst        |   39 ----
 Documentation/tools/rtla/common_osnoise_options.txt        |   39 ++++
 Documentation/tools/rtla/common_timerlat_aa.rst            |    7 
 Documentation/tools/rtla/common_timerlat_aa.txt            |    7 
 Documentation/tools/rtla/common_timerlat_description.rst   |   18 -
 Documentation/tools/rtla/common_timerlat_description.txt   |   18 +
 Documentation/tools/rtla/common_timerlat_options.rst       |   67 -------
 Documentation/tools/rtla/common_timerlat_options.txt       |   67 +++++++
 Documentation/tools/rtla/common_top_options.rst            |    3 
 Documentation/tools/rtla/common_top_options.txt            |    3 
 Documentation/tools/rtla/rtla-hwnoise.rst                  |    8 
 Documentation/tools/rtla/rtla-osnoise-hist.rst             |   10 -
 Documentation/tools/rtla/rtla-osnoise-top.rst              |   10 -
 Documentation/tools/rtla/rtla-osnoise.rst                  |    4 
 Documentation/tools/rtla/rtla-timerlat-hist.rst            |   12 -
 Documentation/tools/rtla/rtla-timerlat-top.rst             |   12 -
 Documentation/tools/rtla/rtla-timerlat.rst                 |    4 
 Documentation/tools/rtla/rtla.rst                          |    2 
 Makefile                                                   |    2 
 arch/x86/include/asm/kvm_host.h                            |    9 
 arch/x86/kvm/svm/svm.c                                     |   24 +-
 arch/x86/kvm/x86.c                                         |   21 ++
 crypto/zstd.c                                              |    7 
 drivers/android/binder/node.rs                             |    6 
 drivers/comedi/comedi_fops.c                               |   42 +++-
 drivers/comedi/drivers/c6xdigio.c                          |   46 +++--
 drivers/comedi/drivers/multiq3.c                           |    9 
 drivers/comedi/drivers/pcl818.c                            |    5 
 drivers/iio/adc/ad4080.c                                   |    9 
 drivers/net/wireless/realtek/rtl8xxxu/core.c               |    3 
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c             |    2 
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c             |   14 -
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c              |   13 -
 drivers/tty/serial/8250/8250_pci.c                         |   37 ++++
 drivers/tty/serial/sh-sci.c                                |   12 +
 drivers/usb/serial/belkin_sa.c                             |   28 +--
 drivers/usb/serial/ftdi_sio.c                              |   72 ++-----
 drivers/usb/serial/kobil_sct.c                             |   18 -
 drivers/usb/serial/option.c                                |   22 ++
 fs/ext4/inline.c                                           |   14 +
 fs/jbd2/transaction.c                                      |   19 +-
 fs/smb/server/transport_ipc.c                              |    7 
 kernel/locking/spinlock_debug.c                            |    4 
 53 files changed, 650 insertions(+), 481 deletions(-)

Alexander Sverdlin (1):
      locking/spinlock/debug: Fix data-race in do_raw_write_lock

Alexey Nepomnyashih (1):
      ext4: add i_data_sem protection in ext4_destroy_inline_data_nolock()

Alice Ryhl (1):
      rust_binder: fix race condition on death_list

Antoniu Miclaus (1):
      iio: adc: ad4080: fix chip identification

Bagas Sanjaya (1):
      Documentation: process: Also mention Sasha Levin as stable tree maintainer

Biju Das (2):
      dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
      serial: sh-sci: Fix deadlock during RSCI FIFO overrun error

Deepanshu Kartikey (1):
      ext4: refresh inline data size before write operations

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FE910C04 new compositions
      USB: serial: option: move Telit 0x10c7 composition in the right place

Giovanni Cabiddu (1):
      crypto: zstd - fix double-free in per-CPU stream cleanup

Gopi Krishna Menon (1):
      Documentation/rtla: rename common_xxx.rst files to common_xxx.txt

Greg Kroah-Hartman (1):
      Linux 6.18.1

Ian Abbott (1):
      comedi: c6xdigio: Fix invalid PNP driver unregistration

Johan Hovold (3):
      USB: serial: ftdi_sio: match on interface number for jtag
      USB: serial: belkin_sa: fix TIOCMBIS and TIOCMBIC
      USB: serial: kobil_sct: fix TIOCMBIS and TIOCMBIC

Magne Bruno (1):
      serial: add support of CPCI cards

Navaneeth K (3):
      staging: rtl8723bs: fix out-of-bounds read in rtw_get_ie() parser
      staging: rtl8723bs: fix stack buffer overflow in OnAssocReq IE parsing
      staging: rtl8723bs: fix out-of-bounds read in OnBeacon ESR IE parsing

Nikita Zhandarovich (3):
      comedi: pcl818: fix null-ptr-deref in pcl818_ai_cancel()
      comedi: multiq3: sanitize config options in multiq3_attach()
      comedi: check device's attached status in compat ioctls

Omar Sandoval (1):
      KVM: SVM: Don't skip unrelated instruction if INT3/INTO is replaced

Qianchang Zhao (1):
      ksmbd: ipc: fix use-after-free in ipc_msg_send_request

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W760

Ye Bin (1):
      jbd2: avoid bug_on in jbd2_journal_get_create_access() when file system corrupted

Zenm Chen (2):
      wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link AN3U rev. A1
      wifi: rtw88: Add USB ID 2001:3329 for D-Link AC13U rev. A1



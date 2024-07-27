Return-Path: <stable+bounces-61948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B1393DE32
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 11:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BEF1F21EA8
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA747F4A;
	Sat, 27 Jul 2024 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P7YWI3MK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349343AAB;
	Sat, 27 Jul 2024 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722073275; cv=none; b=iNI19/+jMdhx4lWyt5lCu+/DpTkJt6ZEBPKFdD2AKFKLmT7kkhJu9K/d68h3UjgW203OAHDasJqbRX0wqyP021V62fYDcDTPvqloLcT+gUZRPKEq5Xed8wiYsaflbTPaK0PQFUgU/E+zrZEDcZSIx2s3doetfkxZfys4HhZVsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722073275; c=relaxed/simple;
	bh=YkHjFpVLhE2roKbikrqj3K6l5olY2ryZpudaZzUazLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T1J8v9ej8D5e7/HLsf6UuyEu7pfBMTOnS6BR/o3l4kMkymp51eMqMWMcpzdhMeFlg2jmGt4c5cGUycLtTTnfRIwm+RwhOwM+OzxQGBYKLdW+Bf35qaBOjiGEZGRS3jSHRlNA1hliL0T3CS1pL4k3XRTdW+oyggsoyfjv8Injlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P7YWI3MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12D4C32781;
	Sat, 27 Jul 2024 09:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722073275;
	bh=YkHjFpVLhE2roKbikrqj3K6l5olY2ryZpudaZzUazLE=;
	h=From:To:Cc:Subject:Date:From;
	b=P7YWI3MKHdPVN6/MDF6OHCOQr8zlrdSxV8GcwV7DW+P93NfgRYi/xW2pdqC2JlEVB
	 JpTC5mWKNGQAG6kGvYl7Lr9nQDDuicsijaaMSLRyFDzvtPIvuazjrlVngvuD0r+yNe
	 aIz0660tpDnxz3U57Aak+l7H7RTde1WSmM48TS2c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.319
Date: Sat, 27 Jul 2024 11:41:10 +0200
Message-ID: <2024072710-justly-cuddle-f141@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.319 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/arm/include/asm/uaccess.h                          |   14 ----
 drivers/acpi/ec.c                                       |    9 ++-
 drivers/acpi/processor_idle.c                           |   40 +++++--------
 drivers/input/mouse/elantech.c                          |   31 ++++++++++
 drivers/input/touchscreen/silead.c                      |   19 +-----
 drivers/misc/mei/main.c                                 |    2 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c        |    2 
 drivers/net/usb/qmi_wwan.c                              |    2 
 drivers/s390/char/sclp.c                                |    1 
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
 sound/soc/intel/boards/bytcr_rt5640.c                   |   11 +++
 tools/testing/selftests/vDSO/parse_vdso.c               |   16 +++--
 tools/testing/selftests/vDSO/vdso_standalone_test_x86.c |   18 +++++-
 34 files changed, 232 insertions(+), 159 deletions(-)

Alexander Usyskin (1):
      mei: demote client disconnect warning on suspend to debug

Armin Wolf (2):
      ACPI: EC: Abort address space access upon error
      ACPI: EC: Avoid returning AE_OK on errors in address space handler

Chen Ni (1):
      can: kvaser_usb: fix return value for hif_usb_send_regout

Christian Brauner (1):
      fs: better handle deep ancestor chains in is_subdir()

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FN912 compositions

Dmitry Antipov (2):
      wifi: mac80211: fix UBSAN noise in ieee80211_prep_hw_scan()
      wifi: cfg80211: wext: add extra SIOCSIWSCAN data check

Edward Adam Davis (1):
      hfsplus: fix uninit-value in copy_name

Eric Dumazet (1):
      ila: block BH in ila_output()

Greg Kroah-Hartman (1):
      Linux 4.19.319

Hans de Goede (1):
      Input: silead - Always support 10 fingers

Heiko Carstens (1):
      s390/sclp: Fix sclp_init() cleanup on failure

Jann Horn (2):
      filelock: Remove locks reliably when fcntl/close race is detected
      filelock: Fix fcntl/close race recovery compat path

John Hubbard (1):
      selftests/vDSO: fix clang build errors and warnings

Jonathan Denose (1):
      Input: elantech - fix touchpad state on resume for Lenovo N24

Kees Cook (1):
      gcc-plugins: Rename last_stmt() for GCC 14+

Kuan-Wei Chiu (1):
      ACPI: processor_idle: Fix invalid comparison with insertion sort for latency

Masahiro Yamada (3):
      kconfig: gconf: give a proper initial state to the Save button
      kconfig: remove wrong expr_trans_bool()
      ARM: 9324/1: fix get_user() broken with veneer

Nicolas Escande (1):
      wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata

Paolo Abeni (1):
      net: relax socket state check at accept time.

Saurav Kashyap (1):
      scsi: qedf: Set qed_slowpath_params to zero before use

Shengjiu Wang (1):
      ALSA: dmaengine_pcm: terminate dmaengine before synchronize

Tetsuo Handa (1):
      Bluetooth: hci_core: cancel all works upon hci_unregister_dev()

Thomas GENTY (1):
      bytcr_rt5640 : inverse jack detect for Archos 101 cesium

Uwe Kleine-König (1):
      spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices

Yunshui Jiang (1):
      net: mac802154: Fix racy device stats updates by DEV_STATS_INC() and DEV_STATS_ADD()

Yuntao Wang (1):
      fs/file: fix the check in find_next_fd()

lei lu (2):
      ocfs2: add bounds checking to ocfs2_check_dir_entry()
      jfs: don't walk off the end of ealist



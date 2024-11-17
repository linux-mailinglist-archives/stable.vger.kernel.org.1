Return-Path: <stable+bounces-93688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3AE9D0441
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 15:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF79B2195B
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4396E1DA10B;
	Sun, 17 Nov 2024 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Km+EIdyc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40251DA0FC;
	Sun, 17 Nov 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853127; cv=none; b=Sh3vh53pCkiSAYKwUAMG5HWh0TQT2xlSh7S1oFJMAqYwrT3utaK7ckWZ9FiRu3f59e1UHr3oiWQ2xKAburQQrOGxScqEhcgNC/T9D7OGRPRyM5m/lYGyibygHmz8n15mLpUWivAaf0Hp6YGL3olLoHEUDvUolJPgp1+T5czGB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853127; c=relaxed/simple;
	bh=G6sVVSrc9GgFqGxrSIJPNSqa6st4acqJYpxTioY3onY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDmUNS3Iw4MIRE4sTf1P4uRZ7Y5eb9i6orlr60azBtnaypkplCYxBzLHaLLpVRI2JPgdbsoUzZZ4B8nTNPxfDeBGOGwoXFKhHYL9fLh82+GgrqTlwls3uedS3bOUjlQVlg/rqX8YSJSDPy/CJBWA1sfn7TXLdFhyb1iGMLGvJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Km+EIdyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDA9C4CED7;
	Sun, 17 Nov 2024 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731853126;
	bh=G6sVVSrc9GgFqGxrSIJPNSqa6st4acqJYpxTioY3onY=;
	h=From:To:Cc:Subject:Date:From;
	b=Km+EIdycVTXXquCeNLn82yA/+Nd9go3EwIIvlbQMiW5cf6TG04HptkAvrvDT4fTqO
	 Udxog/DyD81/ktc5hXptCmXiM/40YIb3o9cTI1Rpnr9wpS9UF6Qw6RggXaubnFXgYm
	 6mVTy4e//xI8u649FKYnVuP2Q88NM8pMRDyo1nso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.173
Date: Sun, 17 Nov 2024 15:18:14 +0100
Message-ID: <2024111715-unearth-zipfile-a86d@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.173 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                      |    2 -
 arch/powerpc/platforms/powernv/opal-irqchip.c |    1 
 block/elevator.c                              |    4 +--
 drivers/crypto/marvell/cesa/hash.c            |   12 +++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h           |    4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c           |    4 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h           |    3 --
 drivers/hid/hid-ids.h                         |    1 
 drivers/hid/hid-lenovo.c                      |    8 +++++++
 drivers/hid/hid-multitouch.c                  |   13 ++++++++++++
 drivers/irqchip/irq-mscc-ocelot.c             |    4 +--
 drivers/md/raid10.c                           |   23 +++++++++++-----------
 drivers/net/usb/qmi_wwan.c                    |    1 
 drivers/vdpa/ifcvf/ifcvf_base.c               |    2 -
 fs/ocfs2/file.c                               |    9 +++++---
 fs/udf/directory.c                            |   27 ++++++++++++++++++--------
 fs/udf/udfdecl.h                              |    2 -
 io_uring/io_uring.c                           |    5 ++++
 kernel/bpf/verifier.c                         |    4 +--
 mm/memory.c                                   |   11 ++++++++++
 mm/slab_common.c                              |    2 -
 net/9p/client.c                               |   12 ++++++++++-
 sound/Kconfig                                 |    2 -
 23 files changed, 110 insertions(+), 46 deletions(-)

Alessandro Zanni (1):
      fs: Fix uninitialized value issue in from_kuid and from_kgid

Greg Kroah-Hartman (1):
      Linux 5.15.173

Hagar Hemdan (1):
      io_uring: fix possible deadlock in io_register_iowq_max_workers()

Hans de Goede (1):
      HID: lenovo: Add support for Thinkpad X1 Tablet Gen 3 keyboard

Herbert Xu (1):
      crypto: marvell/cesa - Disable hash algorithms

Ian Forbes (1):
      drm/vmwgfx: Limit display layout ioctl array size to VMWGFX_NUM_DISPLAY_UNITS

Jan Kara (2):
      udf: Allocate name buffer in directory iterator on heap
      udf: Avoid directory type conversion failure due to ENOMEM

Julian Vetter (1):
      sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML

Kenneth Albanowski (1):
      HID: multitouch: Add quirk for Logitech Bolt receiver w/ Casa touchpad

Li Nan (1):
      md/raid10: improve code of mrdev in raid10_sync_request

Linus Torvalds (1):
      9p: fix slab cache name creation for real

Michael Ellerman (1):
      powerpc/powernv: Free name on error in opal_event_init()

Pedro Falcato (1):
      9p: Avoid creating multiple slab caches with the same name

Qun-Wei Lin (1):
      mm: krealloc: Fix MTE false alarm in __do_krealloc

Reinhard Speyerer (1):
      net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition

Rik van Riel (1):
      bpf: use kvzmalloc to allocate BPF verifier environment

Sergey Matsievskiy (1):
      irqchip/ocelot: Fix trigger register address

Stefan Blum (1):
      HID: multitouch: Add support for B2402FVA track point

SurajSonawane2415 (1):
      block: Fix elevator_get_default() checking for NULL q->tag_set

WangYuli (1):
      HID: multitouch: Add quirk for HONOR MagicBook Art 14 touchpad

Yuan Can (1):
      vDPA/ifcvf: Fix pci_read_config_byte() return code handling

Yuanzheng Song (1):
      mm/memory: add non-anonymous page check in the copy_present_page()



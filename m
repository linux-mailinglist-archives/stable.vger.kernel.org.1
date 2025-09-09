Return-Path: <stable+bounces-179110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD3B5041A
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 19:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CE3188BEDA
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E246935A2BD;
	Tue,  9 Sep 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UbX6MPiq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538D3376BF;
	Tue,  9 Sep 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437833; cv=none; b=Fibd6ie8TN/LrO4sqGxhNmRlIvJIt3IJS3ypvD5vhvuYXLLDuNkCpIB1Je0u6vE2Txgn/Hv/Un5OMU+uUD3yVrYLxp+oNIjH+OXRYoUt0rpR0iuZ6/BQfLizq6wA6bDkIvYocfdFSlk2N9TVHhajrTR+Gt7hJxKpeDyEolxtAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437833; c=relaxed/simple;
	bh=UZU6hfXndsnQ6oXDXRhik44UXzuRx7di2NJWgi8veEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SLvVpPl7fJBGcgLd4tdCupHqn9BpT6l8lTA5+eHRRPPVy4sUc0ot3Xd2+mwaS1t76pFoyQhDSO79YpubGTBLLAV2vxRMQwh1i5nkDfnq6LjKeFcznShDhO7Toj4F3jpSH1c/mdPG8pp/kmnuNpb5cHSDe0MzIryEuWUJqBz/MXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UbX6MPiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9D3C4CEF8;
	Tue,  9 Sep 2025 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757437833;
	bh=UZU6hfXndsnQ6oXDXRhik44UXzuRx7di2NJWgi8veEA=;
	h=From:To:Cc:Subject:Date:From;
	b=UbX6MPiqdp1Gg6sdfnxvRrOLmWbu5v3XPFPzPOKktcQVj5xvMiy4lpGVYHs3zaPtV
	 gqzVBnkIMyq6DVoVCRnHNmSjQOz7SeK1gmYm/H+qgX5Yubo16QmevsDJxFfywoH0Gh
	 xXUylxOpgq2KAVoC/RIwJVLhvYihbzde/b4wjbww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.299
Date: Tue,  9 Sep 2025 19:10:27 +0200
Message-ID: <2025090928-grid-uncured-a227@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.299 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 -
 arch/powerpc/boot/util.S                          |    4 +-
 arch/x86/kvm/x86.c                                |   16 +++++++-
 drivers/dma/mediatek/mtk-cqdma.c                  |   10 ++---
 drivers/gpio/gpio-pca953x.c                       |    5 ++
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            |    5 --
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            |    5 --
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             |    5 --
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             |    5 --
 drivers/iio/chemical/pms7003.c                    |    5 +-
 drivers/iio/light/opt3001.c                       |    5 +-
 drivers/isdn/mISDN/dsp_hwec.c                     |    6 +--
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c |   20 ++++++-----
 drivers/net/ethernet/intel/e1000e/ethtool.c       |   10 +++--
 drivers/net/ethernet/intel/i40e/i40e_client.c     |    4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c       |   10 ++++-
 drivers/net/ethernet/xircom/xirc2ps_cs.c          |    2 -
 drivers/net/ppp/ppp_generic.c                     |    6 +--
 drivers/net/vmxnet3/vmxnet3_drv.c                 |    5 +-
 drivers/net/wireless/marvell/libertas/cfg.c       |    9 +++-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c   |    5 +-
 drivers/net/wireless/marvell/mwifiex/main.c       |    4 +-
 drivers/net/wireless/st/cw1200/sta.c              |    2 -
 drivers/pcmcia/rsrc_iodyn.c                       |    3 +
 drivers/pcmcia/rsrc_nonstatic.c                   |    4 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                    |   10 +++--
 drivers/spi/spi-fsl-lpspi.c                       |   15 ++++----
 fs/cifs/connect.c                                 |    5 ++
 kernel/sched/cpufreq_schedutil.c                  |   28 +++++++++++++--
 mm/khugepaged.c                                   |   14 +++++++
 mm/slub.c                                         |    7 +++
 net/atm/resources.c                               |    6 ++-
 net/ax25/ax25_in.c                                |    4 ++
 net/batman-adv/network-coding.c                   |    7 +++
 net/bluetooth/l2cap_sock.c                        |    3 +
 net/dsa/tag_ksz.c                                 |   22 +++++++++---
 net/ipv4/devinet.c                                |    7 +--
 net/ipv4/icmp.c                                   |    6 ++-
 net/ipv6/ip6_icmp.c                               |    6 ++-
 net/netfilter/nf_conntrack_helper.c               |    4 +-
 net/wireless/scan.c                               |    3 +
 scripts/gcc-plugins/gcc-common.h                  |   32 +++++++++++++++++
 scripts/gcc-plugins/randomize_layout_plugin.c     |   40 ++++++----------------
 sound/pci/hda/patch_hdmi.c                        |    1 
 sound/pci/hda/patch_realtek.c                     |    1 
 sound/usb/mixer_quirks.c                          |    2 +
 46 files changed, 249 insertions(+), 131 deletions(-)

Alex Deucher (1):
      drm/amdgpu: drop hw access in non-DC audio fini

Alok Tiwari (1):
      xirc2ps_cs: fix register access when enabling FullDuplex

Chris Chiu (1):
      ALSA: hda/realtek - Add new HP ZBook laptop with micmute led fixup

Cryolitia PukNgae (1):
      ALSA: usb-audio: Add mute TLV for playback volumes on some devices

Dan Carpenter (3):
      wifi: cw1200: cap SSID length in cw1200_do_join()
      wifi: libertas: cap SSID len in lbs_associate()
      ipv4: Fix NULL vs error pointer check in inet_blackhole_dev_init()

David Lechner (1):
      iio: chemical: pms7003: use aligned_s64 for timestamp

Dmitry Antipov (1):
      wifi: cfg80211: fix use-after-free in cmp_bss()

Emanuele Ghidoli (1):
      gpio: pca953x: fix IRQ storm on system wake up

Eric Dumazet (1):
      ax25: properly unshare skbs in ax25_kiss_rcv()

Fabian Bläse (1):
      icmp: fix icmp_ndo_send address translation for reply direction

Felix Fietkau (1):
      net: ethernet: mtk_eth_soc: fix tx vlan tag for llc packets

Greg Kroah-Hartman (1):
      Linux 5.4.299

Jakob Unterwurzacher (1):
      net: dsa: microchip: linearize skb for tail-tagging switches

Jann Horn (1):
      mm/khugepaged: fix ->anon_vma race

John Evans (1):
      scsi: lpfc: Fix buffer free/clear order in deferred receive path

Kees Cook (2):
      randstruct: gcc-plugin: Remove bogus void member
      randstruct: gcc-plugin: Fix attribute addition

Kuniyuki Iwashima (1):
      Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen()

Larisa Grigore (3):
      spi: spi-fsl-lpspi: Fix transmissions when using CONT
      spi: spi-fsl-lpspi: Set correct chip-select polarity bit
      spi: spi-fsl-lpspi: Reset FIFO and disable module on transfer abort

Li Qiong (1):
      mm/slub: avoid accessing metadata when pointer is invalid in object_err()

Luca Ceresoli (1):
      iio: light: opt3001: fix deadlock due to concurrent flag access

Ma Ke (1):
      pcmcia: Fix a NULL pointer dereference in __iodyn_find_io_region()

Miaoqian Lin (1):
      mISDN: Fix memory leak in dsp_hwec_enable()

Nathan Chancellor (1):
      powerpc: boot: Remove leading zero in label in udelay()

Phil Sutter (1):
      netfilter: conntrack: helper: Replace -EEXIST by -EBUSY

Pieter Van Trappen (1):
      net: dsa: microchip: update tag_ksz masks for KSZ9477 family

Qianfeng Rong (1):
      wifi: mwifiex: Initialize the chan_stats array to zero

Qingfang Deng (1):
      ppp: fix memory leak in pad_compress_skb

Qiu-ji Chen (2):
      dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()
      dmaengine: mediatek: Fix a flag reuse error in mtk_cqdma_tx_status()

Rafael J. Wysocki (1):
      cpufreq/sched: Explicitly synchronize limits_changed flag handling

Roman Smirnov (1):
      cifs: fix integer overflow in match_server()

Ronak Doshi (1):
      vmxnet3: update MTU after device quiesce

Rosen Penev (2):
      net: thunder_bgx: add a missing of_node_put
      net: thunder_bgx: decrement cleanup index before use

Sean Christopherson (1):
      KVM: x86: Take irqfds.lock when adding/deleting IRQ bypass producer

Stanislav Fort (1):
      batman-adv: fix OOB read/write in network-coding decode

Takashi Iwai (1):
      ALSA: hda/hdmi: Add pin fix for another HP EliteDesk 800 G4 model

Vitaly Lifshits (1):
      e1000e: fix heap overflow in e1000_set_eeprom

Wang Liang (1):
      net: atm: fix memory leak in atm_register_sysfs when device_register fail

Wentao Liang (1):
      pcmcia: Add error handling for add_interval() in do_validate_mem()

Zhen Ni (1):
      i40e: Fix potential invalid access when MAC list is empty



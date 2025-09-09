Return-Path: <stable+bounces-179112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1DB50422
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BA0189F4BD
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB84D35AAAB;
	Tue,  9 Sep 2025 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ym4r9maV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7449F33471D;
	Tue,  9 Sep 2025 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437842; cv=none; b=r0yX3LeaGzFptRSbkjjlzkqu0L9LzwWyXLGjnxK6LdNVUF3ZviS3ABk8oFuz6K0tOkCGyF+uAjYOczrm0SUJ3oLOe4Qbd2/B/xkhynhxLwp0YJDBa6btm2evd7E21wr6OvimJ7xH2ToWypZ5lFAwlSfEAj4QJMQ8au4Jd6SswZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437842; c=relaxed/simple;
	bh=PxBtM+kB0TF/f2jIOGAYU8I5HZtLVEk8tc71a2te5Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MX0QlFlaaOLokYaNW3MZVDAJc8exGVEIarJs2p6ZWjkUeCG+N20Z1Qj4Yrz7VV7FDy/qfyP6yEbBEHjXM670iQMLdnmLbuGwRPEP/ldyxwyzJYNHJZW+Zf35yiAP2WXOvxVDNCp4POvnE2rYMyp5xSJDYAQwM2E7OHeFPAOKiKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ym4r9maV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B27AC4CEF8;
	Tue,  9 Sep 2025 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757437842;
	bh=PxBtM+kB0TF/f2jIOGAYU8I5HZtLVEk8tc71a2te5Uk=;
	h=From:To:Cc:Subject:Date:From;
	b=Ym4r9maV/95PQnhmmhPMx4nc86HazTKp69v/uqkUOW4y8A6FRjoe4qyw50WkW2HSv
	 8ifImzHC6ycnhNueczNq8IA7hZhmrMl+Xq0FIELE5a2vH7Lh6V/5QJsoPD/mfHN5w5
	 1+3xAyyWrPp+663qEO3G+ST5vSm541LbPXC5qzUw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.243
Date: Tue,  9 Sep 2025 19:10:33 +0200
Message-ID: <2025090933-doorpost-refinery-730a@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.243 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                              |    2 
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts      |    9 ++--
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts  |    1 
 arch/x86/kvm/x86.c                                    |   18 ++++++--
 drivers/clk/qcom/gdsc.c                               |   21 ++++-----
 drivers/dma/mediatek/mtk-cqdma.c                      |   10 +---
 drivers/gpio/gpio-pca953x.c                           |    5 ++
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                |    5 --
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c                |    5 --
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                 |    5 --
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                 |    5 --
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c |    8 +--
 drivers/iio/chemical/pms7003.c                        |    5 +-
 drivers/iio/light/opt3001.c                           |    5 +-
 drivers/isdn/mISDN/dsp_hwec.c                         |    6 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c     |   20 +++++----
 drivers/net/ethernet/intel/e1000e/ethtool.c           |   10 +++-
 drivers/net/ethernet/intel/i40e/i40e_client.c         |    4 -
 drivers/net/ethernet/mediatek/mtk_eth_soc.c           |   10 ++++
 drivers/net/ethernet/xircom/xirc2ps_cs.c              |    2 
 drivers/net/phy/microchip.c                           |   30 +------------
 drivers/net/phy/microchip_t1.c                        |   28 +++++++++---
 drivers/net/ppp/ppp_generic.c                         |    6 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                     |    5 +-
 drivers/net/wireless/marvell/libertas/cfg.c           |    9 ++--
 drivers/net/wireless/marvell/mwifiex/cfg80211.c       |    5 +-
 drivers/net/wireless/marvell/mwifiex/main.c           |    4 -
 drivers/net/wireless/st/cw1200/sta.c                  |    2 
 drivers/pcmcia/rsrc_iodyn.c                           |    3 +
 drivers/pcmcia/rsrc_nonstatic.c                       |    4 +
 drivers/scsi/lpfc/lpfc_nvmet.c                        |   10 ++--
 drivers/spi/spi-fsl-lpspi.c                           |   15 +++---
 drivers/tee/tee_shm.c                                 |    6 ++
 fs/cifs/connect.c                                     |    5 ++
 kernel/sched/cpufreq_schedutil.c                      |   28 ++++++++++--
 mm/khugepaged.c                                       |   15 ++++++
 mm/slub.c                                             |    7 ++-
 net/atm/resources.c                                   |    6 +-
 net/ax25/ax25_in.c                                    |    4 +
 net/batman-adv/network-coding.c                       |    7 ++-
 net/bluetooth/l2cap_sock.c                            |    3 +
 net/dsa/tag_ksz.c                                     |   22 +++++++--
 net/ipv4/devinet.c                                    |    7 +--
 net/ipv4/icmp.c                                       |    6 +-
 net/ipv6/ip6_icmp.c                                   |    6 +-
 net/netfilter/nf_conntrack_helper.c                   |    4 -
 net/wireless/scan.c                                   |    3 -
 scripts/gcc-plugins/gcc-common.h                      |   32 ++++++++++++++
 scripts/gcc-plugins/randomize_layout_plugin.c         |   40 +++++-------------
 sound/pci/hda/patch_hdmi.c                            |    1 
 sound/pci/hda/patch_realtek.c                         |    1 
 sound/usb/mixer_quirks.c                              |    2 
 52 files changed, 301 insertions(+), 181 deletions(-)

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

Fiona Klute (1):
      net: phy: microchip: force IRQ polling mode for lan88xx

Gabor Juhos (1):
      arm64: dts: marvell: uDPU: define pinctrl state for alarm LEDs

Greg Kroah-Hartman (1):
      Linux 5.10.243

Ioana Ciornei (2):
      net: phy: microchip: implement generic .handle_interrupt() callback
      net: phy: microchip: remove the use of .ack_interrupt()

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

Pei Xiao (1):
      tee: fix NULL pointer dereference in tee_shm_put

Peter Robinson (1):
      arm64: dts: rockchip: Add vcc-supply to SPI flash on rk3399-pinebook-pro

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

Taniya Das (1):
      clk: qcom: gdsc: Set retain_ff before moving to HW CTRL

Timur Kristóf (1):
      drm/amd/display: Don't warn when missing DCE encoder caps

Vitaly Lifshits (1):
      e1000e: fix heap overflow in e1000_set_eeprom

Wang Liang (1):
      net: atm: fix memory leak in atm_register_sysfs when device_register fail

Wentao Liang (1):
      pcmcia: Add error handling for add_interval() in do_validate_mem()

Zhen Ni (1):
      i40e: Fix potential invalid access when MAC list is empty



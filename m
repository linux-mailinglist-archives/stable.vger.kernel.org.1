Return-Path: <stable+bounces-217448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD94Oj4ul2k1vgIAu9opvQ
	(envelope-from <stable+bounces-217448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:37:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B05C1603EF
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9C5C30848C2
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D52346A19;
	Thu, 19 Feb 2026 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oE2MtEv+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47149345CAE;
	Thu, 19 Feb 2026 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515324; cv=none; b=hYRdxaGj43C3wOFsWAjEn6zGkjmHWKnMiF+8oITz6jIrPhdKaOnzZ1/RDzt72beb2ZIi0pi9JT8fDC6nRZhuGrvDFmXiPdtLManr33kdaUPoKp/EPZNymVL88Wcvf77mv6Hkeb3ZX+hKwUnMAVCZeFanwPzYZBi2xIr6g2Cr48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515324; c=relaxed/simple;
	bh=2a1ZmJA55cA0dl9MTl98N4eIkMow791235cbG01/9JE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wr/6si4FqvgkB0P0F1djk5jJ3FgEt/iNa5uNgfC70YcqeOQyiSK6hpolnUQnIuQLLsZ/6nSZw0jWY0a/QmCrPIUmk4z3UIeHrid4knJVz1mkBdjRlDoi0A+sH0+o8riFy/o3NhDPHETOfs+1Yv9ItTX7cdRhjlPaHfyiaAD3LFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oE2MtEv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFE3C4CEF7;
	Thu, 19 Feb 2026 15:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771515324;
	bh=2a1ZmJA55cA0dl9MTl98N4eIkMow791235cbG01/9JE=;
	h=From:To:Cc:Subject:Date:From;
	b=oE2MtEv+639pBsnYTTfuUQSMUwaAynkb1oAXPGFlCYuamjlp1N8mzUTY7w7TaG2U/
	 05QPc3HITbq9/LUsWJbkasAw2R0Dzt0HWnd1X5rROHWT7naqJb5+89Xj5xz0uUMASa
	 p5UKm4WSF1dDxTKp3x4v3MANYeDU/VGu96hVrYsM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.201
Date: Thu, 19 Feb 2026 16:35:14 +0100
Message-ID: <2026021915-finalist-satisfy-bda6@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217448-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B05C1603EF
X-Rspamd-Action: no action

I'm announcing the release of the 5.15.201 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/PCI/endpoint/pci-ntb-howto.rst      |   11 
 Makefile                                          |    2 
 drivers/bus/fsl-mc/fsl-mc-bus.c                   |   10 
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c |    2 
 drivers/crypto/omap-crypto.c                      |    2 
 drivers/crypto/virtio/virtio_crypto_algs.c        |    2 
 drivers/crypto/virtio/virtio_crypto_core.c        |    5 
 drivers/gpio/gpio-omap.c                          |   22 
 drivers/gpio/gpio-sprd.c                          |    8 
 drivers/gpio/gpiolib-acpi.c                       |    1 
 drivers/gpu/drm/tegra/hdmi.c                      |    4 
 drivers/gpu/drm/tegra/sor.c                       |    4 
 drivers/net/wireguard/device.c                    |    1 
 drivers/pci/endpoint/pci-ep-cfs.c                 |   54 --
 drivers/platform/x86/classmate-laptop.c           |   32 +
 drivers/platform/x86/panasonic-laptop.c           |    4 
 drivers/scsi/qla2xxx/qla_bsg.c                    |   25 
 drivers/scsi/qla2xxx/qla_def.h                    |   50 +
 drivers/scsi/qla2xxx/qla_gbl.h                    |    9 
 drivers/scsi/qla2xxx/qla_gs.c                     |  578 +++++++---------------
 drivers/scsi/qla2xxx/qla_init.c                   |   31 -
 drivers/scsi/qla2xxx/qla_isr.c                    |   29 -
 drivers/scsi/qla2xxx/qla_os.c                     |   18 
 drivers/usb/serial/option.c                       |    6 
 drivers/video/fbdev/riva/riva_hw.c                |    3 
 drivers/video/fbdev/smscufx.c                     |    8 
 fs/btrfs/block-group.c                            |    6 
 fs/btrfs/space-info.c                             |   20 
 fs/btrfs/space-info.h                             |    6 
 fs/cifs/cifs_dfs_ref.c                            |   16 
 fs/f2fs/data.c                                    |   12 
 fs/f2fs/sysfs.c                                   |   65 ++
 fs/ksmbd/transport_tcp.c                          |    3 
 fs/nilfs2/sufile.c                                |    4 
 fs/romfs/super.c                                  |    5 
 net/dsa/dsa2.c                                    |   21 
 net/mptcp/pm_netlink.c                            |   16 
 sound/pci/hda/patch_realtek.c                     |    4 
 sound/soc/fsl/fsl_xcvr.c                          |    3 
 tools/testing/selftests/net/mptcp/pm_netlink.sh   |    4 
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |   11 
 41 files changed, 571 insertions(+), 546 deletions(-)

Alban Bedel (1):
      gpiolib: acpi: Fix gpio count with string references

Anil Gurumurthy (5):
      scsi: qla2xxx: Validate sp before freeing associated memory
      scsi: qla2xxx: Delay module unload while fabric scan in progress
      scsi: qla2xxx: Query FW again before proceeding with login
      scsi: qla2xxx: Fix bsg_done() causing double free
      scsi: qla2xxx: Free sp in error path to fix system crash

Bibo Mao (2):
      crypto: virtio - Add spinlock protection with virtqueue notification
      crypto: virtio - Remove duplicated virtqueue_kick in virtio_crypto_skcipher_crypt_req

Boris Burkov (1):
      btrfs: fix racy bitfield write in btrfs_clear_space_info_full()

Brahmajit Das (1):
      drm/tegra: hdmi: sor: Fix error: variable ‘j’ set but not used

Chao Yu (1):
      f2fs: fix to avoid UAF in f2fs_write_end_io()

Chelsy Ratnawat (1):
      bus: fsl-mc: Replace snprintf and sprintf with sysfs_emit in sysfs show functions

Christophe JAILLET (1):
      PCI: endpoint: Remove unused field in struct pci_epf_group

Damien Le Moal (1):
      PCI: endpoint: Automatically create a function specific attributes group

Daniel Borkmann (1):
      Revert "wireguard: device: enable threaded NAPI"

Danilo Krummrich (1):
      gpio: omap: do not register driver in probe()

Deepanshu Kartikey (1):
      romfs: check sb_set_blocksize() return value

Edward Adam Davis (1):
      nilfs2: Fix potential block overflow that cause system hang

Eric Dumazet (1):
      mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()

Fabio Porcedda (1):
      USB: serial: option: add Telit FN920C04 RNDIS compositions

Gleb Chesnokov (1):
      scsi: qla2xxx: Use named initializers for port_[d]state_str

Greg Kroah-Hartman (2):
      fbdev: smscufx: properly copy ioctl memory to kernelspace
      Linux 5.15.201

Guangshuo Li (1):
      fbdev: rivafb: fix divide error in nv3_arb()

Gui-Dong Han (1):
      bus: fsl-mc: fix use-after-free in driver_override_show()

Henrique Carvalho (1):
      smb: server: fix leak of active_num_conn in ksmbd_tcp_new_connection()

Kees Cook (1):
      crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY scatterlists correctly

Liu Song (1):
      PCI: endpoint: Avoid creating sub-groups asynchronously

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: pm: ensure unknown flags are ignored

Paulo Alcantara (1):
      smb: client: set correct id, uid and cruid for multiuser automounts

Quinn Tran (2):
      scsi: qla2xxx: Remove dead code (GNN ID)
      scsi: qla2xxx: Reduce fabric scan duplicate code

Rafael J. Wysocki (2):
      platform/x86: classmate-laptop: Add missing NULL pointer checks
      platform/x86: panasonic-laptop: Fix sysfs group leak in error path

Thorsten Blum (1):
      crypto: octeontx - Fix length check to avoid truncation in ucode_load_store

Tim Guttzeit (1):
      ALSA: hda/realtek: Fix headset mic for TongFang X6AR55xU

Vladimir Oltean (1):
      net: dsa: free routing table on probe failure

Xuewen Yan (1):
      gpio: sprd: Change sprd_gpio lock to raw_spin_lock

Yongpeng Yang (1):
      f2fs: fix out-of-bounds access in sysfs attribute read/write

Ziyi Guo (1):
      ASoC: fsl_xcvr: fix missing lock in fsl_xcvr_mode_put()



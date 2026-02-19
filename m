Return-Path: <stable+bounces-217451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIl9NxAvl2kcvgIAu9opvQ
	(envelope-from <stable+bounces-217451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:41:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A17C160448
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8DAA300AECF
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BA0347BC6;
	Thu, 19 Feb 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ByFlaBL8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84906346FA7;
	Thu, 19 Feb 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515656; cv=none; b=FBN9hp8oyxiIOzlX1x2DgoNQsR0VlSTzZ/2FXc/7jJyJ8nuugijmypAUJqv825pWlL6CSRCFzVKgHNlTF34BCz4N+lMl+aehFb/GD3JWA/c/ZjqzPgS/+uklCaq+hghHuqLqa6PVsV8vT8oU1AyLGMfbMTFMSMViWSQ/dfpWMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515656; c=relaxed/simple;
	bh=1aMnFXp4sWU81tdi7tt4Fwb2f4c9Ti/XtsMt/tCQJzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QEDDKYbPvgoq3GGsXJV3/SGBNHhRrI6viQS2CRkb6Am2qDskZ0CUFWW1ogo0esOh+725Yf67+IzOC+nq3RWo4V/xq+AYWHY9chBoYen+Q9GNk3Gz0MkHXxsGHqcuJfMK+H0MG4aeLkBg1IO6VFIlp8EB0xaeWilGGZ1AaEoMa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ByFlaBL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C13C4CEF7;
	Thu, 19 Feb 2026 15:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771515656;
	bh=1aMnFXp4sWU81tdi7tt4Fwb2f4c9Ti/XtsMt/tCQJzc=;
	h=From:To:Cc:Subject:Date:From;
	b=ByFlaBL80FzqeOOgoeFJzYxesiQja82qV5xGP/fl7NC1fCf6sNETgoLQK4NBauuQX
	 m75OQe+BNsfwcMtWdH08eUZ0eZGtrv5BzU2b6RA71gFOig1rPGITkaavg4J3XGSJ4v
	 pk7blMqmFxJw6k+8ELzzF7VkH/viRJ2fJx1C0NpA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.164
Date: Thu, 19 Feb 2026 16:40:51 +0100
Message-ID: <2026021952-half-citrus-cf38@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217451-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5A17C160448
X-Rspamd-Action: no action

I'm announcing the release of the 6.1.164 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/PCI/endpoint/pci-ntb-howto.rst        |   11 
 Documentation/PCI/endpoint/pci-vntb-howto.rst       |   13 
 Makefile                                            |    2 
 drivers/acpi/apei/ghes.c                            |   10 
 drivers/base/cacheinfo.c                            |   19 
 drivers/bus/fsl-mc/fsl-mc-bus.c                     |   10 
 drivers/clk/mediatek/clk-mtk.c                      |    7 
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c   |    2 
 drivers/crypto/omap-crypto.c                        |    2 
 drivers/crypto/virtio/virtio_crypto_core.c          |    5 
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c |    2 
 drivers/gpio/gpio-omap.c                            |   22 
 drivers/gpio/gpio-sprd.c                            |    8 
 drivers/gpio/gpiolib-acpi.c                         |    1 
 drivers/gpu/drm/tegra/hdmi.c                        |    4 
 drivers/gpu/drm/tegra/sor.c                         |    4 
 drivers/net/bareudp.c                               |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |   11 
 drivers/net/geneve.c                                |    4 
 drivers/net/phy/sfp.c                               |    2 
 drivers/net/wireguard/device.c                      |    1 
 drivers/pci/endpoint/pci-ep-cfs.c                   |   54 -
 drivers/platform/x86/classmate-laptop.c             |   32 +
 drivers/platform/x86/panasonic-laptop.c             |    4 
 drivers/scsi/qla2xxx/qla_bsg.c                      |   28 
 drivers/scsi/qla2xxx/qla_def.h                      |   17 
 drivers/scsi/qla2xxx/qla_gbl.h                      |    9 
 drivers/scsi/qla2xxx/qla_gs.c                       |  581 ++++++--------------
 drivers/scsi/qla2xxx/qla_init.c                     |   40 -
 drivers/scsi/qla2xxx/qla_isr.c                      |   19 
 drivers/scsi/qla2xxx/qla_os.c                       |   18 
 drivers/usb/serial/option.c                         |    6 
 drivers/video/fbdev/riva/riva_hw.c                  |    3 
 drivers/video/fbdev/smscufx.c                       |    8 
 fs/btrfs/block-group.c                              |    6 
 fs/btrfs/space-info.c                               |   22 
 fs/btrfs/space-info.h                               |    6 
 fs/f2fs/data.c                                      |   12 
 fs/f2fs/node.c                                      |   14 
 fs/f2fs/sysfs.c                                     |   61 +-
 fs/nfsd/nfsctl.c                                    |    9 
 fs/nfsd/stats.c                                     |    4 
 fs/nfsd/stats.h                                     |    2 
 fs/nilfs2/sufile.c                                  |    4 
 fs/romfs/super.c                                    |    5 
 fs/smb/client/cached_dir.h                          |    8 
 fs/smb/client/cifs_dfs_ref.c                        |   16 
 fs/smb/server/server.c                              |    6 
 fs/smb/server/smb2pdu.c                             |   10 
 fs/smb/server/transport_tcp.c                       |    3 
 include/net/ip_tunnels.h                            |   13 
 include/net/xdp_sock.h                              |    2 
 include/net/xsk_buff_pool.h                         |    2 
 kernel/cgroup/cpuset.c                              |    2 
 net/devlink/leftover.c                              |    4 
 net/dsa/dsa2.c                                      |   21 
 net/mptcp/pm_netlink.c                              |   16 
 net/mptcp/protocol.c                                |   24 
 net/mptcp/protocol.h                                |    3 
 net/wireless/reg.c                                  |    5 
 net/xdp/xsk.c                                       |    6 
 net/xdp/xsk_buff_pool.c                             |    1 
 sound/pci/hda/patch_realtek.c                       |    5 
 sound/soc/amd/yc/acp6x-mach.c                       |    7 
 sound/soc/codecs/cs35l45.c                          |    2 
 sound/soc/fsl/fsl_xcvr.c                            |    3 
 sound/soc/intel/boards/sof_es8336.c                 |    9 
 tools/testing/selftests/net/mptcp/mptcp_join.sh     |  111 +++
 tools/testing/selftests/net/mptcp/pm_netlink.sh     |    4 
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c       |   11 
 70 files changed, 780 insertions(+), 622 deletions(-)

Alban Bedel (1):
      gpiolib: acpi: Fix gpio count with string references

Alexander Wetzel (1):
      wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()

Anatolii Shirykalov (1):
      ASoC: amd: yc: Add ASUS ExpertBook PM1503CDA to quirks list

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

Bosi Zhang (1):
      clk: mediatek: fix of_iomap memory leak

Brahmajit Das (1):
      drm/tegra: hdmi: sor: Fix error: variable ‘j’ set but not used

Chao Yu (1):
      f2fs: fix to avoid UAF in f2fs_write_end_io()

Chelsy Ratnawat (1):
      bus: fsl-mc: Replace snprintf and sprintf with sysfs_emit in sysfs show functions

Chen Ridong (1):
      cpuset: Fix missing adaptation for cpuset_is_populated

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

Greg Kroah-Hartman (2):
      fbdev: smscufx: properly copy ioctl memory to kernelspace
      Linux 6.1.164

Guangshuo Li (1):
      fbdev: rivafb: fix divide error in nv3_arb()

Gui-Dong Han (1):
      bus: fsl-mc: fix use-after-free in driver_override_show()

Henrique Carvalho (2):
      smb: client: split cached_fid bitfields to avoid shared-byte RMW races
      smb: server: fix leak of active_num_conn in ksmbd_tcp_new_connection()

Jeff Layton (1):
      nfsd: don't ignore the return code of svc_proc_register()

Kees Cook (1):
      crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY scatterlists correctly

Liu Song (1):
      PCI: endpoint: Avoid creating sub-groups asynchronously

Marek Behún (1):
      net: sfp: Fix quirk for Ubiquiti U-Fiber Instant SFP module

Matthieu Baerts (NGI0) (4):
      selftests: mptcp: pm: ensure unknown flags are ignored
      selftests: mptcp: check no dup close events after error
      selftests: mptcp: check subflow errors in close events
      selftests: mptcp: join: fix local endp not being tracked

Menglong Dong (1):
      net: tunnel: make skb_vlan_inet_prepare() return drop reasons

Namjae Jeon (2):
      ksmbd: fix infinite loop caused by next_smb2_rcv_hdr_off reset in error paths
      ksmbd: set ATTR_CTIME flags when setting mtime

Paolo Abeni (2):
      mptcp: schedule rtx timer only after pushing data
      mptcp: ensure context reset on disconnect()

Paulo Alcantara (1):
      smb: client: set correct id, uid and cruid for multiuser automounts

Pierre Gondois (2):
      cacheinfo: Decrement refcount in cache_setup_of_node()
      cacheinfo: Remove of_node_put() for fw_token

Qingfang Deng (1):
      net: stmmac: Fix accessing freed irq affinity_hint

Quinn Tran (2):
      scsi: qla2xxx: Remove dead code (GNN ID)
      scsi: qla2xxx: Reduce fabric scan duplicate code

Rafael J. Wysocki (2):
      platform/x86: classmate-laptop: Add missing NULL pointer checks
      platform/x86: panasonic-laptop: Fix sysfs group leak in error path

Ricardo Rivera-Matos (1):
      ASoC: cs35l45: Corrects ASP_TX5 DAPM widget channel

Shay Drory (1):
      devlink: rate: Unset parent pointer in devl_rate_nodes_destroy

Shreyas Deodhar (1):
      scsi: qla2xxx: Allow recovery for tape devices

Shuai Xue (1):
      ACPI: APEI: send SIGBUS to current task if synchronous memory error not recovered

Tagir Garaev (1):
      ASoC: Intel: sof_es8336: Add DMI quirk for Huawei BOD-WXX9

Thorsten Blum (1):
      crypto: octeontx - Fix length check to avoid truncation in ucode_load_store

Tim Guttzeit (1):
      ALSA: hda/realtek: Fix headset mic for TongFang X6AR55xU

Vladimir Oltean (1):
      net: dsa: free routing table on probe failure

Xuewen Yan (1):
      gpio: sprd: Change sprd_gpio lock to raw_spin_lock

Yongpeng Yang (2):
      f2fs: fix IS_CHECKPOINTED flag inconsistency issue caused by concurrent atomic commit and checkpoint writes
      f2fs: fix out-of-bounds access in sysfs attribute read/write

Zhang Heng (1):
      ALSA: hda/realtek: Add quirk for Inspur S14-G1

Ziyi Guo (1):
      ASoC: fsl_xcvr: fix missing lock in fsl_xcvr_mode_put()

e.kubanski (1):
      xsk: Fix race condition in AF_XDP generic RX path



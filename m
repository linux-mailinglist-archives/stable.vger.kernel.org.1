Return-Path: <stable+bounces-241349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO5RDIR972lKBwEAu9opvQ
	(envelope-from <stable+bounces-241349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:15:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3387B474FDF
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E421A301A6A1
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FECC329E79;
	Mon, 27 Apr 2026 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZqGsQWX3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C893264DA;
	Mon, 27 Apr 2026 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302754; cv=none; b=TXoPqGWxnQKiLu8TH+Fbjm46a2s0OA24iu2euGDsai5W7UZ/cqTF6VRzPJ4+wuezOy+c1+u33q+XFakM16FMScau1edk9XRCJ3TppsTAp4icVLD/svFjQHSVP/YhBSJkq2TizAsK1FKoTpY+3r3cqMilL221xjKPX2tFVlV58Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302754; c=relaxed/simple;
	bh=0CC88COpBaqYlSXj67XsOQr+tfsgRW1QIN6RGOKNID0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m5lGqpm1dqYLj9aKGWCUDDdc1Hq1ob7iNsKNE5IYXCzuECiu077qrHiHYB02oArctcw6YVMWwMg8VpzMYBuCKExi52OqNi1jqH3WB5ckD7dKZoxvumqGiHaXZ/XxN4m0dPoCswrmYkzqCZ3ie+tgimN0kFt8SOSjg75hmjLswvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZqGsQWX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D00C2BCB5;
	Mon, 27 Apr 2026 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777302753;
	bh=0CC88COpBaqYlSXj67XsOQr+tfsgRW1QIN6RGOKNID0=;
	h=From:To:Cc:Subject:Date:From;
	b=ZqGsQWX36xiEmUAo6OtvnigNO6wZ31qAJZBWdgbZ58MSvQ8MdFat+CsWnJG2ZNydY
	 ux5vfaojdS3Dg/pRSWd+qWBz2++keovdzQx26DRlbL+2MyqkX4MR4EDi9qJyaJUOsy
	 yOh9A/7KoZpEq70vkvV4QPQvliZLN71SqY2O+aBw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.136
Date: Mon, 27 Apr 2026 09:11:56 -0600
Message-ID: <2026042757-manhunt-charter-5755@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3387B474FDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241349-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

I'm announcing the release of the 6.6.136 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/mm/damon/reclaim.rst                      |    4 
 Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml     |    4 
 Makefile                                                            |    2 
 arch/arm64/boot/dts/freescale/imx8mq.dtsi                           |    2 
 arch/x86/events/intel/uncore_discovery.c                            |    2 
 arch/x86/include/asm/kvm-x86-ops.h                                  |    1 
 arch/x86/include/asm/kvm_host.h                                     |    1 
 arch/x86/include/uapi/asm/kvm.h                                     |   12 -
 arch/x86/kvm/svm/sev.c                                              |   11 -
 arch/x86/kvm/vmx/nested.c                                           |    4 
 arch/x86/kvm/vmx/vmx.c                                              |   21 --
 arch/x86/kvm/x86.c                                                  |   24 +-
 crypto/algif_aead.c                                                 |    2 
 crypto/testmgr.c                                                    |   24 ++
 drivers/ata/ahci.c                                                  |   14 +
 drivers/crypto/ccp/sev-dev.c                                        |   19 +-
 drivers/gpio/gpio-tegra.c                                           |    2 
 drivers/gpu/drm/i915/display/intel_psr.c                            |   18 +-
 drivers/gpu/drm/vc4/vc4_bo.c                                        |    3 
 drivers/gpu/drm/vc4/vc4_gem.c                                       |   19 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                                      |   14 +
 drivers/gpu/drm/vc4/vc4_v3d.c                                       |    1 
 drivers/hid/hid-alps.c                                              |    3 
 drivers/hid/hid-core.c                                              |    3 
 drivers/hid/hid-ids.h                                               |    3 
 drivers/hid/hid-quirks.c                                            |    1 
 drivers/hid/hid-roccat.c                                            |    2 
 drivers/i2c/busses/i2c-s3c2410.c                                    |    7 
 drivers/iio/accel/st_accel_core.c                                   |   10 -
 drivers/iio/common/st_sensors/st_sensors_core.c                     |   36 +---
 drivers/iio/common/st_sensors/st_sensors_trigger.c                  |   20 +-
 drivers/infiniband/hw/irdma/verbs.c                                 |    1 
 drivers/md/bcache/super.c                                           |    7 
 drivers/md/raid1.c                                                  |    6 
 drivers/md/raid10.c                                                 |    7 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c |    9 +
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                     |    4 
 drivers/media/test-drivers/vidtv/vidtv_channel.c                    |    4 
 drivers/media/test-drivers/vidtv/vidtv_mux.c                        |    4 
 drivers/media/test-drivers/vidtv/vidtv_ts.c                         |   48 ++---
 drivers/media/test-drivers/vidtv/vidtv_ts.h                         |    4 
 drivers/media/usb/as102/as102_usb_drv.c                             |    2 
 drivers/media/usb/em28xx/em28xx-video.c                             |   14 +
 drivers/media/usb/hackrf/hackrf.c                                   |    7 
 drivers/net/can/spi/mcp251x.c                                       |   29 ++-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c                    |    8 
 drivers/net/ethernet/intel/i40e/i40e_trace.h                        |    2 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                        |   11 +
 drivers/net/ethernet/intel/ixgbevf/vf.c                             |    7 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                         |   22 ++
 drivers/net/ethernet/mediatek/mtk_ppe.c                             |   30 +++
 drivers/net/ethernet/mediatek/mtk_ppe.h                             |    1 
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c                   |   19 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h                     |    8 
 drivers/net/ipa/reg/gsi_reg-v5.0.c                                  |    9 -
 drivers/net/usb/cdc-phonet.c                                        |    7 
 drivers/net/wan/lapbether.c                                         |   13 -
 drivers/net/wireless/ath/ath9k/channel.c                            |    6 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c             |    5 
 drivers/net/wireless/realtek/rtw88/usb.c                            |    3 
 drivers/net/wireless/ti/wl1251/tx.c                                 |    8 
 drivers/net/wireless/virtual/mac80211_hwsim.c                       |    1 
 drivers/nfc/s3fwrn5/uart.c                                          |   10 -
 drivers/pci/controller/pci-hyperv.c                                 |    8 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                       |   19 --
 drivers/pinctrl/intel/pinctrl-intel.c                               |    2 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                           |    9 +
 drivers/soc/aspeed/aspeed-socinfo.c                                 |    2 
 drivers/staging/media/rkvdec/rkvdec-vp9.c                           |    3 
 drivers/staging/rtl8723bs/core/rtw_security.c                       |    2 
 drivers/staging/sm750fb/sm750.c                                     |    3 
 drivers/usb/class/cdc-acm.c                                         |   53 +++++-
 drivers/usb/core/port.c                                             |    1 
 drivers/usb/gadget/function/f_ncm.c                                 |    4 
 drivers/usb/gadget/function/f_phonet.c                              |    9 +
 drivers/usb/gadget/udc/renesas_usb3.c                               |    7 
 drivers/usb/serial/option.c                                         |    2 
 drivers/usb/storage/unusual_devs.h                                  |    7 
 drivers/usb/usbip/usbip_common.c                                    |   12 +
 drivers/video/fbdev/tdfxfb.c                                        |    3 
 drivers/video/fbdev/udlfb.c                                         |    3 
 fs/btrfs/bio.c                                                      |   29 +--
 fs/dcache.c                                                         |    4 
 fs/eventpoll.c                                                      |    6 
 fs/f2fs/compress.c                                                  |   14 +
 fs/f2fs/namei.c                                                     |    1 
 fs/fuse/control.c                                                   |    4 
 fs/fuse/dev.c                                                       |    3 
 fs/fuse/readdir.c                                                   |    4 
 fs/nilfs2/dat.c                                                     |    3 
 fs/ntfs3/fslog.c                                                    |   12 +
 fs/ocfs2/aops.c                                                     |    3 
 fs/ocfs2/inode.c                                                    |   31 +++
 fs/ocfs2/mmap.c                                                     |    7 
 fs/ocfs2/ocfs2_trace.h                                              |   10 -
 fs/ocfs2/resize.c                                                   |   10 -
 fs/smb/client/cifsacl.c                                             |    1 
 fs/smb/client/fs_context.c                                          |    4 
 fs/smb/client/smb2inode.c                                           |    2 
 fs/smb/client/smb2ops.c                                             |    6 
 fs/smb/server/connection.c                                          |    1 
 fs/smb/server/smb2pdu.c                                             |    9 -
 fs/smb/server/smbacl.c                                              |   19 +-
 fs/smb/server/transport_tcp.c                                       |    4 
 include/linux/kvm_host.h                                            |    3 
 include/net/mac80211.h                                              |    4 
 include/net/netfilter/nf_tables.h                                   |    2 
 include/net/pkt_cls.h                                               |    2 
 include/net/xdp_sock.h                                              |    2 
 include/net/xdp_sock_drv.h                                          |   23 ++
 include/trace/events/btrfs.h                                        |   11 -
 include/uapi/linux/kvm.h                                            |   11 -
 kernel/trace/blktrace.c                                             |    4 
 kernel/trace/trace_probe.c                                          |    2 
 mm/backing-dev.c                                                    |    5 
 mm/kasan/init.c                                                     |    8 
 net/can/raw.c                                                       |   11 +
 net/core/net-procfs.c                                               |   49 +++--
 net/core/skbuff.c                                                   |    5 
 net/core/skmsg.c                                                    |   14 -
 net/ipv4/icmp.c                                                     |    7 
 net/ipv4/tcp.c                                                      |    4 
 net/ipv4/tcp_bpf.c                                                  |    2 
 net/ipv4/tcp_input.c                                                |   14 -
 net/ipv4/tcp_minisocks.c                                            |    2 
 net/ipv4/udp.c                                                      |    3 
 net/ipv4/udp_bpf.c                                                  |    2 
 net/ipv6/exthdrs.c                                                  |    4 
 net/ipv6/netfilter/ip6t_eui64.c                                     |    3 
 net/ipv6/seg6_hmac.c                                                |    2 
 net/l2tp/l2tp_core.c                                                |    5 
 net/mac80211/tx.c                                                   |    4 
 net/netfilter/ipvs/ip_vs_ctl.c                                      |    1 
 net/netfilter/nf_conntrack_netlink.c                                |    2 
 net/netfilter/nf_conntrack_proto_sctp.c                             |    3 
 net/netfilter/nf_tables_api.c                                       |    4 
 net/netfilter/nfnetlink_log.c                                       |    8 
 net/netfilter/nft_dynset.c                                          |   10 +
 net/netfilter/nft_set_pipapo_avx2.c                                 |   20 +-
 net/netfilter/xt_multiport.c                                        |   34 +++
 net/nfc/digital_technology.c                                        |    6 
 net/nfc/llcp_core.c                                                 |    2 
 net/nfc/nci/core.c                                                  |    9 +
 net/packet/af_packet.c                                              |   21 +-
 net/rxrpc/conn_event.c                                              |   14 +
 net/rxrpc/key.c                                                     |    9 -
 net/rxrpc/sendmsg.c                                                 |    2 
 net/sched/act_csum.c                                                |    6 
 net/sched/em_cmp.c                                                  |    5 
 net/sched/em_nbyte.c                                                |    2 
 net/sched/em_text.c                                                 |   11 +
 net/unix/af_unix.c                                                  |    8 
 net/unix/diag.c                                                     |   21 +-
 net/wireless/core.c                                                 |    4 
 net/xdp/xdp_umem.c                                                  |    3 
 net/xdp/xsk.c                                                       |    4 
 net/xdp/xsk_buff_pool.c                                             |   32 +++
 net/xfrm/xfrm_policy.c                                              |    2 
 net/xfrm/xfrm_user.c                                                |    1 
 scripts/checkpatch.pl                                               |   10 +
 scripts/dtc/dtc-lexer.l                                             |    3 
 scripts/generate_rust_analyzer.py                                   |   17 +
 sound/firewire/fireworks/fireworks_command.c                        |    5 
 sound/pci/asihpi/hpimsgx.c                                          |    6 
 sound/pci/ctxfi/ctvmem.h                                            |    2 
 sound/pci/hda/patch_realtek.c                                       |    5 
 sound/soc/amd/yc/acp6x-mach.c                                       |   21 ++
 sound/soc/qcom/qdsp6/q6apm.c                                        |   14 +
 sound/soc/soc-core.c                                                |    1 
 sound/soc/sof/topology.c                                            |    2 
 sound/soc/stm/stm32_sai_sub.c                                       |    3 
 sound/usb/6fire/chip.c                                              |   17 +
 sound/usb/caiaq/device.c                                            |    4 
 sound/usb/format.c                                                  |   86 ++++++++--
 sound/usb/mixer.c                                                   |    7 
 sound/usb/quirks.c                                                  |    2 
 tools/objtool/elf.c                                                 |   14 -
 tools/perf/util/unwind-libdw.c                                      |    7 
 tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh         |    1 
 179 files changed, 1171 insertions(+), 449 deletions(-)

Aaron Plattner (1):
      objtool: Remove max symbol name length limitation

Abd-Alrhman Masalkhi (1):
      media: vidtv: fix pass-by-value structs causing MSAN warnings

Abhishek Kumar (1):
      media: em28xx: fix use-after-free in em28xx_v4l2_open()

Agalakov Daniil (1):
      e1000: check return value of e1000_read_eeprom

Alexander Koskovich (2):
      net: ipa: fix GENERIC_CMD register field masks for IPA v5.0+
      net: ipa: fix event ring index not programmed for IPA v5.0+

Alice Mikityanska (1):
      l2tp: Drop large packets with UDP encap

Anderson Nascimento (1):
      rxrpc: Fix missing validation of ticket length in non-XDR key preparsing

Andrii Kovalchuk (1):
      ALSA: hda/realtek: Add HP ENVY Laptop 13-ba0xxx quirk

Andy Shevchenko (1):
      pinctrl: intel: Fix the revision for new features (1kOhm PD, HW debouncer)

Arnd Bergmann (2):
      media: rkvdec: reduce stack usage in rkvdec_init_v4l2_vp9_count_tbl()
      ALSA: asihpi: avoid write overflow check warning

Arthur Husband (1):
      ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585

Benoît Sevens (1):
      HID: roccat: fix use-after-free in roccat_report_event

Berk Cem Goksel (2):
      ALSA: 6fire: fix use-after-free on disconnect
      ALSA: caiaq: take a reference on the USB device in create_card()

Bernd Schubert (1):
      fuse: Check for large folio with SPLICE_F_MOVE

Bingquan Chen (1):
      net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()

Breno Leitao (1):
      mm: blk-cgroup: fix use-after-free in cgwb_release_workfn()

Chaitanya Kulkarni (1):
      blktrace: fix __this_cpu_read/write in preemptible context

Chao Yu (1):
      f2fs: fix to avoid memory leak in f2fs_rename()

Cryolitia PukNgae (1):
      ALSA: usb-audio: apply quirk for MOONDROP JU Jiu

Cássio Gabriel (1):
      ASoC: SOF: topology: reject invalid vendor array size in token parser

César Montoya (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 15-eg0xxx

DaeMyung Kang (1):
      smb: server: fix max_connections off-by-one in tcp accept path

Daniel Brát (1):
      usb: storage: Expand range of matched versions for VL817 quirks entry

Daniel Golle (2):
      selftests: net: bridge_vlan_mcast: wait for h1 before querier check
      net: ethernet: mtk_eth_soc: initialize PPE per-tag-layer MTU registers

Darrick J. Wong (1):
      fuse: quiet down complaints in fuse_conn_limit_write

Dave Carey (1):
      USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10 INGENIC touchscreen

David Howells (2):
      rxrpc: Fix key quota calculation for multitoken keys
      rxrpc: Fix anonymous key handling

David Woodhouse (1):
      KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs

Deepanshu Kartikey (2):
      nilfs2: fix NULL i_assoc_inode dereference in nilfs_mdt_save_to_shadow_map
      ocfs2: validate inline data i_size during inode read

Dmitry Antipov (1):
      ocfs2: add inline inode consistency check to ocfs2_validate_inode_block()

Dustin L. Howett (1):
      ALSA: hda/realtek: add quirk for Framework F111:000F

Eric Dumazet (4):
      net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
      net: add proper RCU protection to /proc/net/ptype
      net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()
      net: annotate data-races around sk->sk_{data_ready,write_space}

Fabio Baltieri (1):
      net: txgbe: leave space for null terminators on property_entry

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FN990A MBIM composition

Fan Wu (1):
      media: mediatek: vcodec: fix use-after-free in encoder release path

Felix Fietkau (1):
      wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure

Florian Westphal (2):
      netfilter: nft_set_pipapo_avx2: don't return non-matching entry on expiry
      netfilter: conntrack: add missing netlink policy validations

Fredric Cover (1):
      fs/smb/client: fix out-of-bounds read in cifs_sanitize_prepath

Geoffrey D. Bennett (1):
      ALSA: usb-audio: Improve Focusrite sample rate filtering

George Saad (1):
      f2fs: fix use-after-free of sbi in f2fs_compress_write_end_io()

Gilson Marquato Júnior (1):
      ASoC: amd: yc: Add DMI entry for HP Laptop 15-fc0xxx

Goldwyn Rodrigues (1):
      btrfs: tracepoints: get correct superblock from dentry in event btrfs_sync_file()

Greg Kroah-Hartman (19):
      xfrm_user: fix info leak in build_mapping()
      i2c: s3c24xx: check the size of the SMBUS message before using it
      HID: alps: fix NULL pointer dereference in alps_raw_event()
      HID: core: clamp report_size in s32ton() to avoid undefined shift
      net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()
      NFC: digital: Bounds check NFC-A cascade depth in SDD response handler
      drm/vc4: platform_get_irq_byname() returns an int
      ALSA: fireworks: bound device-supplied status before string array lookup
      fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      usb: gadget: f_ncm: validate minimum block_len in ncm_unwrap_ntb()
      usb: gadget: f_phonet: fix skb frags[] overflow in pn_rx_complete()
      usb: gadget: renesas_usb3: validate endpoint index in standard request handlers
      smb: client: fix off-by-8 bounds check in check_wsl_eas()
      ksmbd: validate EaNameLength in smb2_get_ea()
      ksmbd: require 3 sub-authorities before reading sub_auth[2]
      ksmbd: fix mechToken leak when SPNEGO decode fails after token alloc
      fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      fs/ntfs3: validate rec->used in journal-replay file record check
      Linux 6.6.136

Guocai He (1):
      Revert "wifi: cfg80211: stop NAN and P2P in cfg80211_leave"

Harin Lee (1):
      ALSA: ctxfi: Limit PTP to a single page

Herbert Xu (3):
      crypto: algif_aead - Fix minimum RX size check for decryption
      crypto: testmgr - Hide ENOENT errors
      crypto: testmgr - Hide ENOENT errors better

Jacob Moroni (1):
      RDMA/irdma: Fix double free related to rereg_user_mr

Jakub Kicinski (1):
      nfc: nci: complete pending data exchange on device close

Jeongjun Park (2):
      media: as102: fix to not free memory after the device is registered in as102_usb_probe()
      media: hackrf: fix to not free memory after the device is registered in hackrf_probe()

Jiayuan Chen (1):
      net: skb: fix cross-cache free of KFENCE-allocated skb head

Jiexun Wang (1):
      af_unix: read UNIX_DIAG_VFS data under unix_state_lock

Johan Hovold (1):
      wifi: rtw88: fix device leak on probe failure

Jon Hunter (2):
      net: stmmac: Fix PTP ref clock for Tegra234
      dt-bindings: net: Fix Tegra234 MGBE PTP clock

Joseph Qi (2):
      ocfs2: fix possible deadlock between unlink and dio_end_io_write
      ocfs2: fix out-of-bounds write in ocfs2_write_end_inline

Jouni Högander (1):
      drm/i915/psr: Do not use pipe_src as borders for SU area

Junrui Luo (1):
      staging: sm750fb: fix division by zero in ps_to_hz()

Junxi Qian (1):
      nfc: llcp: add missing return after LLCP_CLOSED checks

Kenta Akagi (1):
      Revert "perf unwind-libdw: Fix invalid reference counts"

Koichiro Den (2):
      PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
      PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup

Kuninori Morimoto (1):
      ASoC: soc-core: call missing INIT_LIST_HEAD() for card_aux_list

Lin YuChen (1):
      staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_verify()

Long Li (1):
      PCI: hv: Set default NUMA node to 0 for devices without affinity info

Maciej Fijalkowski (4):
      xsk: tighten UMEM headroom validation to account for tailroom and min frame
      xsk: respect tailroom for ZC setups
      xsk: fix XDP_UMEM_SG_FLAG issues
      xsk: validate MTU against usable frame size on bind

Mario Limonciello (1):
      platform/x86/amd: pmc: Add Thinkpad L14 Gen3 to quirk_s2idle_bug

Matthew Schwartz (1):
      ALSA: hda/realtek: Add quirk for ASUS ROG Flow Z13-KJP GZ302EAC

Maud Spierings (1):
      iio: common: st_sensors: Fix use of uninitialize device structs

Maíra Canal (4):
      drm/vc4: Release runtime PM reference after binding V3D
      drm/vc4: Fix memory leak of BO array in hang state
      drm/vc4: Fix a memory leak in hang state error path
      drm/vc4: Protect madv read in vc4_gem_object_mmap() with madv_lock

Michael Bommarito (3):
      smb: server: fix active_num_conn leak on transport allocation failure
      smb: client: require a full NFS mode SID before reading mode bits
      smb: client: fix OOB read in smb2_ioctl_query_info QUERY_INFO path

Michal Schmidt (1):
      ixgbevf: add missing negotiate_features op to Hyper-V ops table

Mingzhe Zou (1):
      bcache: fix cached_dev.sb_bio use-after-free and crash

Minhong He (1):
      ipv6: add NULL checks for idev in SRv6 paths

Nathan Chancellor (1):
      scripts/dtc: Remove unused dts_version in dtc-lexer.l

Nathan Rebello (1):
      usbip: validate number_of_packets in usbip_pack_ret_submit()

Nicholas Carlini (1):
      eventpoll: defer struct eventpoll free to RCU grace period

Pablo Neira Ayuso (1):
      nf_tables: nft_dynset: fix possible stateful expression memleak in error path

Pengpeng Hou (4):
      wifi: wl1251: validate packet IDs before indexing tx_frames
      wifi: brcmfmac: validate bsscfg indices in IF events
      nfc: s3fwrn5: allocate rx skb before consuming bytes
      tracing/probe: reject non-closed empty immediate strings

Phil Willoughby (1):
      ALSA: usb-audio: Fix quirk flags for NeuralDSP Quad Cortex

Potin Lai (1):
      soc: aspeed: socinfo: Mask table entries for accurate SoC ID matching

Qu Wenruo (1):
      btrfs: merge btrfs_orig_bbio_end_io() into btrfs_bio_end_io()

Ren Wei (1):
      netfilter: xt_multiport: validate range encoding in checkentry

Ritesh Harjani (IBM) (1):
      mm/kasan: fix double free for kasan pXds

Ruide Cao (1):
      net: sched: act_csum: validate nested VLAN headers

Ruslan Valiyev (2):
      media: vidtv: fix NULL pointer dereference in vidtv_channel_pmt_match_sections
      media: vidtv: fix nfeeds state corruption on start_streaming failure

Samasth Norway Ananda (1):
      gpio: tegra: fix irq_release_resources calling enable instead of disable

Samuel Page (2):
      can: raw: fix ro->uniq use-after-free in raw_rcv()
      fuse: reject oversized dirents in page cache

Sasha Levin (1):
      checkpatch: add support for Assisted-by tag

Sean Christopherson (6):
      KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
      KVM: nVMX: Fold requested virtual interrupt check into has_nested_events()
      KVM: x86: Use scratch field in MMIO fragment to hold small write values
      crypto: ccp: Don't attempt to copy CSR to userspace if PSP command failed
      crypto: ccp: Don't attempt to copy PDH cert to userspace if PSP command failed
      crypto: ccp: Don't attempt to copy ID to userspace if PSP command failed

Sebastian Krzyszkowiak (1):
      arm64: dts: imx8mq: Set the correct gpu_ahb clock frequency

SeongJae Park (1):
      Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race

Srinivas Kandagatla (1):
      ASoC: qcom: q6apm: move component registration to unmanaged version

Steffen Klassert (1):
      xfrm: Wait for RCU readers during policy netns exit

Tamir Duberstein (2):
      scripts: generate_rust_analyzer.py: avoid FD leak
      scripts: generate_rust_analyzer.py: define scripts

Tejas Bharambe (1):
      ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY

Thomas Gleixner (1):
      i40e: Fix preempt count leak in napi poll tracepoint

Tomasz Merta (1):
      ASoC: stm32_sai: fix incorrect BCLK polarity for DSP_A/B, LEFT_J

Tristan Madani (2):
      ksmbd: fix out-of-bounds write in smb2_get_ea() EA alignment
      ksmbd: use check_add_overflow() to prevent u16 DACL size overflow

Vee Satayamas (1):
      ASoC: amd: yc: Add DMI quirk for ASUS EXPERTBOOK BM1403CDA

Wang Jie (1):
      rxrpc: only handle RESPONSE during service challenge

Weiming Shi (1):
      ipvs: fix NULL deref in ip_vs_add_service error path

Wenyuan Li (1):
      can: mcp251x: add error handling for power enable in open and resume

Xiang Mei (1):
      netfilter: nfnetlink_log: initialize nfgenmsg in NLMSG_DONE terminator

Xu Yang (1):
      usb: port: add delay after usb_hub_set_port_power()

Yiqi Sun (1):
      ipv4: icmp: fix null-ptr-deref in icmp_build_probe()

Yu Kuai (2):
      md/raid1,raid10: don't ignore IO flags
      md/raid1: fix data lost for writemostly rdev

Zhang Heng (1):
      ASoC: amd: yc: Add DMI quirk for Thin A15 B7VF

ZhengYuan Huang (1):
      ocfs2: handle invalid dinode in ocfs2_group_extend

Zhengchuan Liang (1):
      netfilter: ip6t_eui64: reject invalid MAC header for all packets

Zhihao Cheng (1):
      dcache: Limit the minimal number of bucket to two

Zide Chen (1):
      perf/x86/intel/uncore: Skip discovery table for offline dies

Zilin Guan (1):
      ice: Fix memory leak in ice_set_ringparam()

leo vriska (1):
      HID: quirks: add HID_QUIRK_ALWAYS_POLL for 8BitDo Pro 3

songxiebing (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IAH10



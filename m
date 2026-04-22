Return-Path: <stable+bounces-240316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CkUFeW36GmgPAIAu9opvQ
	(envelope-from <stable+bounces-240316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 13:58:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E879A445A2E
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 13:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09B773023348
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 11:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9D43D1719;
	Wed, 22 Apr 2026 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DmMLl8Ur"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143126CE05;
	Wed, 22 Apr 2026 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859082; cv=none; b=HAEhkUqHSrpk6btp8bVH77qafE7/fLbGngVeNzgzk4kaJYfau8/d5/X+8kPxlF5joYs38WFb4HIYfN2ZuYqg+YUf3e7/A7t8U5GhzpAix6bvDUW1kndp6lbvdA9LiOMfu2kiHA6YZQvMNzzaz/VsGlfowlfmU1HdovMe28giFAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859082; c=relaxed/simple;
	bh=92ZF+g+lkOhzhQw8HY6zxpn4bJ1dpL9amNuMhhBloyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YxWzcwJ2N9H0spCHhXktbRxa/+N22JYvuq6ybFBL5zMgFLSXc1CjLtJ3nhp5P/BgwFufhxeOfE0/XEC7Q7RDPYMXrB062rrymyQUZN8krhO80HbCULjDvdmHII4w1mbPT6GejgpLaARKRIRByezGl0B3XniIDgIptaD2ayxJ0LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DmMLl8Ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A12C19425;
	Wed, 22 Apr 2026 11:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776859082;
	bh=92ZF+g+lkOhzhQw8HY6zxpn4bJ1dpL9amNuMhhBloyo=;
	h=From:To:Cc:Subject:Date:From;
	b=DmMLl8Urv0CjkEH+1xx0KP2LIN4g6/zgI2rp2wu7M/LvTdKHmh0uZ05kWxw8Aap9E
	 43jlcyveokXHFgq4mJFGYvhDpdG3mnhe45GhUJCiNmGPFfbexdLeHnrrSo9JA0PZxE
	 pVhUcAlsLOS8YbGlWR7qY9ypAh8Jxqq5muLGavh0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.83
Date: Wed, 22 Apr 2026 13:57:57 +0200
Message-ID: <2026042258-exhume-payday-0bf1@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-240316-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: E879A445A2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.12.83 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/mm/damon/reclaim.rst                      |    4 
 Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml     |    4 
 Makefile                                                            |    2 
 arch/arm64/boot/dts/freescale/imx8mq.dtsi                           |    2 
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts                     |    2 
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi                   |   26 -
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                              |    2 
 arch/arm64/include/asm/uaccess.h                                    |    2 
 arch/arm64/kvm/guest.c                                              |    4 
 arch/loongarch/kvm/vcpu.c                                           |    2 
 arch/loongarch/kvm/vm.c                                             |    2 
 arch/mips/kvm/mips.c                                                |    4 
 arch/powerpc/include/asm/uaccess.h                                  |    3 
 arch/powerpc/kvm/book3s.c                                           |    4 
 arch/powerpc/kvm/booke.c                                            |    4 
 arch/powerpc/lib/pmem.c                                             |   11 
 arch/riscv/kvm/vcpu.c                                               |    2 
 arch/riscv/kvm/vm.c                                                 |    2 
 arch/s390/kvm/kvm-s390.c                                            |    4 
 arch/x86/events/intel/uncore_discovery.c                            |    2 
 arch/x86/include/asm/uaccess.h                                      |    2 
 arch/x86/include/asm/uaccess_32.h                                   |    8 
 arch/x86/include/asm/uaccess_64.h                                   |   16 
 arch/x86/include/uapi/asm/kvm.h                                     |   12 
 arch/x86/kvm/svm/sev.c                                              |   24 -
 arch/x86/kvm/x86.c                                                  |   18 
 arch/x86/lib/copy_user_uncached_64.S                                |    6 
 arch/x86/lib/usercopy_32.c                                          |    9 
 arch/x86/lib/usercopy_64.c                                          |   12 
 crypto/af_alg.c                                                     |    2 
 crypto/algif_aead.c                                                 |    2 
 crypto/algif_skcipher.c                                             |    5 
 drivers/ata/ahci.c                                                  |   14 
 drivers/gpio/gpio-tegra.c                                           |    2 
 drivers/gpio/gpiolib.c                                              |   43 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                              |    6 
 drivers/gpu/drm/i915/i915_gem.c                                     |    2 
 drivers/gpu/drm/qxl/qxl_ioctl.c                                     |    2 
 drivers/gpu/drm/vc4/vc4_bo.c                                        |    3 
 drivers/gpu/drm/vc4/vc4_gem.c                                       |   19 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                      |   14 
 drivers/gpu/drm/vc4/vc4_v3d.c                                       |    1 
 drivers/gpu/drm/xe/xe_mmio.c                                        |  135 +++---
 drivers/gpu/drm/xe/xe_mmio.h                                        |   76 ---
 drivers/gpu/drm/xe/xe_trace.h                                       |    7 
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                              |    3 
 drivers/hid/hid-alps.c                                              |    3 
 drivers/hid/hid-core.c                                              |    3 
 drivers/hid/hid-ids.h                                               |    3 
 drivers/hid/hid-quirks.c                                            |    1 
 drivers/hid/hid-roccat.c                                            |    2 
 drivers/hwmon/powerz.c                                              |    8 
 drivers/i2c/busses/i2c-s3c2410.c                                    |    7 
 drivers/infiniband/hw/irdma/verbs.c                                 |    1 
 drivers/infiniband/sw/rdmavt/qp.c                                   |    8 
 drivers/md/bcache/super.c                                           |    7 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c |    9 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                     |    4 
 drivers/media/test-drivers/vidtv/vidtv_channel.c                    |    4 
 drivers/media/test-drivers/vidtv/vidtv_mux.c                        |    4 
 drivers/media/test-drivers/vidtv/vidtv_ts.c                         |   48 +-
 drivers/media/test-drivers/vidtv/vidtv_ts.h                         |    4 
 drivers/media/usb/as102/as102_usb_drv.c                             |    2 
 drivers/media/usb/em28xx/em28xx-video.c                             |   14 
 drivers/media/usb/hackrf/hackrf.c                                   |    7 
 drivers/net/can/spi/mcp251x.c                                       |   29 +
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c                    |    8 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                     |   15 
 drivers/net/ethernet/intel/ixgbevf/vf.c                             |    7 
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c                   |   19 
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h                     |    8 
 drivers/net/ipa/reg/gsi_reg-v5.0.c                                  |    9 
 drivers/net/phy/sfp.c                                               |   16 
 drivers/net/usb/cdc-phonet.c                                        |    7 
 drivers/net/wan/lapbether.c                                         |   13 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c             |    5 
 drivers/net/wireless/realtek/rtw88/usb.c                            |    3 
 drivers/net/wireless/ti/wl1251/tx.c                                 |    8 
 drivers/nfc/s3fwrn5/uart.c                                          |   10 
 drivers/ntb/ntb_transport.c                                         |    7 
 drivers/pci/bus.c                                                   |    6 
 drivers/pci/controller/pci-hyperv.c                                 |    8 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                       |    1 
 drivers/pci/pci-driver.c                                            |    8 
 drivers/pci/pci.c                                                   |   10 
 drivers/pci/pci.h                                                   |    1 
 drivers/pinctrl/intel/pinctrl-intel.c                               |    2 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                           |    9 
 drivers/platform/x86/asus-nb-wmi.c                                  |    2 
 drivers/soc/aspeed/aspeed-socinfo.c                                 |    2 
 drivers/soc/qcom/pdr_internal.h                                     |    2 
 drivers/soc/qcom/qcom_pdr_msg.c                                     |    2 
 drivers/staging/media/rkvdec/rkvdec-vp9.c                           |    3 
 drivers/staging/rtl8723bs/core/rtw_security.c                       |    2 
 drivers/staging/sm750fb/sm750.c                                     |    3 
 drivers/thermal/thermal_core.c                                      |   36 +
 drivers/thermal/thermal_core.h                                      |    1 
 drivers/usb/class/cdc-acm.c                                         |   53 ++
 drivers/usb/core/port.c                                             |    1 
 drivers/usb/gadget/function/f_hid.c                                 |   15 
 drivers/usb/gadget/function/f_ncm.c                                 |    4 
 drivers/usb/gadget/function/f_phonet.c                              |    9 
 drivers/usb/gadget/udc/renesas_usb3.c                               |    7 
 drivers/usb/serial/option.c                                         |    2 
 drivers/usb/storage/unusual_devs.h                                  |    7 
 drivers/usb/usbip/usbip_common.c                                    |   12 
 drivers/video/fbdev/tdfxfb.c                                        |    3 
 drivers/video/fbdev/udlfb.c                                         |    3 
 fs/dcache.c                                                         |    4 
 fs/eventpoll.c                                                      |    6 
 fs/nilfs2/dat.c                                                     |    3 
 fs/ocfs2/aops.c                                                     |    3 
 fs/ocfs2/inode.c                                                    |   31 +
 fs/ocfs2/mmap.c                                                     |    7 
 fs/ocfs2/ocfs2_trace.h                                              |   10 
 fs/ocfs2/resize.c                                                   |   10 
 fs/smb/client/fs_context.c                                          |    4 
 fs/smb/client/smb2inode.c                                           |    2 
 fs/smb/server/connection.c                                          |    1 
 fs/smb/server/smb2pdu.c                                             |    7 
 fs/smb/server/smbacl.c                                              |    3 
 include/linux/kvm_host.h                                            |   93 ++--
 include/linux/soc/qcom/pdr.h                                        |    1 
 include/linux/uaccess.h                                             |   11 
 include/net/ip_tunnels.h                                            |    2 
 include/net/netfilter/nf_queue.h                                    |    1 
 include/net/pkt_cls.h                                               |    2 
 include/net/xdp_sock.h                                              |    2 
 include/net/xdp_sock_drv.h                                          |   23 +
 include/trace/events/btrfs.h                                        |   11 
 include/uapi/linux/kvm.h                                            |   19 
 kernel/events/uprobes.c                                             |    4 
 kernel/fork.c                                                       |   17 
 kernel/sched/deadline.c                                             |    2 
 kernel/trace/trace_probe.c                                          |    2 
 lib/iov_iter.c                                                      |    4 
 mm/backing-dev.c                                                    |    5 
 mm/kasan/init.c                                                     |    8 
 net/bluetooth/hci_conn.c                                            |    2 
 net/bluetooth/hci_core.c                                            |    2 
 net/bluetooth/hci_sync.c                                            |   20 
 net/can/raw.c                                                       |   11 
 net/ipv4/icmp.c                                                     |    7 
 net/ipv4/nexthop.c                                                  |   41 +
 net/ipv6/exthdrs.c                                                  |    4 
 net/ipv6/netfilter/ip6t_eui64.c                                     |    3 
 net/ipv6/seg6_hmac.c                                                |    2 
 net/l2tp/l2tp_core.c                                                |    5 
 net/netfilter/ipvs/ip_vs_ctl.c                                      |    1 
 net/netfilter/nf_conntrack_netlink.c                                |    2 
 net/netfilter/nf_conntrack_proto_sctp.c                             |    3 
 net/netfilter/nfnetlink_log.c                                       |    8 
 net/netfilter/nfnetlink_queue.c                                     |  214 +++-------
 net/netfilter/nft_set_pipapo_avx2.c                                 |   20 
 net/netfilter/xt_multiport.c                                        |   34 +
 net/nfc/digital_technology.c                                        |    6 
 net/nfc/llcp_core.c                                                 |    2 
 net/rxrpc/key.c                                                     |    5 
 net/sched/act_csum.c                                                |    6 
 net/sched/em_cmp.c                                                  |    5 
 net/sched/em_nbyte.c                                                |    2 
 net/sched/em_text.c                                                 |   11 
 net/unix/diag.c                                                     |   21 
 net/xdp/xdp_umem.c                                                  |    3 
 net/xdp/xsk.c                                                       |    4 
 net/xdp/xsk_buff_pool.c                                             |   32 +
 net/xfrm/xfrm_policy.c                                              |    5 
 net/xfrm/xfrm_user.c                                                |   11 
 scripts/checkpatch.pl                                               |   10 
 scripts/generate_rust_analyzer.py                                   |    3 
 sound/firewire/fireworks/fireworks_command.c                        |    5 
 sound/pci/asihpi/hpimsgx.c                                          |    6 
 sound/pci/ctxfi/ctvmem.h                                            |    2 
 sound/pci/hda/patch_realtek.c                                       |   10 
 sound/soc/amd/yc/acp6x-mach.c                                       |   21 
 sound/soc/qcom/qdsp6/q6apm.c                                        |   14 
 sound/soc/soc-core.c                                                |    1 
 sound/soc/sof/topology.c                                            |    2 
 sound/soc/stm/stm32_sai_sub.c                                       |    3 
 sound/usb/6fire/chip.c                                              |   17 
 sound/usb/format.c                                                  |   86 +++-
 sound/usb/quirks.c                                                  |    2 
 tools/objtool/check.c                                               |    2 
 tools/power/x86/turbostat/turbostat.c                               |    9 
 tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh         |    1 
 virt/kvm/binary_stats.c                                             |    2 
 virt/kvm/kvm_main.c                                                 |   20 
 187 files changed, 1327 insertions(+), 727 deletions(-)

Abd-Alrhman Masalkhi (1):
      media: vidtv: fix pass-by-value structs causing MSAN warnings

Abhishek Kumar (1):
      media: em28xx: fix use-after-free in em28xx_v4l2_open()

Agalakov Daniil (1):
      e1000: check return value of e1000_read_eeprom

Alexander Koskovich (2):
      net: ipa: fix GENERIC_CMD register field masks for IPA v5.0+
      net: ipa: fix event ring index not programmed for IPA v5.0+

Alexander Savenko (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IMH9

Alice Mikityanska (1):
      l2tp: Drop large packets with UDP encap

Andrii Kovalchuk (1):
      ALSA: hda/realtek: Add HP ENVY Laptop 13-ba0xxx quirk

Andy Shevchenko (1):
      pinctrl: intel: Fix the revision for new features (1kOhm PD, HW debouncer)

Arnd Bergmann (2):
      media: rkvdec: reduce stack usage in rkvdec_init_v4l2_vp9_count_tbl()
      ALSA: asihpi: avoid write overflow check warning

Arthur Husband (1):
      ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585

Bartosz Golaszewski (1):
      gpiolib: unify two loops initializing GPIO descriptors

Benoît Sevens (1):
      HID: roccat: fix use-after-free in roccat_report_event

Berk Cem Goksel (1):
      ALSA: 6fire: fix use-after-free on disconnect

Breno Leitao (1):
      mm: blk-cgroup: fix use-after-free in cgwb_release_workfn()

Cen Zhang (1):
      Bluetooth: hci_sync: annotate data-races around hdev->req_status

Chris J Arges (1):
      net: increase IP_TUNNEL_RECURSION_LIMIT to 5

Cássio Gabriel (1):
      ASoC: SOF: topology: reject invalid vendor array size in token parser

César Montoya (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 15-eg0xxx

Daniel Brát (1):
      usb: storage: Expand range of matched versions for VL817 quirks entry

Daniel Golle (1):
      selftests: net: bridge_vlan_mcast: wait for h1 before querier check

Daniel J Blueman (1):
      arm64: dts: qcom: hamoa/x1: fix idle exit latency

Dave Carey (1):
      USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10 INGENIC touchscreen

David Howells (1):
      rxrpc: Fix key quota calculation for multitoken keys

David Woodhouse (1):
      KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs

Deepanshu Kartikey (2):
      nilfs2: fix NULL i_assoc_inode dereference in nilfs_mdt_save_to_shadow_map
      ocfs2: validate inline data i_size during inode read

Dmitry Antipov (1):
      ocfs2: add inline inode consistency check to ocfs2_validate_inode_block()

Donet Tom (1):
      drm/amdgpu: Handle GPU page faults correctly on non-4K page systems

Douya Le (1):
      crypto: af_alg - limit RX SG extraction by receive buffer budget

Dustin L. Howett (1):
      ALSA: hda/realtek: add quirk for Framework F111:000F

Emil Tantilov (1):
      idpf: fix PREEMPT_RT raw/bh spinlock nesting for async VC handling

Eric Dumazet (2):
      net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
      net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()

Fabio Baltieri (1):
      net: txgbe: leave space for null terminators on property_entry

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FN990A MBIM composition

Fan Wu (1):
      media: mediatek: vcodec: fix use-after-free in encoder release path

Fernando Fernandez Mancera (2):
      ipv4: nexthop: avoid duplicate NHA_HW_STATS_ENABLE on nexthop group dump
      ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()

Florian Westphal (3):
      netfilter: nft_set_pipapo_avx2: don't return non-matching entry on expiry
      netfilter: nfnetlink_queue: make hash table per queue
      netfilter: conntrack: add missing netlink policy validations

Fredric Cover (1):
      fs/smb/client: fix out-of-bounds read in cifs_sanitize_prepath

Geoffrey D. Bennett (1):
      ALSA: usb-audio: Improve Focusrite sample rate filtering

Gilson Marquato Júnior (1):
      ASoC: amd: yc: Add DMI entry for HP Laptop 15-fc0xxx

Goldwyn Rodrigues (1):
      btrfs: tracepoints: get correct superblock from dentry in event btrfs_sync_file()

Greg Kroah-Hartman (18):
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
      Linux 6.12.83

Harin Lee (1):
      ALSA: ctxfi: Limit PTP to a single page

Herbert Xu (1):
      crypto: algif_aead - Fix minimum RX size check for decryption

Jacob Moroni (1):
      RDMA/irdma: Fix double free related to rereg_user_mr

Jeongjun Park (2):
      media: as102: fix to not free memory after the device is registered in as102_usb_probe()
      media: hackrf: fix to not free memory after the device is registered in hackrf_probe()

Jiexun Wang (1):
      af_unix: read UNIX_DIAG_VFS data under unix_state_lock

Johan Hovold (1):
      wifi: rtw88: fix device leak on probe failure

John Hancock (1):
      PCI: Revert "Enable ACS after configuring IOMMU for OF platforms"

John Pavlick (1):
      net: sfp: add quirks for Hisense and HSGQ GPON ONT SFP modules

Jon Hunter (2):
      net: stmmac: Fix PTP ref clock for Tegra234
      dt-bindings: net: Fix Tegra234 MGBE PTP clock

Joseph Qi (2):
      ocfs2: fix possible deadlock between unlink and dio_end_io_write
      ocfs2: fix out-of-bounds write in ocfs2_write_end_inline

Junrui Luo (1):
      staging: sm750fb: fix division by zero in ps_to_hz()

Junxi Qian (1):
      nfc: llcp: add missing return after LLCP_CLOSED checks

Keenan Dong (1):
      xfrm: account XFRMA_IF_ID in aevent size calculation

Koichiro Den (1):
      PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup

Kotlyarov Mihail (1):
      xfrm: fix refcount leak in xfrm_migrate_policy_find

Kuninori Morimoto (1):
      ASoC: soc-core: call missing INIT_LIST_HEAD() for card_aux_list

Liam R. Howlett (1):
      kernel: be more careful about dup_mmap() failures and uprobe registering

Lin YuChen (1):
      staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_verify()

Linus Torvalds (3):
      x86-64: rename misleadingly named '__copy_user_nocache()' function
      x86: rename and clean up __copy_from_user_inatomic_nocache()
      x86-64/arm64/powerpc: clean up and rename __copy_from_user_flushcache

Long Li (1):
      PCI: hv: Set default NUMA node to 0 for devices without affinity info

Lukas Wunner (1):
      PCI: Fix placement of pci_save_state() in pci_bus_add_device()

Luke Wang (1):
      arm64: dts: imx93-9x9-qsb: change usdhc tuning step for eMMC and SD

Maciej Fijalkowski (4):
      xsk: tighten UMEM headroom validation to account for tailroom and min frame
      xsk: respect tailroom for ZC setups
      xsk: fix XDP_UMEM_SG_FLAG issues
      xsk: validate MTU against usable frame size on bind

Mario Limonciello (1):
      platform/x86/amd: pmc: Add Thinkpad L14 Gen3 to quirk_s2idle_bug

Markus Niebel (1):
      arm64: dts: imx93-tqma9352: improve eMMC pad configuration

Matthew Schwartz (2):
      ALSA: hda/realtek: Add quirk for ASUS ROG Flow Z13-KJP GZ302EAC
      platform/x86: asus-nb-wmi: add DMI quirk for ASUS ROG Flow Z13-KJP GZ302EAC

Maximilian Pezzullo (1):
      HID: amd_sfh: don't log error when device discovery fails with -EOPNOTSUPP

Maíra Canal (4):
      drm/vc4: Release runtime PM reference after binding V3D
      drm/vc4: Fix memory leak of BO array in hang state
      drm/vc4: Fix a memory leak in hang state error path
      drm/vc4: Protect madv read in vc4_gem_object_mmap() with madv_lock

Michael Zimmermann (1):
      usb: gadget: f_hid: don't call cdev_init while cdev in use

Michal Schmidt (1):
      ixgbevf: add missing negotiate_features op to Hyper-V ops table

Mingzhe Zou (1):
      bcache: fix cached_dev.sb_bio use-after-free and crash

Minhong He (1):
      ipv6: add NULL checks for idev in SRv6 paths

Mukesh Ojha (1):
      soc: qcom: pd-mapper: Fix element length in servreg_loc_pfr_req_ei

Nathan Rebello (1):
      usbip: validate number_of_packets in usbip_pack_ret_submit()

Nicholas Carlini (1):
      eventpoll: defer struct eventpoll free to RCU grace period

Paweł Narewski (1):
      gpiolib: fix race condition for gdev->srcu

Pengpeng Hou (4):
      wifi: wl1251: validate packet IDs before indexing tx_frames
      wifi: brcmfmac: validate bsscfg indices in IF events
      nfc: s3fwrn5: allocate rx skb before consuming bytes
      tracing/probe: reject non-closed empty immediate strings

Peter Zijlstra (1):
      sched/deadline: Use revised wakeup rule for dl_server

Phil Willoughby (1):
      ALSA: usb-audio: Fix quirk flags for NeuralDSP Quad Cortex

Potin Lai (1):
      soc: aspeed: socinfo: Mask table entries for accurate SoC ID matching

Rafael J. Wysocki (2):
      thermal: core: Mark thermal zones as exiting before unregistration
      thermal: core: Address thermal zone removal races with resume

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

Samuel Page (1):
      can: raw: fix ro->uniq use-after-free in raw_rcv()

Sanman Pradhan (1):
      hwmon: (powerz) Fix use-after-free on USB disconnect

Sasha Levin (3):
      Revert "drm/xe/mmio: Avoid double-adjust in 64-bit reads"
      Revert "drm/xe: Switch MMIO interface to take xe_mmio instead of xe_gt"
      checkpatch: add support for Assisted-by tag

Scott Mitchell (1):
      netfilter: nfnetlink_queue: nfqnl_instance GFP_ATOMIC -> GFP_KERNEL_ACCOUNT allocation

Sean Christopherson (5):
      KVM: SEV: Reject attempts to sync VMSA of an already-launched/encrypted vCPU
      KVM: SEV: Disallow LAUNCH_FINISH if vCPUs are actively being created
      KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
      KVM: Remove subtle "struct kvm_stats_desc" pseudo-overlay
      KVM: x86: Use scratch field in MMIO fragment to hold small write values

Sebastian Krzyszkowiak (1):
      arm64: dts: imx8mq: Set the correct gpu_ahb clock frequency

SeongJae Park (1):
      Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race

Serhii Pievniev (1):
      tools/power/turbostat: Fix microcode patch level output for AMD/Hygon

Srinivas Kandagatla (1):
      ASoC: qcom: q6apm: move component registration to unmanaged version

Steffen Klassert (1):
      xfrm: Wait for RCU readers during policy netns exit

Takashi Iwai (1):
      ALSA: hda/realtek: Add quirk for Samsung Book2 Pro 360 (NP950QED)

Tamir Duberstein (1):
      scripts: generate_rust_analyzer.py: avoid FD leak

Tejas Bharambe (1):
      ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY

Tomasz Merta (1):
      ASoC: stm32_sai: fix incorrect BCLK polarity for DSP_A/B, LEFT_J

Vee Satayamas (1):
      ASoC: amd: yc: Add DMI quirk for ASUS EXPERTBOOK BM1403CDA

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

leo vriska (1):
      HID: quirks: add HID_QUIRK_ALWAYS_POLL for 8BitDo Pro 3

songxiebing (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IAH10



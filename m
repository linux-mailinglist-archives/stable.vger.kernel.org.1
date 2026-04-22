Return-Path: <stable+bounces-240318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFgmAAq46GmgPAIAu9opvQ
	(envelope-from <stable+bounces-240318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 13:59:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 533FB445A3D
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 13:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B417303AF0A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 11:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1739B3D1CC5;
	Wed, 22 Apr 2026 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGBgY7qS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14A3C279B;
	Wed, 22 Apr 2026 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859092; cv=none; b=uEtHbWv2Ww/LC6Lb+YZFqIYto4IGKnbwW1qNmo4aXVIYuBQGlfOx9mJumZymqfP4YIJda0PExVxXUuo7wyJkoReoZIJaLnutBYh+9UnsqNOnjgnuSc2zOoUJ4NJFbAi9eL7Fy3YyoxmCZxvxkUJPFLr1KiNF/jp15/mmEj2k6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859092; c=relaxed/simple;
	bh=eDWwauNbQ2Y+vbsrFJoOuALxs+TZRri9uBl+phgV6w0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F8odx2E4jKieNAD3zWuXSvUskPOgXpihAxi3MvzF7eMT0psd5hSiQidjIbIy4tSzNTypY6rKc8mqo2YuPJVRAGz9D9cQCL0XtkjMwpYvWl6WHy+RklZHvMdswrB/wmxJ/NqkHWR+Iy2zO2JY1iO+C46yPYVAfSIhIZVjqUqGtpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGBgY7qS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CC5C2BCB4;
	Wed, 22 Apr 2026 11:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776859092;
	bh=eDWwauNbQ2Y+vbsrFJoOuALxs+TZRri9uBl+phgV6w0=;
	h=From:To:Cc:Subject:Date:From;
	b=DGBgY7qSvwaxZOSSXFfe7TbTqn9qk+hTW+N3aHMFJYJRgzbgLVFt29Tye5XL/ygI0
	 FA5z1j2zqMRwrDI/TJQbLFQAmcNug0EAfmg5Ny+4dOm+9cDfp2/JQavcYCMtsKOr5f
	 oUH4fe6uQyPskNMTYhbYcFp2adtQHtPCsDzumJBM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.24
Date: Wed, 22 Apr 2026 13:58:05 +0200
Message-ID: <2026042206-reuse-prelaunch-f58d@gregkh>
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
	TAGGED_FROM(0.00)[bounces-240318-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 533FB445A3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.18.24 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/mm/damon/reclaim.rst                      |    4 
 Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml     |    4 
 Makefile                                                            |    2 
 arch/arm/boot/dts/microchip/sam9x7.dtsi                             |    2 
 arch/arm64/boot/dts/freescale/imx8mq.dtsi                           |    2 
 arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi                   |   20 
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts                     |    2 
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi                   |   26 -
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts                            |    2 
 arch/arm64/boot/dts/qcom/qcs8300.dtsi                               |    9 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                              |    2 
 arch/arm64/include/asm/pgtable-prot.h                               |    2 
 arch/arm64/include/asm/pgtable.h                                    |    9 
 arch/arm64/include/asm/uaccess.h                                    |    2 
 arch/arm64/kvm/guest.c                                              |    4 
 arch/arm64/mm/mmu.c                                                 |    4 
 arch/arm64/mm/pageattr.c                                            |   50 +-
 arch/arm64/mm/trans_pgd.c                                           |   42 -
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
 arch/x86/kernel/shstk.c                                             |    3 
 arch/x86/kvm/svm/sev.c                                              |   46 +-
 arch/x86/kvm/x86.c                                                  |   18 
 arch/x86/lib/copy_user_uncached_64.S                                |    6 
 arch/x86/lib/usercopy_32.c                                          |    9 
 arch/x86/lib/usercopy_64.c                                          |   12 
 crypto/af_alg.c                                                     |    6 
 crypto/algif_aead.c                                                 |    2 
 crypto/algif_skcipher.c                                             |    5 
 drivers/ata/ahci.c                                                  |   14 
 drivers/dma/idxd/device.c                                           |   17 
 drivers/dma/idxd/init.c                                             |   10 
 drivers/gpio/gpio-tegra.c                                           |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                              |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                              |    7 
 drivers/gpu/drm/i915/i915_gem.c                                     |    2 
 drivers/gpu/drm/qxl/qxl_ioctl.c                                     |    2 
 drivers/gpu/drm/vc4/vc4_bo.c                                        |    3 
 drivers/gpu/drm/vc4/vc4_gem.c                                       |   19 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                      |   14 
 drivers/gpu/drm/vc4/vc4_v3d.c                                       |    1 
 drivers/gpu/drm/xe/xe_hw_engine.c                                   |    3 
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                              |    3 
 drivers/hid/hid-alps.c                                              |    3 
 drivers/hid/hid-core.c                                              |    3 
 drivers/hid/hid-ids.h                                               |    3 
 drivers/hid/hid-quirks.c                                            |    1 
 drivers/hid/hid-roccat.c                                            |    2 
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c             |    6 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h             |    2 
 drivers/hwmon/powerz.c                                              |    8 
 drivers/i2c/busses/i2c-s3c2410.c                                    |    7 
 drivers/infiniband/hw/irdma/verbs.c                                 |    1 
 drivers/infiniband/sw/rdmavt/qp.c                                   |    8 
 drivers/md/bcache/super.c                                           |    7 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c |    9 
 drivers/media/platform/rockchip/rkvdec/rkvdec-vp9.c                 |    3 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                     |    4 
 drivers/media/test-drivers/vidtv/vidtv_channel.c                    |    4 
 drivers/media/test-drivers/vidtv/vidtv_mux.c                        |    4 
 drivers/media/test-drivers/vidtv/vidtv_ts.c                         |   48 +-
 drivers/media/test-drivers/vidtv/vidtv_ts.h                         |    4 
 drivers/media/usb/as102/as102_usb_drv.c                             |    2 
 drivers/media/usb/em28xx/em28xx-video.c                             |   14 
 drivers/media/usb/hackrf/hackrf.c                                   |    7 
 drivers/net/can/spi/mcp251x.c                                       |   29 +
 drivers/net/ethernet/airoha/airoha_eth.c                            |    3 
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c                    |    8 
 drivers/net/ethernet/intel/ice/ice_ptp.c                            |    8 
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c                  |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe.h                            |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c                    |   13 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                       |   10 
 drivers/net/ethernet/intel/ixgbevf/vf.c                             |    7 
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c                   |   19 
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h                     |    8 
 drivers/net/ipa/reg/gsi_reg-v5.0.c                                  |    9 
 drivers/net/mdio/mdio-realtek-rtl9300.c                             |    3 
 drivers/net/phy/sfp.c                                               |   16 
 drivers/net/usb/cdc-phonet.c                                        |    7 
 drivers/net/wan/lapbether.c                                         |   13 
 drivers/net/wireguard/device.c                                      |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c             |    5 
 drivers/net/wireless/realtek/rtw88/usb.c                            |    3 
 drivers/net/wireless/ti/wl1251/tx.c                                 |    8 
 drivers/nfc/s3fwrn5/uart.c                                          |   10 
 drivers/ntb/ntb_transport.c                                         |    7 
 drivers/pci/controller/pci-hyperv.c                                 |    8 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                       |   20 
 drivers/pinctrl/intel/pinctrl-intel.c                               |    2 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                           |    9 
 drivers/platform/x86/asus-nb-wmi.c                                  |    2 
 drivers/platform/x86/hp/hp-wmi.c                                    |    4 
 drivers/soc/aspeed/aspeed-socinfo.c                                 |    2 
 drivers/soc/qcom/pdr_internal.h                                     |    2 
 drivers/soc/qcom/qcom_pdr_msg.c                                     |    2 
 drivers/staging/rtl8723bs/core/rtw_security.c                       |    2 
 drivers/staging/sm750fb/sm750.c                                     |    3 
 drivers/usb/class/cdc-acm.c                                         |   53 ++
 drivers/usb/core/port.c                                             |    1 
 drivers/usb/gadget/function/f_hid.c                                 |   15 
 drivers/usb/gadget/function/f_ncm.c                                 |    4 
 drivers/usb/gadget/function/f_phonet.c                              |    9 
 drivers/usb/gadget/udc/renesas_usb3.c                               |    7 
 drivers/usb/serial/option.c                                         |    2 
 drivers/usb/storage/unusual_devs.h                                  |    7 
 drivers/usb/typec/tcpm/fusb302.c                                    |    5 
 drivers/usb/usbip/usbip_common.c                                    |   12 
 drivers/video/fbdev/tdfxfb.c                                        |    3 
 drivers/video/fbdev/udlfb.c                                         |    3 
 fs/btrfs/tree-log.c                                                 |   98 +++-
 fs/dcache.c                                                         |    4 
 fs/eventpoll.c                                                      |    6 
 fs/nilfs2/dat.c                                                     |    3 
 fs/ocfs2/aops.c                                                     |    3 
 fs/ocfs2/inode.c                                                    |   31 +
 fs/ocfs2/mmap.c                                                     |    7 
 fs/ocfs2/ocfs2_trace.h                                              |   10 
 fs/ocfs2/resize.c                                                   |   10 
 fs/smb/client/fs_context.c                                          |    4 
 fs/smb/client/smb2file.c                                            |   20 
 fs/smb/client/smb2inode.c                                           |    2 
 fs/smb/client/smbdirect.c                                           |    8 
 fs/smb/server/connection.c                                          |    1 
 fs/smb/server/smb2pdu.c                                             |    7 
 fs/smb/server/smbacl.c                                              |    3 
 fs/smb/server/transport_rdma.c                                      |    8 
 include/linux/dma-mapping.h                                         |    7 
 include/linux/hugetlb.h                                             |   17 
 include/linux/kvm_host.h                                            |   93 ++--
 include/linux/mmap_lock.h                                           |    6 
 include/linux/soc/qcom/pdr.h                                        |    1 
 include/linux/uaccess.h                                             |   11 
 include/net/ip_tunnels.h                                            |    2 
 include/net/netfilter/nf_conntrack_core.h                           |    5 
 include/net/netfilter/nf_queue.h                                    |    1 
 include/net/xdp_sock.h                                              |    2 
 include/net/xdp_sock_drv.h                                          |   23 +
 include/trace/events/btrfs.h                                        |   11 
 include/trace/events/dma.h                                          |    3 
 include/uapi/linux/kvm.h                                            |   19 
 kernel/dma/debug.c                                                  |   35 +
 kernel/sched/deadline.c                                             |    2 
 kernel/trace/trace_probe.c                                          |    2 
 lib/iov_iter.c                                                      |    4 
 mm/backing-dev.c                                                    |    5 
 mm/kasan/init.c                                                     |    8 
 mm/userfaultfd.c                                                    |    2 
 net/bluetooth/hci_conn.c                                            |    2 
 net/bluetooth/hci_core.c                                            |    2 
 net/bluetooth/hci_sync.c                                            |   20 
 net/bridge/br_fdb.c                                                 |    6 
 net/can/raw.c                                                       |   11 
 net/core/rtnetlink.c                                                |   40 +
 net/devlink/health.c                                                |    2 
 net/ipv4/icmp.c                                                     |    7 
 net/ipv4/nexthop.c                                                  |   41 +
 net/ipv6/ioam6.c                                                    |   33 -
 net/ipv6/netfilter/ip6t_eui64.c                                     |    3 
 net/l2tp/l2tp_core.c                                                |    5 
 net/netfilter/ipvs/ip_vs_ctl.c                                      |    1 
 net/netfilter/nf_conntrack_ecache.c                                 |    2 
 net/netfilter/nf_conntrack_expect.c                                 |   10 
 net/netfilter/nf_conntrack_netlink.c                                |   30 -
 net/netfilter/nf_conntrack_proto_sctp.c                             |    3 
 net/netfilter/nfnetlink_log.c                                       |    8 
 net/netfilter/nfnetlink_queue.c                                     |  214 +++-------
 net/netfilter/nft_set_pipapo_avx2.c                                 |   20 
 net/netfilter/xt_multiport.c                                        |   34 +
 net/nfc/digital_technology.c                                        |    6 
 net/nfc/llcp_core.c                                                 |    2 
 net/sched/act_csum.c                                                |    6 
 net/unix/diag.c                                                     |   21 
 net/xdp/xdp_umem.c                                                  |    3 
 net/xdp/xsk.c                                                       |    4 
 net/xdp/xsk_buff_pool.c                                             |   32 +
 net/xfrm/xfrm_policy.c                                              |    5 
 net/xfrm/xfrm_user.c                                                |   11 
 scripts/checkpatch.pl                                               |   10 
 scripts/generate_rust_analyzer.py                                   |    3 
 sound/firewire/fireworks/fireworks_command.c                        |    5 
 sound/hda/codecs/realtek/alc269.c                                   |   13 
 sound/pci/asihpi/hpimsgx.c                                          |    6 
 sound/pci/ctxfi/ctvmem.h                                            |    2 
 sound/soc/amd/acp/acp-sdw-legacy-mach.c                             |   16 
 sound/soc/amd/yc/acp6x-mach.c                                       |   21 
 sound/soc/intel/avs/board_selection.c                               |    9 
 sound/soc/qcom/qdsp6/q6apm.c                                        |   14 
 sound/soc/sdca/sdca_interrupts.c                                    |    4 
 sound/soc/soc-core.c                                                |    1 
 sound/soc/sof/topology.c                                            |    2 
 sound/soc/stm/stm32_sai_sub.c                                       |    3 
 sound/usb/6fire/chip.c                                              |   17 
 sound/usb/Kconfig                                                   |    1 
 sound/usb/quirks.c                                                  |    2 
 sound/usb/usx2y/us144mkii.c                                         |    6 
 tools/objtool/check.c                                               |    2 
 tools/power/x86/turbostat/turbostat.c                               |   44 +-
 tools/testing/selftests/bpf/progs/verifier_bounds.c                 |  137 ++++++
 tools/testing/selftests/kvm/x86/sev_migrate_tests.c                 |    2 
 tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh         |    1 
 virt/kvm/binary_stats.c                                             |    2 
 virt/kvm/kvm_main.c                                                 |   20 
 216 files changed, 1621 insertions(+), 791 deletions(-)

Abd-Alrhman Masalkhi (1):
      media: vidtv: fix pass-by-value structs causing MSAN warnings

Abhishek Kumar (1):
      media: em28xx: fix use-after-free in em28xx_v4l2_open()

Agalakov Daniil (1):
      e1000: check return value of e1000_read_eeprom

Aleksandr Loktionov (1):
      ixgbe: stop re-reading flash on every get_drvinfo for e610

Alexander Koskovich (2):
      net: ipa: fix GENERIC_CMD register field masks for IPA v5.0+
      net: ipa: fix event ring index not programmed for IPA v5.0+

Alexander Savenko (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IMH9

Alexey Charkov (1):
      usb: typec: fusb302: Switch to threaded IRQ handler

Alice Mikityanska (1):
      l2tp: Drop large packets with UDP encap

Andrii Kovalchuk (1):
      ALSA: hda/realtek: Add HP ENVY Laptop 13-ba0xxx quirk

Andy Shevchenko (1):
      pinctrl: intel: Fix the revision for new features (1kOhm PD, HW debouncer)

Arnd Bergmann (2):
      media: rkvdec: reduce stack usage in rkvdec_init_v4l2_vp9_count_tbl()
      ALSA: asihpi: avoid write overflow check warning

Artem Bityutskiy (1):
      tools/power turbostat: Fix --show/--hide for individual cpuidle counters

Arthur Husband (1):
      ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585

Benoît Sevens (1):
      HID: roccat: fix use-after-free in roccat_report_event

Berk Cem Goksel (1):
      ALSA: 6fire: fix use-after-free on disconnect

Breno Leitao (1):
      mm: blk-cgroup: fix use-after-free in cgwb_release_workfn()

Cen Zhang (1):
      Bluetooth: hci_sync: annotate data-races around hdev->req_status

Cezary Rojewski (1):
      ASoC: Intel: avs: Fix memory leak in avs_register_i2s_test_boards()

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

David Woodhouse (1):
      KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs

Deepanshu Kartikey (2):
      ocfs2: validate inline data i_size during inode read
      nilfs2: fix NULL i_assoc_inode dereference in nilfs_mdt_save_to_shadow_map

Dmitry Antipov (1):
      ocfs2: add inline inode consistency check to ocfs2_validate_inode_block()

Donet Tom (2):
      drm/amdgpu: Handle GPU page faults correctly on non-4K page systems
      drm/amdkfd: Fix queue preemption/eviction failures by aligning control stack size to GPU page size

Douya Le (1):
      crypto: af_alg - limit RX SG extraction by receive buffer budget

Dustin L. Howett (1):
      ALSA: hda/realtek: add quirk for Framework F111:000F

Eric Dumazet (2):
      net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
      ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()

Even Xu (1):
      HID: Intel-thc-hid: Intel-quickspi: Add NVL Device IDs

Fabio Baltieri (1):
      net: txgbe: leave space for null terminators on property_entry

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FN990A MBIM composition

Fan Wu (1):
      media: mediatek: vcodec: fix use-after-free in encoder release path

Felix Gu (1):
      net: mdio: realtek-rtl9300: use scoped device_for_each_child_node loop

Fernando Fernandez Mancera (2):
      ipv4: nexthop: avoid duplicate NHA_HW_STATS_ENABLE on nexthop group dump
      ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()

Filipe Manana (1):
      btrfs: fix zero size inode with non-zero size after log replay

Florian Westphal (3):
      netfilter: nft_set_pipapo_avx2: don't return non-matching entry on expiry
      netfilter: nfnetlink_queue: make hash table per queue
      netfilter: conntrack: add missing netlink policy validations

Frank Zhang (1):
      ALSA:usb:qcom: add AUXILIARY_BUS to Kconfig dependencies

Fredric Cover (1):
      fs/smb/client: fix out-of-bounds read in cifs_sanitize_prepath

Gilson Marquato Júnior (1):
      ASoC: amd: yc: Add DMI entry for HP Laptop 15-fc0xxx

Goldwyn Rodrigues (1):
      btrfs: tracepoints: get correct superblock from dentry in event btrfs_sync_file()

Greg Kroah-Hartman (20):
      xfrm_user: fix info leak in build_mapping()
      i2c: s3c24xx: check the size of the SMBUS message before using it
      HID: alps: fix NULL pointer dereference in alps_raw_event()
      HID: core: clamp report_size in s32ton() to avoid undefined shift
      net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()
      NFC: digital: Bounds check NFC-A cascade depth in SDD response handler
      drm/vc4: platform_get_irq_byname() returns an int
      ALSA: usx2y: us144mkii: fix NULL deref on missing interface 0
      ALSA: fireworks: bound device-supplied status before string array lookup
      fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      usb: gadget: f_ncm: validate minimum block_len in ncm_unwrap_ntb()
      usb: gadget: f_phonet: fix skb frags[] overflow in pn_rx_complete()
      usb: gadget: renesas_usb3: validate endpoint index in standard request handlers
      smb: client: fix off-by-8 bounds check in check_wsl_eas()
      smb: client: fix OOB reads parsing symlink error response
      ksmbd: validate EaNameLength in smb2_get_ea()
      ksmbd: require 3 sub-authorities before reading sub_auth[2]
      ksmbd: fix mechToken leak when SPNEGO decode fails after token alloc
      fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      Linux 6.18.24

Harin Lee (1):
      ALSA: ctxfi: Limit PTP to a single page

Hasun Park (1):
      ASoC: amd: acp: add ASUS HN7306EA quirk for legacy SDW machine

Herbert Xu (2):
      crypto: af_alg - Fix page reassignment overflow in af_alg_pull_tsgl
      crypto: algif_aead - Fix minimum RX size check for decryption

Jacob Moroni (1):
      RDMA/irdma: Fix double free related to rereg_user_mr

Jeongjun Park (2):
      media: as102: fix to not free memory after the device is registered in as102_usb_probe()
      media: hackrf: fix to not free memory after the device is registered in hackrf_probe()

Jianhui Zhou (1):
      mm/userfaultfd: fix hugetlb fault mutex hash calculation

Jiexun Wang (1):
      af_unix: read UNIX_DIAG_VFS data under unix_state_lock

Johan Hovold (1):
      wifi: rtw88: fix device leak on probe failure

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

Justin Iurman (1):
      net: ioam6: fix OOB and missing lock

Keenan Dong (1):
      xfrm: account XFRMA_IF_ID in aevent size calculation

Kohei Enju (1):
      ice: ptp: don't WARN when controlling PF is unavailable

Koichiro Den (2):
      PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
      PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown

Kotlyarov Mihail (1):
      xfrm: fix refcount leak in xfrm_migrate_policy_find

Krishna Chomal (1):
      platform/x86: hp-wmi: Add support for Omen 16-wf1xxx (8C76)

Kshamendra Kumar Mishra (1):
      ALSA: hda/realtek: add HP Laptop 15-fd0xxx mute LED quirk

Kuninori Morimoto (1):
      ASoC: soc-core: call missing INIT_LIST_HEAD() for card_aux_list

Leon Romanovsky (2):
      dma-debug: Allow multiple invocations of overlapping entries
      dma-mapping: handle DMA_ATTR_CPU_CACHE_CLEAN in trace output

Li RongQing (1):
      devlink: Fix incorrect skb socket family dumping

Lin YuChen (1):
      staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_verify()

Linus Torvalds (4):
      x86: shadow stacks: proper error handling for mmap lock
      x86-64: rename misleadingly named '__copy_user_nocache()' function
      x86: rename and clean up __copy_from_user_inatomic_nocache()
      x86-64/arm64/powerpc: clean up and rename __copy_from_user_flushcache

Loic Poulain (2):
      arm64: dts: qcom: monaco: Fix UART10 pinconf
      arm64: dts: qcom: monaco: Reserve full Gunyah metadata region

Long Li (1):
      PCI: hv: Set default NUMA node to 0 for devices without affinity info

Lorenzo Bianconi (1):
      net: airoha: Fix memory leak in airoha_qdma_rx_process()

Luke Wang (1):
      arm64: dts: imx93-9x9-qsb: change usdhc tuning step for eMMC and SD

Maciej Fijalkowski (4):
      xsk: tighten UMEM headroom validation to account for tailroom and min frame
      xsk: respect tailroom for ZC setups
      xsk: fix XDP_UMEM_SG_FLAG issues
      xsk: validate MTU against usable frame size on bind

Maciej Strozek (1):
      ASoC: SDCA: Fix overwritten var within for loop

Mario Limonciello (1):
      platform/x86/amd: pmc: Add Thinkpad L14 Gen3 to quirk_s2idle_bug

Markus Niebel (2):
      arm64: dts: imx91-tqma9131: improve eMMC pad configuration
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

Michael S. Tsirkin (2):
      dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN
      dma-debug: track cache clean flag in entries

Michael Zimmermann (1):
      usb: gadget: f_hid: don't call cdev_init while cdev in use

Michal Schmidt (1):
      ixgbevf: add missing negotiate_features op to Hyper-V ops table

Mihai Sain (1):
      ARM: dts: microchip: sam9x7: fix gpio-lines count for pioB

Mikhail Gavrilov (1):
      dma-debug: suppress cacheline overlap warning when arch has no DMA alignment requirement

Mingzhe Zou (1):
      bcache: fix cached_dev.sb_bio use-after-free and crash

Mukesh Ojha (1):
      soc: qcom: pd-mapper: Fix element length in servreg_loc_pfr_req_ei

Nathan Rebello (1):
      usbip: validate number_of_packets in usbip_pack_ret_submit()

Nicholas Carlini (1):
      eventpoll: defer struct eventpoll free to RCU grace period

Nikolaos Gkarlis (1):
      rtnetlink: add missing netlink_ns_capable() check for peer netns

Pablo Neira Ayuso (1):
      netfilter: ctnetlink: ensure safe access to master conntrack

Paul Chaignon (1):
      selftests/bpf: Test refinement of single-value tnum

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

Ravi Hothi (1):
      arm64: dts: qcom: qcm6490-idp: Fix WCD9370 reset GPIO polarity

Ren Wei (1):
      netfilter: xt_multiport: validate range encoding in checkentry

Ritesh Harjani (IBM) (1):
      mm/kasan: fix double free for kasan pXds

Ruide Cao (1):
      net: sched: act_csum: validate nested VLAN headers

Ruslan Valiyev (2):
      media: vidtv: fix NULL pointer dereference in vidtv_channel_pmt_match_sections
      media: vidtv: fix nfeeds state corruption on start_streaming failure

Ryan Roberts (1):
      arm64: mm: Handle invalid large leaf mappings correctly

Samasth Norway Ananda (1):
      gpio: tegra: fix irq_release_resources calling enable instead of disable

Samuel Page (1):
      can: raw: fix ro->uniq use-after-free in raw_rcv()

Sanman Pradhan (1):
      hwmon: (powerz) Fix use-after-free on USB disconnect

Sasha Levin (1):
      checkpatch: add support for Assisted-by tag

Scott Mitchell (1):
      netfilter: nfnetlink_queue: nfqnl_instance GFP_ATOMIC -> GFP_KERNEL_ACCOUNT allocation

Sean Christopherson (8):
      KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in SEV-ES migrate test
      KVM: SEV: Reject attempts to sync VMSA of an already-launched/encrypted vCPU
      KVM: SEV: Protect *all* of sev_mem_enc_register_region() with kvm->lock
      KVM: SEV: Disallow LAUNCH_FINISH if vCPUs are actively being created
      KVM: SEV: Lock all vCPUs when synchronzing VMSAs for SNP launch finish
      KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
      KVM: Remove subtle "struct kvm_stats_desc" pseudo-overlay
      KVM: x86: Use scratch field in MMIO fragment to hold small write values

Sebastian Krzyszkowiak (1):
      arm64: dts: imx8mq: Set the correct gpu_ahb clock frequency

SeongJae Park (1):
      Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race

Serhii Pievniev (1):
      tools/power/turbostat: Fix microcode patch level output for AMD/Hygon

Shardul Bankar (1):
      wireguard: device: use exit_rtnl callback instead of manual rtnl_lock in pre_exit

Srinivas Kandagatla (1):
      ASoC: qcom: q6apm: move component registration to unmanaged version

Stefan Metzmacher (2):
      smb: client: avoid double-free in smbd_free_send_io() after smbd_send_batch_flush()
      smb: server: avoid double-free in smb_direct_free_sendmsg after smb_direct_flush_send_list()

Steffen Klassert (1):
      xfrm: Wait for RCU readers during policy netns exit

Syed Saba Kareem (1):
      ASoC: amd: acp: update DMI quirk and add ACP DMIC for Lenovo platforms

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

Vinay Belgaumkar (1):
      drm/xe: Fix bug in idledly unit conversion

Vinicius Costa Gomes (1):
      dmaengine: idxd: Fix lockdep warnings when calling idxd_device_config()

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

Zhang Heng (2):
      ALSA: hda/realtek: add quirk for Lenovo Yoga 7 2-in-1 16AKP10
      ASoC: amd: yc: Add DMI quirk for Thin A15 B7VF

ZhengYuan Huang (1):
      ocfs2: handle invalid dinode in ocfs2_group_extend

Zhengchuan Liang (1):
      netfilter: ip6t_eui64: reject invalid MAC header for all packets

Zhihao Cheng (1):
      dcache: Limit the minimal number of bucket to two

Zide Chen (1):
      perf/x86/intel/uncore: Skip discovery table for offline dies

Zijing Yin (1):
      bridge: guard local VLAN-0 FDB helpers against NULL vlan group

leo vriska (1):
      HID: quirks: add HID_QUIRK_ALWAYS_POLL for 8BitDo Pro 3

songxiebing (2):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Slim 7 14AKP10
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IAH10



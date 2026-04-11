Return-Path: <stable+bounces-235722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAvbKDJF2mkrzggAu9opvQ
	(envelope-from <stable+bounces-235722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 14:57:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA2F3E0033
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24D9D307E067
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB03720D4E9;
	Sat, 11 Apr 2026 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xhBlcgej"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21B1F03D7;
	Sat, 11 Apr 2026 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775912010; cv=none; b=kZK0l7STpG8CInxCbNZgoc6X1ZjNObu/UJb2AJ4h9/WK9CITqt43fj8XtbN+QwmtRaq/KQMYDNGDTI/XbFofPYNZDL03Suei1rtJck303MAlBJKmzD0JxFvApWpn3j7mquhUbiPtEnBCmriZvySlGPYbm4/K42qBvDikvwVyf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775912010; c=relaxed/simple;
	bh=801KvvKghDWvQqwBCl9UOzYz4DzPw3TE8NARPGk0+gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZcAc+KLhT9fXFgWTQ63/Jj8U7/NPCklvSAqT388I/qV9Ym9NTbXRBbot2jOv/sGB569uNi/Eb4WGLPcRdPHb5FLXm2bUK9KC3xwzh2FBaidQKIZViWF/1iy1YnIYVgrsOkPYdILmX2zJYqDhdDZV0xZ2X9H3ojKNiqICRer+4M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xhBlcgej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9DCC4CEF7;
	Sat, 11 Apr 2026 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775912010;
	bh=801KvvKghDWvQqwBCl9UOzYz4DzPw3TE8NARPGk0+gM=;
	h=From:To:Cc:Subject:Date:From;
	b=xhBlcgejjBTKv6Vnfc9qTEGtmrHzU333J77fDg/Scnf+60q477MyCoAOWgMGIrzsR
	 ecrPAFv19NfQcw/WE1kh+vyh41qrt2+yZvl3znb9t3ZkSnhQI3hPi3UWQDIGU8yezT
	 8mym7DjKdjGRFzwNHhl0QsSYWGWgpzZUYr2DhQQk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.81
Date: Sat, 11 Apr 2026 14:53:26 +0200
Message-ID: <2026041126-submitter-showdown-090f@gregkh>
X-Mailer: git-send-email 2.53.0
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
	TAGGED_FROM(0.00)[bounces-235722-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FA2F3E0033
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.12.81 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml |    2 
 Documentation/devicetree/bindings/connector/usb-connector.yaml   |    1 
 Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml  |    4 
 Makefile                                                         |    2 
 arch/arm64/kernel/pi/patch-scs.c                                 |    8 
 arch/loongarch/include/asm/setup.h                               |    3 
 arch/loongarch/kernel/unwind_orc.c                               |   32 -
 arch/mips/lib/multi3.c                                           |    6 
 arch/mips/mm/cache.c                                             |    3 
 arch/mips/mm/tlb-r4k.c                                           |    2 
 arch/mips/ralink/clk.c                                           |    8 
 arch/riscv/kernel/kgdb.c                                         |    7 
 arch/s390/kernel/perf_cpum_sf.c                                  |   30 -
 arch/x86/coco/sev/core.c                                         |    6 
 arch/x86/entry/entry_fred.c                                      |   14 
 arch/x86/kernel/cpu/amd.c                                        |    7 
 crypto/af_alg.c                                                  |    4 
 drivers/accel/qaic/qaic_control.c                                |   47 +
 drivers/comedi/drivers.c                                         |    8 
 drivers/comedi/drivers/dt2815.c                                  |   12 
 drivers/comedi/drivers/me4000.c                                  |   16 
 drivers/comedi/drivers/me_daq.c                                  |   35 -
 drivers/comedi/drivers/ni_atmio16d.c                             |    3 
 drivers/counter/rz-mtu3-cnt.c                                    |   67 +-
 drivers/cpufreq/cpufreq_governor.c                               |    6 
 drivers/crypto/caam/caamalg_qi2.c                                |    3 
 drivers/crypto/caam/caamhash.c                                   |    3 
 drivers/crypto/tegra/tegra-se-aes.c                              |   11 
 drivers/crypto/tegra/tegra-se-hash.c                             |   30 -
 drivers/firmware/microchip/mpfs-auto-update.c                    |   10 
 drivers/gpio/gpio-mxc.c                                          |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                       |   39 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c                          |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h                           |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                            |    4 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c      |   17 
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c            |   49 +
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c        |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c                   |    1 
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c                   |    1 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c             |   33 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c             |   33 +
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c                   |    1 
 drivers/gpu/drm/ast/ast_dp501.c                                  |    2 
 drivers/gpu/drm/drm_file.c                                       |    5 
 drivers/gpu/drm/drm_ioc32.c                                      |    2 
 drivers/gpu/drm/drm_mode_config.c                                |    9 
 drivers/gpu/drm/i915/display/g4x_dp.c                            |    2 
 drivers/gpu/drm/i915/display/icl_dsi.c                           |    4 
 drivers/hid/hid-logitech-hidpp.c                                 |    6 
 drivers/hid/hid-multitouch.c                                     |    7 
 drivers/hid/wacom_wac.c                                          |   10 
 drivers/hwmon/occ/common.c                                       |   19 
 drivers/hwmon/pmbus/ltc4286.c                                    |    1 
 drivers/hwmon/pmbus/pxe1610.c                                    |    5 
 drivers/hwmon/pmbus/tps53679.c                                   |    4 
 drivers/i2c/busses/Kconfig                                       |    2 
 drivers/i2c/busses/i2c-tegra.c                                   |    5 
 drivers/iio/accel/adxl355_core.c                                 |    2 
 drivers/iio/accel/adxl380.c                                      |    2 
 drivers/iio/adc/aspeed_adc.c                                     |    1 
 drivers/iio/adc/ti-adc161s626.c                                  |   41 -
 drivers/iio/adc/ti-ads1119.c                                     |   11 
 drivers/iio/dac/ad5770r.c                                        |    2 
 drivers/iio/gyro/mpu3050-core.c                                  |   32 -
 drivers/iio/imu/bmi160/bmi160_core.c                             |   15 
 drivers/iio/imu/bno055/bno055.c                                  |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c                   |    4 
 drivers/iio/light/vcnl4035.c                                     |   18 
 drivers/input/joystick/xpad.c                                    |    5 
 drivers/input/mouse/bcm5974.c                                    |   42 +
 drivers/input/rmi4/rmi_f54.c                                     |    4 
 drivers/input/serio/i8042-acpipnpio.h                            |    7 
 drivers/misc/fastrpc.c                                           |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                        |    2 
 drivers/net/ethernet/broadcom/tg3.c                              |   13 
 drivers/net/ethernet/cadence/macb_pci.c                          |   10 
 drivers/net/ethernet/faraday/ftgmac100.c                         |   28 
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c             |    4 
 drivers/net/ethernet/freescale/fec_ptp.c                         |    3 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                     |   11 
 drivers/net/ethernet/mediatek/airoha_eth.c                       |   18 
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c                  |   21 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c                |    4 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/fw.c                     |   53 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c            |    3 
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h              |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c                     |    6 
 drivers/net/ethernet/microsoft/mana/mana_en.c                    |    6 
 drivers/net/ethernet/xilinx/xilinx_axienet.h                     |    4 
 drivers/net/phy/sfp.c                                            |    7 
 drivers/net/vxlan/vxlan_core.c                                   |    6 
 drivers/net/wireless/ath/ath11k/dp_rx.c                          |   15 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                      |    2 
 drivers/net/wireless/microchip/wilc1000/hif.c                    |    2 
 drivers/net/wireless/virtual/virt_wifi.c                         |    1 
 drivers/nfc/pn533/uart.c                                         |    3 
 drivers/nvmem/imx-ocotp-ele.c                                    |    1 
 drivers/nvmem/imx-ocotp.c                                        |    1 
 drivers/nvmem/zynqmp_nvmem.c                                     |    8 
 drivers/spi/spi-cadence-quadspi.c                                |   13 
 drivers/spi/spi-geni-qcom.c                                      |    9 
 drivers/target/loopback/tcm_loop.c                               |   52 +
 drivers/thermal/thermal_core.c                                   |    1 
 drivers/thunderbolt/nhi.c                                        |    2 
 drivers/usb/cdns3/cdns3-gadget.c                                 |    4 
 drivers/usb/class/cdc-acm.c                                      |    9 
 drivers/usb/class/cdc-acm.h                                      |    1 
 drivers/usb/class/usbtmc.c                                       |    3 
 drivers/usb/common/ulpi.c                                        |    5 
 drivers/usb/core/phy.c                                           |   12 
 drivers/usb/core/quirks.c                                        |    3 
 drivers/usb/dwc2/gadget.c                                        |    2 
 drivers/usb/gadget/function/f_ecm.c                              |   37 -
 drivers/usb/gadget/function/f_eem.c                              |   59 +-
 drivers/usb/gadget/function/f_hid.c                              |   19 
 drivers/usb/gadget/function/f_rndis.c                            |   51 +
 drivers/usb/gadget/function/f_subset.c                           |   63 +-
 drivers/usb/gadget/function/f_uac1_legacy.c                      |   47 +
 drivers/usb/gadget/function/f_uvc.c                              |   39 +
 drivers/usb/gadget/function/u_ecm.h                              |   21 
 drivers/usb/gadget/function/u_eem.h                              |   21 
 drivers/usb/gadget/function/u_ether.c                            |   16 
 drivers/usb/gadget/function/u_gether.h                           |   22 
 drivers/usb/gadget/function/u_rndis.h                            |   31 -
 drivers/usb/gadget/function/uvc.h                                |    3 
 drivers/usb/gadget/function/uvc_v4l2.c                           |    5 
 drivers/usb/gadget/udc/dummy_hcd.c                               |   42 -
 drivers/usb/host/ehci-brcm.c                                     |    4 
 drivers/usb/serial/io_edgeport.c                                 |    3 
 drivers/usb/serial/io_usbvend.h                                  |    1 
 drivers/usb/serial/option.c                                      |    4 
 drivers/usb/typec/ucsi/ucsi.c                                    |    9 
 fs/btrfs/inode.c                                                 |    6 
 fs/btrfs/ioctl.c                                                 |   12 
 fs/btrfs/tree-checker.c                                          |   17 
 fs/btrfs/zoned.c                                                 |    6 
 fs/ext4/fast_commit.c                                            |    4 
 fs/ext4/inode.c                                                  |   15 
 fs/smb/server/smb2pdu.c                                          |  121 +++-
 fs/smb/server/smbacl.c                                           |   43 +
 fs/smb/server/smbacl.h                                           |    2 
 include/linux/io_uring_types.h                                   |    9 
 include/linux/netdevice.h                                        |    3 
 include/linux/netfilter/ipset/ip_set.h                           |    2 
 include/linux/swapops.h                                          |   27 
 include/net/netfilter/nf_conntrack_expect.h                      |   20 
 io_uring/io_uring.c                                              |   15 
 io_uring/io_uring.h                                              |    1 
 io_uring/kbuf.c                                                  |  289 ++++------
 io_uring/kbuf.h                                                  |  148 +----
 io_uring/net.c                                                   |  149 ++---
 io_uring/poll.c                                                  |    4 
 io_uring/rw.c                                                    |   58 +-
 kernel/bpf/verifier.c                                            |   87 ++-
 kernel/sched/fair.c                                              |   12 
 mm/gup.c                                                         |   10 
 mm/hmm.c                                                         |    2 
 mm/memory.c                                                      |   22 
 mm/mprotect.c                                                    |    2 
 mm/sparse-vmemmap.c                                              |    2 
 mm/vmscan.c                                                      |    2 
 net/atm/lec.c                                                    |   72 +-
 net/atm/lec.h                                                    |    2 
 net/bluetooth/hci_conn.c                                         |    8 
 net/bluetooth/hci_event.c                                        |   33 -
 net/bluetooth/hci_sync.c                                         |   14 
 net/bluetooth/mgmt.c                                             |   17 
 net/bluetooth/sco.c                                              |   26 
 net/bluetooth/smp.c                                              |   11 
 net/bridge/br_arp_nd_proxy.c                                     |   18 
 net/core/dev.c                                                   |   38 +
 net/core/skmsg.c                                                 |   13 
 net/hsr/hsr_device.c                                             |   32 -
 net/ipv6/addrconf.c                                              |    6 
 net/ipv6/datagram.c                                              |   10 
 net/ipv6/icmp.c                                                  |    3 
 net/ipv6/ioam6.c                                                 |    4 
 net/ipv6/ip6_flowlabel.c                                         |    5 
 net/ipv6/ip6_tunnel.c                                            |    5 
 net/ipv6/ndisc.c                                                 |    3 
 net/mac80211/tdls.c                                              |    2 
 net/mptcp/pm_netlink.c                                           |    2 
 net/netfilter/ipset/ip_set_core.c                                |    4 
 net/netfilter/ipset/ip_set_hash_gen.h                            |    2 
 net/netfilter/ipset/ip_set_list_set.c                            |    4 
 net/netfilter/nf_conntrack_broadcast.c                           |    8 
 net/netfilter/nf_conntrack_expect.c                              |   25 
 net/netfilter/nf_conntrack_h323_main.c                           |   12 
 net/netfilter/nf_conntrack_helper.c                              |   13 
 net/netfilter/nf_conntrack_netlink.c                             |   87 +--
 net/netfilter/nf_conntrack_sip.c                                 |    4 
 net/netfilter/nf_flow_table_offload.c                            |  196 ++++--
 net/netfilter/nf_tables_api.c                                    |    7 
 net/netfilter/nfnetlink_log.c                                    |    2 
 net/netfilter/x_tables.c                                         |   23 
 net/netfilter/xt_cgroup.c                                        |    6 
 net/netfilter/xt_rateest.c                                       |    5 
 net/qrtr/af_qrtr.c                                               |   31 -
 net/rds/ib_rdma.c                                                |    7 
 net/sched/cls_api.c                                              |    1 
 net/sched/cls_flow.c                                             |   10 
 net/sched/cls_fw.c                                               |   14 
 net/sched/sch_hfsc.c                                             |    4 
 net/sched/sch_netem.c                                            |    5 
 net/x25/x25_in.c                                                 |    9 
 net/x25/x25_subr.c                                               |    1 
 sound/pci/ctxfi/ctdaio.c                                         |    1 
 sound/soc/cirrus/ep93xx-i2s.c                                    |   34 -
 sound/soc/intel/boards/Kconfig                                   |    2 
 sound/usb/caiaq/device.c                                         |    2 
 tools/objtool/check.c                                            |    5 
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c              |   62 ++
 tools/testing/selftests/bpf/progs/verifier_bounds.c              |  159 +++++
 215 files changed, 2592 insertions(+), 1281 deletions(-)

Adrian Freund (1):
      HID: logitech-hidpp: Enable MX Master 4 over bluetooth

Alan Stern (2):
      USB: dummy-hcd: Fix locking/synchronization error
      USB: dummy-hcd: Fix interrupt synchronization error

Alex Deucher (1):
      drm/amdgpu/pm: drop SMU driver if version not matched messages

Alexander Popov (1):
      wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free

Alexei Starovoitov (1):
      bpf: Fix regsafe() for pointers to packet

Alexey Velichayshiy (1):
      wifi: iwlwifi: mvm: fix potential out-of-bounds read in iwl_mvm_nd_match_info_handler()

Anshuman Khandual (1):
      mm: replace READ_ONCE() with standard page table accessors

Antoniu Miclaus (2):
      iio: accel: adxl380: fix FIFO watermark bit 8 always written as 0
      iio: dac: ad5770r: fix error return in ad5770r_read_raw()

Asim Viladi Oglu Manizada (1):
      ksmbd: fix OOB write in QUERY_INFO for compound requests

Bart Van Assche (1):
      Input: synaptics-rmi4 - fix a locking bug in an error path

Benoît Sevens (1):
      HID: wacom: fix out-of-bounds read in wacom_intuos_bt_irq

Berk Cem Goksel (1):
      ALSA: caiaq: fix stack out-of-bounds read in init_card

Billy Tsai (1):
      iio: adc: aspeed: clear reference voltage bits before configuring vref

Buday Csaba (1):
      net: fec: fix the PTP periodic output sysfs interface

Caleb Sander Mateos (1):
      io_uring/kbuf: use READ_ONCE() for userspace-mapped memory

Cen Zhang (1):
      Bluetooth: SCO: fix race conditions in sco_sock_connect()

Charlene Liu (1):
      drm/amd/display: Correct logic check error for fastboot

Christian Eggers (1):
      nvmem: imx: assign nvmem_cell_info::raw_len

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Max 16 Gen10 AMD to i8042 quirk table

Conor Dooley (1):
      firmware: microchip: fail auto-update probe if no flash found

Cosmin Tanislav (2):
      counter: rz-mtu3-cnt: prevent counter from being toggled multiple times
      counter: rz-mtu3-cnt: do not use struct rz_mtu3_channel's dev member

David Hildenbrand (Arm) (1):
      mm/memory: fix PMD/PUD checks in follow_pfnmap_start()

David Lechner (4):
      iio: imu: bno055: fix BNO055_SCAN_CH_COUNT off by one
      iio: adc: ti-adc161s626: fix buffer read on big-endian
      iio: adc: ti-adc161s626: use DMA-safe memory for spi_read()
      iio: light: vcnl4035: fix scan buffer on big-endian

Deepanshu Kartikey (3):
      wifi: mac80211: check tdls flag in ieee80211_tdls_oper
      atm: lec: fix use-after-free in sock_def_readable()
      comedi: dt2815: add hardware detection to prevent crash

Dimitri Daskalakis (1):
      eth: fbnic: Account for page fragments when updating BDQ tail

Donet Tom (1):
      drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 64KB

Eduard Zingerman (2):
      bpf: Fix u32/s32 bounds when ranges cross min/max boundary
      selftests/bpf: test refining u32/s32 bounds when ranges cross min/max boundary

Emanuele Ghidoli (1):
      spi: cadence-qspi: Fix exec_mem_op error handling

Eric Biggers (1):
      crypto: tegra - Add missing CRYPTO_ALG_ASYNC

Eric Dumazet (3):
      ipv6: icmp: clear skb2->cb[] in ip6_err_gen_icmpv6_unreach()
      ip6_tunnel: clear skb2->cb[] in ip4ip6_err()
      ipv6: avoid overflows in ip6_datagram_send_ctl()

Ernestas Kulik (1):
      USB: serial: option: add MeiG Smart SRM825WN

Ethan Tidmore (4):
      iio: gyro: mpu3050: Fix incorrect free_irq() variable
      iio: gyro: mpu3050: Fix irq resource leak
      iio: gyro: mpu3050: Move iio_device_register() to correct location
      iio: gyro: mpu3050: Fix out-of-sequence free_irq()

Fedor Pchelkin (2):
      net: macb: fix clk handling on PCI glue driver removal
      net: macb: properly unregister fixed rate clocks

Felix Gu (3):
      iio: adc: ti-ads1119: Fix unbalanced pm reference count in ds1119_single_conversion()
      iio: adc: ti-ads1119: Reinit completion before wait_for_completion_timeout()
      iio: adc: ti-ads1119: Replace IRQF_ONESHOT with IRQF_NO_THREAD

Filipe Manana (2):
      btrfs: reserve enough transaction items for qgroup ioctls
      btrfs: do not free data reservation in fallback from inline due to -ENOSPC

Florian Westphal (3):
      netfilter: nfnetlink_log: account for netlink header size
      netfilter: x_tables: ensure names are nul-terminated
      netfilter: ipset: use nla_strcmp for IPSET_ATTR_NAME attr

Francesco Lavra (1):
      iio: imu: st_lsm6dsx: Set FIFO ODR for accelerometer and gyroscope only

Frank Li (1):
      dt-bindings: auxdisplay: ht16k33: Use unevaluatedProperties to fix common property warning

Frej Drejhammar (1):
      USB: serial: io_edgeport: add support for Blackbox IC135A

Gabor Juhos (1):
      usb: core: phy: avoid double use of 'usb3-phy'

Greg Kroah-Hartman (2):
      drm/ioc32: stop speculation on the drm_compat_ioctl path
      Linux 6.12.81

Guangshuo Li (3):
      usb: ulpi: fix double free in ulpi_register_interface() error path
      cpufreq: governor: fix double free in cpufreq_dbs_governor_init() error path
      net: mana: fix use-after-free in add_adev() error path

Guoyu Su (1):
      net: use skb_header_pointer() for TCPv4 GSO frag_off check

Heiko Carstens (1):
      s390/perf_cpum_sf: Convert to use try_cmpxchg128()

Heitor Alves de Siqueira (1):
      usb: usbtmc: Flush anchored URBs in usbtmc_release

Horia Geantă (2):
      crypto: caam - fix DMA corruption on long hmac keys
      crypto: caam - fix overflow on long hmac keys

Ian Abbott (4):
      comedi: Reinit dev->spinlock between attachments to low-level drivers
      comedi: ni_atmio16d: Fix invalid clean-up after failed attach
      comedi: me_daq: Fix potential overrun of firmware buffer
      comedi: me4000: Fix potential overrun of firmware buffer

Ivan Vera (1):
      nvmem: zynqmp_nvmem: Fix buffer size in DMA and memcpy

JP Hein (1):
      USB: core: add NO_LPM quirk for Razer Kiyo Pro webcam

Jamie Gibbons (1):
      dt-bindings: gpio: fix microchip #interrupt-cells

Jens Axboe (16):
      io_uring/kbuf: drop 'issue_flags' from io_put_kbuf(s)() arguments
      io_uring/net: don't use io_net_kbuf_recyle() for non-provided cases
      io_uring/net: clarify io_recv_buf_select() return value
      io_uring/kbuf: pass in struct io_buffer_list to commit/recycle helpers
      io_uring/kbuf: introduce struct io_br_sel
      io_uring/kbuf: use struct io_br_sel for multiple buffers picking
      io_uring/net: use struct io_br_sel->val as the recv finish value
      io_uring/net: use struct io_br_sel->val as the send finish value
      io_uring/kbuf: switch to storing struct io_buffer_list locally
      io_uring: remove async/poll related provided buffer recycles
      io_uring/net: correct type for min_not_zero() cast
      io_uring/rw: check for NULL io_br_sel when putting a buffer
      io_uring/kbuf: enable bundles for incrementally consumed buffers
      io_uring/kbuf: always use READ_ONCE() to read ring provided buffer lengths
      io_uring/kbuf: fix missing BUF_MORE for incremental buffers at EOF
      io_uring/kbuf: propagate BUF_MORE through early buffer commit path

Jiayuan Chen (1):
      net: qrtr: replace qrtr_tx_flow radix_tree with xarray to fix memory leak

Jihed Chaibi (1):
      ASoC: ep93xx: Fix unchecked clk_prepare_enable() and add rollback on failure

Jimmy Hu (1):
      usb: gadget: uvc: fix NULL pointer dereference during unbind race

Jinjiang Tu (1):
      mm/huge_memory: fix folio isn't locked in softleaf_to_folio()

Joanne Koong (1):
      io_uring/kbuf: use WRITE_ONCE() for userspace-shared buffer ring fields

Johannes Thumshirn (1):
      btrfs: don't take device_list_mutex when querying zone info

Josef Bacik (1):
      scsi: target: tcm_loop: Drain commands in target_reset handler

Josh Poimboeuf (2):
      objtool: Fix Clang jump table detection
      iio: imu: bmi160: Remove potential undefined behavior in bmi160_config_pin()

Julian Braha (1):
      ASoC: Intel: boards: fix unmet dependency on PINCTRL

Juno Choi (1):
      usb: dwc2: gadget: Fix spin_lock/unlock mismatch in dwc2_hsotg_udc_stop()

Junxi Qian (1):
      io_uring/net: fix slab-out-of-bounds read in io_bundle_nbufs()

Justin Chen (1):
      usb: ehci-brcm: fix sleep during atomic

Keenan Dong (2):
      Bluetooth: MGMT: validate LTK enc_size on load
      Bluetooth: MGMT: validate mesh send advertising payload length

Kenneth Feng (2):
      drm/amd/amdgpu: decouple ASPM with pcie dpm
      drm/amd/amdgpu: disable ASPM in some situations

Konrad Dybcio (1):
      thunderbolt: Fix property read in nhi_wake_supported()

Kuen-Han Tsai (8):
      usb: gadget: u_ether: Fix race between gether_disconnect and eth_stop
      usb: gadget: u_ether: Fix NULL pointer deref in eth_get_drvinfo
      usb: gadget: f_subset: Fix unbalanced refcnt in geth_free
      usb: gadget: f_rndis: Protect RNDIS options with mutex
      usb: gadget: f_ecm: Fix net_device lifecycle with device_move
      usb: gadget: f_eem: Fix net_device lifecycle with device_move
      usb: gadget: f_subset: Fix net_device lifecycle with device_move
      usb: gadget: f_rndis: Fix net_device lifecycle with device_move

Kuniyuki Iwashima (1):
      bpf: sockmap: Fix use-after-free of sk->sk_socket in sk_psock_verdict_data_ready().

Lee Jones (2):
      HID: logitech-hidpp: Prevent use-after-free on force feedback initialisation failure
      HID: multitouch: Check to ensure report responses match the request

Li Chen (1):
      ext4: publish jinode after initialization

Li Xiasong (1):
      MPTCP: fix lock class name family in pm_nl_create_listen_socket

Liam Mitchell (1):
      Input: bcm5974 - recover from failed mode switch

Lorenzo Bianconi (1):
      net: airoha: Add missing cleanup bits in airoha_qdma_cleanup_rx_queue()

Luka Gejak (1):
      net: hsr: fix VLAN add unwind on slave errors

Maarten Lankhorst (1):
      Revert "drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug"

Maciej W. Rozycki (2):
      MIPS: SiByte: Bring back cache initialisation
      MIPS: Fix the GCC version check for `__multi3' workaround

Marek Behún (1):
      net: sfp: Fix Ubiquiti U-Fiber Instant SFP module on mvneta

Mario Limonciello (1):
      x86/CPU/AMD: Add additional fixed RDSEED microcode revisions

Martin Schiller (2):
      net/x25: Fix potential double free of skb
      net/x25: Fix overflow when accumulating packets

Miao Li (1):
      usb: quirks: add DELAY_INIT quirk for another Silicon Motion flash drive

Michael Zimmermann (1):
      usb: gadget: f_hid: move list and spinlock inits from bind to alloc

Mikko Perttunen (1):
      i2c: tegra: Don't mark devices with pins as IRQ safe

Nathan Rebello (1):
      usb: typec: ucsi: validate connector number in ucsi_notify_common()

Nikunj A Dadhania (1):
      x86/fred: Fix early boot failures on SEV-ES/SNP guests

Norbert Szetei (1):
      crypto: af-alg - fix NULL pointer dereference in scatterwalk

Oleh Konko (2):
      Bluetooth: SMP: derive legacy responder STK authentication from MITM state
      Bluetooth: SMP: force responder MITM requirements before building the pairing response

Oliver Neukum (1):
      cdc-acm: new quirk for EPSON HMD

Pablo Neira Ayuso (7):
      netfilter: flowtable: strictly check for maximum number of actions
      netfilter: nf_conntrack_expect: honor expectation helper field
      netfilter: nf_conntrack_expect: use expect->helper
      netfilter: nf_conntrack_expect: store netns and zone in expectation
      netfilter: ctnetlink: ignore explicit helper on new expectations
      netfilter: x_tables: restrict xt_check_match/xt_check_target extensions for NFPROTO_ARP
      netfilter: nf_tables: reject immediate NF_QUEUE verdict

Paolo Abeni (2):
      ipv6: prevent possible UaF in addrconf_permanent_addr()
      net: introduce mangleid_features

Paul Chaignon (4):
      bpf: Improve bounds when s64 crosses sign boundary
      selftests/bpf: Test cross-sign 64bits range refinement
      selftests/bpf: Test invariants on JSLT crossing sign
      bpf: Add third round of bounds deduction

Paul SAGE (1):
      tg3: replace placeholder MAC address with device property

Paul Walmsley (1):
      riscv: kgdb: fix several debug register assignment bugs

Pauli Virtanen (3):
      Bluetooth: hci_sync: call destroy in hci_cmd_sync_run if immediate
      Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync
      Bluetooth: hci_event: fix potential UAF in hci_le_remote_conn_param_req_evt

Pavan Chebbi (1):
      bnxt_en: Restore default stat ctxs for ULP when resource is available

Pavel Begunkov (7):
      io_uring/kbuf: remove legacy kbuf bulk allocation
      io_uring/kbuf: remove legacy kbuf kmem cache
      io_uring/kbuf: simplify __io_put_kbuf
      io_uring/kbuf: remove legacy kbuf caching
      io_uring/kbuf: open code __io_put_kbuf()
      io_uring/kbuf: introduce io_kbuf_drop_legacy()
      io_uring/kbuf: uninline __io_put_kbufs

Pengpeng Hou (2):
      net/ipv6: ioam6: prevent schema length wraparound in trace fill
      NFC: pn533: bound the UART receive buffer

Pepper Gray (1):
      arm64/scs: Fix handling of advance_loc4

Peter Zijlstra (1):
      sched/fair: Fix zero_vruntime tracking fix

Praveen Talari (1):
      spi: geni-qcom: Check DMA interrupts early in ISR

Prike Liang (1):
      drm/amdgpu: fix the idr allocation flags

Qi Tang (3):
      netfilter: nf_conntrack_helper: pass helper to expect cleanup
      netfilter: ctnetlink: zero expect NAT fields when CTA_EXPECT_NAT absent
      bpf: reject direct access to nullable PTR_TO_BUF pointers

Qu Wenruo (1):
      btrfs: fix the qgroup data free range for inline data extents

Rafael J. Wysocki (1):
      thermal: core: Fix thermal zone device registration error path

Reshma Immaculate Rajkumar (1):
      wifi: ath11k: Pass the correct value of each TID during a stop AMPDU session

Saeed Mahameed (2):
      net/mlx5: Avoid "No data available" when FW version queries fail
      net/mlx5: Fix switchdev mode rollback in case of failure

Sanman Pradhan (5):
      hwmon: (pxe1610) Check return value of page-select write in probe
      hwmon: (ltc4286) Add missing MODULE_IMPORT_NS("PMBUS")
      hwmon: (tps53679) Fix device ID comparison and printing in tps53676_identify()
      hwmon: (occ) Fix missing newline in occ_show_extended()
      hwmon: (occ) Fix division by zero in occ_show_power_1()

Sasha Levin (3):
      Revert "LoongArch: Handle percpu handler address for ORC unwinder"
      Revert "LoongArch: Remove unnecessary checks for ORC unwinder"
      Revert "LoongArch/orc: Use RCU in all users of __module_address()."

Sebastian Urban (1):
      usb: gadget: dummy_hcd: fix premature URB completion when ZLP follows partial transfer

Shay Drory (1):
      net/mlx5: lag: Check for LAG device before creating debugfs

Shengyu Qu (1):
      Input: xpad - add support for BETOP BTP-KP50B/C controller's wireless mode

Shenwei Wang (1):
      gpio: mxc: map Both Edge pad wakeup to Rising Edge

Shiji Yang (1):
      mips: ralink: update CPU clock index

Stefan Wiehler (1):
      mips: mm: Allocate tlb_vpn array atomically

Suraj Gupta (1):
      net: xilinx: axienet: Correct BD length masks to match AXIDMA IP spec

Sven Eckelmann (Plasma Cloud) (1):
      net: ethernet: mtk_ppe: avoid NULL deref when gmac0 is disabled

Taegu Ha (1):
      usb: gadget: f_uac1_legacy: validate control request size

Takashi Iwai (1):
      ALSA: ctxfi: Fix missing SPDIFI1 index handling

Thomas Bogendoerfer (1):
      tg3: Fix race for querying speed/duplex

Thomas Richter (1):
      s390/cpum_sf: Cap sampling rate to prevent lsctl exception

Thomas Zimmermann (1):
      drm/ast: dp501: Fix initialization of SCU2C

Timur Kristóf (6):
      drm/amd/display: Disable fastboot on DCE 6 too
      drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4
      drm/amd/display: Fix DCE 6.0 and 6.4 PLL programming.
      drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
      drm/amd/display: Disable scaling on DCE6 for now
      drm/amd: Disable ASPM on SI

Valek Andrej (1):
      iio: accel: fix ADXL355 temperature signature value

Ville Syrjälä (2):
      drm/i915/dsi: Don't do DSC horizontal timing adjustments in command mode
      drm/i915/dp: Use crtc_state->enhanced_framing properly on ivb/hsw CPU eDP

Vincent Guittot (1):
      sched/fair: Use protect_slice() instead of direct comparison

Wanquan Zhong (1):
      USB: serial: option: add support for Rolling Wireless RW135R-GL

Wei Fang (1):
      net: enetc: check whether the RSS algorithm is Toeplitz

Weiming Shi (1):
      rds: ib: reject FRMR registration before IB connection is established

Willem de Bruijn (1):
      net: correctly handle tunneled traffic on IPV6_CSUM GSO fallback

Xiang Mei (3):
      net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
      net/sched: cls_fw: fix NULL pointer dereference on shared blocks
      net/sched: cls_flow: fix NULL pointer dereference on shared blocks

Xingjing Deng (1):
      misc: fastrpc: possible double-free of cctx->remote_heap

Xu Yang (1):
      dt-bindings: connector: add pd-disable dependency

Yang Wang (1):
      drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid for smu v13

Yang Yang (3):
      bridge: br_nd_send: linearize skb before parsing ND options
      bridge: br_nd_send: validate ND option lengths
      vxlan: validate ND option lengths in vxlan_na_create

Yasuaki Torimaru (1):
      wifi: wilc1000: fix u8 overflow in SSID scan buffer size calculation

Yifan Wu (1):
      netfilter: ipset: drop logically empty buckets in mtype_del

Yochai Eisenrich (2):
      net: ipv6: ndisc: fix ndisc_ra_useropt to initialize nduseropt_padX fields to zero to prevent an info-leak
      net: sched: cls_api: fix tc_chain_fill_node to initialize tcm_info to zero to prevent an info-leak

Yongchao Wu (2):
      usb: cdns3: gadget: fix NULL pointer dereference in ep_queue
      usb: cdns3: gadget: fix state inconsistency on gadget init failure

Youssef Samir (1):
      accel/qaic: Handle DBC deactivation if the owner went away

Yucheng Lu (1):
      net/sched: sch_netem: fix out-of-bounds access in packet corruption

Yufan Chen (1):
      net: ftgmac100: fix ring allocation unwind on open failure

ZhengYuan Huang (1):
      btrfs: reject root items with drop_progress and zero drop_level

Zhengchuan Liang (1):
      net: ipv6: flowlabel: defer exclusive option free until RCU teardown

Zilin Guan (1):
      ice: Fix memory leak in ice_set_ringparam()

Zoltan Illes (1):
      Input: xpad - add support for Razer Wolverine V3 Pro

hkbinbin (1):
      Bluetooth: hci_sync: fix stack buffer overflow in hci_le_big_create_sync



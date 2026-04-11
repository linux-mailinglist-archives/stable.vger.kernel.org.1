Return-Path: <stable+bounces-235718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jRq7Dz1E2mkrzggAu9opvQ
	(envelope-from <stable+bounces-235718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 14:53:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2E43DFFC1
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 14:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29938300B29E
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275EA1F03D7;
	Sat, 11 Apr 2026 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rOnCgPnZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543813A3F7;
	Sat, 11 Apr 2026 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775911990; cv=none; b=i1Ior8XmwG3VvN4g+mU228crZb+5w+UlR1xIE/DQKHffAopCjSWd+liyOJ9y6DY+gNajRejZdyIUy1Do5o0Rug2rbQ0FnPlvuWR6lI6eEwaU+cPATvDk0Jn/mE8DnmkOoWRef4qlE5zbo1PZxV8qVxTxzkVGU7NeepqqJWjGSWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775911990; c=relaxed/simple;
	bh=OndQUo8HQjMWnP9Sq3tV85MZbfDrD/TC6Ro6LDg17/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EjsvGn1OMDRovm25GATap2iAS9KppDV1Th3aO3snw3jb7HP65e+2GFxAHJleRbjnS2QA16bvdL1MDYl8b/xHDRhHdVdV15wR0ClhwY72HExXcNk3Cc0WgnyyH4ec8SPVzfUNYly+Tnh/Mj8s1f+uNZXLCgkEe+F44L0+Q/rcevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rOnCgPnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AA3C4CEF7;
	Sat, 11 Apr 2026 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775911990;
	bh=OndQUo8HQjMWnP9Sq3tV85MZbfDrD/TC6Ro6LDg17/8=;
	h=From:To:Cc:Subject:Date:From;
	b=rOnCgPnZMxWBpm/AE7jpU6Twr+49jMQ0Ei2AFaeNIcGUtUizLNDXRP0f9roaM551U
	 unBtbv6Uya9eBhjOzd3wR4NT61sGXmlXdASR2IJhuBp+oVxmNEc/bu4gIJb4webvzo
	 5wDcOzAKAt7DT4+7gVJfUixumQSLgLZzQveh8RVY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.168
Date: Sat, 11 Apr 2026 14:53:06 +0200
Message-ID: <2026041107-uncurled-bonded-bb11@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235718-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF2E43DFFC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.1.168 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                  |    3 
 Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml |    2 
 Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml  |    4 
 Documentation/hwmon/adm1177.rst                                  |    8 
 Documentation/hwmon/peci-cputemp.rst                             |   10 
 Makefile                                                         |    2 
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts        |   13 
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi              |   22 
 arch/arm64/kvm/reset.c                                           |   14 
 arch/loongarch/pci/pci.c                                         |   80 ++
 arch/mips/lib/multi3.c                                           |    6 
 arch/mips/mm/tlb-r4k.c                                           |    2 
 arch/powerpc/net/bpf_jit_comp64.c                                |   23 
 arch/riscv/kernel/kgdb.c                                         |    7 
 arch/s390/include/asm/barrier.h                                  |    4 
 arch/s390/kernel/syscall.c                                       |    2 
 arch/sh/drivers/platform_early.c                                 |    4 
 arch/x86/kernel/cpu/common.c                                     |   18 
 arch/x86/kvm/mmu/mmu.c                                           |   15 
 arch/x86/platform/efi/quirks.c                                   |    2 
 block/blk-mq.c                                                   |    9 
 block/blk-sysfs.c                                                |    2 
 block/bsg-lib.c                                                  |    2 
 crypto/af_alg.c                                                  |    4 
 drivers/acpi/acpica/acevents.h                                   |    4 
 drivers/acpi/acpica/evregion.c                                   |    6 
 drivers/acpi/acpica/evxfregn.c                                   |  146 ++++
 drivers/acpi/ec.c                                                |   52 +
 drivers/base/regmap/regmap.c                                     |   30 
 drivers/bluetooth/btusb.c                                        |    5 
 drivers/bluetooth/hci_ll.c                                       |    2 
 drivers/comedi/drivers.c                                         |    8 
 drivers/comedi/drivers/dt2815.c                                  |   12 
 drivers/comedi/drivers/me4000.c                                  |   16 
 drivers/comedi/drivers/me_daq.c                                  |   35 -
 drivers/comedi/drivers/ni_atmio16d.c                             |    3 
 drivers/cpufreq/cpufreq_conservative.c                           |   12 
 drivers/cpufreq/cpufreq_governor.c                               |   13 
 drivers/cpufreq/cpufreq_governor.h                               |    1 
 drivers/dma/idxd/cdev.c                                          |   10 
 drivers/dma/idxd/device.c                                        |    3 
 drivers/dma/idxd/sysfs.c                                         |    1 
 drivers/dma/sh/rz-dmac.c                                         |   66 +-
 drivers/dma/xilinx/xilinx_dma.c                                  |   66 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                       |    4 
 drivers/gpu/drm/ast/ast_dp501.c                                  |    2 
 drivers/gpu/drm/drm_ioc32.c                                      |    2 
 drivers/gpu/drm/i915/display/intel_gmbus.c                       |    4 
 drivers/hid/hid-apple.c                                          |    4 
 drivers/hid/hid-asus.c                                           |   15 
 drivers/hid/hid-magicmouse.c                                     |    6 
 drivers/hid/hid-mcp2221.c                                        |    2 
 drivers/hid/hid-multitouch.c                                     |    7 
 drivers/hid/wacom_wac.c                                          |   10 
 drivers/hwmon/adm1177.c                                          |   54 -
 drivers/hwmon/occ/common.c                                       |   19 
 drivers/hwmon/peci/cputemp.c                                     |    4 
 drivers/hwmon/pmbus/isl68137.c                                   |   21 
 drivers/hwmon/pmbus/pmbus.h                                      |    2 
 drivers/hwmon/pmbus/pmbus_core.c                                 |   30 
 drivers/hwmon/pmbus/pxe1610.c                                    |    5 
 drivers/hwmon/pmbus/tps53679.c                                   |    4 
 drivers/i2c/busses/Kconfig                                       |    2 
 drivers/i2c/busses/i2c-tegra.c                                   |    5 
 drivers/iio/accel/adxl355_core.c                                 |    2 
 drivers/iio/adc/ti-adc161s626.c                                  |   41 -
 drivers/iio/dac/ad5770r.c                                        |    2 
 drivers/iio/gyro/mpu3050-core.c                                  |   32 -
 drivers/iio/imu/bmi160/bmi160_core.c                             |   15 
 drivers/iio/imu/bno055/bno055.c                                  |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c                   |    4 
 drivers/iio/light/vcnl4035.c                                     |   18 
 drivers/infiniband/core/rw.c                                     |   21 
 drivers/infiniband/hw/irdma/cm.c                                 |   29 
 drivers/infiniband/hw/irdma/utils.c                              |    2 
 drivers/infiniband/hw/irdma/verbs.c                              |    9 
 drivers/input/joystick/xpad.c                                    |    2 
 drivers/input/rmi4/rmi_f54.c                                     |    4 
 drivers/input/serio/i8042-acpipnpio.h                            |    7 
 drivers/irqchip/irq-qcom-mpm.c                                   |    3 
 drivers/media/mc/mc-request.c                                    |    5 
 drivers/media/v4l2-core/v4l2-ioctl.c                             |    5 
 drivers/mtd/spi-nor/core.c                                       |  145 ++++
 drivers/net/can/vxcan.c                                          |    2 
 drivers/net/ethernet/broadcom/tg3.c                              |   13 
 drivers/net/ethernet/cadence/macb_main.c                         |   17 
 drivers/net/ethernet/cadence/macb_pci.c                          |   10 
 drivers/net/ethernet/faraday/ftgmac100.c                         |   28 
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c             |    2 
 drivers/net/ethernet/freescale/enetc/enetc_pf.c                  |    2 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                     |   14 
 drivers/net/ethernet/intel/ice/ice_repr.c                        |    3 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c                |    4 
 drivers/net/ethernet/mellanox/mlx5/core/fw.c                     |   53 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c            |    3 
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h              |    4 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                  |   17 
 drivers/net/ethernet/xilinx/xilinx_axienet.h                     |    4 
 drivers/net/geneve.c                                             |    2 
 drivers/net/phy/phy_device.c                                     |   58 +
 drivers/net/usb/r8152.c                                          |    1 
 drivers/net/veth.c                                               |    2 
 drivers/net/virtio_net.c                                         |    1 
 drivers/net/vxlan/vxlan_core.c                                   |   10 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                      |    2 
 drivers/net/wireless/microchip/wilc1000/hif.c                    |    2 
 drivers/net/wireless/virt_wifi.c                                 |    1 
 drivers/net/wwan/wwan_core.c                                     |    2 
 drivers/nfc/pn533/uart.c                                         |    3 
 drivers/nvme/host/apple.c                                        |    1 
 drivers/nvme/host/core.c                                         |   16 
 drivers/nvme/host/fabrics.c                                      |    4 
 drivers/nvme/host/pci.c                                          |   25 
 drivers/phy/ti/phy-j721e-wiz.c                                   |    2 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c                    |    9 
 drivers/platform/olpc/olpc-xo175-ec.c                            |    2 
 drivers/platform/x86/intel/hid.c                                 |   13 
 drivers/platform/x86/touchscreen_dmi.c                           |   18 
 drivers/scsi/ibmvscsi/ibmvfc.c                                   |    3 
 drivers/scsi/scsi_sysfs.c                                        |    1 
 drivers/scsi/scsi_transport_sas.c                                |    2 
 drivers/scsi/ses.c                                               |    2 
 drivers/spi/spi-fsl-lpspi.c                                      |    3 
 drivers/target/loopback/tcm_loop.c                               |   52 +
 drivers/thunderbolt/nhi.c                                        |    2 
 drivers/ufs/core/ufshcd.c                                        |    2 
 drivers/usb/cdns3/cdns3-gadget.c                                 |    4 
 drivers/usb/class/cdc-acm.c                                      |    9 
 drivers/usb/class/cdc-acm.h                                      |    1 
 drivers/usb/class/usbtmc.c                                       |    3 
 drivers/usb/common/ulpi.c                                        |    5 
 drivers/usb/core/config.c                                        |    6 
 drivers/usb/core/quirks.c                                        |    8 
 drivers/usb/dwc2/gadget.c                                        |    2 
 drivers/usb/gadget/function/f_rndis.c                            |    9 
 drivers/usb/gadget/function/f_subset.c                           |    6 
 drivers/usb/gadget/function/f_uac1_legacy.c                      |   47 +
 drivers/usb/gadget/function/f_uvc.c                              |   39 +
 drivers/usb/gadget/function/uvc.h                                |    3 
 drivers/usb/gadget/function/uvc_v4l2.c                           |    5 
 drivers/usb/gadget/udc/dummy_hcd.c                               |   42 -
 drivers/usb/host/ehci-brcm.c                                     |    4 
 drivers/usb/serial/io_edgeport.c                                 |    3 
 drivers/usb/serial/io_usbvend.h                                  |    1 
 drivers/usb/serial/option.c                                      |    4 
 fs/btrfs/block-group.c                                           |    2 
 fs/btrfs/disk-io.c                                               |    4 
 fs/btrfs/inode.c                                                 |    6 
 fs/btrfs/ioctl.c                                                 |    7 
 fs/btrfs/tree-checker.c                                          |   17 
 fs/btrfs/volumes.c                                               |    5 
 fs/btrfs/zoned.c                                                 |    6 
 fs/erofs/data.c                                                  |    2 
 fs/erofs/zdata.c                                                 |   70 +-
 fs/ext4/crypto.c                                                 |    9 
 fs/ext4/ext4.h                                                   |   10 
 fs/ext4/extents.c                                                |  312 ++++------
 fs/ext4/extents_status.c                                         |   12 
 fs/ext4/extents_status.h                                         |    4 
 fs/ext4/fast_commit.c                                            |   25 
 fs/ext4/ialloc.c                                                 |    6 
 fs/ext4/inline.c                                                 |   12 
 fs/ext4/inode.c                                                  |   35 -
 fs/ext4/mballoc.c                                                |   30 
 fs/ext4/migrate.c                                                |    5 
 fs/ext4/move_extent.c                                            |    7 
 fs/ext4/super.c                                                  |  164 ++---
 fs/ext4/sysfs.c                                                  |   10 
 fs/gfs2/lock_dlm.c                                               |   10 
 fs/jbd2/checkpoint.c                                             |   15 
 fs/smb/server/smb2pdu.c                                          |   72 +-
 fs/xfs/xfs_attr_item.c                                           |    4 
 fs/xfs/xfs_dquot_item.c                                          |    9 
 fs/xfs/xfs_inode_item.c                                          |    9 
 fs/xfs/xfs_mount.c                                               |    7 
 fs/xfs/xfs_trace.c                                               |    1 
 fs/xfs/xfs_trace.h                                               |   36 +
 fs/xfs/xfs_trans_ail.c                                           |   26 
 include/acpi/acpixf.h                                            |  134 ++--
 include/linux/dma-mapping.h                                      |    4 
 include/linux/netdevice.h                                        |    2 
 include/linux/netfilter/ipset/ip_set.h                           |    2 
 include/linux/rtnetlink.h                                        |    9 
 include/linux/swapops.h                                          |   20 
 include/linux/usb/quirks.h                                       |    3 
 include/linux/usb/r8152.h                                        |    1 
 include/net/inet_hashtables.h                                    |   14 
 include/net/netfilter/nf_conntrack_expect.h                      |   38 -
 include/net/netlink.h                                            |   21 
 include/net/rtnetlink.h                                          |    5 
 include/uapi/linux/dma-buf.h                                     |    1 
 include/uapi/linux/netfilter/nf_conntrack_common.h               |    4 
 kernel/bpf/btf.c                                                 |   24 
 kernel/bpf/verifier.c                                            |   10 
 kernel/dma/swiotlb.c                                             |   21 
 kernel/futex/pi.c                                                |    3 
 kernel/module/main.c                                             |    7 
 kernel/sysctl.c                                                  |    2 
 kernel/time/alarmtimer.c                                         |    2 
 kernel/trace/trace_osnoise.c                                     |    8 
 lib/nlattr.c                                                     |    6 
 mm/damon/sysfs.c                                                 |    3 
 net/atm/lec.c                                                    |   72 +-
 net/atm/lec.h                                                    |    2 
 net/bluetooth/eir.c                                              |    7 
 net/bluetooth/eir.h                                              |    2 
 net/bluetooth/hci_event.c                                        |   33 -
 net/bluetooth/hci_sync.c                                         |    5 
 net/bluetooth/l2cap_core.c                                       |   28 
 net/bluetooth/l2cap_sock.c                                       |    3 
 net/bluetooth/mgmt.c                                             |   17 
 net/bluetooth/sco.c                                              |   36 -
 net/bluetooth/smp.c                                              |   11 
 net/bridge/br_arp_nd_proxy.c                                     |   18 
 net/can/af_can.c                                                 |    4 
 net/can/af_can.h                                                 |    2 
 net/can/gw.c                                                     |    6 
 net/can/proc.c                                                   |    3 
 net/core/dev.c                                                   |   70 +-
 net/core/dev.h                                                   |    7 
 net/core/rtnetlink.c                                             |   51 -
 net/hsr/hsr_device.c                                             |   32 -
 net/ipv4/esp4.c                                                  |   11 
 net/ipv4/inet_connection_sock.c                                  |   68 --
 net/ipv4/inet_hashtables.c                                       |    3 
 net/ipv4/ip_gre.c                                                |    2 
 net/ipv4/udp.c                                                   |    2 
 net/ipv6/addrconf.c                                              |    6 
 net/ipv6/datagram.c                                              |   10 
 net/ipv6/esp6.c                                                  |   11 
 net/ipv6/icmp.c                                                  |    3 
 net/ipv6/ioam6.c                                                 |    4 
 net/ipv6/ip6_flowlabel.c                                         |    5 
 net/ipv6/ip6_tunnel.c                                            |    5 
 net/ipv6/ndisc.c                                                 |    3 
 net/ipv6/netfilter/ip6t_rt.c                                     |    4 
 net/ipv6/xfrm6_output.c                                          |    4 
 net/key/af_key.c                                                 |   19 
 net/mptcp/pm_netlink.c                                           |    2 
 net/netfilter/ipset/ip_set_core.c                                |    4 
 net/netfilter/ipset/ip_set_hash_gen.h                            |    2 
 net/netfilter/ipset/ip_set_list_set.c                            |    4 
 net/netfilter/nf_conntrack_broadcast.c                           |    8 
 net/netfilter/nf_conntrack_expect.c                              |   29 
 net/netfilter/nf_conntrack_h323_main.c                           |   12 
 net/netfilter/nf_conntrack_helper.c                              |   13 
 net/netfilter/nf_conntrack_netlink.c                             |  103 +--
 net/netfilter/nf_conntrack_proto_tcp.c                           |   10 
 net/netfilter/nf_conntrack_sip.c                                 |   18 
 net/netfilter/nf_flow_table_offload.c                            |  196 ++++--
 net/netfilter/nf_tables_api.c                                    |    7 
 net/netfilter/nfnetlink_log.c                                    |   10 
 net/netfilter/x_tables.c                                         |   23 
 net/netfilter/xt_cgroup.c                                        |    6 
 net/netfilter/xt_rateest.c                                       |    5 
 net/nfc/nci/core.c                                               |   10 
 net/openvswitch/flow_netlink.c                                   |    2 
 net/openvswitch/vport-geneve.c                                   |    2 
 net/openvswitch/vport-gre.c                                      |    2 
 net/openvswitch/vport-netdev.c                                   |   13 
 net/openvswitch/vport-vxlan.c                                    |    2 
 net/packet/af_packet.c                                           |    1 
 net/qrtr/af_qrtr.c                                               |   31 
 net/rds/ib_rdma.c                                                |    7 
 net/sched/cls_api.c                                              |    1 
 net/sched/cls_flow.c                                             |   10 
 net/sched/cls_fw.c                                               |   14 
 net/sched/sch_hfsc.c                                             |    4 
 net/smc/smc_rx.c                                                 |    9 
 net/tls/tls_sw.c                                                 |    2 
 net/x25/x25_in.c                                                 |    9 
 net/x25/x25_subr.c                                               |    1 
 net/xfrm/xfrm_interface_core.c                                   |    2 
 net/xfrm/xfrm_output.c                                           |    7 
 net/xfrm/xfrm_policy.c                                           |    2 
 net/xfrm/xfrm_state.c                                            |    1 
 sound/pci/ctxfi/ctdaio.c                                         |    1 
 sound/pci/hda/patch_realtek.c                                    |    2 
 sound/soc/cirrus/ep93xx-i2s.c                                    |   40 +
 sound/soc/codecs/adau1372.c                                      |   34 -
 sound/soc/fsl/fsl_easrc.c                                        |   14 
 sound/soc/intel/catpt/device.c                                   |   10 
 sound/soc/intel/catpt/dsp.c                                      |    3 
 sound/usb/caiaq/device.c                                         |    2 
 tools/objtool/check.c                                            |    5 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                  |   14 
 286 files changed, 3057 insertions(+), 1431 deletions(-)

Alan Stern (2):
      USB: dummy-hcd: Fix locking/synchronization error
      USB: dummy-hcd: Fix interrupt synchronization error

Alexander Popov (1):
      wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free

Alexander Sverdlin (1):
      ASoC: ep93xx: i2s: move enable call to startup callback

Alexei Starovoitov (1):
      bpf: Fix regsafe() for pointers to packet

Alexey Velichayshiy (1):
      wifi: iwlwifi: mvm: fix potential out-of-bounds read in iwl_mvm_nd_match_info_handler()

Ali Norouzi (1):
      can: gw: fix OOB heap access in cgw_csum_crc8_rel()

Alok Tiwari (1):
      platform/olpc: olpc-xo175-ec: Fix overflow error message to print inlen

Anas Iqbal (1):
      Bluetooth: hci_ll: Fix firmware leak on error path

Andreas Gruenbacher (1):
      gfs2: Fix unlikely race in gdlm_put_lock

Andy Shevchenko (1):
      regmap: Synchronize cache for the page selector

Anil Samal (1):
      RDMA/irdma: Fix deadlock during netdev reset with active connections

Antoniu Miclaus (1):
      iio: dac: ad5770r: fix error return in ad5770r_read_raw()

Baokun Li (1):
      ext4: fix iloc.bh leak in ext4_fc_replay_inode() error paths

Bart Van Assche (2):
      Input: synaptics-rmi4 - fix a locking bug in an error path
      block: Fix the blk_mq_destroy_queue() documentation

Benoît Sevens (1):
      HID: wacom: fix out-of-bounds read in wacom_intuos_bt_irq

Berk Cem Goksel (1):
      ALSA: caiaq: fix stack out-of-bounds read in init_card

Boris Burkov (1):
      btrfs: set BTRFS_ROOT_ORPHAN_CLEANUP during subvol create

Cen Zhang (1):
      Bluetooth: SCO: fix race conditions in sco_sock_connect()

Cezary Rojewski (1):
      ASoC: Intel: catpt: Fix the device initialization

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Max 16 Gen10 AMD to i8042 quirk table

Christoph Hellwig (3):
      blk-mq: move the call to blk_put_queue out of blk_mq_destroy_queue
      nvme-pci: remove an extra queue reference
      nvme-pci: put the admin queue in nvme_dev_remove_admin

Christophe JAILLET (2):
      dmaengine: idxd: Remove usage of the deprecated ida_simple_xx() API
      netfilter: Reorder fields in 'struct nf_conntrack_expect'

Chuck Lever (2):
      tls: Purge async_hold in tls_decrypt_async_wait()
      RDMA/rw: Fall back to direct SGE on MR pool exhaustion

Claudiu Beznea (2):
      dmaengine: sh: rz-dmac: Protect the driver specific lists
      dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock

Daniel Hodges (1):
      nvme-fabrics: use kfree_sensitive() for DHCHAP secrets

Danilo Krummrich (1):
      sh: platform_early: remove pdev->driver_override check

David Carlier (1):
      netfilter: ctnetlink: use netlink policy range checks

David Lechner (4):
      iio: imu: bno055: fix BNO055_SCAN_CH_COUNT off by one
      iio: adc: ti-adc161s626: fix buffer read on big-endian
      iio: adc: ti-adc161s626: use DMA-safe memory for spi_read()
      iio: light: vcnl4035: fix scan buffer on big-endian

Davidlohr Bueso (1):
      futex: Clear stale exiting pointer in futex_lock_pi() retry path

Deepanshu Kartikey (3):
      ext4: convert inline data to extents when truncate exceeds inline size
      atm: lec: fix use-after-free in sock_def_readable()
      comedi: dt2815: add hardware detection to prevent crash

Denis Arefev (1):
      erofs: Fix the slab-out-of-bounds in drop_buffers()

Eddie James (1):
      hwmon: (pmbus/core) Add lock and unlock functions

Edward Adam Davis (1):
      ext4: avoid infinite loops caused by residual data

Eric Dumazet (5):
      af_key: validate families in pfkey_send_migrate()
      tcp: optimize inet_use_bhash2_on_bind()
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

Felix Gu (1):
      phy: ti: j721e-wiz: Fix device node reference leak in wiz_get_lane_phy_types()

Filipe Manana (2):
      btrfs: fix lost error when running device stats on multiple devices fs
      btrfs: do not free data reservation in fallback from inline due to -ENOSPC

Florian Westphal (4):
      netlink: allow be16 and be32 types in all uint policy checks
      netfilter: nfnetlink_log: account for netlink header size
      netfilter: x_tables: ensure names are nul-terminated
      netfilter: ipset: use nla_strcmp for IPSET_ATTR_NAME attr

Francesco Lavra (1):
      iio: imu: st_lsm6dsx: Set FIFO ODR for accelerometer and gyroscope only

Frank Li (1):
      dt-bindings: auxdisplay: ht16k33: Use unevaluatedProperties to fix common property warning

Frej Drejhammar (1):
      USB: serial: io_edgeport: add support for Blackbox IC135A

Gao Xiang (2):
      erofs: handle overlapped pclusters out of crafted images properly
      erofs: fix PSI memstall accounting

Greg Kroah-Hartman (4):
      s390/syscalls: Add spectre boundary for syscall dispatch table
      scsi: ses: Handle positive SCSI error from ses_recv_diag()
      drm/ioc32: stop speculation on the drm_compat_ioctl path
      Linux 6.1.168

Guangshuo Li (2):
      usb: ulpi: fix double free in ulpi_register_interface() error path
      cpufreq: governor: fix double free in cpufreq_dbs_governor_init() error path

Günther Noack (3):
      HID: asus: avoid memory leak in asus_report_fixup()
      HID: magicmouse: avoid memory leak in magicmouse_report_fixup()
      HID: apple: avoid memory leak in apple_report_fixup()

Hangbin Liu (3):
      rtnetlink: pass netlink message header and portid to rtnl_configure_link()
      net: add new helper unregister_netdevice_many_notify
      rtnetlink: Honour NLM_F_ECHO flag in rtnl_delete_link

Hans de Goede (5):
      platform/x86: touchscreen_dmi: Add quirk for y-inverted Goodix touchscreen on SUPI S10
      ACPICA: include/acpi/acpixf.h: Fix indentation
      ACPICA: Allow address_space_handler Install and _REG execution as 2 separate steps
      ACPI: EC: Fix EC address space handler unregistration
      ACPI: EC: Fix ECDT probe ordering issues

Hari Bathini (1):
      powerpc64/bpf: do not increment tailcall count when prog is NULL

Heitor Alves de Siqueira (1):
      usb: usbtmc: Flush anchored URBs in usbtmc_release

Helen Koike (2):
      Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb
      ext4: reject mount if bigalloc with s_first_data_block != 0

Heyne, Maximilian (1):
      Revert "nvme: fix admin request_queue lifetime"

Huacai Chen (1):
      LoongArch: Workaround LS2K/LS7A GPU DMA hang bug

Hyunwoo Kim (4):
      Bluetooth: L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
      Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
      Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop
      ksmbd: do not expire session on binding failure

Ian Abbott (4):
      comedi: Reinit dev->spinlock between attachments to low-level drivers
      comedi: ni_atmio16d: Fix invalid clean-up after failed attach
      comedi: me_daq: Fix potential overrun of firmware buffer
      comedi: me4000: Fix potential overrun of firmware buffer

Ihor Solodrai (1):
      module: Fix kernel panic when a symbol st_shndx is out of bounds

Isaac J. Manjarres (1):
      dma-buf: Include ioctl.h in UAPI header

Ivan Barrera (1):
      RDMA/irdma: Clean up unnecessary dereference of event->cm_node

JP Hein (1):
      USB: core: add NO_LPM quirk for Razer Kiyo Pro webcam

Jacob Moroni (1):
      RDMA/irdma: Initialize free_qp completion before using it

Jakub Kicinski (1):
      nfc: nci: fix circular locking dependency in nci_close_device

Jamie Gibbons (1):
      dt-bindings: gpio: fix microchip #interrupt-cells

Jan Kara (1):
      ext4: make recently_deleted() properly work with lazy itable initialization

Jason Yan (3):
      ext4: factor out ext4_percpu_param_init() and ext4_percpu_param_destroy()
      ext4: use ext4_group_desc_free() in ext4_put_super() to save some duplicated code
      ext4: factor out ext4_flex_groups_free()

Jassi Brar (1):
      irqchip/qcom-mpm: Add missing mailbox TX done acknowledgment

Jiayuan Chen (2):
      net: qrtr: replace qrtr_tx_flow radix_tree with xarray to fix memory leak
      ext4: fix use-after-free in update_super_work when racing with umount

Jie Deng (1):
      usb: core: new quirk to handle devices with zero configurations

Jihed Chaibi (3):
      ASoC: adau1372: Fix unchecked clk_prepare_enable() return value
      ASoC: adau1372: Fix clock leak on PLL lock failure
      ASoC: ep93xx: Fix unchecked clk_prepare_enable() and add rollback on failure

Jimmy Hu (1):
      usb: gadget: uvc: fix NULL pointer dereference during unbind race

Jinjiang Tu (1):
      mm/huge_memory: fix folio isn't locked in softleaf_to_folio()

Jiucheng Xu (1):
      erofs: add GFP_NOIO in the bio completion if needed

Johannes Thumshirn (1):
      btrfs: don't take device_list_mutex when querying zone info

Josef Bacik (1):
      scsi: target: tcm_loop: Drain commands in target_reset handler

Josh Law (1):
      mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]

Josh Poimboeuf (2):
      objtool: Fix Clang jump table detection
      iio: imu: bmi160: Remove potential undefined behavior in bmi160_config_pin()

Julius Lehmann (1):
      HID: magicmouse: fix battery reporting for Apple Magic Trackpad 2

Juno Choi (1):
      usb: dwc2: gadget: Fix spin_lock/unlock mismatch in dwc2_hsotg_udc_stop()

Justin Chen (1):
      usb: ehci-brcm: fix sleep during atomic

Keenan Dong (2):
      Bluetooth: MGMT: validate LTK enc_size on load
      Bluetooth: MGMT: validate mesh send advertising payload length

Keith Busch (3):
      nvme-pci: cap queue creation to used queues
      nvme-pci: ensure we're polling a polled queue
      nvme: fix admin request_queue lifetime

Kevin Hao (2):
      net: macb: Use dev_consume_skb_any() to free TX SKBs
      net: macb: Move devm_{free,request}_irq() out of spin lock area

Konrad Dybcio (1):
      thunderbolt: Fix property read in nhi_wake_supported()

Kuen-Han Tsai (2):
      usb: gadget: f_subset: Fix unbalanced refcnt in geth_free
      usb: gadget: f_rndis: Protect RNDIS options with mutex

Kumar Kartikeya Dwivedi (1):
      bpf: Release module BTF IDR before module unload

Kuniyuki Iwashima (3):
      tcp: Use bhash2 for v4-mapped-v6 non-wildcard address.
      tcp: Rearrange tests in inet_csk_bind_conflict().
      tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6 non-wildcard addresses.

Lee Jones (1):
      HID: multitouch: Check to ensure report responses match the request

Leif Skunberg (1):
      platform/x86: intel-hid: Enable 5-button array on ThinkPad X1 Fold 16 Gen 1

Li Chen (1):
      ext4: publish jinode after initialization

Li Xiasong (1):
      MPTCP: fix lock class name family in pm_nl_create_listen_socket

Liao Chang (1):
      cpufreq: governor: Free dbs_data directly when gov->init() fails

Liucheng Lu (1):
      ALSA: hda/realtek: add HP Laptop 14s-dr5xxx mute LED quirk

Long Li (1):
      xfs: fix ri_total validation in xlog_recover_attri_commit_pass2

Luca Leonardo Scorcia (1):
      pinctrl: mediatek: common: Fix probe failure for devices without EINT

Luiz Augusto von Dentz (1):
      Bluetooth: eir: Fix possible crashes on eir_create_adv_data

Luka Gejak (1):
      net: hsr: fix VLAN add unwind on slave errors

Luo Haiyang (1):
      tracing: Fix potential deadlock in cpu hotplug with osnoise

Maciej W. Rozycki (1):
      MIPS: Fix the GCC version check for `__multi3' workaround

Marc Buerg (1):
      sysctl: fix uninitialized variable in proc_do_large_bitmap

Marc Kleine-Budde (1):
      spi: spi-fsl-lpspi: fix teardown order issue (UAF)

Marc Zyngier (1):
      KVM: arm64: Discard PC update state on vcpu reset

Marek Vasut (3):
      dmaengine: xilinx: xilinx_dma: Fix dma_device directions
      dmaengine: xilinx: xilinx_dma: Fix residue calculation for cyclic DMA
      dmaengine: xilinx: xilinx_dma: Fix unmasked residue subtraction

Mark Brown (2):
      ASoC: fsl_easrc: Fix event generation in fsl_easrc_iec958_set_reg()
      ASoC: fsl_easrc: Fix event generation in fsl_easrc_iec958_put_bits()

Mark Harmstone (1):
      btrfs: fix super block offset in error message in btrfs_validate_super()

Markus Niebel (1):
      arm64: dts: imx8mn-tqma8mqnl: fix LDO5 power off

Martin KaFai Lau (1):
      udp: Fix wildcard bind conflict check when using hash2

Martin Schiller (2):
      net/x25: Fix potential double free of skb
      net/x25: Fix overflow when accumulating packets

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: join: implicit: stop transfer after last check
      selftests: mptcp: join: check removing signal+subflow endp

Miao Li (1):
      usb: quirks: add DELAY_INIT quirk for another Silicon Motion flash drive

Miguel Ojeda (1):
      dma-mapping: add missing `inline` for `dma_free_attrs`

Mike Rapoport (Microsoft) (1):
      x86/efi: efi_unmap_boot_services: fix calculation of ranges_to_free size

Mikko Perttunen (1):
      i2c: tegra: Don't mark devices with pins as IRQ safe

Milos Nikic (1):
      jbd2: gracefully abort on checkpointing state corruptions

Ming Lei (1):
      nvme: fix admin queue leak on controller reset

Mohammad Heib (1):
      ionic: fix persistent MAC address override on PF

Namjae Jeon (2):
      ksmbd: replace hardcoded hdr2_len with offsetof() in smb2_calc_max_out_buf_len()
      ksmbd: fix potencial OOB in get_file_all_info() for compound requests

Nathan Chancellor (1):
      ext4: fix unused iterator variable warnings

Nikunj A Dadhania (1):
      x86/cpu: Enable FSGSBASE early in cpu_init_exception_handling()

Norbert Szetei (1):
      crypto: af-alg - fix NULL pointer dereference in scatterwalk

Oleh Konko (2):
      Bluetooth: SMP: derive legacy responder STK authentication from MITM state
      Bluetooth: SMP: force responder MITM requirements before building the pairing response

Oliver Hartkopp (1):
      can: statistics: add missing atomic access in hot path

Oliver Neukum (1):
      cdc-acm: new quirk for EPSON HMD

Pablo Neira Ayuso (8):
      netfilter: nf_conntrack_expect: skip expectations in other netns via proc
      netfilter: flowtable: strictly check for maximum number of actions
      netfilter: nf_conntrack_expect: honor expectation helper field
      netfilter: nf_conntrack_expect: use expect->helper
      netfilter: nf_conntrack_expect: store netns and zone in expectation
      netfilter: ctnetlink: ignore explicit helper on new expectations
      netfilter: x_tables: restrict xt_check_match/xt_check_target extensions for NFPROTO_ARP
      netfilter: nf_tables: reject immediate NF_QUEUE verdict

Paolo Abeni (1):
      ipv6: prevent possible UaF in addrconf_permanent_addr()

Paolo Valerio (1):
      net: macb: use the current queue number for stats

Paul SAGE (1):
      tg3: replace placeholder MAC address with device property

Paul Walmsley (1):
      riscv: kgdb: fix several debug register assignment bugs

Pauli Virtanen (1):
      Bluetooth: hci_event: fix potential UAF in hci_le_remote_conn_param_req_evt

Pengpeng Hou (3):
      Bluetooth: btusb: clamp SCO altsetting table indices
      net/ipv6: ioam6: prevent schema length wraparound in trace fill
      NFC: pn533: bound the UART receive buffer

Peter Metz (1):
      platform/x86: intel-hid: Add Dell 14 Plus 2-in-1 to dmi_vgbs_allow_list

Petr Oros (1):
      ice: use ice_update_eth_stats() for representor stats

Pratyush Yadav (2):
      mtd: spi-nor: core: avoid odd length/address reads on 8D-8D-8D mode
      mtd: spi-nor: core: avoid odd length/address writes in 8D-8D-8D mode

Qi Tang (4):
      net/smc: fix double-free of smc_spd_priv when tee() duplicates splice pipe buffer
      netfilter: nf_conntrack_helper: pass helper to expect cleanup
      netfilter: ctnetlink: zero expect NAT fields when CTA_EXPECT_NAT absent
      bpf: reject direct access to nullable PTR_TO_BUF pointers

Qu Wenruo (1):
      btrfs: fix the qgroup data free range for inline data extents

Radhey Shyam Pandey (1):
      dmaengine: xilinx_dma: Program interrupt delay timeout

Rafael J. Wysocki (2):
      ACPI: EC: Install address space handler at the namespace root
      ACPI: EC: Evaluate orphan _REG under EC device

Ren Wei (1):
      netfilter: ip6t_rt: reject oversized addrnr in rt_mt6_check()

Romain Sioen (1):
      HID: mcp2221: cancel last I2C command on read error

Russell King (Oracle) (1):
      net: phy: fix phy_uses_state_machine()

Sabrina Dubroca (3):
      xfrm: call xdo_dev_state_delete during state update
      esp: fix skb leak with espintcp and async crypto
      rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size

Saeed Mahameed (1):
      net/mlx5: Avoid "No data available" when FW version queries fail

Samasth Norway Ananda (1):
      drm/i915/gmbus: fix spurious timeout on 512-byte burst reads

Sanman Pradhan (8):
      hwmon: (adm1177) fix sysfs ABI violation and current unit conversion
      hwmon: (peci/cputemp) Fix crit_hyst returning delta instead of absolute temperature
      hwmon: (peci/cputemp) Fix off-by-one in cputemp_is_visible()
      hwmon: (pxe1610) Check return value of page-select write in probe
      hwmon: (tps53679) Fix device ID comparison and printing in tps53676_identify()
      hwmon: (occ) Fix missing newline in occ_show_extended()
      hwmon: (occ) Fix division by zero in occ_show_power_1()
      hwmon: (pmbus/isl68137) Add mutex protection for AVS enable sysfs attributes

Sasha Levin (10):
      Revert "ext4: avoid infinite loops caused by residual data"
      Revert "ext4: drop extent cache when splitting extent fails"
      Revert "ext4: drop extent cache after doing PARTIAL_VALID1 zeroout"
      Revert "ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1"
      Revert "ext4: subdivide EXT4_EXT_DATA_VALID1"
      Revert "ext4: get rid of ppath in ext4_split_extent_at()"
      Revert "ext4: get rid of ppath in ext4_ext_insert_extent()"
      Revert "ext4: get rid of ppath in ext4_ext_create_new_leaf()"
      Revert "ext4: get rid of ppath in ext4_find_extent()"
      Revert "ext4: make ext4_es_remove_extent() return void"

Sean Christopherson (1):
      KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE

Sebastian Urban (1):
      usb: gadget: dummy_hcd: fix premature URB completion when ZLP follows partial transfer

Shay Drory (1):
      net/mlx5: lag: Check for LAG device before creating debugfs

Shigeru Yoshida (1):
      dma: swiotlb: add KMSAN annotations to swiotlb_bounce()

Shin'ichiro Kawasaki (1):
      btrfs: fix leak of kobject name for sub-group space_info

Simon Weber (1):
      ext4: fix journal credit check when setting fscrypt context

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix fence put before wait in amdgpu_amdkfd_submit_ib

Stefan Wiehler (1):
      mips: mm: Allocate tlb_vpn array atomically

Steffen Klassert (1):
      xfrm: Fix the usage of skb->sk

Suraj Gupta (1):
      net: xilinx: axienet: Correct BD length masks to match AXIDMA IP spec

Taegu Ha (1):
      usb: gadget: f_uac1_legacy: validate control request size

Takashi Iwai (1):
      ALSA: ctxfi: Fix missing SPDIFI1 index handling

Tatyana Nikolova (4):
      RDMA/irdma: Update ibqp state to error if QP is already in error state
      RDMA/irdma: Remove a NOP wait_event() in irdma_modify_qp_roce()
      RDMA/irdma: Remove reset check from irdma_modify_qp_to_err()
      RDMA/irdma: Return EINVAL for invalid arp index error

Theodore Ts'o (3):
      ext4: always drain queued discard work in ext4_mb_release()
      ext4: handle wraparound when searching for blocks for indirect mapped blocks
      ext4: fix lost error code reporting in __ext4_fill_super()

Thomas Bogendoerfer (1):
      tg3: Fix race for querying speed/duplex

Thomas Zimmermann (1):
      drm/ast: dp501: Fix initialization of SCU2C

Toke Høiland-Jørgensen (1):
      net: openvswitch: Avoid releasing netdev before teardown completes

Tomi Valkeinen (1):
      dmaengine: xilinx_dma: Fix reset related timeout with two-channel AXIDMA

Tyllis Xu (1):
      scsi: ibmvfc: Fix OOB access in ibmvfc_discover_targets_done()

Uzair Mughal (1):
      ALSA: hda/realtek: Add headset jack quirk for Thinkpad X390

Valek Andrej (1):
      iio: accel: fix ADXL355 temperature signature value

Valentin Spreckels (1):
      net: usb: r8152: add TRENDnet TUC-ET2G

Vasily Gorbik (1):
      s390/barrier: Make array_index_mask_nospec() __always_inline

Vinicius Costa Gomes (3):
      dmaengine: idxd: Fix not releasing workqueue on .release()
      dmaengine: idxd: Fix memory leak when a wq is reset
      dmaengine: idxd: Fix freeing the allocated ida too late

Viresh Kumar (1):
      cpufreq: conservative: Reset requested_freq on limits change

Vladimir Oltean (3):
      net: enetc: fix PF !of_device_is_available() teardown path
      net: phy: move phy_link_change() prior to mdio_bus_phy_may_suspend()
      net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY

Wanquan Zhong (1):
      USB: serial: option: add support for Rolling Wireless RW135R-GL

Wei Fang (1):
      net: enetc: fix the output issue of 'ethtool --show-ring'

Weiming Shi (4):
      netfilter: nfnetlink_log: fix uninitialized padding leak in NFULA_PAYLOAD
      netfilter: nf_conntrack_sip: fix use of uninitialized rtp_addr in process_sdp
      ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()
      rds: ib: reject FRMR registration before IB connection is established

Werner Kasselman (1):
      ksmbd: fix memory leaks and NULL deref in smb2_lock()

Willem de Bruijn (1):
      net: correctly handle tunneled traffic on IPV6_CSUM GSO fallback

Xiang Mei (3):
      net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
      net/sched: cls_fw: fix NULL pointer dereference on shared blocks
      net/sched: cls_flow: fix NULL pointer dereference on shared blocks

Yang Yang (5):
      openvswitch: defer tunnel netdev_put to RCU release
      openvswitch: validate MPLS set/set_masked payload length
      bridge: br_nd_send: linearize skb before parsing ND options
      bridge: br_nd_send: validate ND option lengths
      vxlan: validate ND option lengths in vxlan_na_create

Yasuaki Torimaru (1):
      wifi: wilc1000: fix u8 overflow in SSID scan buffer size calculation

Ye Bin (1):
      ext4: avoid allocate block from corrupted group in ext4_mb_find_by_goal()

Yifan Wu (1):
      netfilter: ipset: drop logically empty buckets in mtype_del

Yihang Li (1):
      scsi: scsi_transport_sas: Fix the maximum channel scanning issue

Yochai Eisenrich (3):
      net: fix fanout UAF in packet_release() via NETDEV_UP race
      net: ipv6: ndisc: fix ndisc_ra_useropt to initialize nduseropt_padX fields to zero to prevent an info-leak
      net: sched: cls_api: fix tc_chain_fill_node to initialize tcm_info to zero to prevent an info-leak

Yongchao Wu (2):
      usb: cdns3: gadget: fix NULL pointer dereference in ep_queue
      usb: cdns3: gadget: fix state inconsistency on gadget init failure

Yuchan Nam (1):
      media: mc, v4l2: serialize REINIT and REQBUFS with req_queue_mutex

Yufan Chen (1):
      net: ftgmac100: fix ring allocation unwind on open failure

Yuto Ohnuki (3):
      xfs: stop reclaim before pushing AIL during unmount
      xfs: avoid dereferencing log items after push callbacks
      xfs: save ailp before dropping the AIL lock in push callbacks

Zhan Xusheng (1):
      alarmtimer: Fix argument order in alarm_timer_forward()

Zhang Chen (1):
      Bluetooth: L2CAP: Fix send LE flow credits in ACL link

Zheng Qixing (1):
      block: fix resource leak in blk_register_queue() error path

ZhengYuan Huang (1):
      btrfs: reject root items with drop_progress and zero drop_level

Zhengchuan Liang (1):
      net: ipv6: flowlabel: defer exclusive option free until RCU teardown

Zoltan Illes (1):
      Input: xpad - add support for Razer Wolverine V3 Pro

Zqiang (1):
      ext4: fix the might_sleep() warnings in kvfree()

xietangxin (1):
      virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false



Return-Path: <stable+bounces-232989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOCdJzVZzmkxnAYAu9opvQ
	(envelope-from <stable+bounces-232989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:55:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4127A388A31
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B020030A3FD1
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3163D6695;
	Thu,  2 Apr 2026 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K8hna/7H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1F3AD500;
	Thu,  2 Apr 2026 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130665; cv=none; b=k/c2F/OEYal/p/m2gLUV9murwBKzGlm+V2tx5MITXtz0cKN/l2INoCGk5GdwyWeI0Aa0L0Q94bzwAGrai37RnoUKjsQ2FBkjpIcuM40BEHD+sp5eJMvTHc0wsxVPOBRD9E4z9FZEdNJxgkBDmykAwij7nuuxnul8HJ83N4oIUdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130665; c=relaxed/simple;
	bh=wSpZNLnNsm6BWdEqR23gY8xVpdxFan3E19tp03NWqUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZlmWPgtpjBqKpbCid5PpJe2tUCZGGg2s++OexpKiZi/S/0F4jXZtAWzMTDWkY5gV4lYGDwVKmB8rAew8hxz5fP6WjQapq5N/wjfGapdQSqz43+qQ4pSUt+m2thVW3SsykiwOhNnWGOJ1hWXbily8BR0KgyJ68X6fLyHmdy5AlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K8hna/7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2290C116C6;
	Thu,  2 Apr 2026 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775130665;
	bh=wSpZNLnNsm6BWdEqR23gY8xVpdxFan3E19tp03NWqUE=;
	h=From:To:Cc:Subject:Date:From;
	b=K8hna/7H9UVb2WQOIx+tonSWYmnM0RAMciywFRNHf6OyoYLujRiWMjhwd4wAa+sNj
	 rZ1v+hT+8ekWsjLa0Zukw4uq6G4nKex26fU9nCzn11c7hze8RvAZuMe51Bl1wsJ1eN
	 ydvBd8FlG4R8qRiQ+PG9n9lszn/gkxmJRQFD1NO8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.131
Date: Thu,  2 Apr 2026 13:51:00 +0200
Message-ID: <2026040201-dugout-chuck-5c64@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232989-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,iloc.bh:url]
X-Rspamd-Queue-Id: 4127A388A31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.6.131 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt             |    3 
 Documentation/hwmon/adm1177.rst                             |    8 
 Documentation/hwmon/peci-cputemp.rst                        |   10 
 Makefile                                                    |    2 
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts   |   13 
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi         |   22 +
 arch/arm64/kvm/reset.c                                      |   14 +
 arch/loongarch/pci/pci.c                                    |   80 ++++++
 arch/powerpc/net/bpf_jit_comp64.c                           |   23 +
 arch/s390/include/asm/barrier.h                             |    4 
 arch/s390/kernel/entry.S                                    |    4 
 arch/s390/kernel/syscall.c                                  |    2 
 arch/sh/drivers/platform_early.c                            |    4 
 arch/x86/kvm/mmu/mmu.c                                      |   14 -
 arch/x86/platform/efi/quirks.c                              |    2 
 drivers/acpi/ec.c                                           |    2 
 drivers/base/regmap/regmap.c                                |   30 +-
 drivers/bluetooth/btintel.c                                 |   11 
 drivers/bluetooth/btusb.c                                   |    5 
 drivers/bluetooth/hci_ll.c                                  |    2 
 drivers/cpufreq/cpufreq_conservative.c                      |   12 
 drivers/cpufreq/cpufreq_governor.c                          |    3 
 drivers/cpufreq/cpufreq_governor.h                          |    1 
 drivers/cxl/core/hdm.c                                      |   25 -
 drivers/dma/dw-edma/dw-hdma-v0-core.c                       |    6 
 drivers/dma/idxd/cdev.c                                     |   10 
 drivers/dma/idxd/device.c                                   |    3 
 drivers/dma/idxd/sysfs.c                                    |    1 
 drivers/dma/sh/rz-dmac.c                                    |   66 ++--
 drivers/dma/xilinx/xdma.c                                   |    4 
 drivers/dma/xilinx/xilinx_dma.c                             |   46 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                  |    4 
 drivers/gpu/drm/i915/display/intel_gmbus.c                  |    4 
 drivers/hid/hid-apple.c                                     |    4 
 drivers/hid/hid-asus.c                                      |   18 +
 drivers/hid/hid-ids.h                                       |    1 
 drivers/hid/hid-magicmouse.c                                |    6 
 drivers/hid/hid-mcp2221.c                                   |    2 
 drivers/hwmon/adm1177.c                                     |   54 ++--
 drivers/hwmon/axi-fan-control.c                             |   75 ++---
 drivers/hwmon/peci/cputemp.c                                |    4 
 drivers/hwmon/pmbus/isl68137.c                              |   21 +
 drivers/infiniband/core/rw.c                                |   21 +
 drivers/infiniband/hw/irdma/cm.c                            |   29 +-
 drivers/infiniband/hw/irdma/utils.c                         |    2 
 drivers/infiniband/hw/irdma/verbs.c                         |    9 
 drivers/irqchip/irq-qcom-mpm.c                              |    3 
 drivers/media/mc/mc-request.c                               |    5 
 drivers/media/v4l2-core/v4l2-ioctl.c                        |    5 
 drivers/mtd/spi-nor/core.c                                  |  145 ++++++++++
 drivers/net/ethernet/cadence/macb_main.c                    |    4 
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c        |    2 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                |   14 -
 drivers/net/ethernet/intel/ice/ice_repr.c                   |    3 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c             |   17 -
 drivers/net/usb/r8152.c                                     |    1 
 drivers/net/virtio_net.c                                    |    1 
 drivers/nvme/host/core.c                                    |    7 
 drivers/nvme/host/fabrics.c                                 |    4 
 drivers/nvme/host/pci.c                                     |   11 
 drivers/phy/ti/phy-j721e-wiz.c                              |    2 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c               |    9 
 drivers/platform/olpc/olpc-xo175-ec.c                       |    2 
 drivers/platform/x86/intel/hid.c                            |   13 
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c |    2 
 drivers/platform/x86/touchscreen_dmi.c                      |   18 +
 drivers/scsi/ibmvscsi/ibmvfc.c                              |    3 
 drivers/scsi/scsi_transport_sas.c                           |    2 
 drivers/scsi/ses.c                                          |    2 
 drivers/spi/spi-fsl-lpspi.c                                 |    3 
 drivers/spi/spi-intel-pci.c                                 |    1 
 drivers/spi/spi-sn-f-ospi.c                                 |   17 -
 drivers/usb/core/config.c                                   |    6 
 drivers/usb/core/quirks.c                                   |    5 
 fs/btrfs/block-group.c                                      |    2 
 fs/btrfs/disk-io.c                                          |    4 
 fs/btrfs/ioctl.c                                            |    7 
 fs/btrfs/volumes.c                                          |    5 
 fs/erofs/zdata.c                                            |    4 
 fs/ext4/crypto.c                                            |    9 
 fs/ext4/ext4.h                                              |    1 
 fs/ext4/extents.c                                           |    8 
 fs/ext4/fast_commit.c                                       |   13 
 fs/ext4/fsync.c                                             |   16 +
 fs/ext4/ialloc.c                                            |    6 
 fs/ext4/inline.c                                            |   10 
 fs/ext4/inode.c                                             |   12 
 fs/ext4/mballoc.c                                           |   28 --
 fs/ext4/page-io.c                                           |   10 
 fs/ext4/super.c                                             |   16 -
 fs/ext4/sysfs.c                                             |   10 
 fs/gfs2/lock_dlm.c                                          |   10 
 fs/jbd2/checkpoint.c                                        |   15 -
 fs/smb/server/oplock.c                                      |   72 +++--
 fs/smb/server/smb2pdu.c                                     |   73 +++--
 fs/xattr.c                                                  |   27 --
 fs/xfs/xfs_attr_item.c                                      |    4 
 fs/xfs/xfs_dquot_item.c                                     |    9 
 fs/xfs/xfs_inode_item.c                                     |    9 
 fs/xfs/xfs_mount.c                                          |    7 
 fs/xfs/xfs_trace.c                                          |    1 
 fs/xfs/xfs_trace.h                                          |   36 ++
 fs/xfs/xfs_trans_ail.c                                      |   26 +
 include/linux/dma-mapping.h                                 |    4 
 include/linux/usb/quirks.h                                  |    3 
 include/linux/usb/r8152.h                                   |    1 
 include/net/bluetooth/hci_sync.h                            |   17 +
 include/net/inet_hashtables.h                               |   14 +
 include/net/ip6_fib.h                                       |   21 +
 include/uapi/linux/dma-buf.h                                |    1 
 include/uapi/linux/netfilter/nf_conntrack_common.h          |    4 
 kernel/bpf/btf.c                                            |   24 +
 kernel/bpf/core.c                                           |   22 +
 kernel/dma/swiotlb.c                                        |   21 +
 kernel/events/core.c                                        |   58 ++--
 kernel/futex/pi.c                                           |    3 
 kernel/module/main.c                                        |    7 
 kernel/power/power.h                                        |    2 
 kernel/power/snapshot.c                                     |   36 ++
 kernel/power/swap.c                                         |    8 
 kernel/power/user.c                                         |    4 
 kernel/sysctl.c                                             |    2 
 kernel/time/alarmtimer.c                                    |    2 
 kernel/trace/trace_osnoise.c                                |   48 +--
 mm/damon/sysfs.c                                            |    3 
 net/bluetooth/hci_request.h                                 |   21 -
 net/bluetooth/hci_sync.c                                    |   14 -
 net/bluetooth/l2cap_core.c                                  |   28 +-
 net/bluetooth/l2cap_sock.c                                  |    3 
 net/bluetooth/sco.c                                         |   10 
 net/can/af_can.c                                            |    4 
 net/can/af_can.h                                            |    2 
 net/can/gw.c                                                |    6 
 net/can/isotp.c                                             |   24 +
 net/can/proc.c                                              |    3 
 net/core/rtnetlink.c                                        |    9 
 net/ipv4/esp4.c                                             |   11 
 net/ipv4/inet_connection_sock.c                             |   68 ++---
 net/ipv4/inet_hashtables.c                                  |    3 
 net/ipv4/udp.c                                              |    2 
 net/ipv6/addrconf.c                                         |    4 
 net/ipv6/esp6.c                                             |   11 
 net/ipv6/ip6_fib.c                                          |   15 -
 net/ipv6/netfilter/ip6t_rt.c                                |    4 
 net/ipv6/route.c                                            |    2 
 net/ipv6/xfrm6_output.c                                     |    4 
 net/key/af_key.c                                            |   19 -
 net/netfilter/nf_conntrack_expect.c                         |    4 
 net/netfilter/nf_conntrack_netlink.c                        |   16 -
 net/netfilter/nf_conntrack_proto_tcp.c                      |   10 
 net/netfilter/nf_conntrack_sip.c                            |   14 -
 net/netfilter/nfnetlink_log.c                               |    8 
 net/nfc/nci/core.c                                          |   10 
 net/openvswitch/flow_netlink.c                              |    2 
 net/openvswitch/vport-netdev.c                              |   11 
 net/packet/af_packet.c                                      |    1 
 net/smc/smc_rx.c                                            |    9 
 net/tls/tls_sw.c                                            |    2 
 net/xfrm/xfrm_interface_core.c                              |    2 
 net/xfrm/xfrm_output.c                                      |    7 
 net/xfrm/xfrm_policy.c                                      |    2 
 net/xfrm/xfrm_state.c                                       |    1 
 rust/kernel/init/macros.rs                                  |  160 +++++++++---
 sound/firewire/amdtp-stream.c                               |    2 
 sound/pci/hda/patch_realtek.c                               |    2 
 sound/soc/codecs/adau1372.c                                 |   34 +-
 sound/soc/fsl/fsl_easrc.c                                   |   14 -
 sound/soc/intel/catpt/device.c                              |   10 
 sound/soc/intel/catpt/dsp.c                                 |    3 
 sound/soc/sof/ipc4-topology.c                               |    2 
 tools/lib/bpf/libbpf.c                                      |    2 
 tools/objtool/arch/x86/decode.c                             |   62 +---
 tools/objtool/check.c                                       |   14 +
 173 files changed, 1680 insertions(+), 739 deletions(-)

Al Viro (1):
      xattr: switch to CLASS(fd)

Alan Borzeszkowski (1):
      spi: intel-pci: Add support for Nova Lake mobile SPI flash

Alberto Garcia (1):
      PM: hibernate: Drain trailing zero pages on userspace restore

Alexander Stein (1):
      dmaengine: xilinx: xdma: Fix regmap init error handling

Alexey Nepomnyashih (1):
      ALSA: firewire-lib: fix uninitialized local variable

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

Baokun Li (1):
      ext4: fix iloc.bh leak in ext4_fc_replay_inode() error paths

Benno Lossin (2):
      rust: pin-init: add references to previously initialized fields
      rust: pin-init: internal: init: document load-bearing fact of field accessors

Boris Burkov (1):
      btrfs: set BTRFS_ROOT_ORPHAN_CLEANUP during subvol create

Cen Zhang (1):
      Bluetooth: btintel: serialize btintel_hw_error() with hci_req_sync_lock

Cezary Rojewski (1):
      ASoC: Intel: catpt: Fix the device initialization

Christophe JAILLET (1):
      dmaengine: idxd: Remove usage of the deprecated ida_simple_xx() API

Christophe Leroy (1):
      PM: hibernate: Don't ignore return from set_memory_ro()

Chuck Lever (2):
      tls: Purge async_hold in tls_decrypt_async_wait()
      RDMA/rw: Fall back to direct SGE on MR pool exhaustion

Claudiu Beznea (2):
      dmaengine: sh: rz-dmac: Protect the driver specific lists
      dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock

Daniel Hodges (1):
      nvme-fabrics: use kfree_sensitive() for DHCHAP secrets

Danilo Krummrich (2):
      hwmon: axi-fan: don't use driver_override as IRQ name
      sh: platform_early: remove pdev->driver_override check

David Carlier (1):
      netfilter: ctnetlink: use netlink policy range checks

Davidlohr Bueso (1):
      futex: Clear stale exiting pointer in futex_lock_pi() retry path

Deepanshu Kartikey (1):
      ext4: convert inline data to extents when truncate exceeds inline size

Denis Benato (1):
      HID: asus: add xg mobile 2023 external hardware support

Edward Adam Davis (1):
      ext4: avoid infinite loops caused by residual data

Eric Dumazet (2):
      af_key: validate families in pfkey_send_migrate()
      tcp: optimize inet_use_bhash2_on_bind()

Felix Gu (2):
      spi: sn-f-ospi: Fix resource leak in f_ospi_probe()
      phy: ti: j721e-wiz: Fix device node reference leak in wiz_get_lane_phy_types()

Filipe Manana (1):
      btrfs: fix lost error when running device stats on multiple devices fs

Gao Xiang (1):
      erofs: fix "BUG: Bad page state in z_erofs_do_read_page"

Greg Kroah-Hartman (3):
      s390/syscalls: Add spectre boundary for syscall dispatch table
      scsi: ses: Handle positive SCSI error from ses_recv_diag()
      Linux 6.6.131

Günther Noack (3):
      HID: asus: avoid memory leak in asus_report_fixup()
      HID: magicmouse: avoid memory leak in magicmouse_report_fixup()
      HID: apple: avoid memory leak in apple_report_fixup()

Hans de Goede (1):
      platform/x86: touchscreen_dmi: Add quirk for y-inverted Goodix touchscreen on SUPI S10

Hari Bathini (1):
      powerpc64/bpf: do not increment tailcall count when prog is NULL

Helen Koike (2):
      Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb
      ext4: reject mount if bigalloc with s_first_data_block != 0

Huacai Chen (1):
      LoongArch: Workaround LS2K/LS7A GPU DMA hang bug

Hyunwoo Kim (4):
      Bluetooth: L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
      Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
      Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop
      ksmbd: do not expire session on binding failure

Ihor Solodrai (1):
      module: Fix kernel panic when a symbol st_shndx is out of bounds

Isaac J. Manjarres (1):
      dma-buf: Include ioctl.h in UAPI header

Ivan Barrera (1):
      RDMA/irdma: Clean up unnecessary dereference of event->cm_node

Jacob Moroni (1):
      RDMA/irdma: Initialize free_qp completion before using it

Jakub Kicinski (1):
      nfc: nci: fix circular locking dependency in nci_close_device

Jan Kara (3):
      ext4: fix stale xarray tags after writeback
      ext4: fix fsync(2) for nojournal mode
      ext4: make recently_deleted() properly work with lazy itable initialization

Jassi Brar (1):
      irqchip/qcom-mpm: Add missing mailbox TX done acknowledgment

Jenny Guanni Qu (1):
      bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN

Jiayuan Chen (1):
      ext4: fix use-after-free in update_super_work when racing with umount

Jie Deng (1):
      usb: core: new quirk to handle devices with zero configurations

Jihed Chaibi (2):
      ASoC: adau1372: Fix unchecked clk_prepare_enable() return value
      ASoC: adau1372: Fix clock leak on PLL lock failure

Jiucheng Xu (1):
      erofs: add GFP_NOIO in the bio completion if needed

Josh Law (1):
      mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]

Josh Poimboeuf (1):
      objtool: Handle Clang RSP musical chairs

Julius Lehmann (1):
      HID: magicmouse: fix battery reporting for Apple Magic Trackpad 2

Keith Busch (2):
      nvme-pci: cap queue creation to used queues
      nvme-pci: ensure we're polling a polled queue

Kevin Hao (1):
      net: macb: Use dev_consume_skb_any() to free TX SKBs

Kumar Kartikeya Dwivedi (1):
      bpf: Release module BTF IDR before module unload

Kuniyuki Iwashima (5):
      ipv6: Remove permanent routes from tb6_gc_hlist when all exceptions expire.
      ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.
      tcp: Use bhash2 for v4-mapped-v6 non-wildcard address.
      tcp: Rearrange tests in inet_csk_bind_conflict().
      tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6 non-wildcard addresses.

LUO Haowen (1):
      dmaengine: dw-edma: Fix multiple times setting of the CYCLE_STATE and CYCLE_BIT bits for HDMA.

Leif Skunberg (1):
      platform/x86: intel-hid: Enable 5-button array on ThinkPad X1 Fold 16 Gen 1

Liucheng Lu (1):
      ALSA: hda/realtek: add HP Laptop 14s-dr5xxx mute LED quirk

Long Li (1):
      xfs: fix ri_total validation in xlog_recover_attri_commit_pass2

Luca Leonardo Scorcia (1):
      pinctrl: mediatek: common: Fix probe failure for devices without EINT

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Remove remaining dependencies of hci_request

Luo Haiyang (1):
      tracing: Fix potential deadlock in cpu hotplug with osnoise

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

Miguel Ojeda (1):
      dma-mapping: add missing `inline` for `dma_free_attrs`

Mike Rapoport (Microsoft) (1):
      x86/efi: efi_unmap_boot_services: fix calculation of ranges_to_free size

Mikhail Gavrilov (1):
      libbpf: Fix -Wdiscarded-qualifiers under C23

Milos Nikic (1):
      jbd2: gracefully abort on checkpointing state corruptions

Ming Lei (1):
      nvme: fix admin queue leak on controller reset

Mohammad Heib (1):
      ionic: fix persistent MAC address override on PF

Namjae Jeon (2):
      ksmbd: replace hardcoded hdr2_len with offsetof() in smb2_calc_max_out_buf_len()
      ksmbd: fix potencial OOB in get_file_all_info() for compound requests

Nuno Sa (2):
      hwmon: (axi-fan-control) Use device firmware agnostic API
      hwmon: (axi-fan-control) Make use of dev_err_probe()

Oliver Hartkopp (2):
      can: statistics: add missing atomic access in hot path
      can: isotp: fix tx.buf use-after-free in isotp_sendmsg()

Pablo Neira Ayuso (1):
      netfilter: nf_conntrack_expect: skip expectations in other netns via proc

Paolo Valerio (1):
      net: macb: use the current queue number for stats

Pengpeng Hou (1):
      Bluetooth: btusb: clamp SCO altsetting table indices

Peter Metz (1):
      platform/x86: intel-hid: Add Dell 14 Plus 2-in-1 to dmi_vgbs_allow_list

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-topology: Allow bytes controls without initial payload

Peter Zijlstra (2):
      perf: Extract a few helpers
      perf: Make sure to use pmu_ctx->pmu for groups

Petr Oros (1):
      ice: use ice_update_eth_stats() for representor stats

Pratyush Yadav (2):
      mtd: spi-nor: core: avoid odd length/address reads on 8D-8D-8D mode
      mtd: spi-nor: core: avoid odd length/address writes in 8D-8D-8D mode

Qi Tang (1):
      net/smc: fix double-free of smc_spd_priv when tee() duplicates splice pipe buffer

Ren Wei (1):
      netfilter: ip6t_rt: reject oversized addrnr in rt_mt6_check()

Romain Sioen (1):
      HID: mcp2221: cancel last I2C command on read error

Sabrina Dubroca (3):
      xfrm: call xdo_dev_state_delete during state update
      esp: fix skb leak with espintcp and async crypto
      rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size

Samasth Norway Ananda (1):
      drm/i915/gmbus: fix spurious timeout on 512-byte burst reads

Sanman Pradhan (4):
      hwmon: (adm1177) fix sysfs ABI violation and current unit conversion
      hwmon: (pmbus/isl68137) Add mutex protection for AVS enable sysfs attributes
      hwmon: (peci/cputemp) Fix crit_hyst returning delta instead of absolute temperature
      hwmon: (peci/cputemp) Fix off-by-one in cputemp_is_visible()

Sean Christopherson (1):
      KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE

Shigeru Yoshida (1):
      dma: swiotlb: add KMSAN annotations to swiotlb_bounce()

Shin'ichiro Kawasaki (1):
      btrfs: fix leak of kobject name for sub-group space_info

Simon Weber (1):
      ext4: fix journal credit check when setting fscrypt context

Smita Koralahalli (1):
      cxl/hdm: Avoid incorrect DVSEC fallback when HDM decoders are enabled

Srinivas Pandruvada (1):
      platform/x86: ISST: Correct locked bit width

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix fence put before wait in amdgpu_amdkfd_submit_ib

Steffen Klassert (1):
      xfrm: Fix the usage of skb->sk

Steven Rostedt (1):
      tracing: Switch trace_osnoise.c code over to use guard() and __free()

Tatyana Nikolova (4):
      RDMA/irdma: Update ibqp state to error if QP is already in error state
      RDMA/irdma: Remove a NOP wait_event() in irdma_modify_qp_roce()
      RDMA/irdma: Remove reset check from irdma_modify_qp_to_err()
      RDMA/irdma: Return EINVAL for invalid arp index error

Theodore Ts'o (1):
      ext4: always drain queued discard work in ext4_mb_release()

Toke Høiland-Jørgensen (1):
      net: openvswitch: Avoid releasing netdev before teardown completes

Tomi Valkeinen (1):
      dmaengine: xilinx_dma: Fix reset related timeout with two-channel AXIDMA

Tyllis Xu (1):
      scsi: ibmvfc: Fix OOB access in ibmvfc_discover_targets_done()

Uzair Mughal (1):
      ALSA: hda/realtek: Add headset jack quirk for Thinkpad X390

Valentin Spreckels (1):
      net: usb: r8152: add TRENDnet TUC-ET2G

Vasily Gorbik (2):
      s390/barrier: Make array_index_mask_nospec() __always_inline
      s390/entry: Scrub r12 register on kernel entry

Vinicius Costa Gomes (3):
      dmaengine: idxd: Fix not releasing workqueue on .release()
      dmaengine: idxd: Fix memory leak when a wq is reset
      dmaengine: idxd: Fix freeing the allocated ida too late

Viresh Kumar (1):
      cpufreq: conservative: Reset requested_freq on limits change

Wei Fang (1):
      net: enetc: fix the output issue of 'ethtool --show-ring'

Weiming Shi (3):
      netfilter: nfnetlink_log: fix uninitialized padding leak in NFULA_PAYLOAD
      netfilter: nf_conntrack_sip: fix use of uninitialized rtp_addr in process_sdp
      ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()

Werner Kasselman (2):
      ksmbd: fix use-after-free and NULL deref in smb_grant_oplock()
      ksmbd: fix memory leaks and NULL deref in smb2_lock()

Yang Yang (2):
      openvswitch: defer tunnel netdev_put to RCU release
      openvswitch: validate MPLS set/set_masked payload length

Ye Bin (1):
      ext4: avoid allocate block from corrupted group in ext4_mb_find_by_goal()

Yihang Li (1):
      scsi: scsi_transport_sas: Fix the maximum channel scanning issue

Yochai Eisenrich (1):
      net: fix fanout UAF in packet_release() via NETDEV_UP race

Yuchan Nam (1):
      media: mc, v4l2: serialize REINIT and REQBUFS with req_queue_mutex

Yuto Ohnuki (4):
      xfs: stop reclaim before pushing AIL during unmount
      ext4: replace BUG_ON with proper error handling in ext4_read_inline_folio
      xfs: avoid dereferencing log items after push callbacks
      xfs: save ailp before dropping the AIL lock in push callbacks

Zhan Xusheng (1):
      alarmtimer: Fix argument order in alarm_timer_forward()

Zhang Chen (1):
      Bluetooth: L2CAP: Fix send LE flow credits in ACL link

Zijun Hu (1):
      Bluetooth: Remove 3 repeated macro definitions

Zqiang (1):
      ext4: fix the might_sleep() warnings in kvfree()

xietangxin (1):
      virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false



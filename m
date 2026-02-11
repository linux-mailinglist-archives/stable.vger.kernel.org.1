Return-Path: <stable+bounces-215856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LY/Ao+RjGlQrAAAu9opvQ
	(envelope-from <stable+bounces-215856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:26:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBAF12534D
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13FA5305A4AB
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758152BD5A2;
	Wed, 11 Feb 2026 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u3H7wjCB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594B29E115;
	Wed, 11 Feb 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819727; cv=none; b=A4MkrewCupSybTy08yd+JB1C5oyH+JIenFOZSi3ckMcqvUz9vCAHM3F/xMSncY3kUrpp6rlnWzpPkUzHKxv8K0uvXW8AMUfHEzht2k71JQQoH8mJYoIO2G+za6vMWHFicUN4Iih+I0rvY8e2IHfCCxhrfIeRWvajF1D2hAtS7Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819727; c=relaxed/simple;
	bh=LKWa8LtN4cJuSD5TEgZvT1AwlR+FH5BJhcmxQS4+qls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UPZLVE+1MCDUWT2PRFTuWfH6hrBHN+z+bFhdI5CqYzIj3/0VAOQcYFVVE8VPgvkWa2WKIISjPNMUBa0oGPLmM3+pxoyDJ7Hhgzm/1T/V4wmWkF/C8Ne02hBuQz0mm4BjYXgFjlBoPInTW85HXTVZcWTI3qKRcn9DbGAxYU1Q7uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u3H7wjCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38155C19421;
	Wed, 11 Feb 2026 14:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770819726;
	bh=LKWa8LtN4cJuSD5TEgZvT1AwlR+FH5BJhcmxQS4+qls=;
	h=From:To:Cc:Subject:Date:From;
	b=u3H7wjCBvOPFWvbMg+bcM8kZpMy37zg217tdjJQxRsPtBXMCtcLRxTGb2jGsQf4Kn
	 DUzHqsPRPZhSLOlwkyF9DlwJ3bvP+Sm0/0pm9KGaAcqJnF7xoOniDJfqJ79g1Pctzs
	 Hwe4v59XHS4DgYHsTTMCfR1r1Ow2+Gfv1zk9tD5o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.10
Date: Wed, 11 Feb 2026 15:21:52 +0100
Message-ID: <2026021153-crispness-broom-2e2c@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215856-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DBAF12534D
X-Rspamd-Action: no action

I'm announcing the release of the 6.18.10 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm/include/asm/string.h                                  |    5 
 arch/loongarch/kernel/traps.c                                  |    5 
 arch/loongarch/mm/cache.c                                      |    8 
 arch/riscv/include/asm/uaccess.h                               |   14 
 arch/riscv/kernel/Makefile                                     |   15 
 arch/riscv/kernel/traps.c                                      |    4 
 arch/x86/coco/sev/Makefile                                     |    2 
 arch/x86/include/asm/kfence.h                                  |    7 
 arch/x86/include/asm/vmware.h                                  |    4 
 arch/x86/kvm/svm/svm.c                                         |    2 
 arch/x86/kvm/vmx/vmx.c                                         |    2 
 arch/x86/kvm/x86.c                                             |   30 -
 arch/x86/kvm/x86.h                                             |    2 
 block/bfq-cgroup.c                                             |    2 
 drivers/android/binder.c                                       |   19 
 drivers/android/binder/rust_binderfs.c                         |    8 
 drivers/android/binder/thread.rs                               |  109 ++--
 drivers/android/binderfs.c                                     |    8 
 drivers/base/regmap/regcache-maple.c                           |   11 
 drivers/block/rbd.c                                            |   33 -
 drivers/bus/mhi/host/pci_generic.c                             |   13 
 drivers/crypto/intel/qat/qat_common/adf_aer.c                  |    2 
 drivers/dma/ioat/init.c                                        |    1 
 drivers/dma/mmp_pdma.c                                         |    6 
 drivers/firmware/cirrus/cs_dsp.c                               |   82 ++-
 drivers/firmware/cirrus/cs_dsp.h                               |   18 
 drivers/firmware/cirrus/test/cs_dsp_test_bin.c                 |   22 
 drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c           |   24 
 drivers/firmware/cirrus/test/cs_dsp_test_wmfw.c                |   26 -
 drivers/firmware/cirrus/test/cs_dsp_test_wmfw_error.c          |   24 
 drivers/firmware/cirrus/test/cs_dsp_tests.c                    |    1 
 drivers/gpio/gpio-loongson-64bit.c                             |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                     |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                         |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c         |   11 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c         |    7 
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c |  258 ++--------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c           |    7 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c           |    9 
 drivers/gpu/drm/mgag200/mgag200_bmc.c                          |   31 -
 drivers/gpu/drm/mgag200/mgag200_drv.h                          |    6 
 drivers/gpu/drm/nouveau/include/nvif/client.h                  |    2 
 drivers/gpu/drm/nouveau/include/nvif/driver.h                  |    2 
 drivers/gpu/drm/nouveau/include/nvkm/core/device.h             |    3 
 drivers/gpu/drm/nouveau/include/nvkm/core/engine.h             |    2 
 drivers/gpu/drm/nouveau/include/nvkm/core/object.h             |    5 
 drivers/gpu/drm/nouveau/include/nvkm/core/oproxy.h             |    2 
 drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h             |    4 
 drivers/gpu/drm/nouveau/include/nvkm/core/suspend_state.h      |   11 
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h              |    6 
 drivers/gpu/drm/nouveau/nouveau_drm.c                          |    2 
 drivers/gpu/drm/nouveau/nouveau_nvif.c                         |   10 
 drivers/gpu/drm/nouveau/nvif/client.c                          |    4 
 drivers/gpu/drm/nouveau/nvkm/core/engine.c                     |    4 
 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c                      |    4 
 drivers/gpu/drm/nouveau/nvkm/core/object.c                     |   20 
 drivers/gpu/drm/nouveau/nvkm/core/oproxy.c                     |    2 
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c                     |   18 
 drivers/gpu/drm/nouveau/nvkm/core/uevent.c                     |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/ce/ga100.c                 |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/ce/priv.h                  |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c              |   22 
 drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c               |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h              |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c              |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c                |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/chan.c                |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/falcon.c                   |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c                |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/uchan.c               |    6 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/base.c                  |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c                 |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv04.c                  |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv10.c                  |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv20.c                  |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv20.h                  |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv40.c                  |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/mpeg/nv44.c                |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/base.c                |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/xtensa.c                   |    4 
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c                 |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/base.c                 |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c                 |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/base.c             |    4 
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c               |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/user.c               |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/base.c                |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c                 |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gh100.c                |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h                 |    8 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c         |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c          |    8 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c          |    6 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c         |    8 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c          |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h                |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c                |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c                 |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/base.c             |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c                 |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c                 |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c               |    6 
 drivers/gpu/drm/nouveau/nvkm/subdev/timer/base.c               |    2 
 drivers/gpu/drm/xe/xe_guc.c                                    |    6 
 drivers/gpu/drm/xe/xe_guc.h                                    |    2 
 drivers/gpu/drm/xe/xe_pm.c                                     |   13 
 drivers/gpu/drm/xe/xe_query.c                                  |    2 
 drivers/hid/hid-elecom.c                                       |   15 
 drivers/hid/hid-ids.h                                          |    7 
 drivers/hid/hid-logitech-hidpp.c                               |    2 
 drivers/hid/hid-multitouch.c                                   |    1 
 drivers/hid/hid-playstation.c                                  |    5 
 drivers/hid/hid-quirks.c                                       |    5 
 drivers/hid/i2c-hid/i2c-hid-core.c                             |    1 
 drivers/hid/intel-ish-hid/ishtp-hid-client.c                   |    1 
 drivers/hid/intel-ish-hid/ishtp/bus.c                          |   12 
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c            |    5 
 drivers/hwmon/acpi_power_meter.c                               |   17 
 drivers/hwmon/dell-smm-hwmon.c                                 |    8 
 drivers/hwmon/gpio-fan.c                                       |    6 
 drivers/hwmon/occ/common.c                                     |    1 
 drivers/i2c/busses/i2c-imx.c                                   |    3 
 drivers/md/md.c                                                |    4 
 drivers/net/ethernet/adi/adin1110.c                            |    3 
 drivers/net/ethernet/broadcom/bnx2.c                           |    2 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c               |    1 
 drivers/net/ethernet/broadcom/tg3.c                            |    1 
 drivers/net/ethernet/cavium/liquidio/lio_main.c                |   39 -
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c             |    4 
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c                |    1 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c                |    2 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c            |   10 
 drivers/net/ethernet/freescale/enetc/enetc.c                   |   11 
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c               |    6 
 drivers/net/ethernet/freescale/enetc/enetc_cbdr.c              |    4 
 drivers/net/ethernet/freescale/enetc/enetc_hw.h                |   17 
 drivers/net/ethernet/google/gve/gve_ethtool.c                  |   77 +-
 drivers/net/ethernet/google/gve/gve_main.c                     |    4 
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c               |    1 
 drivers/net/ethernet/intel/e1000e/netdev.c                     |    1 
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c                   |    6 
 drivers/net/ethernet/intel/i40e/i40e_main.c                    |    2 
 drivers/net/ethernet/intel/ice/ice_main.c                      |   28 -
 drivers/net/ethernet/intel/ice/ice_ptp.c                       |  179 ++++--
 drivers/net/ethernet/intel/ice/ice_ptp.h                       |   18 
 drivers/net/ethernet/intel/igb/igb_main.c                      |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                      |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                  |    1 
 drivers/net/ethernet/mellanox/mlx4/main.c                      |    1 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                 |    1 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c                    |    1 
 drivers/net/ethernet/microchip/lan743x_main.c                  |    1 
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c               |    4 
 drivers/net/ethernet/neterion/s2io.c                           |    1 
 drivers/net/ethernet/spacemit/k1_emac.c                        |   21 
 drivers/net/ethernet/ti/cpsw.c                                 |   41 +
 drivers/net/ethernet/ti/cpsw_new.c                             |   34 +
 drivers/net/ethernet/ti/cpsw_priv.h                            |    1 
 drivers/net/macvlan.c                                          |    5 
 drivers/net/phy/sfp.c                                          |    2 
 drivers/net/usb/r8152.c                                        |   29 -
 drivers/net/usb/sr9700.c                                       |    5 
 drivers/net/wireless/intel/iwlwifi/mld/iface.c                 |    2 
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c              |    2 
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c                   |    7 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                    |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c                   |    7 
 drivers/net/wireless/ti/wlcore/tx.c                            |    5 
 drivers/nvme/host/fc.c                                         |    2 
 drivers/nvme/host/pci.c                                        |   45 +
 drivers/nvme/target/tcp.c                                      |   26 -
 drivers/pci/bus.c                                              |    3 
 drivers/pci/controller/dwc/pcie-qcom.c                         |    4 
 drivers/pci/pci.c                                              |    3 
 drivers/pci/pcie/portdrv.c                                     |    1 
 drivers/platform/x86/dell/dell-lis3lv02d.c                     |    1 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                   |    5 
 drivers/platform/x86/intel/plr_tpmi.c                          |    2 
 drivers/platform/x86/intel/telemetry/debugfs.c                 |    4 
 drivers/platform/x86/intel/telemetry/pltdrv.c                  |    2 
 drivers/platform/x86/toshiba_haps.c                            |    2 
 drivers/pmdomain/imx/gpcv2.c                                   |    8 
 drivers/pmdomain/imx/imx8m-blk-ctrl.c                          |    2 
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c                         |   30 +
 drivers/pmdomain/qcom/rpmpd.c                                  |    2 
 drivers/regulator/spacemit-p1.c                                |    6 
 drivers/scsi/bfa/bfad.c                                        |    1 
 drivers/scsi/csiostor/csio_init.c                              |    1 
 drivers/scsi/ipr.c                                             |    1 
 drivers/scsi/lpfc/lpfc_init.c                                  |    6 
 drivers/scsi/qla2xxx/qla_os.c                                  |    5 
 drivers/scsi/qla4xxx/ql4_os.c                                  |    5 
 drivers/spi/spi-hisi-kunpeng.c                                 |    4 
 drivers/spi/spi-intel-pci.c                                    |    1 
 drivers/spi/spi-tegra114.c                                     |    3 
 drivers/spi/spi-tegra20-slink.c                                |    6 
 drivers/spi/spi-tegra210-quad.c                                |   56 ++
 drivers/target/iscsi/iscsi_target_util.c                       |   10 
 drivers/tty/serial/8250/8250_pci.c                             |    1 
 drivers/tty/serial/jsm/jsm_driver.c                            |    1 
 fs/btrfs/disk-io.c                                             |   13 
 fs/btrfs/fs.h                                                  |    8 
 fs/btrfs/inode.c                                               |   22 
 fs/btrfs/tree-log.c                                            |    2 
 fs/btrfs/volumes.c                                             |    2 
 fs/ceph/crypto.c                                               |    9 
 fs/ceph/mds_client.c                                           |    5 
 fs/ceph/mdsmap.c                                               |   26 -
 fs/ceph/mdsmap.h                                               |    1 
 fs/ceph/super.h                                                |   16 
 fs/proc/task_mmu.c                                             |   42 +
 fs/smb/client/smb2file.c                                       |    1 
 fs/smb/server/smb2pdu.c                                        |    8 
 include/linux/buildid.h                                        |    3 
 include/linux/ceph/ceph_fs.h                                   |    6 
 include/linux/firmware/cirrus/cs_dsp.h                         |    4 
 include/linux/skbuff.h                                         |   12 
 io_uring/io_uring.c                                            |    2 
 io_uring/rw.c                                                  |   15 
 io_uring/zcrx.c                                                |    1 
 kernel/cgroup/dmem.c                                           |   70 ++
 kernel/sched/fair.c                                            |   54 +-
 kernel/trace/ring_buffer.c                                     |    2 
 kernel/trace/trace.c                                           |    8 
 kernel/trace/trace.h                                           |    7 
 kernel/trace/trace_entries.h                                   |   32 -
 kernel/trace/trace_export.c                                    |   21 
 lib/buildid.c                                                  |   42 +
 mm/shmem.c                                                     |   23 
 mm/slub.c                                                      |    6 
 net/bridge/netfilter/ebtables.c                                |    2 
 net/core/filter.c                                              |    8 
 net/core/gro.c                                                 |    2 
 net/core/link_watch.c                                          |   20 
 net/core/net-procfs.c                                          |   50 +
 net/ethtool/common.c                                           |    3 
 net/ethtool/rss.c                                              |    9 
 net/ipv6/ip6_fib.c                                             |    3 
 net/mac80211/iface.c                                           |    8 
 net/mac80211/key.c                                             |    3 
 net/mac80211/mlme.c                                            |    5 
 net/mac80211/ocb.c                                             |    3 
 net/mac80211/sta_info.c                                        |    7 
 net/netfilter/nf_log.c                                         |    4 
 net/netfilter/nf_tables_api.c                                  |    2 
 net/netfilter/x_tables.c                                       |    2 
 net/sched/cls_u32.c                                            |   13 
 net/tipc/crypto.c                                              |    4 
 net/wireless/util.c                                            |    8 
 sound/drivers/aloop.c                                          |   62 +-
 sound/hda/codecs/realtek/alc269.c                              |   27 +
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c                 |    5 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                           |    2 
 sound/soc/amd/yc/acp6x-mach.c                                  |    7 
 sound/soc/codecs/tlv320adcx140.c                               |    3 
 sound/soc/generic/simple-card-utils.c                          |    4 
 sound/soc/intel/boards/sof_sdw.c                               |    8 
 sound/soc/ti/davinci-evm.c                                     |   39 +
 sound/usb/mixer_quirks.c                                       |    9 
 sound/usb/pcm.c                                                |    3 
 sound/usb/quirks.c                                             |    2 
 tools/testing/selftests/kvm/Makefile.kvm                       |    1 
 virt/kvm/eventfd.c                                             |   44 -
 265 files changed, 1871 insertions(+), 1032 deletions(-)

Aaron Ma (1):
      ice: Fix PTP NULL pointer dereference during VSI rebuild

Alan Borzeszkowski (1):
      spi: intel-pci: Add support for Nova Lake SPI serial flash

Alex Deucher (1):
      Revert "drm/amd/display: pause the workload setting in dm"

Alexandre Negrel (1):
      io_uring: use GFP_NOWAIT for overflow CQEs on legacy rings

Alice Ryhl (2):
      rust_binder: correctly handle FDA objects of length zero
      rust_binder: add additional alignment checks

Andrew Cooper (1):
      x86/kfence: fix booting on 32bit non-PAE systems

Andrew Fasano (1):
      netfilter: nf_tables: fix inverted genmask check in nft_map_catchall_activate()

Andrii Nakryiko (1):
      procfs: avoid fetching build ID while holding VMA lock

Arnd Bergmann (1):
      hwmon: (occ) Mark occ_init_attribute() as __printf

Arnoud Willemsen (1):
      HID: Elecom: Add support for ELECOM M-XT3DRBK (018C)

Baochen Qiang (1):
      wifi: mac80211: collect station statistics earlier when disconnect

Bert Karwatzki (1):
      Revert "drm/amd: Check if ASPM is enabled from PCIe subsystem"

Brendan Jackman (1):
      x86/sev: Disable GCOV on noinstr object

Breno Leitao (6):
      spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed transfer
      spi: tegra210-quad: Move curr_xfer read inside spinlock
      spi: tegra210-quad: Protect curr_xfer assignment in tegra_qspi_setup_transfer_one
      spi: tegra210-quad: Protect curr_xfer in tegra_qspi_combined_seq_xfer
      spi: tegra210-quad: Protect curr_xfer clearing in tegra_qspi_non_combined_seq_xfer
      spi: tegra210-quad: Protect curr_xfer check in IRQ handler

Carlos Llamas (4):
      rust_binderfs: fix ida_alloc_max() upper bound
      binder: fix UAF in binder_netlink_report()
      binder: fix BR_FROZEN_REPLY error log
      binderfs: fix ida_alloc_max() upper bound

Chaitanya Kulkarni (1):
      nvme-fc: release admin tagset if init fails

Chen Ni (2):
      net: ethernet: adi: adin1110: Check return value of devm_gpiod_get_optional() in adin1110_check_spi()
      gpio: loongson-64bit: Fix incorrect NULL check after devm_kcalloc()

Chen Ridong (3):
      cgroup/dmem: fix NULL pointer dereference when setting max
      cgroup/dmem: avoid rcu warning when unregister region
      cgroup/dmem: avoid pool UAF

ChenXiaoSong (1):
      smb/client: fix memory leak in smb2_open_file()

Chenghao Duan (1):
      LoongArch: Enable exception fixup for specific ADE subcode

Chris Bainbridge (1):
      ASoC: amd: fix memory leak in acp3x pdm dma ops

Chris Chiu (1):
      HID: quirks: Add another Chicony HP 5MP Cameras to hid_ignore_list

Claudiu Manoil (4):
      net: enetc: Remove SI/BDR cacheability AXI settings for ENETC v4
      net: enetc: Remove CBDR cacheability AXI settings for ENETC v4
      net: enetc: Convert 16-bit register writes to 32-bit for ENETC v4
      net: enetc: Convert 16-bit register reads to 32-bit for ENETC v4

Daniel Gomez (1):
      netfilter: replace -EEXIST with -EBUSY

Daniel Hodges (1):
      tipc: use kfree_sensitive() for session key material

Daniel Vogelbacher (1):
      ceph: fix oops due to invalid pointer for kfree() in parse_longname()

Daniele Ceraolo Spurio (1):
      drm/xe/guc: Fix CFI violation in debugfs access.

Daniele Palmas (1):
      bus: mhi: host: pci_generic: Add Telit FE990B40 modem support

Dave Airlie (3):
      nouveau: add a third state to the fini handler.
      nouveau/gsp: use rpc sequence numbers properly.
      nouveau/gsp: fix suspend/resume regression on r570 firmware

DaytonCL (1):
      HID: multitouch: add MT_QUIRK_STICKY_FINGERS to MT_CLS_VTL

Debarghya Kundu (1):
      gve: Fix stats report corruption on queue count change

Deep Harsora (1):
      ASoC: Intel: sof_sdw: Add new quirks for PTL on Dell with CS42L43

Dennis Marttinen (1):
      HID: logitech: add HID++ support for Logitech MX Anywhere 3S

Devyn Liu (1):
      spi: hisi-kunpeng: Fixed the wrong debugfs node name in hisi_spi debugfs initialization

Dimitrios Katsaros (1):
      ASoC: tlv320adcx140: Propagate error codes during probe

Dmytro Bagrii (1):
      platform/x86: dell-lis3lv02d: Add Latitude 5400

Edward Adam Davis (2):
      ALSA: usb-audio: Prevent excessive number of frames
      btrfs: sync read disk super and set block size

Eric Dumazet (4):
      net: add skb_header_pointer_careful() helper
      net/sched: cls_u32: use skb_header_pointer_careful()
      macvlan: fix error recovery in macvlan_common_newlink()
      net: add proper RCU protection to /proc/net/ptype

Ethan Nelson-Moore (1):
      net: usb: sr9700: support devices with virtual driver CD

Even Xu (1):
      HID: Intel-thc-hid: Intel-thc: Add safety check for reading DMA buffer

Felix Gu (1):
      spi: tegra: Fix a memory leak in tegra_slink_probe()

FengWei Shih (1):
      md: suspend array while updating raid_disks via sysfs

Filipe Manana (2):
      btrfs: do not free data reservation in fallback from inline due to -ENOSPC
      btrfs: fix reservation leak in some error paths when inserting inline extent

Gabor Juhos (3):
      pmdomain: qcom: rpmpd: fix off-by-one error in clamping to the highest state
      hwmon: (gpio-fan) Fix set_rpm() return value
      hwmon: (gpio-fan) Allow to stop FANs when CONFIG_PM is disabled

Greg Kroah-Hartman (1):
      Linux 6.18.10

Grzegorz Nitka (1):
      ice: fix missing TX timestamps interrupts on E825 devices

Guodong Xu (2):
      dmaengine: mmp_pdma: Fix race condition in mmp_pdma_residue()
      regulator: spacemit-p1: Fix n_voltages for BUCK and LDO regulators

Hannes Reinecke (1):
      nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()

Hao Ge (1):
      mm/slab: Add alloc_tagging_slab_free_hook for memcg_alloc_abort_single

Huacai Chen (1):
      LoongArch: Set correct protection_map[] for VM_NONE/VM_SHARED

Ian Rogers (1):
      tracing: Avoid possible signed 64-bit truncation

Ilya Dryomov (1):
      rbd: check for EOD after exclusive lock is ensured to be held

Jacky Bai (1):
      pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to wrong adb400 reset

Jacob Keller (2):
      ice: PTP: fix missing timestamps on E825 hardware
      drm/mgag200: fix mgag200_bmc_stop_scanout()

Jakub Kicinski (2):
      net: don't touch dev->stats in BPF redirect paths
      net: rss: fix reporting RXH_XFRM_NO_CHANGE as input_xfrm for contexts

Jens Axboe (1):
      io_uring/rw: free potentially allocated iovec on cache put failure

Jiayuan Chen (1):
      linkwatch: use __dev_put() in callers to prevent UAF

Johannes Berg (1):
      wifi: mac80211: don't WARN for connections on invalid channels

Josh Poimboeuf (1):
      x86/vmware: Fix hypercall clobbers

Junrui Luo (2):
      dpaa2-switch: prevent ZERO_SIZE_PTR dereference when num_ifs is zero
      dpaa2-switch: add bounds check for if_id in IRQ handler

Kairui Song (1):
      mm, shmem: prevent infinite loop on truncate race

Karthik Poosa (1):
      drm/xe/pm: Disable D3Cold for BMG only on specific platforms

Kaushlendra Kumar (3):
      platform/x86: intel_telemetry: Fix swapped arrays in PSS output
      regmap: maple: free entry on mas_store_gfp() failure
      platform/x86: intel_telemetry: Fix PSS event register mask

Keith Busch (1):
      nvme-pci: handle changing device dma map requirements

Kery Qi (1):
      ASoC: davinci-evm: Fix reference leak in davinci_evm_probe

Kevin Hao (2):
      net: cpsw: Execute ndo_set_rx_mode callback in a work queue
      net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue

Kwok Kin Ming (1):
      HID: i2c-hid: fix potential buffer overflow in i2c_hid_get_report()

LI Qingwu (1):
      i2c: imx: preserve error state in block data length handler

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for MOONDROP Moonriver2 Ti

Lukas Gerlach (1):
      riscv: Sanitize syscall table indexing under speculation

Lukas Wunner (2):
      PCI/ERR: Ensure error recoverability at all times
      treewide: Drop pci_save_state() after pci_restore_state()

Manivannan Sadhasivam (1):
      PCI: qcom: Remove ASPM L0s support for MSM8996 SoC

Marek Behún (1):
      net: sfp: Fix quirk for Ubiquiti U-Fiber Instant SFP module

Mario Limonciello (2):
      drm/amd: Set minimum version for set_hw_resource_1 on gfx11 to 0x52
      platform/x86: hp-bioscfg: Skip empty attribute names

Martin Hamilton (1):
      ALSA: hda/realtek: ALC269 fixup for Lenovo Yoga Book 9i 13IRU8 audio

Martin Kaiser (1):
      riscv: trace: fix snapshot deadlock with sbi ecall

Matouš Lánský (1):
      ALSA: hda/realtek: Add quirk for Acer Nitro AN517-55

Maurizio Lombardi (2):
      scsi: target: iscsi: Fix use-after-free in iscsit_dec_session_usage_count()
      scsi: target: iscsi: Fix use-after-free in iscsit_dec_conn_usage_count()

Max Yuan (1):
      gve: Correct ethtool rx_dropped calculation

Melissa Wen (1):
      drm/amd/display: fix wrong color value mapping on MCM shaper LUT

Miri Korenblit (4):
      wifi: mac80211: correctly check if CSA is active
      wifi: mac80211: don't increment crypto_tx_tailroom_needed_cnt twice
      wifi: iwlwifi: mld: cancel mlo_scan_start_wk
      wifi: iwlwifi: mvm: pause TCM on fast resume

Mohammad Heib (2):
      ice: drop udp_tunnel_get_rx_info() call from ndo_open()
      i40e: drop udp_tunnel_get_rx_info() call from i40e_open()

Moon Hee Lee (1):
      wifi: mac80211: ocb: skip rx_no_sta when interface is not joined

Nathan Chancellor (3):
      drm/amd/display: Reduce number of arguments of dcn30's CalculatePrefetchSchedule()
      riscv: Use 64-bit variable for output in __get_user_asm
      riscv: Add intermediate cast to 'unsigned long' in __get_user_asm

Paolo Abeni (1):
      net: gro: fix outer network offset

Pavel Begunkov (1):
      io_uring/zcrx: fix page array leak

Perry Yuan (1):
      drm/amd/pm: Disable MMIO access during SMU Mode 1 reset

Peter Zijlstra (1):
      sched/fair: Have SD_SERIALIZE affect newidle balancing

Peter Åstrand (1):
      wifi: wlcore: ensure skb headroom before skb_push

Qiang Ma (1):
      btrfs: fix Wmaybe-uninitialized warning in replay_one_buffer()

Qu Wenruo (1):
      btrfs: reject new transactions if the fs is fully read-only

Radhi Bajahaw (1):
      ASoC: amd: yc: Fix microphone on ASUS M6500RE

Rafael J. Wysocki (2):
      platform/x86: toshiba_haps: Fix memory leaks in add/remove routines
      hwmon: (acpi_power_meter) Fix deadlocks related to acpi_power_meter_notify()

Ricardo Neri (1):
      platform/x86/intel/tpmi/plr: Make the file domain<n>/status writeable

Richard Fitzgerald (2):
      firmware: cs_dsp: Factor out common debugfs string read
      firmware: cs_dsp: rate-limit log messages in KUnit builds

Rodrigo Lugathe da Conceição Alves (1):
      HID: Apply quirk HID_QUIRK_ALWAYS_POLL to Edifier QR30 (2d99:a101)

Ruslan Krupitsa (1):
      ALSA: hda/realtek: add HP Laptop 15s-eq1xxx mute LED quirk

Sean Christopherson (2):
      KVM: x86: Explicitly configure supported XSS from {svm,vmx}_set_cpu_caps()
      KVM: Don't clobber irqfd routing type when deassigning irqfd

Sergey Senozhatsky (1):
      net: usb: r8152: fix resume reset deadlock

Sergey Shtylyov (1):
      ALSA: usb-audio: fix broken logic in snd_audigy2nx_led_update()

Shenghao Ding (1):
      ALSA: hda/tas2781: Add newly-released HP laptop

Shengjiu Wang (1):
      ASoC: simple-card-utils: Check device node before overwrite direction

Shigeru Yoshida (1):
      ipv6: Fix ECMP sibling count mismatch when clearing RTF_ADDRCONF

Shuicheng Lin (1):
      drm/xe/query: Fix topology query pointer advance

Siarhei Vishniakou (1):
      HID: playstation: Center initial joystick axes to prevent spurious events

Steven Rostedt (1):
      tracing: Fix ftrace event field alignments

Takashi Iwai (2):
      ALSA: aloop: Fix racy access at PCM trigger
      ALSA: usb-audio: Use the right limit for PCM OOB check

Thomas Weissschuh (1):
      ARM: 9468/1: fix memset64() on big-endian

Tim Chen (1):
      sched/fair: Skip sched_balance_running cmpxchg when balance is not due

Tim Guttzeit (1):
      ALSA: hda/realtek: Fix headset mic for TongFang X6AR55xU

Tomas Hlavacek (1):
      net: spacemit: k1-emac: fix jumbo frame support

Veerendranath Jakkam (1):
      wifi: cfg80211: Fix bitrate calculation overflow for HE rates

Viacheslav Dubeyko (1):
      ceph: fix NULL pointer dereference in ceph_mds_auth_match()

Vishwaroop A (1):
      spi: tegra114: Preserve SPI mode bits in def_command1_reg

Werner Sembach (1):
      ALSA: hda/realtek: Really fix headset mic for TongFang X6AR55xU.

Wupeng Ma (1):
      ring-buffer: Avoid softlockup in ring_buffer_resize() during memory free

Xu Yang (3):
      pmdomain: imx8mp-blk-ctrl: Keep gpc power domain on for system wakeup
      pmdomain: imx8mp-blk-ctrl: Keep usb phy power domain on for system wakeup
      pmdomain: imx8m-blk-ctrl: fix out-of-range access of bc->domains

Yao Zi (1):
      wifi: iwlwifi: Implement settime64 as stub for MVM/MLD PTP

YunJe Shin (1):
      nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec

Zhang Lixu (2):
      HID: intel-ish-hid: Update ishtp bus match to support device ID table
      HID: intel-ish-hid: Reset enum_devices_done before enumeration

ZhangGuoDong (3):
      smb/server: call ksmbd_session_rpc_close() on error path in create_smb2_pipe()
      smb/server: fix refcount leak in smb2_open()
      smb/server: fix refcount leak in parse_durable_handle_context()

Zhiquan Li (1):
      KVM: selftests: Add -U_FORTIFY_SOURCE to avoid some unpredictable test failures

Zilin Guan (3):
      net: liquidio: Initialize netdev pointer before queue setup
      net: liquidio: Fix off-by-one error in PF setup_nic_devices() cleanup
      net: liquidio: Fix off-by-one error in VF setup_nic_devices() cleanup

leobannocloutier@gmail.com (1):
      hwmon: (dell-smm) Add Dell G15 5510 to fan control whitelist

shechenglong (1):
      block,bfq: fix aux stat accumulation destination



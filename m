Return-Path: <stable+bounces-73043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7667796BB1B
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035471F27708
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3651B1D79BA;
	Wed,  4 Sep 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q7heUx48"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4311D79B5;
	Wed,  4 Sep 2024 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450150; cv=none; b=IRwgKfF8wvVN5HR5eX5J6Gv+R/Eiy6beDlQRpfA4IdIetoZ7ablriBQ3FrpSCGvG7myKJVcF3l/qaQaGSq5MTSZAhm0XSqWhPJHZoEwsPXpgMGQXnZv5mUJT1H4CJAoxkKmJphfG4SbP574fiyNMwyT58JkYzfAUAIGVs38Cy1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450150; c=relaxed/simple;
	bh=G7PuscIDvmVFUl6J6igQqCnbick9NQG/4HwoesQZ2zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ISp59D0ppFqJ69ATZirvCq86PxHOkni3uDCdNw7RuSYyb5xjp3FpnrJVHmn/0Z0JPTTFPKn2ouNsUsIuMKcS18i+SRbZcapuyFw8/yyhnAuhgLQeD6yseoB3820aBbYIIV+dZ8+ZDfGDtx6WDI0/oPcJJfxBJS0O0XhNer81prQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q7heUx48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AD7C4CEC9;
	Wed,  4 Sep 2024 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725450149;
	bh=G7PuscIDvmVFUl6J6igQqCnbick9NQG/4HwoesQZ2zI=;
	h=From:To:Cc:Subject:Date:From;
	b=q7heUx48tMtxXuLgfqklEmRdToYzIZrXhrxB6SpF3o3cFaJM0yj/MstqVmQV84jiB
	 hz6WvzRBGCSvfw9Ri+X2AA6MrFJSaecafIseOcW/sHD9Fn5Q6VGYIwUsRMuo5AnIpp
	 TckLH95H8yCRSZyZnVIUT5hn/1giEmXUGAAn741g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.8
Date: Wed,  4 Sep 2024 13:42:07 +0200
Message-ID: <2024090408-attire-backyard-9c7f@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.8 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/usb/microchip,usb2514.yaml |    9 
 Makefile                                                     |    2 
 arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi          |   12 
 arch/arm/boot/dts/ti/omap/omap3-n900.dts                     |    2 
 arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts          |   12 
 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts   |    2 
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi            |    2 
 arch/arm64/boot/dts/freescale/imx93.dtsi                     |    2 
 arch/arm64/boot/dts/qcom/ipq5332.dtsi                        |    4 
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                    |    2 
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                    |    2 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                       |    6 
 arch/loongarch/include/asm/dma-direct.h                      |   11 
 arch/loongarch/kernel/fpu.S                                  |    4 
 arch/loongarch/kvm/switch.S                                  |    4 
 drivers/bluetooth/btnxpuart.c                                |   65 +++-
 drivers/char/tpm/tpm_ibmvtpm.c                               |    4 
 drivers/cpufreq/amd-pstate-ut.c                              |   13 
 drivers/cpufreq/amd-pstate.c                                 |    2 
 drivers/dma/dw-edma/dw-hdma-v0-core.c                        |   26 -
 drivers/dma/dw/core.c                                        |   89 +++++-
 drivers/dma/ti/omap-dma.c                                    |    6 
 drivers/firmware/microchip/mpfs-auto-update.c                |    2 
 drivers/firmware/qcom/qcom_scm-smc.c                         |    2 
 drivers/firmware/sysfb.c                                     |   19 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                |   26 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                     |    2 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                       |   18 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c      |    9 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                    |   21 -
 drivers/gpu/drm/i915/display/intel_dp.c                      |   12 
 drivers/gpu/drm/i915/display/intel_dp_mst.c                  |   40 ++
 drivers/gpu/drm/i915/display/intel_dp_mst.h                  |    1 
 drivers/gpu/drm/i915/display/vlv_dsi.c                       |    1 
 drivers/gpu/drm/v3d/v3d_sched.c                              |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c                         |  114 +++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                           |   13 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                           |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                          |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                         |   12 
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                      |    6 
 drivers/gpu/drm/xe/display/xe_display.c                      |   33 ++
 drivers/gpu/drm/xe/display/xe_display.h                      |    8 
 drivers/gpu/drm/xe/xe_exec_queue.c                           |    5 
 drivers/gpu/drm/xe/xe_exec_queue_types.h                     |   14 
 drivers/gpu/drm/xe/xe_hwmon.c                                |    2 
 drivers/gpu/drm/xe/xe_pm.c                                   |   20 +
 drivers/gpu/drm/xe/xe_preempt_fence.c                        |    3 
 drivers/gpu/drm/xe/xe_preempt_fence_types.h                  |    2 
 drivers/gpu/drm/xe/xe_vm.c                                   |   60 ++--
 drivers/hwmon/pt5161l.c                                      |    4 
 drivers/iommu/io-pgtable-arm-v7s.c                           |    3 
 drivers/iommu/io-pgtable-arm.c                               |    3 
 drivers/iommu/io-pgtable-dart.c                              |    3 
 drivers/iommu/iommufd/ioas.c                                 |    8 
 drivers/net/bonding/bond_main.c                              |  159 +++++++----
 drivers/net/ethernet/microsoft/mana/hw_channel.c             |   62 ++--
 drivers/net/gtp.c                                            |    2 
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                 |   13 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                 |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                |   11 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c              |   32 +-
 drivers/net/wireless/silabs/wfx/sta.c                        |    5 
 drivers/nfc/pn533/pn533.c                                    |    5 
 drivers/of/platform.c                                        |    2 
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c                   |    2 
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c                     |   23 +
 drivers/phy/xilinx/phy-zynqmp.c                              |   56 +++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c             |   55 ++-
 drivers/pinctrl/pinctrl-rockchip.c                           |    2 
 drivers/pinctrl/pinctrl-single.c                             |    2 
 drivers/pinctrl/qcom/pinctrl-x1e80100.c                      |   35 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c           |    4 
 drivers/power/supply/qcom_battmgr.c                          |   16 -
 drivers/scsi/aacraid/comminit.c                              |    2 
 drivers/scsi/sd.c                                            |   12 
 drivers/soc/qcom/cmd-db.c                                    |    2 
 drivers/soc/qcom/pmic_glink.c                                |   40 +-
 drivers/soc/qcom/pmic_glink_altmode.c                        |   17 -
 drivers/soundwire/stream.c                                   |    8 
 drivers/usb/cdns3/cdnsp-gadget.h                             |    3 
 drivers/usb/cdns3/cdnsp-ring.c                               |   30 ++
 drivers/usb/class/cdc-acm.c                                  |    3 
 drivers/usb/core/sysfs.c                                     |    1 
 drivers/usb/dwc3/core.c                                      |    8 
 drivers/usb/dwc3/dwc3-omap.c                                 |    4 
 drivers/usb/dwc3/dwc3-st.c                                   |   16 -
 drivers/usb/dwc3/dwc3-xilinx.c                               |    7 
 drivers/usb/dwc3/ep0.c                                       |    3 
 drivers/usb/gadget/function/uvc_video.c                      |    1 
 drivers/usb/serial/option.c                                  |    5 
 drivers/usb/typec/mux/fsa4480.c                              |    2 
 drivers/usb/typec/ucsi/ucsi_glink.c                          |   43 ++
 drivers/video/aperture.c                                     |   11 
 fs/afs/inode.c                                               |   11 
 fs/attr.c                                                    |   14 
 fs/backing-file.c                                            |    5 
 fs/binfmt_elf_fdpic.c                                        |    3 
 fs/btrfs/bio.c                                               |   26 +
 fs/btrfs/qgroup.c                                            |    2 
 fs/ceph/inode.c                                              |    1 
 fs/erofs/zutil.c                                             |    3 
 fs/netfs/io.c                                                |    1 
 fs/netfs/misc.c                                              |   60 +++-
 fs/netfs/write_collect.c                                     |    7 
 fs/nfsd/nfs4state.c                                          |   62 ++--
 fs/nfsd/nfs4xdr.c                                            |    6 
 fs/nfsd/state.h                                              |    2 
 fs/smb/client/cifsglob.h                                     |    1 
 fs/smb/client/cifssmb.c                                      |    1 
 fs/smb/client/smb2ops.c                                      |   24 +
 fs/smb/client/smb2pdu.c                                      |    4 
 include/linux/fs.h                                           |    1 
 include/linux/soc/qcom/pmic_glink.h                          |   11 
 include/linux/sysfb.h                                        |    4 
 include/net/bonding.h                                        |    2 
 include/net/busy_poll.h                                      |    2 
 include/net/netfilter/nf_tables_ipv4.h                       |   10 
 include/net/netfilter/nf_tables_ipv6.h                       |    5 
 io_uring/kbuf.c                                              |    2 
 mm/truncate.c                                                |    4 
 net/bluetooth/hci_core.c                                     |   10 
 net/core/net-sysfs.c                                         |    2 
 net/core/pktgen.c                                            |    4 
 net/ethtool/ioctl.c                                          |    3 
 net/ipv4/tcp.c                                               |   18 -
 net/mptcp/fastopen.c                                         |    4 
 net/mptcp/options.c                                          |   50 +--
 net/mptcp/pm.c                                               |   32 +-
 net/mptcp/pm_netlink.c                                       |  107 +++++--
 net/mptcp/protocol.c                                         |   65 ++--
 net/mptcp/protocol.h                                         |    9 
 net/mptcp/sched.c                                            |    4 
 net/mptcp/sockopt.c                                          |    4 
 net/mptcp/subflow.c                                          |   56 ++-
 net/sched/sch_fq.c                                           |    4 
 net/sctp/sm_statefuns.c                                      |   22 +
 security/apparmor/policy_unpack_test.c                       |    6 
 security/selinux/hooks.c                                     |    4 
 security/smack/smack_lsm.c                                   |    4 
 sound/core/seq/seq_clientmgr.c                               |    3 
 sound/pci/hda/cs35l56_hda.c                                  |    2 
 sound/pci/hda/patch_realtek.c                                |    2 
 sound/soc/amd/acp/acp-legacy-mach.c                          |    2 
 sound/soc/codecs/cs-amp-lib-test.c                           |    9 
 sound/soc/codecs/cs-amp-lib.c                                |    7 
 sound/soc/sof/amd/acp-dsp-offset.h                           |    6 
 sound/soc/sof/amd/acp.c                                      |   52 ++-
 sound/soc/sof/amd/acp.h                                      |    9 
 sound/soc/sof/amd/pci-acp63.c                                |    2 
 sound/soc/sof/amd/pci-rmb.c                                  |    2 
 sound/soc/sof/amd/pci-rn.c                                   |    2 
 tools/testing/selftests/iommu/iommufd.c                      |    6 
 tools/testing/selftests/net/forwarding/local_termination.sh  |    4 
 tools/testing/selftests/net/forwarding/no_forwarding.sh      |    3 
 tools/testing/selftests/net/mptcp/mptcp_join.sh              |   57 ++-
 156 files changed, 1609 insertions(+), 707 deletions(-)

Abel Vesa (1):
      phy: qcom: qmp-pcie: Fix X1E80100 PCIe Gen4 PHY initialisation

Adam Ford (1):
      arm64: dts: imx8mp-beacon-kit: Fix Stereo Audio on WM8962

Aleksandr Mishin (1):
      nfc: pn533: Add poll mod list filling check

Alex Deucher (4):
      drm/amdgpu: align pp_power_profile_mode with kernel docs
      drm/amdgpu/swsmu: always force a state reprogram on init
      video/aperture: optionally match the device in sysfb_disable()
      drm/amdgpu: fix eGPU hotplug regression

Alexander Stein (1):
      dt-bindings: usb: microchip,usb2514: Fix reference USB device schema

Alexander Sverdlin (1):
      wifi: wfx: repair open network AP mode

Anjaneyulu (1):
      wifi: iwlwifi: fw: fix wgds rev 3 exact size

Avraham Stern (1):
      wifi: iwlwifi: mvm: allow 6 GHz channels in MLO scan

Ben Hutchings (1):
      scsi: aacraid: Fix double-free on probe failure

Bjorn Andersson (3):
      soc: qcom: pmic_glink: Actually communicate when remote goes down
      soc: qcom: pmic_glink: Fix race during initialization
      usb: typec: ucsi: Move unregister out of atomic section

Cong Wang (1):
      gtp: fix a potential NULL pointer dereference

Cosmo Chou (1):
      hwmon: (pt5161l) Fix invalid temperature reading

David Howells (8):
      netfs, ceph: Partially revert "netfs: Replace PG_fscache by setting folio->private and marking dirty"
      mm: Fix missing folio invalidation calls during truncation
      afs: Fix post-setattr file edit to do truncation correctly
      netfs: Fix netfs_release_folio() to say no if folio dirty
      netfs: Fix trimming of streaming-write folios in netfs_inval_folio()
      netfs: Fix missing iterator reset on retry of short read
      netfs: Fix interaction of streaming writes with zero-point tracker
      cifs: Fix FALLOC_FL_PUNCH_HOLE support

Ed Tsai (1):
      backing-file: convert to using fops->splice_write

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: take the mutex before running link selection

Eric Dumazet (3):
      pktgen: use cpus_read_lock() in pg_net_init()
      net_sched: sch_fq: fix incorrect behavior for small weights
      net: busy-poll: use ktime_get_ns() instead of local_clock()

Francois Dugast (1):
      drm/xe/exec_queue: Rename xe_exec_queue::compute to xe_exec_queue::lr

Gao Xiang (1):
      erofs: fix out-of-bound access when z_erofs_gbuf_growsize() partially fails

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Use topology_logical_package_id() instead of logical_die_id()

Greg Kroah-Hartman (1):
      Linux 6.10.8

Guenter Roeck (1):
      apparmor: fix policy_unpack_test on big endian systems

Haiyang Zhang (1):
      net: mana: Fix race of mana_hwc_post_rx_wqe and new hwc response

Hal Feng (1):
      pinctrl: starfive: jh7110: Correct the level trigger configuration of iev register

Hans de Goede (1):
      drm/i915/dsi: Make Lenovo Yoga Tab 3 X90F DMI match less strict

Hendrik Borghorst (1):
      ALSA: hda/realtek: support HP Pavilion Aero 13-bg0xxx Mute LED

Huang-Huang Bao (1):
      pinctrl: rockchip: correct RK3328 iomux width flag for GPIO2-B pins

Ian Ray (1):
      cdc-acm: Add DISABLE_ECHO quirk for GE HealthCare UI Controller

Imre Deak (1):
      drm/i915/dp_mst: Fix MST state after a sink reset

Jack Xiao (1):
      drm/amdgpu/mes: fix mes ring buffer overflow

Jamie Bainbridge (1):
      ethtool: check device is present when getting link settings

Jason Gunthorpe (2):
      iommufd: Do not allow creating areas without READ or WRITE
      iommu: Do not return 0 from map_pages if it doesn't do anything

Jeff Layton (4):
      nfsd: ensure that nfsd4_fattr_args.context is zeroed out
      nfsd: hold reference to delegation when updating it for cb_getattr
      nfsd: fix potential UAF in nfsd4_cb_getattr_release
      fs/nfsd: fix update of inode attrs in CB_GETATTR

Jens Axboe (1):
      io_uring/kbuf: return correct iovec count from classic buffer peek

Jianbo Liu (3):
      bonding: implement xdo_dev_state_free and call it after deletion
      bonding: extract the use of real_device into local variable
      bonding: change ipsec_lock from spin lock to mutex

Johan Hovold (4):
      arm64: dts: qcom: x1e80100-crd: fix PCIe4 PHY supply
      arm64: dts: qcom: x1e80100-qcp: fix PCIe4 PHY supply
      arm64: dts: qcom: x1e80100: add missing PCIe minimum OPP
      arm64: dts: qcom: x1e80100: fix PCIe domain numbers

John Sweeney (1):
      ALSA: hda/realtek: Enable mute/micmute LEDs on HP Laptop 14-ey0xxx

Josef Bacik (1):
      btrfs: run delayed iputs when flushing delalloc

Karthik Poosa (1):
      drm/xe/hwmon: Fix WRITE_I1 param from u32 to u16

Kees Cook (1):
      dmaengine: ti: omap-dma: Initialize sglen after allocation

Konrad Dybcio (2):
      pinctrl: qcom: x1e80100: Update PDC hwirq map
      pinctrl: qcom: x1e80100: Fix special pin offsets

Krzysztof Kozlowski (5):
      soundwire: stream: fix programming slave ports for non-continous port maps
      usb: dwc3: xilinx: add missing depopulate in probe error path
      usb: dwc3: omap: add missing depopulate in probe error path
      usb: dwc3: st: fix probed platform device ref count on probe error path
      usb: dwc3: st: add missing depopulate in probe error path

Luca Weiss (1):
      usb: typec: fsa4480: Relax CHIP_ID check

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix not handling hibernation actions

Ma Ke (2):
      pinctrl: single: fix potential NULL dereference in pcs_get_function()
      drm/amd/display: avoid using null object of framebuffer

Maarten Lankhorst (1):
      drm/xe/display: Make display suspend/resume work on discrete

Mario Limonciello (1):
      cpufreq/amd-pstate-ut: Don't check for highest perf matching on prefcore

Markus Niebel (2):
      arm64: dts: freescale: imx93-tqma9352: fix CMA alloc-ranges
      arm64: dts: freescale: imx93-tqma9352-mba93xxla: fix typo

Matthew Auld (1):
      drm/xe: prevent UAF around preempt fence

Matthieu Baerts (NGI0) (16):
      mptcp: close subflow when receiving TCP+FIN
      mptcp: sched: check both backup in retrans
      mptcp: pr_debug: add missing \n at the end
      mptcp: pm: reuse ID 0 after delete and re-add
      mptcp: pm: skip connecting to already established sf
      mptcp: pm: reset MPC endp ID when re-added
      mptcp: pm: send ACK on an active subflow
      mptcp: pm: fix RM_ADDR ID for the initial subflow
      mptcp: pm: do not remove already closed subflows
      mptcp: pm: fix ID 0 endp usage after multiple re-creations
      mptcp: avoid duplicated SUB_CLOSED events
      mptcp: pm: ADD_ADDR 0 is not a new address
      selftests: mptcp: join: cannot rm sf if closed
      selftests: mptcp: join: check removing ID 0 endpoint
      selftests: mptcp: join: no extra msg if no counter
      selftests: mptcp: join: check re-re-adding ID 0 endp

Max Filippov (1):
      binfmt_elf_fdpic: fix AUXV size calculation when ELF_HWCAP2 is defined

Miao Wang (1):
      LoongArch: Remove the unused dma-direct.h

Michael Grzeschik (1):
      usb: dwc3: ep0: Don't reset resource alloc flag (including ep0)

Michal Vokáč (1):
      ARM: dts: imx6dl-yapp43: Increase LED current to match the yapp4 HW design

Mrinmay Sarkar (2):
      dmaengine: dw-edma: Fix unmasking STOP and ABORT interrupts for HDMA
      dmaengine: dw-edma: Do not enable watermark interrupts for HDMA

Murali Nalajala (1):
      firmware: qcom: scm: Mark get_wq_ctx() as atomic call

Neeraj Sanjay Kale (2):
      Bluetooth: btnxpuart: Handle FW Download Abort scenario
      Bluetooth: btnxpuart: Fix random crash seen while removing driver

NeilBrown (1):
      nfsd: fix nfsd4_deleg_getattr_conflict in presence of third party lease

Nícolas F. R. A. Prado (1):
      pinctrl: mediatek: common-v2: Fix broken bias-disable for PULL_PU_PD_RSEL_TYPE

Olga Kornievskaia (1):
      nfsd: prevent panic for nfsv4.0 closed files in nfs4_show_open

Ondrej Mosnacek (1):
      sctp: fix association labeling in the duplicate COOKIE-ECHO case

Pablo Neira Ayuso (2):
      netfilter: nf_tables: restore IP sanity checks for netdev/egress
      netfilter: nf_tables_ipv6: consider network offset in netdev/egress validation

Pawel Laszczak (2):
      usb: cdnsp: fix incorrect index in cdnsp_get_hw_deq function
      usb: cdnsp: fix for Link TRB with TC

Petr Machata (2):
      selftests: forwarding: no_forwarding: Down ports on cleanup
      selftests: forwarding: local_termination: Down ports on cleanup

Piyush Mehta (1):
      phy: xilinx: phy-zynqmp: Fix SGMII linkup failure on resume

Qu Wenruo (1):
      btrfs: fix a use-after-free when hitting errors inside btrfs_submit_chunk()

Richard Fitzgerald (2):
      ASoC: cs-amp-lib-test: Force test calibration blob entries to be valid
      ASoC: cs-amp-lib: Ignore empty UEFI calibration entries

Rodrigo Vivi (1):
      drm/xe: Prepare display for D3Cold

Sascha Hauer (1):
      wifi: mwifiex: duplicate static structs used in driver instances

Scott Mayhew (1):
      selinux,smack: don't bypass permissions check in inode_setsecctx hook

Selvarasu Ganesan (1):
      usb: dwc3: core: Prevent USB core invalid event buffer address access

Serge Semin (2):
      dmaengine: dw: Add peripheral bus width verification
      dmaengine: dw: Add memory bus width verification

Shenwei Wang (1):
      arm64: dts: imx93: update default value for snps,clk-csr

Sicelo A. Mhlongo (1):
      ARM: dts: omap3-n900: correct the accelerometer orientation

Simon Trimmer (1):
      ALSA: hda: cs35l56: Don't use the device index as a calibration index

Stefan Berger (1):
      tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support

Stefan Metzmacher (2):
      smb/client: avoid dereferencing rdata=NULL in smb2_new_read_req()
      smb/client: remove unused rq_iter_size from struct smb_rqst

Steve Wilkins (1):
      firmware: microchip: fix incorrect error report of programming:timeout on success

Takashi Iwai (1):
      ALSA: seq: Skip event type filtering for UMP events

Thorsten Blum (1):
      drm/xe/vm: Simplify if condition

Tiezhu Yang (1):
      LoongArch: Add ifdefs to fix LSX and LASX related warnings

Tvrtko Ursulin (1):
      drm/v3d: Disable preemption while updating GPU stats

Varadarajan Narayanan (1):
      arm64: dts: qcom: ipq5332: Fix interrupt trigger type for usb

Victor Lu (1):
      drm/amdgpu: Do not wait for MP0_C2PMSG_33 IFWI init in SRIOV

Vijendar Mukunda (3):
      ASoC: SOF: amd: move iram-dram fence register programming sequence
      ASoC: SOF: amd: Fix for incorrect acp error register offsets
      ASoC: SOF: amd: Fix for acp init sequence

Volodymyr Babchuk (1):
      soc: qcom: cmd-db: Map shared memory as WC, not WB

Xu Yang (2):
      phy: fsl-imx8mq-usb: fix tuning parameter name
      usb: gadget: uvc: queue pump work in uvcg_video_enable()

Xueming Feng (1):
      tcp: fix forever orphan socket caused by tcp_abort

Yihang Li (1):
      scsi: sd: Ignore command SYNCHRONIZE CACHE error if format in progress

Yuntao Liu (1):
      ASoC: amd: acp: fix module autoloading

ZHANG Yuntian (1):
      USB: serial: option: add MeiG Smart SRM825L

Zack Rusin (3):
      drm/vmwgfx: Prevent unmapping active read buffers
      drm/vmwgfx: Fix prime with external buffers
      drm/vmwgfx: Disable coherent dumb buffers without 3d

Zijun Hu (1):
      usb: core: sysfs: Unmerge @usb3_hardware_lpm_attr_group in remove_power_attributes()



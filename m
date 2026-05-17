Return-Path: <stable+bounces-249108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIPOKeDhCWo6twQAu9opvQ
	(envelope-from <stable+bounces-249108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:42:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151D562107
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840143031AE9
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B5B3BB121;
	Sun, 17 May 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PoBBBgj5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF73BAD81;
	Sun, 17 May 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032378; cv=none; b=UUNbNflv4XnAO3hvPP3/0hBh/7D/5NHF7FW6Y4QcjzhhBajvKHGEGDhbG50uroL1hk5rSW9+IJJyz6Gnn8/39tCJeyeCpBZbwyyOFSDPJrRK83PzuI5/0fMm64BA40GgmmSYzVNS9PD1DkB2JDPom+8lQgkLwjO6oCA2zUKb2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032378; c=relaxed/simple;
	bh=UEtGl1TrDjyukdaReOvOR8puuLQJurkSuCzyd6RXil4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YRWaH9G+e8N2ty0uoBO0VNQ9/kMYZBxfRts0Mdf4qwhQslb2lkh5yNAF69GGBV/6GkuaCOfBS6qv9LnlH9QiakW/Qt1IJfSViU1BIsi/Z7lOAU7Qox93FjBOYOZGAkkZQURAOyBNqOJb4GPCqfftXYDEBj1ejbVBij+pn1psBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PoBBBgj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839C4C2BCB0;
	Sun, 17 May 2026 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779032377;
	bh=UEtGl1TrDjyukdaReOvOR8puuLQJurkSuCzyd6RXil4=;
	h=From:To:Cc:Subject:Date:From;
	b=PoBBBgj51+CHHO68c4JzotejZmeGdT9v95l+U5aeZS/BpeaPM+/zwSHHdOTw1wDVX
	 FEBW38J1h8MvaCl+U+k/JvSJwq5Am+HFbjULibBOU852J4xZkGwngGuahpqMjI4/kF
	 G7WgpjPDtFCc+tpuOxSqz6bXXbYdb9rBrVq1IdAo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.32
Date: Sun, 17 May 2026 17:39:37 +0200
Message-ID: <2026051737-armored-feminist-9bea@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3151D562107
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
	TAGGED_FROM(0.00)[bounces-249108-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

I'm announcing the release of the 6.18.32 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/media/rockchip,vdec.yaml  |   22 
 Makefile                                                    |    2 
 arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts          |   14 
 arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi         |    7 
 arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi |    2 
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi              |   24 
 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts      |    2 
 arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi       |    7 
 arch/arm64/boot/dts/qcom/lemans.dtsi                        |    8 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                     |    2 
 arch/loongarch/Kbuild                                       |    2 
 arch/loongarch/include/asm/asm-prototypes.h                 |   20 
 arch/loongarch/include/asm/kvm_host.h                       |    3 
 arch/loongarch/kvm/Makefile                                 |    3 
 arch/loongarch/kvm/main.c                                   |   35 -
 arch/loongarch/kvm/switch.S                                 |   20 
 arch/powerpc/platforms/pseries/papr-hvpipe.c                |   59 -
 block/blk-zoned.c                                           |  147 +---
 drivers/edac/versalnet_edac.c                               |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c            |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c                    |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                     |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                    |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                     |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                      |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c                  |   12 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                      |   31 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                       |    3 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                      |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                       |   25 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                       |   46 -
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                    |   33 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c       |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                       |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                        |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                   |   11 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           |    2 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c         |   13 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c        |   10 
 drivers/gpu/drm/bridge/tda998x_drv.c                        |    2 
 drivers/gpu/drm/drm_gem.c                                   |   25 
 drivers/gpu/drm/drm_gem_framebuffer_helper.c                |    4 
 drivers/gpu/drm/drm_gpusvm.c                                |    1 
 drivers/gpu/drm/exynos/exynos_drm_mic.c                     |    8 
 drivers/gpu/drm/i915/display/intel_psr.c                    |    2 
 drivers/gpu/drm/imx/ipuv3/parallel-display.c                |   15 
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c                      |    4 
 drivers/gpu/drm/msm/msm_drv.c                               |    7 
 drivers/gpu/drm/msm/msm_gpu.c                               |   42 -
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c              |    2 
 drivers/gpu/drm/panel/panel-himax-hx83102.c                 |    2 
 drivers/gpu/drm/radeon/ci_dpm.c                             |    9 
 drivers/gpu/drm/tiny/appletbdrm.c                           |    4 
 drivers/gpu/drm/udl/udl_main.c                              |    3 
 drivers/gpu/drm/udl/udl_modeset.c                           |    5 
 drivers/gpu/drm/xe/xe_bo.c                                  |    8 
 drivers/gpu/drm/xe/xe_dma_buf.c                             |   23 
 drivers/gpu/drm/xe/xe_vm_madvise.c                          |   47 +
 drivers/hid/hid-appletb-kbd.c                               |   56 +
 drivers/hid/hid-playstation.c                               |    6 
 drivers/hid/usbhid/hid-pidff.c                              |    7 
 drivers/media/common/videobuf2/videobuf2-dma-sg.c           |    1 
 drivers/media/dvb-frontends/dib8000.c                       |    4 
 drivers/media/i2c/imx283.c                                  |   15 
 drivers/media/i2c/imx412.c                                  |    2 
 drivers/media/i2c/ov08d10.c                                 |   21 
 drivers/media/i2c/ov8856.c                                  |   10 
 drivers/media/pci/intel/ipu6/ipu6.c                         |    2 
 drivers/media/pci/saa7164/saa7164-core.c                    |   47 +
 drivers/media/pci/zoran/zoran_card.c                        |    2 
 drivers/media/platform/chips-media/wave5/wave5-vdi.c        |    1 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c    |   14 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c        |    2 
 drivers/media/platform/qcom/camss/camss-csid-gen3.c         |    6 
 drivers/media/platform/qcom/camss/camss.c                   |   80 +-
 drivers/media/platform/qcom/iris/Kconfig                    |    2 
 drivers/media/platform/qcom/iris/iris_buffer.c              |    6 
 drivers/media/platform/qcom/iris/iris_hfi_queue.c           |    2 
 drivers/media/platform/qcom/iris/iris_vpu_buffer.h          |    2 
 drivers/media/platform/qcom/venus/Kconfig                   |    2 
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c          |   22 
 drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c         |   12 
 drivers/media/platform/renesas/vsp1/vsp1_drv.c              |    8 
 drivers/media/platform/ti/omap3isp/ispvideo.c               |    1 
 drivers/media/rc/streamzap.c                                |   12 
 drivers/media/rc/xbox_remote.c                              |    9 
 drivers/media/usb/uvc/uvc_queue.c                           |    3 
 drivers/platform/x86/hp/hp-wmi.c                            |    5 
 drivers/regulator/act8945a-regulator.c                      |    3 
 drivers/regulator/bd9571mwv-regulator.c                     |    3 
 drivers/regulator/bq257xx-regulator.c                       |    3 
 drivers/regulator/max77650-regulator.c                      |    2 
 drivers/regulator/mt6357-regulator.c                        |    2 
 drivers/regulator/rk808-regulator.c                         |    3 
 drivers/regulator/s2dos05-regulator.c                       |    2 
 drivers/spi/spi-amlogic-spisg.c                             |    4 
 drivers/spi/spi-aspeed-smc.c                                |    9 
 drivers/spi/spi-at91-usart.c                                |    8 
 drivers/spi/spi-atmel.c                                     |    8 
 drivers/spi/spi-bcm63xx.c                                   |    8 
 drivers/spi/spi-bcmbca-hsspi.c                              |    4 
 drivers/spi/spi-cadence.c                                   |   21 
 drivers/spi/spi-cavium-thunderx.c                           |    8 
 drivers/spi/spi-ch341.c                                     |    7 
 drivers/spi/spi-coldfire-qspi.c                             |   10 
 drivers/spi/spi-dln2.c                                      |    8 
 drivers/spi/spi-fsl-espi.c                                  |   10 
 drivers/spi/spi-fsl-spi.c                                   |   14 
 drivers/spi/spi-img-spfi.c                                  |    8 
 drivers/spi/spi-imx.c                                       |    1 
 drivers/spi/spi-lantiq-ssc.c                                |    8 
 drivers/spi/spi-meson-spicc.c                               |    8 
 drivers/spi/spi-mpc52xx.c                                   |    9 
 drivers/spi/spi-mpfs.c                                      |    4 
 drivers/spi/spi-mt65xx.c                                    |    4 
 drivers/spi/spi-mtk-nor.c                                   |    4 
 drivers/spi/spi-mxic.c                                      |    3 
 drivers/spi/spi-mxs.c                                       |    8 
 drivers/spi/spi-npcm-pspi.c                                 |    8 
 drivers/spi/spi-omap2-mcspi.c                               |    8 
 drivers/spi/spi-orion.c                                     |   16 
 drivers/spi/spi-pic32-sqi.c                                 |    8 
 drivers/spi/spi-pic32.c                                     |   11 
 drivers/spi/spi-pl022.c                                     |    8 
 drivers/spi/spi-qup.c                                       |    8 
 drivers/spi/spi-rspi.c                                      |   10 
 drivers/spi/spi-s3c64xx.c                                   |    4 
 drivers/spi/spi-sh-hspi.c                                   |   10 
 drivers/spi/spi-sh-msiof.c                                  |   10 
 drivers/spi/spi-slave-mt27xx.c                              |   10 
 drivers/spi/spi-sprd.c                                      |    8 
 drivers/spi/spi-st-ssc4.c                                   |    8 
 drivers/spi/spi-tegra114.c                                  |    8 
 drivers/spi/spi-tegra20-sflash.c                            |    8 
 drivers/spi/spi-uniphier.c                                  |   24 
 drivers/spi/spi-zynq-qspi.c                                 |   55 -
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c           |    4 
 drivers/staging/media/imx/imx-media-csi.c                   |   40 -
 drivers/usb/dwc3/core.c                                     |  204 ++---
 drivers/usb/dwc3/core.h                                     |   10 
 drivers/usb/dwc3/debugfs.c                                  |   44 -
 drivers/usb/dwc3/drd.c                                      |   76 +-
 drivers/usb/dwc3/ep0.c                                      |   20 
 drivers/usb/dwc3/gadget.c                                   |  162 ++--
 drivers/usb/dwc3/gadget.h                                   |    4 
 drivers/usb/dwc3/io.h                                       |    7 
 drivers/usb/dwc3/ulpi.c                                     |   10 
 drivers/usb/typec/tcpm/tcpm.c                               |    2 
 drivers/video/fbdev/core/bitblit.c                          |  122 +--
 drivers/video/fbdev/core/fbcon.c                            |  419 +++++-------
 drivers/video/fbdev/core/fbcon.h                            |    6 
 drivers/video/fbdev/core/fbcon_ccw.c                        |  146 ++--
 drivers/video/fbdev/core/fbcon_cw.c                         |  146 ++--
 drivers/video/fbdev/core/fbcon_rotate.c                     |   43 -
 drivers/video/fbdev/core/fbcon_rotate.h                     |    6 
 drivers/video/fbdev/core/fbcon_ud.c                         |  162 ++--
 drivers/video/fbdev/core/softcursor.c                       |   18 
 drivers/video/fbdev/core/tileblit.c                         |   28 
 fs/btrfs/ioctl.c                                            |    5 
 fs/btrfs/space-info.c                                       |    8 
 fs/btrfs/sysfs.c                                            |    5 
 fs/btrfs/sysfs.h                                            |    3 
 include/linux/damon.h                                       |    1 
 include/linux/fprobe.h                                      |    3 
 include/linux/sched/ext.h                                   |    1 
 io_uring/zcrx.c                                             |   17 
 kernel/sched/ext.c                                          |   23 
 kernel/sched/ext_internal.h                                 |   13 
 kernel/trace/fprobe.c                                       |  366 +++++++---
 mm/damon/core.c                                             |   25 
 mm/damon/lru_sort.c                                         |   83 +-
 mm/damon/reclaim.c                                          |   83 +-
 net/batman-adv/bat_iv_ogm.c                                 |   85 +-
 net/batman-adv/bridge_loop_avoidance.c                      |   11 
 net/batman-adv/main.c                                       |    1 
 net/batman-adv/tp_meter.c                                   |  116 ++-
 net/batman-adv/tp_meter.h                                   |    1 
 net/batman-adv/types.h                                      |    4 
 net/bluetooth/hci_conn.c                                    |   19 
 net/sctp/socket.c                                           |    9 
 net/vmw_vsock/af_vsock.c                                    |    6 
 net/vmw_vsock/virtio_transport_common.c                     |   55 -
 183 files changed, 2596 insertions(+), 1656 deletions(-)

Abdun Nihaal (1):
      media: pci: zoran: fix potential memory leak in zoran_probe()

Alex Deucher (4):
      drm/radeon: add missing revision check for CI
      drm/amdgpu/pm: add missing revision check for CI
      drm/amdgpu/pm: align Hawaii mclk workaround with radeon
      drm/amdgpu: rework how we handle TLB fences

Alexander Koskovich (1):
      media: i2c: ov8856: free control handler on error in ov8856_init_controls()

Alysa Liu (2):
      drm/amdkfd: Add upper bound check for num_of_nodes
      drm/amdkfd: validate SVM ioctl nattr against buffer size

Amir Shetaia (1):
      drm/amdkfd: Clear VRAM on allocation to prevent stale data exposure

Amit Sunil Dhamne (1):
      usb: typec: tcpm: reset internal port states on soft reset AMS

Anna Maniscalco (1):
      drm/msm: always recover the gpu

Arnd Bergmann (2):
      media: iris: fix QCOM_MDT_LOADER dependency
      media: venus: fix QCOM_MDT_LOADER dependency

Ashutosh Desai (1):
      drm/gem: Fix inconsistent plane dimension calculation in drm_gem_fb_init_with_funcs()

Ben Morris (1):
      sctp: revalidate list cursor after sctp_sendmsg_to_asoc() in SCTP_SENDALL

Benjamin Cheng (7):
      drm/amdgpu: Add bounds checking to ib_{get,set}_value
      drm/amdgpu/vcn4: Prevent OOB reads when parsing IB
      drm/amdgpu/vce: Prevent partial address patches
      drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg
      drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg
      drm/amdgpu/vcn3: Avoid overflow on msg bound check
      drm/amdgpu/vcn4: Avoid overflow on msg bound check

Chenglei Xie (1):
      drm/amdgpu: gate VM CPU HDP flush on reset lock

Christian Brauner (1):
      papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()

Cristian Ciocaltea (2):
      media: dt-bindings: rockchip,vdec: Add alternative reg-names order for RK35{76,88}
      media: dt-bindings: rockchip,vdec: Mark reg-names required for RK35{76,88}

Damien Le Moal (1):
      block: fix zone write plug removal

David Carlier (1):
      Bluetooth: hci_conn: fix potential UAF in create_big_sync

Dikshita Agarwal (1):
      media: iris: Fix use-after-free in iris_release_internal_buffers()

Dmitry Baryshkov (1):
      media: qcom: iris: increase H265D_MAX_SLICE to fix H.265 decoding on SC7280

Dudu Lu (1):
      vsock/virtio: fix accept queue count leak on transport mismatch

Ethan Tidmore (1):
      media: intel/ipu6: fix error pointer dereference

Felix Kuehling (1):
      drm/amdkfd: Make all TLB-flushes heavy-weight

Filipe Manana (1):
      btrfs: remove fs_info argument from btrfs_sysfs_add_space_info_type()

Francis, David (1):
      drm: Set old handle to NULL before prime swap in change_handle

Greg Kroah-Hartman (1):
      Linux 6.18.32

Gregor Herburger (2):
      arm64: dts: broadcom: bcm2712-d-rpi-5-b: add fixes for pinctrl/pinctrl_aon
      arm64: dts: broadcom: bcm2712-d-rpi-5-b: update uart10 interrupt

Guangshuo Li (1):
      btrfs: fix double free in create_space_info_sub_group() error path

Guoniu Zhou (1):
      media: nxp: imx8-isi: Reduce minimum queued buffers from 2 to 0

Haoxiang Li (2):
      media: chips-media: wave5: fix a potential memory leak in wave5_vdi_init()
      media: omap3isp: drop the use count of v4l2 pipeline

Icenowy Zheng (2):
      drm/panel: himax-hx83102: restore MODE_LPM after sending disable cmds
      drm/panel: boe-tv101wum-nl6: restore MODE_LPM after sending disable cmds

Jai Luthra (2):
      media: i2c: imx283: Enter full standby when stopping streaming
      media: i2c: imx283: Fix hang when going from large to small resolution

Janne Grunau (1):
      media: videobuf2: Set vma_flags in vb2_dma_sg_mmap

Jia Yao (1):
      drm/xe/uapi: Reject coh_none PAT index for CPU cached memory in madvise

Jiexun Wang (3):
      batman-adv: reject new tp_meter sessions during teardown
      batman-adv: stop tp_meter sessions during mesh teardown
      batman-adv: stop caching unowned originator pointers in BAT IV

Johan Hovold (54):
      spi: bcm63xx: fix controller deregistration
      spi: atmel: fix controller deregistration
      regulator: mt6357: fix OF node reference imbalance
      spi: st-ssc4: fix controller deregistration
      regulator: max77650: fix OF node reference imbalance
      regulator: bq257xx: fix OF node reference imbalance
      regulator: rk808: fix OF node reference imbalance
      regulator: act8945a: fix OF node reference imbalance
      regulator: s2dos05: fix OF node reference imbalance
      regulator: bd9571mwv: fix OF node reference imbalance
      spi: lantiq-ssc: fix controller deregistration
      spi: meson-spicc: fix controller deregistration
      spi: qup: fix controller deregistration
      spi: at91-usart: fix controller deregistration
      spi: amlogic-spisg: fix controller deregistration
      spi: aspeed-smc: fix controller deregistration
      spi: mxs: fix controller deregistration
      spi: mt65xx: fix controller deregistration
      spi: dln2: fix controller deregistration
      spi: s3c64xx: fix controller deregistration
      spi: fsl-espi: fix controller deregistration
      spi: omap2-mcspi: fix controller deregistration
      spi: pic32: fix controller deregistration
      spi: mtk-nor: fix controller deregistration
      spi: pl022: fix controller deregistration
      spi: ch341: fix devres lifetime
      spi: sh-hspi: fix controller deregistration
      spi: fsl: fix controller deregistration
      spi: bcmbca-hsspi: fix controller deregistration
      spi: coldfire-qspi: fix controller deregistration
      spi: npcm-pspi: fix controller deregistration
      spi: cavium-thunderx: fix controller deregistration
      spi: pic32-sqi: fix controller deregistration
      spi: sprd: fix controller deregistration
      spi: rspi: fix controller deregistration
      spi: sh-msiof: fix controller deregistration
      spi: slave-mt27xx: fix controller deregistration
      spi: img-spfi: fix controller deregistration
      spi: mpfs: fix controller deregistration
      spi: imx: fix runtime pm leak on probe deferral
      spi: mxic: fix controller deregistration
      spi: orion: fix controller deregistration
      spi: orion: fix runtime pm leak on unbind
      spi: orion: fix clock imbalance on registration failure
      spi: mpc52xx: fix use-after-free on registration failure
      spi: mpc52xx: fix controller deregistration
      spi: mpc52xx: fix use-after-free on unbind
      spi: cadence: fix controller deregistration
      spi: cadence: fix unclocked access on unbind
      spi: cadence: fix clock imbalance on probe failure
      spi: uniphier: fix controller deregistration
      spi: tegra20-sflash: fix controller deregistration
      spi: tegra114: fix controller deregistration
      spi: zynq-qspi: fix controller deregistration

John B. Moore (2):
      drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check in KIQ
      drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fence emission

Josua Mayer (1):
      arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix usd-cd & gpio pinmux

Jouni Högander (1):
      drm/i915/psr: Init variable to avoid early exit from et alignment loop

Kory Maincent (TI) (1):
      drm/bridge: tda998x: Use __be32 for audio port OF property pointer

Krishna Chomal (1):
      platform/x86: hp-wmi: Ignore backlight and FnLock events

Krzysztof Kozlowski (1):
      drm/msm/hdmi: Fix wrong CTRL1 register used in writing info frames

Luigi Leonardi (1):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy

Lyes Bourennani (1):
      batman-adv: fix integer overflow on buff_pos

Marek Vasut (1):
      drm/imx: parallel-display: Prefer bus format set via legacy "interface-pix-fmt" DT property

Mario Kleiner (1):
      drm/amd/display: Change dither policy for 10 bpc output back to dithering

Masami Hiramatsu (Google) (2):
      tracing/fprobe: Unregister fprobe even if memory allocation fails
      tracing/fprobe: Remove fprobe from hash in failure path

Matthew Brost (1):
      drm/gpusvm: Force unmapping on error in drm_gpusvm_get_pages

Matthias Fend (2):
      media: i2c: ov08d10: fix image vertical start setting
      media: i2c: ov08d10: fix runtime PM handling in probe

Menglong Dong (2):
      tracing: fprobe: use rhltable for fprobe_ip_table
      tracing: fprobe: optimization for entry only case

Michael Tretter (1):
      media: staging: imx: request mbus_config in csi_start

Norbert Szetei (1):
      vsock: fix buffer size clamping order

Oliver Neukum (2):
      media: rc: xbox_remote: heed DMA restrictions
      media: rc: streamzap: Error handling in probe

Osama Abdelkader (1):
      drm/exynos: remove bridge when component_add fails

Pavel Begunkov (2):
      io_uring/zcrx: use guards for locking
      io_uring/zcrx: warn on freelist violations

Pei Xiao (2):
      spi: uniphier: Simplify clock handling with devm_clk_get_enabled()
      spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()

Philip Yang (1):
      drm/amdgpu: zero-initialize GART table on allocation

Prasanna Kumar T S M (1):
      EDAC/versalnet: Fix device name memory leak

Prashanth K (2):
      usb: dwc3: Remove of dep->regs
      usb: dwc3: Add dwc pointer to dwc3_readl/writel

Prike Liang (2):
      drm/amdgpu: validate the flush_gpu_tlb_pasid()
      Revert "drm/amdgpu: don't attach the tlb fence for SI"

Ramalingeswara Reddy, Kanala (1):
      drm/amdgpu: Use SMUIO 15.0.0 offsets for TSC upper and lower count.

Ricardo Ribalda (1):
      media: uvcvideo: Enable VB2_DMABUF for metadata stream

Ritesh Harjani (IBM) (1):
      pseries/papr-hvpipe: Fix race with interrupt handler

Sakari Ailus (1):
      staging: media: atomisp: Disallow all private IOCTLs

Sangyun Kim (2):
      HID: appletb-kbd: fix UAF in inactivity-timer cleanup path
      HID: appletb-kbd: run inactivity autodim from workqueues

Sasha Finkelstein (1):
      drm/appletbdrm: Use kvzalloc for big allocations

Selvarasu Ganesan (1):
      usb: dwc3: Move GUID programming after PHY initialization

SeongJae Park (4):
      mm/damon/core: implement damon_kdamond_pid()
      mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
      mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
      mm/damon/core: disallow time-quota setting zero esz

Sergey Shtylyov (1):
      media: dib8000: avoid division by 0 in dib8000_set_dds()

Shixiong Ou (1):
      drm/udl: Increase GET_URB_TIMEOUT

Shuicheng Lin (4):
      drm/xe: Fix bo leak in xe_dma_buf_init_obj() on allocation failure
      drm/xe/bo: Fix bo leak on GGTT flag validation in xe_bo_init_locked()
      drm/xe: Fix dma-buf attachment leak in xe_gem_prime_import()
      drm/xe/bo: Fix bo leak on unaligned size validation in xe_bo_init_locked()

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-am62a7-sk: Fix pin name in comment from M19 to N22

Stefano Garzarella (2):
      vsock/virtio: fix length and offset in tap skb for split packets
      vsock/virtio: fix empty payload in tap skb for non-linear buffers

Sven Eckelmann (4):
      batman-adv: bla: prevent use-after-free when deleting claims
      batman-adv: bla: only purge non-released claims
      batman-adv: bla: put backbone reference on failed claim hash insert
      batman-adv: tp_meter: fix tp_num leak on kmalloc failure

T.J. Mercier (1):
      HID: playstation: Clamp num_touch_reports

Tejun Heo (1):
      sched_ext: Read scx_root under scx_cgroup_ops_rwsem in cgroup setters

Thomas Fourier (1):
      media: iris: Fix dma_free_attrs() size in iris_hfi_queues_init()

Thomas Zimmermann (2):
      fbcon: Rename struct fbcon_ops to struct fbcon_par
      fbcon: Avoid OOB font access if console rotation fails

Timur Kristóf (1):
      drm/amdgpu: Fix validating flush_gpu_tlb_pasid()

Tomasz Pakuła (1):
      HID: pidff: Fix integer overflow in pidff_rescale

Tomi Valkeinen (2):
      media: renesas: vsp1: Fix NULL pointer deref on module unload
      media: renesas: vin: Fix RAW8 (again)

Viken Dadhaniya (1):
      arm64: dts: qcom: lemans: Correct QUP interrupt numbers

Wang Jun (1):
      media: saa7164: add ioremap return checks and cleanups

Wenmeng Liu (4):
      media: i2c: imx412: Assert reset GPIO during probe
      media: qcom: camss: Fix csid clock configuration for sa8775p
      media: qcom: camss: Fix csid IRQ offset for sa8775p
      media: qcom: camss: Add missing clocks for VFE lite on sa8775p

Xianglai Li (1):
      LoongArch: KVM: Compile switch.S directly into the kernel

Yang Wang (1):
      drm/amd/pm: fix incorrect FeatureCtrlMask setting on smu v14.0.x

Yasuaki Torimaru (1):
      drm/msm/gem: fix error handling in msm_ioctl_gem_info_get_metadata()

Yochai Eisenrich (1):
      btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which can lead to info-leak

Ziyi Guo (2):
      media: chips-media: wave5: add missing spinlock protection for send_eos_event()
      media: chips-media: wave5: add missing spinlock protection for handle_dynamic_resolution_change()

zhidao su (1):
      sched/ext: Implement cgroup_set_idle() callback



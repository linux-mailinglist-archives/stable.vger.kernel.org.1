Return-Path: <stable+bounces-249111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHfAGkPiCWokuAQAu9opvQ
	(envelope-from <stable+bounces-249111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:44:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B710056214C
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DA8A304928E
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D433C0A0C;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yht3cJoF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863163BFAD3;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032389; cv=none; b=KaZhjpuYT+aqFZOQkNpVPDvKOBNh5KU3n8xcG703kJp5sOKF/WLK0n9CEfaZ8C9Oa4Y+fJWa5Zi2EOegouxiO4XSU0eLQsYTqj7xqJa/Rr8hPSGvsG5fR7FbRyGLiBf9OBvZF2kvsb58t0Z+viGYJyC2bcSxGdY4s19xn/3GLds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032389; c=relaxed/simple;
	bh=18Sfd5gtvc7EagWNaYAgrjv7VtRY1cEBmnJvKh5PV9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TNrjQ0pSjtCC0xnYXaToNQ/bcoQlM1Vs0JFha5MIy19vc7O3LWY/ii4LvS7smw9NiW8m7fQQHeI/dnmC39MdMy16r1v5JEgut63jSDpPvBvY5NoYuRhoaOQC7hZlg0SSIfYYmtaHL/iGAr8NMD/wXhit8F5+Vh+pC2VMn3vbLKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yht3cJoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28ADC2BCF6;
	Sun, 17 May 2026 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779032389;
	bh=18Sfd5gtvc7EagWNaYAgrjv7VtRY1cEBmnJvKh5PV9o=;
	h=From:To:Cc:Subject:Date:From;
	b=Yht3cJoFb1njCCa6OV65ZkDbu0RXTwKzMOnYTMl5Atc4Vkhr1J7twpNkgYs2Mb0rF
	 ur6rWeDcqvgLKUESxYWcf9df0Rx2gAbQcsAYs5hLMOdKoi7bkQVp9iutc/qK9EuMMD
	 rZxzcMMA3mD6ggoc+0N/4n6YWOjAqIf0zpXbeDOc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.0.9
Date: Sun, 17 May 2026 17:39:42 +0200
Message-ID: <2026051743-alienate-rubbing-8458@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B710056214C
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
	TAGGED_FROM(0.00)[bounces-249111-lists,stable=lfdr.de];
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

I'm announcing the release of the 7.0.9 kernel.

All users of the 7.0 kernel series must upgrade.

The updated 7.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/media/rockchip,vdec.yaml                                 |   22 
 Makefile                                                                                   |    2 
 arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts                                         |   14 
 arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi                                        |    7 
 arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi                                |    2 
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi                                             |   24 
 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts                                     |    2 
 arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi                                      |    7 
 arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi                                     |    1 
 arch/arm64/boot/dts/qcom/kodiak.dtsi                                                       |    2 
 arch/arm64/boot/dts/qcom/lemans.dtsi                                                       |    8 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                                                    |    2 
 arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts                                           |    2 
 arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts                                              |    2 
 drivers/edac/versalnet_edac.c                                                              |  170 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                                           |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                                 |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c                                                   |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                                                   |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                                                    |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c                                                 |   12 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                                     |   31 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                                      |    3 
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c                                                 |   95 +--
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c                                                   |    9 
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c                                                     |    1 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                                                     |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                                      |   25 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                                      |   46 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                                   |   33 +
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c                                      |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                                      |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                                       |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                                                  |   11 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                                          |    2 
 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.c |    2 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c                                        |   13 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c                                       |   10 
 drivers/gpu/drm/bridge/tda998x_drv.c                                                       |    2 
 drivers/gpu/drm/drm_atomic.c                                                               |    7 
 drivers/gpu/drm/drm_colorop.c                                                              |   28 -
 drivers/gpu/drm/drm_gem.c                                                                  |   25 
 drivers/gpu/drm/drm_gem_framebuffer_helper.c                                               |    4 
 drivers/gpu/drm/drm_gpusvm.c                                                               |    3 
 drivers/gpu/drm/exynos/exynos_drm_mic.c                                                    |    8 
 drivers/gpu/drm/i915/display/intel_psr.c                                                   |    2 
 drivers/gpu/drm/imx/ipuv3/parallel-display.c                                               |   15 
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c                                                     |    4 
 drivers/gpu/drm/msm/msm_drv.c                                                              |    7 
 drivers/gpu/drm/msm/msm_gpu.c                                                              |   42 -
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c                                             |    2 
 drivers/gpu/drm/panel/panel-himax-hx83102.c                                                |    2 
 drivers/gpu/drm/radeon/ci_dpm.c                                                            |    9 
 drivers/gpu/drm/sti/sti_hda.c                                                              |    8 
 drivers/gpu/drm/tiny/appletbdrm.c                                                          |    4 
 drivers/gpu/drm/udl/udl_main.c                                                             |    3 
 drivers/gpu/drm/udl/udl_modeset.c                                                          |    5 
 drivers/gpu/drm/v3d/v3d_submit.c                                                           |    5 
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c                                                   |   12 
 drivers/gpu/drm/xe/xe_bo.c                                                                 |    8 
 drivers/gpu/drm/xe/xe_dma_buf.c                                                            |   23 
 drivers/gpu/drm/xe/xe_vm_madvise.c                                                         |   47 +
 drivers/hid/hid-appletb-kbd.c                                                              |   56 +-
 drivers/hid/hid-playstation.c                                                              |    6 
 drivers/hid/usbhid/hid-pidff.c                                                             |    7 
 drivers/media/common/videobuf2/videobuf2-dma-sg.c                                          |    1 
 drivers/media/dvb-frontends/dib8000.c                                                      |    4 
 drivers/media/i2c/imx283.c                                                                 |   15 
 drivers/media/i2c/imx412.c                                                                 |    2 
 drivers/media/i2c/ov08d10.c                                                                |   21 
 drivers/media/i2c/ov5647.c                                                                 |   12 
 drivers/media/i2c/ov8856.c                                                                 |   10 
 drivers/media/pci/intel/ipu-bridge.c                                                       |   14 
 drivers/media/pci/intel/ipu6/ipu6.c                                                        |    2 
 drivers/media/pci/saa7164/saa7164-core.c                                                   |   47 +
 drivers/media/pci/zoran/zoran_card.c                                                       |    2 
 drivers/media/platform/arm/mali-c55/mali-c55-common.h                                      |    2 
 drivers/media/platform/arm/mali-c55/mali-c55-core.c                                        |   35 -
 drivers/media/platform/arm/mali-c55/mali-c55-isp.c                                         |   37 -
 drivers/media/platform/arm/mali-c55/mali-c55-params.c                                      |  122 ++++
 drivers/media/platform/arm/mali-c55/mali-c55-registers.h                                   |    4 
 drivers/media/platform/chips-media/wave5/wave5-vdi.c                                       |    1 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c                                   |   14 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c                                       |    2 
 drivers/media/platform/qcom/camss/camss-csid-gen3.c                                        |    6 
 drivers/media/platform/qcom/camss/camss.c                                                  |   80 +--
 drivers/media/platform/qcom/iris/Kconfig                                                   |    2 
 drivers/media/platform/qcom/iris/iris_buffer.c                                             |    6 
 drivers/media/platform/qcom/iris/iris_core.c                                               |    4 
 drivers/media/platform/qcom/iris/iris_hfi_common.c                                         |    4 
 drivers/media/platform/qcom/iris/iris_hfi_queue.c                                          |    2 
 drivers/media/platform/qcom/iris/iris_vdec.c                                               |    6 
 drivers/media/platform/qcom/iris/iris_vdec.h                                               |    1 
 drivers/media/platform/qcom/iris/iris_venc.c                                               |    6 
 drivers/media/platform/qcom/iris/iris_venc.h                                               |    1 
 drivers/media/platform/qcom/iris/iris_vidc.c                                               |    6 
 drivers/media/platform/qcom/iris/iris_vpu2.c                                               |    1 
 drivers/media/platform/qcom/iris/iris_vpu3x.c                                              |    9 
 drivers/media/platform/qcom/iris/iris_vpu4x.c                                              |   24 
 drivers/media/platform/qcom/iris/iris_vpu_buffer.h                                         |    2 
 drivers/media/platform/qcom/iris/iris_vpu_common.c                                         |   16 
 drivers/media/platform/qcom/iris/iris_vpu_common.h                                         |    3 
 drivers/media/platform/qcom/venus/Kconfig                                                  |    2 
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c                                         |   22 
 drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c                                        |   12 
 drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc-video.c                                 |   35 -
 drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc.h                                       |    8 
 drivers/media/platform/renesas/vsp1/vsp1_drv.c                                             |    8 
 drivers/media/platform/rockchip/rkcif/rkcif-interface.c                                    |    3 
 drivers/media/platform/rockchip/rkcif/rkcif-stream.c                                       |    2 
 drivers/media/platform/ti/omap3isp/ispvideo.c                                              |    1 
 drivers/media/platform/ti/vpe/vip.c                                                        |    1 
 drivers/media/rc/streamzap.c                                                               |   12 
 drivers/media/rc/xbox_remote.c                                                             |    9 
 drivers/media/usb/uvc/uvc_queue.c                                                          |    3 
 drivers/platform/x86/hp/hp-wmi.c                                                           |    5 
 drivers/regulator/act8945a-regulator.c                                                     |    3 
 drivers/regulator/bd9571mwv-regulator.c                                                    |    3 
 drivers/regulator/bq257xx-regulator.c                                                      |    3 
 drivers/regulator/max77650-regulator.c                                                     |    2 
 drivers/regulator/mt6357-regulator.c                                                       |    2 
 drivers/regulator/rk808-regulator.c                                                        |    3 
 drivers/regulator/s2dos05-regulator.c                                                      |    2 
 drivers/spi/spi-amlogic-spisg.c                                                            |    4 
 drivers/spi/spi-aspeed-smc.c                                                               |    9 
 drivers/spi/spi-at91-usart.c                                                               |    8 
 drivers/spi/spi-atmel.c                                                                    |    8 
 drivers/spi/spi-bcm63xx.c                                                                  |    8 
 drivers/spi/spi-bcmbca-hsspi.c                                                             |    4 
 drivers/spi/spi-cadence-quadspi.c                                                          |   40 -
 drivers/spi/spi-cadence.c                                                                  |   21 
 drivers/spi/spi-cavium-octeon.c                                                            |    8 
 drivers/spi/spi-cavium-thunderx.c                                                          |    8 
 drivers/spi/spi-ch341.c                                                                    |    7 
 drivers/spi/spi-coldfire-qspi.c                                                            |   10 
 drivers/spi/spi-dln2.c                                                                     |    8 
 drivers/spi/spi-ep93xx.c                                                                   |    8 
 drivers/spi/spi-fsl-espi.c                                                                 |   10 
 drivers/spi/spi-fsl-spi.c                                                                  |   14 
 drivers/spi/spi-img-spfi.c                                                                 |    8 
 drivers/spi/spi-imx.c                                                                      |    1 
 drivers/spi/spi-lantiq-ssc.c                                                               |    8 
 drivers/spi/spi-meson-spicc.c                                                              |    8 
 drivers/spi/spi-mpc52xx.c                                                                  |    9 
 drivers/spi/spi-mpfs.c                                                                     |    4 
 drivers/spi/spi-mt65xx.c                                                                   |    4 
 drivers/spi/spi-mtk-nor.c                                                                  |    4 
 drivers/spi/spi-mxic.c                                                                     |    3 
 drivers/spi/spi-mxs.c                                                                      |    8 
 drivers/spi/spi-npcm-pspi.c                                                                |    8 
 drivers/spi/spi-omap2-mcspi.c                                                              |    8 
 drivers/spi/spi-orion.c                                                                    |   16 
 drivers/spi/spi-pic32-sqi.c                                                                |    8 
 drivers/spi/spi-pic32.c                                                                    |   11 
 drivers/spi/spi-pl022.c                                                                    |    8 
 drivers/spi/spi-qup.c                                                                      |    8 
 drivers/spi/spi-rspi.c                                                                     |   10 
 drivers/spi/spi-s3c64xx.c                                                                  |    4 
 drivers/spi/spi-sh-hspi.c                                                                  |   10 
 drivers/spi/spi-sh-msiof.c                                                                 |   10 
 drivers/spi/spi-slave-mt27xx.c                                                             |   10 
 drivers/spi/spi-sprd.c                                                                     |    8 
 drivers/spi/spi-st-ssc4.c                                                                  |    8 
 drivers/spi/spi-uniphier.c                                                                 |   24 
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c                                          |    4 
 drivers/staging/media/imx/imx-media-csi.c                                                  |   40 -
 drivers/usb/typec/tcpm/tcpm.c                                                              |    2 
 include/linux/cgroup-defs.h                                                                |    4 
 include/linux/mm.h                                                                         |    2 
 io_uring/zcrx.c                                                                            |   17 
 kernel/cgroup/cgroup.c                                                                     |  254 ++++------
 kernel/liveupdate/kexec_handover.c                                                         |   13 
 kernel/sched/ext.c                                                                         |   12 
 mm/util.c                                                                                  |   51 +-
 mm/vma.c                                                                                   |    3 
 net/batman-adv/bat_iv_ogm.c                                                                |   85 ++-
 net/batman-adv/bridge_loop_avoidance.c                                                     |   11 
 net/batman-adv/main.c                                                                      |    1 
 net/batman-adv/tp_meter.c                                                                  |  116 +++-
 net/batman-adv/tp_meter.h                                                                  |    1 
 net/batman-adv/types.h                                                                     |    4 
 net/sctp/socket.c                                                                          |    9 
 net/vmw_vsock/af_vsock.c                                                                   |    6 
 net/vmw_vsock/virtio_transport_common.c                                                    |   55 --
 tools/perf/pmu-events/Build                                                                |    4 
 tools/testing/vma/include/dup.h                                                            |   41 -
 tools/testing/vma/include/stubs.h                                                          |    3 
 187 files changed, 1815 insertions(+), 937 deletions(-)

Abdun Nihaal (1):
      media: pci: zoran: fix potential memory leak in zoran_probe()

Alex Deucher (3):
      drm/radeon: add missing revision check for CI
      drm/amdgpu/pm: add missing revision check for CI
      drm/amdgpu/pm: align Hawaii mclk workaround with radeon

Alexander Koskovich (1):
      media: i2c: ov8856: free control handler on error in ov8856_init_controls()

Alysa Liu (2):
      drm/amdkfd: Add upper bound check for num_of_nodes
      drm/amdkfd: validate SVM ioctl nattr against buffer size

Amir Shetaia (1):
      drm/amdkfd: Clear VRAM on allocation to prevent stale data exposure

Amit Sunil Dhamne (1):
      usb: typec: tcpm: reset internal port states on soft reset AMS

Andrea Righi (1):
      sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation

Anna Maniscalco (1):
      drm/msm: always recover the gpu

Arnd Bergmann (2):
      media: iris: fix QCOM_MDT_LOADER dependency
      media: venus: fix QCOM_MDT_LOADER dependency

Ashutosh Desai (2):
      drm/v3d: Reject empty multisync extension to prevent infinite loop
      drm/gem: Fix inconsistent plane dimension calculation in drm_gem_fb_init_with_funcs()

Barnabás Pőcze (3):
      media: rzv2h-ivc: Write AXIRX_PIXFMT once
      media: rzv2h-ivc: Fix FM_STOP register write
      media: rzv2h-ivc: Fix concurrent buffer list access

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

Breno Leitao (1):
      kho: fix error handling in kho_add_subtree()

Chaitanya Kumar Borah (2):
      drm/colorop: Preserve bypass value in duplicate_state()
      drm/atomic: Add affected colorops with affected planes

Chenglei Xie (1):
      drm/amdgpu: gate VM CPU HDP flush on reset lock

Cristian Ciocaltea (2):
      media: dt-bindings: rockchip,vdec: Add alternative reg-names order for RK35{76,88}
      media: dt-bindings: rockchip,vdec: Mark reg-names required for RK35{76,88}

Dang Huynh (1):
      media: rockchip: rkcif: Add missing MUST_CONNECT flag to pads

Daniel Scally (1):
      media: mali-c55: Fix Iridix bypass macros

Dikshita Agarwal (1):
      media: iris: Fix use-after-free in iris_release_internal_buffers()

Dmitry Baryshkov (1):
      media: qcom: iris: increase H265D_MAX_SLICE to fix H.265 decoding on SC7280

Dudu Lu (1):
      vsock/virtio: fix accept queue count leak on transport mismatch

Emanuele Ghidoli (1):
      arm64: dts: freescale: imx95-toradex-smarc: fix PMIC_SD2_VSEL label position

Ethan Tidmore (1):
      media: intel/ipu6: fix error pointer dereference

Felix Gu (1):
      media: ti: vpe: Add missing v4l2_device_unregister in vip_remove()

Felix Kuehling (1):
      drm/amdkfd: Make all TLB-flushes heavy-weight

Francis, David (1):
      drm: Set old handle to NULL before prime swap in change_handle

Franz Schnyder (2):
      arm64: dts: ti: k3-am69-aquila-clover: Fix DP regulator enable GPIO
      arm64: dts: ti: k3-am69-aquila-dev: Fix DP regulator enable GPIO

Greg Kroah-Hartman (1):
      Linux 7.0.9

Gregor Herburger (2):
      arm64: dts: broadcom: bcm2712-d-rpi-5-b: add fixes for pinctrl/pinctrl_aon
      arm64: dts: broadcom: bcm2712-d-rpi-5-b: update uart10 interrupt

Guoniu Zhou (1):
      media: nxp: imx8-isi: Reduce minimum queued buffers from 2 to 0

Gustavo Sousa (1):
      drm/xe/hdcp: Add NULL check for media_gt in intel_hdcp_gsc_check_status()

Hans de Goede (1):
      media: ipu-bridge: Add upside-down sensor DMI quirk for Dell XPS 13 9340 and XPS 14 9440

Haoxiang Li (2):
      media: chips-media: wave5: fix a potential memory leak in wave5_vdi_init()
      media: omap3isp: drop the use count of v4l2 pipeline

Harry Wentland (1):
      drm/colorop: Fix blob property reference tracking in state lifecycle

Icenowy Zheng (2):
      drm/panel: himax-hx83102: restore MODE_LPM after sending disable cmds
      drm/panel: boe-tv101wum-nl6: restore MODE_LPM after sending disable cmds

Jacopo Mondi (3):
      media: rzv2h-ivc: Avoid double job scheduling
      media: mali-c55: Initialize the ISP in enable_streams()
      media: mali-c55: Fully reset the ISP configuration

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

Johan Hovold (58):
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
      spi: ep93xx: fix controller deregistration
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
      spi: octeon: fix controller deregistration
      spi: imx: fix runtime pm leak on probe deferral
      spi: mxic: fix controller deregistration
      spi: orion: fix controller deregistration
      spi: orion: fix runtime pm leak on unbind
      spi: orion: fix clock imbalance on registration failure
      spi: mpc52xx: fix use-after-free on registration failure
      spi: mpc52xx: fix controller deregistration
      spi: mpc52xx: fix use-after-free on unbind
      spi: cadence: fix controller deregistration
      spi: cadence-quadspi: fix controller deregistration
      spi: cadence: fix unclocked access on unbind
      spi: cadence: fix clock imbalance on probe failure
      spi: cadence-quadspi: fix runtime pm disable imbalance on probe failure
      spi: cadence-quadspi: fix clock imbalance on probe failure
      spi: cadence-quadspi: fix runtime pm and clock imbalance on unbind
      spi: cadence-quadspi: fix unclocked access on unbind
      spi: uniphier: fix controller deregistration

John B. Moore (2):
      drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check in KIQ
      drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fence emission

Josua Mayer (1):
      arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix usd-cd & gpio pinmux

Jouni Högander (1):
      drm/i915/psr: Init variable to avoid early exit from et alignment loop

Kory Maincent (TI) (1):
      drm/bridge: tda998x: Use __be32 for audio port OF property pointer

Krishna Chaitanya Chundru (1):
      arm64: dts: qcom: kodiak: Fix PCIe1 PHY ref clock voting

Krishna Chomal (1):
      platform/x86: hp-wmi: Ignore backlight and FnLock events

Krzysztof Kozlowski (1):
      drm/msm/hdmi: Fix wrong CTRL1 register used in writing info frames

Lorenzo Stoakes (1):
      mm/vma: do not try to unmap a VMA if mmap_prepare() invoked from mmap()

Luigi Leonardi (1):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy

Lyes Bourennani (1):
      batman-adv: fix integer overflow on buff_pos

Marek Vasut (1):
      drm/imx: parallel-display: Prefer bus format set via legacy "interface-pix-fmt" DT property

Mario Kleiner (1):
      drm/amd/display: Change dither policy for 10 bpc output back to dithering

Mario Limonciello (1):
      drm/amd: Add missing firmware declaration for PSP v15.0.0

Markus Mayer (1):
      perf build: fix "argument list too long" in second location

Matthew Brost (2):
      drm/gpusvm: Allow device pages to be mapped in mixed mappings after system pages
      drm/gpusvm: Force unmapping on error in drm_gpusvm_get_pages

Matthias Fend (2):
      media: i2c: ov08d10: fix image vertical start setting
      media: i2c: ov08d10: fix runtime PM handling in probe

Michael Tretter (1):
      media: staging: imx: request mbus_config in csi_start

Norbert Szetei (1):
      vsock: fix buffer size clamping order

Oliver Neukum (2):
      media: rc: xbox_remote: heed DMA restrictions
      media: rc: streamzap: Error handling in probe

Osama Abdelkader (2):
      drm/exynos: remove bridge when component_add fails
      drm/sti: remove bridge when sti_hda component_add fails

Pavel Begunkov (2):
      io_uring/zcrx: use guards for locking
      io_uring/zcrx: warn on freelist violations

Pei Xiao (1):
      spi: uniphier: Simplify clock handling with devm_clk_get_enabled()

Petr Malat (1):
      cgroup: Increment nr_dying_subsys_* from rmdir context

Philip Yang (1):
      drm/amdgpu: zero-initialize GART table on allocation

Prasanna Kumar T S M (1):
      EDAC/versalnet: Fix device name memory leak

Ramalingeswara Reddy, Kanala (2):
      drm/amdgpu: Use NBIF offset for register RCC_STRAP0_RCC_DEV0_EPF0_STRAP0 .
      drm/amdgpu: Use SMUIO 15.0.0 offsets for TSC upper and lower count.

Ricardo Ribalda (1):
      media: uvcvideo: Enable VB2_DMABUF for metadata stream

Sakari Ailus (1):
      staging: media: atomisp: Disallow all private IOCTLs

Sangyun Kim (2):
      HID: appletb-kbd: fix UAF in inactivity-timer cleanup path
      HID: appletb-kbd: run inactivity autodim from workqueues

Sasha Finkelstein (1):
      drm/appletbdrm: Use kvzalloc for big allocations

Sergey Shtylyov (1):
      media: dib8000: avoid division by 0 in dib8000_set_dds()

Shixiong Ou (1):
      drm/udl: Increase GET_URB_TIMEOUT

Shubhankar Milind Sardeshpande (1):
      drm/amdgpu: Avoid reset in AMDGPU unload path for APUs with GFX V11 and higher.

Shubhrajyoti Datta (1):
      EDAC/versalnet: Refactor memory controller initialization and cleanup

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

Sunil Khatri (1):
      drm/amdgpu/userq: fix access to stale wptr mapping

Sven Eckelmann (4):
      batman-adv: tp_meter: fix tp_num leak on kmalloc failure
      batman-adv: bla: prevent use-after-free when deleting claims
      batman-adv: bla: only purge non-released claims
      batman-adv: bla: put backbone reference on failed claim hash insert

T.J. Mercier (1):
      HID: playstation: Clamp num_touch_reports

Tejun Heo (2):
      cgroup: Defer css percpu_ref kill on rmdir until cgroup is depopulated
      sched_ext: Skip tasks with stale task_rq in bypass_lb_cpu()

Thomas Fourier (1):
      media: iris: Fix dma_free_attrs() size in iris_hfi_queues_init()

Tomasz Pakuła (1):
      HID: pidff: Fix integer overflow in pidff_rescale

Tomi Valkeinen (2):
      media: renesas: vsp1: Fix NULL pointer deref on module unload
      media: renesas: vin: Fix RAW8 (again)

Vikash Garodia (1):
      media: iris: switch to hardware mode after firmware boot

Viken Dadhaniya (1):
      arm64: dts: qcom: lemans: Correct QUP interrupt numbers

Vishnu Reddy (1):
      media: iris: fix use-after-free of fmt_src during MBPF check

Wang Jun (1):
      media: saa7164: add ioremap return checks and cleanups

Wenjing Liu (1):
      drm/amd/display: fix math_mod() using arg1 instead of arg2

Wenmeng Liu (4):
      media: i2c: imx412: Assert reset GPIO during probe
      media: qcom: camss: Fix csid clock configuration for sa8775p
      media: qcom: camss: Fix csid IRQ offset for sa8775p
      media: qcom: camss: Add missing clocks for VFE lite on sa8775p

Xiaolei Wang (1):
      media: i2c: ov5647: Fix runtime PM refcount leak in s_ctrl

Yang Wang (1):
      drm/amd/pm: fix incorrect FeatureCtrlMask setting on smu v14.0.x

Yasuaki Torimaru (1):
      drm/msm/gem: fix error handling in msm_ioctl_gem_info_get_metadata()

Ziyi Guo (2):
      media: chips-media: wave5: add missing spinlock protection for send_eos_event()
      media: chips-media: wave5: add missing spinlock protection for handle_dynamic_resolution_change()



Return-Path: <stable+bounces-249106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LyyD7PhCWo6twQAu9opvQ
	(envelope-from <stable+bounces-249106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:41:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9570F5620DB
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91ADC302A522
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7533BB101;
	Sun, 17 May 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H3JHe2E/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7EF405C32;
	Sun, 17 May 2026 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032372; cv=none; b=L9DUk//JVIYjkDDbb3Y2JWNzuJFyEb5wp9UlFZbIP3pRyesbalvzg8oiVQ72JqY11fhi9kRtf41AHG3d7YnC07Vak4JNvQ3apaz5MTQXIgIZi7exLbzTCKWcqqSxscY1MfhQFF0qPOnPnZsqKbaOtI2jqoavUydYkZPRQh0R46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032372; c=relaxed/simple;
	bh=6PTfnUAWdb+HsBOM3wi0y9aNj79u4Xgz5cJjSrKYFms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rtcH1G4g0uNWGc5vKi/WcVOutHgw03Wku30y2Euuc2zn8Vgtdq3HY0PGDEhJ1WiF+z7cmDuysaCZHJVrnYW2Gt30Q0R6k0GO7LnGv0yRuB2e0SrjdIFDRH1mERlFTOufqDeuazcJzyAJvKXwbF3wpfAETT1eFZPOBkeP2UMe58I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H3JHe2E/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E76EC2BCB0;
	Sun, 17 May 2026 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779032371;
	bh=6PTfnUAWdb+HsBOM3wi0y9aNj79u4Xgz5cJjSrKYFms=;
	h=From:To:Cc:Subject:Date:From;
	b=H3JHe2E/0e4SoQvs+0FOVALdEAm6q9nIaXjNfNVHLkQ11rJVxoV2PPZ6kl8DHhSgv
	 bGKB6kZRJ93fpct6roNb1HYButGOs/9hFF7xRApveZhNUJPLZ8tVKdqcP6/rW1txXG
	 OSJiyBebzjNmwunUTnEvQWM173+NyUjb+UJSB5js=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.90
Date: Sun, 17 May 2026 17:39:30 +0200
Message-ID: <2026051731-platonic-espionage-a7e5@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9570F5620DB
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
	TAGGED_FROM(0.00)[bounces-249106-lists,stable=lfdr.de];
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

I'm announcing the release of the 6.12.90 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    4 
 arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi         |    7 
 arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi |    2 
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi              |   24 +
 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts      |    2 
 arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi       |    7 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                     |    2 
 block/blk-zoned.c                                           |  168 ++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c            |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c                    |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                    |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                     |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c                  |   12 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                      |   31 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                       |    3 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                      |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                       |   25 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                       |   46 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                    |   33 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c       |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                       |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                        |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                   |   11 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           |    2 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c         |   13 
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c        |   10 
 drivers/gpu/drm/drm_gem_framebuffer_helper.c                |    4 
 drivers/gpu/drm/exynos/exynos_drm_mic.c                     |    8 
 drivers/gpu/drm/i915/display/intel_psr.c                    |    2 
 drivers/gpu/drm/msm/msm_drv.c                               |    7 
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c              |    2 
 drivers/gpu/drm/panel/panel-himax-hx83102.c                 |    2 
 drivers/gpu/drm/radeon/ci_dpm.c                             |    9 
 drivers/gpu/drm/xe/xe_bo.c                                  |    8 
 drivers/gpu/drm/xe/xe_dma_buf.c                             |   11 
 drivers/hid/hid-playstation.c                               |    6 
 drivers/media/common/videobuf2/videobuf2-dma-sg.c           |    1 
 drivers/media/dvb-frontends/dib8000.c                       |    4 
 drivers/media/i2c/imx283.c                                  |   15 -
 drivers/media/i2c/imx412.c                                  |    2 
 drivers/media/i2c/ov08d10.c                                 |   10 
 drivers/media/i2c/ov8856.c                                  |   10 
 drivers/media/pci/intel/ipu6/ipu6.c                         |    2 
 drivers/media/pci/saa7164/saa7164-core.c                    |   47 ++-
 drivers/media/pci/zoran/zoran_card.c                        |    2 
 drivers/media/platform/chips-media/wave5/wave5-vdi.c        |    1 
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c    |   14 -
 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c        |    2 
 drivers/media/platform/ti/omap3isp/ispvideo.c               |    1 
 drivers/media/rc/streamzap.c                                |   12 
 drivers/media/rc/xbox_remote.c                              |    9 
 drivers/media/usb/uvc/uvc_queue.c                           |    3 
 drivers/net/bonding/bond_main.c                             |    6 
 drivers/platform/x86/hp/hp-wmi.c                            |    5 
 drivers/regulator/act8945a-regulator.c                      |    3 
 drivers/regulator/bd9571mwv-regulator.c                     |    3 
 drivers/regulator/max77650-regulator.c                      |    2 
 drivers/regulator/mt6357-regulator.c                        |    2 
 drivers/regulator/rk808-regulator.c                         |    3 
 drivers/spi/spi-aspeed-smc.c                                |    9 
 drivers/spi/spi-at91-usart.c                                |    8 
 drivers/spi/spi-atmel.c                                     |    8 
 drivers/spi/spi-bcm63xx.c                                   |    8 
 drivers/spi/spi-bcmbca-hsspi.c                              |    4 
 drivers/spi/spi-cadence.c                                   |   15 -
 drivers/spi/spi-coldfire-qspi.c                             |   10 
 drivers/spi/spi-dln2.c                                      |    8 
 drivers/spi/spi-fsl-espi.c                                  |   10 
 drivers/spi/spi-fsl-spi.c                                   |   14 -
 drivers/spi/spi-img-spfi.c                                  |    8 
 drivers/spi/spi-imx.c                                       |    1 
 drivers/spi/spi-lantiq-ssc.c                                |    8 
 drivers/spi/spi-meson-spicc.c                               |    8 
 drivers/spi/spi-mpc52xx.c                                   |    9 
 drivers/spi/spi-mtk-nor.c                                   |    4 
 drivers/spi/spi-mxic.c                                      |    3 
 drivers/spi/spi-mxs.c                                       |    8 
 drivers/spi/spi-npcm-pspi.c                                 |    8 
 drivers/spi/spi-omap2-mcspi.c                               |    8 
 drivers/spi/spi-orion.c                                     |   16 +
 drivers/spi/spi-pic32-sqi.c                                 |    8 
 drivers/spi/spi-pic32.c                                     |   11 
 drivers/spi/spi-pl022.c                                     |    8 
 drivers/spi/spi-qup.c                                       |    8 
 drivers/spi/spi-rspi.c                                      |   10 
 drivers/spi/spi-s3c64xx.c                                   |    4 
 drivers/spi/spi-sh-hspi.c                                   |   10 
 drivers/spi/spi-sprd.c                                      |    8 
 drivers/spi/spi-st-ssc4.c                                   |    8 
 drivers/spi/spi-tegra114.c                                  |    8 
 drivers/spi/spi-tegra20-sflash.c                            |    8 
 drivers/spi/spi-uniphier.c                                  |   24 -
 drivers/spi/spi-zynq-qspi.c                                 |   55 +--
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c           |    4 
 drivers/staging/media/imx/imx-media-csi.c                   |   40 +-
 drivers/usb/dwc3/core.c                                     |   12 
 drivers/usb/typec/tcpm/tcpm.c                               |    2 
 drivers/video/fbdev/core/fbcon_rotate.c                     |    5 
 fs/btrfs/ioctl.c                                            |    5 
 fs/btrfs/space-info.c                                       |    8 
 fs/btrfs/sysfs.c                                            |    5 
 fs/btrfs/sysfs.h                                            |    3 
 fs/tracefs/inode.c                                          |    1 
 include/linux/damon.h                                       |    2 
 include/uapi/linux/io_uring.h                               |    3 
 io_uring/kbuf.c                                             |    8 
 io_uring/kbuf.h                                             |    7 
 kernel/trace/trace_probe.c                                  |    6 
 kernel/trace/trace_probe.h                                  |    4 
 mm/damon/core.c                                             |   34 ++
 mm/damon/lru_sort.c                                         |   88 ++++--
 mm/damon/reclaim.c                                          |   88 ++++--
 mm/hugetlb.c                                                |    1 
 net/batman-adv/bat_iv_ogm.c                                 |   85 ++++--
 net/batman-adv/bridge_loop_avoidance.c                      |   11 
 net/batman-adv/main.c                                       |    1 
 net/batman-adv/tp_meter.c                                   |  116 ++++++--
 net/batman-adv/tp_meter.h                                   |    1 
 net/batman-adv/types.h                                      |    4 
 net/bluetooth/hci_conn.c                                    |   19 +
 net/bluetooth/l2cap_sock.c                                  |    3 
 net/sctp/socket.c                                           |    9 
 net/vmw_vsock/af_vsock.c                                    |    6 
 net/vmw_vsock/virtio_transport_common.c                     |   55 +--
 rust/kernel/init/__internal.rs                              |   28 +-
 rust/kernel/init/macros.rs                                  |   91 +++---
 sound/core/misc.c                                           |   33 +-
 sound/core/seq/seq_clientmgr.c                              |    9 
 sound/core/seq/seq_clientmgr.h                              |    5 
 sound/core/seq/seq_ump_client.c                             |    4 
 sound/pci/hda/cs35l56_hda.c                                 |   19 +
 131 files changed, 1260 insertions(+), 584 deletions(-)

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

Cássio Gabriel (3):
      ALSA: hda: cs35l56: Propagate ASP TX source control errors
      ALSA: core: Serialize deferred fasync state checks
      ALSA: seq: Fix UMP group 16 filtering

Damien Le Moal (3):
      block: cleanup blkdev_report_zones()
      block: reorganize struct blk_zone_wplug
      block: fix zone write plug removal

David Carlier (2):
      Bluetooth: hci_conn: fix potential UAF in create_big_sync
      tracefs: Fix default permissions not being applied on initial mount

Dudu Lu (1):
      vsock/virtio: fix accept queue count leak on transport mismatch

Ethan Tidmore (1):
      media: intel/ipu6: fix error pointer dereference

Felix Kuehling (1):
      drm/amdkfd: Make all TLB-flushes heavy-weight

Filipe Manana (1):
      btrfs: remove fs_info argument from btrfs_sysfs_add_space_info_type()

Gary Guo (1):
      rust: pin-init: fix incorrect accessor reference lifetime

Greg Kroah-Hartman (1):
      Linux 6.12.90

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

Jiexun Wang (3):
      batman-adv: reject new tp_meter sessions during teardown
      batman-adv: stop caching unowned originator pointers in BAT IV
      batman-adv: stop tp_meter sessions during mesh teardown

Johan Hovold (44):
      spi: bcm63xx: fix controller deregistration
      spi: atmel: fix controller deregistration
      regulator: mt6357: fix OF node reference imbalance
      spi: st-ssc4: fix controller deregistration
      regulator: max77650: fix OF node reference imbalance
      regulator: rk808: fix OF node reference imbalance
      regulator: act8945a: fix OF node reference imbalance
      regulator: bd9571mwv: fix OF node reference imbalance
      spi: lantiq-ssc: fix controller deregistration
      spi: meson-spicc: fix controller deregistration
      spi: qup: fix controller deregistration
      spi: at91-usart: fix controller deregistration
      spi: aspeed-smc: fix controller deregistration
      spi: mxs: fix controller deregistration
      spi: dln2: fix controller deregistration
      spi: s3c64xx: fix controller deregistration
      spi: fsl-espi: fix controller deregistration
      spi: omap2-mcspi: fix controller deregistration
      spi: pic32: fix controller deregistration
      spi: mtk-nor: fix controller deregistration
      spi: pl022: fix controller deregistration
      spi: sh-hspi: fix controller deregistration
      spi: fsl: fix controller deregistration
      spi: bcmbca-hsspi: fix controller deregistration
      spi: coldfire-qspi: fix controller deregistration
      spi: npcm-pspi: fix controller deregistration
      spi: pic32-sqi: fix controller deregistration
      spi: sprd: fix controller deregistration
      spi: rspi: fix controller deregistration
      spi: img-spfi: fix controller deregistration
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
      spi: zynq-qspi: fix controller deregistration
      spi: tegra20-sflash: fix controller deregistration
      spi: tegra114: fix controller deregistration
      spi: uniphier: fix controller deregistration

John B. Moore (2):
      drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check in KIQ
      drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fence emission

Josua Mayer (1):
      arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix usd-cd & gpio pinmux

Jouni Högander (1):
      drm/i915/psr: Init variable to avoid early exit from et alignment loop

Krishna Chomal (1):
      platform/x86: hp-wmi: Ignore backlight and FnLock events

Luigi Leonardi (1):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy

Lyes Bourennani (1):
      batman-adv: fix integer overflow on buff_pos

Mario Kleiner (1):
      drm/amd/display: Change dither policy for 10 bpc output back to dithering

Martin Michaelis (1):
      io_uring/kbuf: support min length left for incremental buffers

Matthias Fend (1):
      media: i2c: ov08d10: fix image vertical start setting

Michael Tretter (1):
      media: staging: imx: request mbus_config in csi_start

Miguel Ojeda (2):
      rust: allow `clippy::collapsible_match` globally
      rust: allow `clippy::collapsible_if` globally

Nikolay Aleksandrov (1):
      bonding: fix use-after-free due to enslave fail after slave array update

Norbert Szetei (1):
      vsock: fix buffer size clamping order

Oliver Neukum (2):
      media: rc: xbox_remote: heed DMA restrictions
      media: rc: streamzap: Error handling in probe

Osama Abdelkader (1):
      drm/exynos: remove bridge when component_add fails

Pei Xiao (2):
      spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()
      spi: uniphier: Simplify clock handling with devm_clk_get_enabled()

Philip Yang (1):
      drm/amdgpu: zero-initialize GART table on allocation

Ramalingeswara Reddy, Kanala (1):
      drm/amdgpu: Use SMUIO 15.0.0 offsets for TSC upper and lower count.

Ricardo Ribalda (1):
      media: uvcvideo: Enable VB2_DMABUF for metadata stream

Sakari Ailus (1):
      staging: media: atomisp: Disallow all private IOCTLs

Sang-Heon Jeon (1):
      mm/hugetlb_cma: round up per_node before logging it

Selvarasu Ganesan (1):
      usb: dwc3: Move GUID programming after PHY initialization

SeongJae Park (4):
      mm/damon/core: disallow time-quota setting zero esz
      mm/damon/core: implement damon_kdamond_pid()
      mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
      mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values

Sergey Shtylyov (1):
      media: dib8000: avoid division by 0 in dib8000_set_dds()

Shuicheng Lin (3):
      drm/xe/bo: Fix bo leak on GGTT flag validation in xe_bo_init_locked()
      drm/xe: Fix dma-buf attachment leak in xe_gem_prime_import()
      drm/xe/bo: Fix bo leak on unaligned size validation in xe_bo_init_locked()

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-am62a7-sk: Fix pin name in comment from M19 to N22

Siwei Zhang (1):
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()

Stefano Garzarella (2):
      vsock/virtio: fix length and offset in tap skb for split packets
      vsock/virtio: fix empty payload in tap skb for non-linear buffers

Steven Rostedt (1):
      tracing/probes: Limit size of event probe to 3K

Sven Eckelmann (4):
      batman-adv: bla: prevent use-after-free when deleting claims
      batman-adv: bla: only purge non-released claims
      batman-adv: bla: put backbone reference on failed claim hash insert
      batman-adv: tp_meter: fix tp_num leak on kmalloc failure

T.J. Mercier (1):
      HID: playstation: Clamp num_touch_reports

Takashi Iwai (2):
      ALSA: misc: Use guard() for spin locks
      ALSA: seq: Notify client and port info changes

Thomas Zimmermann (1):
      fbcon: Avoid OOB font access if console rotation fails

Wang Jun (1):
      media: saa7164: add ioremap return checks and cleanups

Wenmeng Liu (1):
      media: i2c: imx412: Assert reset GPIO during probe

Yang Wang (1):
      drm/amd/pm: fix incorrect FeatureCtrlMask setting on smu v14.0.x

Yasuaki Torimaru (1):
      drm/msm/gem: fix error handling in msm_ioctl_gem_info_get_metadata()

Yochai Eisenrich (1):
      btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which can lead to info-leak

Ziyi Guo (2):
      media: chips-media: wave5: add missing spinlock protection for send_eos_event()
      media: chips-media: wave5: add missing spinlock protection for handle_dynamic_resolution_change()



Return-Path: <stable+bounces-253936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG/BKriTEWpLnwYAu9opvQ
	(envelope-from <stable+bounces-253936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:47:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED16D5BEBFC
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BD9F3017F8A
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7EE38AC79;
	Sat, 23 May 2026 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X9rQBBJ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D2238A718;
	Sat, 23 May 2026 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779536812; cv=none; b=dszxIPnt3JeuLrcTZcShcLsP/9lYU1Lp8KBKBePHOpZS44NbfFDrus6qpR+YyrwMb/BEIyBRSfUq0m2O4sdNMZtPOaEF5GvqLM0NzYmwztfNUVwr/2NfGagRG2O5+eDk+udRnCRVyVqNnRkKWvG4UqhxZyuSHEvpnvxpY+L/0tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779536812; c=relaxed/simple;
	bh=8WJbFzTPJ6QZ/HXazJ6Y82U2hwd8iKxioS4kiYmNq80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K9BNr1RIax8ZqVvkHvVU/eI9L7llE9X1rEeTG0cI514dgyynCSAPbSsYaF7NGLXQpGK3PAOSk87UXJYmD5c+QeYHjVfrHfrgcKsY32ebPYlBzr6Yj6uKGUs2GMhb7k9Ix5ggnXIqFJQOPRRsiItOI734JH7+3KGfgQQDsn1rzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X9rQBBJ2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5B01F00A3F;
	Sat, 23 May 2026 11:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779536801;
	bh=QFD6+Ef1PbeqpWI0OUu/M65hlvjI4qflfUyfPYJ/9M0=;
	h=From:To:Cc:Subject:Date;
	b=X9rQBBJ268+IL60rIxiVdWJ/U9lUjlfTXgMzEaREZI1rnJ7B6k1GDV2ypfLGECjgN
	 TlI18EeFrd5MWW/a5m5n2mMRG/BATvJ2Be46Fy2s9fXBrhKd0kkB9ujssmr3Xt3W6P
	 jveM4LJ9+0HTkYdCeAOfx8MlIykOoKImhTC7J1Lo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.0.10
Date: Sat, 23 May 2026 13:46:32 +0200
Message-ID: <2026052332-storage-thinly-a50b@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253936-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,haoyu.lu:url]
X-Rspamd-Queue-Id: ED16D5BEBFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 7.0.10 kernel.

All users of the 7.0 kernel series must upgrade.

The updated 7.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/mm/damon/lru_sort.rst                              |    4 
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml       |    2 
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml                |    3 
 Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml                   |    2 
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml             |    4 
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml                    |    3 
 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml            |   50 -
 Documentation/devicetree/bindings/pinctrl/marvell,armada3710-xb-pinctrl.yaml |   11 
 Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml            |    1 
 Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml             |    7 
 Documentation/driver-api/driver-model/devres.rst                             |    4 
 Documentation/mm/damon/index.rst                                             |    2 
 Documentation/mm/hugetlbfs_reserv.rst                                        |    2 
 Documentation/netlink/specs/psp.yaml                                         |    2 
 Documentation/userspace-api/rseq.rst                                         |   94 ++
 Makefile                                                                     |    4 
 arch/arc/net/bpf_jit_arcv2.c                                                 |    8 
 arch/arm/boot/dts/broadcom/bcm-ns.dtsi                                       |    2 
 arch/arm/boot/dts/mediatek/mt7623.dtsi                                       |    2 
 arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi                         |    8 
 arch/arm/boot/dts/nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts               |    2 
 arch/arm/mach-omap1/clock_data.c                                             |    4 
 arch/arm/net/bpf_jit_32.c                                                    |    6 
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                                   |    6 
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts                         |    3 
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi                               |  161 +++--
 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi                    |    4 
 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi                    |    4 
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts                                |  114 ++-
 arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi                          |    4 
 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi                          |    2 
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi                          |    2 
 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi              |    2 
 arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts                             |    2 
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts                  |    2 
 arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts                       |    2 
 arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts                  |    2 
 arch/arm64/boot/dts/freescale/imx8mp-debix-som-a.dtsi                        |    2 
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi                          |    2 
 arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi                              |    2 
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts                                 |    5 
 arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi          |    2 
 arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi       |   11 
 arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp.dtsi                        |    2 
 arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso                         |   19 
 arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi                      |    6 
 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts          |    1 
 arch/arm64/boot/dts/freescale/imx8mp-navqp.dts                               |    2 
 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-som.dtsi                       |    2 
 arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi                             |    4 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts             |    4 
 arch/arm64/boot/dts/freescale/imx8mp-ultra-mach-sbc.dts                      |    4 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                                 |   10 
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts                                |   10 
 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts                            |    2 
 arch/arm64/boot/dts/freescale/imx91.dtsi                                     |    2 
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi                            |    2 
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi                                 |    2 
 arch/arm64/boot/dts/mediatek/mt6795.dtsi                                     |    2 
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi                                    |    2 
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi                                    |    2 
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-4e.dts              |    2 
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-pro-8x.dts              |    2 
 arch/arm64/boot/dts/mediatek/mt8365.dtsi                                     |    5 
 arch/arm64/boot/dts/nvidia/tegra234-p3701.dtsi                               |    1 
 arch/arm64/boot/dts/nvidia/tegra234-p3767.dtsi                               |    1 
 arch/arm64/boot/dts/qcom/Makefile                                            |    2 
 arch/arm64/boot/dts/qcom/hamoa.dtsi                                          |   10 
 arch/arm64/boot/dts/qcom/kaanapali.dtsi                                      |    2 
 arch/arm64/boot/dts/qcom/lemans.dtsi                                         |    6 
 arch/arm64/boot/dts/qcom/milos.dtsi                                          |    4 
 arch/arm64/boot/dts/qcom/monaco.dtsi                                         |    6 
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts                             |    2 
 arch/arm64/boot/dts/qcom/msm8937-xiaomi-land.dts                             |    2 
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts                            |    2 
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts                            |    2 
 arch/arm64/boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts                    |    8 
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts                           |   12 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi                 |    1 
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts                            |   52 -
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts                            |    4 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                         |    5 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                         |    5 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                         |   13 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                         |   15 
 arch/arm64/boot/dts/qcom/sm8750.dtsi                                         |   14 
 arch/arm64/boot/dts/qcom/talos.dtsi                                          |    3 
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts                                   |   23 
 arch/arm64/boot/dts/rockchip/rk3562-evb2-v10.dts                             |    2 
 arch/arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts                           |    4 
 arch/arm64/boot/dts/rockchip/rk3576.dtsi                                     |    5 
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts                               |    2 
 arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts                       |   12 
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                                     |   14 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                                   |    2 
 arch/arm64/boot/dts/ti/k3-am62l.dtsi                                         |    4 
 arch/arm64/boot/dts/ti/k3-am62l3-evm.dts                                     |    6 
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                                      |    6 
 arch/arm64/include/asm/entry-common.h                                        |   21 
 arch/arm64/include/asm/kernel-pgtable.h                                      |    7 
 arch/arm64/include/asm/xor.h                                                 |    2 
 arch/arm64/kernel/cpufeature.c                                               |    4 
 arch/arm64/kernel/machine_kexec.c                                            |    3 
 arch/arm64/kernel/pi/patch-scs.c                                             |    4 
 arch/arm64/kernel/sys32.c                                                    |    2 
 arch/arm64/lib/insn.c                                                        |    2 
 arch/arm64/net/bpf_jit_comp.c                                                |   16 
 arch/mips/kernel/linux32.c                                                   |    2 
 arch/parisc/kernel/sys_parisc.c                                              |    4 
 arch/powerpc/include/asm/book3s/64/pgtable.h                                 |   15 
 arch/powerpc/include/asm/kexec.h                                             |   14 
 arch/powerpc/kernel/sys_ppc32.c                                              |    2 
 arch/powerpc/kexec/crash.c                                                   |   64 ++
 arch/powerpc/kexec/file_load_64.c                                            |   29 
 arch/powerpc/mm/book3s64/pgtable.c                                           |   13 
 arch/powerpc/mm/pgtable-frag.c                                               |    1 
 arch/powerpc/platforms/44x/warp.c                                            |    2 
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts                              |    4 
 arch/riscv/net/bpf_jit.h                                                     |    6 
 arch/riscv/net/bpf_jit_core.c                                                |    7 
 arch/s390/kvm/interrupt.c                                                    |    3 
 arch/s390/kvm/pci.c                                                          |    6 
 arch/s390/mm/fault.c                                                         |    2 
 arch/s390/net/bpf_jit_comp.c                                                 |   39 -
 arch/sh/include/cpu-sh3/cpu/dac.h                                            |    2 
 arch/sparc/kernel/sys_sparc32.c                                              |    2 
 arch/sparc/vdso/Makefile                                                     |    2 
 arch/um/kernel/tlb.c                                                         |    1 
 arch/x86/Makefile.um                                                         |    2 
 arch/x86/coco/tdx/debug.c                                                    |    2 
 arch/x86/events/amd/ibs.c                                                    |   15 
 arch/x86/events/perf_event_flags.h                                           |    1 
 arch/x86/include/asm/irqflags.h                                              |    6 
 arch/x86/include/asm/shared/tdx.h                                            |    4 
 arch/x86/include/asm/vdso.h                                                  |    1 
 arch/x86/kernel/acpi/cppc.c                                                  |    6 
 arch/x86/kernel/relocate_kernel_64.S                                         |    8 
 arch/x86/kernel/sys_ia32.c                                                   |    3 
 arch/x86/kvm/emulate.c                                                       |    2 
 arch/x86/kvm/trace.h                                                         |    2 
 arch/x86/tools/vdso2c.c                                                      |    1 
 arch/x86/um/vdso/Makefile                                                    |    2 
 block/blk-cgroup.c                                                           |   16 
 block/blk-wbt.c                                                              |    5 
 block/blk-zoned.c                                                            |   26 
 block/disk-events.c                                                          |    3 
 crypto/af_alg.c                                                              |    2 
 crypto/jitterentropy-kcapi.c                                                 |   14 
 crypto/simd.c                                                                |   16 
 drivers/accel/amdxdna/amdxdna_mailbox.c                                      |    2 
 drivers/accel/rocket/rocket_gem.c                                            |    2 
 drivers/acpi/apei/einj-core.c                                                |   45 -
 drivers/acpi/arm64/agdi.c                                                    |    2 
 drivers/acpi/x86/cmos_rtc.c                                                  |   77 +-
 drivers/ata/libata-scsi.c                                                    |    4 
 drivers/base/devres.c                                                        |    2 
 drivers/block/drbd/drbd_nl.c                                                 |    8 
 drivers/block/ublk_drv.c                                                     |   21 
 drivers/block/zram/zram_drv.c                                                |    4 
 drivers/bluetooth/btmtk.c                                                    |    4 
 drivers/bluetooth/hci_ldisc.c                                                |    3 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                              |   43 -
 drivers/bus/stm32_rifsc.c                                                    |   52 -
 drivers/cdrom/cdrom.c                                                        |   73 +-
 drivers/char/ipmi/ssif_bmc.c                                                 |   34 -
 drivers/clk/clk-qoriq.c                                                      |   17 
 drivers/clk/clk-xgene.c                                                      |    2 
 drivers/clk/imx/clk-imx6q.c                                                  |   12 
 drivers/clk/imx/clk-imx8mq.c                                                 |    4 
 drivers/clk/qcom/dispcc-glymur.c                                             |    4 
 drivers/clk/qcom/dispcc-kaanapali.c                                          |    2 
 drivers/clk/qcom/dispcc-milos.c                                              |    1 
 drivers/clk/qcom/dispcc-sc8280xp.c                                           |    4 
 drivers/clk/qcom/dispcc-sm4450.c                                             |    1 
 drivers/clk/qcom/dispcc-sm8250.c                                             |    6 
 drivers/clk/qcom/dispcc-sm8450.c                                             |    2 
 drivers/clk/qcom/dispcc0-sa8775p.c                                           |    2 
 drivers/clk/qcom/dispcc1-sa8775p.c                                           |    2 
 drivers/clk/qcom/gcc-glymur.c                                                |    1 
 drivers/clk/qcom/gcc-sc8180x.c                                               |   64 +-
 drivers/clk/qcom/gcc-x1e80100.c                                              |    1 
 drivers/clk/qcom/gdsc.c                                                      |   12 
 drivers/clk/renesas/r9a09g056-cpg.c                                          |   36 -
 drivers/clk/renesas/r9a09g057-cpg.c                                          |   55 -
 drivers/clk/spacemit/ccu_mix.c                                               |    2 
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c                                     |   17 
 drivers/clk/visconti/pll.c                                                   |    2 
 drivers/cpufreq/amd-pstate.c                                                 |    6 
 drivers/cpufreq/cpufreq.c                                                    |    6 
 drivers/cpufreq/intel_pstate.c                                               |    4 
 drivers/crypto/atmel-aes.c                                                   |    6 
 drivers/crypto/ccp/ccp-crypto-aes.c                                          |    7 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                                   |    2 
 drivers/crypto/inside-secure/eip93/eip93-common.c                            |    2 
 drivers/crypto/inside-secure/eip93/eip93-main.c                              |   16 
 drivers/crypto/inside-secure/eip93/eip93-regs.h                              |    2 
 drivers/crypto/intel/iaa/iaa_crypto_main.c                                   |    2 
 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c                       |   20 
 drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c                         |   14 
 drivers/crypto/intel/qat/qat_common/adf_sysfs_ras_counters.c                 |   12 
 drivers/crypto/intel/qat/qat_common/icp_qat_hw_20_comp.h                     |   10 
 drivers/crypto/intel/qat/qat_common/qat_comp_algs.c                          |   10 
 drivers/crypto/sa2ul.c                                                       |    4 
 drivers/crypto/tegra/tegra-se-aes.c                                          |    9 
 drivers/crypto/tegra/tegra-se-hash.c                                         |    3 
 drivers/cxl/pci.c                                                            |    3 
 drivers/dma-buf/dma-fence.c                                                  |    8 
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c                               |   16 
 drivers/dma/mxs-dma.c                                                        |    1 
 drivers/dpll/dpll_netlink.c                                                  |   10 
 drivers/dpll/dpll_netlink.h                                                  |    2 
 drivers/firmware/arm_ffa/driver.c                                            |    2 
 drivers/firmware/efi/capsule-loader.c                                        |    2 
 drivers/firmware/qcom/qcom_scm.c                                             |    3 
 drivers/fwctl/main.c                                                         |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                                      |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                                      |   57 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c                                    |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c                                     |    5 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                                        |   66 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c                                       |   10 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                                       |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                                       |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c                                       |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                                     |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c                                     |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c                                     |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c                                     |    1 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c                                     |    1 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                                        |   10 
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                                        |    5 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c                                        |    2 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                                        |    2 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                        |    3 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                        |    1 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                                      |    1 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c                                      |    1 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c                                      |    1 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c                                      |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c                                 |   35 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c                             |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c                             |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                             |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c                             |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c                           |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                              |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c                              |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                       |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                            |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                       |   21 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c                    |   44 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c                            |   62 +
 drivers/gpu/drm/amd/display/dc/dc.h                                          |    2 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                                 |   10 
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c                        |    4 
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c                           |    3 
 drivers/gpu/drm/amd/display/dc/link/link_factory.c                           |    4 
 drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c               |    3 
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c               |    3 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c               |    8 
 drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h                  |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c                               |   15 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                          |  118 +++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h                          |    1 
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h                                 |    1 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c                          |   15 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c                           |    1 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c                        |    5 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c                         |    1 
 drivers/gpu/drm/amd/ras/rascore/ras_core.c                                   |   17 
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c                                    |    2 
 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c                      |    6 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c                          |   72 +-
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h                          |    1 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c                          |   18 
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c                                 |   40 -
 drivers/gpu/drm/drm_color_mgmt.c                                             |    2 
 drivers/gpu/drm/drm_fb_helper.c                                              |    4 
 drivers/gpu/drm/drm_gem.c                                                    |    7 
 drivers/gpu/drm/drm_gpusvm.c                                                 |    4 
 drivers/gpu/drm/gma500/oaktrail_hdmi.c                                       |    1 
 drivers/gpu/drm/gma500/oaktrail_lvds.c                                       |    9 
 drivers/gpu/drm/i915/display/intel_dp.c                                      |    9 
 drivers/gpu/drm/i915/display/skl_watermark.c                                 |    4 
 drivers/gpu/drm/i915/gt/intel_reset.c                                        |    3 
 drivers/gpu/drm/imagination/pvr_rogue_fwif.h                                 |    8 
 drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h                          |    6 
 drivers/gpu/drm/loongson/lsdc_drv.c                                          |    2 
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c                                        |    6 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                                        |    6 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                        |  140 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h                                        |    7 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                        |  109 ---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h                                        |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                                  |   18 
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c                                        |   14 
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c                                        |   26 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                      |    6 
 drivers/gpu/drm/msm/adreno/adreno_gpu.h                                      |    3 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h                     |    7 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                                     |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                                      |    2 
 drivers/gpu/drm/msm/dp/dp_display.c                                          |    1 
 drivers/gpu/drm/msm/dsi/dsi.c                                                |    1 
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                                            |    4 
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                                            |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                           |   16 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c                                        |    1 
 drivers/gpu/drm/msm/hdmi/hdmi.c                                              |    1 
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                                          |    1 
 drivers/gpu/drm/msm/msm_fb.c                                                 |    7 
 drivers/gpu/drm/msm/msm_gem.c                                                |    3 
 drivers/gpu/drm/msm/msm_gem_shrinker.c                                       |    5 
 drivers/gpu/drm/msm/msm_gem_vma.c                                            |   11 
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml                            |    6 
 drivers/gpu/drm/panel/Kconfig                                                |    1 
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c                              |    1 
 drivers/gpu/drm/panel/panel-simple.c                                         |    2 
 drivers/gpu/drm/panfrost/panfrost_drv.c                                      |    2 
 drivers/gpu/drm/sun4i/sun4i_backend.c                                        |    6 
 drivers/gpu/drm/sun4i/sun8i_mixer.c                                          |    2 
 drivers/gpu/drm/sysfb/ofdrm.c                                                |    2 
 drivers/gpu/drm/ttm/ttm_bo.c                                                 |   18 
 drivers/gpu/drm/ttm/ttm_bo_util.c                                            |   11 
 drivers/gpu/drm/ttm/ttm_resource.c                                           |   18 
 drivers/gpu/drm/v3d/v3d_drv.c                                                |   16 
 drivers/gpu/drm/virtio/virtgpu_prime.c                                       |    2 
 drivers/gpu/drm/xe/xe_dma_buf.c                                              |   52 -
 drivers/gpu/drm/xe/xe_eu_stall.c                                             |    4 
 drivers/gpu/drm/xe/xe_exec_queue.c                                           |    9 
 drivers/gpu/drm/xe/xe_gsc.c                                                  |    2 
 drivers/gpu/drm/xe/xe_guc_submit.c                                           |   34 -
 drivers/gpu/drm/xe/xe_lrc.c                                                  |    2 
 drivers/gpu/drm/xe/xe_reg_whitelist.c                                        |    2 
 drivers/gpu/drm/xe/xe_wa.c                                                   |   37 -
 drivers/gpu/nova-core/bitfield.rs                                            |    5 
 drivers/gpu/nova-core/driver.rs                                              |    2 
 drivers/gpu/nova-core/falcon.rs                                              |   74 +-
 drivers/gpu/nova-core/firmware.rs                                            |   88 +-
 drivers/gpu/nova-core/firmware/booter.rs                                     |   59 -
 drivers/gpu/nova-core/firmware/fwsec.rs                                      |  167 ++---
 drivers/gpu/nova-core/gpu.rs                                                 |    4 
 drivers/gpu/nova-core/gsp/boot.rs                                            |   34 -
 drivers/gpu/nova-core/gsp/cmdq.rs                                            |   38 -
 drivers/hid/bpf/hid_bpf_dispatch.c                                           |    6 
 drivers/hid/hid-asus.c                                                       |   28 
 drivers/hid/hid-core.c                                                       |   67 +-
 drivers/hid/hid-gfrm.c                                                       |    4 
 drivers/hid/hid-logitech-hidpp.c                                             |    2 
 drivers/hid/hid-multitouch.c                                                 |    2 
 drivers/hid/hid-primax.c                                                     |    2 
 drivers/hid/hid-vivaldi-common.c                                             |    2 
 drivers/hid/i2c-hid/i2c-hid-core.c                                           |    7 
 drivers/hid/usbhid/hid-core.c                                                |   13 
 drivers/hid/wacom_sys.c                                                      |    6 
 drivers/hte/Kconfig                                                          |    6 
 drivers/hv/vmbus_drv.c                                                       |    1 
 drivers/hwmon/aspeed-g6-pwm-tach.c                                           |    8 
 drivers/i3c/master/adi-i3c-master.c                                          |    2 
 drivers/i3c/master/dw-i3c-master.c                                           |   18 
 drivers/i3c/master/mipi-i3c-hci/dma.c                                        |    5 
 drivers/i3c/master/renesas-i3c.c                                             |    4 
 drivers/infiniband/core/iwpm_msg.c                                           |    6 
 drivers/infiniband/core/umem.c                                               |   13 
 drivers/iommu/amd/iommu.c                                                    |   15 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                               |    7 
 drivers/iommu/intel/iommu.c                                                  |   16 
 drivers/iommu/iommu.c                                                        |  168 ++++-
 drivers/iommu/iommufd/selftest.c                                             |    4 
 drivers/iommu/iommufd/vfio_compat.c                                          |    2 
 drivers/iommu/riscv/Kconfig                                                  |    1 
 drivers/iommu/riscv/iommu-platform.c                                         |   17 
 drivers/iommu/riscv/iommu.c                                                  |   84 ++
 drivers/irqchip/irq-gic-v5-its.c                                             |   34 -
 drivers/irqchip/irq-gic-v5.c                                                 |   98 +--
 drivers/irqchip/irq-meson-gpio.c                                             |    3 
 drivers/irqchip/irq-pic32-evic.c                                             |    2 
 drivers/irqchip/irq-renesas-rzg2l.c                                          |    2 
 drivers/irqchip/irq-riscv-imsic-early.c                                      |    2 
 drivers/leds/blink/leds-lgm-sso.c                                            |    2 
 drivers/mailbox/mailbox-test.c                                               |   43 -
 drivers/mailbox/mailbox.c                                                    |    3 
 drivers/mailbox/mtk-cmdq-mailbox.c                                           |    8 
 drivers/mailbox/mtk-vcp-mailbox.c                                            |    2 
 drivers/md/dm-cache-metadata.c                                               |   24 
 drivers/md/dm-cache-metadata.h                                               |    5 
 drivers/md/dm-cache-policy-smq.c                                             |    4 
 drivers/md/dm-cache-target.c                                                 |   73 +-
 drivers/md/dm-init.c                                                         |    4 
 drivers/md/dm-log.c                                                          |    6 
 drivers/md/dm-mpath.c                                                        |    9 
 drivers/md/md-bitmap.c                                                       |  131 +++-
 drivers/md/md-bitmap.h                                                       |    2 
 drivers/md/md-llbitmap.c                                                     |    7 
 drivers/md/md.c                                                              |  259 ++++++--
 drivers/md/md.h                                                              |    3 
 drivers/md/raid1-10.c                                                        |    7 
 drivers/md/raid1.c                                                           |    4 
 drivers/media/i2c/og01a1b.c                                                  |   13 
 drivers/media/platform/synopsys/Kconfig                                      |    1 
 drivers/memory/tegra/tegra124-emc.c                                          |    2 
 drivers/memory/tegra/tegra30-emc.c                                           |    6 
 drivers/mfd/mc13xxx-core.c                                                   |    2 
 drivers/mtd/maps/physmap-gemini.c                                            |    2 
 drivers/mtd/nand/raw/sunxi_nand.c                                            |    6 
 drivers/mtd/nand/spi/core.c                                                  |   24 
 drivers/mtd/nand/spi/winbond.c                                               |   19 
 drivers/mtd/parsers/ofpart_core.c                                            |    4 
 drivers/mtd/spi-nor/core.c                                                   |    2 
 drivers/mtd/spi-nor/core.h                                                   |    2 
 drivers/mtd/spi-nor/micron-st.c                                              |   10 
 drivers/mtd/spi-nor/swp.c                                                    |    4 
 drivers/net/bareudp.c                                                        |    3 
 drivers/net/bonding/bond_3ad.c                                               |  109 +--
 drivers/net/bonding/bond_main.c                                              |    8 
 drivers/net/bonding/bond_netlink.c                                           |   21 
 drivers/net/bonding/bond_procfs.c                                            |    3 
 drivers/net/bonding/bond_sysfs_slave.c                                       |   17 
 drivers/net/dsa/realtek/rtl8365mb.c                                          |    2 
 drivers/net/ethernet/airoha/airoha_eth.c                                     |  312 ++++++---
 drivers/net/ethernet/airoha/airoha_eth.h                                     |   10 
 drivers/net/ethernet/airoha/airoha_ppe.c                                     |   44 +
 drivers/net/ethernet/amazon/ena/ena_com.c                                    |    7 
 drivers/net/ethernet/amazon/ena/ena_phc.c                                    |    5 
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c                         |    2 
 drivers/net/ethernet/broadcom/bnge/bnge_core.c                               |   30 
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c                               |   16 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                               |   30 
 drivers/net/ethernet/freescale/Makefile                                      |    3 
 drivers/net/ethernet/freescale/dpaa2/Kconfig                                 |    4 
 drivers/net/ethernet/freescale/enetc/ntmp.c                                  |  217 ++++--
 drivers/net/ethernet/freescale/enetc/ntmp_private.h                          |   10 
 drivers/net/ethernet/intel/e1000e/netdev.c                                   |    1 
 drivers/net/ethernet/intel/i40e/i40e.h                                       |    1 
 drivers/net/ethernet/intel/i40e/i40e_main.c                                  |    2 
 drivers/net/ethernet/intel/i40e/i40e_ptp.c                                   |    3 
 drivers/net/ethernet/intel/iavf/iavf.h                                       |    9 
 drivers/net/ethernet/intel/iavf/iavf_main.c                                  |   52 -
 drivers/net/ethernet/intel/iavf/iavf_type.h                                  |    2 
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c                              |   76 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c                             |    2 
 drivers/net/ethernet/intel/ice/ice.h                                         |    4 
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h                              |    2 
 drivers/net/ethernet/intel/ice/ice_common.c                                  |    2 
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c                                 |    2 
 drivers/net/ethernet/intel/ice/ice_dpll.c                                    |  146 ++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c                                 |    1 
 drivers/net/ethernet/intel/ice/ice_lib.c                                     |    4 
 drivers/net/ethernet/intel/ice/ice_main.c                                    |  123 ---
 drivers/net/ethernet/intel/ice/ice_ptp.c                                     |   44 -
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h                              |   12 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c                                  |  259 +++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h                                  |    5 
 drivers/net/ethernet/intel/ice/ice_txrx.c                                    |   29 
 drivers/net/ethernet/intel/ice/ice_txrx.h                                    |   16 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                                  |    7 
 drivers/net/ethernet/intel/idpf/idpf_idc.c                                   |    6 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                                  |   22 
 drivers/net/ethernet/mediatek/mtk_ppe.c                                      |   30 
 drivers/net/ethernet/mediatek/mtk_ppe.h                                      |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c             |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                            |    8 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                               |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c                                  |    2 
 drivers/net/ethernet/microsoft/mana/gdma_main.c                              |    7 
 drivers/net/ethernet/microsoft/mana/mana_en.c                                |   39 -
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c                      |   17 
 drivers/net/ethernet/sfc/efx_devlink.c                                       |    2 
 drivers/net/ethernet/ti/Makefile                                             |   30 
 drivers/net/ethernet/ti/cpsw.c                                               |    2 
 drivers/net/ethernet/ti/cpsw_ale.c                                           |   25 
 drivers/net/ethernet/ti/cpsw_ethtool.c                                       |   24 
 drivers/net/ethernet/ti/cpsw_new.c                                           |    2 
 drivers/net/ethernet/ti/cpsw_priv.c                                          |   39 +
 drivers/net/ethernet/ti/cpsw_priv.h                                          |    2 
 drivers/net/ethernet/ti/cpsw_sl.c                                            |   11 
 drivers/net/ethernet/ti/davinci_cpdma.c                                      |   27 
 drivers/net/hamradio/6pack.c                                                 |    9 
 drivers/net/ipa/gsi.c                                                        |    1 
 drivers/net/ipa/ipa_main.c                                                   |    6 
 drivers/net/macsec.c                                                         |   71 ++
 drivers/net/macvlan.c                                                        |    9 
 drivers/net/mctp/mctp-i2c.c                                                  |    4 
 drivers/net/netconsole.c                                                     |   49 -
 drivers/net/netdevsim/dev.c                                                  |    2 
 drivers/net/phy/dp83869.c                                                    |   13 
 drivers/net/phy/phy_device.c                                                 |    4 
 drivers/net/phy/qcom/at803x.c                                                |    2 
 drivers/net/ppp/ppp_generic.c                                                |    5 
 drivers/net/ppp/pppoe.c                                                      |    8 
 drivers/net/slip/slhc.c                                                      |   49 -
 drivers/net/usb/r8152.c                                                      |    2 
 drivers/net/usb/rtl8150.c                                                    |   12 
 drivers/net/virtio_net.c                                                     |    6 
 drivers/net/vrf.c                                                            |   15 
 drivers/net/wireless/ath/ath10k/wmi-tlv.c                                    |   26 
 drivers/net/wireless/ath/ath11k/mac.c                                        |   28 
 drivers/net/wireless/ath/ath12k/dp_htt.c                                     |   24 
 drivers/net/wireless/ath/ath12k/hal.h                                        |   31 
 drivers/net/wireless/ath/ath12k/mac.c                                        |   51 -
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c                               |   76 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c                      |   15 
 drivers/net/wireless/marvell/libertas/if_usb.c                               |   32 -
 drivers/net/wireless/marvell/libertas/if_usb.h                               |    3 
 drivers/net/wireless/marvell/mwifiex/11n_aggr.c                              |    1 
 drivers/net/wireless/mediatek/mt76/channel.c                                 |   13 
 drivers/net/wireless/mediatek/mt76/dma.c                                     |   11 
 drivers/net/wireless/mediatek/mt76/eeprom.c                                  |  154 +++-
 drivers/net/wireless/mediatek/mt76/mac80211.c                                |    1 
 drivers/net/wireless/mediatek/mt76/mt76.h                                    |    5 
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                              |   15 
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                             |    7 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                              |   47 +
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                           |    5 
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h                             |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c                         |    6 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                         |   16 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                             |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                              |   13 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                             |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                              |   66 ++
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                              |   11 
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                           |    4 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                             |   22 
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                           |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/init.c                             |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                              |    9 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                             |   22 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                              |   13 
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h                           |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/regd.c                             |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                             |   22 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                              |   44 -
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                             |  121 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                              |   51 +
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                              |    5 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                           |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c                              |   23 
 drivers/net/wireless/mediatek/mt76/npu.c                                     |    1 
 drivers/net/wireless/mediatek/mt76/scan.c                                    |   66 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c                                   |    1 
 drivers/net/wireless/realtek/rtw89/phy.c                                     |    2 
 drivers/nfc/trf7970a.c                                                       |    3 
 drivers/nvme/host/apple.c                                                    |    1 
 drivers/nvme/host/pci.c                                                      |    1 
 drivers/nvme/target/tcp.c                                                    |   51 -
 drivers/opp/core.c                                                           |    2 
 drivers/opp/debugfs.c                                                        |   20 
 drivers/pci/controller/cadence/pci-sky1.c                                    |    4 
 drivers/pci/controller/cadence/pcie-cadence-host.c                           |    7 
 drivers/pci/controller/cadence/pcie-cadence.h                                |   19 
 drivers/pci/controller/cadence/pcie-sg2042.c                                 |    2 
 drivers/pci/controller/dwc/pci-imx6.c                                        |   11 
 drivers/pci/controller/dwc/pcie-designware-debugfs.c                         |   21 
 drivers/pci/controller/dwc/pcie-designware-ep.c                              |   31 
 drivers/pci/controller/dwc/pcie-designware-host.c                            |   17 
 drivers/pci/controller/dwc/pcie-designware.c                                 |   16 
 drivers/pci/controller/dwc/pcie-designware.h                                 |    3 
 drivers/pci/controller/dwc/pcie-qcom.c                                       |   17 
 drivers/pci/controller/dwc/pcie-rcar-gen4.c                                  |    2 
 drivers/pci/controller/dwc/pcie-tegra194.c                                   |  200 +++---
 drivers/pci/controller/pcie-aspeed.c                                         |    8 
 drivers/pci/controller/pcie-mediatek-gen3.c                                  |    8 
 drivers/pci/controller/pcie-rzg3s-host.c                                     |   21 
 drivers/pci/endpoint/functions/pci-epf-test.c                                |    8 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                                |   12 
 drivers/pci/endpoint/pci-ep-msi.c                                            |    5 
 drivers/pci/npem.c                                                           |    2 
 drivers/pci/pci-driver.c                                                     |   20 
 drivers/pci/pci-sysfs.c                                                      |   28 
 drivers/pci/pci.c                                                            |   41 -
 drivers/pci/pcie/dpc.c                                                       |    1 
 drivers/pci/probe.c                                                          |    1 
 drivers/pci/setup-bus.c                                                      |   59 +
 drivers/pci/tph.c                                                            |    9 
 drivers/pcmcia/rsrc_nonstatic.c                                              |    6 
 drivers/phy/apple/atc.c                                                      |    8 
 drivers/pinctrl/microchip/pinctrl-mpfs-mssio.c                               |    2 
 drivers/pinctrl/nomadik/pinctrl-abx500.c                                     |    2 
 drivers/pinctrl/pinconf-generic.c                                            |    7 
 drivers/pinctrl/pinctrl-cy8c95x0.c                                           |   27 
 drivers/pinctrl/pinctrl-pic32.c                                              |   20 
 drivers/pinctrl/realtek/pinctrl-rtd.c                                        |    2 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                      |    7 
 drivers/pinctrl/sophgo/pinctrl-sg2042.c                                      |    2 
 drivers/pinctrl/sophgo/pinctrl-sg2044.c                                      |    2 
 drivers/platform/chrome/chromeos_tbmc.c                                      |    6 
 drivers/platform/surface/surfacepro3_button.c                                |    1 
 drivers/platform/wmi/core.c                                                  |   36 -
 drivers/platform/x86/asus-wmi.c                                              |   50 -
 drivers/platform/x86/barco-p50-gpio.c                                        |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c                  |   34 -
 drivers/platform/x86/dell/dell_rbu.c                                         |    6 
 drivers/platform/x86/hp/hp-wmi.c                                             |   93 ++
 drivers/platform/x86/intel/vsec_tpmi.c                                       |   10 
 drivers/platform/x86/lenovo/wmi-capdata.c                                    |    8 
 drivers/platform/x86/lenovo/wmi-capdata.h                                    |   20 
 drivers/platform/x86/lenovo/wmi-events.c                                     |    2 
 drivers/platform/x86/lenovo/wmi-gamezone.c                                   |    3 
 drivers/platform/x86/lenovo/wmi-gamezone.h                                   |   20 
 drivers/platform/x86/lenovo/wmi-helpers.c                                    |    4 
 drivers/platform/x86/lenovo/wmi-helpers.h                                    |   13 
 drivers/platform/x86/lenovo/wmi-other.c                                      |  190 ++++--
 drivers/platform/x86/panasonic-laptop.c                                      |    5 
 drivers/pmdomain/imx/scu-pd.c                                                |    1 
 drivers/pmdomain/ti/omap_prm.c                                               |    1 
 drivers/power/supply/max77705_charger.c                                      |   36 -
 drivers/pwm/pwm-atmel-tcb.c                                                  |   38 +
 drivers/pwm/pwm-stm32.c                                                      |   22 
 drivers/regulator/fp9931.c                                                   |    2 
 drivers/remoteproc/imx_rproc.c                                               |    6 
 drivers/remoteproc/xlnx_r5_remoteproc.c                                      |    2 
 drivers/resctrl/mpam_devices.c                                               |  122 +--
 drivers/resctrl/mpam_internal.h                                              |    6 
 drivers/reset/amlogic/reset-meson.c                                          |    1 
 drivers/rtc/rtc-abx80x.c                                                     |    2 
 drivers/s390/cio/cio.h                                                       |    5 
 drivers/s390/cio/css.c                                                       |   34 -
 drivers/s390/crypto/ap_bus.c                                                 |   34 -
 drivers/s390/crypto/ap_bus.h                                                 |    1 
 drivers/s390/crypto/ap_queue.c                                               |   24 
 drivers/scsi/hpsa.h                                                          |    4 
 drivers/scsi/qla2xxx/qla_attr.c                                              |   62 +
 drivers/scsi/qla2xxx/qla_init.c                                              |    2 
 drivers/scsi/qla2xxx/qla_mbx.c                                               |    9 
 drivers/scsi/sg.c                                                            |   31 
 drivers/scsi/sr.c                                                            |   11 
 drivers/scsi/sr.h                                                            |    1 
 drivers/soc/qcom/llcc-qcom.c                                                 |    2 
 drivers/soc/qcom/ocmem.c                                                     |   17 
 drivers/soc/qcom/qcom_aoss.c                                                 |    2 
 drivers/soc/qcom/ubwc_config.c                                               |    3 
 drivers/soc/tegra/cbb/tegra234-cbb.c                                         |   35 +
 drivers/soc/tegra/pmc.c                                                      |    7 
 drivers/soundwire/bus.c                                                      |    8 
 drivers/soundwire/cadence_master.c                                           |    8 
 drivers/soundwire/debugfs.c                                                  |    9 
 drivers/soundwire/intel_ace2x.c                                              |    5 
 drivers/spi/spi-amlogic-spisg.c                                              |    3 
 drivers/spi/spi-atcspi200.c                                                  |    4 
 drivers/spi/spi-axiado.c                                                     |    3 
 drivers/spi/spi-cadence-quadspi.c                                            |    4 
 drivers/spi/spi-fsl-qspi.c                                                   |    3 
 drivers/spi/spi-hisi-kunpeng.c                                               |   12 
 drivers/spi/spi-mtk-snfi.c                                                   |   14 
 drivers/spi/spi-nxp-fspi.c                                                   |    3 
 drivers/spi/spi-nxp-xspi.c                                                   |    3 
 drivers/spi/spi-rockchip.c                                                   |    3 
 drivers/spi/spi-rzv2h-rspi.c                                                 |   20 
 drivers/spi/spi-sifive.c                                                     |   29 
 drivers/staging/greybus/hid.c                                                |    2 
 drivers/staging/greybus/raw.c                                                |   92 +-
 drivers/staging/media/imx/imx-media-csi.c                                    |   44 -
 drivers/target/target_core_sbc.c                                             |    3 
 drivers/thermal/spear_thermal.c                                              |    2 
 drivers/tty/hvc/hvc_iucv.c                                                   |    2 
 drivers/tty/serial/ip22zilog.c                                               |    2 
 drivers/usb/typec/mux/ps883x.c                                               |    1 
 drivers/usb/typec/tipd/core.c                                                |    6 
 drivers/vdpa/vdpa.c                                                          |   48 -
 drivers/vfio/fsl-mc/vfio_fsl_mc.c                                            |    4 
 drivers/vfio/pci/vfio_pci_core.c                                             |   28 
 drivers/vhost/net.c                                                          |    4 
 drivers/video/backlight/sky81452-backlight.c                                 |    3 
 drivers/video/fbdev/matrox/g450_pll.c                                        |    2 
 drivers/video/fbdev/offb.c                                                   |    7 
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c                              |    3 
 drivers/virt/coco/sev-guest/sev-guest.c                                      |   12 
 drivers/xen/xen-pciback/pci_stub.c                                           |    6 
 fs/adfs/super.c                                                              |    3 
 fs/btrfs/disk-io.c                                                           |    1 
 fs/btrfs/inode.c                                                             |    5 
 fs/btrfs/reflink.c                                                           |   45 +
 fs/btrfs/relocation.c                                                        |   14 
 fs/btrfs/transaction.c                                                       |    9 
 fs/btrfs/volumes.c                                                           |    7 
 fs/ceph/addr.c                                                               |    2 
 fs/ceph/xattr.c                                                              |   17 
 fs/d_path.c                                                                  |   11 
 fs/debugfs/file.c                                                            |    7 
 fs/erofs/erofs_fs.h                                                          |    4 
 fs/erofs/inode.c                                                             |    2 
 fs/erofs/super.c                                                             |    8 
 fs/erofs/zmap.c                                                              |   19 
 fs/eventpoll.c                                                               |  126 ++--
 fs/ext4/extents-test.c                                                       |   60 +
 fs/ext4/mballoc-test.c                                                       |    6 
 fs/f2fs/gc.c                                                                 |    5 
 fs/f2fs/node.c                                                               |    3 
 fs/f2fs/super.c                                                              |   29 
 fs/f2fs/sysfs.c                                                              |    7 
 fs/fuse/dir.c                                                                |    5 
 fs/gfs2/aops.c                                                               |    5 
 fs/gfs2/inode.c                                                              |    3 
 fs/gfs2/log.c                                                                |   33 -
 fs/internal.h                                                                |    1 
 fs/lockd/svclock.c                                                           |    5 
 fs/mbcache.c                                                                 |    1 
 fs/netfs/iterator.c                                                          |   15 
 fs/nfs/blocklayout/blocklayout.c                                             |    4 
 fs/nfsd/nfs4proc.c                                                           |   18 
 fs/nfsd/nfs4state.c                                                          |   77 +-
 fs/nfsd/nfs4xdr.c                                                            |   23 
 fs/nfsd/nfsfh.c                                                              |    9 
 fs/nfsd/state.h                                                              |   13 
 fs/nfsd/xdr4.h                                                               |    1 
 fs/nilfs2/ioctl.c                                                            |    6 
 fs/notify/fanotify/fanotify_user.c                                           |   50 -
 fs/notify/mark.c                                                             |   39 +
 fs/ntfs3/attrib.c                                                            |   15 
 fs/ntfs3/inode.c                                                             |   10 
 fs/ntfs3/super.c                                                             |    7 
 fs/ocfs2/dlm/dlmdomain.c                                                     |   10 
 fs/ocfs2/ioctl.c                                                             |   18 
 fs/ocfs2/resize.c                                                            |   12 
 fs/ocfs2/xattr.c                                                             |    4 
 fs/omfs/inode.c                                                              |    6 
 fs/open.c                                                                    |   12 
 fs/pstore/ram_core.c                                                         |    4 
 fs/quota/dquot.c                                                             |   38 -
 fs/resctrl/ctrlmondata.c                                                     |    1 
 fs/smb/client/ioctl.c                                                        |    2 
 fs/smb/client/smb2file.c                                                     |    3 
 fs/smb/client/smb2transport.c                                                |   32 -
 fs/smb/server/auth.c                                                         |   11 
 fs/smb/server/connection.c                                                   |    9 
 fs/smb/server/mgmt/user_session.c                                            |   12 
 fs/smb/server/smb2pdu.c                                                      |   15 
 fs/tracefs/event_inode.c                                                     |   98 +--
 fs/xfs/xfs_zone_alloc.c                                                      |    2 
 include/acpi/actbl1.h                                                        |    6 
 include/drm/ttm/ttm_resource.h                                               |    2 
 include/dt-bindings/clock/qcom,gcc-sc8180x.h                                 |    5 
 include/dt-bindings/clock/qcom,glymur-gcc.h                                  |    1 
 include/linux/cdrom.h                                                        |    1 
 include/linux/cpufreq.h                                                      |    4 
 include/linux/cpuhotplug.h                                                   |    1 
 include/linux/dmi.h                                                          |    5 
 include/linux/dpll.h                                                         |    1 
 include/linux/fsl/mc.h                                                       |    4 
 include/linux/fsl/ntmp.h                                                     |    9 
 include/linux/hid.h                                                          |    6 
 include/linux/hid_bpf.h                                                      |   14 
 include/linux/ieee80211-eht.h                                                |    4 
 include/linux/iopoll.h                                                       |    8 
 include/linux/irqchip/arm-gic-v5.h                                           |    3 
 include/linux/moduleparam.h                                                  |   11 
 include/linux/mtd/spinand.h                                                  |    7 
 include/linux/mutex.h                                                        |    6 
 include/linux/nstree.h                                                       |    6 
 include/linux/padata.h                                                       |    8 
 include/linux/pci.h                                                          |    6 
 include/linux/pm_domain.h                                                    |    4 
 include/linux/ppp_defs.h                                                     |   16 
 include/linux/printk.h                                                       |    5 
 include/linux/quotaops.h                                                     |    9 
 include/linux/rculist.h                                                      |   29 
 include/linux/rseq.h                                                         |   35 -
 include/linux/rseq_entry.h                                                   |  122 +--
 include/linux/rseq_types.h                                                   |   13 
 include/linux/rwlock.h                                                       |    4 
 include/linux/rwlock_api_smp.h                                               |    6 
 include/linux/sched/deadline.h                                               |    9 
 include/linux/sched/signal.h                                                 |    2 
 include/linux/sched/topology.h                                               |   24 
 include/linux/spi/spi-mem.h                                                  |    8 
 include/linux/spinlock.h                                                     |    3 
 include/linux/spinlock_up.h                                                  |   20 
 include/linux/stop_machine.h                                                 |    4 
 include/linux/sunrpc/debug.h                                                 |   10 
 include/linux/sunrpc/sched.h                                                 |    3 
 include/linux/syscalls.h                                                     |    8 
 include/linux/tcp.h                                                          |    4 
 include/linux/trace_printk.h                                                 |    1 
 include/linux/vdpa.h                                                         |    4 
 include/linux/vfio.h                                                         |    2 
 include/linux/wmi.h                                                          |    4 
 include/linux/workqueue.h                                                    |   24 
 include/linux/ww_mutex.h                                                     |    4 
 include/net/bond_3ad.h                                                       |    2 
 include/net/dropreason-core.h                                                |    6 
 include/net/ip6_tunnel.h                                                     |    2 
 include/net/netfilter/nf_tables.h                                            |   13 
 include/net/pie.h                                                            |    2 
 include/net/sch_generic.h                                                    |   16 
 include/net/tcp.h                                                            |   31 
 include/net/tcp_ecn.h                                                        |    2 
 include/rdma/ib_umem.h                                                       |    1 
 include/sound/soc-component.h                                                |    4 
 include/sound/soc.h                                                          |    3 
 include/trace/events/dma_fence.h                                             |   35 -
 include/trace/events/mptcp.h                                                 |    2 
 include/trace/events/net.h                                                   |    4 
 include/trace/events/timer.h                                                 |   11 
 include/uapi/linux/if_link.h                                                 |    2 
 include/uapi/linux/iommufd.h                                                 |    5 
 include/uapi/linux/mii.h                                                     |    3 
 io_uring/io-wq.c                                                             |    3 
 io_uring/napi.c                                                              |    2 
 kernel/audit.c                                                               |    4 
 kernel/auditsc.c                                                             |    2 
 kernel/bpf/arena.c                                                           |    4 
 kernel/bpf/arraymap.c                                                        |    4 
 kernel/bpf/bpf_local_storage.c                                               |    3 
 kernel/bpf/bpf_lsm.c                                                         |    3 
 kernel/bpf/btf.c                                                             |    2 
 kernel/bpf/core.c                                                            |    2 
 kernel/bpf/devmap.c                                                          |    5 
 kernel/bpf/hashtab.c                                                         |    6 
 kernel/bpf/helpers.c                                                         |   17 
 kernel/bpf/local_storage.c                                                   |    2 
 kernel/bpf/offload.c                                                         |   10 
 kernel/bpf/syscall.c                                                         |   17 
 kernel/bpf/task_iter.c                                                       |  151 ++++
 kernel/bpf/verifier.c                                                        |  111 ++-
 kernel/cgroup/cgroup.c                                                       |   24 
 kernel/cgroup/cpuset-internal.h                                              |    6 
 kernel/cgroup/cpuset.c                                                       |   51 -
 kernel/cgroup/dmem.c                                                         |    1 
 kernel/cgroup/rdma.c                                                         |    2 
 kernel/fork.c                                                                |   23 
 kernel/futex/requeue.c                                                       |   13 
 kernel/locking/mutex.c                                                       |    4 
 kernel/module/main.c                                                         |    4 
 kernel/padata.c                                                              |  130 +---
 kernel/params.c                                                              |   27 
 kernel/printk/printk_ringbuffer.c                                            |    8 
 kernel/rseq.c                                                                |  183 +++--
 kernel/sched/core.c                                                          |   25 
 kernel/sched/cpufreq_schedutil.c                                             |    5 
 kernel/sched/deadline.c                                                      |   31 
 kernel/sched/ext.c                                                           |    4 
 kernel/sched/fair.c                                                          |   28 
 kernel/sched/membarrier.c                                                    |   11 
 kernel/sched/rt.c                                                            |   20 
 kernel/sched/topology.c                                                      |   14 
 kernel/time/hrtimer.c                                                        |   51 -
 kernel/trace/trace_branch.c                                                  |    8 
 kernel/trace/trace_events_hist.c                                             |   12 
 kernel/trace/trace_kprobe.c                                                  |    8 
 kernel/trace/trace_printk.c                                                  |    1 
 kernel/workqueue.c                                                           |   49 +
 lib/tests/kunit_iov_iter.c                                                   |   14 
 mm/Kconfig                                                                   |    1 
 mm/memblock.c                                                                |    2 
 net/bluetooth/hci_event.c                                                    |    3 
 net/bluetooth/l2cap_core.c                                                   |    8 
 net/bluetooth/sco.c                                                          |    3 
 net/bpf/test_run.c                                                           |   35 -
 net/ceph/auth_x.c                                                            |    5 
 net/ceph/crush/crush.c                                                       |    6 
 net/ceph/osdmap.c                                                            |   14 
 net/core/dev.c                                                               |  164 ++---
 net/core/filter.c                                                            |   12 
 net/core/gro.c                                                               |    4 
 net/core/neighbour.c                                                         |   10 
 net/core/netpoll.c                                                           |   19 
 net/core/page_pool.c                                                         |   10 
 net/core/skbuff.c                                                            |   15 
 net/dsa/conduit.c                                                            |   16 
 net/ipv4/ip_tunnel_core.c                                                    |    2 
 net/ipv4/netfilter/arp_tables.c                                              |   18 
 net/ipv4/netfilter/arpt_mangle.c                                             |    8 
 net/ipv4/netfilter/iptable_nat.c                                             |    4 
 net/ipv4/nexthop.c                                                           |    4 
 net/ipv4/syncookies.c                                                        |    2 
 net/ipv4/tcp.c                                                               |   64 +-
 net/ipv4/tcp_bbr.c                                                           |    6 
 net/ipv4/tcp_bic.c                                                           |    2 
 net/ipv4/tcp_cdg.c                                                           |    4 
 net/ipv4/tcp_cubic.c                                                         |    6 
 net/ipv4/tcp_dctcp.c                                                         |    2 
 net/ipv4/tcp_input.c                                                         |   52 -
 net/ipv4/tcp_metrics.c                                                       |    6 
 net/ipv4/tcp_nv.c                                                            |    4 
 net/ipv4/tcp_output.c                                                        |   44 -
 net/ipv4/tcp_plb.c                                                           |    2 
 net/ipv4/tcp_timer.c                                                         |    7 
 net/ipv4/tcp_vegas.c                                                         |    9 
 net/ipv4/tcp_westwood.c                                                      |    4 
 net/ipv4/tcp_yeah.c                                                          |    3 
 net/ipv4/udp.c                                                               |   12 
 net/ipv6/icmp.c                                                              |   10 
 net/ipv6/netfilter/ip6table_nat.c                                            |    4 
 net/ipv6/udp.c                                                               |   13 
 net/mac80211/mlme.c                                                          |    3 
 net/mptcp/protocol.c                                                         |   63 +-
 net/mptcp/protocol.h                                                         |   37 +
 net/netfilter/ipvs/ip_vs_xmit.c                                              |   19 
 net/netfilter/nf_conntrack_proto_sctp.c                                      |   10 
 net/netfilter/nf_conntrack_sip.c                                             |  160 +++--
 net/netfilter/nf_nat_amanda.c                                                |    2 
 net/netfilter/nf_nat_core.c                                                  |   10 
 net/netfilter/nf_nat_sip.c                                                   |   34 -
 net/netfilter/nf_tables_api.c                                                |  314 +++++++---
 net/netfilter/nfnetlink_osf.c                                                |   45 -
 net/netfilter/nft_ct.c                                                       |    2 
 net/netfilter/nft_fwd_netdev.c                                               |   10 
 net/netfilter/nft_osf.c                                                      |    6 
 net/netfilter/xt_mac.c                                                       |   34 -
 net/netfilter/xt_owner.c                                                     |   37 -
 net/netfilter/xt_physdev.c                                                   |   29 
 net/netfilter/xt_policy.c                                                    |    2 
 net/netfilter/xt_realm.c                                                     |    2 
 net/netfilter/xt_socket.c                                                    |   23 
 net/openvswitch/datapath.c                                                   |   35 +
 net/openvswitch/vport.c                                                      |    3 
 net/phonet/socket.c                                                          |   10 
 net/psp/psp-nl-gen.c                                                         |    4 
 net/psp/psp_nl.c                                                             |   10 
 net/rds/af_rds.c                                                             |   10 
 net/rds/connection.c                                                         |   14 
 net/rds/ib.c                                                                 |   24 
 net/rds/ib.h                                                                 |    1 
 net/rds/ib_rdma.c                                                            |    2 
 net/rds/message.c                                                            |    1 
 net/sched/act_ct.c                                                           |    8 
 net/sched/act_mirred.c                                                       |    2 
 net/sched/cls_fw.c                                                           |    6 
 net/sched/sch_cake.c                                                         |  219 +++---
 net/sched/sch_choke.c                                                        |   26 
 net/sched/sch_dualpi2.c                                                      |   32 -
 net/sched/sch_fq_codel.c                                                     |    3 
 net/sched/sch_fq_pie.c                                                       |   19 
 net/sched/sch_hhf.c                                                          |   19 
 net/sched/sch_netem.c                                                        |   76 ++
 net/sched/sch_pie.c                                                          |   52 -
 net/sched/sch_red.c                                                          |   31 
 net/sched/sch_sfb.c                                                          |   54 +
 net/sched/sch_taprio.c                                                       |   22 
 net/sctp/inqueue.c                                                           |    1 
 net/sctp/ipv6.c                                                              |    2 
 net/sctp/protocol.c                                                          |    2 
 net/sctp/sm_statefuns.c                                                      |    6 
 net/sctp/socket.c                                                            |    5 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                     |   27 
 net/tipc/msg.c                                                               |   14 
 net/tls/tls.h                                                                |    1 
 net/tls/tls_strp.c                                                           |    6 
 net/tls/tls_sw.c                                                             |    4 
 net/unix/af_unix.c                                                           |   44 +
 net/unix/unix_bpf.c                                                          |    3 
 net/vmw_vsock/virtio_transport_common.c                                      |   11 
 rust/kernel/cpufreq.rs                                                       |   13 
 rust/kernel/sync/atomic.rs                                                   |    5 
 scripts/gdb/linux/timerlist.py                                               |    2 
 scripts/package/builddeb                                                     |    8 
 security/integrity/ima/ima_crypto.c                                          |    2 
 security/integrity/ima/ima_fs.c                                              |   16 
 sound/core/compress_offload.c                                                |    7 
 sound/core/sound.c                                                           |    7 
 sound/hda/codecs/cmedia.c                                                    |    7 
 sound/hda/codecs/conexant.c                                                  |    8 
 sound/hda/codecs/realtek/alc269.c                                            |   30 
 sound/hda/codecs/side-codecs/cs35l56_hda.c                                   |   12 
 sound/hda/codecs/side-codecs/cs35l56_hda.h                                   |    1 
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c                               |   14 
 sound/hda/common/codec.c                                                     |   46 +
 sound/hda/common/hda_local.h                                                 |    1 
 sound/isa/sc6000.c                                                           |  152 ++--
 sound/soc/amd/acp-pcm-dma.c                                                  |    2 
 sound/soc/amd/acp/acp-legacy-mach.c                                          |    2 
 sound/soc/amd/acp/acp-mach-common.c                                          |   22 
 sound/soc/amd/acp/acp-mach.h                                                 |    4 
 sound/soc/amd/acp/acp-platform.c                                             |    2 
 sound/soc/amd/acp/acp-sdw-legacy-mach.c                                      |    4 
 sound/soc/amd/acp/acp-sof-mach.c                                             |    2 
 sound/soc/amd/ps/ps-pdm-dma.c                                                |    3 
 sound/soc/amd/ps/ps-sdw-dma.c                                                |    2 
 sound/soc/amd/raven/acp3x-pcm-dma.c                                          |    2 
 sound/soc/amd/renoir/acp3x-pdm-dma.c                                         |    2 
 sound/soc/amd/vangogh/acp5x-pcm-dma.c                                        |    2 
 sound/soc/amd/yc/acp6x-pdm-dma.c                                             |    2 
 sound/soc/codecs/ab8500-codec.c                                              |    6 
 sound/soc/codecs/cs35l56-shared.c                                            |    7 
 sound/soc/codecs/tas2764.c                                                   |    1 
 sound/soc/codecs/tas2770.c                                                   |    4 
 sound/soc/fsl/fsl_easrc.c                                                    |  123 ++-
 sound/soc/fsl/fsl_micfil.c                                                   |   72 +-
 sound/soc/fsl/fsl_xcvr.c                                                     |   22 
 sound/soc/generic/audio-graph-card.c                                         |    1 
 sound/soc/intel/Kconfig                                                      |    2 
 sound/soc/intel/avs/tgl.c                                                    |   38 -
 sound/soc/qcom/qdsp6/audioreach.c                                            |    5 
 sound/soc/qcom/qdsp6/topology.c                                              |    8 
 sound/soc/renesas/rcar/core.c                                                |    2 
 sound/soc/rockchip/rockchip_sai.c                                            |    4 
 sound/soc/sdca/sdca_asoc.c                                                   |   41 +
 sound/soc/sdca/sdca_class.c                                                  |   34 -
 sound/soc/sdca/sdca_fdl.c                                                    |    5 
 sound/soc/sdca/sdca_functions.c                                              |    6 
 sound/soc/soc-component.c                                                    |   10 
 sound/soc/soc-compress.c                                                     |    4 
 sound/soc/soc-pcm.c                                                          |    4 
 sound/soc/sof/compress.c                                                     |    8 
 sound/soc/sof/intel/hda-stream.c                                             |   10 
 sound/soc/sof/intel/hda.c                                                    |    3 
 sound/soc/sof/sof-priv.h                                                     |    2 
 sound/soc/sti/uniperif_player.c                                              |    9 
 sound/usb/midi.c                                                             |   12 
 sound/usb/midi2.c                                                            |   12 
 sound/usb/mixer_scarlett2.c                                                  |    2 
 sound/usb/qcom/qc_audio_offload.c                                            |   33 -
 sound/usb/quirks.c                                                           |    3 
 sound/usb/stream.c                                                           |   58 -
 sound/usb/stream.h                                                           |    3 
 tools/build/feature/Makefile                                                 |   10 
 tools/hv/Makefile                                                            |    4 
 tools/include/nolibc/arch-mips.h                                             |   15 
 tools/include/nolibc/compiler.h                                              |    8 
 tools/include/nolibc/stdio.h                                                 |  132 ++--
 tools/lib/bpf/libbpf.c                                                       |   21 
 tools/lib/bpf/relo_core.c                                                    |    2 
 tools/perf/builtin-lock.c                                                    |    2 
 tools/perf/builtin-stat.c                                                    |   69 +-
 tools/perf/builtin-trace.c                                                   |   12 
 tools/perf/pmu-events/arch/common/common/metrics.json                        |    6 
 tools/perf/pmu-events/empty-pmu-events.c                                     |  108 +--
 tools/perf/tests/parse-events.c                                              |   49 -
 tools/perf/tests/shell/data_type_profiling.sh                                |    6 
 tools/perf/tests/workloads/datasym.c                                         |    6 
 tools/perf/util/branch.h                                                     |    3 
 tools/perf/util/cgroup.c                                                     |   30 
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c                              |   51 -
 tools/perf/util/expr.c                                                       |    3 
 tools/perf/util/maps.c                                                       |   15 
 tools/perf/util/symbol-elf.c                                                 |    8 
 tools/perf/util/util.h                                                       |    1 
 tools/power/x86/turbostat/turbostat.c                                        |   96 ++-
 tools/sched_ext/scx_pair.c                                                   |   14 
 tools/sched_ext/scx_sdt.bpf.c                                                |    3 
 tools/testing/ktest/ktest.pl                                                 |   35 -
 tools/testing/selftests/arm64/gcs/gcs-util.h                                 |    6 
 tools/testing/selftests/arm64/gcs/libc-gcs.c                                 |    1 
 tools/testing/selftests/bpf/prog_tests/access_variable_array.c               |   16 
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c                          |   35 +
 tools/testing/selftests/bpf/prog_tests/snprintf.c                            |    3 
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c                       |   17 
 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c                        |    6 
 tools/testing/selftests/bpf/progs/bpf_misc.h                                 |    2 
 tools/testing/selftests/bpf/progs/bpf_smc.c                                  |   28 
 tools/testing/selftests/bpf/progs/test_access_variable_array.c               |   19 
 tools/testing/selftests/cgroup/test_memcontrol.c                             |   11 
 tools/testing/selftests/ftrace/ftracetest                                    |   18 
 tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc            |    2 
 tools/testing/selftests/ftrace/test.d/functions                              |    4 
 tools/testing/selftests/futex/functional/futex_requeue.c                     |   49 -
 tools/testing/selftests/mm/migration.c                                       |    3 
 tools/testing/selftests/namespaces/listns_efault_test.c                      |    1 
 tools/testing/selftests/net/netfilter/nft_tproxy_udp.sh                      |   14 
 tools/testing/selftests/net/packetdrill/tcp_ts_recent_invalid_ack.pkt        |    4 
 tools/testing/selftests/nolibc/nolibc-test.c                                 |   26 
 tools/testing/selftests/powerpc/vphn/Makefile                                |    2 
 tools/testing/selftests/sched_ext/exit.c                                     |    2 
 tools/testing/selftests/vfio/Makefile                                        |    2 
 tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c                    |    1 
 tools/tracing/rtla/src/common.c                                              |   48 +
 tools/tracing/rtla/src/common.h                                              |    2 
 tools/tracing/rtla/src/osnoise_hist.c                                        |    3 
 tools/tracing/rtla/src/osnoise_top.c                                         |    3 
 tools/tracing/rtla/src/timerlat_hist.c                                       |    3 
 tools/tracing/rtla/src/timerlat_top.c                                        |    3 
 tools/tracing/rtla/src/utils.c                                               |   11 
 virt/kvm/dirty_ring.c                                                        |    3 
 1071 files changed, 11680 insertions(+), 6204 deletions(-)

Aaro Koskinen (1):
      ARM: OMAP1: Fix DEBUG_LL and earlyprintk on OMAP16XX

Aaron Sacks (1):
      KVM: Reject wrapped offset in kvm_reset_dirty_gfn()

Aaron Tomlin (1):
      fs/resctrl: Report invalid domain ID when parsing io_alloc_cbm

Abd-Alrhman Masalkhi (1):
      md: remove unused static md_wq workqueue

Abdun Nihaal (1):
      mfd: mc13xxx-core: Fix memory leak in mc13xxx_add_subdevice_pdata()

Abel Vesa (1):
      arm64: dts: qcom: milos: Add missing CX power domain to GCC

Aditya Garg (1):
      tools: hv: Fix cross-compilation

Adrien Burnett (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion Laptop 16-ag0xxx

Ahmed S. Darwish (2):
      ASoC: Intel: avs: Check maximum valid CPUID leaf
      ASoC: Intel: avs: Include CPUID header at file scope

Ahsan Atta (2):
      crypto: qat - disable 4xxx AE cluster when lead engine is fused off
      crypto: qat - disable 420xx AE cluster when lead engine is fused off

Akari Tsuyukusa (3):
      arm64: dts: mediatek: mt6795: Fix gpio-ranges pin count
      arm64: dts: mediatek: mt7981b: Fix gpio-ranges pin count
      arm64: dts: mediatek: mt7986a: Fix gpio-ranges pin count

Akhil P Oommen (6):
      drm/msm/a6xx: Use barriers while updating HFI Q headers
      drm/msm/a8xx: Fix the ticks used in submit traces
      drm/msm/a6xx: Switch to preemption safe AO counter
      drm/msm/a6xx: Correct OOB usage
      drm/msm/adreno: Implement gx_is_on() for A8x
      drm/msm/a6xx: Fix gpu init from secure world

Akif (1):
      ksmbd: fix use-after-free in smb2_open during durable reconnect

Aksh Garg (2):
      PCI: dwc: ep: Fix MSI-X Table Size configuration in dw_pcie_ep_set_msix()
      PCI: dwc: ep: Mirror the max link width and speed fields to all functions

Alan Maguire (1):
      selftests/bpf: Handle !CONFIG_SMC in bpf_smc.c

Aleksa Sarai (1):
      dcache: permit dynamic_dname()s up to NAME_MAX

Aleksander Jan Bajkowski (3):
      crypto: inside-secure/eip93 - fix register definition
      crypto: inside-secure/eip93 - register hash before authenc algorithms
      crypto: eip93 - fix hmac setkey algo selection

Alex Deucher (3):
      drm/amdgpu/gfx10: look at the right prop for gfx queue priority
      drm/amdgpu/gfx11: look at the right prop for gfx queue priority
      drm/amd/display: properly handle family setting for early GC 11.5.4

Alex Mastro (1):
      vfio: selftests: fix crash in vfio_dma_mapping_mmio_test

Alexander Konyukhov (1):
      drm/komeda: fix integer overflow in AFBC framebuffer size check

Alexander Koskovich (2):
      drm/msm/dsi: rename MSM8998 DSI version from V2_2_0 to V2_0_0
      arm64: dts: qcom: sm8250: Add missing CPU7 3.09GHz OPP

Alexander Stein (1):
      arm64: dts: imx91: Remove TMU's superfluous sensor ID

Alexandre Courbot (3):
      gpu: nova-core: create falcon firmware DMA objects lazily
      gpu: nova-core: falcon: rename load parameters to reflect DMA dependency
      gpu: nova-core: firmware: fix and explain v2 header offsets computations

Alexandru Dadu (1):
      drm/imagination: Switch reset_reason fields from enum to u32

Alexei Starovoitov (1):
      bpf: Fix variable length stack write over spilled pointers

Alexey Charkov (1):
      ASoC: rockchip: rockchip_sai: Set slot width for non-TDM mode

Alexey Kodanev (1):
      nfp: fix swapped arguments in nfp_encode_basic_qdr() calls

Alexey Velichayshiy (1):
      wifi: rtw89: phy: fix uninitialized variable access in rtw89_phy_cfo_set_crystal_cap()

Allen Ye (1):
      wifi: mt76: fix backoff fields and max_power calculation

Allison Henderson (1):
      net/rds: reset op_nents when zerocopy page pin fails

Alok Tiwari (3):
      wifi: mt76: mt7996: fix FCS error flag check in RX descriptor
      soc: qcom: llcc: fix v1 SB syndrome register offset
      soc: qcom: aoss: compare against normalized cooling state

Altan Hacigumus (1):
      tcp: make probe0 timer handle expired user timeout

Amery Hung (1):
      bpf: Do not allow deleting local storage in NMI

Amir Goldstein (1):
      fsnotify: fix inode reference leak in fsnotify_recalc_mask()

Amit Machhiwal (1):
      selftests/powerpc: Suppress -Wmaybe-uninitialized with GCC 15

Anand Moon (1):
      arm64: dts: amlogic: meson-axg: Add missing cache information to cpu0

Andreas Gruenbacher (4):
      gfs2: Call unlock_new_inode before d_instantiate
      gfs2: less aggressive low-memory log flushing
      gfs2: add some missing log locking
      gfs2: prevent NULL pointer dereference during unmount

Andrew Martin (1):
      drm/amdkfd: Removed commented line for MQD queue priority

Andrey Grodzovsky (1):
      bpf: Prefer vmlinux symbols over module symbols for unqualified kprobes

Andy Shevchenko (8):
      fbdev: matroxfb: Mark variable with __maybe_unused to avoid W=1 build break
      pinctrl: cy8c95x0: remove duplicate error message
      pinctrl: cy8c95x0: Unify messages with help of dev_err_probe()
      pinctrl: cy8c95x0: Avoid returning positive values to user space
      pinctrl: pinconf-generic: Fully validate 'pinmux' property
      nfs/blocklayout: Fix compilation error (`make W=1`) in bl_write_pagelist()
      sunrpc: Kill RPC_IFDEBUG()
      sunrpc: Fix compilation error (`make W=1`) when dprintk() is no-op

AnishMulay (1):
      selftests/mm: skip migration tests if NUMA is unavailable

Annette Kobou (1):
      arm64: dts: imx8mp-kontron: Fix boot order for PMIC and RTC

Anthony Pighin (Nokia) (1):
      rtc: abx80x: Disable alarm feature if no interrupt attached

Arnaldo Carvalho de Melo (1):
      perf util: Kill die() prototype, dead for a long time

Arnd Bergmann (5):
      net: ethernet: ti-cpsw:: rename soft_reset() function
      net: ethernet: ti-cpsw: fix linking built-in code to modules
      vfio: unhide vdev->debug_root
      tracing: move __printf() attribute on __ftrace_vbprintk()
      clk: qoriq: avoid format string warning

Arthur Kiyanovski (2):
      net: ena: PHC: Fix potential use-after-free in get_timestamp
      net: ena: PHC: Check return code before setting timestamp output

Aurelien Jarno (1):
      riscv: dts: spacemit: drop incorrect pinctrl for combo PHY

Bae Yeonju (1):
      fs/adfs: validate nzones in adfs_validate_bblk()

Baochen Qiang (1):
      wifi: ath10k: fix station lookup failure during disconnect

Bard Liao (2):
      soundwire: Intel: test bus.bpt_stream before assigning it
      ASoC: SOF: Intel: add an empty adr_link

Barnabás Czémán (8):
      arm64: dts: qcom: sm6125-xiaomi-ginkgo: Remove board-id
      arm64: dts: qcom: sm6125-xiaomi-ginkgo: Correct reserved memory ranges
      arm64: dts: qcom: sm6125-xiaomi-ginkgo: Remove extcon
      arm64: dts: qcom: sm6125-xiaomi-ginkgo: Fix reserved gpio ranges
      arm64: dts: qcom: msm8953-xiaomi-vince: correct wled ovp value
      arm64: dts: qcom: msm8937-xiaomi-land: correct wled ovp value
      arm64: dts: qcom: msm8953-xiaomi-daisy: fix backlight
      arm64: dts: qcom: msm8917-xiaomi-riva: Fix board-id for all bootloader

Bart Van Assche (6):
      drbd: Balance RCU calls in drbd_adm_dump_devices()
      locking: Fix rwlock and spinlock lock context annotations
      signal: Fix the lock_task_sighand() annotation
      ww-mutex: Fix the ww_acquire_ctx function annotations
      locking: Fix rwlock support in <linux/spinlock_up.h>
      drm/fb-helper: Fix a locking bug in an error path

Ben Horgan (4):
      arm_mpam: Reset when feature configuration bit unset
      arm_mpam: Fix monitor instance selection when checking for hardware NRDY
      arm_mpam: Pretend that NRDY is always hardware managed
      arm_mpam: Improve check for whether or not NRDY is hardware managed

Benjamin Marzinski (1):
      dm-mpath: don't stop probing paths at presuspend

Benjamin Tissoires (2):
      HID: pass the buffer size to hid_report_raw_event
      HID: core: introduce hid_safe_input_report()

Biju Das (2):
      irqchip/renesas-rzg2l: Fix error path in rzg2l_irqc_common_probe()
      pinctrl: renesas: rzg2l: Fix save/restore of {IOLH,IEN,PUPD,SMT} registers

Billy Tsai (2):
      hwmon: (aspeed-g6-pwm-tach): remove redundant driver remove callback
      i3c: mipi-i3c-hci: fix IBI payload length calculation for final status

Boqun Feng (1):
      rust: sync: atomic: Remove bound `T: Sync` for `Atomic::from_ptr()`

Breno Leitao (9):
      perf stat: Fix crash on arm64
      tracing: branch: Fix inverted check on stat tracer registration
      netpoll: fix IPv6 local-address corruption
      netconsole: return count instead of strnlen(buf, count) from store callbacks
      netconsole: avoid clobbering userdatum value on truncated write
      netconsole: propagate device name truncation in dev_name_store()
      netconsole: restore userdatum value on update_userdata() failure
      workqueue: fix devm_alloc_workqueue() va_list misuse
      workqueue: Fix wq->cpu_pwq leak in alloc_and_link_pwqs() WQ_UNBOUND path

Brett Creeley (1):
      virtio_net: sync rss_trailer.max_tx_vq on queue_pairs change via VQ_PAIRS_SET

Brian Masney (2):
      irqchip/irq-pic32-evic: Address warning related to wrong printf() formatter
      clk: visconti: pll: initialize clk_init_data to zero

Cai Xinchen (2):
      dpaa2: add independent dependencies for FSL_DPAA2_SWITCH
      dpaa2: compile dpaa2 even CONFIG_FSL_DPAA2_ETH=n

Carlos Llamas (1):
      bpf: Switch CONFIG_CFI_CLANG to CONFIG_CFI

Carlos López (1):
      virt: sev-guest: Do not use host-controlled page order in cleanup path

Chad Monroe (3):
      wifi: mt76: fix deadlock in remain-on-channel
      wifi: mt76: fix multi-radio on-channel scanning
      wifi: mt76: support upgrading passive scans to active

Chaitanya Kumar Borah (1):
      drm/i915/dp: Fix VSC dynamic range signaling for RGB formats

Charles Keepax (2):
      ASoC: SDCA: Add default value for mipi-sdca-function-reset-max-delay
      ASoC: SDCA: Update counting of SU/GE DAPM routes

Charles Perry (1):
      net: phy: fix a return path in get_phy_c45_ids()

Chen Cheng (1):
      md: suppress spurious superblock update error message for dm-raid

Chen Ni (4):
      remoteproc: imx_rproc: Check return value of regmap_attach_dev() in imx_rproc_mmio_detect_mode()
      mtd: physmap_of_gemini: Fix disabled pinctrl state check
      backlight: sky81452-backlight: Check return value of devm_gpiod_get_optional() in sky81452_bl_parse_dt()
      leds: lgm-sso: Remove duplicate assignments for priv->mmap

Chen-Yu Tsai (2):
      PCI: mediatek-gen3: Prevent leaking IRQ domains when IRQ not found
      clk: sunxi-ng: sun55i-a523-r: Add missing r-spi module clock

Cheng-Yang Chou (1):
      tools/sched_ext: Fix off-by-one in scx_sdt payload zeroing

Chia-Yu Chang (1):
      net/sched: sch_dualpi2: drain both C-queue and L-queue in dualpi2_change()

Chih Kai Hsu (1):
      r8152: fix incorrect register write to USB_UPHY_XTAL

Chris Morgan (2):
      arm64: dts: rockchip: Correct Fan Supply for Gameforce Ace
      arm64: dts: rockchip: Correct Joystick Axes on Gameforce Ace

Christian A. Ehrhardt (2):
      lib: kunit_iov_iter: fix memory leaks
      ASoC: codecs: ab8500: Fix casting of private data

Christian Brauner (7):
      selftests/namespaces: remove unused utils.h include from listns_efault_test
      eventpoll: use hlist_is_singular_node() in __ep_remove()
      eventpoll: split __ep_remove()
      eventpoll: kill __ep_remove()
      eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
      eventpoll: move epi_fget() up
      eventpoll: fix ep_remove struct eventpoll / struct file UAF

Christian König (1):
      drm/amdgpu: fix AMDGPU_INFO_READ_MMR_REG

Christoph Hellwig (2):
      fs: fix archiecture-specific compat_ftruncate64
      arm64/xor: fix conflicting attributes for xor_block_template

Chuck Lever (2):
      perf tools: Fix module symbol resolution for non-zero .text sh_addr
      nfsd: use dynamic allocation for oversized NFSv4.0 replay cache

Chuyi Zhou (1):
      padata: Remove cpu online check from cpu add and removal

Cole Leavitt (2):
      pstore/ram: fix resource leak when ioremap() fails
      soundwire: bus: demote UNATTACHED state warnings to dev_dbg()

Connor Abbott (1):
      drm/msm/a6xx: Fix dumping A650+ debugbus blocks

Cosmin Ratiu (1):
      macsec: Support VLAN-filtering lower devices

Cosmin Tanislav (2):
      mtd: parsers: ofpart: call of_node_put() only in ofpart_fail path
      mtd: parsers: ofpart: call of_node_get() for dedicated subpartitions

Costa Shulyupin (1):
      tools/rtla: Generate optstring from long options

Cássio Gabriel (7):
      ALSA: core: Validate compress device numbers without dynamic minors
      ALSA: hda: Notify IEC958 Default PCM switch state changes
      ASoC: SOF: compress: return the configured codec from get_params
      ALSA: sc6000: Keep the programmed board state in card-private data
      ALSA: usb-audio: Bound MIDI 2.0 endpoint descriptor scans
      ALSA: usb-audio: Bound MIDI endpoint descriptor scans
      ALSA: usb-audio: qcom: Check offload mapping failures

Daan De Meyer (2):
      loop: fix partition scan race between udev and loop_reread_partitions()
      cdrom, scsi: sr: propagate read-only status to block layer via set_disk_ro()

DaeMyung Kang (3):
      ksmbd: destroy tree_conn_ida in ksmbd_session_destroy()
      ksmbd: destroy async_ida in ksmbd_conn_free()
      ksmbd: fix durable fd leak on ClientGUID mismatch in durable v2 open

Dai Ngo (1):
      NFSD: fix nfs4_file access extra count in nfsd4_add_rdaccess_to_wrdeleg

Damien Riégel (2):
      greybus: raw: fix use-after-free on cdev close
      greybus: raw: fix use-after-free if write is called after disconnect

Dan Carpenter (1):
      sfc: fix error code in efx_devlink_info_running_versions()

Daniel Borkmann (8):
      bpf: Fix linked reg delta tracking when src_reg == dst_reg
      bpf: Propagate error from visit_tailcall_insn
      bpf: Fix ld_{abs,ind} failure path analysis in subprogs
      bpf: Remove static qualifier from local subprog pointer
      bpf: Enforce regsafe base id consistency for BPF_ADD_CONST scalars
      bpf, arm64: Reject out-of-range B.cond targets
      bpf, arm64: Fix off-by-one in check_imm signed range check
      bpf: Fix precedence bug in convert_bpf_ld_abs alignment check

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: initialize PPE per-tag-layer MTU registers

Daniel Hodges (1):
      ima: check return value of crypto_shash_final() in boot aggregate

Daniel Jordan (1):
      padata: Put CPU offline callback in ONLINE section to allow failure

Danilo Krummrich (7):
      devres: fix missing node debug info in devm_krealloc()
      PCI: use generic driver_override infrastructure
      platform/wmi: use generic driver_override infrastructure
      vdpa: use generic driver_override infrastructure
      s390/cio: use generic driver_override infrastructure
      s390/ap: use generic driver_override infrastructure
      bus: fsl-mc: use generic driver_override infrastructure

David Arcari (1):
      tools/power turbostat: Fix unrecognized option '-P'

David Carlier (4):
      bpf: Use RCU-safe iteration in dev_map_redirect_multi() SKB path
      selftests/sched_ext: Add missing error check for exit__load()
      gpu: nova-core: fix missing colon in SEC2 boot debug message
      eventfs: Use list_add_tail_rcu() for SRCU-protected children list

David Heidelberg (1):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Mark l1a regulator as powered during boot

David Howells (1):
      netfs: Fix potential uninitialised var in netfs_extract_user_iter()

David Laight (3):
      selftests/nolibc: Fix build with host headers and libc
      tools/nolibc/printf: Change variables 'c' to 'ch' and 'tmpbuf[]' to 'outbuf[]'
      tools/nolibc/printf: Move snprintf length check to callback

David Woodhouse (1):
      x86/kexec: Push kjump return address even for non-kjump kexec

Davide Caratti (1):
      net/sched: cls_fw: fix NULL dereference of "old" filters before change()

Davidlohr Bueso (3):
      locking/mutex: Rename mutex_init_lockep()
      locking/mutex: Fix wrong comment for CONFIG_DEBUG_LOCK_ALLOC
      futex: Drop CLONE_THREAD requirement for private default hash alloc

Deepanshu Kartikey (2):
      nilfs2: reject zero bd_oblocknr in nilfs_ioctl_mark_blocks_dirty()
      fs/ntfs3: fix missing run load for vcn0 in attr_data_get_block_locked()

Denis Benato (4):
      HID: asus: make asus_resume adhere to linux kernel coding standards
      HID: asus: do not abort probe when not necessary
      platform/x86: asus-wmi: adjust screenpad power/brightness handling
      platform/x86: asus-wmi: fix screenpad brightness range

Denis Rastyogin (1):
      ASoC: rsnd: Fix potential out-of-bounds access of component_dais[]

Derek J. Clark (5):
      platform/x86: lenovo-wmi-helpers: Move gamezone enums to wmi-helpers
      platform/x86: lenovo-wmi-other: Zero initialize WMI arguments
      platform/x86: lenovo-wmi-other: Fix tunable_attr_01 struct members
      platform/x86: lenovo-wmi-other: Add Attribute ID helper functions
      platform/x86: lenovo-wmi-other: Limit adding attributes to supported devices

Dmitry Baryshkov (17):
      drm/msm: add missing MODULE_DEVICE_ID definitions
      drm/msm/dpu: don't try using 2 LMs if only one DSC is available
      drm/panel: sharp-ls043t1le01: make use of prepare_prev_first
      PM: domains: De-constify fields in struct dev_pm_domain_attach_data
      drm/msm/dpu: drop INTF_0 on MSM8953
      soc: qcom: ubwc: disable bank swizzling for Glymur platform
      soc: qcom: ocmem: make the core clock optional
      soc: qcom: ocmem: register reasons for probe deferrals
      soc: qcom: ocmem: return -EPROBE_DEFER is ocmem is not available
      arm64: dts: qcom: hamoa: correct Iris corners for the MXC rail
      arm64: dts: qcom: lemans: correct Iris corners for the MXC rail
      arm64: dts: qcom: monaco: correct Iris corners for the MXC rail
      arm64: dts: qcom: sm8550: correct Iris corners for the MXC rail
      arm64: dts: qcom: sm8650: correct Iris corners for the MXC rail
      arm64: dts: qcom: sm8750: correct Iris corners for the MXC rail
      clk: qcom: dispcc-glymur: use RCG2 ops for DPTX1 AUX clock source
      clk: qcom: dispcc-sm8450: use RCG2 ops for DPTX1 AUX clock source

Dmitry Safonov (1):
      ima_fs: Correctly create securityfs files for unsupported hash algos

Dmitry Torokhov (1):
      platform/x86: barco-p50-gpio: normalize return value of gpio_get

Dudu Lu (4):
      Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp
      net/sched: act_mirred: fix wrong device for mac_header_xmit check in tcf_blockcast_redir
      macvlan: fix macvlan_get_size() not reserving space for IFLA_MACVLAN_BC_CUTOFF
      net/sched: sch_cake: fix NAT destination port not being updated in cake_update_flowkeys

Duoming Zhou (3):
      wifi: rtlwifi: pci: fix possible use-after-free caused by unfinished irq_prepare_bcn_tasklet
      wifi: mt76: mt7915: fix use-after-free bugs in mt7915_mac_dump_work()
      wifi: mt76: mt7996: fix use-after-free bugs in mt7996_mac_dump_work()

Eduard Zingerman (1):
      selftests/bpf: fix __jited_unpriv tag name

Edward Adam Davis (3):
      fs/ntfs3: prevent uninitialized lcn caused by zero len
      sched/psi: fix race between file release and pressure write
      drm: Replace old pointer to new idr

Eliot Courtney (3):
      gpu: nova-core: gsp: use empty slices instead of [0..0] ranges
      gpu: nova-core: gsp: fix improper handling of empty slot in cmdq
      gpu: nova-core: bitfield: fix broken Default implementation

Emil Tsalapatis (1):
      bpf: Allow instructions with arena source and non-arena dest registers

Emre Cecanpunar (5):
      platform/x86: hp-wmi: fix ignored return values in fan settings
      platform/x86: hp-wmi: avoid cancel_delayed_work_sync from work handler
      platform/x86: hp-wmi: use mod_delayed_work to reset keep-alive timer
      platform/x86: hp-wmi: fix u8 underflow in gpu_delta calculation
      platform/x86: hp-wmi: add locking for concurrent hwmon access

Eric Dumazet (36):
      macvlan: annotate data-races around port->bc_queue_len_used
      net: dropreason: add SKB_DROP_REASON_RECURSION_LIMIT
      net: plumb drop reasons to __dev_queue_xmit()
      net: qdisc_pkt_len_segs_init() cleanup
      net: pull headers in qdisc_pkt_len_segs_init()
      tcp: move tp->chrono_type next tp->chrono_stat[]
      tcp: inline tcp_chrono_start()
      tcp: annotate data-races in tcp_get_info_chrono_stats()
      tcp: add data-race annotations around tp->data_segs_out and tp->total_retrans
      tcp: add data-races annotations around tp->reordering, tp->snd_cwnd
      tcp: annotate data-races around tp->snd_ssthresh
      tcp: annotate data-races around tp->delivered and tp->delivered_ce
      tcp: add data-race annotations for TCP_NLA_SNDQ_SIZE
      tcp: annotate data-races around tp->bytes_sent
      tcp: annotate data-races around tp->bytes_retrans
      tcp: annotate data-races around tp->dsack_dups
      tcp: annotate data-races around tp->reord_seen
      tcp: annotate data-races around tp->srtt_us
      tcp: annotate data-races around tp->timeout_rehash
      tcp: annotate data-races around (tp->write_seq - tp->snd_nxt)
      tcp: annotate data-races around tp->plb_rehash
      ipv6: fix possible UAF in icmpv6_rcv()
      net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
      net/sched: sch_pie: annotate data-races in pie_dump_stats()
      net/sched: sch_fq_codel: remove data-races from fq_codel_dump_stats()
      net/sched: sch_red: annotate data-races in red_dump_stats()
      net/sched: sch_sfb: annotate data-races in sfb_dump_stats()
      net/sched: sch_choke: annotate data-races in choke_dump_stats()
      net/sched: sch_fq_pie: annotate data-races in fq_pie_dump_stats()
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (I)
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (II)
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (III)
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (IV)
      net/sched: sch_cake: annotate data-races in cake_dump_stats() (V)
      bonding: 3ad: implement proper RCU rules for port->aggregator
      net/sched: sch_pie: annotate more data-races in pie_dump_stats()

Erni Sri Satya Vennela (7):
      net: mana: Use pci_name() for debugfs directory naming
      net: mana: Move current_speed debugfs file to mana_init_port()
      net: mana: Init link_change_work before potential error paths in probe
      net: mana: Init gf_stats_work before potential error paths in probe
      net: mana: Guard mana_remove against double invocation
      net: mana: Don't overwrite port probe error with add_adev result
      net: mana: Fix EQ leak in mana_remove on NULL port

Ethan Tidmore (7):
      wifi: brcmfmac: Fix error pointer dereference
      drm/sun4i: backend: fix error pointer dereference
      drm/sun4i: Fix resource leaks
      iommu/riscv: Fix signedness bug
      ASoC: SOF: Intel: hda: Place check before dereference
      pinctrl: pinctrl-pic32: Fix resource leak
      usb: typec: Fix error pointer dereference

Fabrizio Castro (1):
      clk: renesas: r9a09g057: Remove entries for WDT{0,2,3}

Fangyu Yu (2):
      iommu/riscv: Add IOTINVAL after updating DDT/PDT entries
      iommu/riscv: Stop polling when CQCSR reports an error

Fedor Pchelkin (1):
      platform/x86: dell_rbu: avoid uninit value usage in packet_size_write()

Felix Gu (19):
      PCI: imx6: Fix device node reference leak in imx_pcie_probe()
      spi: nxp-xspi: Use reinit_completion() for repeated operations
      spi: nxp-fspi: Use reinit_completion() for repeated operations
      spi: fsl-qspi: Use reinit_completion() for repeated operations
      spi: axiado: Remove redundant pm_runtime_mark_last_busy() call
      PCI: sky1: Fix missing cleanup of ECAM config on probe failure
      pmdomain: ti: omap_prm: Fix a reference leak on device node
      pmdomain: imx: scu-pd: Fix device_node reference leak during ->probe()
      PCI: aspeed: Fix IRQ domain leak on platform_get_irq() failure
      pinctrl: microchip-mssio: Fix missing return in probe
      i3c: master: dw-i3c: Fix missing reset assertion in remove() callback
      i3c: master: dw-i3c: Balance PM runtime usage count on probe failure
      i3c: master: renesas: Fix memory leak in renesas_i3c_i3c_xfers()
      i3c: dw: Fix memory leak in dw_i3c_master_i3c_xfers()
      clk: imx: imx6q: Fix device node reference leak in pll6_bypassed()
      clk: imx: imx6q: Fix device node reference leak in of_assigned_ldb_sels()
      mailbox: mtk-vcp-mailbox: Fix the return value in mtk_vcp_mbox_xlate()
      spi: axiado: replace usleep_range() with udelay() in IRQ path
      spi: amlogic-spisg: initialize completion before requesting IRQ

Feng Yang (1):
      bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap

Fernando Fernandez Mancera (3):
      net_sched: fix skb memory leak in deferred qdisc drops
      netfilter: nfnetlink_osf: fix out-of-bounds read on option matching
      netfilter: nfnetlink_osf: fix potential NULL dereference in ttl check

Filipe Manana (1):
      btrfs: fix deadlock between reflink and transaction commit when using flushoncommit

Florian Westphal (8):
      netfilter: xt_socket: enable defrag after all other checks
      netfilter: nft_fwd_netdev: check ttl/hl before forwarding
      selftests: netfilter: nft_tproxy.sh: adjust to socat changes
      RDMA/core: Prefer NLA_NUL_STRING
      netfilter: conntrack: remove sprintf usage
      netfilter: nf_tables: use list_del_rcu for netlink hooks
      netfilter: nf_conntrack_sip: don't use simple_strtoul
      neigh: let neigh_xmit take skb ownership

Francesco Dolcini (2):
      arm64: dts: imx8-apalis: Fix LEDs name collision
      arm64: dts: ti: k3-am62-verdin: Fix SPI_1 GPIO CS pinctrl label

Francesco Lavra (1):
      hte: tegra194: remove Kconfig dependency on Tegra194 SoC

Frank Li (2):
      ARM: dts: imx27-eukrea: replace interrupts with interrupts-extended
      dmaengine: mxs-dma: Fix missing return value from of_dma_controller_register()

Frank Wunderlich (1):
      arm64: dts: mediatek: mt7988a-bpi-r4pro: fix model string

Frieder Schrempf (2):
      arm64: dts: imx8mp-kontron: Fix touch reset configuration on DL devices
      arm64: dts: imx8mp-kontron: Drop vmmc-supply to fix SD card on SMARC eval carrier

Gabor Juhos (2):
      dt-bindings: pinctrl: marvell,armada3710-xb-pinctrl: add missing items keyword
      arm64: dts: marvell: armada-37xx: use 'usb2-phy' in USB3 controller's phy-names

Gabriel Krisman Bertazi (1):
      udp: Force compute_score to always inline

Gal Pressman (2):
      net/mlx5e: Fix features not applied during netdev registration
      net/mlx5e: IPsec, fix ASO poll timeout with read_poll_timeout_atomic()

Gao Xiang (1):
      erofs: unify lcn as u64 for 32-bit platforms

Gary Guo (1):
      gpu: nova-core: remove redundant `.as_ref()` for `dev_*` print

Gatien Chevallier (1):
      bus: rifsc: fix RIF configuration check for peripherals

Gautham R. Shenoy (2):
      amd-pstate: Fix memory leak in amd_pstate_epp_cpu_init()
      amd-pstate: Update cppc_req_cached in fast_switch case

Geert Uytterhoeven (5):
      media: synopsys: VIDEO_DW_MIPI_CSI2RX should depend on ARCH_ROCKCHIP
      dt-bindings: interrupt-controller: arm,gic-v3: Fix EPPI range
      clk: xgene: Fix mapping leak in xgene_pllclk_init()
      lib/hexdump: print_hex_dump_bytes() calls print_hex_dump_debug()
      drm/color-mgmt: Typo s/R332/RGB332/

Geoffrey D. Bennett (1):
      ALSA: usb-audio: Exclude Scarlett 18i20 1st Gen from SKIP_IFACE_SETUP

George Abraham P (1):
      PCI/TPH: Allow TPH enable for RCiEPs

Gerd Bayer (1):
      PCI: Enable AtomicOps only if Root Port supports them

Giovanni Cabiddu (4):
      crypto: qat - fix compression instance leak
      crypto: qat - fix type mismatch in RAS sysfs show functions
      crypto: iaa - fix per-node CPU counter reset in rebalance_wq_table()
      crypto: qat - use swab32 macro

Gopi Krishna Menon (1):
      thermal/drivers/spear: Fix error condition for reading st,thermal-flags

Greg Jumper (1):
      net/rds: Restrict use of RDS/IB to the initial network namespace

Greg Kroah-Hartman (2):
      idpf: fix double free and use-after-free in aux device error paths
      Linux 7.0.10

Grzegorz Nitka (4):
      ice: fix 'adjust' timer programming for E830 devices
      ice: update PCS latency settings for E825 10G/25Gb modes
      ice: fix timestamp interrupt configuration for E825C
      ice: perform PHY soft reset for E825C ports at initialization

Guangshuo Li (1):
      drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with device_node cleanup

Gui-Dong Han (3):
      debugfs: check for NULL pointer in debugfs_create_str()
      debugfs: fix placement of EXPORT_SYMBOL_GPL for debugfs_create_str()
      soundwire: debugfs: initialize firmware_file to empty string

Guilherme G. Piccoli (1):
      ASoC: amd: acp: Add DMI quirk for Valve Steam Deck OLED

Guillaume Gonnet (1):
      dm init: ensure device probing has finished in dm-mod.waitfor=

Guopeng Zhang (4):
      cgroup/cpuset: record DL BW alloc CPU for attach rollback
      cgroup/cpuset: Reset DL migration state on can_attach() failure
      cgroup/dmem: Return -ENOMEM on failed pool preallocation
      cgroup/cpuset: Reserve DL bandwidth only for root-domain moves

Gyeyoung Baek (2):
      accel/rocket: Fix prep_bo ioctl leaking positive return from dma_resv_wait_timeout()
      drm/panfrost: Fix wait_bo ioctl leaking positive return from dma_resv_wait_timeout()

Haibo Chen (2):
      mtd: spi-nor: core: correct the op.dummy.nbytes when check read operations
      mtd: spi-nor: micron-st: add SNOR_CMD_PP_8_8_8_DTR sfdp fixup for mt35xu512aba

Haixin Xu (1):
      crypto: jitterentropy - replace long-held spinlock with mutex

Hangbin Liu (1):
      bonding: print churn state via netlink

Hans Zhang (1):
      PCI: dwc: Fix type mismatch for kstrtou32_from_user() return value

Haoyu Lu (1):
      ACPI: AGDI: fix missing newline in error message

Harikrishna Shenoy (1):
      drm/bridge: cadence: cdns-mhdp8546-core: Handle HDCP state in bridge atomic check

Hasan Basbunar (1):
      page_pool: fix memory-provider leak in page_pool_create_percpu() error path

Heiko Carstens (1):
      s390/mm: Fix phys_to_folio() usage in do_secure_storage_access()

Heiko Schocher (1):
      net: phy: dp83869: fix setting CLK_O_SEL field.

Heiko Stuebner (1):
      arm64: dts: rockchip: Make Jaguar PCIe-refclk pin use pull-up config

Heitor Alves de Siqueira (2):
      wifi: libertas: use USB anchors for tracking in-flight URBs
      wifi: libertas: don't kill URBs in interrupt context

Herbert Xu (2):
      crypto: tegra - Disable softirqs before finalizing request
      crypto: af_alg - Cap AEAD AD length to 0x80000000

Hongyan Xu (1):
      drm/amdgpu: avoid double drm_exec_fini() in userq validate

Hongyang Zhao (1):
      arm64: dts: qcom: qcs6490-rubikpi3: Use lt9611 DSI Port B

Hristo Venev (1):
      ceph: put folios not suitable for writeback

Huan He (1):
      dt-bindings: mmc: dwcmshc-sdhci: Fix resets array validation

HyungJung Joo (2):
      fs/omfs: reject s_sys_blocksize smaller than OMFS_DIR_START
      fs/mbcache: cancel shrink work before destroying the cache

Hyunwoo Kim (2):
      ksmbd: scope conn->binding slowpath to bound sessions only
      net: skbuff: propagate shared-frag marker through frag-transfer helpers

Håkon Bugge (1):
      net/rds: Optimize rds_ib_laddr_check

Ian Rogers (9):
      perf trace: Avoid an ERR_PTR in syscall_stats
      perf test type profiling: Remote typedef on struct
      perf branch: Avoid incrementing NULL
      perf lock: Fix option value type in parse_max_stack
      perf stat: Fix opt->value type for parse_cache_level
      perf metrics: Make common stalled metrics conditional on having the event
      perf cgroup: Update metric leader in evlist__expand_cgroup
      perf maps: Fix fixup_overlap_and_insert that can break sorted by name order
      perf maps: Fix copy_from that can break sorted by name order

Ido Schimmel (1):
      vrf: Fix a potential NPD when removing a port from a VRF

Igor Pylypiv (1):
      ata: libata-scsi: fix requeue of deferred ATA PASS-THROUGH commands

Ilpo Järvinen (3):
      PCI: Prevent shrinking bridge window from its required size
      PCI: Fix premature removal from realloc_head list during resource assignment
      PCI: Fix alignment calculation for resource size larger than align

Ilya Leoshkevich (1):
      s390/bpf: Zero-extend bpf prog return values and kfunc arguments

Inochi Amaoto (2):
      pinctrl: sophgo: pinctrl-sg2042: Fix wrong module description
      pinctrl: sophgo: pinctrl-sg2044: Fix wrong module description

Ivan Vecera (1):
      dpll: export __dpll_pin_change_ntf() for use under dpll_lock

Jackie Liu (2):
      block: fix zones_cond memory leak on zone revalidation error paths
      blk-cgroup: fix disk reference leak in blkcg_maybe_throttle_current()

Jacob Keller (2):
      ice: fix ready bitmap check for non-E822 devices
      ice: fix ice_ptp_read_tx_hwtstamp_status_eth56g

Jacob Pan (1):
      iommufd: vfio compatibility extension check for noiommu mode

Jaegeuk Kim (1):
      f2fs: allow empty mount string for Opt_usr|grp|projjquota

Jagadeesh Kona (1):
      clk: qcom: gcc-x1e80100: Keep GCC USB QTB clock always ON

Jakub Kicinski (3):
      net: psp: check for device unregister when creating assoc
      net: psp: require admin permission for dev-set and key-rotate
      net: tls: fix strparser anchor skb leak on offload RX setup failure

Jamal Hadi Salim (1):
      net/sched: act_ct: Only release RCU read lock after ct_ft

James Calligeros (2):
      ASoC: tas2764: Mark die temp register as volatile
      ASoC: tas2770: Fix order of operations for temperature calculation

James Clark (1):
      arm64: cpufeature: Make PMUVer and PerfMon unsigned

James Morse (2):
      arm_mpam: Fix false positive assert failure during mpam_disable()
      arm_mpam: Check whether the config array is allocated before destroying it

Jan Kara (1):
      quota: Fix race of dquot_scan_active() with quota deactivation

Jane Chu (1):
      Documentation: fix a hugetlbfs reservation statement

Janne Grunau (1):
      phy: apple: apple: Use local variable for ioremap return value

Jason Gunthorpe (2):
      iommu/riscv: Add missing GENERIC_MSI_IRQ
      iommu/riscv: Remove overflows on the invalidation path

Jason-JH Lin (1):
      mailbox: mtk-cmdq: Fix CURR and END addr for task insert case

Jayesh Choudhary (2):
      drm/bridge: cadence: cdns-mhdp8546-core: Set the mhdp connector earlier in atomic_enable()
      drm/bridge: cadence: cdns-mhdp8546-core: Add mode_valid hook to drm_bridge_funcs

Jens Axboe (1):
      io_uring/napi: cap busy_poll_to 10 msec

Jernej Skrabec (1):
      drm/sun4i: mixer: Fix layer init code

Jian Zhang (3):
      ipmi: ssif_bmc: fix missing check for copy_to_user() partial failure
      ipmi: ssif_bmc: fix message desynchronization after truncated response
      ipmi: ssif_bmc: change log level to dbg in irq callback

Jianan Huang (1):
      f2fs: avoid reading already updated pages during GC

Jiayuan Chen (7):
      selftests/bpf: Fix sockmap_multi_channels reliability
      bpf: Drop task_to_inode and inet_conn_established from lsm sleepable hooks
      bpf: Fix use-after-free in offloaded map/prog info fill
      bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops
      net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master
      nexthop: fix IPv6 route referencing IPv4 nexthop
      tcp: send a challenge ACK on SEG.ACK > SND.NXT

Jiexun Wang (1):
      netfilter: xt_policy: fix strict mode inbound policy matching

Jiri Olsa (1):
      libbpf: Prevent double close and leak of btf objects

Joel Fernandes (1):
      gpu: nova-core: use checked arithmetic in FWSEC firmware parsing

Johan Hovold (4):
      drm/gma500/oaktrail_hdmi: fix i2c adapter leak on setup
      drm/gma500/oaktrail_lvds: fix hang on init failure
      drm/gma500/oaktrail_lvds: fix i2c adapter leaks on init
      spi: sifive: fix controller deregistration

John Madieu (5):
      PCI: rzg3s-host: Fix reset handling in probe error path
      PCI: rzg3s-host: Reorder reset assertion during suspend
      dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix naming properties
      spi: rzv2h-rspi: Fix silent failure in clock setup error path
      spi: rockchip: Read ISR, not IMR, to detect cs-inactive IRQ

John Ogness (1):
      printk_ringbuffer: Fix get_data() size sanity check

John Stultz (1):
      sched: Make class_schedulers avoid pushing current, and get rid of proxy_tag_curr()

Jon Hunter (4):
      arm64: tegra: Fix RTC aliases
      soc/tegra: pmc: Add kerneldoc for reboot notifier
      soc/tegra: pmc: Correct function names in kerneldoc
      soc/tegra: pmc: Add kerneldoc for wake-up variables

Jonas Gorski (1):
      mtd: spi-nor: update spi_nor_fixups::post_sfdp() documentation

Jonathan Rissanen (1):
      Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error

Jorge Marques (1):
      i3c: master: adi: Fix error propagation for CCCs

Jork Loeser (1):
      Drivers: hv: vmbus: fix hyperv_cpuhp_online variable shadowing

Jose Fernandez (Anthropic) (1):
      iommu/amd: Bounds-check devid in __rlookup_amd_iommu()

Joshua Klinesmith (1):
      ksmbd: fix use-after-free from async crypto on Qualcomm crypto engine

Josua Mayer (9):
      dt-bindings: net: dsa: nxp,sja1105: make spi-cpol optional for sja1110
      arm64: dts: imx8mp-hummingboard-pulse/cubox-m: fix vmmc gpio polarity
      arm64: dts: imx8mp-hummingboard-pulse: fix mini-hdmi dsi port reference
      arm64: dts: lx2160a: change i2c0 (iic1) pinmux mask to one bit
      arm64: dts: lx2160a: remove duplicate pinmux nodes
      arm64: dts: lx2160a: rename pinmux nodes for readability
      arm64: dts: lx2160a: add sda gpio references for i2c bus recovery
      arm64: dts: lx2160a: change zeros to hexadecimal in pinmux nodes
      arm64: dts: lx2160a: complete pinmux for rcwsr12 configuration word

Judith Mendez (3):
      arm64: dts: ti: k3-am62p5-sk: Disable MMC1 internal pulls on data pins
      arm64: dts: ti: k3-am62l3-evm: Disable MMC1 internal pulls on data pins
      arm64: dts: ti: k3-am62-lp-sk: Enable internal pulls for MMC0 data pins

Juergen Gross (1):
      x86/irqflags: Preemptively move include paravirt.h directive where it belongs

Jun Yan (1):
      arm64: dts: meson-gxl-p230: fix ethernet PHY interrupt number

Junrui Luo (5):
      dm log: fix out-of-bounds write due to region_count overflow
      ocfs2/dlm: validate qr_numregions in dlm_match_regions()
      ocfs2/dlm: fix off-by-one in dlm_match_regions() region comparison
      scsi: target: core: Fix integer overflow in UNMAP bounds check
      KVM: s390: pci: fix GAIT table indexing due to double-scaling pointer arithmetic

Justin Chen (3):
      net: bcmgenet: fix off-by-one in bcmgenet_put_txcb
      net: bcmgenet: fix leaking free_bds
      net: bcmgenet: fix racing timeout handler

K Prateek Nayak (2):
      cpufreq: Pass the policy to cpufreq_driver->adjust_perf()
      sched/topology: Compute sd_weight considering cpuset partitions

Kailang Yang (1):
      ALSA: hda/realtek - fixed speaker no sound update

Kees Cook (1):
      drm/amd/ras: Fix type size of remainder argument

Keisuke Nishimura (1):
      bpf: Fix refcount check in check_struct_ops_btf_id()

Keita Morisaki (1):
      ice: fix race condition in TX timestamp ring cleanup

Keith Busch (2):
      nvme-pci: fix missed admin queue sq doorbell write
      md/raid1,raid10: don't fail devices for invalid IO errors

Kendall Willis (1):
      arm64: dts: ti: k3-am62l: include WKUP_UART0 in wakeup peripheral window

Kent Russell (1):
      drm/amdgpu: Only send RMA CPER when threshold is exceeded

Khairul Anuar Romli (2):
      dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
      dmaengine: dw-axi-dmac: Remove unnecessary return statement from void function

Kohei Enju (4):
      ice: fix potential NULL pointer deref in error path of ice_set_ringparam()
      i40e: don't advertise IFF_SUPP_NOFCS
      net: validate skb->napi_id in RX tracepoints
      vhost_net: fix sleeping with preempt-disabled in vhost_net_busy_poll()

Koichiro Den (4):
      PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ unwind
      PCI: endpoint: pci-epf-test: Don't free doorbell IRQ unless requested
      PCI: endpoint: pci-ep-msi: Fix error unwind and prevent double alloc
      PCI: dwc: rcar-gen4: Change EPC BAR alignment to 4K as per the documentation

Konrad Dybcio (12):
      arm64: dts: qcom: talos: Add missing clock-names to GCC
      arm64: dts: qcom: kaanapali: Fix GIC_ITS range length
      arm64: dts: qcom: milos: Fix GIC_ITS range length
      arm64: dts: qcom: sm8450: Fix GIC_ITS range length
      arm64: dts: qcom: sm8550: Fix GIC_ITS range length
      arm64: dts: qcom: sm8650: Fix GIC_ITS range length
      arm64: dts: qcom: sm8750: Fix GIC_ITS range length
      clk: qcom: dispcc-glymur: Fix DSI byte clock rate setting
      clk: qcom: dispcc-kaanapali: Fix DSI byte clock rate setting
      clk: qcom: dispcc-milos: Fix DSI byte clock rate setting
      clk: qcom: dispcc-sm4450: Fix DSI byte clock rate setting
      clk: qcom: dispcc[01]-sa8775p: Fix DSI byte clock rate setting

Konstantin Khorenko (1):
      net: fix skb_ext_total_length() BUILD_BUG_ON with CONFIG_GCOV_PROFILE_ALL

Krishna Chaitanya Chundru (1):
      PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support

Krishna Chomal (1):
      platform/x86: hp-wmi: fix fan table parsing

Krzysztof Kozlowski (3):
      workqueue: devres: Add device-managed allocate workqueue
      power: supply: max77705: Drop duplicated IRQ error message
      power: supply: max77705: Free allocated workqueue and fix removal order

Kuninori Morimoto (3):
      ASoC: soc-compress: use function to clear symmetric params
      ASoC: soc-component: re-add pcm_new()/pcm_free()
      ASoC: amd: name back to pcm_new()/pcm_free()

Kuniyuki Iwashima (2):
      tcp: Don't set treq->req_usec_ts in cookie_tcp_reqsk_init().
      af_unix: Drop all SCM attributes for SOCKMAP.

Kuppuswamy Sathyanarayanan (1):
      PCI/DPC: Log AER error info for DPC/EDR uncorrectable errors

Lad Prabhakar (1):
      spi: rzv2h-rspi: Fix invalid SPR=0/BRDV=0 clock configuration

Lang Xu (1):
      bpf: Fix OOB in pcpu_init_value

Lee Jones (1):
      tipc: fix double-free in tipc_buf_append()

Lei Huang (2):
      ALSA: hda/realtek: fix bad indentation for alc269
      ALSA: hda/realtek: fix code style (ERROR: else should follow close brace '}')

Len Brown (3):
      tools/power turbostat: Fix AMD RAPL regression on big systems
      tools/power turbostat: Fix --cpu-set 0 regression on HT systems
      tools/power turbostat: Fix --cpu-set 1 regression on HT systems

Leo Yan (3):
      tools build: Correct link flags for libopenssl
      perf expr: Return -EINVAL for syntax error in expr__find_ids()
      kselftest/arm64: Include <asm/ptrace.h> for user_gcs definition

Leon Hwang (1):
      bpf: Fix abuse of kprobe_write_ctx via freplace

Leon Romanovsky (1):
      RDMA/umem: Use consistent DMA attributes when unmapping entries

Leon Yen (2):
      wifi: mt76: mt7925: Fix incorrect MLO mode in firmware control
      wifi: mt76: mt7925: fix tx power setting failure after chip reset

Li Ming (1):
      cxl/pci: Check memdev driver binding status in cxl_reset_done()

Li Xiasong (2):
      netfilter: nf_conntrack_sip: get helper before allocating expectation
      netfilter: nft_ct: fix missing expect put in obj eval

Lijo Lazar (2):
      drm/amd/pm: Fix xgmi max speed reporting
      drm/amd/pm: Add fine grained flag to SMU v13.0.6

Liu Ying (1):
      arm64: dts: imx8mp-evk: Specify ADV7535 register addresses

Lorenzo Bianconi (28):
      wifi: mt76: mt7996: Set mtxq->wcid just for primary link
      wifi: mt76: mt7996: Reset mtxq->idx if primary link is removed in mt7996_vif_link_remove()
      wifi: mt76: mt7996: Switch to the secondary link if the default one is removed
      wifi: mt76: mt7996: Clear wcid pointer in mt7996_mac_sta_deinit_link()
      wifi: mt76: mt7996: Reset ampdu_state state in case of failure in mt7996_tx_check_aggr()
      wifi: mt76: Fix memory leak destroying device
      wifi: mt76: mt7996: Fix NPU stop procedure
      wifi: mt76: npu: Add missing rx_token_size initialization
      wifi: mt76: mt7996: Add missing CHANCTX_STA_CSA property
      wifi: mt76: mt7996: Remove link pointer dependency in mt7996_mac_sta_remove_links()
      wifi: mt76: mt7996: Decrement sta counter removing the link in mt7996_mac_reset_sta_iter()
      net: airoha: Add dma_rmb() and READ_ONCE() in airoha_qdma_rx_process()
      net: airoha: Fix FE_PSE_BUF_SET configuration if PPE2 is available
      net: airoha: Add missing RX_CPU_IDX() configuration in airoha_qdma_cleanup_rx_queue()
      net: airoha: Fix VIP configuration for AN7583 SoC
      net: airoha: Add missing PPE configurations in airoha_ppe_hw_init()
      net: airoha: Wait for NPU PPE configuration to complete in airoha_ppe_offload_setup()
      net: airoha: Fix possible TX queue stall in airoha_qdma_tx_napi_poll()
      net: airoha: Move ndesc initialization at end of airoha_qdma_init_tx()
      net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()
      net: airoha: Move ndesc initialization at end of airoha_qdma_init_rx_queue()
      net: airoha: Rework the code flow in airoha_remove() and in airoha_probe() error path
      net: airoha: Add size check for TX NAPIs in airoha_qdma_cleanup()
      net: airoha: fix BQL imbalance in TX path
      net: airoha: stop net_device TX queue before updating CPU index
      net: airoha: Do not wake all netdev TX queues in airoha_qdma_wake_netdev_txqs()
      net: airoha: Do not read uninitialized fragment address in airoha_dev_xmit()
      net: airoha: Do not return err in ndo_stop() callback

Luca Weiss (3):
      net: ipa: Fix programming of QTIME_TIMESTAMP_CFG
      net: ipa: Fix decoding EV_PER_EE for IPA v5.0+
      arm64: dts: qcom: sm7225-fairphone-fp4: Fix conflicting bias pinctrl

Luis Henriques (1):
      fuse: fix uninit-value in fuse_dentry_revalidate()

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU

Luke Wang (1):
      arm64: dts: imx91-11x11-evk: change usdhc tuning step for eMMC and SD

Ma Ke (1):
      powerpc/warp: Fix error handling in pika_dtm_thread

Maciej Patelczyk (1):
      drm/gpusvm: Fix unbalanced unlock in drm_gpusvm_scan_mm()

Manikanta Maddireddy (6):
      PCI: tegra194: Increase LTSSM poll time on surprise link down
      PCI: tegra194: Disable LTSSM after transition to Detect on surprise link down
      PCI: tegra194: Disable PERST# IRQ only in Endpoint mode
      PCI: tegra194: Use DWC IP core version
      PCI: dwc: Apply ECRC workaround to DesignWare 5.00a as well
      PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on

Manivannan Sadhasivam (2):
      OPP: debugfs: Use performance level if available to distinguish between rates
      PCI: dwc: Perform cleanup in the error path of dw_pcie_resume_noirq()

Mario Limonciello (1):
      Revert "ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn"

Mario Limonciello (AMD) (1):
      firmware: dmi: Correct an indexing error in dmi.h

Mark Harmstone (4):
      btrfs: fix bytes_may_use leak in move_existing_remap()
      btrfs: fix bytes_may_use leak in do_remap_reloc_trans()
      btrfs: don't clobber errors in add_remap_tree_entries()
      btrfs: fix double-decrement of bytes_may_use in submit_one_async_extent()

Mark Rutland (1):
      arm64: entry: Don't preempt with SError or Debug masked

Markus Kramer (1):
      ALSA: hda/realtek: Add quirk for Samsung Galaxy Book5 360 headphone

Masami Hiramatsu (Google) (2):
      selftests/tracing: Fix to make --logdir option work again
      selftests/tracing: Fix to check awk supports non POSIX strtonum()

Mashiro Chen (1):
      net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf

Mathias Krause (1):
      kbuild: builddeb - avoid recompiles for non-cross-compiles

Matt Evans (1):
      vfio/pci: Clean up DMABUFs before disabling function

Matt Roper (4):
      drm/xe: Consolidate workaround entries for Wa_14019877138
      drm/xe: Consolidate workaround entries for Wa_14019386621
      drm/xe/xe2_hpg: Drop invalid workaround Wa_15010599737
      drm/xe/debugfs: Correct printing of register whitelist ranges

Matt Vollrath (2):
      e1000e: Unroll PTP in probe error handling
      i40e: Cleanup PTP pins on probe failure

Matthew Auld (2):
      drm/xe/dma-buf: handle empty bo and UAF races
      drm/xe/dma-buf: fix UAF with retry loop

Matthew Brost (1):
      drm/xe: Drop registration of guc_submit_wedged_fini from xe_guc_submit_wedge()

Maurizio Lombardi (1):
      nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec() errors to its callers

Maxime Chevallier (1):
      net: phy: qcom: at803x: Use the correct bit to disable extended next page

Maíra Canal (2):
      drm/panel: ilitek-ili9882t: Select DRM_DISPLAY_DSC_HELPER
      drm/v3d: Handle error from drm_sched_entity_init()

Michael Bommarito (2):
      sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
      net/rds: zero per-item info buffer before handing it to visitors

Michael Lo (1):
      wifi: mt76: mt7921: fix 6GHz regulatory update on connection

Michael Tretter (1):
      media: staging: imx: configure src_mux in csi_start

Michal Grzedzicki (1):
      unshare: fix nsproxy leak in ksys_unshare() on set_cred_ucounts() failure

Michal Koutný (1):
      sched/rt: Skip group schedulable check with rt_group_sched=0

Michal Luczaj (3):
      bpf, sockmap: Fix af_unix iter deadlock
      bpf, sockmap: Fix af_unix null-ptr-deref in proto update
      bpf, sockmap: Take state lock for af_unix iter

Michal Schmidt (1):
      ice: fix double-free of tx_buf skb

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: fix mode mask calculation

Mike Leach (1):
      perf: tools: cs-etm: Fix print issue for Coresight debug in ETE/TRBE trace

Mike Rapoport (Microsoft) (1):
      memblock: reserve_mem: fix end caclulation in reserve_mem_release_by_name()

Mikhail Gavrilov (1):
      drm/amd/display: Wrap DCN32 phantom-plane allocation in DC_RUN_WITH_PREEMPTION_ENABLED

Mikko Perttunen (2):
      memory: tegra124-emc: Fix dll_change check
      memory: tegra30-emc: Fix dll_change check

Ming Lei (1):
      blk-cgroup: wait for blkcg cleanup before initializing new disk

Ming Wang (1):
      arm64: dts: rockchip: Fix Bluetooth stability on LCKFB TaiShan Pi

Ming Yen Hsieh (2):
      wifi: mt76: mt7925: prevent NULL pointer dereference in mt7925_tx_check_aggr()
      wifi: mt76: mt7925: prevent NULL vif dereference in mt7925_mac_write_txwi

Ming-Hung Tsai (8):
      dm cache: fix null-deref with concurrent writes in passthrough mode
      dm cache: fix write path cache coherency in passthrough mode
      dm cache: fix write hang in passthrough mode
      dm cache policy smq: fix missing locks in invalidating cache blocks
      dm cache: fix concurrent write failure in passthrough mode
      dm cache: fix dirty mapping checking in passthrough mode switching
      dm cache metadata: fix memory leak on metadata abort retry
      dm cache: fix missing return in invalidate_committed's error path

MingTao Huang (1):
      bpf: Fix stale offload->prog pointer after constant blinding

Miquel Raynal (7):
      spi: cadence-qspi: Revert the filtering of certain opcodes in ODTR
      ARM: dts: BCM5301X: Drop extra NAND controller compatible
      mtd: spinand: winbond: Clarify when to enable the HS bit
      spi: spi-mem: Add a packed command operation
      mtd: spinand: Add support for packed read data ODTR commands
      mtd: spinand: winbond: Set the packed page read flag to W35N02/04JW
      mtd: spinand: winbond: Fix ODTR write VCR on W35NxxJW

Mohsin Bashir (1):
      eth: fbnic: Use wake instead of start

Morduan Zang (2):
      net: usb: rtl8150: free skb on usb_submit_urb() failure in xmit
      net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind

Mostafa Saleh (1):
      usb: typec: ps883x: Fix Oops at unbind

Mukesh Ojha (1):
      firmware: qcom_scm: don't opencode kmemdup

Myeonghun Pak (1):
      drm/loongson: Use managed KMS polling

Mykyta Yatsenko (2):
      bpf: Use copy_map_value_locked() in alloc_htab_elem() for BPF_F_LOCK
      bpf: Fix NULL deref in map_kptr_match_type for scalar regs

Nathan Chancellor (1):
      HID: core: Fix size_t specifier in hid_report_raw_event()

Naval Alcalá (1):
      iommu/vt-d: Disable DMAR for Intel Q35 IGFX

Nicholas Carlini (1):
      io-wq: check that the predecessor is hashed in io_wq_remove_pending()

Nick Chan (1):
      nvme-apple: Reset q->sq_tail during queue init

Nicolas Escande (1):
      wifi: mac80211: handle VHT EXT NSS in ieee80211_determine_our_sta_mode()

Nicolin Chen (8):
      iommu/tegra241-cmdqv: Set supports_cmd op in tegra241_vcmdq_hw_init()
      iommu/tegra241-cmdqv: Update uAPI to clarify HYP_OWN requirement
      iommu: Fix NULL group->domain dereference in pci_dev_reset_iommu_done()
      iommu: Replace per-group resetting_domain with per-gdev blocked flag
      iommu: Fix WARN_ON in __iommu_group_set_domain_nofail() due to reset
      iommu: Fix pasid attach in pci_dev_reset_iommu_prepare/done()
      iommu: Fix nested pci_dev_reset_iommu_prepare/done()
      iommu: Fix ATS invalidation timeouts during __iommu_remove_group_pasid()

Nikola Z. Ivanov (1):
      netdevsim: zero initialize struct iphdr in dummy sk_buff

Nilesh Javali (1):
      scsi: qla2xxx: Add support to report MPI FW state

Nora Schiffer (1):
      arm64: dts: freescale: imx8mp-tqma8mpql-mba8mp-ras314: fix UART1 RTS/CTS muxing

Nícolas F. R. A. Prado (1):
      arm64: dts: mediatek: mt8365: Describe infracfg-nao as a pure syscon

Olga Kornievskaia (3):
      nfsd: fix GET_DIR_DELEGATION when VFS leases are disabled
      nfsd: update mtime/ctime on CLONE in presense of delegated attributes
      nfsd: update mtime/ctime on COPY in presence of delegated attributes

Oliver Neukum (1):
      HID: usbhid: fix deadlock in hid_post_reset()

Ondrej Mosnacek (2):
      fanotify: avoid/silence premature LSM capability checks
      fanotify: call fanotify_events_supported() before path_permission() and security_path_notify()

Ovidiu Panait (2):
      clk: renesas: r9a09g057: Fix ordering of module clocks array
      clk: renesas: r9a09g056: Fix ordering of module clocks array

P Praneesh (1):
      wifi: ath12k: Fix legacy rate mapping for monitor mode capture

Pablo Neira Ayuso (7):
      netfilter: nft_osf: restrict it to ipv4
      netfilter: xtables: restrict several matches to inet family
      netfilter: nat: use kfree_rcu to release ops
      netfilter: arp_tables: fix IEEE1394 ARP payload parsing
      rculist: add list_splice_rcu() for private lists
      netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase
      netfilter: nf_tables: add hook transactions for device deletions

Panagiotis Petrakopoulos (1):
      ALSA: scarlett2: Add missing sentinel initializer field

Paolo Abeni (2):
      mptcp: better mptcp-level RTT estimator
      net/sched: cls_flower: revert unintended changes

Paul Chaignon (1):
      selftests/bpf: Fix reg_bounds to match new tnum-based refinement

Paul Geurts (1):
      NFC: trf7970a: Ignore antenna noise when checking for RF field

Paul Greenwalt (2):
      ice: fix PHY config on media change with link-down-on-close
      ice: fix ICE_AQ_LINK_SPEED_M for 200G

Paul Moses (1):
      crypto: ccp - copy IV using skcipher ivsize

Pauli Virtanen (2):
      Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER
      Bluetooth: btmtk: accept too short WMT FUNC_CTRL events

Paulo Alcantara (1):
      netfs: fix error handling in netfs_extract_user_iter()

Pei Xiao (4):
      spi: atcspi200: fix mutex initialization order
      spi: hisi-kunpeng: prevent infinite while() loop in hisi_spi_flush_fifo
      spi: mtk-snfi: unregister ECC engine on probe failure and remove() callback
      spi: sifive: Simplify clock handling with devm_clk_get_enabled()

Peng Fan (14):
      arm64: dts: imx8mp-debix-model-a: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-debix-som-a: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-navqp: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-icore-mx8mp: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-edm-g: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-aristainetos3a-som-v1: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-nitrogen-som: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-sr-som: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-ultra-mach-sbc: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-dhcom-som: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mp-data-modul-edm-sbc: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mm-emtop-som: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mn-tqma8mqnl: Correct PAD settings for PMIC_nINT
      arm64: dts: imx8mm-tqma8mqml: Correct PAD settings for PMIC_nINT

Pengpeng Hou (4):
      tracing: Rebuild full_name on each hist_field_name() call
      fs/ntfs3: terminate the cached volume label after UTF-8 conversion
      platform/x86: dell-wmi-sysman: bound enumeration string aggregation
      scsi: hpsa: Enlarge controller and IRQ name buffers

Pengyu Luo (3):
      drm/msm/dsi: add the missing parameter description
      drm/msm/dsi: fix bits_per_pclk
      drm/msm/dsi: fix hdisplay calculation for CMD mode panel

Peter Chiu (1):
      wifi: mt76: mt7996: fix RRO EMU configuration

Peter Zijlstra (2):
      hrtimer: Avoid pointless reprogramming in __hrtimer_start_range_ns()
      sched/topology: Fix sched_domain_span()

Petr Oros (11):
      iavf: fix wrong VLAN mask for legacy Rx descriptors L2TAG2
      iavf: rename IAVF_VLAN_IS_NEW to IAVF_VLAN_ADDING
      iavf: stop removing VLAN filters from PF on interface down
      iavf: wait for PF confirmation before removing VLAN filters
      iavf: add VIRTCHNL_OP_ADD_VLAN to success completion handler
      ice: fix NULL pointer dereference in ice_reset_all_vfs()
      ice: fix infinite recursion in ice_cfg_tx_topo via ice_init_dev_hw
      ice: fix missing SMA pin initialization in DPLL subsystem
      ice: fix SMA and U.FL pin state changes affecting paired pin
      ice: fix missing dpll notifications for SW pins
      ice: add dpll peer notification for paired SMA and U.FL pins

Petr Pavlu (1):
      module: Fix freeing of charp module parameters when CONFIG_SYSFS=n

Philip Yang (2):
      drm/amdgpu: GFX12.1 scratch memory limit up to 57-bit
      drm/amdkfd: Update queue properties for metadata ring

Piyush Sachdeva (1):
      smb: client: Use FullSessionKey for AES-256 encryption key derivation

Prathamesh Deshpande (1):
      net/mlx5: Fix HCA caps leak on notifier init failure

Puranjay Mohan (7):
      bpf: fix mm lifecycle in open-coded task_vma iterator
      bpf: switch task_vma iterator from mmap_lock to per-VMA locks
      bpf: return VMA snapshot from task_vma iterator
      bpf, arm64: Remove redundant bpf_flush_icache() after pack allocator finalize
      bpf, riscv: Remove redundant bpf_flush_icache() after pack allocator finalize
      bpf: Validate node_id in arena_alloc_pages()
      bpf, arm32: Reject BPF-to-BPF calls and callbacks in the JIT

Qiang Ma (1):
      KVM: x86: Fix Xen hypercall tracepoint argument assignment

Qingfang Deng (1):
      pppoe: drop PFC frames

Qu Wenruo (3):
      btrfs: fix the inline compressed extent check in inode_need_compress()
      btrfs: do not reject a valid running dev-replace
      btrfs: only release the dirty pages io tree after successful writes

Rafael J. Wysocki (5):
      ACPI: x86: cmos_rtc: Clean up address space handler driver
      ACPI: x86: cmos_rtc: Improve coordination with ACPI TAD driver
      platform/chrome: chromeos_tbmc: Drop wakeup source on remove
      platform/surface: surfacepro3_button: Drop wakeup source on remove
      platform/x86: panasonic-laptop: Fix OPTD notifier registration and cleanup

Rafał Miłecki (1):
      ARM: dts: mediatek: mt7623: fix efuse fallback compatible

Randy Dunlap (3):
      iopoll: fix function parameter names in read_poll_timeout_atomic()
      tty: hvc_iucv: fix off-by-one in number of supported devices
      nstree: fix func. parameter kernel-doc warnings

Raphael Zimmer (5):
      libceph: Fix potential out-of-bounds access in osdmap_decode()
      libceph: Fix potential null-ptr-deref in decode_choose_args()
      libceph: Fix potential out-of-bounds access in __ceph_x_decrypt()
      libceph: Fix potential out-of-bounds access in crush_decode()
      libceph: handle rbtree insertion error in decode_choose_args()

Ravi Bangoria (3):
      perf/amd/ibs: Account interrupt for discarded samples
      perf/amd/ibs: Preserve PhyAddrVal bit when clearing PhyAddr MSR
      perf/amd/ibs: Avoid calling perf_allow_kernel() from the IBS NMI handler

Ravi Hothi (1):
      ASoC: qcom: audioreach: explicitly enable speaker protection modules

René Rebe (1):
      PCMCIA: Fix garbled log messages for KERN_CONT

Ricardo B. Marlière (3):
      ktest: Avoid undef warning when WARNINGS_FILE is unset
      ktest: Honor empty per-test option overrides
      ktest: Run POST_KTEST hooks on failure and cancellation

Riccardo Mereu (1):
      arm64: dts: qcom: arduino-imola: fix faulty spidev node

Richard Cheng (2):
      PCI/NPEM: Set LED_HW_PLUGGABLE for hotplug-capable ports
      fwctl: Fix class init ordering to avoid NULL pointer dereference on device removal

Richard Fitzgerald (4):
      ASoC: SDCA: Fix cleanup inversion in class driver
      soundwire: cadence: Clear message complete before signaling waiting thread
      ASoC: cs35l56: Fix illegal writes to OTP_MEM registers
      ALSA: hda: cs35l56: Fix uninitialized value in cs35l56_hda_read_acpi()

Richard Genoud (1):
      mtd: rawnand: sunxi: fix sunxi_nfc_hw_ecc_read_extra_oob

Richard Zhu (2):
      PCI: imx6: Keep Root Port MSI capability with iMSI-RX to work around hardware bug
      dt-bindings: PCI: imx6q-pcie: Fix maxItems of clocks and clock-names

Ritesh Harjani (IBM) (3):
      powerpc/pgtable-frag: Fix bad page state in pte_frag_destroy
      powerpc/64s: Fix unmap race with PMD migration entries
      drivers/vfio_pci_core: Change PXD_ORDER check from switch case to if/else block

Rob Clark (6):
      drm/msm/vma: Avoid lock in VM_BIND fence signaling path
      drm/msm/a6xx: Add missing aperture_lock init
      drm/msm: Reject fb creation from _NO_SHARE objs
      drm/msm: Fix VM_BIND UNMAP locking
      drm/msm/a6xx: Fix HLSQ register dumping
      drm/msm/shrinker: Fix can_block() logic

Robby Cai (2):
      regulator: dt-bindings: fp9931: Make vin-supply property as required
      regulator: fp9931: Fix handling of mandatory "vin" supply

Robin Murphy (1):
      Revert "arm64: dts: rockchip: add SPDIF audio to Beelink A1"

Ronald Claveau (1):
      reset: amlogic: t7: Fix null reset ops

Rong Zhang (3):
      platform/x86: lenovo-wmi-helpers: Fix memory leak in lwmi_dev_evaluate_int()
      platform/x86: lenovo-wmi-other: Balance IDA id allocation and free
      platform/x86: lenovo-wmi-other: Balance component bind and unbind

Rory Little (1):
      wifi: mt76: mt7921: Place upper limit on station AID

Ryder Lee (2):
      wifi: mt76: mt7615: fix use_cts_prot support
      wifi: mt76: mt7915: fix use_cts_prot support

Sami Mujawar (1):
      virt: arm-cca-guest: fix error check for RSI_INCOMPLETE

Samiullah Khawaja (1):
      PCI: Initialize temporary device in new_id_store()

Sander Vanheule (2):
      ASoC: sti: Return errors from regmap_field_alloc()
      ASoC: sti: use managed regmap_field allocations

Sangyun Kim (1):
      pwm: atmel-tcb: Cache clock rates and mark chip as atomic

Sarika Sharma (1):
      wifi: ath12k: account TX stats only when ACK/BA status is present

Sascha Bischoff (3):
      irqchip/gic-v5: Move LPI allocation into the LPI domain
      irqchip/gic-v5: Support range allocation for LPIs
      irqchip/gic-v5: Allocate ITS parent LPIs as a range

Scott Mayhew (1):
      nfsd: fix file change detection in CB_GETATTR

Sean Christopherson (1):
      KVM: x86: Swap the dst and src operand for MOVNTDQA

Sean Wang (4):
      wifi: mt76: mt7921: Reset ampdu_state state in case of failure in mt76_connac2_tx_check_aggr()
      wifi: mt76: mt7925: drop puncturing handling from BSS change path
      wifi: mt76: mt7925: fix potential deadlock in mt7925_roc_abort_sync
      wifi: mt76: mt7921: fix potential deadlock in mt7921_roc_abort_sync

Sebastian Andrzej Siewior (1):
      futex: Prevent lockup in requeue-PI during signal/ timeout wakeup

Sebastian Brzezinka (1):
      drm/i915: skip __i915_request_skip() for already signaled requests

Sebastian Ene (1):
      firmware: arm_ffa: Use the correct buffer size during RXTX_MAP

Sebastian Krzyszkowiak (1):
      clk: imx8mq: Correct the CSI PHY sels

Sebastian Reichel (1):
      drm/panel: simple: Correct G190EAN01 prepare timing

Sechang Lim (1):
      bpf: Fix RCU stall in bpf_fd_array_map_clear()

SeongJae Park (2):
      Docs/admin-guide/mm/damn/lru_sort: fix intervals autotune parameter name
      Docs/mm/damon/index: fix typo: autoamted -> automated

Sergey Senozhatsky (1):
      zram: do not permit params change after init

Sergio Correia (2):
      audit: fix incorrect inheritable capability in CAPSET records
      audit: enforce AUDIT_LOCKED for AUDIT_TRIM and AUDIT_MAKE_EQUIV

Shawn Lin (2):
      arm64: dts: rockchip: Add mphy reset to ufshc node
      scsi: ufs: rockchip,rk3576-ufshc: dt-bindings: Add new mphy reset item

Shayne Chen (3):
      wifi: ieee80211: fix definition of EHT-MCS 15 in MRU
      wifi: mt76: mt7996: fix iface combination for different chipsets
      wifi: mt76: mt7996: fix wrong DMAD length when using MAC TXP

Shenghao Ding (1):
      ALSA: hda/tas2781: Fix incorrect bit update for non-book-zero or book 0 pages >1

Shengjiu Wang (12):
      ASoC: fsl_micfil: Add access property for "VAD Detected"
      ASoC: fsl_micfil: Fix event generation in hwvad_put_enable()
      ASoC: fsl_micfil: Fix event generation in hwvad_put_init_mode()
      ASoC: fsl_micfil: Fix event generation in micfil_range_set()
      ASoC: fsl_micfil: Fix event generation in micfil_put_dc_remover_state()
      ASoC: fsl_micfil: Fix event generation in micfil_quality_set()
      ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_arc_mode_put()
      ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_mode_put()
      ASoC: fsl_easrc: Check the variable range in fsl_easrc_iec958_put_bits()
      ASoC: fsl_easrc: Fix value type in fsl_easrc_iec958_get_bits()
      ASoC: fsl_easrc: Change the type for iec958 channel status controls
      arm64: dts: imx8dxl-evk: Use audio-graph-card2 for wm8960-2 and wm8960-3

Sherry Sun (1):
      arm64: dts: imx8mp-evk: Enable pull select bit for PCIe regulator GPIO (M.2 W_DISABLE1)

Shiji Yang (1):
      mtd: spi-nor: swp: check SR_TB flag when getting tb_mask

Shuicheng Lin (4):
      drm/xe: Fix potential NULL deref in xe_exec_queue_tlb_inval_last_fence_put_unlocked
      drm/xe: Fix error cleanup in xe_exec_queue_create_ioctl()
      drm/xe/eustall: Fix drm_dev_put called before stream disable in close
      drm/xe/gsc: Fix BO leak on error in query_compatibility_version()

Shuwei Wu (1):
      clk: spacemit: ccu_mix: fix inverted condition in ccu_mix_trigger_fc()

Sourabh Jain (2):
      powerpc/crash: fix backup region offset update to elfcorehdr
      powerpc/crash: Update backup region offset in elfcorehdr on memory hotplug

Srinivas Kandagatla (1):
      ASoC: qcom: qdsp6: topology: check widget type before accessing data

Srinivas Pandruvada (1):
      platform/x86: intel: Move debugfs register before creating devices

Srinivasan Shanmugam (8):
      drm/amd/ras: Fix NULL deref in ras_core_ras_interrupt_detected()
      drm/amdgpu: Add default case in DVI mode validation
      drm/amd/ras: Fix NULL deref in ras_core_get_utc_second_timestamp()
      drm/amdgpu: Drop redundant queue NULL check in hang detect worker
      drm/amdgpu: Remove dead negative offset check in amdgpu_virt_init_critical_region()
      drm/amd/ras: Remove redundant NULL check in pending bad-bank list iteration
      drm/amd/display: Avoid NULL dereference in dc_dmub_srv error paths
      drm/amd/display: Fix parameter mismatch in panel self-refresh helper

Stanislav Fomichev (1):
      net: dsa: remove redundant netdev_lock_ops() from conduit ethtool ops

StanleyYP Wang (2):
      wifi: mt76: mt7996: fix the behavior of radar detection
      wifi: mt76: mt7996: fix struct mt7996_mcu_uni_event

Stefan Metzmacher (1):
      Bluetooth: SCO: check for codecs->num_codecs == 1 before assigning to sco_pi(sk)->codec

Stefano Garzarella (1):
      vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting

Stephen Hemminger (6):
      net/sched: netem: fix probability gaps in 4-state loss model
      net/sched: netem: fix queue limit check to include reordered packets
      net/sched: netem: only reseed PRNG when seed is explicitly provided
      net/sched: netem: validate slot configuration
      net/sched: netem: fix slot delay calculation overflow
      net/sched: netem: check for negative latency and jitter

Steven Rostedt (2):
      eventfs: Simplify code using guard()s
      tracefs: Removed unused 'ret' variable in eventfs_iterate()

Sumit Gupta (3):
      soc/tegra: cbb: Set ERD on resume for err interrupt
      soc/tegra: cbb: Fix incorrect ARRAY_SIZE in fabric lookup tables
      soc/tegra: cbb: Fix cross-fabric target timeout lookup

Sun Jian (1):
      bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb

Syed Saba Kareem (1):
      ASoC: amd: ps: fix the pcm device numbering for acp pdm dmic

T Pratham (1):
      crypto: sa2ul - Fix AEAD fallback algorithm names

Taegu Ha (1):
      ppp: require CAP_NET_ADMIN in target netns for unattached ioctls

Takashi Iwai (1):
      ALSA: usb-audio: Fix potential leak of pd at parsing UAC3 streams

Taniya Das (2):
      dt-bindings: clock: qcom: Add GCC video axi reset clock for Glymur
      clk: qcom: gcc-glymur: Add video axi clock resets for glymur

Ted Logan (1):
      vfio: selftests: Build tests on aarch64

Tejun Heo (3):
      sched_ext: Track @p's rq lock across set_cpus_allowed_scx -> ops.set_cpumask
      sched_ext: Fix ops.cgroup_move() invocation kf_mask and rq tracking
      workqueue: Annotate alloc_workqueue_va() with __printf(1, 0)

Thomas Bogendoerfer (1):
      tty: serial: ip22zilog: Fix section mispatch warning

Thomas Falcon (1):
      perf test: Fix ratio_to_prev event parsing test

Thomas Gleixner (4):
      hrtimer: Reduce trace noise in hrtimer_start()
      rseq: Revert to historical performance killing behaviour
      rseq: Implement read only ABI enforcement for optimized RSEQ V2 mode
      rseq: Reenable performance optimizations conditionally

Thomas Hellström (3):
      drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout failure
      drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup failure
      drm/ttm: Convert -EAGAIN from dmem_cgroup_try_charge to -ENOSPC

Thomas Huth (1):
      efi/capsule-loader: fix incorrect sizeof in phys array reallocation

Thomas Richter (1):
      perf test: Skip perf data type profiling tests for s390

Thomas Weißschuh (8):
      sparc64: vdso: Link with -z noexecstack
      x86/vdso: Clean up remnants of VDSO32_NOTE_MASK
      selftests/nolibc: fix test_file_stream() on musl libc
      tools/nolibc: MIPS: fix clobbers of 'lo' and 'hi' registers on different ISAs
      tools/nolibc: avoid -Wundef warning for __STDC_VERSION__
      stop_machine: Fix the documentation for a NULL cpus argument
      x86/um: fix vDSO installation
      kbuild: Never respect CONFIG_WERROR / W=e to fixdep

Thomas Weißschuh (Schneider Electric) (1):
      scripts/gdb: timerlist: Adapt to move of tk_core

Thomas Zimmermann (1):
      sh: Include <linux/io.h> in dac.h

Thorsten Blum (2):
      crypto: atmel-aes - guard unregister on error in atmel_aes_register_algs
      iommufd/selftest: Fix page leaks in mock_viommu_{init,destroy}

Tim Michals (1):
      remoteproc: xlnx: Fix sram property parsing

Timur Kristóf (17):
      drm/amd/pm/ci: Use highest MCLK on CI when MCLK DPM is disabled
      drm/amd/pm/ci: Disable MCLK DPM on problematic CI ASICs
      drm/amd/pm/smu7: Fix SMU7 voltage dependency on display clock
      drm/amd/pm/ci: Fix powertune defaults for Hawaii 0x67B0
      drm/amd/pm/ci: Clear EnabledForActivity field for memory levels
      drm/amd/pm/ci: Fill DW8 fields from SMC
      drm/amd/pm/smu7: Add SCLK cap for quirky Hawaii board
      drm/amdgpu/uvd4.2: Don't initialize UVD 4.2 when DPM is disabled
      drm/amdgpu/gmc: Fix AMDGPU_GART_PLACEMENT_LOW to not overlap with VRAM
      drm/amdgpu/uvd3.1: Don't validate the firmware when already validated
      drm/amdgpu/gfx6: Support harvested SI chips with disabled TCCs (v2)
      drm/amd/display: Allow embedded connectors without DDC
      drm/amd/display: Allow DCE link encoder without AUX registers
      drm/amd/display: Allow constructing DCE6 link encoder without DDC
      drm/amd/display: Allow constructing DCE8 link encoder without DDC
      drm/amd/display: Read EDID from VBIOS embedded panel info
      drm/amd/display: Use EDID from VBIOS embedded panel info

Tiwei Bie (1):
      um: Fix potential race condition in TLB sync

Tobias Heider (1):
      arm64: dts: qcom: add missing denali-oled.dtb to Makefile

Tomas Glozar (1):
      rtla: Fix segfault on multiple SIGINTs

Tony Luck (2):
      ACPICA: Provide #defines for EINJV2 error types
      ACPI: APEI: EINJ: Fix EINJV2 memory error injection

Tvrtko Ursulin (2):
      dma-fence: Fix sparse warnings due __rcu annotations
      drm/xe/xelp: Fix Wa_18022495364

Uday Shankar (1):
      ublk: reset per-IO canceled flag on each fetch

Uwe Kleine-König (1):
      pwm: stm32: Fix rounding issue for requests with inverted polarity

Val Packett (7):
      drm/virtio: Allow importing prime buffers when 3D is enabled
      dt-bindings: clock: qcom,gcc-sc8180x: Add missing GDSCs
      clk: qcom: gcc-sc8180x: Add missing GDSCs
      clk: qcom: gcc-sc8180x: Use retention for USB power domains
      clk: qcom: gcc-sc8180x: Use retention for PCIe power domains
      clk: qcom: dispcc-sm8250: Use shared ops on the mdss vsync clk
      clk: qcom: dispcc-sm8250: Enable parents for pixel clocks

Vasant Hegde (1):
      iommu/amd: Fix clone_alias() to use the original device's devid

Venkat Rao Bagalkote (1):
      selftests/bpf: Remove test_access_variable_array

Viacheslav Dubeyko (2):
      ceph: fix a buffer leak in __ceph_setxattr()
      ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to stale blob size

Vidya Sagar (8):
      PCI: tegra194: Fix polling delay for L2 state
      PCI: tegra194: Don't force the device into the D0 state before L2
      PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
      PCI: tegra194: Disable direct speed change for Endpoint mode
      PCI: tegra194: Set LTR message request before PCIe link up in Endpoint mode
      PCI: tegra194: Allow system suspend when the Endpoint link is not up
      PCI: tegra194: Free up Endpoint resources during remove()
      PCI: tegra194: Disable L1.2 capability of Tegra234 EP

Vijendar Mukunda (1):
      ASoC: amd: acp: update dmic_num logic for acp pdm dmic

Vikas Gupta (2):
      bnge: fix initial HWRM sequence
      bnge: remove unsupported backing store type

Ville Syrjälä (1):
      drm/i915/wm: Verify the correct plane DDB entry

Vincent Guittot (2):
      sched/fair: Fix wakeup_preempt_fair() vs delayed dequeue
      sched/fair: Fix wakeup_preempt_fair() for not waking up task

Vinicius Costa Gomes (1):
      net/sched: taprio: fix use-after-free in advance_sched() on schedule switch

Viresh Kumar (1):
      OPP: Move break out of scoped_guard in dev_pm_opp_xlate_required_opp()

Vladimir Zapolskiy (8):
      media: i2c: og01a1b: Fix V4L2 subdevice data initialization on probe
      arm64: dts: qcom: sm8550: Fix xo clock supply of platform SD host controller
      arm64: dts: qcom: sm8650: Fix xo clock supply of SD host controller
      arm64: dts: qcom: hamoa: Fix xo clock supply of platform SD host controller
      arm64: dts: qcom: sm8450: Enable UHS-I SDR50 and SDR104 SD card modes
      arm64: dts: qcom: sm8550: Enable UHS-I SDR50 and SDR104 SD card modes
      arm64: dts: qcom: sm8650: Enable UHS-I SDR50 and SDR104 SD card modes
      clk: qcom: gdsc: Fix error path on registration of multiple pm subdomains

Waiman Long (1):
      selftest: memcg: skip memcg_sock test if address family not supported

Wander Lairson Costa (1):
      rtla/utils: Fix resource leak in set_comm_sched_attr()

Wang Wensheng (1):
      arm64: kexec: Remove duplicate allocation for trans_pgd

Wei Fang (2):
      net: enetc: correct the command BD ring consumer index
      net: enetc: fix NTMP DMA use-after-free issue

Weiming Shi (7):
      bpf: fix end-of-list detection in cgroup_storage_get_next_key()
      bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()
      openvswitch: cap upcall PID array size and pre-size vport replies
      slip: reject VJ receive packets on instances with no rstate array
      slip: bound decode() reads against the compressed packet length
      net/sched: taprio: fix NULL pointer dereference in class dump
      bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()

Wenkai Lin (1):
      crypto: hisilicon/sec2 - prevent req used-after-free for sec

Wentao Guan (1):
      arm64/scs: Fix potential sign extension issue of advance_loc4

Wesley Atwell (1):
      crypto: simd - reject compat registrations without __ prefixes

White Lewis (1):
      clk: qcom: dispcc-sc8280xp: remove CLK_SET_RATE_PARENT from byte_div_clk_src dividers

Wilfred Mallawa (1):
      xfs: fix memory leak on error in xfs_alloc_zone_info()

William A. Kennington III (1):
      net: mctp i2c: check length before marking flow active

William Bowling (1):
      net: skbuff: preserve shared-frag marker during coalescing

Wolfram Sang (6):
      mailbox: mailbox-test: free channels on probe error
      mailbox: add sanity check for channel array
      mailbox: mailbox-test: handle channel errors consistently
      mailbox: mailbox-test: don't free the reused channel
      mailbox: mailbox-test: initialize struct earlier
      mailbox: mailbox-test: make data_ready a per-instance variable

Xiang Mei (1):
      netfilter: nfnetlink_osf: fix divide-by-zero in OSF_WSS_MODULO

Xianwei Zhao (1):
      irqchip/meson-gpio: Use the correct register in meson_s4_gpio_irq_set_type()

Xiao Ni (1):
      md/raid1: fix the comparing region of interval tree

Xiaoyao Li (1):
      x86/tdx: Fix the typo in TDX_ATTR_MIGRTABLE

Xin Long (5):
      sctp: fix missing encap_port propagation for GSO fragments
      sctp: disable BH before calling udp_tunnel_xmit_skb()
      sctp: fix sockets_allocated imbalance after sk_clone()
      netfilter: skip recording stale or retransmitted INIT
      sctp: discard stale INIT after handshake completion

Xu Yang (2):
      arm64: dts: imx8qm-mek: switch Type-C connector power-role to dual
      arm64: dts: imx8qxp-mek: switch Type-C connector power-role to dual

Yang Erkun (2):
      scsi: sg: Fix sysctl sg-big-buff register during sg_init()
      scsi: sg: Resolve soft lockup issue when opening /dev/sgX

Yang Wang (1):
      drm/amd/pm: fix missing fine-grained dpm table flag on aldebaran

Yao Zi (2):
      PCI: cadence: Add flags for disabling ASPM capability for broken Root Ports
      PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports

Yaxing Guo (1):
      iommu/riscv: Skip IRQ count check when using MSI interrupts

Ye Bin (6):
      ext4: fix miss unlock 'sb->s_umount' in extents_kunit_init()
      ext4: call deactivate_super() in extents_kunit_exit()
      ext4: fix the error handling process in extents_kunit_init).
      ext4: fix possible null-ptr-deref in extents_kunit_exit()
      ext4: fix possible null-ptr-deref in mbt_kunit_exit()
      smb/client: fix possible infinite loop and oob read in symlink_data()

Yihan Ding (1):
      bpf: allow UTF-8 literals in bpf_bprintf_prepare()

Yingnan Zhang (1):
      ipvs: fix MTU check for GSO packets in tunnel mode

Yinjie Yao (17):
      drm/amdgpu/vcn: set no_user_fence for VCN v2.0 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v2.5 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v3.0 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0.3 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0.5 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v5.0.0 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v5.0.1 enc ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v3.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.3 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.5 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.1 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.3.0 ring

Yixun Lan (1):
      riscv: dts: spacemit: pcie: fix missing power regulator

Yong-Xuan Wang (1):
      irqchip/riscv-imsic: Clear interrupt move state during CPU offlining

Yongpeng Yang (2):
      f2fs: fix data loss caused by incorrect use of nat_entry flag
      f2fs: protect extension_list reading with sb_lock in f2fs_sbi_show()

Yu Kuai (6):
      md: fix array_state=clear sysfs deadlock
      md: wake raid456 reshape waiters before suspend
      md: add fallback to correct bitmap_ops on version mismatch
      md: factor bitmap creation away from sysfs handling
      md/md-bitmap: split bitmap sysfs groups
      md/md-bitmap: add a none backend for bitmap grow

Yu-Chun Lin (2):
      pinctrl: realtek: Fix function signature for config argument
      pinctrl: abx500: Fix type of 'argument' variable

Yuanjie Yang (1):
      drm/msm/dpu: fix mismatch between power and frequency

Yuho Choi (2):
      fbdev: offb: fix PCI device reference leak on probe failure
      drm/sysfb: ofdrm: fix PCI device reference leaks

Yuto Ohnuki (1):
      blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()

Yuwen Chen (1):
      selftests/futex: Fix incorrect result reporting of futex_requeue test item

Zeng Heng (1):
      arm_mpam: Ensure in_reset_state is false after applying configuration

Zhan Jun (1):
      net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()

Zhan Xusheng (2):
      erofs: include the trailing NUL in FS_IOC_GETFSLABEL
      erofs: handle 48-bit blocks/uniaddr for extra devices

Zhanjun Dong (1):
      drm/xe: Use XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET enum instead of magic number

Zhao Mengmeng (1):
      tools/sched_ext: scx_pair: fix pair_ctx indexing for CPU pairs

Zhaoyang Huang (1):
      arm64: Reserve an extra page for early kernel mapping

ZhengYuan Huang (3):
      ocfs2: fix listxattr handling when the buffer is full
      ocfs2: validate bg_bits during freefrag scan
      ocfs2: validate group add input before caching

Zhengping Zhang (1):
      net: airoha: fix typo in function name

Zhenzhong Duan (2):
      iommu/vt-d: Fix oops due to out of scope access
      iommu/vt-d: Avoid NULL pointer dereference or refcount corruption

Zhiguo Niu (1):
      f2fs: fix to preserve previous reserve_{blocks,node} value when remount

Zicheng Qu (1):
      sched/fair: Clear rel_deadline when initializing forked entities

Zilin Guan (3):
      wifi: ath11k: fix memory leaks in beacon template setup
      wifi: mwifiex: Fix memory leak in mwifiex_11n_aggregate_pkt()
      wifi: mt76: Fix memory leak after mt76_connac_mcu_alloc_sta_req()

Zoran Ilievski (1):
      net: atlantic: preserve PCI wake-from-D3 on shutdown when WOL enabled

cuitao (1):
      cgroup/rdma: fix integer overflow in rdmacg_try_charge()

haoyu.lu (2):
      bpf,arc_jit: Fix missing newline in pr_err messages
      accel/amdxdna: fix missing newline in pr_err message

songxiebing (1):
      ALSA: usb-audio: qcom: Fix incorrect type in enable_audio_stream

sunshaojie (1):
      cgroup/cpuset: Return only actually allocated CPUs during partition invalidation

wangdicheng (2):
      ALSA: hda/cmedia: Remove duplicate pin configuration parsing
      ALSA: hda/conexant: Fix missing error check for jack detection

wangguangju (1):
      perf trace: Fix IS_ERR() vs NULL check bug

谢致邦 (XIE Zhibang) (1):
      arm64: dts: rockchip: Fix RK3562 EVB2 model name



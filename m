Return-Path: <stable+bounces-61460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A4693C46A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6312E1F2120E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B05219D07A;
	Thu, 25 Jul 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dETM/AJl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5419CD17;
	Thu, 25 Jul 2024 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918379; cv=none; b=qoOX17WnI3YUs+iOFkiIgCATPLjMcF5Kj2Isr/1/XBTUfG13f1QjH16dJEAgeX6DQx1Riu9ZcynYlmmelIELl4skyWc8tFqG851GlJZKePk98A08MxJkYTm2zNXB1VWqExvTkdd1FJel8U92z1qhoLeJs8axKWid6e9a4kVa3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918379; c=relaxed/simple;
	bh=GJ68F/+PoOUcHYSYqlt5pCBKbCkdy1ioG9LuJgF/UAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYezFFDLvfCIKrxQziFH2Ghlcqc/26Wozm8UY7+VdCw+XgeyokGP4moBExMaCBsyOxZbI55J6sMe+YZ7suCds4g2u3rjGFkyXV8gFGdTpDhoBTZa3eU942G900RO9J8LFDiLx6U2t49GEdf1qQj9RTRf0LrP2eSCX4vd59FVM2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dETM/AJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D96C116B1;
	Thu, 25 Jul 2024 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721918379;
	bh=GJ68F/+PoOUcHYSYqlt5pCBKbCkdy1ioG9LuJgF/UAM=;
	h=From:To:Cc:Subject:Date:From;
	b=dETM/AJlqRVRlSS0DG2HiMdTH2dGwgfMP9lrKOqzzCvYnVDAj4zf8QaP1Ivc+0Zs3
	 i3jlDf9gHZnbpEb4f0pPRHg5vFBHZivv2ZOw2diGKyf678wNwd9kIXaK+ntQr04k7s
	 cLIbb2Wkemw2ugG3s96nCJiaqFoZEDx9kZWh8U/8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com,
	broonie@kernel.org
Subject: [PATCH 6.10 00/29] 6.10.2-rc1 review
Date: Thu, 25 Jul 2024 16:36:16 +0200
Message-ID: <20240725142731.814288796@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.2-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.10.2-rc1
X-KernelTest-Deadline: 2024-07-27T14:27+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.10.2 release.
There are 29 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.2-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.10.2-rc1

Jann Horn <jannh@google.com>
    filelock: Fix fcntl/close race recovery compat path

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: ump: Skip useless ports for static blocks

Shengjiu Wang <shengjiu.wang@nxp.com>
    ALSA: pcm_dmaengine: Don't synchronize DMA channel when DMA is paused

Krishna Kurapati <quic_kriskura@quicinc.com>
    arm64: dts: qcom: sm6115: Disable SS instance in Parkmode for USB

Krishna Kurapati <quic_kriskura@quicinc.com>
    arm64: dts: qcom: sdm845: Disable SS instance in Parkmode for USB

Krishna Kurapati <quic_kriskura@quicinc.com>
    arm64: dts: qcom: ipq8074: Disable SS instance in Parkmode for USB

Krishna Kurapati <quic_kriskura@quicinc.com>
    arm64: dts: qcom: sdm630: Disable SS instance in Parkmode for USB

Krishna Kurapati <quic_kriskura@quicinc.com>
    arm64: dts: qcom: ipq6018: Disable SS instance in Parkmode for USB

Krishna Kurapati <quic_kriskura@quicinc.com>
    arm64: dts: qcom: msm8998: Disable SS instance in Parkmode for USB

Krishna Kurapati <quic_kriskura@quicinc.com>
    arm64: dts: qcom: sm6350: Disable SS instance in Parkmode for USB

Krishna Kurapati <quic_kriskura@quicinc.com>
    arm64: dts: qcom: msm8996: Disable SS instance in Parkmode for USB

Abel Vesa <abel.vesa@linaro.org>
    arm64: dts: qcom: x1e80100-crd: Fix USB PHYs regulators

Abel Vesa <abel.vesa@linaro.org>
    arm64: dts: qcom: x1e80100-qcp: Fix the PHY regulator for PCIe 6a

Abel Vesa <abel.vesa@linaro.org>
    arm64: dts: qcom: x1e80100-crd: Fix the PHY regulator for PCIe 6a

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: qrb4210-rb2: switch I2C2 to i2c-gpio

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: qrb2210-rb1: switch I2C2 to i2c-gpio

Abel Vesa <abel.vesa@linaro.org>
    arm64: dts: qcom: x1e80100-qcp: Fix USB PHYs regulators

Krishna Kurapati <quic_kriskura@quicinc.com>
    arm64: dts: qcom: sc7280: Disable SuperSpeed instances in park mode

Krishna Kurapati <quic_kriskura@quicinc.com>
    arm64: dts: qcom: sc7180: Disable SuperSpeed instances in park mode

Seunghun Han <kkamagui@gmail.com>
    ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book Pro 360

Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
    ALSA: hda/realtek: Enable headset mic on Positivo SU C1400

Shenghao Ding <shenghao-ding@ti.com>
    ALSA: hda/tas2781: Add new quirk for Lenovo Hera2 Laptop

Takashi Iwai <tiwai@suse.de>
    usb: gadget: midi2: Fix incorrect default MIDI2 protocol setup

lei lu <llfamsec@gmail.com>
    fs/ntfs3: Validate ff offset

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Add a check for attr_names and oatbl

lei lu <llfamsec@gmail.com>
    jfs: don't walk off the end of ealist

lei lu <llfamsec@gmail.com>
    ocfs2: add bounds checking to ocfs2_check_dir_entry()

Gerald Schaefer <gerald.schaefer@linux.ibm.com>
    s390/mm: Fix VM_FAULT_HWPOISON handling in do_exception()

Dan Carpenter <dan.carpenter@linaro.org>
    drm/amdgpu: Fix signedness bug in sdma_v4_0_process_trap_irq()


-------------

Diffstat:

 Makefile                                  |  4 +--
 arch/arm64/boot/dts/qcom/ipq6018.dtsi     |  1 +
 arch/arm64/boot/dts/qcom/ipq8074.dtsi     |  2 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi     |  1 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi     |  1 +
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts  | 13 ++++++++-
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts  | 13 ++++++++-
 arch/arm64/boot/dts/qcom/sc7180.dtsi      |  1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi      |  1 +
 arch/arm64/boot/dts/qcom/sdm630.dtsi      |  1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi      |  2 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi      |  1 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi      |  1 +
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 17 +++++++++---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 17 +++++++++---
 arch/s390/mm/fault.c                      |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c    |  2 +-
 drivers/usb/gadget/function/f_midi2.c     | 19 +++++++------
 fs/jfs/xattr.c                            | 23 +++++++++++++---
 fs/locks.c                                |  9 +++---
 fs/ntfs3/fslog.c                          | 44 ++++++++++++++++++++++++-----
 fs/ocfs2/dir.c                            | 46 +++++++++++++++++++------------
 sound/core/pcm_dmaengine.c                |  6 +++-
 sound/core/seq/seq_ump_client.c           | 16 +++++++++++
 sound/pci/hda/patch_realtek.c             |  3 ++
 25 files changed, 191 insertions(+), 56 deletions(-)




Return-Path: <stable+bounces-61961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AD293DE4E
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 11:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0C028150A
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428F36F30F;
	Sat, 27 Jul 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DQBLMeNM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B536F307;
	Sat, 27 Jul 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722073386; cv=none; b=Onh+fvLN41tlS888PkagsDE47lXq8m/kuDEpwPkX+YWanhLaCK3WAEUFNJKDzrmurTuyCzcEzH0Ju12HEJe4+XSuz/yvN0x2kOpkkzIe/KqHhepB0eeaPPeUyIpBuWE/5gzYKaM8sxUay6S4Go2ZujJ9yfARn61baWoZ4hnPl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722073386; c=relaxed/simple;
	bh=R8z0C0cCxB//avUzGpPaUaKV9Ucs7PGB/xpiX73xRK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrHEdlE9mJVcbcV1BB5WjqRzqhTCOiC6TJgq/YM8kRiyiWgIRA7YxuVphZkmZUsYoM1+XbiqCLVbp4Iv5a/xy6xRkYl4f5Ss4JLdonvzb5kwpPd/mk6f9wZFGvVIkhQdUZe47u/H66Ueya1Zyic7VFaplASx2fK/pVFIIicaZ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DQBLMeNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFA8C32781;
	Sat, 27 Jul 2024 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722073385;
	bh=R8z0C0cCxB//avUzGpPaUaKV9Ucs7PGB/xpiX73xRK0=;
	h=From:To:Cc:Subject:Date:From;
	b=DQBLMeNMQ27wDCLOxEiXINhtHJpJDi439sNXb0cAjvt2AadUyBslmXTkIKZJz6Fpe
	 1AFA9N+9sS4K8pR4yQvZpA4DlzkXbjkpcchnzznyvODWSkGdgzveY3GRlheGzxwGJR
	 rdA6RluZqFLG1U6Q2fz/D6iqW+6GW/jP0Yi2c2eI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.9.12
Date: Sat, 27 Jul 2024 11:42:50 +0200
Message-ID: <2024072750-gummy-bobbed-8af6@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.9.12 kernel.

All users of the 6.9 kernel series must upgrade.

The updated 6.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.9.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                  |    2 -
 arch/arm64/boot/dts/qcom/ipq6018.dtsi     |    1 
 arch/arm64/boot/dts/qcom/ipq8074.dtsi     |    2 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi     |    1 
 arch/arm64/boot/dts/qcom/msm8998.dtsi     |    1 
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts  |   13 +++++++-
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts  |   13 +++++++-
 arch/arm64/boot/dts/qcom/sc7180.dtsi      |    1 
 arch/arm64/boot/dts/qcom/sc7280.dtsi      |    1 
 arch/arm64/boot/dts/qcom/sdm630.dtsi      |    1 
 arch/arm64/boot/dts/qcom/sdm845.dtsi      |    2 +
 arch/arm64/boot/dts/qcom/sm6115.dtsi      |    1 
 arch/arm64/boot/dts/qcom/sm6350.dtsi      |    1 
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts |   17 ++++++++---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts |   17 ++++++++---
 arch/s390/mm/fault.c                      |    3 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c    |    2 -
 drivers/net/tap.c                         |    5 +++
 drivers/net/tun.c                         |    3 +
 drivers/usb/gadget/function/f_midi2.c     |   19 +++++++-----
 fs/jfs/xattr.c                            |   23 ++++++++++++---
 fs/locks.c                                |    9 ++---
 fs/ntfs3/fslog.c                          |   44 ++++++++++++++++++++++++----
 fs/ocfs2/dir.c                            |   46 ++++++++++++++++++------------
 sound/core/pcm_dmaengine.c                |    6 +++
 sound/core/seq/seq_ump_client.c           |   16 ++++++++++
 sound/pci/hda/patch_realtek.c             |    3 +
 27 files changed, 198 insertions(+), 55 deletions(-)

Abel Vesa (4):
      arm64: dts: qcom: x1e80100-qcp: Fix USB PHYs regulators
      arm64: dts: qcom: x1e80100-crd: Fix the PHY regulator for PCIe 6a
      arm64: dts: qcom: x1e80100-qcp: Fix the PHY regulator for PCIe 6a
      arm64: dts: qcom: x1e80100-crd: Fix USB PHYs regulators

Dan Carpenter (1):
      drm/amdgpu: Fix signedness bug in sdma_v4_0_process_trap_irq()

Dmitry Baryshkov (2):
      arm64: dts: qcom: qrb2210-rb1: switch I2C2 to i2c-gpio
      arm64: dts: qcom: qrb4210-rb2: switch I2C2 to i2c-gpio

Dongli Zhang (1):
      tun: add missing verification for short frame

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Positivo SU C1400

Gerald Schaefer (1):
      s390/mm: Fix VM_FAULT_HWPOISON handling in do_exception()

Greg Kroah-Hartman (1):
      Linux 6.9.12

Jann Horn (1):
      filelock: Fix fcntl/close race recovery compat path

Konstantin Komarov (1):
      fs/ntfs3: Add a check for attr_names and oatbl

Krishna Kurapati (10):
      arm64: dts: qcom: sc7180: Disable SuperSpeed instances in park mode
      arm64: dts: qcom: sc7280: Disable SuperSpeed instances in park mode
      arm64: dts: qcom: msm8996: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: sm6350: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: msm8998: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: ipq6018: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: sdm630: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: ipq8074: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: sdm845: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: sm6115: Disable SS instance in Parkmode for USB

Seunghun Han (1):
      ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book Pro 360

Shenghao Ding (1):
      ALSA: hda/tas2781: Add new quirk for Lenovo Hera2 Laptop

Shengjiu Wang (1):
      ALSA: pcm_dmaengine: Don't synchronize DMA channel when DMA is paused

Si-Wei Liu (1):
      tap: add missing verification for short frame

Takashi Iwai (2):
      usb: gadget: midi2: Fix incorrect default MIDI2 protocol setup
      ALSA: seq: ump: Skip useless ports for static blocks

lei lu (3):
      ocfs2: add bounds checking to ocfs2_check_dir_entry()
      jfs: don't walk off the end of ealist
      fs/ntfs3: Validate ff offset



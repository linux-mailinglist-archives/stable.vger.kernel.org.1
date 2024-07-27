Return-Path: <stable+bounces-61962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA7B93DE50
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 11:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575AD283144
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 09:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3663E770E4;
	Sat, 27 Jul 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vqJsJb4E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52AE768E1;
	Sat, 27 Jul 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722073389; cv=none; b=JLmncBUPZV0dPcXQiOkLS1Os0az3+IEkWSGbbrP8e+I4/Omyu+ogpiX/9UaRvlbNwyKeYhIkavwJ7DYhoazw1qmehIQj1fHgYfu7//8/AlQR4158O9LcAAX572T+QV15jqI9rZvlZs56BjqOJ5+BpeCesUNHmPqeBBQ0Kwwb3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722073389; c=relaxed/simple;
	bh=YzcEV1UXK+zVwgXqH4GdrCFf6aTAwQsf34V6mhii6Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHY2iHssgvAnIxqjIPrOnVqVN2XDmhwSLWMDQNf1t0cMzM92ltwmRRS0Eob8PRt0vI1KyNhvnNuvKzp3j4ZVOVPZvjWpneToGDg/cl0arggso/KAaMsblebgCFfUb+nI0L9536q0mYyDXLNYEPHVQlEyWUZ1VjoG5QhrMB5ZTog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vqJsJb4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B39FC4AF09;
	Sat, 27 Jul 2024 09:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722073388;
	bh=YzcEV1UXK+zVwgXqH4GdrCFf6aTAwQsf34V6mhii6Ok=;
	h=From:To:Cc:Subject:Date:From;
	b=vqJsJb4EiY7uWuPFvh7jBUR79B7nsqJvRGQrLsnzcRqpeCKzMkeUdNfQdpWrCA0A8
	 OBgjJgUe7Q+J3rPqOaCRJ4IBjSd9WuBUmSDWESaLNrwzuouooSPiwcDH9DAX4p0X1n
	 6TLJ+nINtcHupP75KMfCx9RjSqwfyMLe86y59Dls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.2
Date: Sat, 27 Jul 2024 11:42:57 +0200
Message-ID: <2024072758-untold-deflected-6abf@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.2 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
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
      Linux 6.10.2

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



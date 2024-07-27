Return-Path: <stable+bounces-61958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF98F93DE48
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 11:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2C01F21779
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FF147F4A;
	Sat, 27 Jul 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S7VsDxmE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F0768E1;
	Sat, 27 Jul 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722073364; cv=none; b=sLQXwk/3BTHrTnhWqN1sHx/4Gk2T3ET/7ENjgkS2IN9NPAOTORRFFeBhbgJ8uZw3MBnSJZk7BCIQutLD2sAvi0QMQHS1UbbeA3k4WB9bwJbtSUR8TfPqd5di98P9/4Ux20eA4+MlAJYd4//BzjDS00NPMQ6R527lx94hR0QnKIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722073364; c=relaxed/simple;
	bh=ulbObRKxsH5Nh6wrUSOParDbrZpIJDVbbUdmPuPhkIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjbxL7kyDfmPofg1B4i1trJ+0I+WPCbkk2mB3T0yN1knZbpVKaED/h7WrZBM2MlFxHg9OBYifc/TKHnUoVe1odWn2fOcHAHpbnQQxTCLd7pGA1gWA01z19DcU0XC//NPre2Ooqw4liZQYuFBrkY8fA2ro9NvZLV32d6awksN6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S7VsDxmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B814C32781;
	Sat, 27 Jul 2024 09:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722073364;
	bh=ulbObRKxsH5Nh6wrUSOParDbrZpIJDVbbUdmPuPhkIk=;
	h=From:To:Cc:Subject:Date:From;
	b=S7VsDxmEOB0+2RYA7LTn+h4jVZFaZ9hGY28941Ps0SAvzbN1Rxo2iTpfXZHIxgLBa
	 mQuhL/xbjUNmErbFcQ3hAVIS/cAIpZ8SgL+4qsgelbgq4gnBIwerBmvs+vGpTIeTt4
	 vjC6W2EhIh6qlkSu1EtjS0pO3QI2vTU3H8pDG3oE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.43
Date: Sat, 27 Jul 2024 11:42:39 +0200
Message-ID: <2024072739-shortly-creamlike-8b8a@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.43 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                 |    2 -
 arch/arm64/boot/dts/qcom/ipq6018.dtsi    |    1 
 arch/arm64/boot/dts/qcom/msm8996.dtsi    |    1 
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts |   13 ++++++++
 arch/arm64/boot/dts/qcom/sdm630.dtsi     |    1 
 arch/arm64/boot/dts/qcom/sm6350.dtsi     |    1 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |    2 -
 drivers/net/tap.c                        |    5 +++
 drivers/net/tun.c                        |    3 ++
 drivers/usb/gadget/function/f_midi2.c    |   19 +++++++-----
 fs/jfs/xattr.c                           |   23 ++++++++++++---
 fs/locks.c                               |    9 ++----
 fs/ntfs3/fslog.c                         |   44 ++++++++++++++++++++++++-----
 fs/ocfs2/dir.c                           |   46 +++++++++++++++++++------------
 sound/core/pcm_dmaengine.c               |    6 +++-
 sound/core/seq/seq_ump_client.c          |   16 ++++++++++
 sound/pci/hda/patch_realtek.c            |    2 +
 17 files changed, 149 insertions(+), 45 deletions(-)

Dan Carpenter (1):
      drm/amdgpu: Fix signedness bug in sdma_v4_0_process_trap_irq()

Dmitry Baryshkov (1):
      arm64: dts: qcom: qrb4210-rb2: switch I2C2 to i2c-gpio

Dongli Zhang (1):
      tun: add missing verification for short frame

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Positivo SU C1400

Greg Kroah-Hartman (1):
      Linux 6.6.43

Jann Horn (1):
      filelock: Fix fcntl/close race recovery compat path

Konstantin Komarov (1):
      fs/ntfs3: Add a check for attr_names and oatbl

Krishna Kurapati (4):
      arm64: dts: qcom: msm8996: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: sm6350: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: ipq6018: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: sdm630: Disable SS instance in Parkmode for USB

Seunghun Han (1):
      ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book Pro 360

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



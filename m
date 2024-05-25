Return-Path: <stable+bounces-46133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406CD8CEF67
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8721C20A1C
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812645A7AA;
	Sat, 25 May 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TOVQdOMK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1335A4D1;
	Sat, 25 May 2024 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648486; cv=none; b=UN2AZtkYc3Ay0ATaUfFiSra8fv6tgkcwfU/4mW7D03e6XJ/sx55J5EksK7dCvj2r3492RUH8EUCF5R/hUUNZAFqIfFKlMXyAz9bZHq+yUz515UXIuYyQQsaY1jI9mwWRDcvi6VPv3AdfOPCrf74aPyoj6vU0PtQ0/tmrh7EmnsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648486; c=relaxed/simple;
	bh=R9HQdl8tqqjOtcb56+7EY9QQyjllC8NO+LtiarLVXPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNjvctRVWFogCOJw7C9lLdfs3GbFstOm8jA2w7+ASJfr+9SWXg+g2CjWXAjMTTkltfWsF0jsd8CJLeMnOWY1dueSZyNo1DiqsyEkNzs2nKz4LBzOYy70+TLI1KV1XzA6GHPPrF/LJPX0mYP0butGgw2nVpO9CHhReS1S9glSBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TOVQdOMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C5BC2BD11;
	Sat, 25 May 2024 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716648485;
	bh=R9HQdl8tqqjOtcb56+7EY9QQyjllC8NO+LtiarLVXPE=;
	h=From:To:Cc:Subject:Date:From;
	b=TOVQdOMKuH09V/DWYGfn2foPpcE7ES1dhfN1fqbJ++b8aHI5527doO8PScfoFWHYj
	 Fj9Z9FdJxQKVXiucW08bJd4mu3Vy74PHSX3oWN6/n2xxZ4ve0DzsrLnrNUmOIM5JOL
	 //qxgMMjgSm3nw6mKuvLb3eaDcLyI1C3hwQS4hso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.277
Date: Sat, 25 May 2024 16:48:01 +0200
Message-ID: <2024052500-gravitate-dragonish-b98c@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.277 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/sphinx/kernel_include.py             |    1 
 Makefile                                           |    2 
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |    8 +-
 drivers/firmware/arm_scmi/reset.c                  |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    3 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   22 ++++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |    2 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |   12 ++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   43 ++---------
 drivers/pinctrl/core.c                             |   14 ++-
 drivers/tty/serial/kgdboc.c                        |   30 +++++++
 drivers/usb/typec/ucsi/displayport.c               |    4 -
 fs/btrfs/volumes.c                                 |    1 
 fs/cifs/smb2ops.c                                  |    4 -
 fs/cifs/smb2pdu.c                                  |   81 +++++++++++++--------
 fs/cifs/smb2proto.h                                |   10 +-
 fs/ext4/extents.c                                  |   10 +-
 tools/testing/selftests/vm/map_hugetlb.c           |    7 -
 18 files changed, 161 insertions(+), 99 deletions(-)

Akira Yokosawa (1):
      docs: kernel_include.py: Cope with docutils 0.21

Baokun Li (1):
      ext4: fix bug_on in __es_tree_search

Cristian Marussi (1):
      firmware: arm_scmi: Harden accesses to the reset domains

Daniel Thompson (1):
      serial: kgdboc: Fix NMI-safety problems from keyboard reset code

Dominique Martinet (1):
      btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()

Doug Berger (5):
      Revert "net: bcmgenet: use RGMII loopback for MAC reset"
      net: bcmgenet: keep MAC in reset until PHY is up
      net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
      net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
      net: bcmgenet: synchronize UMAC_CMD access

Greg Kroah-Hartman (1):
      Linux 5.4.277

Harshit Mogalapalli (1):
      Revert "selftests: mm: fix map_hugetlb failure on 64K page size systems"

Heikki Krogerus (1):
      usb: typec: ucsi: displayport: Fix potential deadlock

Paulo Alcantara (1):
      smb: client: fix potential OOBs in smb2_parse_contexts()

Rob Herring (1):
      arm64: dts: qcom: Fix 'interrupt-map' parent address cells

Sergey Shtylyov (1):
      pinctrl: core: handle radix_tree_insert() errors in pinctrl_register_one_pin()

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix possible NULL dereference in amdgpu_ras_query_error_status_helper()



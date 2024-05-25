Return-Path: <stable+bounces-46135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FC08CEF6B
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784391C209A1
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DB05A788;
	Sat, 25 May 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GEGhxaCP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601E86EB53;
	Sat, 25 May 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648498; cv=none; b=YA6mamzeIWLmOuM7iLHg5EXd4W4QCFvxM2olcVUxz1gGMRKReWAelU3jwaxeRL7B8D+xjAt1D9+2zdsTwv5YtSrXEAV6XshbgWDheDUG+bzTb0v8hS5fIa7sILETP1KxoS3fKqQyqx/4MkeuxO+YOY3DSL8wyVIFw4SLqNRglrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648498; c=relaxed/simple;
	bh=M77t3NqpXIWi/7gg+9XWZpiyRv/x/Tm05sMx56OfxMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RqlI6bmw+U75n7c5Nc5VN4zwAhyfd3mTK1mVygIvxcT2RTE3d0QQoomc2m2b474tQ1Nmb13YQwixmyRBzylWFOMTkSwtXGTjvSDpEZrw81N1lBHZ4OrEhHWIQSZG3MAUs9kBdcUpR0SSho4B3PGULShlpUl2HoFEowMocq05fYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GEGhxaCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB857C2BD11;
	Sat, 25 May 2024 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716648498;
	bh=M77t3NqpXIWi/7gg+9XWZpiyRv/x/Tm05sMx56OfxMc=;
	h=From:To:Cc:Subject:Date:From;
	b=GEGhxaCPWNj2aj/urPLuU6Ob29Y5yT3RzwZffeMdtCphHB3P45UXS81FF9M12IOGw
	 xIcw9TkyYPuDSqG8CGI/mgui+MGvJaRumXJbkTUbYKHNFmt68vmI6GeIpZRpr2Qu4a
	 BNMjsuXwQhKrAfdrRfJ4HjQvpqVKFIj9j30KTzPY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.218
Date: Sat, 25 May 2024 16:48:13 +0200
Message-ID: <2024052513-everybody-glory-b3dd@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.218 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/sphinx/kernel_include.py             |    1 
 Makefile                                           |    2 -
 arch/x86/entry/entry_64.S                          |   17 +++++------
 arch/x86/include/asm/irqflags.h                    |    7 ----
 arch/x86/include/asm/paravirt.h                    |    5 ---
 arch/x86/include/asm/paravirt_types.h              |    8 -----
 arch/x86/kernel/asm-offsets_64.c                   |    2 -
 arch/x86/kernel/paravirt.c                         |    5 ---
 arch/x86/kernel/paravirt_patch.c                   |    4 --
 arch/x86/kvm/x86.c                                 |   11 ++++++-
 arch/x86/xen/enlighten_pv.c                        |    1 
 arch/x86/xen/xen-asm.S                             |   21 --------------
 arch/x86/xen/xen-ops.h                             |    2 -
 drivers/firmware/arm_scmi/reset.c                  |    6 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    3 ++
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   12 +++++++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |    2 +
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |    6 ++++
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |    4 ++
 drivers/pinctrl/core.c                             |   14 +++++++--
 drivers/tty/serial/kgdboc.c                        |   30 ++++++++++++++++++++-
 drivers/usb/typec/ucsi/displayport.c               |    4 --
 fs/btrfs/volumes.c                                 |    1 
 net/mptcp/protocol.c                               |    2 +
 net/netlink/af_netlink.c                           |   15 ++++++----
 security/integrity/ima/ima_policy.c                |   29 ++++++++++++++------
 tools/testing/selftests/vm/map_hugetlb.c           |    7 ----
 27 files changed, 122 insertions(+), 99 deletions(-)

Akira Yokosawa (1):
      docs: kernel_include.py: Cope with docutils 0.21

Cristian Marussi (1):
      firmware: arm_scmi: Harden accesses to the reset domains

Daniel Thompson (1):
      serial: kgdboc: Fix NMI-safety problems from keyboard reset code

Dominique Martinet (1):
      btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()

Doug Berger (2):
      net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
      net: bcmgenet: synchronize UMAC_CMD access

Eric Dumazet (1):
      netlink: annotate lockless accesses to nlk->max_recvmsg_len

Greg Kroah-Hartman (1):
      Linux 5.10.218

Harshit Mogalapalli (1):
      Revert "selftests: mm: fix map_hugetlb failure on 64K page size systems"

Heikki Krogerus (1):
      usb: typec: ucsi: displayport: Fix potential deadlock

Juergen Gross (1):
      x86/xen: Drop USERGS_SYSRET64 paravirt call

Paolo Abeni (1):
      mptcp: ensure snd_nxt is properly initialized on connect

Sean Christopherson (1):
      KVM: x86: Clear "has_error_code", not "error_code", for RM exception injection

Sergey Shtylyov (1):
      pinctrl: core: handle radix_tree_insert() errors in pinctrl_register_one_pin()

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix possible NULL dereference in amdgpu_ras_query_error_status_helper()

liqiong (1):
      ima: fix deadlock when traversing "ima_default_rules".



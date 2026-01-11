Return-Path: <stable+bounces-208016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E792FD0F1F1
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 15:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3D4B303136E
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 14:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BBA348899;
	Sun, 11 Jan 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NykVsqgX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE233F378;
	Sun, 11 Jan 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768141973; cv=none; b=N9UzG96ugFPgFdx63RpqYtboTL3Z4KarQ6A8VvtUlYSpLyM1LFaWX+xWxHX9bTH9CeZTvBbPoPC9miYeZJzD2DqUQ7ENIr0gebN5rSuNHZv5ZdIvec2mQlOSiorSHiEHDvU6CAffnCQ0hyONCzkkTirwol1vmyVZF3ZP58iGUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768141973; c=relaxed/simple;
	bh=LSHc6fkg/v5WQieyT4FcR0JKzdZzHCmya5hKhsUdeks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sRlg3xkzmnOA0M9jiFDznv8lY4SeBpEqQMsC7xmODFCHyvQn/zv7WrwIyt132ZVWTPXLVNlDgclVsIBx1YFC9uaddmn1WPIczZcRowTE2bON6ynsTNefrpgBdT3UAUCtmeK+ua/CP3e31s+wDiWvu4F+cquboYApmBy2aI3NvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NykVsqgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DA7C4CEF7;
	Sun, 11 Jan 2026 14:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768141973;
	bh=LSHc6fkg/v5WQieyT4FcR0JKzdZzHCmya5hKhsUdeks=;
	h=From:To:Cc:Subject:Date:From;
	b=NykVsqgXBvI/Ico8A1oY3RAEbWEomtM3nlR/k0IClm5u2xvAvtQ4H9btqihKP8PHL
	 rIm4CkEdNIJ23Vlbd5og/lpiqrhTi+Hgj1PMFLX5j4Z9F82SSWKjMroph20ofU/4Vy
	 MJXFwHqyWYF3K0JMZbmRk/kKBEbAnycGaebDDfq8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.65
Date: Sun, 11 Jan 2026 15:32:41 +0100
Message-ID: <2026011142--18e1@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.65 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                               |    2 -
 drivers/char/virtio_console.c          |    2 -
 drivers/cpufreq/intel_pstate.c         |    9 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |    6 ++-
 drivers/iommu/amd/init.c               |   28 ++++----------
 drivers/net/phy/mediatek-ge-soc.c      |    2 -
 drivers/pwm/pwm-stm32.c                |    3 -
 include/linux/if_bridge.h              |    6 +--
 include/linux/mm.h                     |   10 ++---
 include/linux/sched/topology.h         |    3 +
 kernel/sched/core.c                    |    3 +
 kernel/sched/fair.c                    |   65 ++++++++++++++++++++++++++-------
 kernel/sched/features.h                |    5 ++
 kernel/sched/sched.h                   |    7 +++
 kernel/sched/topology.c                |    6 +++
 mm/page_alloc.c                        |   24 ++++++------
 net/bridge/br_ioctl.c                  |   36 ++++++++++++++++--
 net/bridge/br_private.h                |    3 -
 net/core/dev_ioctl.c                   |   16 --------
 net/mac80211/rx.c                      |    5 ++
 net/mptcp/options.c                    |   10 +++++
 net/mptcp/protocol.c                   |    8 ++--
 net/mptcp/protocol.h                   |    9 ++--
 net/mptcp/subflow.c                    |   10 -----
 net/socket.c                           |   19 ++++-----
 25 files changed, 185 insertions(+), 112 deletions(-)

Alexander Gordeev (1):
      mm/page_alloc: change all pageblocks migrate type on coalescing

Bijan Tabatabai (1):
      mm: consider non-anon swap cache folios in folio_expected_ref_count()

David Hildenbrand (1):
      mm: simplify folio_expected_ref_count()

Greg Kroah-Hartman (2):
      Revert "iommu/amd: Skip enabling command/event buffers for kdump"
      Linux 6.12.65

Jouni Malinen (1):
      wifi: mac80211: Discard Beacon frames to non-broadcast address

Maximilian Immanuel Brandtner (1):
      virtio_console: fix order of fields cols and rows

Miaoqian Lin (1):
      net: phy: mediatek: fix nvmem cell reference leak in mt798x_phy_calibration

Natalie Vock (1):
      drm/amdgpu: Forward VMID reservation errors

Paolo Abeni (2):
      mptcp: fallback earlier on simult connection
      mptcp: ensure context reset on disconnect()

Peter Zijlstra (3):
      sched/fair: Small cleanup to sched_balance_newidle()
      sched/fair: Small cleanup to update_newidle_cost()
      sched/fair: Proportional newidle balance

Richa Bharti (1):
      cpufreq: intel_pstate: Check IDA only before MSR_IA32_PERF_CTL writes

Sean Nyekjaer (1):
      pwm: stm32: Always program polarity

Thadeu Lima de Souza Cascardo (1):
      net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELIF.



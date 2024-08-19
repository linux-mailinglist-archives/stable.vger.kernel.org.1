Return-Path: <stable+bounces-69444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3C1956271
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 06:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9391F20F0B
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 04:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A7814A4F7;
	Mon, 19 Aug 2024 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d8tPSTgN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19781802B;
	Mon, 19 Aug 2024 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040795; cv=none; b=XovFejE0pPEmWJ/NQM9MZj2G/+bHfo1ZMqNDaO368kMrQq4rn8dWIB4Sn8Gb9wew9Z2jw3cHJsaz3ZURCBewIsRcnH49p07PvFfiyiP2XgDOn4QU3VfAYJQY/xZBAA25guYuBqvePpyGzatvrGBVU0r5KEvlA5VLUpuG0qp3fOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040795; c=relaxed/simple;
	bh=kuDGN+Sy9ObTjxPC4MScf87LZYQG37rZZ3Qs53/7mqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jw3wEaDDfGUwizF0EGFnrFYGPrRqcJxgHYPUzYw+aWphcsQsCZgFCqdiMSDMXs2MG105nBVABZ1olK+7tQ0eLc6U1LTx9OOuLN8/U8RjjKJRj6YVtokuUPOEJ2vIFyrNtr9E83eUaSsk5yLf+QXxttH/3vbqTWUweSI6sTESrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d8tPSTgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A38C32782;
	Mon, 19 Aug 2024 04:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724040795;
	bh=kuDGN+Sy9ObTjxPC4MScf87LZYQG37rZZ3Qs53/7mqM=;
	h=From:To:Cc:Subject:Date:From;
	b=d8tPSTgNoXfOSEOzEEC9t3YrvbZ8JiwMOHWVZQ1S+7wGpW6Aj1XixPcTj+WFCKlBJ
	 YWkH5adGRdYBPcQYzQC7sr8dFxMiGEFwWaiOOPufi0seOBgnNW1IGHOxHgiaYS57jT
	 D+aDRxlBGcuah9+Z+jv9SqfiHD50bPJfOcTjQCMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.106
Date: Mon, 19 Aug 2024 06:13:01 +0200
Message-ID: <2024081902-glowworm-troubling-7825@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.106 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                        |    2 
 arch/arm64/kvm/hyp/pgtable.c                    |   10 -
 arch/loongarch/include/uapi/asm/unistd.h        |    1 
 drivers/ata/libata-scsi.c                       |   15 +
 drivers/gpu/drm/i915/gem/i915_gem_mman.c        |  192 ++++++++++++++++------
 drivers/gpu/drm/i915/gem/i915_gem_mman.h        |    2 
 drivers/media/usb/dvb-usb/dvb-usb-init.c        |   35 ----
 drivers/nvme/host/pci.c                         |    7 
 fs/binfmt_flat.c                                |    4 
 fs/exec.c                                       |    8 
 fs/lockd/svc.c                                  |    3 
 fs/nfs/callback.c                               |    3 
 fs/nfsd/export.c                                |   32 ++-
 fs/nfsd/export.h                                |    4 
 fs/nfsd/netns.h                                 |   25 ++
 fs/nfsd/nfs4proc.c                              |    6 
 fs/nfsd/nfscache.c                              |  201 ++++++++++++++----------
 fs/nfsd/nfsctl.c                                |   24 +-
 fs/nfsd/nfsd.h                                  |    1 
 fs/nfsd/nfsfh.c                                 |    3 
 fs/nfsd/nfssvc.c                                |   24 +-
 fs/nfsd/stats.c                                 |   52 ++----
 fs/nfsd/stats.h                                 |   85 +++-------
 fs/nfsd/trace.h                                 |   22 ++
 fs/nfsd/vfs.c                                   |    6 
 include/linux/cgroup-defs.h                     |    7 
 include/linux/sunrpc/svc.h                      |    5 
 kernel/cgroup/cgroup-internal.h                 |    3 
 kernel/cgroup/cgroup.c                          |   23 +-
 net/mptcp/options.c                             |    3 
 net/mptcp/pm_netlink.c                          |   49 +++--
 net/mptcp/pm_userspace.c                        |    2 
 net/mptcp/protocol.h                            |    2 
 net/sunrpc/stats.c                              |    2 
 net/sunrpc/svc.c                                |   36 ++--
 net/wireless/nl80211.c                          |    6 
 sound/soc/soc-topology.c                        |   32 ---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   14 +
 38 files changed, 572 insertions(+), 379 deletions(-)

Amadeusz Sławiński (2):
      ASoC: topology: Clean up route loading
      ASoC: topology: Fix route memory corruption

Andi Shyti (2):
      drm/i915/gem: Fix Virtual Memory mapping boundaries calculation
      drm/i915/gem: Adjust vma offset for framebuffer mmap offset

Chuck Lever (6):
      NFSD: Refactor nfsd_reply_cache_free_locked()
      NFSD: Rename nfsd_reply_cache_alloc()
      NFSD: Replace nfsd_prune_bucket()
      NFSD: Refactor the duplicate reply cache shrinker
      NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
      NFSD: Fix frame size warning in svc_export_parse()

Dan Carpenter (1):
      drm/i915: Fix a NULL vs IS_ERR() bug

Eric Dumazet (1):
      wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values

Geliang Tang (1):
      mptcp: pass addr to mptcp_pm_alloc_anno_list

Greg Kroah-Hartman (1):
      Linux 6.1.106

Huacai Chen (1):
      LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h

Jeff Layton (2):
      nfsd: move reply cache initialization into nfsd startup
      nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net

Josef Bacik (10):
      sunrpc: don't change ->sv_stats if it doesn't exist
      nfsd: stop setting ->pg_stats for unused stats
      sunrpc: pass in the sv_stats struct through svc_create_pooled
      sunrpc: remove ->pg_stats from svc_program
      sunrpc: use the struct net as the svc proc private
      nfsd: rename NFSD_NET_* to NFSD_STATS_*
      nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
      nfsd: make all of the nfsd stats per-network namespace
      nfsd: remove nfsd_stats, make th_cnt a global counter
      nfsd: make svc_stat per-network namespace instead of global

Kees Cook (2):
      exec: Fix ToCToU between perm check and set-uid/gid usage
      binfmt_flat: Fix corruption when not offsetting data start

Matthieu Baerts (NGI0) (5):
      mptcp: pm: reduce indentation blocks
      mptcp: pm: don't try to create sf if alloc failed
      mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
      selftests: mptcp: join: test both signal & subflow
      mptcp: fully established after ADD_ADDR echo on MPJ

Niklas Cassel (1):
      Revert "ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error"

Nirmoy Das (1):
      drm/i915: Add a function to mmap framebuffer obj

Sean Young (1):
      media: Revert "media: dvb-usb: Fix unexpected infinite loop in dvb_usb_read_remote_control()"

Waiman Long (1):
      cgroup: Move rcu_head up near the top of cgroup_root

WangYuli (1):
      nvme/pci: Add APST quirk for Lenovo N60z laptop

Will Deacon (1):
      KVM: arm64: Don't pass a TLBI level hint when zapping table entries

Yafang Shao (1):
      cgroup: Make operations on the cgroup root_list RCU safe



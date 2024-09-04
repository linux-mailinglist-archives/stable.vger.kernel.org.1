Return-Path: <stable+bounces-73118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F87396CAF5
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 01:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53EC8B2522A
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 23:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8758E18891F;
	Wed,  4 Sep 2024 23:43:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56385188582;
	Wed,  4 Sep 2024 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493407; cv=none; b=fieDUcWcSV44gyTNkV/f0FOu5w1qtS5ttTBW+6RfhL4pkoSCe8+a/7nxdXIKlegYg3iv0vwc1bVSuBURjin/+TYW8yiDGdBiNDlg4N7Q1FAB7evqg+Lmk6t0NXX+QiJsfPhSw/W5Vyf7+/RH00/rw2tnrEWC5SyirnMGTkUA/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493407; c=relaxed/simple;
	bh=HIysEs4RR0b2/m+X1+me+BZTI+S9WgRiIAAWQOLfrg8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oCWKZGWQtCwL0fM0ZxommTnAYSqhjwl4bB3ixbhnyv1DW1os4zBKsh93v4XimbuvC8r1e5IOmZ1mahxZjBfK9hYFd2ihKK6ZlgkmJjXRXooqbvVWqGtFcmMjW59Tf4xVfxDIWZRmo57w1cOEDJwHczrWpJxf4xeB+Zdw66hznZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E226BC4CED3;
	Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1slzfo-00000005Bpt-2Ia8;
	Wed, 04 Sep 2024 19:44:28 -0400
Message-ID: <20240904234428.406523717@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 04 Sep 2024 19:44:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Chi Zhiling <chizhiling@kylinos.cn>
Subject: [for-linus][PATCH 6/6] eventfs: Use list_del_rcu() for SRCU protected list variable
References: <20240904234411.443593140@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Chi Zhiling reported:

  We found a null pointer accessing in tracefs[1], the reason is that the
  variable 'ei_child' is set to LIST_POISON1, that means the list was
  removed in eventfs_remove_rec. so when access the ei_child->is_freed, the
  panic triggered.

  by the way, the following script can reproduce this panic

  loop1 (){
      while true
      do
          echo "p:kp submit_bio" > /sys/kernel/debug/tracing/kprobe_events
          echo "" > /sys/kernel/debug/tracing/kprobe_events
      done
  }
  loop2 (){
      while true
      do
          tree /sys/kernel/debug/tracing/events/kprobes/
      done
  }
  loop1 &
  loop2

  [1]:
  [ 1147.959632][T17331] Unable to handle kernel paging request at virtual address dead000000000150
  [ 1147.968239][T17331] Mem abort info:
  [ 1147.971739][T17331]   ESR = 0x0000000096000004
  [ 1147.976172][T17331]   EC = 0x25: DABT (current EL), IL = 32 bits
  [ 1147.982171][T17331]   SET = 0, FnV = 0
  [ 1147.985906][T17331]   EA = 0, S1PTW = 0
  [ 1147.989734][T17331]   FSC = 0x04: level 0 translation fault
  [ 1147.995292][T17331] Data abort info:
  [ 1147.998858][T17331]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  [ 1148.005023][T17331]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  [ 1148.010759][T17331]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
  [ 1148.016752][T17331] [dead000000000150] address between user and kernel address ranges
  [ 1148.024571][T17331] Internal error: Oops: 0000000096000004 [#1] SMP
  [ 1148.030825][T17331] Modules linked in: team_mode_loadbalance team nlmon act_gact cls_flower sch_ingress bonding tls macvlan dummy ib_core bridge stp llc veth amdgpu amdxcp mfd_core gpu_sched drm_exec drm_buddy radeon crct10dif_ce video drm_suballoc_helper ghash_ce drm_ttm_helper sha2_ce ttm sha256_arm64 i2c_algo_bit sha1_ce sbsa_gwdt cp210x drm_display_helper cec sr_mod cdrom drm_kms_helper binfmt_misc sg loop fuse drm dm_mod nfnetlink ip_tables autofs4 [last unloaded: tls]
  [ 1148.072808][T17331] CPU: 3 PID: 17331 Comm: ls Tainted: G        W         ------- ----  6.6.43 #2
  [ 1148.081751][T17331] Source Version: 21b3b386e948bedd29369af66f3e98ab01b1c650
  [ 1148.088783][T17331] Hardware name: Greatwall GW-001M1A-FTF/GW-001M1A-FTF, BIOS KunLun BIOS V4.0 07/16/2020
  [ 1148.098419][T17331] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  [ 1148.106060][T17331] pc : eventfs_iterate+0x2c0/0x398
  [ 1148.111017][T17331] lr : eventfs_iterate+0x2fc/0x398
  [ 1148.115969][T17331] sp : ffff80008d56bbd0
  [ 1148.119964][T17331] x29: ffff80008d56bbf0 x28: ffff001ff5be2600 x27: 0000000000000000
  [ 1148.127781][T17331] x26: ffff001ff52ca4e0 x25: 0000000000009977 x24: dead000000000100
  [ 1148.135598][T17331] x23: 0000000000000000 x22: 000000000000000b x21: ffff800082645f10
  [ 1148.143415][T17331] x20: ffff001fddf87c70 x19: ffff80008d56bc90 x18: 0000000000000000
  [ 1148.151231][T17331] x17: 0000000000000000 x16: 0000000000000000 x15: ffff001ff52ca4e0
  [ 1148.159048][T17331] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
  [ 1148.166864][T17331] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000804391d0
  [ 1148.174680][T17331] x8 : 0000000180000000 x7 : 0000000000000018 x6 : 0000aaab04b92862
  [ 1148.182498][T17331] x5 : 0000aaab04b92862 x4 : 0000000080000000 x3 : 0000000000000068
  [ 1148.190314][T17331] x2 : 000000000000000f x1 : 0000000000007ea8 x0 : 0000000000000001
  [ 1148.198131][T17331] Call trace:
  [ 1148.201259][T17331]  eventfs_iterate+0x2c0/0x398
  [ 1148.205864][T17331]  iterate_dir+0x98/0x188
  [ 1148.210036][T17331]  __arm64_sys_getdents64+0x78/0x160
  [ 1148.215161][T17331]  invoke_syscall+0x78/0x108
  [ 1148.219593][T17331]  el0_svc_common.constprop.0+0x48/0xf0
  [ 1148.224977][T17331]  do_el0_svc+0x24/0x38
  [ 1148.228974][T17331]  el0_svc+0x40/0x168
  [ 1148.232798][T17331]  el0t_64_sync_handler+0x120/0x130
  [ 1148.237836][T17331]  el0t_64_sync+0x1a4/0x1a8
  [ 1148.242182][T17331] Code: 54ffff6c f9400676 910006d6 f9000676 (b9405300)
  [ 1148.248955][T17331] ---[ end trace 0000000000000000 ]---

The issue is that list_del() is used on an SRCU protected list variable
before the synchronization occurs. This can poison the list pointers while
there is a reader iterating the list.

This is simply fixed by using list_del_rcu() that is specifically made for
this purpose.

Link: https://lore.kernel.org/linux-trace-kernel/20240829085025.3600021-1-chizhiling@163.com/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20240904131605.640d42b1@gandalf.local.home
Fixes: 43aa6f97c2d03 ("eventfs: Get rid of dentry pointers without refcounts")
Reported-by: Chi Zhiling <chizhiling@kylinos.cn>
Tested-by: Chi Zhiling <chizhiling@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 01e99e98457d..8705c77a9e75 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -862,7 +862,7 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 	list_for_each_entry(ei_child, &ei->children, list)
 		eventfs_remove_rec(ei_child, level + 1);
 
-	list_del(&ei->list);
+	list_del_rcu(&ei->list);
 	free_ei(ei);
 }
 
-- 
2.43.0




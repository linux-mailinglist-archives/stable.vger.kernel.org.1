Return-Path: <stable+bounces-100374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067679EAC48
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F4B28A74B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89912080DF;
	Tue, 10 Dec 2024 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u6w2NODb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E62223E64
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823190; cv=none; b=SLrAzDOutB4Ywlj2IP0/DlPUdXVwddkewCwkYUUj5YxDCMuTFMJRRPi8dVhykfAqHelH2lXMDbIGVZRRGcghWrD4kvZ/fLCUGU/FNivdU8nUQ3NIHbZJKDnRyLnbLQB+JdKfx11ukOVJfw/9svN14dg5MRUJv2QF6WuNjk/cUJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823190; c=relaxed/simple;
	bh=zhotzM61o5XPkVjAAnZo/+pTh/fx1P2IICPJWDF8k+g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gkN+PcY12lbiQ6fJ06ojAyS8m3VUx/gFecrK9++IBii5L0o8260acpHRq3xWlerjDEJUDyyXJi1ouzkIU+UzVTZhfn1ftjMAXr4BeCzCnjqDHnRw9jMdV/WPeZpNt63/qhge9vgTZSyOrH8gp21rlt22CuM2445oXTI/bR3Lblw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u6w2NODb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE61DC4CEDD;
	Tue, 10 Dec 2024 09:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733823190;
	bh=zhotzM61o5XPkVjAAnZo/+pTh/fx1P2IICPJWDF8k+g=;
	h=Subject:To:Cc:From:Date:From;
	b=u6w2NODblnrvs89UtUSjutTbPNCupgNW63n0hwwEaLrWHZuKTkqK3bxm7pQOqDYR4
	 J3eYTQaDjFMZD7RlBI5MwffqlcKpNQhrQaVS7sSuF4oCqFimutU0SdlJ5SJSWi+8Fd
	 Ld/CWs3Qf1kjD32f9VMsTAAgVigUJikOl5A33Z9g=
Subject: FAILED: patch "[PATCH] bpf: fix OOB devmap writes when deleting elements" failed to apply to 5.4-stable tree
To: maciej.fijalkowski@intel.com,ast@kernel.org,john.fastabend@gmail.com,jordyzomer@google.com,toke@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:32:26 +0100
Message-ID: <2024121026-synthesis-staring-54ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x ab244dd7cf4c291f82faacdc50b45cc0f55b674d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121026-synthesis-staring-54ef@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab244dd7cf4c291f82faacdc50b45cc0f55b674d Mon Sep 17 00:00:00 2001
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 22 Nov 2024 13:10:30 +0100
Subject: [PATCH] bpf: fix OOB devmap writes when deleting elements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Jordy reported issue against XSKMAP which also applies to DEVMAP - the
index used for accessing map entry, due to being a signed integer,
causes the OOB writes. Fix is simple as changing the type from int to
u32, however, when compared to XSKMAP case, one more thing needs to be
addressed.

When map is released from system via dev_map_free(), we iterate through
all of the entries and an iterator variable is also an int, which
implies OOB accesses. Again, change it to be u32.

Example splat below:

[  160.724676] BUG: unable to handle page fault for address: ffffc8fc2c001000
[  160.731662] #PF: supervisor read access in kernel mode
[  160.736876] #PF: error_code(0x0000) - not-present page
[  160.742095] PGD 0 P4D 0
[  160.744678] Oops: Oops: 0000 [#1] PREEMPT SMP
[  160.749106] CPU: 1 UID: 0 PID: 520 Comm: kworker/u145:12 Not tainted 6.12.0-rc1+ #487
[  160.757050] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[  160.767642] Workqueue: events_unbound bpf_map_free_deferred
[  160.773308] RIP: 0010:dev_map_free+0x77/0x170
[  160.777735] Code: 00 e8 fd 91 ed ff e8 b8 73 ed ff 41 83 7d 18 19 74 6e 41 8b 45 24 49 8b bd f8 00 00 00 31 db 85 c0 74 48 48 63 c3 48 8d 04 c7 <48> 8b 28 48 85 ed 74 30 48 8b 7d 18 48 85 ff 74 05 e8 b3 52 fa ff
[  160.796777] RSP: 0018:ffffc9000ee1fe38 EFLAGS: 00010202
[  160.802086] RAX: ffffc8fc2c001000 RBX: 0000000080000000 RCX: 0000000000000024
[  160.809331] RDX: 0000000000000000 RSI: 0000000000000024 RDI: ffffc9002c001000
[  160.816576] RBP: 0000000000000000 R08: 0000000000000023 R09: 0000000000000001
[  160.823823] R10: 0000000000000001 R11: 00000000000ee6b2 R12: dead000000000122
[  160.831066] R13: ffff88810c928e00 R14: ffff8881002df405 R15: 0000000000000000
[  160.838310] FS:  0000000000000000(0000) GS:ffff8897e0c40000(0000) knlGS:0000000000000000
[  160.846528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  160.852357] CR2: ffffc8fc2c001000 CR3: 0000000005c32006 CR4: 00000000007726f0
[  160.859604] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  160.866847] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  160.874092] PKRU: 55555554
[  160.876847] Call Trace:
[  160.879338]  <TASK>
[  160.881477]  ? __die+0x20/0x60
[  160.884586]  ? page_fault_oops+0x15a/0x450
[  160.888746]  ? search_extable+0x22/0x30
[  160.892647]  ? search_bpf_extables+0x5f/0x80
[  160.896988]  ? exc_page_fault+0xa9/0x140
[  160.900973]  ? asm_exc_page_fault+0x22/0x30
[  160.905232]  ? dev_map_free+0x77/0x170
[  160.909043]  ? dev_map_free+0x58/0x170
[  160.912857]  bpf_map_free_deferred+0x51/0x90
[  160.917196]  process_one_work+0x142/0x370
[  160.921272]  worker_thread+0x29e/0x3b0
[  160.925082]  ? rescuer_thread+0x4b0/0x4b0
[  160.929157]  kthread+0xd4/0x110
[  160.932355]  ? kthread_park+0x80/0x80
[  160.936079]  ret_from_fork+0x2d/0x50
[  160.943396]  ? kthread_park+0x80/0x80
[  160.950803]  ret_from_fork_asm+0x11/0x20
[  160.958482]  </TASK>

Fixes: 546ac1ffb70d ("bpf: add devmap, a map for storing net device references")
CC: stable@vger.kernel.org
Reported-by: Jordy Zomer <jordyzomer@google.com>
Suggested-by: Jordy Zomer <jordyzomer@google.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Link: https://lore.kernel.org/r/20241122121030.716788-3-maciej.fijalkowski@intel.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 7878be18e9d2..3aa002a47a96 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -184,7 +184,7 @@ static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
 static void dev_map_free(struct bpf_map *map)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
-	int i;
+	u32 i;
 
 	/* At this point bpf_prog->aux->refcnt == 0 and this map->refcnt == 0,
 	 * so the programs (can be more than one that used this map) were
@@ -821,7 +821,7 @@ static long dev_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *old_dev;
-	int k = *(u32 *)key;
+	u32 k = *(u32 *)key;
 
 	if (k >= map->max_entries)
 		return -EINVAL;
@@ -838,7 +838,7 @@ static long dev_map_hash_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *old_dev;
-	int k = *(u32 *)key;
+	u32 k = *(u32 *)key;
 	unsigned long flags;
 	int ret = -ENOENT;
 



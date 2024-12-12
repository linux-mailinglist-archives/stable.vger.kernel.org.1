Return-Path: <stable+bounces-102992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173659EF615
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC98616632F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33BD216E2D;
	Thu, 12 Dec 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sUWYYfV3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72020969B;
	Thu, 12 Dec 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023213; cv=none; b=PUDJ/YgXQ8GXySoKH8udCNNjVXJSo0IktXeRviV4DgJfZrErUKT6je4CdoPumOXZQUKCUHZcHXO1Q6S04pBJQhsh19ovJGXvMF5VLzX4RwB9FtsVmHokl/ZoMhL5If6WtTFGGnFJcYd98XAVu066oY9zwON4mjCPYzEJNXNClYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023213; c=relaxed/simple;
	bh=A75ZXHLgfDA0E8GGuK6d4iQDDb0TlJnHyPcPUJ/V6EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUeP0tq0B4ccT7AGTBWt3Z6UGfWgpIq7Gs8+gmwNRQFhT0DdQvSy6EnqcjVd2c0SSrov+sC0mP35e+gLMN5QxrvkpvMZ74FyQQt44VZ8PsYe/k5YhWGKvrNAi2JL+P8IQIdkT6fvZiE3pFtzRXTPgEHYMNGG1ncjffVBtbC0uFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sUWYYfV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A75C4CECE;
	Thu, 12 Dec 2024 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023213;
	bh=A75ZXHLgfDA0E8GGuK6d4iQDDb0TlJnHyPcPUJ/V6EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUWYYfV3aVido4v7mmNAOHS7/bNeoZBNxu2lA0Jb+2M6xEUH0Eotkq4x78hW8Ydm6
	 wyxjKSNN3cw/Dy1R2IqriTtvbayMt3AfKDrnb6ZSlnVLfr66/onTUAMNXtQPzYzwyD
	 40D3Jrs/lUN+oot3br9A1YX+c/3PCc0H4J2ozvG8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jordy Zomer <jordyzomer@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.15 461/565] bpf: fix OOB devmap writes when deleting elements
Date: Thu, 12 Dec 2024 16:00:56 +0100
Message-ID: <20241212144329.952725830@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

commit ab244dd7cf4c291f82faacdc50b45cc0f55b674d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/devmap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -183,7 +183,7 @@ static struct bpf_map *dev_map_alloc(uni
 static void dev_map_free(struct bpf_map *map)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
-	int i;
+	u32 i;
 
 	/* At this point bpf_prog->aux->refcnt == 0 and this map->refcnt == 0,
 	 * so the programs (can be more than one that used this map) were
@@ -806,7 +806,7 @@ static int dev_map_delete_elem(struct bp
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *old_dev;
-	int k = *(u32 *)key;
+	u32 k = *(u32 *)key;
 
 	if (k >= map->max_entries)
 		return -EINVAL;
@@ -821,7 +821,7 @@ static int dev_map_hash_delete_elem(stru
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *old_dev;
-	int k = *(u32 *)key;
+	u32 k = *(u32 *)key;
 	unsigned long flags;
 	int ret = -ENOENT;
 




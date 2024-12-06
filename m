Return-Path: <stable+bounces-99147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679589E706A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236FA2812FA
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95C614BFA2;
	Fri,  6 Dec 2024 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kl+R2C3U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879411494D9;
	Fri,  6 Dec 2024 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496161; cv=none; b=rHMssMHNZvuqfAhLl0mVNNYKXWjj3Q7vXrgwY/HXB//vdJJtgkvflnZiKSkGI3+yEnURoEVDjYIt+/2ohILpHYLhEsCR7E+iG9j0cE854xJ63/UHlfAOepAMdZBSWw12W12sTk8yo5phbF/Fm4kmlLu2SajRmXvIP4PFdn27/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496161; c=relaxed/simple;
	bh=Qlw82rftwIoFCz0zgB9QA0uCtfPCU4xQC8mVkiI9Gfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWy+n9PcPImhPXQfVrq0ovG02TGe9WeuQcbgjSNaBahGcFA2Pe0zmECI8THwTAc0X1slOSngVQ/sVoS9sLOkxjCm7L37hOTI3VVtafffJDf5b9Cr2U3+CkGeX1l/XVPKWQs8OVBGRdOiMF1pzr9qb7KAS1bJwCoqignFBIV+YYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kl+R2C3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3D4C4CED1;
	Fri,  6 Dec 2024 14:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733496161;
	bh=Qlw82rftwIoFCz0zgB9QA0uCtfPCU4xQC8mVkiI9Gfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kl+R2C3Uu7aW2AIz3n1P7mdh9axdCjhOEYPO1edpNIe3LiWdWiNvbncsim5SDOlIT
	 IT7hxkUfWglps9909Xv2/mX0CTNm2Lp/abUyd9MVMIiPEpd4ghCTrtM8RhekfCcrUl
	 Tae+AMtMmEMWAGJ/kv2a8TOCFXwjM7SjyZ7VlA18=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"yuan.gao" <yuan.gao@ucloud.cn>,
	Christoph Lameter <cl@linux.com>
Subject: [PATCH 6.12 069/146] mm/slub: Avoid list corruption when removing a slab from the full list
Date: Fri,  6 Dec 2024 15:36:40 +0100
Message-ID: <20241206143530.322801243@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143527.654980698@linuxfoundation.org>
References: <20241206143527.654980698@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yuan.gao <yuan.gao@ucloud.cn>

commit dbc16915279a548a204154368da23d402c141c81 upstream.

Boot with slub_debug=UFPZ.

If allocated object failed in alloc_consistency_checks, all objects of
the slab will be marked as used, and then the slab will be removed from
the partial list.

When an object belonging to the slab got freed later, the remove_full()
function is called. Because the slab is neither on the partial list nor
on the full list, it eventually lead to a list corruption (actually a
list poison being detected).

So we need to mark and isolate the slab page with metadata corruption,
do not put it back in circulation.

Because the debug caches avoid all the fastpaths, reusing the frozen bit
to mark slab page with metadata corruption seems to be fine.

[ 4277.385669] list_del corruption, ffffea00044b3e50->next is LIST_POISON1 (dead000000000100)
[ 4277.387023] ------------[ cut here ]------------
[ 4277.387880] kernel BUG at lib/list_debug.c:56!
[ 4277.388680] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[ 4277.389562] CPU: 5 PID: 90 Comm: kworker/5:1 Kdump: loaded Tainted: G           OE      6.6.1-1 #1
[ 4277.392113] Workqueue: xfs-inodegc/vda1 xfs_inodegc_worker [xfs]
[ 4277.393551] RIP: 0010:__list_del_entry_valid_or_report+0x7b/0xc0
[ 4277.394518] Code: 48 91 82 e8 37 f9 9a ff 0f 0b 48 89 fe 48 c7 c7 28 49 91 82 e8 26 f9 9a ff 0f 0b 48 89 fe 48 c7 c7 58 49 91
[ 4277.397292] RSP: 0018:ffffc90000333b38 EFLAGS: 00010082
[ 4277.398202] RAX: 000000000000004e RBX: ffffea00044b3e50 RCX: 0000000000000000
[ 4277.399340] RDX: 0000000000000002 RSI: ffffffff828f8715 RDI: 00000000ffffffff
[ 4277.400545] RBP: ffffea00044b3e40 R08: 0000000000000000 R09: ffffc900003339f0
[ 4277.401710] R10: 0000000000000003 R11: ffffffff82d44088 R12: ffff888112cf9910
[ 4277.402887] R13: 0000000000000001 R14: 0000000000000001 R15: ffff8881000424c0
[ 4277.404049] FS:  0000000000000000(0000) GS:ffff88842fd40000(0000) knlGS:0000000000000000
[ 4277.405357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4277.406389] CR2: 00007f2ad0b24000 CR3: 0000000102a3a006 CR4: 00000000007706e0
[ 4277.407589] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4277.408780] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4277.410000] PKRU: 55555554
[ 4277.410645] Call Trace:
[ 4277.411234]  <TASK>
[ 4277.411777]  ? die+0x32/0x80
[ 4277.412439]  ? do_trap+0xd6/0x100
[ 4277.413150]  ? __list_del_entry_valid_or_report+0x7b/0xc0
[ 4277.414158]  ? do_error_trap+0x6a/0x90
[ 4277.414948]  ? __list_del_entry_valid_or_report+0x7b/0xc0
[ 4277.415915]  ? exc_invalid_op+0x4c/0x60
[ 4277.416710]  ? __list_del_entry_valid_or_report+0x7b/0xc0
[ 4277.417675]  ? asm_exc_invalid_op+0x16/0x20
[ 4277.418482]  ? __list_del_entry_valid_or_report+0x7b/0xc0
[ 4277.419466]  ? __list_del_entry_valid_or_report+0x7b/0xc0
[ 4277.420410]  free_to_partial_list+0x515/0x5e0
[ 4277.421242]  ? xfs_iext_remove+0x41a/0xa10 [xfs]
[ 4277.422298]  xfs_iext_remove+0x41a/0xa10 [xfs]
[ 4277.423316]  ? xfs_inodegc_worker+0xb4/0x1a0 [xfs]
[ 4277.424383]  xfs_bmap_del_extent_delay+0x4fe/0x7d0 [xfs]
[ 4277.425490]  __xfs_bunmapi+0x50d/0x840 [xfs]
[ 4277.426445]  xfs_itruncate_extents_flags+0x13a/0x490 [xfs]
[ 4277.427553]  xfs_inactive_truncate+0xa3/0x120 [xfs]
[ 4277.428567]  xfs_inactive+0x22d/0x290 [xfs]
[ 4277.429500]  xfs_inodegc_worker+0xb4/0x1a0 [xfs]
[ 4277.430479]  process_one_work+0x171/0x340
[ 4277.431227]  worker_thread+0x277/0x390
[ 4277.431962]  ? __pfx_worker_thread+0x10/0x10
[ 4277.432752]  kthread+0xf0/0x120
[ 4277.433382]  ? __pfx_kthread+0x10/0x10
[ 4277.434134]  ret_from_fork+0x2d/0x50
[ 4277.434837]  ? __pfx_kthread+0x10/0x10
[ 4277.435566]  ret_from_fork_asm+0x1b/0x30
[ 4277.436280]  </TASK>

Fixes: 643b113849d8 ("slub: enable tracking of full slabs")
Suggested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Acked-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/slab.h |    5 +++++
 mm/slub.c |    9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

--- a/mm/slab.h
+++ b/mm/slab.h
@@ -73,6 +73,11 @@ struct slab {
 						struct {
 							unsigned inuse:16;
 							unsigned objects:15;
+							/*
+							 * If slab debugging is enabled then the
+							 * frozen bit can be reused to indicate
+							 * that the slab was corrupted
+							 */
 							unsigned frozen:1;
 						};
 					};
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1423,6 +1423,11 @@ static int check_slab(struct kmem_cache
 			slab->inuse, slab->objects);
 		return 0;
 	}
+	if (slab->frozen) {
+		slab_err(s, slab, "Slab disabled since SLUB metadata consistency check failed");
+		return 0;
+	}
+
 	/* Slab_pad_check fixes things up after itself */
 	slab_pad_check(s, slab);
 	return 1;
@@ -1603,6 +1608,7 @@ bad:
 		slab_fix(s, "Marking all objects used");
 		slab->inuse = slab->objects;
 		slab->freelist = NULL;
+		slab->frozen = 1; /* mark consistency-failed slab as frozen */
 	}
 	return false;
 }
@@ -2744,7 +2750,8 @@ static void *alloc_single_from_partial(s
 	slab->inuse++;
 
 	if (!alloc_debug_processing(s, slab, object, orig_size)) {
-		remove_partial(n, slab);
+		if (folio_test_slab(slab_folio(slab)))
+			remove_partial(n, slab);
 		return NULL;
 	}
 




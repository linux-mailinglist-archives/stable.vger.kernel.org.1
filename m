Return-Path: <stable+bounces-8678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4100981F930
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF31284FEF
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0938832;
	Thu, 28 Dec 2023 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aduw0hAi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F3C8DE
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703774282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CQHOzG868gm+gvlGB6P/qTYXqXQacg3t3nXYZlzCzEU=;
	b=aduw0hAitsNf5pTYZesGma3aZ/+q3U2HuGihrAhkjOP5p2BjFODOz/70sKIqgbT6SR0wR/
	qBmk8xwAyWijXxCtTHqDL9TNR0FpIMOrbiQzCK2XJ5/s/rqo//Q64yoL+jN93QbwHgWUhX
	FCO+Yn5vjdYQnYd22EBGSLsgt1J2arA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-mQwwAA_IO_CAGq_TZmnERw-1; Thu, 28 Dec 2023 09:37:57 -0500
X-MC-Unique: mQwwAA_IO_CAGq_TZmnERw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 076FA836F21;
	Thu, 28 Dec 2023 14:37:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C0DAB1121313;
	Thu, 28 Dec 2023 14:37:55 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: security@kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>,
	Kevin Rich <kevinrich1337@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfilter/nf_tables: fix UAF in catchall element removal
Date: Thu, 28 Dec 2023 11:37:37 -0300
Message-ID: <20231228143737.17712-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

From the original report:

"""
If the catchall element is gc'd when the pipapo set is removed, the element
can be deactivated twice.

When a set is deleted, the nft_map_deactivate() is called to deactivate the
data of the set elements [1].

static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
{
    int err;

    err = nft_trans_set_add(ctx, NFT_MSG_DELSET, set);
    if (err < 0)
        return err;

    if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
        nft_map_deactivate(ctx, set);                       // [1]

    nft_deactivate_next(ctx->net, set);
    nft_use_dec(&ctx->table->use);

    return err;
}

Then nft_set_commit_update() is called in the nf_tables_commit() and the
pipapo set's commit function is called [2].

static void nft_set_commit_update(struct list_head *set_update_list)
{
    struct nft_set *set, *next;

    list_for_each_entry_safe(set, next, set_update_list, pending_update) {
        list_del_init(&set->pending_update);

        if (!set->ops->commit)
            continue;

        set->ops->commit(set);          // [2]
    }
}

In the nft_pipapo_commit(), nft_trans_gc_catchall_sync() is called and
nft_setelem_data_deactivate() is called for expired elements [3].

struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
{
    struct nft_set_elem_catchall *catchall, *next;
    const struct nft_set *set = gc->set;
    struct nft_set_elem elem;
    struct nft_set_ext *ext;

    WARN_ON_ONCE(!lockdep_commit_lock_is_held(gc->net));

    list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
        ext = nft_set_elem_ext(set, catchall->elem);

        if (!nft_set_elem_expired(ext))
            continue;

        gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
        if (!gc)
            return NULL;

        memset(&elem, 0, sizeof(elem));
        elem.priv = catchall->elem;

        nft_setelem_data_deactivate(gc->net, gc->set, &elem);       // [3]
        nft_setelem_catchall_destroy(catchall);
        nft_trans_gc_elem_add(gc, elem.priv);
    }

    return gc;
}

This element is deactivated by calling the nft_map_deactivate() in the
nft_delset() [1], so the data deactivation is done twice. This causes a UAF
on an NFT_CHAIN object or NFT_OBJECT object.

In nft_data_release, chain->use is underflowed, and the following log is
printed.

[    3.709887] ------------[ cut here ]------------
[    3.710046] WARNING: CPU: 0 PID: 345 at
include/net/netfilter/nf_tables.h:1190 nft_data_release+0x5d/0x70
[    3.710385] Modules linked in:
[    3.710495] CPU: 0 PID: 345 Comm: poc Not tainted 6.7.0-rc6 #251
[    3.710701] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[    3.711005] RIP: 0010:nft_data_release+0x5d/0x70
[    3.711172] Code: 06 5b c3 cc cc cc cc 48 8d 7b 08 e8 0d f8 ce fe 48 8b
5b 08 48 8d 7b 50 e8 c0 f6 ce fe 8b 43 50 8d 50 ff 89 53 50 85 c0 75 d7
<0f> 0b 5b c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 9
[    3.711784] RSP: 0018:ffff888107437328 EFLAGS: 00010246
[    3.711962] RAX: 0000000000000000 RBX: ffff88810031b200 RCX:
dffffc0000000000
[    3.712206] RDX: 00000000ffffffff RSI: 00000000ffffff00 RDI:
ffff88810031b250
[    3.712481] RBP: ffff888104b68000 R08: ffffffffae99d250 R09:
ffffed102096d005
[    3.712722] R10: ffffed102096d004 R11: ffff888104b68023 R12:
0000000000000020
[    3.712968] R13: ffff888104b680e0 R14: ffff888104b68000 R15:
ffff8881061d4018
[    3.713234] FS:  000000000082e880(0000) GS:ffff88811b200000(0000)
knlGS:0000000000000000
[    3.713523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.713730] CR2: 0000000000839000 CR3: 00000001090ce000 CR4:
0000000000750ef0
[    3.714072] PKRU: 55555554
[    3.714213] Call Trace:
[    3.714331]  <TASK>
[    3.714432]  ? __warn+0xa1/0x1c0
[    3.714588]  ? nft_data_release+0x5d/0x70
[    3.714783]  ? report_bug+0x265/0x270
[    3.714953]  ? handle_bug+0x42/0x80
[    3.715093]  ? exc_invalid_op+0x14/0x50
[    3.715238]  ? asm_exc_invalid_op+0x16/0x20
[    3.715399]  ? nft_data_release+0x50/0x70
[    3.715553]  ? nft_data_release+0x5d/0x70
[    3.715708]  ? nft_data_release+0x50/0x70
[    3.715864]  nft_setelem_data_deactivate+0x67/0xb0
[    3.716051]  nft_trans_gc_catchall_sync+0xae/0x200
[    3.716246]  pipapo_gc+0x356/0x3f0
[    3.716392]  ? __pfx_pipapo_gc+0x10/0x10
[    3.716565]  ? _raw_spin_lock+0x87/0xe0
[    3.716728]  ? __pfx__raw_spin_lock+0x10/0x10
[    3.716910]  ? __rcu_read_unlock+0x4e/0x260
[    3.717087]  ? kasan_quarantine_put+0x55/0x180
[    3.717273]  nft_pipapo_commit+0x7b/0x140
[    3.717423]  nf_tables_commit+0x10a7/0x2200
"""

The original patch says expired catchall elements are not deactivated,
but nft_setelem_data_deactivate is called for all map objects. So, only
call nft_setelem_data_deactivate for non map objects.

Fixes: 93995bf4af2c ("netfilter: nf_tables: remove catchall element in GC sync path")
Reported-by: Kevin Rich <kevinrich1337@gmail.com>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: stable@vger.kernel.org
---
 net/netfilter/nf_tables_api.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c5c17c6e80ed..2defdf56484f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9728,7 +9728,11 @@ struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
 			return NULL;
 
 		elem_priv = catchall->elem;
-		nft_setelem_data_deactivate(gc->net, gc->set, elem_priv);
+
+		 /* For map objects, nft_map_catchall_deactivate has already been called. */
+		if (!(set->flags & (NFT_SET_MAP | NFT_SET_OBJECT)))
+			nft_setelem_data_deactivate(gc->net, gc->set, elem_priv);
+
 		nft_setelem_catchall_destroy(catchall);
 		nft_trans_gc_elem_add(gc, elem_priv);
 	}
-- 
2.43.0



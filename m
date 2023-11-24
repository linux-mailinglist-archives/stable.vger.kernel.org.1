Return-Path: <stable+bounces-958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9B7F7D52
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FC92821AB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE403A8D0;
	Fri, 24 Nov 2023 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oHfpKXHq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A43A8C3;
	Fri, 24 Nov 2023 18:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AE1C433CA;
	Fri, 24 Nov 2023 18:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850204;
	bh=xTm4uHLHs0QG9Hw/gV1lBUi3/rpmYCKbLkxKnpuvjtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHfpKXHqAzTPkisHv+m9FQ+17bAPf0c+da6EnhHd4eCP12/gURycsAr/u1fLfM4he
	 CS18agM/6KYFxtVKd6x+C2J3bemwMd0mBRutALvp56an5erWr9QEelXQNpSMC8paaR
	 xFBJw+D9vlZ9rQRsgAeo/dKMiB1SGoUGFaJhFbHs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 6.6 463/530] dm-verity: dont use blocking calls from tasklets
Date: Fri, 24 Nov 2023 17:50:29 +0000
Message-ID: <20231124172042.175894257@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 28f07f2ab4b3a2714f1fefcc58ada4bcc195f806 upstream.

The commit 5721d4e5a9cd enhanced dm-verity, so that it can verify blocks
from tasklets rather than from workqueues. This reportedly improves
performance significantly.

However, dm-verity was using the flag CRYPTO_TFM_REQ_MAY_SLEEP from
tasklets which resulted in warnings about sleeping function being called
from non-sleeping context.

BUG: sleeping function called from invalid context at crypto/internal.h:206
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 14, name: ksoftirqd/0
preempt_count: 100, expected: 0
RCU nest depth: 0, expected: 0
CPU: 0 PID: 14 Comm: ksoftirqd/0 Tainted: G        W 6.7.0-rc1 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x32/0x50
 __might_resched+0x110/0x160
 crypto_hash_walk_done+0x54/0xb0
 shash_ahash_update+0x51/0x60
 verity_hash_update.isra.0+0x4a/0x130 [dm_verity]
 verity_verify_io+0x165/0x550 [dm_verity]
 ? free_unref_page+0xdf/0x170
 ? psi_group_change+0x113/0x390
 verity_tasklet+0xd/0x70 [dm_verity]
 tasklet_action_common.isra.0+0xb3/0xc0
 __do_softirq+0xaf/0x1ec
 ? smpboot_thread_fn+0x1d/0x200
 ? sort_range+0x20/0x20
 run_ksoftirqd+0x15/0x30
 smpboot_thread_fn+0xed/0x200
 kthread+0xdc/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x28/0x40
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork_asm+0x11/0x20
 </TASK>

This commit fixes dm-verity so that it doesn't use the flags
CRYPTO_TFM_REQ_MAY_SLEEP and CRYPTO_TFM_REQ_MAY_BACKLOG from tasklets. The
crypto API would do GFP_ATOMIC allocation instead, it could return -ENOMEM
and we catch -ENOMEM in verity_tasklet and requeue the request to the
workqueue.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org	# v6.0+
Fixes: 5721d4e5a9cd ("dm verity: Add optional "try_verify_in_tasklet" feature")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-verity-fec.c    |    4 ++--
 drivers/md/dm-verity-target.c |   23 ++++++++++++-----------
 drivers/md/dm-verity.h        |    2 +-
 3 files changed, 15 insertions(+), 14 deletions(-)

--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -185,7 +185,7 @@ static int fec_is_erasure(struct dm_veri
 {
 	if (unlikely(verity_hash(v, verity_io_hash_req(v, io),
 				 data, 1 << v->data_dev_block_bits,
-				 verity_io_real_digest(v, io))))
+				 verity_io_real_digest(v, io), true)))
 		return 0;
 
 	return memcmp(verity_io_real_digest(v, io), want_digest,
@@ -386,7 +386,7 @@ static int fec_decode_rsb(struct dm_veri
 	/* Always re-validate the corrected block against the expected hash */
 	r = verity_hash(v, verity_io_hash_req(v, io), fio->output,
 			1 << v->data_dev_block_bits,
-			verity_io_real_digest(v, io));
+			verity_io_real_digest(v, io), true);
 	if (unlikely(r < 0))
 		return r;
 
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -135,20 +135,21 @@ static int verity_hash_update(struct dm_
  * Wrapper for crypto_ahash_init, which handles verity salting.
  */
 static int verity_hash_init(struct dm_verity *v, struct ahash_request *req,
-				struct crypto_wait *wait)
+				struct crypto_wait *wait, bool may_sleep)
 {
 	int r;
 
 	ahash_request_set_tfm(req, v->tfm);
-	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP |
-					CRYPTO_TFM_REQ_MAY_BACKLOG,
-					crypto_req_done, (void *)wait);
+	ahash_request_set_callback(req,
+		may_sleep ? CRYPTO_TFM_REQ_MAY_SLEEP | CRYPTO_TFM_REQ_MAY_BACKLOG : 0,
+		crypto_req_done, (void *)wait);
 	crypto_init_wait(wait);
 
 	r = crypto_wait_req(crypto_ahash_init(req), wait);
 
 	if (unlikely(r < 0)) {
-		DMERR("crypto_ahash_init failed: %d", r);
+		if (r != -ENOMEM)
+			DMERR("crypto_ahash_init failed: %d", r);
 		return r;
 	}
 
@@ -179,12 +180,12 @@ out:
 }
 
 int verity_hash(struct dm_verity *v, struct ahash_request *req,
-		const u8 *data, size_t len, u8 *digest)
+		const u8 *data, size_t len, u8 *digest, bool may_sleep)
 {
 	int r;
 	struct crypto_wait wait;
 
-	r = verity_hash_init(v, req, &wait);
+	r = verity_hash_init(v, req, &wait, may_sleep);
 	if (unlikely(r < 0))
 		goto out;
 
@@ -322,7 +323,7 @@ static int verity_verify_level(struct dm
 
 		r = verity_hash(v, verity_io_hash_req(v, io),
 				data, 1 << v->hash_dev_block_bits,
-				verity_io_real_digest(v, io));
+				verity_io_real_digest(v, io), !io->in_tasklet);
 		if (unlikely(r < 0))
 			goto release_ret_r;
 
@@ -556,7 +557,7 @@ static int verity_verify_io(struct dm_ve
 			continue;
 		}
 
-		r = verity_hash_init(v, req, &wait);
+		r = verity_hash_init(v, req, &wait, !io->in_tasklet);
 		if (unlikely(r < 0))
 			return r;
 
@@ -652,7 +653,7 @@ static void verity_tasklet(unsigned long
 
 	io->in_tasklet = true;
 	err = verity_verify_io(io);
-	if (err == -EAGAIN) {
+	if (err == -EAGAIN || err == -ENOMEM) {
 		/* fallback to retrying with work-queue */
 		INIT_WORK(&io->work, verity_work);
 		queue_work(io->v->verify_wq, &io->work);
@@ -1033,7 +1034,7 @@ static int verity_alloc_zero_digest(stru
 		goto out;
 
 	r = verity_hash(v, req, zero_data, 1 << v->data_dev_block_bits,
-			v->zero_digest);
+			v->zero_digest, true);
 
 out:
 	kfree(req);
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -128,7 +128,7 @@ extern int verity_for_bv_block(struct dm
 					      u8 *data, size_t len));
 
 extern int verity_hash(struct dm_verity *v, struct ahash_request *req,
-		       const u8 *data, size_t len, u8 *digest);
+		       const u8 *data, size_t len, u8 *digest, bool may_sleep);
 
 extern int verity_hash_for_block(struct dm_verity *v, struct dm_verity_io *io,
 				 sector_t block, u8 *digest, bool *is_zero);




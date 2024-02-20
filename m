Return-Path: <stable+bounces-21495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 771F585C928
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5E70B210ED
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF43F151CD9;
	Tue, 20 Feb 2024 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OKwjFf6s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798341509BC;
	Tue, 20 Feb 2024 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464597; cv=none; b=mdgVBK+XrsuREzSKwGEIAAK3xvlhyfXf81QxvL1YePMkwrLxfPfpx/NnbUqhZONKj7IhqGXhprsrhoyrdcISTwptIIfKziSmMSQcfVEpweSp1NTHjlKjB3f92g5QKkExWVJPMFDRhdWtp97GSrnfDy/B9fRNh0KY79W9cIdn6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464597; c=relaxed/simple;
	bh=BzuC8AzZjmZ2IEP82pVQxFmnfTpjPmWDWYxTQUmT+RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klbUmLgg/PBC+JbPCl/DnPnmyK5huzevk+OivtAxTngLhkYNKlumKRMptFFJDNPFSG9LsGQEnkE8/GtifCgf4atKWh6Cf+DgGk4OaI9d2lqcxxYnd/W9lUHwNGDXyc+djymFO0svMy7FJ4ugM6re5ikgiy8vFMlm7sqzX6FHwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OKwjFf6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D24C433C7;
	Tue, 20 Feb 2024 21:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464597;
	bh=BzuC8AzZjmZ2IEP82pVQxFmnfTpjPmWDWYxTQUmT+RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKwjFf6sQVpOvXV+j26QQFDXqBgyleeoNcT4CVuCiisIhxkdrsKppw1R19HfHJz5F
	 uvK5kBBaRvbbN75fxPQfw7G3Qz3Z+Ymo2WLbbNLDF88Wx7QCJopo9U4DjpKi0PVDeQ
	 74YCMP9/3kZ/zLqo5AX0gbP7mpyhJuaRZH7Bbz6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 6.7 076/309] dm-crypt, dm-verity: disable tasklets
Date: Tue, 20 Feb 2024 21:53:55 +0100
Message-ID: <20240220205635.586059087@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 0a9bab391e336489169b95cb0d4553d921302189 upstream.

Tasklets have an inherent problem with memory corruption. The function
tasklet_action_common calls tasklet_trylock, then it calls the tasklet
callback and then it calls tasklet_unlock. If the tasklet callback frees
the structure that contains the tasklet or if it calls some code that may
free it, tasklet_unlock will write into free memory.

The commits 8e14f610159d and d9a02e016aaf try to fix it for dm-crypt, but
it is not a sufficient fix and the data corruption can still happen [1].
There is no fix for dm-verity and dm-verity will write into free memory
with every tasklet-processed bio.

There will be atomic workqueues implemented in the kernel 6.9 [2]. They
will have better interface and they will not suffer from the memory
corruption problem.

But we need something that stops the memory corruption now and that can be
backported to the stable kernels. So, I'm proposing this commit that
disables tasklets in both dm-crypt and dm-verity. This commit doesn't
remove the tasklet support, because the tasklet code will be reused when
atomic workqueues will be implemented.

[1] https://lore.kernel.org/all/d390d7ee-f142-44d3-822a-87949e14608b@suse.de/T/
[2] https://lore.kernel.org/lkml/20240130091300.2968534-1-tj@kernel.org/

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 39d42fa96ba1b ("dm crypt: add flags to optionally bypass kcryptd workqueues")
Fixes: 5721d4e5a9cdb ("dm verity: Add optional "try_verify_in_tasklet" feature")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-crypt.c         |   38 ++------------------------------------
 drivers/md/dm-verity-target.c |   26 ++------------------------
 drivers/md/dm-verity.h        |    1 -
 3 files changed, 4 insertions(+), 61 deletions(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -73,10 +73,8 @@ struct dm_crypt_io {
 	struct bio *base_bio;
 	u8 *integrity_metadata;
 	bool integrity_metadata_from_pool:1;
-	bool in_tasklet:1;
 
 	struct work_struct work;
-	struct tasklet_struct tasklet;
 
 	struct convert_context ctx;
 
@@ -1762,7 +1760,6 @@ static void crypt_io_init(struct dm_cryp
 	io->ctx.r.req = NULL;
 	io->integrity_metadata = NULL;
 	io->integrity_metadata_from_pool = false;
-	io->in_tasklet = false;
 	atomic_set(&io->io_pending, 0);
 }
 
@@ -1771,13 +1768,6 @@ static void crypt_inc_pending(struct dm_
 	atomic_inc(&io->io_pending);
 }
 
-static void kcryptd_io_bio_endio(struct work_struct *work)
-{
-	struct dm_crypt_io *io = container_of(work, struct dm_crypt_io, work);
-
-	bio_endio(io->base_bio);
-}
-
 /*
  * One of the bios was finished. Check for completion of
  * the whole request and correctly clean up the buffer.
@@ -1801,20 +1791,6 @@ static void crypt_dec_pending(struct dm_
 
 	base_bio->bi_status = error;
 
-	/*
-	 * If we are running this function from our tasklet,
-	 * we can't call bio_endio() here, because it will call
-	 * clone_endio() from dm.c, which in turn will
-	 * free the current struct dm_crypt_io structure with
-	 * our tasklet. In this case we need to delay bio_endio()
-	 * execution to after the tasklet is done and dequeued.
-	 */
-	if (io->in_tasklet) {
-		INIT_WORK(&io->work, kcryptd_io_bio_endio);
-		queue_work(cc->io_queue, &io->work);
-		return;
-	}
-
 	bio_endio(base_bio);
 }
 
@@ -2246,11 +2222,6 @@ static void kcryptd_crypt(struct work_st
 		kcryptd_crypt_write_convert(io);
 }
 
-static void kcryptd_crypt_tasklet(unsigned long work)
-{
-	kcryptd_crypt((struct work_struct *)work);
-}
-
 static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
@@ -2262,15 +2233,10 @@ static void kcryptd_queue_crypt(struct d
 		 * irqs_disabled(): the kernel may run some IO completion from the idle thread, but
 		 * it is being executed with irqs disabled.
 		 */
-		if (in_hardirq() || irqs_disabled()) {
-			io->in_tasklet = true;
-			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
-			tasklet_schedule(&io->tasklet);
+		if (!(in_hardirq() || irqs_disabled())) {
+			kcryptd_crypt(&io->work);
 			return;
 		}
-
-		kcryptd_crypt(&io->work);
-		return;
 	}
 
 	INIT_WORK(&io->work, kcryptd_crypt);
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -645,23 +645,6 @@ static void verity_work(struct work_stru
 	verity_finish_io(io, errno_to_blk_status(verity_verify_io(io)));
 }
 
-static void verity_tasklet(unsigned long data)
-{
-	struct dm_verity_io *io = (struct dm_verity_io *)data;
-	int err;
-
-	io->in_tasklet = true;
-	err = verity_verify_io(io);
-	if (err == -EAGAIN || err == -ENOMEM) {
-		/* fallback to retrying with work-queue */
-		INIT_WORK(&io->work, verity_work);
-		queue_work(io->v->verify_wq, &io->work);
-		return;
-	}
-
-	verity_finish_io(io, errno_to_blk_status(err));
-}
-
 static void verity_end_io(struct bio *bio)
 {
 	struct dm_verity_io *io = bio->bi_private;
@@ -674,13 +657,8 @@ static void verity_end_io(struct bio *bi
 		return;
 	}
 
-	if (static_branch_unlikely(&use_tasklet_enabled) && io->v->use_tasklet) {
-		tasklet_init(&io->tasklet, verity_tasklet, (unsigned long)io);
-		tasklet_schedule(&io->tasklet);
-	} else {
-		INIT_WORK(&io->work, verity_work);
-		queue_work(io->v->verify_wq, &io->work);
-	}
+	INIT_WORK(&io->work, verity_work);
+	queue_work(io->v->verify_wq, &io->work);
 }
 
 /*
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -83,7 +83,6 @@ struct dm_verity_io {
 	struct bvec_iter iter;
 
 	struct work_struct work;
-	struct tasklet_struct tasklet;
 
 	/*
 	 * Three variably-size fields follow this struct:




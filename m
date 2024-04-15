Return-Path: <stable+bounces-39959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3C38A5BC4
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 21:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675E2285FF6
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 19:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A0D15688A;
	Mon, 15 Apr 2024 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Mfh9fpZu"
X-Original-To: stable@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D715625E
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210572; cv=none; b=qXewKZL2xriWbVMIgXItkMgJcgkZu1u9rrnipuoKz2PQicJr8CAmPKqmxYl91uXLAzpee5MLbC9qFwY2lFK8YEcvcb7f/ykRcRnBPOP3zRkrL/363bymanOE5wKi1+o2z4+bk6cSEYtsNkyjg7SIag1n1wbyr3z6xM2x5r9XzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210572; c=relaxed/simple;
	bh=NFbCstpZ5RRgQEDVh+ETz0L+LNvbESu1uz/39Ycxj8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4lIWUeylQY30gRQUh+JqjX3nC/5w9h/MgJ8s6WMv259lY9Knk4D6BjzzGZyNPgG4khRxGPOclxAQ+1I6FBjUeAVXW8b43d+vxDhYOkLD0g8qIUz1Gd9j6oOkgaweG80tVKCTo3pBxhUjo+5WU1q19kVzfDdDs/IuuB+4b1GwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Mfh9fpZu; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VJHn606g5z6Cnk8t;
	Mon, 15 Apr 2024 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1713210565; x=1715802566; bh=zl8tqsLft0ikguPVXC2WkShAIfWKvvycaTJ
	nEdM0E30=; b=Mfh9fpZuOT95cXW3XOhoZVTxPa2QcW1WtWNFgOx5UBlxETZNPBr
	bbANgKamnaELAK6yk9fpMwYcukKy0V2kns/3HWORFlm91iht4Hfhi57cY4dn8e8q
	O4SUtHGCMDw05CUOjpWhU1tJ7HrmiPur2KgWIvJnIe7c2S39VHFiA7+whCRSHrVg
	yoo5kMnv354dKzJIdKLjeA4icqRx/UH6+GTz7cVcjCD0EqgC4ttgmmdGuu7+6iQC
	TFEahrMxIMoj6O+rslu/2Hb+Yo13cljYzNddDealebFY2MCFE2sceP6M2i2o1w/C
	lPJ4zRdxF8NFDUx4LHgNKgH25zU8wCdL73Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Kg_uBXSKOTAy; Mon, 15 Apr 2024 19:49:25 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VJHn05PZqz6Cnk8m;
	Mon, 15 Apr 2024 19:49:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@lists.linux.dev,
	Bart Van Assche <bvanassche@acm.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daniel Lee <chullee@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] dm: Change the default value of rq_affinity from 0 into 1
Date: Mon, 15 Apr 2024 12:49:21 -0700
Message-ID: <20240415194921.6404-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following behavior is inconsistent:
* For request-based dm queues the default value of rq_affinity is 1.
* For bio-based dm queues the default value of rq_affinity is 0.

The default value for request-based dm queues is 1 because of the followi=
ng
code in blk_mq_init_allocated_queue():

    q->queue_flags |=3D QUEUE_FLAG_MQ_DEFAULT;

From <linux/blkdev.h>:

    #define QUEUE_FLAG_MQ_DEFAULT ((1UL << QUEUE_FLAG_IO_STAT) |	\
				   (1UL << QUEUE_FLAG_SAME_COMP) |	\
				   (1UL << QUEUE_FLAG_NOWAIT))

The default value of rq_affinity for bio-based dm queues is 0 because the
dm alloc_dev() function does not set any of the QUEUE_FLAG_SAME_* flags. =
I
think the different default values are the result of an oversight when
blk-mq support was added in the device mapper code. Hence this patch that
changes the default value of rq_affinity from 0 to 1 for bio-based dm
queues.

This patch reduces the boot time from 12.23 to 12.20 seconds on my test
setup, a Pixel 2023 development board. The storage controller on that tes=
t
setup supports a single completion interrupt and hence benefits from
redirecting I/O completions to a CPU core that is closer to the submitter=
.

Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daniel Lee <chullee@google.com>
Cc: stable@vger.kernel.org
Fixes: bfebd1cdb497 ("dm: add full blk-mq support to request-based DM")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 56aa2a8b9d71..9af216c11cf7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2106,6 +2106,7 @@ static struct mapped_device *alloc_dev(int minor)
 	if (IS_ERR(md->disk))
 		goto bad;
 	md->queue =3D md->disk->queue;
+	blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, md->queue);
=20
 	init_waitqueue_head(&md->wait);
 	INIT_WORK(&md->work, dm_wq_work);


Return-Path: <stable+bounces-39957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAFD8A5B4C
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 21:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA9F6B256CA
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 19:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE115686D;
	Mon, 15 Apr 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EF1Yavu5"
X-Original-To: stable@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80415667D
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209724; cv=none; b=R4r1gak7uc6h9Jbb6isAcAyvFkzPh8bpZ0aEO9T0HAp1dJzFTq2F9GJcwfIJBVo1Cwl/0FMBjHM6eE9mnf1MgTxi9obuPYKcWU5KDK2MhwD/fn1Ih3KAwOExWIdlxZeI1pLxlEtQF/WS74KO+Xvo+28uesZIfpMXXyY6ZbamgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209724; c=relaxed/simple;
	bh=NFbCstpZ5RRgQEDVh+ETz0L+LNvbESu1uz/39Ycxj8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvVQn5Q/X+3Mb6YJm+O8mG9oQXJir9YzLgfTtqfXU26acloCQMlAVgqA02TghZqeLEXmXCopPwFkYwUqy54AzUNZS9gTeChn9WKd9QLFvNacqlg6QsNBQNGOmQjxvm4atMsBg3XQ7wtdErDNIyfXXnC/litSk9ldfWtPXJXmCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EF1Yavu5; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VJHSn6VTfz6Cnk8t;
	Mon, 15 Apr 2024 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1713209717; x=1715801718; bh=zl8tqsLft0ikguPVXC2WkShAIfWKvvycaTJ
	nEdM0E30=; b=EF1Yavu57B/TraQ2XjXI5/elXDQnQShqh75r08v+zvJlVEz9Y/e
	7Kfm78H4guRWqU0Uw7YbMbtWBAYSbtK1Ek2K/xTit/HjhhxqJhV/KVnuFoYAgeME
	+Q5iBb6+OG4ZNwldicp+wUZ2yzCjfQ5kiz5DID9ncXw6jKcOoaISXKP7MKd+ugTj
	VGerRZ9WU2KHjFvOAZvhZ3CH/3jGi0xi/Iv++SdI4+EU2tMJkp2mg6bRqOqhUyaO
	K/exUOxkDkSfB+/uGI1XycryvKRU+1Lh1/xtvaYp+fa5zOK2D4471X/CPSB2TSHP
	LT1HdQj/EHUPIB0GKo4L+iDJh2g22iX8RTQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PciwkBaa4_gF; Mon, 15 Apr 2024 19:35:17 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VJHSh0kv0z6Cnk8m;
	Mon, 15 Apr 2024 19:35:15 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com,
	Bart Van Assche <bvanassche@acm.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daniel Lee <chullee@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] dm: Change the default value of rq_affinity from 0 into 1
Date: Mon, 15 Apr 2024 12:34:48 -0700
Message-ID: <20240415193448.4193512-1-bvanassche@acm.org>
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


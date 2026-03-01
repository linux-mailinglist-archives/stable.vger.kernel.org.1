Return-Path: <stable+bounces-222062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMnuMg6so2myJgUAu9opvQ
	(envelope-from <stable+bounces-222062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:01:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5272E1CE226
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE2E6325C783
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270B312825;
	Sun,  1 Mar 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZcDwGdn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A793033D5;
	Sun,  1 Mar 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329806; cv=none; b=XWe4GNanuGOxS8RHSsVTHDz7zkilDIpkM7XZBOd7cJpqJk7a2w1cEIWeLcQqrvhPFTY7wFnNd6Rtz0T6m8jh6Ji6pX6R/wlGkh9Rbcumsr2ALvLLgSGgtFdK35mkHSPB+DT8muPzwFRL6NBG+vhSFN0VLWwE+Ah3zz07LN3vQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329806; c=relaxed/simple;
	bh=egZ+BMy85krg1F7KMRh2SeKdT/DZBZlgsxaCH8aSCxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDGMgGzTEKrLDfFfrVHtgrzEdNJ8ImnZ1tQdHa7M8atQsonWJVBUuLYF+phDsSk+TcswN+cDe/oJSnuUKvnsoqSvrwXFxiFDt0YNWHWtHWnTaO7x6cpmFmjw8CsSz4VZjzawcfWZolzxXZoa8iancqGrLH+ivBzmjUcPLch94XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZcDwGdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF731C19421;
	Sun,  1 Mar 2026 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329806;
	bh=egZ+BMy85krg1F7KMRh2SeKdT/DZBZlgsxaCH8aSCxg=;
	h=From:To:Cc:Subject:Date:From;
	b=hZcDwGdn3DMNGXmA1D5gdFBX4HWrryEDCChz0WIy+LEH5d1vt4YIZgaNfJ8x8JYl6
	 U8q/CGITIja+gvqp3DoPgkgZafK9DlYFuN1zLxskEJwB+HdZVDc+r0J1sjA7Mq7eVK
	 iRIBrzpVxw8KfuKgC+/0r0ffHfn0YLW2LX6hcbA9+dNgCUaucgaOSqjfn07Bpla2hU
	 xY0gzE4aLznS9g0faapUnFZNea7Gb/xULN4OGUDdG0yskGrxbroIjFeaeYHav+vj3d
	 a9QJmaGTb6hIyskUcZUs0QIcw6Nvpc4UjjVBLg3HPiOit5BUoKmdkLYhjv/a8TDq0c
	 bFoQrOE9sfUjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mliang@purestorage.com
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev
Subject: FAILED: Patch "dm: clear cloned request bio pointer when last clone bio completes" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:50:04 -0500
Message-ID: <20260301015004.1715749-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222062-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5272E1CE226
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fb8a6c18fb9a6561f7a15b58b272442b77a242dd Mon Sep 17 00:00:00 2001
From: Michael Liang <mliang@purestorage.com>
Date: Fri, 9 Jan 2026 15:52:54 -0700
Subject: [PATCH] dm: clear cloned request bio pointer when last clone bio
 completes

Stale rq->bio values have been observed to cause double-initialization of
cloned bios in request-based device-mapper targets, leading to
use-after-free and double-free scenarios.

One such case occurs when using dm-multipath on top of a PCIe NVMe
namespace, where cloned request bios are freed during
blk_complete_request(), but rq->bio is left intact. Subsequent clone
teardown then attempts to free the same bios again via
blk_rq_unprep_clone().

The resulting double-free path looks like:

  nvme_pci_complete_batch()
    nvme_complete_batch()
      blk_mq_end_request_batch()
        blk_complete_request()        // called on a DM clone request
          bio_endio()                 // first free of all clone bios
          ...
        rq->end_io()                  // end_clone_request()
          dm_complete_request(tio->orig)
            dm_softirq_done()
              dm_done()
                dm_end_request()
                  blk_rq_unprep_clone()  // second free of clone bios

Fix this by clearing the clone request's bio pointer when the last cloned
bio completes, ensuring that later teardown paths do not attempt to free
already-released bios.

Signed-off-by: Michael Liang <mliang@purestorage.com>
Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/md/dm-rq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 5e08546696145..923252fb57aec 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -109,14 +109,21 @@ static void end_clone_bio(struct bio *clone)
 	 */
 	tio->completed += nr_bytes;
 
+	if (!is_last)
+		return;
+	/*
+	 * At this moment we know this is the last bio of the cloned request,
+	 * and all cloned bios have been released, so reset the clone request's
+	 * bio pointer to avoid double free.
+	 */
+	tio->clone->bio = NULL;
+ exit:
 	/*
 	 * Update the original request.
 	 * Do not use blk_mq_end_request() here, because it may complete
 	 * the original request before the clone, and break the ordering.
 	 */
-	if (is_last)
- exit:
-		blk_update_request(tio->orig, BLK_STS_OK, tio->completed);
+	blk_update_request(tio->orig, BLK_STS_OK, tio->completed);
 }
 
 static struct dm_rq_target_io *tio_from_request(struct request *rq)
-- 
2.51.0






Return-Path: <stable+bounces-144833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4122CABBEBA
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607201B60D6F
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ADC27935D;
	Mon, 19 May 2025 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KBymvdan"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418281F4717
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660273; cv=none; b=s5Q1wej2NQSHdJ7ASbBEJnfHhfbzmdjDJAwZdEw0m3anhEaIUDwUjAqlDWbt+qDNDIAD4kT2FueVmCSioDDdBKHdZSLl7kt0mdt3hzW/OmJjkmR/aawYXhIe4xAaIHyWCM5KXpKx2MGiqwyzpB1x2O14UYyIFqyvDr3dEvobD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660273; c=relaxed/simple;
	bh=t96So4evZv57aLXDgCi0MmRHI2+/k0UUc8meQLBqgZY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eASU9O0iVoUk+2kWy9hyv2sWoy8aKAo6+mXtWTrJ3W51+oL83QhqZ2/0lOufBoVADQPrRx3PqLJ9VecGS5s/pWGxDACs9fnGCa0poowkPEFIoXk9PxJEaYCBuVw2riiFaHGdlc1ifs2Q4lQvEPB1yr2Y86eCMOk8TuE1ilRgYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KBymvdan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972DEC4CEE4;
	Mon, 19 May 2025 13:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747660273;
	bh=t96So4evZv57aLXDgCi0MmRHI2+/k0UUc8meQLBqgZY=;
	h=Subject:To:Cc:From:Date:From;
	b=KBymvdanr6u4DMQz4zIuHYK4s1eHuRT35JmyN/RlnkJuJ/Gst3BKIAI0UcrGJjzml
	 LzEmMCLIocnozmxXphoPZmPoOMx8qM+1X4pmb0pvQTA2/8pr2Yer3Y+6HfyWN+BIks
	 DkRgnSNMFGXF1C7SEIOQsK3sfulGxkoRPAXBAtNk=
Subject: FAILED: patch "[PATCH] scsi: sd_zbc: block: Respect bio vector limits for REPORT" failed to apply to 5.10-stable tree
To: ssiwinski@atto.com,dlemoal@kernel.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:10:59 +0200
Message-ID: <2025051959-radiantly-ominous-f8f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e8007fad5457ea547ca63bb011fdb03213571c7e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051959-radiantly-ominous-f8f3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e8007fad5457ea547ca63bb011fdb03213571c7e Mon Sep 17 00:00:00 2001
From: Steve Siwinski <ssiwinski@atto.com>
Date: Thu, 8 May 2025 16:01:22 -0400
Subject: [PATCH] scsi: sd_zbc: block: Respect bio vector limits for REPORT
 ZONES buffer

The REPORT ZONES buffer size is currently limited by the HBA's maximum
segment count to ensure the buffer can be mapped. However, the block
layer further limits the number of iovec entries to 1024 when allocating
a bio.

To avoid allocation of buffers too large to be mapped, further restrict
the maximum buffer size to BIO_MAX_INLINE_VECS.

Replace the UIO_MAXIOV symbolic name with the more contextually
appropriate BIO_MAX_INLINE_VECS.

Fixes: b091ac616846 ("sd_zbc: Fix report zones buffer allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Steve Siwinski <ssiwinski@atto.com>
Link: https://lore.kernel.org/r/20250508200122.243129-1-ssiwinski@atto.com
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/block/bio.c b/block/bio.c
index 4e6c85a33d74..4be592d37fb6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -611,7 +611,7 @@ struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
 {
 	struct bio *bio;
 
-	if (nr_vecs > UIO_MAXIOV)
+	if (nr_vecs > BIO_MAX_INLINE_VECS)
 		return NULL;
 	return kmalloc(struct_size(bio, bi_inline_vecs, nr_vecs), gfp_mask);
 }
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 7a447ff600d2..a8db66428f80 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -169,6 +169,7 @@ static void *sd_zbc_alloc_report_buffer(struct scsi_disk *sdkp,
 					unsigned int nr_zones, size_t *buflen)
 {
 	struct request_queue *q = sdkp->disk->queue;
+	unsigned int max_segments;
 	size_t bufsize;
 	void *buf;
 
@@ -180,12 +181,15 @@ static void *sd_zbc_alloc_report_buffer(struct scsi_disk *sdkp,
 	 * Furthermore, since the report zone command cannot be split, make
 	 * sure that the allocated buffer can always be mapped by limiting the
 	 * number of pages allocated to the HBA max segments limit.
+	 * Since max segments can be larger than the max inline bio vectors,
+	 * further limit the allocated buffer to BIO_MAX_INLINE_VECS.
 	 */
 	nr_zones = min(nr_zones, sdkp->zone_info.nr_zones);
 	bufsize = roundup((nr_zones + 1) * 64, SECTOR_SIZE);
 	bufsize = min_t(size_t, bufsize,
 			queue_max_hw_sectors(q) << SECTOR_SHIFT);
-	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
+	max_segments = min(BIO_MAX_INLINE_VECS, queue_max_segments(q));
+	bufsize = min_t(size_t, bufsize, max_segments << PAGE_SHIFT);
 
 	while (bufsize >= SECTOR_SIZE) {
 		buf = kvzalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index cafc7c215de8..b786ec5bcc81 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -11,6 +11,7 @@
 #include <linux/uio.h>
 
 #define BIO_MAX_VECS		256U
+#define BIO_MAX_INLINE_VECS	UIO_MAXIOV
 
 struct queue_limits;
 



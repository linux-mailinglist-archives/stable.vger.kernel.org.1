Return-Path: <stable+bounces-76235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1F797A0B8
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADB51C22DCB
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE55615687C;
	Mon, 16 Sep 2024 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2eIX1I4g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940151553BB;
	Mon, 16 Sep 2024 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488014; cv=none; b=X70OFsTVI3L7yFmiRPXFL9rzDL4rLgUGDF/0lATBU+hpOcrflSDa+Xk4nmZ8VBZ7rML8mZJRLOWLoC2C+G/89zN0RzGj8dfDrQdsl4otXzIE+TyjEM4goShQOq4Rb2duXXe05QuwKkKNJL4n3CZvkGWUJd6VUcMCa6um9ZKfdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488014; c=relaxed/simple;
	bh=YNWzurjmCM0UJrYprmKFfOxpgH6yX1yDTA1ea2Gc1JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTFJ1zQPAaRSx/4FPcRP1HEVjTNiGgjko0ByyG1KKO6AkmRuiN4D9j3D/+JIp2dI4Hr76LEsTK/geaO+1qxgfn7lP2gJk9rGBIqZSxhdp4EtKTJ6w1XljU3PamgTpF9hZIyVVzqHzEWVz5UVmYfvbawK16X6Ot1BhpffKjUo0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2eIX1I4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5CDC4CEC4;
	Mon, 16 Sep 2024 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488014;
	bh=YNWzurjmCM0UJrYprmKFfOxpgH6yX1yDTA1ea2Gc1JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2eIX1I4g6l9gr2yfzBy0Pu29D4PPnB2eHeMmqmmkjKTJ5+omNllVUG7AbkSNUdOdb
	 1L7lppxxaNa7vrVj+YezrYEniTPL1RoEoBfXTTxMQHz1Msckq7iQZIjOhbGrJct/7k
	 reexD9pLvVGB+M1zXcU0a9ctE5oUfqa/9xrvcGB4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.1 28/63] dm-integrity: fix a race condition when accessing recalc_sector
Date: Mon, 16 Sep 2024 13:44:07 +0200
Message-ID: <20240916114222.073459910@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114221.021192667@linuxfoundation.org>
References: <20240916114221.021192667@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit f8e1ca92e35e9041cc0a1bc226ef07a853a22de4 upstream.

There's a race condition when accessing the variable
ic->sb->recalc_sector. The function integrity_recalc writes to this
variable when it makes some progress and the function
dm_integrity_map_continue may read this variable concurrently.

One problem is that on 32-bit architectures the 64-bit variable is not
read and written atomically - it may be possible to read garbage if read
races with write.

Another problem is that memory accesses to this variable are not guarded
with memory barriers.

This commit fixes the race - it moves reading ic->sb->recalc_sector to an
earlier place where we hold &ic->endio_wait.lock.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-integrity.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2175,6 +2175,7 @@ static void dm_integrity_map_continue(st
 	struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
 	unsigned int journal_section, journal_entry;
 	unsigned int journal_read_pos;
+	sector_t recalc_sector;
 	struct completion read_comp;
 	bool discard_retried = false;
 	bool need_sync_io = ic->internal_hash && dio->op == REQ_OP_READ;
@@ -2308,6 +2309,7 @@ offload_to_thread:
 			goto lock_retry;
 		}
 	}
+	recalc_sector = le64_to_cpu(ic->sb->recalc_sector);
 	spin_unlock_irq(&ic->endio_wait.lock);
 
 	if (unlikely(journal_read_pos != NOT_FOUND)) {
@@ -2362,7 +2364,7 @@ offload_to_thread:
 	if (need_sync_io) {
 		wait_for_completion_io(&read_comp);
 		if (ic->sb->flags & cpu_to_le32(SB_FLAG_RECALCULATING) &&
-		    dio->range.logical_sector + dio->range.n_sectors > le64_to_cpu(ic->sb->recalc_sector))
+		    dio->range.logical_sector + dio->range.n_sectors > recalc_sector)
 			goto skip_check;
 		if (ic->mode == 'B') {
 			if (!block_bitmap_op(ic, ic->recalc_bitmap, dio->range.logical_sector,




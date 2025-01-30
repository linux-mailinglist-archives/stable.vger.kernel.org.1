Return-Path: <stable+bounces-111535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B8FA22F96
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F80C16300C
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240911E98E8;
	Thu, 30 Jan 2025 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XqYkwJ+X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EE81DDC22;
	Thu, 30 Jan 2025 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247019; cv=none; b=FUpBzfntwQ47Qbte65WpM/LRSov3v1EBYDeDxNOVs1Rp+ux7AoM08okchC1gcb/dZRVgnHH/qrB7zvHyXvw6+Z+jM7xoZmeEoCHX18pwIXjBrG1mRyqkqDj1hvb1ealSjPWV1C+DUY7uZ7izfA5uHtUdD8kr/GGNr+n2w/eI6IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247019; c=relaxed/simple;
	bh=opQkO7I1hobNu7evjEcJoZNzVKIW68a0SwxXLSZMzwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6+rEMSprlfCa6CTB9PGUqGOhjwWCsD5jsH8Q6yBSTgyCixmlLeHxrnylr/UpR+U0650K7AxijkXvD6uy17xxEQXKgoXJyQh5BenltXwCdG4urSNuBn5GlVnYmXX01PB85eb9mr6M4sWtfCr4rMu5lhEUOPRJdhNeUvWBoztCWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XqYkwJ+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AB1C4CED2;
	Thu, 30 Jan 2025 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738247019;
	bh=opQkO7I1hobNu7evjEcJoZNzVKIW68a0SwxXLSZMzwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XqYkwJ+XfDcYwWQRF8wHRB+b3BtJipWM41E04ZAqVpe5lKTBon7yW/iggDfsbx594
	 6RfW7e6daQGV6UsjQQFO9hZC7cMfwipS5Mn8pEbEYJmMvJ2vuzuQeRAczk7RY/zGwr
	 1Yyc6OX0nTMqUjAiz3jlqZrlvA5xONFJC+GFamg4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 054/133] nvme: let set_capacity_revalidate_and_notify update the bdev size
Date: Thu, 30 Jan 2025 15:00:43 +0100
Message-ID: <20250130140144.691864125@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
References: <20250130140142.491490528@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 5dd55749b79cdf471ca0966ad91541daebac3e2f ]

There is no good reason to call revalidate_disk_size separately.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bee55902fe6c..c8e64a1e2fc0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2132,7 +2132,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 			capacity = 0;
 	}
 
-	set_capacity_revalidate_and_notify(disk, capacity, false);
+	set_capacity_revalidate_and_notify(disk, capacity, true);
 
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk->queue, ns->ctrl);
@@ -2213,7 +2213,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 		blk_stack_limits(&ns->head->disk->queue->limits,
 				 &ns->queue->limits, 0);
 		blk_queue_update_readahead(ns->head->disk->queue);
-		nvme_update_bdev_size(ns->head->disk);
 		blk_mq_unfreeze_queue(ns->head->disk->queue);
 	}
 #endif
@@ -4095,8 +4094,6 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 	 */
 	if (ret > 0 && (ret & NVME_SC_DNR))
 		nvme_ns_remove(ns);
-	else
-		revalidate_disk_size(ns->disk, true);
 }
 
 static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
-- 
2.39.5





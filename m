Return-Path: <stable+bounces-107436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319DBA02BFA
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6F33A7DD9
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A101E1547D8;
	Mon,  6 Jan 2025 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QhVzUZFz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58E145348;
	Mon,  6 Jan 2025 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178457; cv=none; b=Eo9eazgJmUklOkIEQFUHK06u0V7SLtOxXAmj7Mr1JDj0OkPeyXlV4yrh7xyWiGgxvin4Tuq1RIguICfLaTQSVlQcW32BNYE3fcr/7T6tJLoBeozWVXOpq+Mx1w0HmjRFcmNYjmA+Qezi0VPSabKQFfdvqBQQhnDlrIpHEi5G2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178457; c=relaxed/simple;
	bh=opQkO7I1hobNu7evjEcJoZNzVKIW68a0SwxXLSZMzwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtB/c54OOyA5d0gmNkjc6b/CspOVkiGZ+mz1Ivrict9UWjpF8CAEuDEF9ngC9kRtwVP7dEthuiSMCOv78li2SGeyXJmmTFe9eY/ATfORWNtM+L+prbPvIDQD5Ca9ZGACtpUyP7N8ueZSwSdI7hu6ihlmz+p4tGZ/mz17iDskQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QhVzUZFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9526CC4CED2;
	Mon,  6 Jan 2025 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178457;
	bh=opQkO7I1hobNu7evjEcJoZNzVKIW68a0SwxXLSZMzwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QhVzUZFzhLS4XLyxAdIlggM2tjLkvIQAS7HotftryG4IYAnEFPp7FmgWXaVRnxVyC
	 qMua3fQJURdSlx0u91zkEmXtSLe5I4+r18A24npDEUo9+NQ3dl/fICGLRJuIfjj0oE
	 0TtQbw3k9SWLsq0JQbNFSQjjYDe+I3s9eA4ikhKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 093/138] nvme: let set_capacity_revalidate_and_notify update the bdev size
Date: Mon,  6 Jan 2025 16:16:57 +0100
Message-ID: <20250106151136.753676940@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151133.209718681@linuxfoundation.org>
References: <20250106151133.209718681@linuxfoundation.org>
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





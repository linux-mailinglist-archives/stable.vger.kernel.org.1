Return-Path: <stable+bounces-125227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A427A69024
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27F942569A
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747372144C0;
	Wed, 19 Mar 2025 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K4kQl4fO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276EC1E105E;
	Wed, 19 Mar 2025 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395042; cv=none; b=IEPMasQxWSsNxFFez9ldJRGmTDxnfic9VfvjE5ZuSuSVvQ4+PZ2Kh8Qh2ma/9lzhBOopx8p0OzjIRcok1VF2tyghXbxa3Nv247yoTRHj01QAVjPMR0HnYuaFcmOHIBLfaCtdjiTvNWlVnmtiiHbJUeuGecmp9DQrCLL158JhGz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395042; c=relaxed/simple;
	bh=kQ08iqHSIohfh0wjGSOpMsUCFjX71pr89htDAy1jT9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d32s32OHx8F7r9R97a6e/tVedyroLC2ghZHfMpSWZLF+E04zVM+CrMc0n4vej3l6BcrliZ4gVm+USlS9S0vLC+9k7kQxOCysiFgJd+e4GrUqKKOVhZ17unemnXV+wgwfeViIe0Me8jOCguRZWMyfRNGKoa89tycy7sSQyCj986A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K4kQl4fO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EB6C4CEE8;
	Wed, 19 Mar 2025 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395042;
	bh=kQ08iqHSIohfh0wjGSOpMsUCFjX71pr89htDAy1jT9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4kQl4fOts3Kc7QkUuaszey3G8qlMi/Nag8AihIotIvSXFQcWAouQxDHx2Bv8MzEj
	 HhgB4D1ubFnjAB0WqDZrzYpKHs3tHhihmGesV6U3eIAwY3Gco/1fpdH+4XvZ8XsLAl
	 xWpTb2g5pHAecvw3i8DAr5mESyiCAng3uvUXYEc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>,
	Rik van Riel <riel@surriel.com>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 066/231] scsi: core: Use GFP_NOIO to avoid circular locking dependency
Date: Wed, 19 Mar 2025 07:29:19 -0700
Message-ID: <20250319143028.459935990@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rik van Riel <riel@surriel.com>

[ Upstream commit 5363ee9d110e139584c2d92a0b640bc210588506 ]

Filesystems can write to disk from page reclaim with __GFP_FS
set. Marc found a case where scsi_realloc_sdev_budget_map() ends up in
page reclaim with GFP_KERNEL, where it could try to take filesystem
locks again, leading to a deadlock.

WARNING: possible circular locking dependency detected
6.13.0 #1 Not tainted
------------------------------------------------------
kswapd0/70 is trying to acquire lock:
ffff8881025d5d78 (&q->q_usage_counter(io)){++++}-{0:0}, at: blk_mq_submit_bio+0x461/0x6e0

but task is already holding lock:
ffffffff81ef5f40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x9f/0x760

The full lockdep splat can be found in Marc's report:

https://lkml.org/lkml/2025/1/24/1101

Avoid the potential deadlock by doing the allocation with GFP_NOIO, which
prevents both filesystem and block layer recursion.

Reported-by: Marc Aurèle La France <tsi@tuyoix.net>
Signed-off-by: Rik van Riel <riel@surriel.com>
Link: https://lore.kernel.org/r/20250129104525.0ae8421e@fangorn
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 042329b74c6e6..fe08af4dcb67c 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -245,7 +245,7 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
 	}
 	ret = sbitmap_init_node(&sdev->budget_map,
 				scsi_device_max_queue_depth(sdev),
-				new_shift, GFP_KERNEL,
+				new_shift, GFP_NOIO,
 				sdev->request_queue->node, false, true);
 	if (!ret)
 		sbitmap_resize(&sdev->budget_map, depth);
-- 
2.39.5





Return-Path: <stable+bounces-132546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED201A882F5
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13FB7A3142
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186ED29E04E;
	Mon, 14 Apr 2025 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnygZ4pI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69B29E048;
	Mon, 14 Apr 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637382; cv=none; b=UZQL0g7ywM7GcosCE4FbsdKxDvgLxgtjYBn1a1e+GrBuKMVQ5cgMfmJrB6Gn5NvgtcJQ2dkCHAExNhqtLI/tiPOw3zysikmPvRjKbGMSOIH30mLHg5mltZSZ1bovzb6PtkTVEUOqoPKnWwxKi0GtmV1ie2u5ev60IKyhn367nNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637382; c=relaxed/simple;
	bh=gmCfe1COb9qkb2Vi9dOY8JKW+Czq0eYOsx8yhYbnm9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3SWC4tLieG+Enqe+tJVy7zZBylDNDBE5dol3F0EPLpN9uehXMMvajXC6NKVLnUfYYCnR9KYJNxsOczyrfs5M3qq09ukbHCsTdHZlha7vTZKKsAOxuN4yH5jD1ohpY8zBzG4I3qVvzre8NpQggzFy0F8UnrziNYqQDSBm10GG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnygZ4pI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E59C4CEE2;
	Mon, 14 Apr 2025 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637382;
	bh=gmCfe1COb9qkb2Vi9dOY8JKW+Czq0eYOsx8yhYbnm9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnygZ4pIZkHFPFWqhN/JudlBqw61+/KO0WgbT8ZC11VB2qVXOqSCE/nFqT+0Hz0tf
	 F2d2bu7tl0RqiJzU6GsR6C4uxBIdqXZB7xqCOZC3htK3WQ0v58kcIVb9Kj9t7bArQd
	 bwt/LBIqI4+xDd8CcjexBiMeo7Pz8Pe+fDqycLPd3xmBZ9+FfntjoqlLZfq2PNzdh7
	 pOzQEM1YiQzDp+4euUR487xr1iSr9ZaDB47oGz80vdBq0C+fFRgqCvoStW59ZhSsQL
	 IEJbIs51wtvmrZiL5rJxnX3Gh7D2vGhFv5ayQS/ejIpaG/4yInXlt9O3YOdETV8DBa
	 u93Lb7UCQeP5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 23/30] nvmet-fc: put ref when assoc->del_work is already scheduled
Date: Mon, 14 Apr 2025 09:28:40 -0400
Message-Id: <20250414132848.679855-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit 70289ae5cac4d3a39575405aaf63330486cea030 ]

Do not leak the tgtport reference when the work is already scheduled.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a3a6dfe98d6fc..0dfffb3f39b06 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1103,7 +1103,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static bool
-- 
2.39.5



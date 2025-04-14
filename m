Return-Path: <stable+bounces-132572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C12BBA88347
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1052D7A3AD1
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED62D0A3B;
	Mon, 14 Apr 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oo7mQHt/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413F2D0A34;
	Mon, 14 Apr 2025 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637438; cv=none; b=U52tRIolx/g02LOIDWXqCfEAerWliVl+HLQEa4HXsYUHuB6CaHvZvJccKrqqhZvcysBaO50BQoTRAhxZ1kH2tyPPjOTVFPTkt7/mmnmj7TfyUXtkiE0okXQD8u3Ao1wq2MXJd4sZ85Mq2EjM4hHGiITCbwj8LAXDh4ylpKuv7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637438; c=relaxed/simple;
	bh=zoXg8WRJFTRy7RmDZZQNLt3wyDVJhYSJ5hgWVHuxyK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dl3atg7Tu8Ue5vmPyBDMLuc4WGOzgY0qb9HPCvFoWORjhNseiekoTqtcSCGM67Nk+BCY11qC4Tn+fh2FvfJGWrARhmdvaVbfG/k1dZryqTESelGJu/oTqrcGnxzqUmgpzIMv62zF3NHEIztXZ0JUGRJE0KLdHICyp/58GfGHPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oo7mQHt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B92AC4CEE2;
	Mon, 14 Apr 2025 13:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637437;
	bh=zoXg8WRJFTRy7RmDZZQNLt3wyDVJhYSJ5hgWVHuxyK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oo7mQHt/OsSU6wWlRM32rlaBNjJNTlJXTeHHYgnYXZnQnNGrT1MExZsyXjpR8itto
	 5M5pmrB5lzgFKKr/7aJxiL7ZBfOYC3aDIDHsyBhjGtiGkOilSOSMIfTn6Lmzafa3Jv
	 zouw0i7aQtoFzTQqoVQflq2b+4mlUhmjkUaDVvJWteRv9YPf5eDkG/2jdWnCv8tNud
	 xB0bcMaa5yZSQieUM20wAQHnVXtc/koApkOOYfyB9QZnkFQs8Ah33pVMTDN15oe6eb
	 fy3XT19UZHgBUFOkHy5M7hcaSJx2TzUwn1N2jMupgiHvHfbbeDPRJhQnni3i5pHyfs
	 o3Bw1MO1MgAbA==
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
Subject: [PATCH AUTOSEL 6.6 19/24] nvmet-fc: put ref when assoc->del_work is already scheduled
Date: Mon, 14 Apr 2025 09:29:52 -0400
Message-Id: <20250414132957.680250-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
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
index 50953e0f9772d..ad43d36c537be 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1105,7 +1105,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static struct nvmet_fc_tgt_assoc *
-- 
2.39.5



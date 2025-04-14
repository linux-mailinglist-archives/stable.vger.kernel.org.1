Return-Path: <stable+bounces-132593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0F7A883FD
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7FB3BA861
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF93D2D86B3;
	Mon, 14 Apr 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3JJpQLZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B62D86A1;
	Mon, 14 Apr 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637481; cv=none; b=SuvKA+KhQ+670C9/7W9Ihh3doO+pYzGhThH800Qe2tGFfARf98LhiCD0Qy0AUW6K3bRgZW4Crqd2ZYpJt6Kk3lpuALe/+Dc6Q6C8XtPNmMxdC0tmoaSqKinCtDKWLohL9BqrXjdlrWRbvcdN5kXFr9o4dAtogxoPBkHEFELKQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637481; c=relaxed/simple;
	bh=zoXg8WRJFTRy7RmDZZQNLt3wyDVJhYSJ5hgWVHuxyK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xnz7WrN5I6zw4nsT0PsKF92mkuPv5V0yMP1FWt/7EY6+Oui2WOA8inW7c/WCKq6xTv5+bRjgHmkJVD75qNVCgGbjU5MT9i7P1FI3C7MuWD3M2VtfHEp0px1ZodB+DLO6Iis+vnEPoEu1gcOFgFz1EnTkoGtPCtPlCWU5z7ekqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3JJpQLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E08C4CEE2;
	Mon, 14 Apr 2025 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637481;
	bh=zoXg8WRJFTRy7RmDZZQNLt3wyDVJhYSJ5hgWVHuxyK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3JJpQLZkYcvfQyXGG37YBTbOVVqdtcwsztWaFRT8nnSXK7AQoW+vLGVvLVLRD4pg
	 tcDbwVGkDirEhtLUAk6IZvyN4GaZti+8blzp4hBz+gOBPCECWp8UeE5et8p+Wpq7Lj
	 xJw8bpj2FyzQ67RPjW2QrWBilvMlMcFjx+eqxk06HYYvpUOxHIc2P9M0b1WyRZE+kC
	 XXc+lbGsLSACLT9M4OG6i+wZDLm85o6OnRLbvLJkz4dw9J52dVnL23OSaHrbRLXlHX
	 WRpHThlZNBzldIcrcA10FCK/NjW+zqzj3qY5gOquAojY++9NIgaoeDi3K8PjtC2iJk
	 m24ggwf6eZkhg==
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
Subject: [PATCH AUTOSEL 6.1 15/17] nvmet-fc: put ref when assoc->del_work is already scheduled
Date: Mon, 14 Apr 2025 09:30:46 -0400
Message-Id: <20250414133048.680608-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133048.680608-1-sashal@kernel.org>
References: <20250414133048.680608-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
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



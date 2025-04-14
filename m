Return-Path: <stable+bounces-132609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 947CDA883E8
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E4B164488
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F752DC48A;
	Mon, 14 Apr 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGB0Tx+6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0A2DC484;
	Mon, 14 Apr 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637516; cv=none; b=TrLLc1ZFQ/odkqZWOtGKuDELCJzn9TOybH8wH+UyR1gXq/w6SzpD11p6Wgd+OmhIKlbJvM2Sops/sFiAPPaO+l312N3JxotqFA43zzcRxvkwM8zh8FZQ+EvYXp81ZMxJbNjG6tRxla4aCE66E6zoln+qcq1yDT9FZQammv8mMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637516; c=relaxed/simple;
	bh=Kt7NhyquizgXgPlH6ZDGEhzHM6pEp1YYaxQTCPWhVnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUIbAmnSzbzF1mtNvSKaEM2oS6rXoZ2qO82jt/iKsDgBafW6a0kF7pLZOd/9gLl2BUe2aj799WakJArerSMEmToiJlVopVnf3i9/u3fdwl5miu11AOoQjqlntEsmSZ77dJTv0je3miYs3z111rL66ZdkPHfOJsYBL0ohgMz4LOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGB0Tx+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81C8C4CEEB;
	Mon, 14 Apr 2025 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637516;
	bh=Kt7NhyquizgXgPlH6ZDGEhzHM6pEp1YYaxQTCPWhVnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGB0Tx+6ypmGEDsL4S/Ofuw0inMvUzfnKjNv6xyh7jQM9m5bVoeIuSRefXGpwUCLO
	 ARD2o9FJUGlPU9mdn5vIFRM4i+t2WPYLnIDVG/TQo6LdZGDQluNt9CVJFZHksITa8r
	 XL21f3zB0RWMvEYL1VlSOJeh7U5qusqtpVbsi7ZCpdgW9svUNUUj70VyugbKuBetuv
	 nBkR4v8/a1wPrpdeBnbaU7zn5esHbs5R24gL6tCpXgF+XCSZQ11hmGigoTphrWsaib
	 10twjqi+l0E+0NcfnmrafLk4gmSx5j1zD4FXCdCLaNP8A3wZTQDIrq+dPG/L19HSUW
	 rxwJwZzwDbWoA==
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
Subject: [PATCH AUTOSEL 5.15 14/15] nvmet-fc: put ref when assoc->del_work is already scheduled
Date: Mon, 14 Apr 2025 09:31:24 -0400
Message-Id: <20250414133126.680846-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133126.680846-1-sashal@kernel.org>
References: <20250414133126.680846-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
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
index 606fdde21d629..3fb51fef64733 100644
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



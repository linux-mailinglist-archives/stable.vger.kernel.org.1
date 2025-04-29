Return-Path: <stable+bounces-138689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B9AA191F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50CF1BA3C5C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD124397A;
	Tue, 29 Apr 2025 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tIhPevMZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30F40C03;
	Tue, 29 Apr 2025 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950040; cv=none; b=njG3F6ad+mTPI1Cpe2lGV19kqKHmZrEIfb6ZYZNXcsnyolNZEEgnR0VbPrjz8G9rNHbD3QtkGg2dyDogCgi614XHcZi9IEbmAm3SBs98mVfIPiQZBOmAHhisxflTK1nqj7Sx2Cjm3balh3Fz1y8kxVbKwhyQ9QhFx4olKiVK1Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950040; c=relaxed/simple;
	bh=MLZ32R8dqj19H184XbTIA+MhLmtmzCTmee7gIi10zLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WckZZRcCSUFEqSSmpVphhL8hRSLUbedP5PB303Yqkctxews7RIlijuPjWq6gQ6hSXRBqE7gWbkjOAkLnxlWTVhNPtkazsFMlb7KjjofYze2rwsGP1C44cvFrkZ8M40vEUT0JqU2mMQ5/2JXpszOjwkuvCz7RNX1JwZfWug9PhDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tIhPevMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E65C4CEEA;
	Tue, 29 Apr 2025 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950040;
	bh=MLZ32R8dqj19H184XbTIA+MhLmtmzCTmee7gIi10zLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tIhPevMZURHbBgqvzW4Re+Ok6ec6kgUy9C1aRJD2MKUtKwrGepUPK6s/QN292WTzZ
	 lSUD0cPom+85eVwdH/iY9+Ov5b4DsjlDCVchF554pjKFm8N0AFP+hPDQ13EKZ+rsWA
	 aLJGHGyqdCNzA8rny/sy3wsX/t7ZBkyls+e0OkmQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 138/167] nvmet-fc: put ref when assoc->del_work is already scheduled
Date: Tue, 29 Apr 2025 18:44:06 +0200
Message-ID: <20250429161057.312006062@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
References: <20250429161051.743239894@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 68ff9540e2d13..570c58d2b5a58 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1091,7 +1091,8 @@ static void
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





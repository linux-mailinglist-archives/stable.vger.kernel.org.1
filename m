Return-Path: <stable+bounces-132498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19418A882AF
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3C43B1831
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8773827A935;
	Mon, 14 Apr 2025 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BntZI/6+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B127A92B;
	Mon, 14 Apr 2025 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637271; cv=none; b=UNIi1pSzDjdEFHU6QMQsEXJMoBWr1Nbm/A6SDsglqPzby8Zj8ei9i4os7aDQzBlvk3KiBvKACwommaXCtwnxr9lRqHanNaWysgAo0jWcuy9SPx0Hoew3Z29Z0xbwL6I9lTNYrsH+nT3hVL1vAN4K5RusK7nl4ufupCNq9urBcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637271; c=relaxed/simple;
	bh=5h2lMXQWMzNDy6atMz06+3FskdOTLm+ZoYi30GgjGDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/AyK+vbbWL4KlgPHbJR5Wch66BCqaqBYhKz9CDxN5GEJb6USkD6niPcF0C/TY7bnnKb1sk4cCoq8YT3Cuf/HPDjhdwdAewgpX5/I7sSJzfFXM+7WcnS0hb7JkcctPpPrFQAwVsF/Wqt4Ty0Qx6oHFjqPXVwUq/wzqgTQKFQFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BntZI/6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31FBC4CEE9;
	Mon, 14 Apr 2025 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637271;
	bh=5h2lMXQWMzNDy6atMz06+3FskdOTLm+ZoYi30GgjGDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BntZI/6+Tw56TxUAstC8U+iB+8gN/ezfS5Iu0+qbVfI1xvEQU1VlbscjzJ2EQV6cH
	 ohEViIUIPjUCqs0BwWVztb7KTwY+GQO336zdIDzk7XybkVl7PBzmCHUE2m11/KuanQ
	 pDkhSQZ/zF31GNdhIGKQXkPCdwG2pQ564C/rbUEfr79XxLdiGlWPTbtY4HbJShh59q
	 2WU9KV/62GQQcH/HhhdiV8zQNG8x5/NCZsxxRj2moQuM24MYNwrFT1DL1PU+NTyV0x
	 p/b2+QQaXpQy65k/OkTxR2X7s2JPIjrWXEbWoRo2xZFv56RQIU66WLiZ46SrnXcZ+y
	 sLxwhYRZpIsQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 10/34] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:27:04 -0400
Message-Id: <20250414132729.679254-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 9546ad1a9bda7362492114f5866b95b0ac4a100e ]

Scanning for namespaces can take some time, so if the target is
reconfigured while the scan is running we may miss a Attached Namespace
Attribute Changed AEN.

Check if the NVME_AER_NOTICE_NS_CHANGED bit is set once the scan has
finished, and requeue scanning to pick up any missed change.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e4034cec59237..1b386889242c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4282,6 +4282,10 @@ static void nvme_scan_work(struct work_struct *work)
 			nvme_scan_ns_sequential(ctrl);
 	}
 	mutex_unlock(&ctrl->scan_lock);
+
+	/* Requeue if we have missed AENs */
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
 }
 
 /*
-- 
2.39.5



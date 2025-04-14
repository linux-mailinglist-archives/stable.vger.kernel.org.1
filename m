Return-Path: <stable+bounces-132614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 914A8A883F8
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7110168293
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6C44C9F;
	Mon, 14 Apr 2025 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L889CAft"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A309134CF;
	Mon, 14 Apr 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637529; cv=none; b=qs29u5P1Uimb2nWvq3vTsv5rfDjYkn48O3zAgsRz+9rounXhbhCHyso5Z4qsbCbsAd81muqG45F40XSdQpr+pMvp2PC0pcmYxCTMUH+4PAm0BDVWg0XeuqaVW1pVsMP/J5MwVx5yYf2rxsbulIlswDuB9Gv2/54QnRpwiKNCfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637529; c=relaxed/simple;
	bh=Ekfkic5IQNMOXLfzLqVWehnFSXZpJb9m496EdyUz3xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mFJcZKHqjaygmAlQIOFZ1cLtKlQ5QvNLASTtTGsoHupGJactcf2LFJ9yNGC7i8SiXTWd3FkEKIUAt4W8WIwM5rnmPE839hPduRvT6kBEHNrenkP/kYwgao7TnNL73yi8nRnW3gxATf8kyaae7J2tRlTrZEPj4rj8sae+JwSLJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L889CAft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76382C4CEE2;
	Mon, 14 Apr 2025 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637528;
	bh=Ekfkic5IQNMOXLfzLqVWehnFSXZpJb9m496EdyUz3xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L889CAftYF1ZchKK95i36DX2SYQ5xQg5mE/4D8bjOm3Nhu3Ckd4gOTOq2xHstbp85
	 7fH90K3YscAlfxJuXRTihMz4+DEaYViRO7E2pkjQGuFAfbo+olyFhuhWwpOAXSnoMe
	 TxMWfaVyCGX3Pr2tM+5EVO/A9f+yHYwBIK88XaFVfBCbambvnZg7H6dsDKM0xywcE4
	 ZPs01772wUYGm16YYmVY/6wzEK0Dt2tOX5RjBzlGMO4e+XZMT32KKv72KEDyvhzekL
	 ZDiS2W18xJGh+3VwjFHg1mZaXR0xjLLXhU5RoQbXyoX/ODiEhj/PgcS2fB/qQYDR7i
	 cVVftKM+mVkwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 04/11] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:31:51 -0400
Message-Id: <20250414133158.681045-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133158.681045-1-sashal@kernel.org>
References: <20250414133158.681045-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.236
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
index 5f16fc9111a9f..b3ca27b78f030 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4265,6 +4265,10 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_scan_ns_list(ctrl) != 0)
 		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
+
+	/* Requeue if we have missed AENs */
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
 }
 
 /*
-- 
2.39.5



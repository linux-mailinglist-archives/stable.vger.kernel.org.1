Return-Path: <stable+bounces-132530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD80A88313
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2D13BFBCD
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80FE2973C9;
	Mon, 14 Apr 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF+UmHDC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948372973C2;
	Mon, 14 Apr 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637344; cv=none; b=gFFPo4psfJSW2nJFUp4TFKq77mRFtA3r3tqjfhFQK+tt3rEe/+WKvB7A8KzRnYWXBZsg8nurOy5tnRa7uPWc5K1qA1jYux+pVJ6dCV1Q61RS4eh6dthmIsfJATImIrc1jg1LuYQBjq3vitC/tGajRx8AkInuDWOhs5YP+4ZqRxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637344; c=relaxed/simple;
	bh=9hY5+zVfs+pL21mtsAaULpMOnydMqkceFDf/9FixZkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P289hi5G241/gsJoBPO9eG/YuvrDYd5ZHF0vVokbUJeRYB9vLG/Nf6yCN4ehyZS9peSXs9S+2ufqnWH9+QA91XAJRvSzSJF3NO4v05vuVmP3gQvH6IjCCoNP0Fv5rcxV7ljloZ4JxEpd8Hq3DmjLNQ690dDDjgp0iJikda+FeUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF+UmHDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA32C4CEE9;
	Mon, 14 Apr 2025 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637344;
	bh=9hY5+zVfs+pL21mtsAaULpMOnydMqkceFDf/9FixZkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZF+UmHDCvgAJX/rttm/v9/4uSrdlJV77hGXiCG503mQybxOU3Me/E8qadSz0TkwzG
	 Aq+CgOmPVbU9Vd/gfh9rtKjPnjQJeGYtCzUZQk8ADB8D1fA9Ix+pxiDkWdGAU2txzu
	 xdVBoTgYQOMO+tmLn5Gr+gjpoX91MxbX8pDeOmimumUcXINjc7QSFd4J2mKFGwiLyP
	 18D5JnHx+IjvWc2HhcgnORXr9RyMNp5mwnRqGKNqSYLIomsxtpL7cektJ6MBOfJsIL
	 njtz/g1dUyscaR2xAsfxfx7d/XYziDg+mt06Ba0+vgoGnOdXdbeCyLYNwGzkOg3GNA
	 37IH2PdnYNOeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 07/30] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:28:24 -0400
Message-Id: <20250414132848.679855-7-sashal@kernel.org>
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
index 9bdf6fc53697c..587385b59b865 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4273,6 +4273,10 @@ static void nvme_scan_work(struct work_struct *work)
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



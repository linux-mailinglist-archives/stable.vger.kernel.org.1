Return-Path: <stable+bounces-132560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF5A88358
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D24188AE97
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B4518DB02;
	Mon, 14 Apr 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDPI70l/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066F2522BC;
	Mon, 14 Apr 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637415; cv=none; b=BtOuAOoTtyNdYUdvOwsmC1ZeIwmAuE2VNEN2MGSvv7s8rYRPxhYsAQ4aGB5TMFpTyralgxw8XHNI7txBiJZ9PuXD+yxWY/RCNnCMYJi9TS6xenDHEpdzIfoSCDB5ras0Ig49TZkmobTi6FJ3tOtP0CBdXy/qWHsIMn2ifOdejUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637415; c=relaxed/simple;
	bh=+W9WbnTJ5R0nzHALR/B2SpleiwIu9eSewvN7yX8mA24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjlYyNm6OyKzqtG7Q73iHRXMUsXn70CfNKyiS9NvRASSgcv9ZB5hzKf/IfbniAub891KW03lr0Q1gRBaMZCQyKe5yMsYhn40ByvWCz043dTiAF2rhORL+09naHcYtHnbRV7tOmMWUAUIBRh9yT5dqtsw3AlI1i0K3AlU9c25guc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDPI70l/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7E8C4CEE2;
	Mon, 14 Apr 2025 13:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637413;
	bh=+W9WbnTJ5R0nzHALR/B2SpleiwIu9eSewvN7yX8mA24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDPI70l//D3yb/wIW1pkRTILTO9wzC9KSfSXIgcdX0IICaDDDTgSm/7C6I6AS6YPm
	 qY5Ppi1UlZhMwFjD95haW9NRHlj+5AZ7NzqGAhsGqF23Ef6eLJBw1WeXDQBv2OotoJ
	 6urXoeaeiV+AnKFc377OsoCx3TpLl7A+D7nDwmbPUYeM4tKc9kz0hp6r04pah5PVNN
	 F+Zl8u4qmpxstyrN6HuoOWBu43H/PHTNPqxcHu35bd/Dl3hJ2M6obuiKeLNYb1MijH
	 LCI7btbCCW1XaxD2iftn9X2j+0ueN5rbsWKOX+btfNslY85gz5wKD+xi4JnrzzmoCP
	 uvp/jvHLqBiUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 07/24] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:29:40 -0400
Message-Id: <20250414132957.680250-7-sashal@kernel.org>
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
index f00665ad0c11a..e36c6fcab1eed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3972,6 +3972,10 @@ static void nvme_scan_work(struct work_struct *work)
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



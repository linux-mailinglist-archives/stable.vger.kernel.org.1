Return-Path: <stable+bounces-132464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AED7A88221
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CB4164B97
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4FC252293;
	Mon, 14 Apr 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dbr/INED"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46725228B;
	Mon, 14 Apr 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637192; cv=none; b=MzPNNyud2o1qNAftRpHFzMGbHnM9r0kUmfYVt1SIDEqCjVuJX4A8xx4MkkjfZgFYSOwGDXd38V69SvHyUN7+ckn/Kce3/k98+3Hp6zJipnznacSmlokxdomUdcT4YzOA+EsxcuwiGMTIxFuEXFxyiIHYQiEVVhEQxMbMdOelEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637192; c=relaxed/simple;
	bh=CJepgFajH+uEClC5+Nr4xS6NXi18SZs+QeUfB+qxRhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UpL9ZC+hkx4VDGPfroVsfZJA4mgrjDCmUCLnKzRjIpRrcfBIBMtdcEDPLTpcgFZq+Gol5nmoX6QR5Ry/3KRkgAeGLwRETDXjpNkv4tZn+3QvdgwOiyPDGXIZ1cKyj4xOfvDCUfl7MKuJJiUfpyyHA8TZ3aYgo4m+E01BCsgshxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dbr/INED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812BBC4CEE9;
	Mon, 14 Apr 2025 13:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637192;
	bh=CJepgFajH+uEClC5+Nr4xS6NXi18SZs+QeUfB+qxRhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dbr/INEDDGfdA/i82DvLsznRYDPI65L2AGnSHDHvkqjZTNb7KHmRd1Vs8JVvImk54
	 C3OKQExiyAWYiZYLb1qeX/nZldvwXM5sf10WVwcEmEchGJwHhsftFmlfKii/aGl3yQ
	 +8xBf6HcE2VyB0Qdueg50nWi9u5YM01pGBqxuIZ+O6DMywHJZG+uyEUXVdY64ro2gz
	 hq0ZmKaJ8M+8cGZv+zFdTMGvtG5YOkvnXBCaMTjip8+gc4fWqaJ+bjTVGY7u7Ayi7c
	 PmKVVM9Xfuj6fHgDLK+1ZGw4MOPlmsfhdPqWcbqRXcDUmdrQTA9fmILNFj37Q84rzI
	 PcHXSETHdxAuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 10/34] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:25:46 -0400
Message-Id: <20250414132610.677644-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
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
index 8359d0aa0e44b..70f9c2d2b1130 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4292,6 +4292,10 @@ static void nvme_scan_work(struct work_struct *work)
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



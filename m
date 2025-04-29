Return-Path: <stable+bounces-137549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89007AA13EA
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D7B18830A1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBD024113C;
	Tue, 29 Apr 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CcswVKHU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABABA23C8D6;
	Tue, 29 Apr 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946400; cv=none; b=JV/BwnaN40DIxlGSlIuGnNa1p+a7j+43S62BM6sOsRzrMGjnzzomdDsaM3Cs3fPFfFa5WfvpfLFbJ06WBl1f4McYwpTcSfvw2Ft3Qyuou2UucV6ffBw2PbHUct+6WdMh4KjWSE48KqDpwhibXAPryzRpDGyJM913nXiPMHLOlwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946400; c=relaxed/simple;
	bh=DWFeldlnZ3IPa/9SY6C7tmK40jxiRFiKapb1p0lKNLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avHuPs+GCA4Buv9gDoxUep5jGGflluq3lx5A3/jQG7/ZOuSeitE4ihPNnrkj4NS8doxJL+ldpn47zaaN6k9ywXscAcDunu2S5TKgdRjTFlnxzGldnQrcdSYnsCmfJ1uxYgPJyMLjY0uy1J4jUQtMT1OPA4NKsbxb3D9BiAUQ/MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CcswVKHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35933C4CEE3;
	Tue, 29 Apr 2025 17:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946400;
	bh=DWFeldlnZ3IPa/9SY6C7tmK40jxiRFiKapb1p0lKNLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcswVKHUccE33gCaLAJEyjr4Q9G06/bvkxOEhDtrcm7XT8voHlx7u/p3TP1TNjqnm
	 n2wmCfjrxo/f3RJ1bnBfYGrhv+rGOqAsVUIfAuSPEGBAI9ZAeP0ytEMU5/+l/N/XrT
	 Ko0exq2lr7tL5DF+HEPJWlDBECqoXSg2+WyORRzU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 247/311] nvme: requeue namespace scan on missed AENs
Date: Tue, 29 Apr 2025 18:41:24 +0200
Message-ID: <20250429161131.146675454@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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





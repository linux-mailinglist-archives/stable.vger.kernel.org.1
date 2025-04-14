Return-Path: <stable+bounces-132585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450DFA883D3
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6C83BFB59
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEEF2D73EE;
	Mon, 14 Apr 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxcKn5XW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757CD2D73E4;
	Mon, 14 Apr 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637465; cv=none; b=cDzLD/3fMX27iI3+4D0vBrBPD11Y6wubGcKDy2A7esdoeHRTA3BEL3ZZT/+LSRwxbnYQaxwLc0zZhJaEfJZejB5eVhAxemQkLFGNXS4PTNRKcftPRwtN9wnPJ0ye9auCkmrUgucmfJU+oacblzAmru12yHc+plES4rsaMhsVrxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637465; c=relaxed/simple;
	bh=WLPqhcICB4GH5EgHVdkmVjqhnt+TGeP0aV62tORQN7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPwl4oS1Nvg6Wc7IKEe1iDW5sJfNMZgzyJEI4YnN7ixHFE1a2zxPy2/w0j3e2md7oUYFAdAgae+i81AvghReF5xeCyIl8QdpxPIa5vMzEJWTEj+dp41y9aNrmiR0iUWtGjWK2/Lb/XJvgRX4BD6hXMWFuzfd82SsnoHUSVufFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxcKn5XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E82C4CEEB;
	Mon, 14 Apr 2025 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637465;
	bh=WLPqhcICB4GH5EgHVdkmVjqhnt+TGeP0aV62tORQN7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxcKn5XWUeipY+Zis3KdKq7ltrKJoPPM5lbzwRBzHPOc3JkP8liWNDUS2NNg0rDUE
	 D44rLuPt2mLQXkzu6wIURB1GK7Rt+FmZytJ8+Zh/usm2fDXtmOZxEO8ZkXKthrMiIA
	 HAHivKC2w9SX7iVnA6ShXVsfBun7W/aFq1Dlmuj2XNM/69FvO5ygvvzXIQkyI9aNXA
	 BIMbbzgw5yAMV9d/qhL1ifJLC6FtjMzJVPcTeqUyPyH/iKuflYUki7lvgC7jVTSCqO
	 3y+BO+6R3ZjEkfh2yeedxGLowTh+bkTtrWl8ke0VMX43s/EBCVtC92vBeYxgd3FVqy
	 y/sSvG+uL5exg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 08/17] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:30:39 -0400
Message-Id: <20250414133048.680608-8-sashal@kernel.org>
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 62baf70c327444338c34703c71aa8cc8e4189bd6 ]

When scanning for new namespaces we might have missed an ANA AEN.

The NVMe base spec (NVMe Base Specification v2.1, Figure 151 'Asynchonous
Event Information - Notice': Asymmetric Namespace Access Change) states:

  A controller shall not send this even if an Attached Namespace
  Attribute Changed asynchronous event [...] is sent for the same event.

so we need to re-read the ANA log page after we rescanned the namespace
list to update the ANA states of the new namespaces.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ec73ec1cf0ff5..e199321086f28 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4708,6 +4708,11 @@ static void nvme_scan_work(struct work_struct *work)
 	/* Requeue if we have missed AENs */
 	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
 		nvme_queue_scan(ctrl);
+#ifdef CONFIG_NVME_MULTIPATH
+	else
+		/* Re-read the ANA log page to not miss updates */
+		queue_work(nvme_wq, &ctrl->ana_work);
+#endif
 }
 
 /*
-- 
2.39.5



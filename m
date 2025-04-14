Return-Path: <stable+bounces-132563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A665FA8835F
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC555188E0E4
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9A82C2578;
	Mon, 14 Apr 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ2KmPoO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A7D2C256F;
	Mon, 14 Apr 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637418; cv=none; b=Rw7nm+w54g4YnnfIv51QGPd5a6qkIkYwOugF1ts2/j4zTLC4080Jc6thJISpiSgQTCSeZKP2kPbRd07COow63of4I+cdXyPmuH0RWDZ3snQ/s0CrZW/KOEX7G4Nrxf0DSN3xLWLPwacJ+E7lkeJHCWsttOxPdkIgrM6DwsLxt04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637418; c=relaxed/simple;
	bh=WR1nmioPnYCDw/Q/8Q6v2DL7uBItXhvHeiWqF0rSOzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cVLFpSBQk8oBDqFx1Tt90d7cVuL3uwMTfyjnL+6HVRAGgFh6etcU0sunk8x/z4J4VHWwttzzkr4GTf5vrrrGhqJyNAktfXgFOUjfQo0l6BTSK+KL15jJixx4OyuYzaLLvBzECKuKwHNk6qisHATnAGthSGN4LExbH0JpGfIfMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ2KmPoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A4BC4CEE2;
	Mon, 14 Apr 2025 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637418;
	bh=WR1nmioPnYCDw/Q/8Q6v2DL7uBItXhvHeiWqF0rSOzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQ2KmPoOKeAVzLKhm7fQR3u2A8TDQK+qCsecIuYdPeBOtBVq4EUIQvPMlW+6YVkYZ
	 IxF7fPUUuMXwp4hORWtSySMigUmONuzxoI8bu8UIFme200U4fBKrfWdhMS+iEMR0CK
	 yQnsmYbtSBohEc2pdc1Xy1pd/EXs2vLexxfZfGdSa76bwNewZWkEeQm2lX4bYTtdLq
	 zgqn9h1FjAbK7c40fk8MGPS/ACLEEqymj6bc+o5vpqprR+2t7gW7MiU1XMQXClLpTP
	 cBurPKZmTcHdBEFTzeXMp0IiLcAVTTDDGc8NTjDxIqIJ42LZETX5Brd0ezy7LFhxYt
	 dKEe8UaxnrQYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 10/24] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:29:43 -0400
Message-Id: <20250414132957.680250-10-sashal@kernel.org>
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
index e36c6fcab1eed..8827614ab8c63 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3976,6 +3976,11 @@ static void nvme_scan_work(struct work_struct *work)
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



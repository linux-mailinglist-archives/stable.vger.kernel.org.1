Return-Path: <stable+bounces-132616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28364A883FB
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273B716A01C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F862DD679;
	Mon, 14 Apr 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIgwFhBE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D562DD676;
	Mon, 14 Apr 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637532; cv=none; b=VNiyJfD2TSafJUnjpPQMR0E3xBo1IfcxOpqeM+MmV17imglyL/g/awsJ07t+b2SNl2okDgcV7GRSjwpjlAyYQ6BoIbRJrTw3UkTWmDblhfeWz/hcInT1kLTVJLxwegVed2k32FRYJCbblJ5qD4jmDV9hup7+WmhOB8C10hNNWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637532; c=relaxed/simple;
	bh=kyogF4eFc8Y+rCLo2T580oxtNnBC/Fq0z7Wi3o7A7jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBzN8ikW5i05AUlrO3VWTMsS4r1owZ1L8vc0h+bUANjVmZQ4leX6RxpMMqwkBKosCLADGgYwZ7ZZHMYGZJAmu0JxCVq//saI4I2stj1QhXlMrb95eiT3mx7vqnHzYEryvSVa4CEu8o4d2hI+zynmnfpsx8SokYAdinfnzwqu2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIgwFhBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48C8C4CEE9;
	Mon, 14 Apr 2025 13:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637531;
	bh=kyogF4eFc8Y+rCLo2T580oxtNnBC/Fq0z7Wi3o7A7jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIgwFhBE+W5Y1yJRhyMd6lF9WoOu662La/49NwJOdX0FFEkEje8O/NkYJovk/ki+8
	 febZVMwSlIVd0LnYXC/lfzJ6544JnY1agGRCwWXKZSNus2S6ofcIQ9MNGEEcptv++K
	 R7irYS592hQ3aP2FMmpye2xm6lwzteH5W+TX60Mf9EaM8RcvPebLKQgu8viT9WQpR2
	 1McV4PIIivF5MAdgCnn1zbas8jL3cqCCtH3iz1uYAasWkE7ey8a+J4qP6sa33ci0PA
	 pJF2/3cusE9UufLv047XUXnG5LP0wkVmoUaA2iXkJ2FQuXU060weSOebmkekbKB1ya
	 IVYGTlmJp9saQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 06/11] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:31:53 -0400
Message-Id: <20250414133158.681045-6-sashal@kernel.org>
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
index b3ca27b78f030..ada9ec02e9b53 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4269,6 +4269,11 @@ static void nvme_scan_work(struct work_struct *work)
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



Return-Path: <stable+bounces-132471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A581A8825A
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A893BB15A
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FF225394F;
	Mon, 14 Apr 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp6M8RL+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72117253939;
	Mon, 14 Apr 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637213; cv=none; b=o9uCkPxoi6FiROAPU4KBQeQX4Q2L+QCx2bEYLZGrdaBYl4qvSpmkbej/j/zFi/JPXIaQEqtxTXC/bvuzsGgAj4dhd+lqsgUJwZNIjyURtWKVAGgZFOYV2v2GE8Rv+l0w3UXkzAexFxWHw9FBxevQBki6E/G4kG+WRsi3mGwzd80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637213; c=relaxed/simple;
	bh=Dk7DGQ+Ldoaia2BqL7ftzKH5lZunYpvEa29t/X7CyhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fgzPlqySlmR63bqaHtUIy75i8eCIbw5z83tsFV3Ei9cupCbcOL8yksCr/YLX9Y6jnPWrbckXftmM5ylCXyY/Ig91/JjYCMdpKF2KSeI06isUL8lsL4SgIWT/3X8m9125PFqJWpNaIgXcFr+1gMRPbaoATpeYsfypeouphq536ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp6M8RL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BE8C4CEE9;
	Mon, 14 Apr 2025 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637213;
	bh=Dk7DGQ+Ldoaia2BqL7ftzKH5lZunYpvEa29t/X7CyhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wp6M8RL+N4r8W++cz/SajOHog4LVXZvMLwAacla/oRsx0rvOy87pKolyky/P2g3sL
	 DC5+mcgdx5Ne6qUU+9iTKYeA0++iKkqEepsOT7DrkUfN+WnkIDAUHpU7Te5oIVF6QY
	 3HuXfEO+Rupunho0FgwUsq24s2w0hIHdWQby8zku0DnpzkcxSebDdBNlBtAlcoOMTV
	 WyKN/wsgLXHuBhXg4x3ljl/sPWiPlJRzTwPdXzFT+8oYEh2AnweLAjuty+Y/Hausmv
	 n3hjhcrptxDHZdmmJcSImOxJwOMe//5jsyhBPhq4d9gd9nDy8CqQ/Z9U+iOPB2Nnfu
	 5pIoss8sTcT+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 17/34] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:25:53 -0400
Message-Id: <20250414132610.677644-17-sashal@kernel.org>
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
index 70f9c2d2b1130..edee1ec3d4780 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4296,6 +4296,11 @@ static void nvme_scan_work(struct work_struct *work)
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



Return-Path: <stable+bounces-132536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6666EA882FF
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F1817149B
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29F29965B;
	Mon, 14 Apr 2025 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RElN7r77"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EF299655;
	Mon, 14 Apr 2025 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637362; cv=none; b=bYYbIdhg+dVcLo7oX47rgV7hQ+jZg7hwR1MmQh8OIMWUyQ9q9PGXe0k+3Lo4Ah1cR3mPxituFrM6FOmvX+xbt6gdU1VMZV8y2oK5cIafGIkzElRFkyGZVjnOBXk5/YE5iZuOGd+MUrlwzj9MxUXArL/T/Y6rMO6j8gi/vGjobZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637362; c=relaxed/simple;
	bh=Pg6gCQBdEpkh4I0IgeWbw45o0IqIzFFpIq3s+sJzhjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJsbVFtAURRgkfDWBo2sKkuOOr/xWsBxiRjVgOlg4mUEj4bhOuKY77cIGoqpQBMkJrGkHkjt65aGD1n1fC7cqtoYAe3q7oly9BRvQ8JVdKxL5hG5X0BvKJyOznAYwMZGC3gITkFRh/JMaruRoqm45R79YEsO88qUtd/nwEaS+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RElN7r77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAABC4CEE9;
	Mon, 14 Apr 2025 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637361;
	bh=Pg6gCQBdEpkh4I0IgeWbw45o0IqIzFFpIq3s+sJzhjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RElN7r77S5yWeybi5dbMERozugb2jENe79wBMaCC3loszV37oarvgwkVsOdoXqPA5
	 COO5OspkEOrfxzrcHwwUeLsDykD3SL4jyMiNU4/6c9DeUMz3FrcsSAzH6IZK2MGRlb
	 EvqChYeqEVDJ5XywFxalxUfnM9ZJSizf4rOUKnmXTg78AzYlau4e9Dm018IgSx6DD0
	 LYFFCT0SV6giEj22vUXGuB/7I+M+Qx4vZbyYBnC4Xm4qRJhHvfAYbZNPUFyag3WvMH
	 RZhiCs8iad8FYcn8Aei4jGQwRfRNrLM4gekxVoO7kyLO40S47WGgUXxm0oQPfV74KG
	 2Yy2iQGk4kWFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 13/30] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:28:30 -0400
Message-Id: <20250414132848.679855-13-sashal@kernel.org>
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
index 587385b59b865..f7519c07ed3c4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4277,6 +4277,11 @@ static void nvme_scan_work(struct work_struct *work)
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



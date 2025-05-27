Return-Path: <stable+bounces-147411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DDBAC578B
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C133B0F49
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F4727F178;
	Tue, 27 May 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZnIV+7+T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE523C01;
	Tue, 27 May 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367259; cv=none; b=JHPq5ZhXx9Cl2uS+9bkK1HgGHqNIEvsLFSQtwB41+P723onMxCEvLeQRNHVeNUKHMkLvm+4lYqDh91rma+DzrvdxFTch2MrlMPpkcQoG2sJ2F2I9O1vJwMXdffFuoulWxMeGb8+o4GAZr+mhyq0VKUR4AUna8Qqs1djCkyYqUV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367259; c=relaxed/simple;
	bh=9VbenKcsQMgXoDiyHIyqvq+c6rzWiH+BnTCypxCFOkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLn2NrO8XCZ52p/4aHleiurt5bbUBcrQ8Nglq8/kz4Qh16E4WdxIZAdRlkp5nLlkWndJ/OhFZ0igPDi7vSDd0Gs0lykOuLvyfTPWGb8LF8EBL0dZSMSMItmXbY37U/9S9fOY5Cm4dj2KJs9ZYy6BFIdYxTZZ5oSCSB6RTR6Y4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZnIV+7+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA34EC4CEE9;
	Tue, 27 May 2025 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367259;
	bh=9VbenKcsQMgXoDiyHIyqvq+c6rzWiH+BnTCypxCFOkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnIV+7+TVyinsadk9FDSnHsJRMJE8aJhY16mq3ardm0n+GzWuyN/vWGiVoo186xNZ
	 7/V1stze07ASxM/KxNdzMwnWBQWZig2woDnnc/UUS57SL1yjt4N/Gzil+w7xy9B1kb
	 sEK9TvQEv3hDWpG0jLqw7v0wNP4fBINckWCMm1Ek=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Moshe Shemesh <moshe@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 330/783] net/mlx5: Avoid report two health errors on same syndrome
Date: Tue, 27 May 2025 18:22:07 +0200
Message-ID: <20250527162526.498217884@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

From: Moshe Shemesh <moshe@nvidia.com>

[ Upstream commit b5d7b2f04ebcff740f44ef4d295b3401aeb029f4 ]

In case health counter has not increased for few polling intervals, miss
counter will reach max misses threshold and health report will be
triggered for FW health reporter. In case syndrome found on same health
poll another health report will be triggered.

Avoid two health reports on same syndrome by marking this syndrome as
already known.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index a6329ca2d9bff..52c8035547be5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -799,6 +799,7 @@ static void poll_health(struct timer_list *t)
 	health->prev = count;
 	if (health->miss_counter == MAX_MISSES) {
 		mlx5_core_err(dev, "device's health compromised - reached miss count\n");
+		health->synd = ioread8(&h->synd);
 		print_health_info(dev);
 		queue_work(health->wq, &health->report_work);
 	}
-- 
2.39.5





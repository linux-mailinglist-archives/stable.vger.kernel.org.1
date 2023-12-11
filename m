Return-Path: <stable+bounces-6073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B06980D89C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1751F219EE
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1867751C2C;
	Mon, 11 Dec 2023 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jJmod2rd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4E4437B;
	Mon, 11 Dec 2023 18:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55204C433C8;
	Mon, 11 Dec 2023 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320438;
	bh=bNKG9tqOpRLAuXuLC6v5re3Mn/PPJM27o3TaITtk7s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJmod2rdANalGtfqNzU66yNLWO1Ka6sk6ED24YNNOsEs3c0YoV0e92NwUfhqzEpJf
	 kBqefXyjaTicWsIZOpllkuhcZwyLg1DFh/40ylBawlxN8g5Wqnuac0Rx95n8oKG6lj
	 JJM9A6qBaPvoQUZ/rXIlDRMxWxjXqD6qtpLG0hRQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 062/194] mm/damon/sysfs: eliminate potential uninitialized variable warning
Date: Mon, 11 Dec 2023 19:20:52 +0100
Message-ID: <20231211182039.269854573@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 85c2ceaafbd306814a3a4740bf4d95ac26a8b36a ]

The "err" variable is not initialized if damon_target_has_pid(ctx) is
false and sys_target->regions->nr is zero.

Link: https://lkml.kernel.org/r/739e6aaf-a634-4e33-98a8-16546379ec9f@moroto.mountain
Fixes: 0bcd216c4741 ("mm/damon/sysfs: update monitoring target regions for online input commit")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index dbf5e4de97a0f..9ea21b6d266be 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2210,7 +2210,7 @@ static int damon_sysfs_update_target(struct damon_target *target,
 		struct damon_ctx *ctx,
 		struct damon_sysfs_target *sys_target)
 {
-	int err;
+	int err = 0;
 
 	if (damon_target_has_pid(ctx)) {
 		err = damon_sysfs_update_target_pid(target, sys_target->pid);
-- 
2.42.0





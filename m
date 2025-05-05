Return-Path: <stable+bounces-139795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75184AA9FB9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0249618835BE
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74706289349;
	Mon,  5 May 2025 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGdkPbeY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE9B289345;
	Mon,  5 May 2025 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483351; cv=none; b=ncCOKyCOdnpwzbUOgFBuTwQAggRAqIOxZ5JHXKXXUIjKattJs9Eq7SgQuFUrFXcIeZuuGiDz+hb6QjjkSq1KmvYub9QLSF0zgyQyYGEnPZkg2wxmU64piOv/OpGMC451VRAhDaVnYLYbmtBPHOOjNXhHHwkorQCe3CW4XaRsng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483351; c=relaxed/simple;
	bh=CFmWoJn0X1XzL9UZA969pY67TiklTsAy6LxaHpXKOtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXRbElJLKZqtzDcxstyV/HxDvorms+tpMDyVOHKENWgkSQAuhJM3txIbnMdBZKd9Z430JCzLQIB8uiqLFvRet5t9Ruqdff7B/bDVoOn9tpbyAnrsCTHBknVmmLYYfbJMCzd3z5/uNVUGxLrwarabilZC3Sv/c0xWQO7UqDHP5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGdkPbeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63780C4CEEF;
	Mon,  5 May 2025 22:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483351;
	bh=CFmWoJn0X1XzL9UZA969pY67TiklTsAy6LxaHpXKOtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGdkPbeYoArvx9v8x++bh7y9d/ojo8CtvOBw/G5aRkpvBgqGrQRwSZJXtJmoaFnCT
	 +7IG+gDjaDLJv6o3lqNmz1TlIumo8pekFNphb9iqld9FwmTRxMMGsREDDGNG0dVUcN
	 8xF9rS6S0lMt3/8YzkETSbXh0J4Bx3IZOx2KqaI29JdsPo+7rA7k50Tu/i9GOM8v4o
	 VKsNqDOkORWqr+j7hTlZVS+YQrwwaHdJCn20N7/rjUZJm7Zh2vCNPSuLYJQcIYRNSa
	 zwRXdZEUpDSh86u4vp4zU9Gz/qGIZbgFfLElDNHSYn+rBPwHDnxJUAQtMyQijMIYWi
	 cr6irQm+RXlMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jing Su <jingsusu@didiglobal.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 048/642] dql: Fix dql->limit value when reset.
Date: Mon,  5 May 2025 18:04:24 -0400
Message-Id: <20250505221419.2672473-48-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jing Su <jingsusu@didiglobal.com>

[ Upstream commit 3a17f23f7c36bac3a3584aaf97d3e3e0b2790396 ]

Executing dql_reset after setting a non-zero value for limit_min can
lead to an unreasonable situation where dql->limit is less than
dql->limit_min.

For instance, after setting
/sys/class/net/eth*/queues/tx-0/byte_queue_limits/limit_min,
an ifconfig down/up operation might cause the ethernet driver to call
netdev_tx_reset_queue, which in turn invokes dql_reset.

In this case, dql->limit is reset to 0 while dql->limit_min remains
non-zero value, which is unexpected. The limit should always be
greater than or equal to limit_min.

Signed-off-by: Jing Su <jingsusu@didiglobal.com>
Link: https://patch.msgid.link/Z9qHD1s/NEuQBdgH@pilot-ThinkCentre-M930t-N000
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/dynamic_queue_limits.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index c1b7638a594ac..f97a752e900a0 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -190,7 +190,7 @@ EXPORT_SYMBOL(dql_completed);
 void dql_reset(struct dql *dql)
 {
 	/* Reset all dynamic values */
-	dql->limit = 0;
+	dql->limit = dql->min_limit;
 	dql->num_queued = 0;
 	dql->num_completed = 0;
 	dql->last_obj_cnt = 0;
-- 
2.39.5



Return-Path: <stable+bounces-141349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A202FAAB2C2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6821889F18
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9CF36BA30;
	Tue,  6 May 2025 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWJEJhs/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC536E0AD;
	Mon,  5 May 2025 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485851; cv=none; b=IC406cj2yBD1zwl33J/WJKEnsiT9VZg85gi/0Z3qmb8iUpwCZt+IejWNqb+InW0RqOmjbuShEliiWBy9sAcpIU025LPYfkFOf7FuojhUrzA/dFPZsUDLHKMyzWewYSXvz2BYmuaA1nk51NeqtNS3GlJvJkwwZ7dRZ8Ev3Wz8RGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485851; c=relaxed/simple;
	bh=c/ZRcjt/5odMSgBwPe3ZiTpzNSyYGXxRkVdPpWZtesY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8F73OwJWhXeEF2pMoLrHKobfQLgbq78el1jK+APLZW/3d4BTtMkqe54phZ4hz4QtMtGL8GPf+lXwtqOU4qviN7oocLZgqmvwFu6aWGN7k874gm5ZXQWAbmJLPYQ6EbJEo34f5a8SSUcvQIo6Sjsy6nzqDyERbQutIcY2IQURBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWJEJhs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271F7C4CEEF;
	Mon,  5 May 2025 22:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485849;
	bh=c/ZRcjt/5odMSgBwPe3ZiTpzNSyYGXxRkVdPpWZtesY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWJEJhs/VPU5mnSIYe9AkX44I0dNNKoywHt1wENiRiUndQAT1EeGqWaayzIlbnmPl
	 JPH6VKJ70SZCsocxb7IhJIfb9e1YrfnXOdcU7xb8oK61AorkLd0SPn5fkgolo3ysQ+
	 5c20rEkhM5r5l1C7pnxBKTKwHAiRnXsRSnPoDQtv2Sy4voIm1/5fNr1Tz4azquG6/M
	 RPqrIfl28oZtzQ11wH5Np84EcR0jFRymnnuF6PALRBySqhbiAqhO9EauGJ2k8HZdsc
	 iKKs3xh5L1aG4EoUfNCxx8U9xxus2ii+LsAO4mDxRYJr75ANni+iZ43t2dec0HPtlV
	 SLQgf4leim4/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jing Su <jingsusu@didiglobal.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 028/294] dql: Fix dql->limit value when reset.
Date: Mon,  5 May 2025 18:52:08 -0400
Message-Id: <20250505225634.2688578-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index fde0aa2441480..a75a9ca46b594 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -116,7 +116,7 @@ EXPORT_SYMBOL(dql_completed);
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



Return-Path: <stable+bounces-141478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62EAAB728
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1031B1C226CF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76333EF64;
	Tue,  6 May 2025 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHCjWNvo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391E2EC00C;
	Mon,  5 May 2025 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486430; cv=none; b=jXU+1bRipXG2TAhIsG0vthuFlpO2tJSjTp07cezuJ4VcdWSAWvDNS4iRBgUjOIPf4HOQLsC6w+0GdfKfhaJTBcFBMsIMt97fJ78/MsMpaLyx8m8XJTfUllE3SYAAqsUVvUeVtMLlkMPuk4d+XtsbCiNi4dIZh0d+N5UayNm2lys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486430; c=relaxed/simple;
	bh=c/ZRcjt/5odMSgBwPe3ZiTpzNSyYGXxRkVdPpWZtesY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YY5vYDQMOwxdVx61aS321rRU2oV1yHZ9LkxkucDe6TYxfUsFU9BvStksV+fsw5fUq5ai4f1fmt1i0tKK3Iy7+hnKk1I50gCYJlX/G5TBP8ds6Q1zvb1NL1IFCMMk1Q8y54cAmOOtGF8IEWCXzZrv/hyr08FrwQSWBuSyhaebhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHCjWNvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5BCC4CEEE;
	Mon,  5 May 2025 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486428;
	bh=c/ZRcjt/5odMSgBwPe3ZiTpzNSyYGXxRkVdPpWZtesY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHCjWNvoBZxyW3E+0meqhob9I7NxyOWVe63j8wEzqsJcmLwNQWsoTvrS7PwOiWm+1
	 J0AIrWsw6SBzmYeXl1YWioGJU6ldKj30SZfsEJeFHd1zpvWlHT26ESrRZmcACE61c5
	 xzwOlVy9tn5eohTkGuxMbYM4g4D8uXq4CgtqDYCiCMhhegLrqtwKJWpSdnMhJhsbZ7
	 oPP0jgnLMsaGuB4V7gMP84b5kLC7G6/TdSmFwS0uzDbg3NwJk5FHf3ayheogrCkTFJ
	 rQxcXqBUg5TRk4NBLyhqkNYL2bvMbFBGWCROjOhIQRcP5/uqbTOl9QAizmUHxxOx/h
	 PC1ib0XG0vnWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jing Su <jingsusu@didiglobal.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 022/212] dql: Fix dql->limit value when reset.
Date: Mon,  5 May 2025 19:03:14 -0400
Message-Id: <20250505230624.2692522-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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



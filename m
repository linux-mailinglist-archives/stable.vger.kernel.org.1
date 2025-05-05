Return-Path: <stable+bounces-141675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE683AAB79A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060654E30EA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EC549E683;
	Tue,  6 May 2025 00:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOGD61Yq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C8D392F94;
	Mon,  5 May 2025 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487126; cv=none; b=k+MqW3xPnKflg9VO+ThUrQEMIW2EV8NjNaCqa+PUybop0fCm8YbMAlc0a8FajeRl1Ls2U7ZyzTcgu9vBuyEoAyO9wii4GiTa9a/KITzuY6mnYfQgb/AoLhNDX7yH4Tim3U/90FLVoOIdJNsIeep0tsXt6T2FeWDTva6sFtteuI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487126; c=relaxed/simple;
	bh=c/ZRcjt/5odMSgBwPe3ZiTpzNSyYGXxRkVdPpWZtesY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRaDjbIDYu+4kDEw9fzfjsmN5MH7KOq6qCtkxOAG+7OHd5f7cRC2wmfVSV24rGg1QhchGHjHREMpxuEVAnElFeY9AmYwBzxwso7o8k9KuhNm/bww93amXAfPmM10ADRSWZ9FZe+CtDLpPKUDhONIv11WuI5k/Dj+0UdZu+QPzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOGD61Yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35C4C4CEEF;
	Mon,  5 May 2025 23:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487126;
	bh=c/ZRcjt/5odMSgBwPe3ZiTpzNSyYGXxRkVdPpWZtesY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOGD61YqTLrMNflX7cPlUaWBLdrTGNrXRiBfy5vpJZ9Yyde+2wOIQCdPAARKaWMDD
	 GF4+DmTPcv8oP+UkCQp+qCSoMgnO/TT37jtdSnvYQjYkqEKg8dJJxTw5VlY+y1W1RO
	 A7m0mJNzqzwBs19HMeNiLW3c6Iqy3r5+Y0zmwXIWbbv0blPRs1TBF9dBFdYG1X7tS4
	 UifkhA15BDfZmsTBs490myf0mEF8ApsbTdVSOKinLpYg57YSTGRExz10sSJeKUd54W
	 RFUlENzNGFHH80patBRkn0pnRsL5+UyPxDLDmb2ZARPLMi5c6qSBtdlBx6t9kqxL5A
	 my25a1PNHz3zA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jing Su <jingsusu@didiglobal.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 012/114] dql: Fix dql->limit value when reset.
Date: Mon,  5 May 2025 19:16:35 -0400
Message-Id: <20250505231817.2697367-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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



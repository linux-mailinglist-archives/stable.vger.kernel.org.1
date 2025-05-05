Return-Path: <stable+bounces-141596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC58AAB4C0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EC3189344C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF44482607;
	Tue,  6 May 2025 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBs+TmUk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3F02F2C75;
	Mon,  5 May 2025 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486830; cv=none; b=JFOaFkUJP5kvfIbnB80HtAdYnzwxEs+6LWK5nutAXQExvsKyQNHb06FVmngvgQ6ISfbi3SzIuAldg1qpToQhQQYcgshFtzOaI9XLu6ZzXE6ueCAeEW6Lz1gs1vh7K+0Cfjax+5rqTKoIfateeCP0Pdf6qrkF3uUFHogiOmGtSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486830; c=relaxed/simple;
	bh=c/ZRcjt/5odMSgBwPe3ZiTpzNSyYGXxRkVdPpWZtesY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XX3hQaItL6C14dWvkzC3g6dvfmIRECEaKMeiGfeI361mjJugt779Se6+MO0cycGch1UbQ2+J0HiZC1CL/R3m6L2brqinzSc5c7290/MJ933qjsujnvpdJ3LVngfnCv0MV3Z6Bv1+h8OTHIcvkHNasrhTin8Okg8Zf37mpCKxQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBs+TmUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB327C4CEE4;
	Mon,  5 May 2025 23:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486830;
	bh=c/ZRcjt/5odMSgBwPe3ZiTpzNSyYGXxRkVdPpWZtesY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBs+TmUkcDi7VAKOLDSoclJgodXZhS7ht6BuSB6Ea8y2445GAA54fUFczpR+LTWHH
	 yBysunE3O4IHDyjk7rFi2/rqLCzWS21Xl7RSpjTWbAgmuWWIFUF+Tq0l//2qMNtCEa
	 Kg7NWG0WZdnzd3H8TZSHXMcBnefyqBIobyw5Jyqk7rZJfydtt9HWsOfG3QIVOK82Xm
	 DTaixtnE4XibN4umM+5snDgBTLcYCTL0WIMmEpNfs1CbEPBxCd8fpOa8YClWA0iYoe
	 SCmfwPuZPm8io6d0yLh3dj+blISIPkK5UM8VxaG5KvEXzXGt+SA1xpDGJO0I9Fb2UK
	 3j/bdlKG2uz1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jing Su <jingsusu@didiglobal.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 013/153] dql: Fix dql->limit value when reset.
Date: Mon,  5 May 2025 19:11:00 -0400
Message-Id: <20250505231320.2695319-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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



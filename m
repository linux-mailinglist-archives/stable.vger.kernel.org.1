Return-Path: <stable+bounces-127777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84807A7AB20
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C4E1899445
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516F0261372;
	Thu,  3 Apr 2025 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvIst5IJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC35261361;
	Thu,  3 Apr 2025 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707067; cv=none; b=W6KWkfQEvez7yAujGfYBRh6go3Vm1rmw4xQDyCFveUbAZ2ry8qjnlb3UgO3ccmErFCzKtV2+Lor9Xj9zlZj/twxPA6zgxn6hnNv944iZkdrhjn/dPU08A+LSrzH2F4rY9lY5rcnc/tdAxnBbwFGnOFyqVSHyVnRDsLw2oY2LV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707067; c=relaxed/simple;
	bh=eFB6fsPsXp9xhVhM7YxjbxdKgahOf8vjLvHyf7iWNiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qRE0kCirRudkKgwCYvn7lEFO4hrfrqo78qtGkm1kV59xprb8eLEvNWHNbs59fITJA+T4QY3aSEOw1bszRu14mhCd+mAx4GsQj3ofwsICUsxg7Je3YkZB/PgBotKyF3z7iGyNW7CiN/GxfdHTpLuPYT5y//TSHPoKj9km8Bxqzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvIst5IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880C6C4CEE3;
	Thu,  3 Apr 2025 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707066;
	bh=eFB6fsPsXp9xhVhM7YxjbxdKgahOf8vjLvHyf7iWNiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XvIst5IJHjZsld9luTFlo7lLAetcdVYsahJy55b5hRBbLYiVs90AcZdIQTVj+j8Gk
	 vrC+Q7jjMk0CVe/uZibGG+SU1Wi3a1s7lqTbtmRLlq18AYf9suX39GQapaWh59a8lS
	 pFzr+aRJ2S+VumNZnB3EmltT6/PDRDY+xCL2dIGFV07ht4q3mawfyndEG+0n/iqy37
	 BP7fpcV6zgwxVBoIUQxfBvbfbzUPqn9b4wtTcnUpFHpSRoklHXEhIa3Uev3JJ6P3Uf
	 O10f4gPsz8VdGGdjJuYp3O3nZiWLgLn/wg6XEZepUY4ud66lUMT+zcxzUyd1Qw5efK
	 Z4zOYL0JAYssg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	David Wei <dw@davidwei.uk>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	sjordhani@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 08/49] net: page_pool: don't cast mp param to devmem
Date: Thu,  3 Apr 2025 15:03:27 -0400
Message-Id: <20250403190408.2676344-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 8d522566ae9cb3f0609ddb2a6ce3f4f39988043c ]

page_pool_check_memory_provider() is a generic path and shouldn't assume
anything about the actual type of the memory provider argument. It's
fine while devmem is the only provider, but cast away the devmem
specific binding types to avoid confusion.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
Link: https://patch.msgid.link/20250204215622.695511-2-dw@davidwei.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/page_pool_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 6677e0c2e2565..d5e214c30c310 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -356,7 +356,7 @@ void page_pool_unlist(struct page_pool *pool)
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq)
 {
-	struct net_devmem_dmabuf_binding *binding = rxq->mp_params.mp_priv;
+	void *binding = rxq->mp_params.mp_priv;
 	struct page_pool *pool;
 	struct hlist_node *n;
 
-- 
2.39.5



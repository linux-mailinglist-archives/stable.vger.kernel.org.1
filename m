Return-Path: <stable+bounces-77185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DD59859D5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198111F23BAE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22D31AF4ED;
	Wed, 25 Sep 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSbjDwA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40B1AD419;
	Wed, 25 Sep 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264419; cv=none; b=sh4GEaBNYVtOppeYPpee8uDX14V1GNNOT/vbF2KnpCWmEesh18jfxt1HfWZ9yV+tgP4RNw/Ad2oXQtaZYAQYsS59Z5b8GKccsr2hK66OAGYCYWMDcxaHM4gv8v+kiSr3kqjMwZjULSI4awgaLUFzQqoNvVSKRrGwK1DMBk4Ysso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264419; c=relaxed/simple;
	bh=PyseLeQpvsNGIa7+PLlAdvIqATHgC6d93pVMovqchg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQIlhfK0+trqsC2MleFYGu4rT8js58hS1Hxh3g1begj8v7k9PEWX/HQu2Bh68EjwjCUPxxpQiDQTNRr9uktlv/rJGnysyY0dTKwQ1eOb0dWWjWpX2G7AfrhMYIyio8Ld91FSyCJ8r8HhV+j/HbbekSOF8gtqutxh/boOLgSuU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSbjDwA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C0EC4CEC3;
	Wed, 25 Sep 2024 11:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264418;
	bh=PyseLeQpvsNGIa7+PLlAdvIqATHgC6d93pVMovqchg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DSbjDwA+gyDfFpPuJJqHE0mneS0+VUuQ8GyeVem0suyUl3Z4a7cUq4BTCQfPINJZw
	 ZpyOvGfIX48PKczRfY4O13VLQmZCOhdM6nCnPcyyXK6P6eWQIxwXqzrRaaRFqr+x8C
	 c54GD6fjqx8I7zCTVWqNoFO7E/jh+s5Ngyhb3h2PzEKuanHg9FpLuN/rBd9W9LUEQb
	 o/3LOhjwoHeceEedlxxPD/XcxUYehQEL45WOz3cZdcselL4bxCcQlXa8tHNhjJyMfs
	 ftzYXzfKvn+5Bu5kdL7UnGe+Pfy7T613AI8E9K7gJTEQQc1Jufws4wBW8kEim7THqJ
	 I+OZOYx0jqqfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	yinjun.zhang@corigine.com,
	fei.qin@corigine.com,
	johannes.berg@intel.com,
	ryno.swart@corigine.com,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 087/244] nfp: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Wed, 25 Sep 2024 07:25:08 -0400
Message-ID: <20240925113641.1297102-87-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit daaba19d357f0900b303a530ced96c78086267ea ]

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable when request IRQ.

Reviewed-by: Louis Peens <louis.peens@corigine.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://patch.msgid.link/20240911094445.1922476-4-ruanjinjie@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 182ba0a8b095b..6e0929af0f725 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -821,14 +821,13 @@ nfp_net_prepare_vector(struct nfp_net *nn, struct nfp_net_r_vector *r_vec,
 
 	snprintf(r_vec->name, sizeof(r_vec->name),
 		 "%s-rxtx-%d", nfp_net_name(nn), idx);
-	err = request_irq(r_vec->irq_vector, r_vec->handler, 0, r_vec->name,
-			  r_vec);
+	err = request_irq(r_vec->irq_vector, r_vec->handler, IRQF_NO_AUTOEN,
+			  r_vec->name, r_vec);
 	if (err) {
 		nfp_net_napi_del(&nn->dp, r_vec);
 		nn_err(nn, "Error requesting IRQ %d\n", r_vec->irq_vector);
 		return err;
 	}
-	disable_irq(r_vec->irq_vector);
 
 	irq_set_affinity_hint(r_vec->irq_vector, &r_vec->affinity_mask);
 
-- 
2.43.0



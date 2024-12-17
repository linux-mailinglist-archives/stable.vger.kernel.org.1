Return-Path: <stable+bounces-104474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C4F9F499B
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93291887D76
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972C91E885A;
	Tue, 17 Dec 2024 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S/B48Nwy"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CCA1D47BB;
	Tue, 17 Dec 2024 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734433818; cv=none; b=Ro3GHvY1C+mECptI7X1ldGY54if2G4JROXy7giQKVgoRM+v28zs8snrApLWiYMOnRmP/VgTUuQxudSeTrMcAYt2sMY8fRiluq/25BUyQVAnBc6mjTpbMu0wnQ16uQvBZsy5h6JA8JCayD/nzW6WwpQXyo+MDw03kvNMvICgfkj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734433818; c=relaxed/simple;
	bh=OIR1M+9fh4+BFhfoky4riBmPazsRyhuJGydkzFwZAqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GO/OnoZ39Ub9nRH1JVzK+u78c9WOzIYUn3mqrSi0UtM0ty+FmlGZS5/CaiqiaOAFh75Ne9TeOdxf102tlHDS9YXyuCDpEq7SXLapQbovhDSKkC37ihUnWkXe08wCJ4tzn+na00i60luUaEEqazlMQetkC8DDXm718joUYMTfjMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S/B48Nwy; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rh33P
	/nUC4Gnwr+KJWC55Ji7OcvFXB2SLSjU5x6+XgQ=; b=S/B48Nwy/hDOVlxzDxpSQ
	H+SqX+GgAXLJy8G3a05QaU76Yx1zovlMKjZLenUwoqB43emU4PowNuBpaLJzluOT
	gwmffEP5NNXrpBaV08YYGQhPlMfuUppCp+1dzMOCHdYor7u51thc7PVuePaXyelr
	4WFkP0CFvbaOILz7yOOMso=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDndyN0W2Fn4urABA--.61757S4;
	Tue, 17 Dec 2024 19:07:43 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	u.kleine-koenig@baylibre.com,
	make_ruc2021@163.com,
	horms@kernel.org,
	mdf@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] net: ethernet: fix NULL dereference in nixge_recv()
Date: Tue, 17 Dec 2024 19:07:31 +0800
Message-Id: <20241217110731.2925254-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDndyN0W2Fn4urABA--.61757S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrZrykZrW8ZrWxury7uFW7Arb_yoW8JrW8p3
	yUCasY9rn7Jr4UKa1ktw1Sqry5Ga129Fy7WF1fKw4rZasIyF18Kr1UKFy29r1kJrWDtF4f
	A347ZFy3ZF4DZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUj9akUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRi4C2dhLpVeiwAEsS

Due to the failure of allocating the variable 'priv' in
netdev_priv(ndev), this could result in 'priv->rx_bd_v' not being set
during the allocation process of netdev_priv(ndev), which could lead
to a null pointer dereference.

Move while() loop with 'priv->rx_bd_v' dereference after the check 
for its validity.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v2:
- modified the bug description as suggestions;
- modified the patch as the code style suggested.
---
 drivers/net/ethernet/ni/nixge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 230d5ff99dd7..41acce878af0 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -604,6 +604,9 @@ static int nixge_recv(struct net_device *ndev, int budget)
 
 	cur_p = &priv->rx_bd_v[priv->rx_bd_ci];
 
+	if (!priv->rx_bd_v)
+		return 0;
+
 	while ((cur_p->status & XAXIDMA_BD_STS_COMPLETE_MASK &&
 		budget > packets)) {
 		tail_p = priv->rx_bd_p + sizeof(*priv->rx_bd_v) *
-- 
2.25.1



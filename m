Return-Path: <stable+bounces-85557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BC599E7D5
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA483B24FDE
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5785B1E7640;
	Tue, 15 Oct 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y+XBxS+x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1585A19B3FF;
	Tue, 15 Oct 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993514; cv=none; b=fjWM7iuMNeu4870UObn3oBGj4IJpBEjm0hilzSs4duCN6sbTHVNeMCecROalak0+HdQu3uhjQfg4cgO0WVWqEMnvHrK5ZfRslVGC88S2Bc5gcPKetJz8JRuMBV6JhtrDR2YT5cL/eXKfUjpyVgYvdZpQ5l8/af4Vhx17xUR2Hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993514; c=relaxed/simple;
	bh=yh0piDHstkJ94pfP2VqCQataKjmDJ5FPZcK3rX7UAGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axFmeBAknlWlV0NI051snqhX6kVZYxPei1+BwOr0+OO5Z1YgU616xWaJcnnqvzR5RlljCcW0MHLPme74gisD1LAg4n+vorSO1rhQOcYRw+vGbXklxGxX5YeJRll2yX+gdy/M7Xfh/pLKzDFFuR/yemnZu98yZrM19KOKtA4JlSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y+XBxS+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935BDC4CEC6;
	Tue, 15 Oct 2024 11:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993514;
	bh=yh0piDHstkJ94pfP2VqCQataKjmDJ5FPZcK3rX7UAGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+XBxS+x9jf5rzCufTB2/3nHP6AvTJ3Rbix6jkHIQnaYWv9qdMkmBccgxOyFN8z82
	 62DP9yKbWFEd+45zk5CzBS7nq435TaLoy14q4kU7uZ6ytfJXjbnEto94DgViadXBVi
	 WYkr2ZTFp+4eoF0j/UA9/ZEHTZ/hl25wkpAMFgPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Louis Peens <louis.peens@corigine.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 434/691] nfp: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Tue, 15 Oct 2024 13:26:22 +0200
Message-ID: <20241015112457.567430643@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 69ac205bbdbd0..331d05590faf0 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2665,8 +2665,8 @@ nfp_net_prepare_vector(struct nfp_net *nn, struct nfp_net_r_vector *r_vec,
 
 	snprintf(r_vec->name, sizeof(r_vec->name),
 		 "%s-rxtx-%d", nfp_net_name(nn), idx);
-	err = request_irq(r_vec->irq_vector, r_vec->handler, 0, r_vec->name,
-			  r_vec);
+	err = request_irq(r_vec->irq_vector, r_vec->handler, IRQF_NO_AUTOEN,
+			  r_vec->name, r_vec);
 	if (err) {
 		if (nn->dp.netdev)
 			netif_napi_del(&r_vec->napi);
@@ -2676,7 +2676,6 @@ nfp_net_prepare_vector(struct nfp_net *nn, struct nfp_net_r_vector *r_vec,
 		nn_err(nn, "Error requesting IRQ %d\n", r_vec->irq_vector);
 		return err;
 	}
-	disable_irq(r_vec->irq_vector);
 
 	irq_set_affinity_hint(r_vec->irq_vector, &r_vec->affinity_mask);
 
-- 
2.43.0





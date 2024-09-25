Return-Path: <stable+bounces-77417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFA5985D30
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56EDB29436
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8281D88B4;
	Wed, 25 Sep 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6MRMuCI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F041B0139;
	Wed, 25 Sep 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265690; cv=none; b=KVck5k1m6mu9cp+D5vAKY4lJIg5AZOFFodZ+y/4I1NGgLm3nFKZeAuknGx1NPNnwXHBhScrX+WPepX2dsQIeQ6YJb+0WTudFVj9hm4RgWybpT6QfVjD7Qi0+lZhWwA9abTrDOdFhqNRaTJ8RJEuPMBJJsIjooFJeQnHdeO7zkfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265690; c=relaxed/simple;
	bh=PyseLeQpvsNGIa7+PLlAdvIqATHgC6d93pVMovqchg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3eMFNP763MGgO8iuDcx8JCgc01VJfWykSscRzTFN2Wg/5ubhBFtGNPUY6atVnhXul8H5q7F4Dc8EV4yrEUXWBlwplNknIi8Nq3b6Qx3wiA1o+bbzNyTu7webRyBfTW+ubgLY7y070IVk/fcqBn4WSkcHtSqxsnAdIOCnNRTfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6MRMuCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5692AC4CEC7;
	Wed, 25 Sep 2024 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265690;
	bh=PyseLeQpvsNGIa7+PLlAdvIqATHgC6d93pVMovqchg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6MRMuCIHlzlsc+c0Gkug6aNtb243tZgZv1hlxkXsT8d3S3KxDmhY8gRivr1tslph
	 PfKhjDV1mpqOQ0EmUBUa0IdWwuk0u+tEfsx8jS5ExGlRJkWpEo3U5q2hUfNXp1rDV/
	 +wXaClHDeza/7LAiGBm4P5R718nRc2s6JZ236j989grMC21XeBXKSkEdp01GVNdN65
	 lZfHZQSyZwCUEqoz8POR6h0k7eVuEHc1QVBmKNubTQS4aOgscSZBFDLOb8O0CC3eXK
	 NcRff0Bmy7u+Mm/ny11uMwdYr1WN3zVBSjcFtrHaSMEypgvppi1A+XO4+u0DIKnGRP
	 I10UQ5wMmgp2A==
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
	james.hershaw@corigine.com,
	ryno.swart@corigine.com,
	johannes.berg@intel.com,
	fei.qin@corigine.com,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 072/197] nfp: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Wed, 25 Sep 2024 07:51:31 -0400
Message-ID: <20240925115823.1303019-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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



Return-Path: <stable+bounces-77603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D421985F09
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5CD1C25A44
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2EF21B437;
	Wed, 25 Sep 2024 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGmZD0SP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DE21B431;
	Wed, 25 Sep 2024 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266434; cv=none; b=ojjd8tECa4OGI4/26TmPhAMgaiCok98e+pdtho10teWhXtJ5WA64bhePG4W69lzFahS9SnP/QerxXCp90NBWzgeHePibQ8q+fEUPZKSRaOQJrjzHUdTfzZsWonZbo0ewreSc0M3hulM8guPRlndZKRkCqVvEbz7kl95ZhCCXnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266434; c=relaxed/simple;
	bh=QMvbVhN2mfbI/fjEYtZiVHzEFLEkBAr70d8O6IrF6tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjmJaRnLrfNfSLcNd5qNGkQw+vrvg11sZIcSuSr+T+q8yMKK233UgI8W2jMZnKvgzDwlAlNbVsHVB/kum1hS1aAKKARH87klN9UErjU37LNDcLOECZwmIcXcaGE9bbD6Y5eJKVu96r70rz4ekbhGx3ifhQ4lVOL6iAeDqWiopDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGmZD0SP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7089CC4CEC3;
	Wed, 25 Sep 2024 12:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266434;
	bh=QMvbVhN2mfbI/fjEYtZiVHzEFLEkBAr70d8O6IrF6tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGmZD0SPPhAHKTcriufJZLgRTB1duxo0CKXwW2B0v8ZnR5WFZvvU9TeQ1U+cmRcFy
	 OUedIJraK+ZWhNfUcntcBP7swQnKJ7MxHJv2ecAnQRHQ+skpGkIgmNjbbRp+Z/uTwG
	 hdTM7SYJezeStm/G5YpqfgO5REAu2y9EQaxge040gtv/BH31KZDwK/R8QXx5Q7I2CU
	 MB5R07oFv6a/m/ybhtTmxAUolFml7lfb2IqPFVbZ9ogIEF9GsIWGjfuzeTCC1mgikL
	 KLdVw4oGaXvujAXGjoOpfkIdRyakGTjqv9eO9fLYrqIJxJdZ/XTlituj9kEOPzTasa
	 Z1ciVeROjbPHg==
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
	james.hershaw@corigine.com,
	johannes.berg@intel.com,
	ryno.swart@corigine.com,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 056/139] nfp: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Wed, 25 Sep 2024 08:07:56 -0400
Message-ID: <20240925121137.1307574-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index f2085340a1cfe..fceb4abea2365 100644
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



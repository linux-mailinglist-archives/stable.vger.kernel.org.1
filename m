Return-Path: <stable+bounces-118810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA15A41C7F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC3E175403
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBABC26388B;
	Mon, 24 Feb 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4EvfZ3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84898262D2A;
	Mon, 24 Feb 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395869; cv=none; b=MoY395u784OJWndQPMrS5ZFqMMy7XPvrbBIyW/YhiiX+m1WWcxY4yrYiYcvEW82WGeItryPbdyGB1GLAnB3CeJ3z1GJYDBCV8GXiQwqCDOH36DTQZRCP+mxMk5/gs1jL7zXfj2JKMvgD27ZSjqJlwuXD/AURm4B4UOfFNdADVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395869; c=relaxed/simple;
	bh=LDVGiLQYV/om9iCPbzlHs+RRDrKvhxgu/48IGJERWAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KCKRXYAU91goRl7EMYi4g0ZxOODXV+vwJqbmpSdDfsxplSXv20sli+zwRzdM0nlImI5aQN40jd7RD8VN+lOizM0zhZbPUlOMYJlQ92LPMM8I8cU2zlmimmcf+xLwSqccb+/oeqOhCEOzJ3nH2LmwzngRaLYcvQZu+E8uBgWyaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4EvfZ3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D7DC4CED6;
	Mon, 24 Feb 2025 11:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395869;
	bh=LDVGiLQYV/om9iCPbzlHs+RRDrKvhxgu/48IGJERWAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4EvfZ3iTdpzan8dwcam1q0+i0m3CGliAH7xeZW5ZVIi1Cplfs8xpfxfp6TUsHXg7
	 bAO4vnXe4Br6CbHlW74pFnFApi+DQZ/eJU1DzJzzCj14XIYX26oUNmyo7p5vIgRNIM
	 iTZKMDgKHMKGHpDlNJQSyQNSInBLkG8ivCAfaV7KP5iwoZc4Sxx/tzRPFpznv0GGW1
	 BEg0aSHKdx7bPbYeL1JmEUEEoC/9bAs2fv9pMVg2erlWkYQhqFc2Hj1rAQSn5clyUH
	 I8D7bY1gpJ6E6Vm7Zh/oXjRDYI6XAdByzIXUQnrL+ag/EYDNidBKi2M20BM1/PLR8z
	 pS0RHJwSA/MNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Neal Gompa <neal@gompa.dev>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	j@jannau.net,
	sagi@grimberg.me,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 26/32] apple-nvme: Release power domains when probe fails
Date: Mon, 24 Feb 2025 06:16:32 -0500
Message-Id: <20250224111638.2212832-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit eefa72a15ea03fd009333aaa9f0e360b2578e434 ]

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/apple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 4319ab50c10d1..0bca33dc48cc9 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1518,6 +1518,7 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 
 	return anv;
 put_dev:
+	apple_nvme_detach_genpd(anv);
 	put_device(anv->dev);
 	return ERR_PTR(ret);
 }
@@ -1551,6 +1552,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 	nvme_uninit_ctrl(&anv->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&anv->ctrl);
+	apple_nvme_detach_genpd(anv);
 	return ret;
 }
 
-- 
2.39.5



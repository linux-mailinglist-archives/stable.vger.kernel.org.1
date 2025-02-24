Return-Path: <stable+bounces-118860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD7A41D0A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227541722AF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5C226BDA4;
	Mon, 24 Feb 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bphc5cVX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896326BD8B;
	Mon, 24 Feb 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395994; cv=none; b=C5VopyquN3FM8tjWnynQ2mbBlfnWrlbNY8kHMc01mgyEu0Zv7kKJiSamEQ8B5ynatZYv7KZlqW1YBmoxWKJj+GKfd9+CO7QFpFa1TaRW86kE3jJ8EAyyop+1HT24c+w1qaKuXDl1IeL9BwHys3AzHVtVqNGXtAChJcICGQVNX90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395994; c=relaxed/simple;
	bh=f7BaXmA/i6cjvHiTSfCrSYaivOytH1GHzL/ySrXPPnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crl4Nm9BQ830c215pSCCnpppIPdQIrMeQm/8gX6q9cd3YE50r+5cYjvAvxI/m+mBo2xvrgfYajYizxg30Hzjz/3tFf73UlUhmZOsEuifwYEMEsWr5kU69px8HwGBFDMlbYahZ6QpZUB9GitB7Po0vlBIlSYz4biDqHbxXBk3W0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bphc5cVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EBBC4CEE8;
	Mon, 24 Feb 2025 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395994;
	bh=f7BaXmA/i6cjvHiTSfCrSYaivOytH1GHzL/ySrXPPnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bphc5cVXpYOotoA7rF6mTvaYimjWjtWzTqNCwQ14guVd0Rf0rv+JsCLnKIq2RlMOq
	 zfkppt4WB2IiYvecFUPWU1CILikbUt81gw4+CmRUPwV2qaGzjfGUMruEA17cx4G8ao
	 cBKDh7wydhDgmGQawmwlj/YCZsAk6SQS4heSlFI1qDOPSHk6n49jdX7TisywwawtKL
	 i/v5cpG5ADKLOv/JZS4bRryV9tbu0p3ecLk64S7zCZqxB5zkVL+VShNJRoARdjHtlN
	 JJnnR8cIFradC3cpyB8OSITx3l765PhfeBdzlzIu/f7le41K6u77J8ZAPYDy04TBg4
	 U+tCHZ4IwbVOQ==
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
Subject: [PATCH AUTOSEL 6.6 16/20] apple-nvme: Release power domains when probe fails
Date: Mon, 24 Feb 2025 06:19:09 -0500
Message-Id: <20250224111914.2214326-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111914.2214326-1-sashal@kernel.org>
References: <20250224111914.2214326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.79
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
index 396eb94376597..9b1019ee74789 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1517,6 +1517,7 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 
 	return anv;
 put_dev:
+	apple_nvme_detach_genpd(anv);
 	put_device(anv->dev);
 	return ERR_PTR(ret);
 }
@@ -1545,6 +1546,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&anv->ctrl);
 	nvme_put_ctrl(&anv->ctrl);
+	apple_nvme_detach_genpd(anv);
 	return ret;
 }
 
-- 
2.39.5



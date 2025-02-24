Return-Path: <stable+bounces-118840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A58A41CE3
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062503BD99D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229DB267B6D;
	Mon, 24 Feb 2025 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmyDgwrE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4AD25D55C;
	Mon, 24 Feb 2025 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395947; cv=none; b=eiWxjGn/JxK+rVnA9N0Wv82Gdq0+3/f+rzsp535Df69CvmBGj0q5MjU7muzJtt/NQKtlAULiypESYmHspU3WyDw7vkJxcq44eAkM4wvqxqKV5XMjdHBiVrNET7FrpF2KTMpd4AIOFQ6jK6hhLSWklckbt5SN+6EPMmRHY7Gfgzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395947; c=relaxed/simple;
	bh=G23AKcUUhcPBQNTXagmQkFOIFePG7LUUEUlJGCkB2o8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5vOa3eElpeUtgLqXR+iSIVq2x/3GWGL7mE3Kkdma6SNsW3BDwjYNOLkwx06qjaP28DniWN2APHv8Bh0mUHDfCk33LNB1jNGzLZYdi8Msf1La5eEA8ZUWxAJ1Z2AU2eK/+eCuTs/h2Q3ehU+iO8jPahG+K49XW5rwbYAHn+1q7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmyDgwrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009FAC4CEE6;
	Mon, 24 Feb 2025 11:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395947;
	bh=G23AKcUUhcPBQNTXagmQkFOIFePG7LUUEUlJGCkB2o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmyDgwrEuN3wRoi/6j8fSlveG6yK5hqsF2xtXm40I1SejK5WqtCyXUzOo/VurLChY
	 GYT7BmVXmriyrN6WiH+rBv5zH17lC4ojzrdZmNjZnkru0RflQrTpVB1N0yLKRyI0wG
	 ZdMWqBKNG57stU/7RrOPAnc6vx3bKNBE9wOyYtVWNKLVOkrJqCh/ATsZWf22D2uwDB
	 XIYKJKqSqjgsNZYVt96SkG0RtfG04HOtYu8gbrEjg/7kBEeXiuEzqS6ZDezuva2ZTF
	 Qfai7sm7AR5BZOpE1/ccinEx5p5voF4fNq7M9UB0JHMd71qjfInur4RdJf9q+2ThXw
	 NeBVQJCDxwgFA==
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
Subject: [PATCH AUTOSEL 6.12 24/28] apple-nvme: Release power domains when probe fails
Date: Mon, 24 Feb 2025 06:17:55 -0500
Message-Id: <20250224111759.2213772-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
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
index b1387dc459a32..df054cd38c3e3 100644
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



Return-Path: <stable+bounces-77558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915C8985E7D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5227E289090
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718B8211CC6;
	Wed, 25 Sep 2024 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjAvj4Bt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9931D0414;
	Wed, 25 Sep 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266328; cv=none; b=RHLxIA9YSvE3fIq1hXqdwNiLiCD5KV3ZoteAT6xKSmAN0T+KwILQOf/UWKb6I7hPsmhnGpAE/IMaakwFvNJchpBkQLNP66SX99r4wg1mXQVBPgJYLHi7fua2CmEE+fm6F/AA8ZQJcqaLrnC4uqfZJrss/x7F+mk8XNq22E8Zp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266328; c=relaxed/simple;
	bh=lsH37S0MgB6FY/D4uHQhTolxSvDmrb9eaFev9wvk1Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIRCqjD4+4dO1MahPaf6CmP95z2AJZPnkfLJszIJmN0xWmhBNcuPSppyb5E4MpUHrgmZ4sj1Zece230NeKJCYGW+VjJM9UMvo5OvxPhTIR/qra32ypl+kdtBxUWk+3leZi4GlqC/zetaUEJ5m8bhLE4rtzJ+9yDksPuEq6wm0xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjAvj4Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C13C4CEC3;
	Wed, 25 Sep 2024 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266327;
	bh=lsH37S0MgB6FY/D4uHQhTolxSvDmrb9eaFev9wvk1Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjAvj4Btv7S6AntCCD59fzvMvIBcKa5WyStQtAMBAMz+uSuwl40Iy9uQJ5JHdp1A9
	 bmX5FWC9LPmEkJEQeoQos0eyP+O8H1UMjLJViDfbxagOPVq06wgIcs++kWP4xx8Ayj
	 1B7mLzj+wtQoe7qzFInzQBaunbZTn6E4fac/GllE1V5UBb5Vq9/sRuB89/bCE/5aT1
	 56GVzgcxZSr4fDppLxjy/EyEQRzsXYCgjqsEyNm+nsfTOMPVUM3IizLXEiCAQJ/eOv
	 ZlafdyzMFJxhFONT+ETxEzsTy/rVK/OYHviHp9L5hRJkMH0fcv5+5UyThFoHFXaojm
	 XgpHeOTuzwyAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	yisen.zhuang@huawei.com,
	salil.mehta@huawei.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 012/139] net: hisilicon: hip04: fix OF node leak in probe()
Date: Wed, 25 Sep 2024 08:07:12 -0400
Message-ID: <20240925121137.1307574-12-sashal@kernel.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 17555297dbd5bccc93a01516117547e26a61caf1 ]

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20240827144421.52852-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index ecf92a5d56bbf..4b893d162e85d 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -947,6 +947,7 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	priv->tx_coalesce_timer.function = tx_done;
 
 	priv->map = syscon_node_to_regmap(arg.np);
+	of_node_put(arg.np);
 	if (IS_ERR(priv->map)) {
 		dev_warn(d, "no syscon hisilicon,hip04-ppe\n");
 		ret = PTR_ERR(priv->map);
-- 
2.43.0



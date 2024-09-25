Return-Path: <stable+bounces-77356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F02985C38
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5071F28481
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B9C1AC896;
	Wed, 25 Sep 2024 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWj/DDBn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D41AC881;
	Wed, 25 Sep 2024 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265538; cv=none; b=KndqsL/Vmfto1YBqjcQqm+ymEuI4ljXfUqdHyzfU2JAa7E9C4Vmtok6PqC9JB/iAhsh8+pBuLGUPCnf2etfiIPdGPFPlc8hIwn9WaFuwhlQ+ILEiAHebQqxU0nP2SwSdlE7JgeJRTug6NM+BJEMuZ0wCaBEfv6qHTfaVqy9X5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265538; c=relaxed/simple;
	bh=JRr0lm+DdTpwalhZmwzU8ENBTVCeWKugFb2zoapxBpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FivM9F14vNe6Sk/6WcUfzt72EEvOOMz8pZ3SZo+O8Bs3Ks6VhwshuQEGIqFzaerYTT4f0UgzDtjLzN9TGiXe8PXlu5ubaW0dhGxD5WYkWaOzpNaaSrXGVdPEJ9T8exxrQQA0ARn5j+zUGRQVZ3gpbQsawNpHKBoBqfErid1TsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWj/DDBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7007C4CEC7;
	Wed, 25 Sep 2024 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265538;
	bh=JRr0lm+DdTpwalhZmwzU8ENBTVCeWKugFb2zoapxBpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWj/DDBnBl0UhPk6Oi7H4tpBXyYgj0IAaSDFT2xad8bidNdLP2Mj+wmr0Nqu/atjL
	 VLEYw+jJMLG3FuD+B67RlmKDdqQ5TCWKw2gcgGXcJUnZtrDXdTlA6OFATLr+i7az6Q
	 axovM/VzC6PjNKQCK4uGUeZQfYlv2YWd/1oLMPB2JxjEP3D2qrX3SVlVotWbTsMkDq
	 23ecm4QLI0aRVVwlFdvAQyLG4D7YxCk1lGA3zAA2BsRUcYzErafSrFiYEHBZA37uxY
	 timzfCuUjsY3/gk4w7RDmesw3qgTiiZzZCAHu8xD5e55aPEYzF3JS0Y0ajc/Dzsslt
	 JYUQb/9Z8AANg==
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
Subject: [PATCH AUTOSEL 6.10 012/197] net: hisilicon: hip04: fix OF node leak in probe()
Date: Wed, 25 Sep 2024 07:50:31 -0400
Message-ID: <20240925115823.1303019-12-sashal@kernel.org>
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
index b91e7a06b97f7..beb815e5289b1 100644
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



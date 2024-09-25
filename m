Return-Path: <stable+bounces-77112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E0F985844
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029661C2119A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164B918B474;
	Wed, 25 Sep 2024 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTouxmUT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F818A95B;
	Wed, 25 Sep 2024 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264236; cv=none; b=uEXvFHS823B7q0wFdt/NSqp63WDQZEPIiEDVKYyuFbgbCVzzPf7W7so6Y4nPnaz1oTY/GoIYPfc6VYPB8RiZIKcF4d9DKnBtIs7LWveT/YkiGmkNoVN81DOunRpkAyELMxcgpDXVuEmcirjl/P/dQcLLkNRTwFoj6bMtSEsepHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264236; c=relaxed/simple;
	bh=JRr0lm+DdTpwalhZmwzU8ENBTVCeWKugFb2zoapxBpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nscoThGI9ebBAzip9uSNXWS8eijoWxBkJCNNe61zJIwVO1J7Gu2Q0/V3edQzJ+KG5cAb5zLRLymwg3XV0JV8PTMC2ESx8ZSOPSyHjGkDrZklOSz1XfGD+JdyNXBinXxJC3/aEsjpWx/w8DgyZdKaR6OmFjEq8aaGMAkxoSAkmG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTouxmUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B62C4CECE;
	Wed, 25 Sep 2024 11:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264236;
	bh=JRr0lm+DdTpwalhZmwzU8ENBTVCeWKugFb2zoapxBpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTouxmUT8ZWOOnzRwzUyOP1f7LCcOi4SiSA4dAtZDIAnwcP53F5h7X4gUysuc1P3Q
	 7A/sGijU9wILSJOJekrNA0gV89i2fLn3qX868sezu/SVY8cGiOg8e5qQvcFfC2Bxp/
	 D5rZrgiTQ7oaBokB9X1v/hIMBHUogSmV/2/6n3e4TpN0zrNXwBw1ZsY963zcvlfOwY
	 gu9EWZb9cbGdpaGBaJTrI/P4ufstKaPcfnwKS+Q9AGQfEUJWXlQMLYN3VSuvD3C5Hf
	 swjAh2bnyGnNngMWGpvBL9UQO6RII13IIJbfzTFgvvmknzIBiu0igNCI2VnHDjNJuS
	 7L7XS5hibVufg==
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
Subject: [PATCH AUTOSEL 6.11 014/244] net: hisilicon: hip04: fix OF node leak in probe()
Date: Wed, 25 Sep 2024 07:23:55 -0400
Message-ID: <20240925113641.1297102-14-sashal@kernel.org>
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



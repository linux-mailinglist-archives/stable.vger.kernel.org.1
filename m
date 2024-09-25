Return-Path: <stable+bounces-77560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A58985E84
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEBE1F217DD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C506C1AFB08;
	Wed, 25 Sep 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm76uEXv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F891AFB00;
	Wed, 25 Sep 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266333; cv=none; b=qb8Sf82atrX0AVGMeahooXHUMlr+h0VZTUn8b11NaEeDs0S92H/65ovUoD6fibUbwAbVWNITEU+lP48m9S2MLO/Q1JoDAQ4pfkR20/Gd/zFiG4ivlurumwqyiPvehl2WaM66o28EQW24vuRgvKmJoM4SomZWpX6ZoeYXslD30Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266333; c=relaxed/simple;
	bh=OwsTIwqeIgzaZkm0UXIF2mKZDAJQPoCDmj/fblpWDOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kf4sRsZSKuFNaQTRPh9PGRpb2BI/QVGdpnCne/okKY3AxR6BdME47A2BOTNxp42JNrg5gP8Mk8iF20XPFNWbsS6Uh8k6m6o0KBWDhrAYPR0NlHgT6OjFj95Q4M5FGlnzvjhmfRH8ikTsWPYKtN1WoYMe0r7BWEiwsQ3BgEV6f8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm76uEXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5270C4CED0;
	Wed, 25 Sep 2024 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266333;
	bh=OwsTIwqeIgzaZkm0UXIF2mKZDAJQPoCDmj/fblpWDOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hm76uEXvNl3MfUFMsu2WG6wAIx/AUKPwGgj4oF5MPsdtcZXEA5ZsI3xS37NWKw8Oe
	 wVWE7aRrAfKSF8fRrrIcgmH1lsfYOUinhba4YTZw7szP2kV0t0rC6H3K230Rc4ZTcV
	 NBNvQfbyPmu3ZRZqQqgsq4L6qvxVyJcEpJOIndeXFhGtoq4nnj17frkcenze2DkRUm
	 szhDAq7l3/Dc61lZp3Uk8yPCqpMqPAQez2osXerrE978DhjNDjOeocVy7tYDhPPcnG
	 k7kYE62unsUzEseaMSPtw1qgWGhImTd7ZZrtp82Zo+m1tCAKk3LJnCMRO6w7FqnRNw
	 egah/AN0+O8DA==
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
Subject: [PATCH AUTOSEL 6.6 014/139] net: hisilicon: hns_mdio: fix OF node leak in probe()
Date: Wed, 25 Sep 2024 08:07:14 -0400
Message-ID: <20240925121137.1307574-14-sashal@kernel.org>
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

[ Upstream commit e62beddc45f487b9969821fad3a0913d9bc18a2f ]

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20240827144421.52852-4-krzysztof.kozlowski@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 409a89d802208..9ffd479c75088 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -575,6 +575,7 @@ static int hns_mdio_probe(struct platform_device *pdev)
 						MDIO_SC_RESET_ST;
 				}
 			}
+			of_node_put(reg_args.np);
 		} else {
 			dev_warn(&pdev->dev, "find syscon ret = %#x\n", ret);
 			mdio_dev->subctrl_vbase = NULL;
-- 
2.43.0



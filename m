Return-Path: <stable+bounces-77113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52E9985846
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E140282DA1
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEE2176FCF;
	Wed, 25 Sep 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHVgG/91"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B6176FB8;
	Wed, 25 Sep 2024 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264240; cv=none; b=jedubfCLOK3f3OC38vISFdCePUjUwpa2VSmBVnB2TyoZSng9lGDAgE3PKiYZAusOE7Y6SEXIIY9EqQ9u+t2ILnXng+ewKnUAczXJudXDEHgvCqs5btf9aoXSGlAbtqrTGcGeoHmjl5RNExhfwFXSlGc0MHz4HBeIZZkLbZQ14JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264240; c=relaxed/simple;
	bh=GBAo6MwrULjwRQNw5KThPU7V3CJYVg5MOj1bngCwdMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxe8Tg0+byG5bNfslov4y5rJaNtQUoSMwocIMwn06j7Zy4vquFx33oARPnHBmHcGJPPR53CvyVkSG7XcBWf2tGdNPcFU+fkP/ZwqyJsO7gE4kQD9aohWRqmL8JklEC0xxrWkMzUT1Juz+kdYAsMKJGYS3KDfb2fbYrtviwBNIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHVgG/91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F29CC4CEC3;
	Wed, 25 Sep 2024 11:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264240;
	bh=GBAo6MwrULjwRQNw5KThPU7V3CJYVg5MOj1bngCwdMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHVgG/91ad+BMB2a8S3PFNTn8tDEo5ZG4yctBs4s5HUejomBYm9HsRsU89MLGsMQr
	 8INn/0EHM23FZIfNSCmKFogkx9popvaxx4qqXB+Wj4J1ZejjT7IQ0QSgU5euxFnwPb
	 0rX4YDkE4ViwCbKqdQWiA/ibIsE0oxT9mNWV3x/zYbmwp/5S6gWz/UXZent5IJqZmX
	 hoCwDDT3jYx5zFx51JcoiKHAbwnuHPZFgLeLg4xGClU3qM0P0sChkSOD7qQcYGpvkA
	 nP0kY+boMimorRbMxB9azIiMDYhW9cRh++2/syhj0v8//+eU22vjLwruOchWdorDrP
	 DhkuAvV55/LMQ==
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
	shaojijie@huawei.com,
	liuyonglong@huawei.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 015/244] net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
Date: Wed, 25 Sep 2024 07:23:56 -0400
Message-ID: <20240925113641.1297102-15-sashal@kernel.org>
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

[ Upstream commit 5680cf8d34e1552df987e2f4bb1bff0b2a8c8b11 ]

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in hns_mac_get_info().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20240827144421.52852-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index f75668c479351..616a2768e5048 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -933,6 +933,7 @@ static int hns_mac_get_info(struct hns_mac_cb *mac_cb)
 			mac_cb->cpld_ctrl = NULL;
 		} else {
 			syscon = syscon_node_to_regmap(cpld_args.np);
+			of_node_put(cpld_args.np);
 			if (IS_ERR_OR_NULL(syscon)) {
 				dev_dbg(mac_cb->dev, "no cpld-syscon found!\n");
 				mac_cb->cpld_ctrl = NULL;
-- 
2.43.0



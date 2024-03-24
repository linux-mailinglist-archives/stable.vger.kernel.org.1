Return-Path: <stable+bounces-30414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 071C3889075
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8441F2D5FB
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 06:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F8C29BF08;
	Sun, 24 Mar 2024 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYU/dOK+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645732308B7;
	Sun, 24 Mar 2024 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322230; cv=none; b=HAUFpja1fK2vZkvtNsyJbZuKlYi26CtyFoVD3CwQhrI37GEgzpROiwFLOwMe3EOOkSfdrcTm+Yq/PDGBMz2bzlIDGldCqYoXCl+1vjxtxD1/InfspFWVqgoAYj0siRJdNbKGK3lmdFM8XvVhncodJo+Uui+BGIilQ7gO4c7pg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322230; c=relaxed/simple;
	bh=dAQrxaCSZeCHMiNKS+UjJmKdlyaqXI9/Lqt8o/r3/Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrKXL/GNNDxVRcykkkVQLTXrTzxumgrxOZ26U35hYmmKOTvZ2B+MBF5+gf9kIvaRenk8LpB/7hW75Txvhy3TfV4rmIEV8RXv3R4qyWaGemH1JDo9f49QtqR8Zg0bjYD6MidLuoB/zZ2RZUL95kK110nxBb1vFFaE8xye4xAlUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYU/dOK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BA2C43390;
	Sun, 24 Mar 2024 23:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322230;
	bh=dAQrxaCSZeCHMiNKS+UjJmKdlyaqXI9/Lqt8o/r3/Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYU/dOK+XAwkARby5GrYiiLj64gYtIM5MtHlkHWQPUvA1BgrWAQLZBCUbD9iStj0a
	 Ip9DqTL71y/BQKSZgPQ2al8cOotFgBASmm1NekjcGyKsKKwbFHuTXMDZHvMufdgbrz
	 7pSPI7qtxBaWBBVip8WHGNMwNhvsNXeTXrQrGHBLugdX7gWn6k4wHxFjIK7DpoqTHV
	 BKxwG+I/qIYY3/U5pVSeHlP0rSqRl16XKnBu8yBDiNpnNDtSDzGdgB5zGPKwreA1Ky
	 ziA7/MeDDF8K0VoN3i17FXpx/YisPfSc3XJPH3qz3tOKCwQvXx+5LxWd4xM51LSFHN
	 mLRvvq/SjZSPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 311/451] mfd: syscon: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 19:09:47 -0400
Message-ID: <20240324231207.1351418-312-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Peter Griffin <peter.griffin@linaro.org>

[ Upstream commit d2b0680cf3b05490b579e71b0df6e07451977745 ]

of_parse_phandle() returns a device_node with refcount incremented, which
the callee needs to call of_node_put() on when done. We should only call
of_node_put() when the property argument is provided though as otherwise
nothing has taken a reference on the node.

Fixes: 45330bb43421 ("mfd: syscon: Allow property as NULL in syscon_regmap_lookup_by_phandle")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Link: https://lore.kernel.org/r/20240220115012.471689-2-peter.griffin@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/syscon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 6196724ef39bb..ecfe151220919 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -223,7 +223,9 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 		return ERR_PTR(-ENODEV);
 
 	regmap = syscon_node_to_regmap(syscon_np);
-	of_node_put(syscon_np);
+
+	if (property)
+		of_node_put(syscon_np);
 
 	return regmap;
 }
-- 
2.43.0


